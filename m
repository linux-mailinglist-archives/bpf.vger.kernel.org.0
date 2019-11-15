Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 291A3FE8A8
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2019 00:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKOXbf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Nov 2019 18:31:35 -0500
Received: from www62.your-server.de ([213.133.104.62]:56978 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfKOXbf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Nov 2019 18:31:35 -0500
Received: from sslproxy01.your-server.de ([88.198.220.130])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iVl3s-0004BD-B3; Sat, 16 Nov 2019 00:31:32 +0100
Received: from [178.197.248.45] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iVl3r-0000RJ-Rs; Sat, 16 Nov 2019 00:31:31 +0100
Subject: Re: [PATCH v4 bpf-next 2/4] bpf: add mmap() support for
 BPF_MAP_TYPE_ARRAY
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>
References: <20191115040225.2147245-1-andriin@fb.com>
 <20191115040225.2147245-3-andriin@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <888858f7-97fb-4434-4440-a5c0ec5cbac8@iogearbox.net>
Date:   Sat, 16 Nov 2019 00:31:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191115040225.2147245-3-andriin@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25634/Fri Nov 15 10:44:37 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/15/19 5:02 AM, Andrii Nakryiko wrote:
> Add ability to memory-map contents of BPF array map. This is extremely useful
> for working with BPF global data from userspace programs. It allows to avoid
> typical bpf_map_{lookup,update}_elem operations, improving both performance
> and usability.
> 
> There had to be special considerations for map freezing, to avoid having
> writable memory view into a frozen map. To solve this issue, map freezing and
> mmap-ing is happening under mutex now:
>    - if map is already frozen, no writable mapping is allowed;
>    - if map has writable memory mappings active (accounted in map->writecnt),
>      map freezing will keep failing with -EBUSY;
>    - once number of writable memory mappings drops to zero, map freezing can be
>      performed again.
> 
> Only non-per-CPU plain arrays are supported right now. Maps with spinlocks
> can't be memory mapped either.
> 
> For BPF_F_MMAPABLE array, memory allocation has to be done through vmalloc()
> to be mmap()'able. We also need to make sure that array data memory is
> page-sized and page-aligned, so we over-allocate memory in such a way that
> struct bpf_array is at the end of a single page of memory with array->value
> being aligned with the start of the second page. On deallocation we need to
> accomodate this memory arrangement to free vmalloc()'ed memory correctly.
> 
> One important consideration regarding how memory-mapping subsystem functions.
> Memory-mapping subsystem provides few optional callbacks, among them open()
> and close().  close() is called for each memory region that is unmapped, so
> that users can decrease their reference counters and free up resources, if
> necessary. open() is *almost* symmetrical: it's called for each memory region
> that is being mapped, **except** the very first one. So bpf_map_mmap does
> initial refcnt bump, while open() will do any extra ones after that. Thus
> number of close() calls is equal to number of open() calls plus one more.
> 
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Rik van Riel <riel@surriel.com>
> Acked-by: Song Liu <songliubraving@fb.com>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

[...]
> +/* called for any extra memory-mapped regions (except initial) */
> +static void bpf_map_mmap_open(struct vm_area_struct *vma)
> +{
> +	struct bpf_map *map = vma->vm_file->private_data;
> +
> +	bpf_map_inc(map);

This would also need to inc uref counter since it's technically a reference
of this map into user space as otherwise if map->ops->map_release_uref would
be used for maps supporting mmap, then the callback would trigger even if user
space still has a reference to it.

> +	if (vma->vm_flags & VM_WRITE) {
> +		mutex_lock(&map->freeze_mutex);
> +		map->writecnt++;
> +		mutex_unlock(&map->freeze_mutex);
> +	}
> +}
> +
> +/* called for all unmapped memory region (including initial) */
> +static void bpf_map_mmap_close(struct vm_area_struct *vma)
> +{
> +	struct bpf_map *map = vma->vm_file->private_data;
> +
> +	if (vma->vm_flags & VM_WRITE) {
> +		mutex_lock(&map->freeze_mutex);
> +		map->writecnt--;
> +		mutex_unlock(&map->freeze_mutex);
> +	}
> +
> +	bpf_map_put(map);

Ditto.

> +}
> +
> +static const struct vm_operations_struct bpf_map_default_vmops = {
> +	.open		= bpf_map_mmap_open,
> +	.close		= bpf_map_mmap_close,
> +};
> +
> +static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct bpf_map *map = filp->private_data;
> +	int err;
> +
> +	if (!map->ops->map_mmap || map_value_has_spin_lock(map))
> +		return -ENOTSUPP;
> +
> +	if (!(vma->vm_flags & VM_SHARED))
> +		return -EINVAL;
> +
> +	mutex_lock(&map->freeze_mutex);
> +
> +	if ((vma->vm_flags & VM_WRITE) && map->frozen) {
> +		err = -EPERM;
> +		goto out;
> +	}
> +
> +	/* set default open/close callbacks */
> +	vma->vm_ops = &bpf_map_default_vmops;
> +	vma->vm_private_data = map;
> +
> +	err = map->ops->map_mmap(map, vma);
> +	if (err)
> +		goto out;
> +
> +	bpf_map_inc(map);

Ditto.

> +	if (vma->vm_flags & VM_WRITE)
> +		map->writecnt++;
> +out:
> +	mutex_unlock(&map->freeze_mutex);
> +	return err;
> +}
> +

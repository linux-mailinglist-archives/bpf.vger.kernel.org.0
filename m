Return-Path: <bpf+bounces-45808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525809DB213
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 05:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B34281056
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 04:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149501369BB;
	Thu, 28 Nov 2024 04:15:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2979C20E6
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732767315; cv=none; b=Y58mur3OkAtr0aYp2g9xJKoU34h1K8eo57p/HFC1QbSndOFcLdysOrEzqYVaI57Rgc5lzdrGrF90vNeqzg/RN+VwpVC2rRH8TEo25CVFZB88hYc89dZw8KwPj+EJs52p/tZK6xXjxETq2stpdr4oFZX7vsHmlO6/N4kYSlsPHvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732767315; c=relaxed/simple;
	bh=XsYd7AawQTKdZsHyBLgDucmjoLfriXFIv0t+8jLu19k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=J4W5EtYJD4pZKqNar9VrLvR1CtN0HcGCc1c5YPN6hpGmhlwMyutprGavYXgccuphiMJY3O2HDur5fhsTbd5fupq1sLsUfR58bvDNcgPn5YZkmzIFZFZbFfEN5NsxTjY0XliFRRoEsY4NqhbbT2iKpn0axl5NpCu3kvfj2ywY5Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XzNHy0lFwz4f3jt6
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 12:14:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D4E311A058E
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 12:15:07 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBH8bJJ7kdn6D7jCw--.1091S2;
	Thu, 28 Nov 2024 12:15:07 +0800 (CST)
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: add fd_array_cnt attribute for
 prog_load
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org
References: <20241119101552.505650-1-aspsk@isovalent.com>
 <20241119101552.505650-4-aspsk@isovalent.com>
 <1b5f9aba-d7de-a677-0a5f-89237c8f62a4@huaweicloud.com> <Z0a/vaxyp4Gnk3TE@eis>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <fea424d2-7a5e-3653-e6f3-c656198b7a29@huaweicloud.com>
Date: Thu, 28 Nov 2024 12:15:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z0a/vaxyp4Gnk3TE@eis>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBH8bJJ7kdn6D7jCw--.1091S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyrtF1UZr48WrWkXw45GFg_yoWrJrWrpF
	WkJF1jyF4UJr17G34jq3Z8Wa12vrWrJw1Uu3sxJa4Y9r9Ivrn3Cry5Kw4j9r9Ykr48CF1I
	vF4jkrZxuF95tFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

H,

On 11/27/2024 2:44 PM, Anton Protopopov wrote:
> On 24/11/26 10:11AM, Hou Tao wrote:
>> Hi,
>>
>> On 11/19/2024 6:15 PM, Anton Protopopov wrote:
>>> The fd_array attribute of the BPF_PROG_LOAD syscall may contain a set
>>> of file descriptors: maps or btfs. This field was introduced as a
>>> sparse array. Introduce a new attribute, fd_array_cnt, which, if
>>> present, indicates that the fd_array is a continuous array of the
>>> corresponding length.
>>>
>>> If fd_array_cnt is non-zero, then every map in the fd_array will be
>>> bound to the program, as if it was used by the program. This
>>> functionality is similar to the BPF_PROG_BIND_MAP syscall, but such
>>> maps can be used by the verifier during the program load.
>>>
>>> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
>>> ---

SNIP
>>> +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
>>> +{
>>> +	struct bpf_map *map;
>>> +	CLASS(fd, f)(fd);
>>> +	int ret;
>>> +
>>> +	map = __bpf_map_get(f);
>>> +	if (!IS_ERR(map)) {
>>> +		ret = add_used_map(env, map);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +		return 0;
>>> +	}
>>> +
>>> +	if (!IS_ERR(__btf_get_by_fd(f)))
>>> +		return 0;
>> For fd_array_cnt > 0 case, does it need to handle BTF fd case ? If it
>> does, these returned BTFs should be saved in somewhere, otherewise,
>> these BTFs will be leaked.
> ATM we don't actually store BTFs here. The __btf_get_by_fd doesn't
> increase the refcnt, so no leaks.

Yes. You are right, I just mis-read the implementation of
__btf_get_by_fd().
>
>>> +	if (!fd)
>>> +		return 0;
>>> +
>>> +	verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
>>> +	return PTR_ERR(map);
>>> +}
>>> +
>>> +static int env_init_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr, bpfptr_t uattr)
>>> +{
>>> +	int size = sizeof(int) * attr->fd_array_cnt;
>>> +	int *copy;
>>> +	int ret;
>>> +	int i;
>>> +
>>> +	if (attr->fd_array_cnt >= MAX_USED_MAPS)
>>> +		return -E2BIG;
>>> +
>>> +	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
>>> +
>>> +	/*
>>> +	 * The only difference between old (no fd_array_cnt is given) and new
>>> +	 * APIs is that in the latter case the fd_array is expected to be
>>> +	 * continuous and is scanned for map fds right away
>>> +	 */
>>> +	if (!size)
>>> +		return 0;
>>> +
>>> +	copy = kzalloc(size, GFP_KERNEL);
>>> +	if (!copy)
>>> +		return -ENOMEM;
>>> +
>>> +	if (copy_from_bpfptr_offset(copy, env->fd_array, 0, size)) {
>>> +		ret = -EFAULT;
>>> +		goto free_copy;
>>> +	}
>> It is better to use kvmemdup_bpfptr() instead.
> Thanks for the hint. As suggested by Alexei, I will remove the memory
> allocation here altogether.

I see.
>
>>> +
>>> +	for (i = 0; i < attr->fd_array_cnt; i++) {
>>> +		ret = add_fd_from_fd_array(env, copy[i]);
>>> +		if (ret)
>>> +			goto free_copy;
>>> +	}
>>> +
>>> +free_copy:
>>> +	kfree(copy);
>>> +	return ret;
>>> +}
>>> +
>>>  int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
>>>  {
>>>  	u64 start_time = ktime_get_ns();
>>> @@ -22557,7 +22632,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>>>  		env->insn_aux_data[i].orig_idx = i;
>>>  	env->prog = *prog;
>>>  	env->ops = bpf_verifier_ops[env->prog->type];
>>> -	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
>>> +	ret = env_init_fd_array(env, attr, uattr);
>>> +	if (ret)
>>> +		goto err_free_aux_data;
>> These maps saved in env->used_map will also be leaked.
> Yeah, thanks, actually, env->used_map contents will be leaked (if
> error occurs here or until we get to after `goto err_unlock`), so
> I will rewrite the init/error path.

Glad to hear that。



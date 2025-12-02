Return-Path: <bpf+bounces-75851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 712ABC99A7E
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 01:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01C06345F0A
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 00:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4822E1B142D;
	Tue,  2 Dec 2025 00:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nadifQ4S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4C722097;
	Tue,  2 Dec 2025 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764635712; cv=none; b=mD4W+rU8DwjT4ujUHryW5CbqZ8UgqgrrDOUUx6C4FwylHCRIdy2LAxn/YFpYSxS2Za6NKggbAdyCpt6jpOu2oAMsMCPe2HuY/ALAnhtK7u7HGDFRbSDmdu3M7DTNMoKP2G+QPrMrmYKDBvENKgN4y+kcsSRyW2ZJCjHfIkK85mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764635712; c=relaxed/simple;
	bh=O4w7N084akAQFurfUT9nM82LZSfaroRXplwKY1DpchM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IGwI4M4n0ii160ITX9Bi24qUhTkRzHMFmtJRL0Ga2NpGKYerir/NVgyFf/NmWk4W6EfmbLbNcqJfHYNv7F9z0xeol1vl53EQ/wwPfrdaw7EDLgtXAzgHEdONp0iSN2CYKhZo9Vk3NpYNzFAo9pHoscdebhaRNNtdtbG2vg/JPI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nadifQ4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217F9C4CEF1;
	Tue,  2 Dec 2025 00:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764635712;
	bh=O4w7N084akAQFurfUT9nM82LZSfaroRXplwKY1DpchM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=nadifQ4Sg0P+3E50RqwOP/lfCwCbMPyEERMqMppOxhQWJjt+F2/8e+QO+36Ku+3g2
	 wWoEFjp8MHwumRjqUtlN0Vpwst6CS5CIb8Ys0geDqV5SJMCFDiu7qWC/MWt6NO2xj/
	 IF8FXpd7JQA5NW0l++xtlYBnVTX+jbUkWfnhry4MeJwyqO72e6ORe+WgTuXwg2BXbS
	 bNB2TVTBTbt/jI2ydUYv24l2i4IC2Ju0pwXKhhdxz5JGAFbPc79fiizAkxGex8BCAy
	 fBvUABIkAHNZOEKvq3PawEUSsTTYHs2HdElhiH80mOpYoFm6762NSPG+y2/DmEEXmo
	 TNshJiziKswTg==
Content-Type: multipart/mixed; boundary="===============3680049882100623108=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <36f21335518bc4f4046736fa044bbbbc381053c47e3a2856acc4a24e8fb90427@mail.kernel.org>
In-Reply-To: <20251202001822.2769330-1-ameryhung@gmail.com>
References: <20251202001822.2769330-1-ameryhung@gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Disallow tail call to programs that use cgroup storage
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Dec 2025 00:35:11 +0000 (UTC)

--===============3680049882100623108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 80b1765a3..fbfc45ed9 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -892,8 +892,9 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
>  				 void *key, void *value, u64 map_flags)
>  {
>  	struct bpf_array *array = container_of(map, struct bpf_array, map);
> +	u32 i, index = *(u32 *)key, ufd;
>  	void *new_ptr, *old_ptr;
> -	u32 index = *(u32 *)key, ufd;
> +	struct bpf_prog *prog;
>
>  	if (map_flags != BPF_ANY)
>  		return -EINVAL;
> @@ -906,6 +907,14 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
>  	if (IS_ERR(new_ptr))
>  		return PTR_ERR(new_ptr);
>
> +	if (map->map_type == BPF_MAP_TYPE_PROG_ARRAY) {
> +		prog = (struct bpf_prog *)new_ptr;
> +
> +		for_each_cgroup_storage_type(i)
> +			if (prog->aux->cgroup_storage[i])
> +				return -EINVAL;
                               ^^^^^^

Does this leak prog's refcount? In bpf_fd_array_map_update_elem(), the
call to map->ops->map_fd_get_ptr() acquires a reference by calling
bpf_prog_get() in prog_fd_array_get_ptr(), which increments both the
prog refcount and prog->aux->prog_array_member_cnt. When the new
validation check returns -EINVAL, the error path never calls
map->ops->map_fd_put_ptr() to release these references.

The normal path releases old_ptr at the end of the function, but the
early return here leaks new_ptr.

> +	}
> +
>  	if (map->ops->map_poke_run) {
>  		mutex_lock(&array->aux->poke_mutex);
>  		old_ptr = xchg(array->ptrs + index, new_ptr);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19842130628

--===============3680049882100623108==--


Return-Path: <bpf+bounces-75904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDADBC9C69A
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 18:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA18F4E3311
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 17:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874812C027E;
	Tue,  2 Dec 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFoARJmx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A66257AD1;
	Tue,  2 Dec 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696937; cv=none; b=cmCkcHQjciENNG+v6Zm679YnxjeTit3sP9EANYfX3ClT+x4Ezk+P3q9i6F8WRiT9NxmwGjGVpbgZ8iw0s2kkWUIWIOWL08ZU3Buzf7/npCPnQwF2pbo73WoLlhrViaydhu1mMnOlh9ZGG4xMDO35/GnuDcKGLU7NmHnsWKxbg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696937; c=relaxed/simple;
	bh=sMJyCKb0Kki65z+BAhXWZmxiCaqZb6FZukt4DZH8U3s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BQVhXF/8+nFbqu5C6R1/b4OzgbcJlPMYSE/4qFWH/CXnKL7RJG59eSLpK4fRsTJehuXeLriFdYy4g8y4PnhMYRP5lMpLeqLgbs/aGxpSjiHA64W19tK7CxooeLzoO6PvHpVEQ2xVrCLhEeX3YUexfUbm9in0K73TZbqBF6Lmavk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFoARJmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9569BC4CEF1;
	Tue,  2 Dec 2025 17:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764696936;
	bh=sMJyCKb0Kki65z+BAhXWZmxiCaqZb6FZukt4DZH8U3s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=jFoARJmxI/c5l9oTgHrmTwfj9acs0AH092KG5/6yiSCvsLVLnLPul3grZh2bq1PL5
	 wemBfLi8+bqNKua/g36qj2TJOvrxpOBJOmsTGszBRHtiCJxKr5cOwduNPQyxpzpTHh
	 Q3Lrwr7rTq69ZBGMP1LYuEPZh2rrzVuWKTcsrbS3WZPnbIx8Ds3ItvJrLKy/4iMAhf
	 iP1X8w3I4NtdhTwMkt5dowBaO3KTyn6jhJSD/R9483tGnnechELt/Fjcq33rqLza2a
	 goKwSh5hklq+8sztgykrC3E1o+TQplMFb/txU9nHvu35RFa5fTL93YJVsohUS8ddjA
	 Y2OJ0U4FaWmFg==
Content-Type: multipart/mixed; boundary="===============2761046317332136558=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b52396ff5028256639d3e9721b0976e28be6b721cec0e36cfe190e30884e189f@mail.kernel.org>
In-Reply-To: <20251202171615.1027536-1-ameryhung@gmail.com>
References: <20251202171615.1027536-1-ameryhung@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Disallow tail call to programs that use cgroup storage
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Dec 2025 17:35:35 +0000 (UTC)

--===============2761046317332136558==
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
> +	}
> +

Does this leak the program reference acquired from map_fd_get_ptr()?

In bpf_fd_array_map_update_elem(), the call to map->ops->map_fd_get_ptr()
at line 906 acquires a reference to the program. Looking at
prog_fd_array_get_ptr(), this increments both the program refcount via
bpf_prog_get() and prog->aux->prog_array_member_cnt.

When returning -EINVAL after the cgroup storage check, shouldn't the code
call map->ops->map_fd_put_ptr(map, new_ptr, true) to properly release
these resources? The normal cleanup path at the end of the function calls
map_fd_put_ptr() for old_ptr, and prog_fd_array_put_ptr() decrements
both prog_array_member_cnt and calls bpf_prog_put().

Without this cleanup, the program would have a leaked reference and an
incorrect prog_array_member_cnt value.

>  	if (map->ops->map_poke_run) {
>  		mutex_lock(&array->aux->poke_mutex);
>  		old_ptr = xchg(array->ptrs + index, new_ptr);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19867449786

--===============2761046317332136558==--


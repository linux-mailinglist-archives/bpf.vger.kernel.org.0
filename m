Return-Path: <bpf+bounces-48556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9297A09288
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 14:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C063AAED2
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6702620E714;
	Fri, 10 Jan 2025 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdhl0cdq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5DD20E6E2;
	Fri, 10 Jan 2025 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517104; cv=none; b=m3RedzL9ipMJmPnIdBFemVRMJcJHIWThZrqWI8Djpms1HlVqQSqFZQqaxmIIp/ULZBnQishWbnbtwYewEm2EP8PwsV8P7AP/1k7dJgrR1m76EkXSUDn21hwIDntcA75MI9GV5aQjliI/kDGxMGrbZG2JiHaLO5u30f8ynUBPh98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517104; c=relaxed/simple;
	bh=QvDL27F2ena82XGRVV2uV6y4O2/JfM2AlymjAELin84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EI0pOzp5S7X/A+LMiYrmBwWW0NegW8DAjfnYxlyA2ypwdHtfViO3lU7zZjCXPYfr+v+HLbhxTAVvpB+SSGbi+WKDfjbUozSaaTqSCWcvnvWiZh1VA4rhqe8mUbBvgqoIGjSr52PCYIBzm59Dw+xjoKNaTM4/OktsWlOyJ6RbmYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdhl0cdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBB0C4CED6;
	Fri, 10 Jan 2025 13:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736517103;
	bh=QvDL27F2ena82XGRVV2uV6y4O2/JfM2AlymjAELin84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdhl0cdqZcgzvjPEVfMOH9+HFpZkFFAWomCUECRP6K4GArfH5iwb6/O8iafVqaKTU
	 dv7da7MoT2/NKVt2UVbjJNEejL9VqsddVFLuCaz3jpEy2dzn6rzSTuPowk2Nc9vL5i
	 QHfDTTa6oYl+5KFrT3pMO15BG4+NoZhRcswMbZ1KoaJtsNwmBqknDAcSQgO84a8FjV
	 1+8OzYslHE+/Fo2X14c/pyCgSgDcXviVVqf/9nvKdFw79uaFDGGKr90nw3q3ORB2zU
	 qEHTYsx2XUVP64rzMqaMqhAV8B6vaJmTIuD2yta87q3yowczxqHxByOa+/uZ2nRNXT
	 9Dl9l6Fi2RQWQ==
Date: Fri, 10 Jan 2025 10:51:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
	olsajiri@gmail.com
Subject: Re: [PATCH dwarves] btf_encoder: always initialize func_state to 0
Message-ID: <Z4El7MpHaaj2YX32@x1>
References: <20250110023138.659519-1-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110023138.659519-1-ihor.solodrai@pm.me>

On Fri, Jan 10, 2025 at 02:31:41AM +0000, Ihor Solodrai wrote:
> BPF CI caught a segfault on aarch64 and s390x [1] after recent merges
> into the master branch.

In the past the libbpf github actions was tracking the tmp.master (it would
be better to track "next") branch and I was looking at when it passed to
then move "next" to master, that would be great to have so that we
wouldn't be having these bugs in the git history, avoiding force pushes.

Anyhway, thanks for the fix, I'll add it and push it out.

- Arnaldo
 
> The segfault happened at free(func_state->annots) in
> btf_encoder__delete_saved_funcs().
> 
> func_state->annots arrived there uninitialized because after patch [2]
> in some cases func_state may be allocated with a realloc, but was not
> zeroed out.
> 
> Fix this bug by always memset-ing a func_state to zero in
> btf_encoder__alloc_func_state().
> 
> [1] https://github.com/kernel-patches/bpf/actions/runs/12700574327
> [2] https://lore.kernel.org/dwarves/20250109185950.653110-11-ihor.solodrai@pm.me/
> ---
>  btf_encoder.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 78efd70..511c1ea 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1083,7 +1083,7 @@ static bool funcs__match(struct btf_encoder_func_state *s1,
>  
>  static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_encoder *encoder)
>  {
> -	struct btf_encoder_func_state *tmp;
> +	struct btf_encoder_func_state *state, *tmp;
>  
>  	if (encoder->func_states.cnt >= encoder->func_states.cap) {
>  
> @@ -1100,7 +1100,10 @@ static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_e
>  		encoder->func_states.array = tmp;
>  	}
>  
> -	return &encoder->func_states.array[encoder->func_states.cnt++];
> +	state = &encoder->func_states.array[encoder->func_states.cnt++];
> +	memset(state, 0, sizeof(*state));
> +
> +	return state;
>  }
>  
>  static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
> -- 
> 2.47.1
> 


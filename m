Return-Path: <bpf+bounces-75666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6020C90305
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 22:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A4ED4E2BBF
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 21:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B5B3126C5;
	Thu, 27 Nov 2025 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1CPzWQT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8492E173B
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764278719; cv=none; b=SmSQXbUP4WvLb7djWuv9KrqhYov9CsR3ajXZ9ja9UsUS0Uv6AY8kIU2R1mvIEt+mGrXi3ytTX89R8Y4xMl6OgPlnaC4D38l/9gac/PnjOK8zOr9R9q0bMNCG6lM5XU+TbPygKctLWf9ZPThzesCsLiM4R/G9u+YMArxWe0K7X/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764278719; c=relaxed/simple;
	bh=tzDa+yaXY+SPN8M+Q00pjsqsW5tof6SNXa4qDtuCczM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=K2c7mUGXZCq61COgMHxWQjmNlgkOFUrt8zUQGOPZGhaFnzh2gsKCn15HT51uncWw7PKFkNc2gZBYPhMkoohaEW0+I/cll4l8+CVUsUmbhozWAm+kZ7FN6n4Zj6qq+3+I9483jZY6lcfuhuwCIYm8L7zfyEftPQVSo6bJGck8rkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1CPzWQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98606C4CEF8;
	Thu, 27 Nov 2025 21:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764278718;
	bh=tzDa+yaXY+SPN8M+Q00pjsqsW5tof6SNXa4qDtuCczM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=a1CPzWQTDFDQea5JkaAccWfmR7qgdPOZ1Tgwg61fNCtO9rDJReoO5/XoEolppsLxO
	 I7R7z4VK3rkXHAkt7VdFxrSeTjYeqAfERGIQLlQpu2PCf1rrsYO+sVkaIpYc677I6n
	 MD0oGvaRyv0qDUXBfRBD6sseSJD+IAlEzAHWh4wLyJKCWGUkNFfkK0+5I6SEQMacu4
	 /vMRfBRdN7rqY5ogsqyyCfL5MSQfVDErotA//qRyfaJGRTvHDIMXLTPmB3aixVKvM0
	 4XFoqPzTXyYtVOuNXVtdkxXLF6HunMJ11K9009j+nx/pWg4IMdcwwmXTPTIJgHNspX
	 XdNxJs5qldEoA==
Content-Type: multipart/mixed; boundary="===============4889043453567614076=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <40da69b17d8be21c32270eba8f2c28c20078f03219c37288441322285a1d18d3@mail.kernel.org>
In-Reply-To: <20251127210732.3241888-1-a.s.protopopov@gmail.com>
References: <20251127210732.3241888-1-a.s.protopopov@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: check for insn arrays in check_ptr_alignment
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 27 Nov 2025 21:25:18 +0000 (UTC)

--===============4889043453567614076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 766695491..43991449f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6482,6 +6482,8 @@ static int check_ptr_alignment(struct bpf_verifier_env *env,
>  		break;
>  	case PTR_TO_MAP_VALUE:
>  		pointer_desc = "value ";
> +		if (reg->map_ptr->map_type == BPF_MAP_TYPE_INSN_ARRAY)
> +			strict = true;
>  		break;
>  	case PTR_TO_CTX:
>  		pointer_desc = "context ";
> @@ -7529,8 +7531,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  {
>  	struct bpf_reg_state *regs = cur_regs(env);
>  	struct bpf_reg_state *reg = regs + regno;
> -	bool insn_array = reg->type == PTR_TO_MAP_VALUE &&
> -			  reg->map_ptr->map_type == BPF_MAP_TYPE_INSN_ARRAY;
>  	int size, err = 0;
>
>  	size = bpf_size_to_bytes(bpf_size);
> @@ -7538,7 +7538,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  		return size;
>
>  	/* alignment checks will add in reg->off themselves */
> -	err = check_ptr_alignment(env, reg, off, size, strict_alignment_once || insn_array);
> +	err = check_ptr_alignment(env, reg, off, size, strict_alignment_once);
>  	if (err)
>  		return err;

The insn_array variable declaration was removed, but this code still
uses it at check_mem_access():7568. Does this compile?

	if (t == BPF_WRITE && insn_array) {
		verbose(env, "writes into insn_array not allowed\n");
		return -EACCES;
	}

The fix would be to check the map type directly:

	if (t == BPF_WRITE && reg->type == PTR_TO_MAP_VALUE &&
	    reg->map_ptr->map_type == BPF_MAP_TYPE_INSN_ARRAY) {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19747897022

--===============4889043453567614076==--


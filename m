Return-Path: <bpf+bounces-26856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93C78A5A01
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 20:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D941C2120C
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 18:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA73154BE5;
	Mon, 15 Apr 2024 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mQkKnyAF"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF28041C66
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206341; cv=none; b=S756CHfY9oFZxGFGHjQCSzfz94mb2j9RL/vHH65tWBhpw+dYqwmvQ7U3iLiSjmKmxzzg6dzFH+WThnBu9ORw7coARlhfBuDX85CljaftvL6P4ytDYrlDfvG6/MXLo5sPO6O+73cyTjIV7+2FKEZ6NI1xpp00X51sDAjbekY444c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206341; c=relaxed/simple;
	bh=fC3h/xef7CBQKT2b/JSVg/YFqvU7lnFCDMBN1NOKW4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ue0+YZxxw04KaQShDsYjuY1T7l1J+c/mrq/zbBUwmvmoB75RZ0FXv02534hWtYuzNpYOP10Kajreopx+jc78iXkaFcvCUcWQb4hck7TEyeIeCjEWERa3TAQMOpLk6s6gzgpsBz0vqFcbUDovRUPW33d/lPTwJUK3VLHtTp05UVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mQkKnyAF; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <154c5a8c-181c-4922-b1f8-a772b831fca3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713206336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AONWSR/ZMY5ya+3bmlZieZLEW5dFM/oNyF/dO2sHeJA=;
	b=mQkKnyAFXjAIQHJ/F3vEp5napyB+LTX1c6nwpKCYuvkye5jc//bbd8i2BRWHldlt4Ktm54
	siiCrfGcllvrIRU1U1ZSD7oZOwH79gXpahepA0VbXqTO+ILJ3QRAu8ELMn8raIQClhUUAG
	YjH+5OLeuH51GFqMBebSYAx6+luEvG0=
Date: Mon, 15 Apr 2024 11:38:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/3] bpf: relax MUL range computation check
Content-Language: en-GB
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: jose.marchesi@oracle.com, david.faust@oracle.com,
 elena.zannoni@oracle.com, alexei.starovoitov@gmail.com
References: <20240411173732.221881-1-cupertino.miranda@oracle.com>
 <20240411173732.221881-3-cupertino.miranda@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240411173732.221881-3-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/11/24 10:37 AM, Cupertino Miranda wrote:
> MUL instruction required that src_reg would be a known value (i.e.
> src_reg would be evaluate as a const value). The condition in this case
> can be relaxed, since multiplication is a commutative operator and the
> range computation is still valid if at least one of its registers is
> known.
>
> BPF self-tests were added to check the new functionality.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> ---
>   kernel/bpf/verifier.c                         | 10 +-
>   .../selftests/bpf/progs/verifier_bounds.c     | 99 +++++++++++++++++++
>   2 files changed, 105 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7894af2e1bdb..a326ec024d82 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13741,15 +13741,17 @@ static bool is_const_reg_and_valid(struct bpf_reg_state reg, bool alu32,
>   }
>   
>   static bool is_safe_to_compute_dst_reg_ranges(struct bpf_insn *insn,
> +					      struct bpf_reg_state dst_reg,
>   					      struct bpf_reg_state src_reg)
>   {
> -	bool src_known;
> +	bool src_known, dst_known;
>   	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
>   	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
>   	u8 opcode = BPF_OP(insn->code);
>   
>   	bool valid_known = true;
>   	src_known = is_const_reg_and_valid(src_reg, alu32, &valid_known);
> +	dst_known = is_const_reg_and_valid(dst_reg, alu32, &valid_known);

Is it a possible the above could falsely reject some operation since
in the original code, dst_reg is not checked here?

>   
>   	/* Taint dst register if offset had invalid bounds
>   	 * derived from e.g. dead branches.
> @@ -13765,10 +13767,10 @@ static bool is_safe_to_compute_dst_reg_ranges(struct bpf_insn *insn,
>   	case BPF_OR:
>   		return true;
>   
> -	/* Compute range for MUL if the src_reg is known.
> +	/* Compute range for MUL if at least one of its registers is know.

know => known

>   	 */
>   	case BPF_MUL:
> -		return src_known;
> +		return src_known || dst_known;
>   
>   	/* Shift operators range is only computable if shift dimension operand
>   	 * is known. Also, shifts greater than 31 or 63 are undefined. This
> @@ -13799,7 +13801,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>   	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
>   	int ret;
>   
> -	if (!is_safe_to_compute_dst_reg_ranges(insn, src_reg)) {
> +	if (!is_safe_to_compute_dst_reg_ranges(insn, *dst_reg, src_reg)) {
>   		__mark_reg_unknown(env, dst_reg);
>   		return 0;
>   	}
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c

Let us break this commit into two patches: verifier change and selftest change. This will make possible backport easier.

> index 2fcf46341b30..09bb1b270ca7 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -949,6 +949,105 @@ l1_%=:	r0 = 0;						\
>   	: __clobber_all);
>   }
>   
[...]


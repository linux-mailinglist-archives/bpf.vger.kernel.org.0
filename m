Return-Path: <bpf+bounces-78062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C2BCFC4B2
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 08:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9338E3053397
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 07:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBFB280A5C;
	Wed,  7 Jan 2026 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT+WWnlF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D41127F727;
	Wed,  7 Jan 2026 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769876; cv=none; b=LssONoBzsxeCgX2vmPxpTYKjgm5Tx+3+dGZ9sYTPCUGIabmwUeOnxXBGHWepZ3txecnjskVbfn+zZL2ddDxznhqD57lKaF8gG3soC8KtV4VhKfdt3O+Hy+991iVGYXxHeJvua4dhjzu8BW1O+SsrXdWSF8T9lB3QiK3zNPr9fNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769876; c=relaxed/simple;
	bh=ThjUFFwixEucJdlmquKYrQi9XpqKL+XjqD9Ooo5jq2k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CM5iK9nUCYTUGtbo5TYZLHJuAqrGBa9zOXwi2XJD2CR0CeKqFpcwDUeQ7Rl5aDA5tTGZrHvdCDa7JcUhuBDqo0lcw4Qlx5QcNG1/ljwI5H0s9Fja+0xUS6349CmvrQ4WMuurC2zJI13ORE7OLIyBZuAHRANlihuwRTRi1A9FQ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT+WWnlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA8CC4CEF7;
	Wed,  7 Jan 2026 07:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767769875;
	bh=ThjUFFwixEucJdlmquKYrQi9XpqKL+XjqD9Ooo5jq2k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=HT+WWnlF7G+W8P1eWx2IOhTojS0sukCzBJWBypcbfrs/Bb+MFbyKzNcUKP89VAkcl
	 uMbecnMrPWArZ5khwqGe9dR1LDPy//5hAglXOkjM/8BelykhMOxz3H27RYUClZPHMZ
	 sJOgJnMiiUFcpqLIrNJfwD7UmRrZGYu8wR4FVzjTtOCRvYCj7mIbfw6tLxSrtDSxSk
	 KMYC8e9R7tf4BZO7Q+tYlSZr5hne15/QtVPj1JdyExE6mwQMDTO2+zK3Z+2c0m2LHH
	 THxC2wp/RRMmssCwqIkDB8EMhlP6Gd7L4DVkEi/SqFqsMB0GawKW7nyU8tMsqf9dzo
	 3UYhWwVC54I5w==
Content-Type: multipart/mixed; boundary="===============5716548634928393677=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ff2e76afdc594cd27a0a08606ffdb0e36ef427dbd5ff0e64d2437a1ad36b96a2@mail.kernel.org>
In-Reply-To: <20260107064352.291069-3-dongml2@chinatelecom.cn>
References: <20260107064352.291069-3-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next v7 02/11] bpf: use last 8-bits for the nr_args in trampoline
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,dsahern@kernel.org,tglx@linutronix.de,mingo@redhat.com,jiang.biao@linux.dev,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  7 Jan 2026 07:11:14 +0000 (UTC)

--===============5716548634928393677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 6e076485bf70..6b58f9a4dc92 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

> @@ -1194,7 +1194,7 @@ const struct bpf_func_proto bpf_get_branch_snapshot_proto = {
>  BPF_CALL_3(get_func_arg, void *, ctx, u32, n, u64 *, value)
>  {
>  	/* This helper call is inlined by verifier. */
> -	u64 nr_args = ((u64 *)ctx)[-1];
> +	u64 nr_args = ((u64 *)ctx)[-1] & 0xFF;

[ ... ]

> @@ -1214,7 +1214,7 @@ static const struct bpf_func_proto bpf_get_func_arg_proto = {
>  BPF_CALL_2(get_func_ret, void *, ctx, u64 *, value)
>  {
>  	/* This helper call is inlined by verifier. */
> -	u64 nr_args = ((u64 *)ctx)[-1];
> +	u64 nr_args = ((u64 *)ctx)[-1] & 0xFF;
>
>  	*value = ((u64 *)ctx)[nr_args];
>  	return 0;

Both get_func_arg() and get_func_ret() are updated with the 0xFF mask, but
should get_func_arg_cnt() also receive the same treatment?

Current code in get_func_arg_cnt():

    BPF_CALL_1(get_func_arg_cnt, void *, ctx)
    {
        /* This helper call is inlined by verifier. */
        return ((u64 *)ctx)[-1];
    }

The comment says "inlined by verifier", but the verifier only inlines this
helper for BPF_PROG_TYPE_TRACING programs. For BPF_PROG_TYPE_LSM programs
with BPF_LSM_MAC attachment type, bpf_prog_has_trampoline() returns true,
allowing access to this helper via tracing_prog_func_proto(). However,
do_misc_fixups() only inlines for BPF_PROG_TYPE_TRACING, so LSM programs
would call this non-inlined fallback function.

If subsequent patches store metadata in the upper bits of ctx[-1], could
LSM programs calling bpf_get_func_arg_cnt() receive incorrect values?

Later commits in this series (93d4641b9513 "bpf,x86: add fsession support
for x86_64") do use the upper bits for BPF_TRAMP_M_IS_RETURN and
BPF_TRAMP_M_COOKIE flags. This regression is not fixed in the series.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20773233136

--===============5716548634928393677==--


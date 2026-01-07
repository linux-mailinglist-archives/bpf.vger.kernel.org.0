Return-Path: <bpf+bounces-78066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19279CFC735
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 08:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDE4A3018439
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 07:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9064C27FD76;
	Wed,  7 Jan 2026 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZFejok+v"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F0827280A
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767772257; cv=none; b=ocibPdhjtpnjHtQnXu1lcMU4MGff+OElyb5RXiim5CLGSLdgqMVEdn8oNq+dbrdSMJCK9eWPpT+vnb9mb5Jasit/MfKhhc0ahd87oLWitaZ9n4uqkF17gP6gX8ConllQUdgEDsi9F5rcKsOLGCj4MDIytHSjDsQWSVSe0+2ms80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767772257; c=relaxed/simple;
	bh=y8HUJrLRQO++NwRIBJ53Y93adcu1ezLkJivlswZDW9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opv1zbx/cedpXLkXKn2ttJbeGQf+fQD1p2OEi/4naS00QiLi0lxfNV+PdobCPdq1YPkImxeyQpt121+Hm/DMN+yl2h+FFJ0tipUHIVmhicz03sUKcQJqoLLWuV9ejGvsqKe+qGVb2g4TpXtJUUTpftlMXvmkjyawmt0lWKm9V78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZFejok+v; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767772242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBcsL+fiUoIToE3VZ/hvnw2izG3N1oE5gW9wTaUrisY=;
	b=ZFejok+vYFs32gaxZA/9UsyK65KByd5qpcaS/rn+goaUkfD0+ihYb+3Vsj4tuXgLDjH+db
	lbFFUhyhJbajvnWJcCMjKc5zZIAOelHXRvwLwmTa9VwpLMOZAvTHS4Qund9NZTDfIFWYpn
	e9/5aWVGzdEoHYHL0b9R9Y5R5frFbnE=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, ast@kernel.org, andrii@kernel.org,
 bot+bpf-ci@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next v7 02/11] bpf: use last 8-bits for the nr_args in
 trampoline
Date: Wed, 07 Jan 2026 15:50:16 +0800
Message-ID: <1945050.tdWV9SEqCh@7940hx>
In-Reply-To:
 <ff2e76afdc594cd27a0a08606ffdb0e36ef427dbd5ff0e64d2437a1ad36b96a2@mail.kernel.org>
References:
 <20260107064352.291069-3-dongml2@chinatelecom.cn>
 <ff2e76afdc594cd27a0a08606ffdb0e36ef427dbd5ff0e64d2437a1ad36b96a2@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/7 15:11 bot+bpf-ci@kernel.org write:
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 6e076485bf70..6b58f9a4dc92 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> 
> [ ... ]
> 
> > @@ -1194,7 +1194,7 @@ const struct bpf_func_proto bpf_get_branch_snapshot_proto = {
> >  BPF_CALL_3(get_func_arg, void *, ctx, u32, n, u64 *, value)
> >  {
> >  	/* This helper call is inlined by verifier. */
> > -	u64 nr_args = ((u64 *)ctx)[-1];
> > +	u64 nr_args = ((u64 *)ctx)[-1] & 0xFF;
> 
> [ ... ]
> 
> > @@ -1214,7 +1214,7 @@ static const struct bpf_func_proto bpf_get_func_arg_proto = {
> >  BPF_CALL_2(get_func_ret, void *, ctx, u64 *, value)
> >  {
> >  	/* This helper call is inlined by verifier. */
> > -	u64 nr_args = ((u64 *)ctx)[-1];
> > +	u64 nr_args = ((u64 *)ctx)[-1] & 0xFF;
> >
> >  	*value = ((u64 *)ctx)[nr_args];
> >  	return 0;
> 
> Both get_func_arg() and get_func_ret() are updated with the 0xFF mask, but
> should get_func_arg_cnt() also receive the same treatment?
> 
> Current code in get_func_arg_cnt():
> 
>     BPF_CALL_1(get_func_arg_cnt, void *, ctx)
>     {
>         /* This helper call is inlined by verifier. */
>         return ((u64 *)ctx)[-1];
>     }
> 
> The comment says "inlined by verifier", but the verifier only inlines this
> helper for BPF_PROG_TYPE_TRACING programs. For BPF_PROG_TYPE_LSM programs
> with BPF_LSM_MAC attachment type, bpf_prog_has_trampoline() returns true,
> allowing access to this helper via tracing_prog_func_proto(). However,
> do_misc_fixups() only inlines for BPF_PROG_TYPE_TRACING, so LSM programs
> would call this non-inlined fallback function.
> 
> If subsequent patches store metadata in the upper bits of ctx[-1], could
> LSM programs calling bpf_get_func_arg_cnt() receive incorrect values?
> 
> Later commits in this series (93d4641b9513 "bpf,x86: add fsession support
> for x86_64") do use the upper bits for BPF_TRAMP_M_IS_RETURN and
> BPF_TRAMP_M_COOKIE flags. This regression is not fixed in the series.

Ah, good point. I missed the modification of get_func_arg_cnt(). It should
be:

     BPF_CALL_1(get_func_arg_cnt, void *, ctx)
     {
         /* This helper call is inlined by verifier. */
         return ((u64 *)ctx)[-1] & 0XFF;
     }

I'll fix it in the next version.

Thanks!
Menglong Dong

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20773233136
> 






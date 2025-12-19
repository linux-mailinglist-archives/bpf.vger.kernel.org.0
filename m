Return-Path: <bpf+bounces-77153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAEECD02D8
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 14:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 146F130762E7
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 13:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18662322A29;
	Fri, 19 Dec 2025 13:57:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2342DF140;
	Fri, 19 Dec 2025 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766152621; cv=none; b=EmQ3IaRHbCvRZjXnx5AVSlieLYQtnPSQ4SmXApi6Hz0lmvr600c65FAnzu7GmRBCSUTvICYDpkc/Sqch68YbqEJV+o1fisH/f8fJ4ns2LUdcaTJXwjodr4OKX3wK2UI6/Q+ni1gi3aTmWgBGJ0OatwSK0kOuagUckwGJkqEXHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766152621; c=relaxed/simple;
	bh=zmPgpJLd9oHSjBpyh/7evpHvwtPdxPea5sW/q6DjpVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=suJhW/EsoVNrJlxZTgzCB8MUd6l/WoW6xefGOhQH0PQ5OyrfsImku3bn3IcnffsYsZgEqOr8kftH8R6H5BETzYAk3Qh1hV8k7XspIArJnC5nLXc8leOzzh3Lr+a5YnOKksNiUM6Ew2tOoCMEFGvcSLk8KsbAG4lB44c+lgYeOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by mail-out.m-online.net (Postfix) with ESMTP id 4dXpmK5LDPz1r2sG;
	Fri, 19 Dec 2025 14:49:05 +0100 (CET)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4dXpmH4HF4z1r2s6;
	Fri, 19 Dec 2025 14:49:03 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4dXpmH0zLYz1qqlW;
	Fri, 19 Dec 2025 14:49:03 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id E4ohm9qLVkoj; Fri, 19 Dec 2025 14:48:53 +0100 (CET)
X-Auth-Info: j2e6s1CXppbb5zYPxe4cgxoysHjyKAsYTE29A1lhOPRvTdV1SOD7vasi/J2u3d5m
Received: from igel.home (aftr-82-135-83-185.dynamic.mnet-online.de [82.135.83.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Fri, 19 Dec 2025 14:48:53 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 2B70F2C18F3; Fri, 19 Dec 2025 14:48:53 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Menglong Dong <menglong.dong@linux.dev>
Cc: ast@kernel.org,  Menglong Dong <menglong8.dong@gmail.com>,
  rostedt@goodmis.org,  daniel@iogearbox.net,  john.fastabend@gmail.com,
  andrii@kernel.org,  martin.lau@linux.dev,  eddyz87@gmail.com,
  song@kernel.org,  yonghong.song@linux.dev,  kpsingh@kernel.org,
  sdf@fomichev.me,  haoluo@google.com,  jolsa@kernel.org,
  mhiramat@kernel.org,  mark.rutland@arm.com,
  mathieu.desnoyers@efficios.com,  jiang.biao@linux.dev,
  bpf@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org,  linux-riscv@lists.infradead.org
Subject: Re: [PATCH bpf-next v3 3/6] bpf: fix the usage of
 BPF_TRAMP_F_SKIP_FRAME
In-Reply-To: <1948844.tdWV9SEqCh@7950hx> (Menglong Dong's message of "Fri, 19
	Dec 2025 21:31:13 +0800")
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
	<875xa2g0m0.fsf@igel.home> <5070743.31r3eYUQgx@7950hx>
	<1948844.tdWV9SEqCh@7950hx>
Date: Fri, 19 Dec 2025 14:48:53 +0100
Message-ID: <87cy4aeg56.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Dez 19 2025, Menglong Dong wrote:

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 5f9457e910e8..09b70bf362d3 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1134,7 +1134,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>  	store_args(nr_arg_slots, args_off, ctx);
>  
>  	/* skip to actual body of traced function */
> -	if (flags & BPF_TRAMP_F_ORIG_STACK)
> +	if (flags & BPF_TRAMP_F_CALL_ORIG)
>  		orig_call += RV_FENTRY_NINSNS * 4;

There are now three occurrences of that condition, and only the third
one uses orig_call.  How about merging them?

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."


Return-Path: <bpf+bounces-77157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADECCD0626
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 15:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4167D305ADD7
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0956333A019;
	Fri, 19 Dec 2025 14:50:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ACD32B981;
	Fri, 19 Dec 2025 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155837; cv=none; b=ihXmjQQAZ6miDB5ShKFkB6zY4e70/cAkzqr3owkXOolOfrnucyQQQA8U6P5FukllR7hjnM0puAWn6dH6/bioERORQjOPgSY7IAlSuVzZhzVeqv6bv04Y1mGCidRdoikhL2lE6EqqAoIDEBxKZOrG5ZiWu5bqX4YtN3Zf/mmVQFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155837; c=relaxed/simple;
	bh=ARr6JZc6yR0+Pd1cZ6MVWWgY7/3jMwr+N36cwZTonUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fD3PtkD3DrwdyRsmyKSma7AuRhy93FgbtEiXu4Ya/LoG07tVTlYrNjI6VFuGbN+XavEk6jVHamPo1vGbw6eRttqQUexpgH+XSI6i7RhFwBLCqz6x9jhJAmsSy9fdqFu8JLf96ATukp/HimqPs9YcKvqK/30/arjGkzgq7i1O8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by mail-out.m-online.net (Postfix) with ESMTP id 4dXr7C0z6Gz1r2sG;
	Fri, 19 Dec 2025 15:50:31 +0100 (CET)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4dXr772X0Bz1r2s2;
	Fri, 19 Dec 2025 15:50:27 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4dXr770FwPz1qqlW;
	Fri, 19 Dec 2025 15:50:27 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 92L-rQcDmWKo; Fri, 19 Dec 2025 15:50:15 +0100 (CET)
X-Auth-Info: 1X/yyBFQ/IZ2joL65/JDyiFRPFc9SosyZ5/1WT994dlm69mRhPapn5zjiUW2unij
Received: from igel.home (aftr-82-135-83-185.dynamic.mnet-online.de [82.135.83.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Fri, 19 Dec 2025 15:50:15 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 761962C18F3; Fri, 19 Dec 2025 15:50:15 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>,  ast@kernel.org,
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
In-Reply-To: <CADxym3Y098836fHHRSjeryxCp=CPB8sDU19TBBVs07VZOERJXw@mail.gmail.com>
	(Menglong Dong's message of "Fri, 19 Dec 2025 22:04:32 +0800")
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
	<875xa2g0m0.fsf@igel.home> <5070743.31r3eYUQgx@7950hx>
	<1948844.tdWV9SEqCh@7950hx> <87cy4aeg56.fsf@igel.home>
	<CADxym3Y098836fHHRSjeryxCp=CPB8sDU19TBBVs07VZOERJXw@mail.gmail.com>
Date: Fri, 19 Dec 2025 15:50:15 +0100
Message-ID: <878qeyedaw.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Dez 19 2025, Menglong Dong wrote:

> @@ -1171,6 +1167,8 @@ static int __arch_prepare_bpf_trampoline(struct
> bpf_tramp_image *im,
>         }
>
>         if (flags & BPF_TRAMP_F_CALL_ORIG) {
> +               /* skip to actual body of traced function */
> +               orig_call += RV_FENTRY_NINSNS * 4;

Before this line, orig_call still contains the same value as func_addr,
with the latter being dead, so there is not much point in using a copy.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."


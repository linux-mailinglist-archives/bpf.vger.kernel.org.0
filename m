Return-Path: <bpf+bounces-70065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C131BBAEB73
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 00:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C0A3C7382
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 22:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00F317B50A;
	Tue, 30 Sep 2025 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNUyFLHo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BD4298CC7
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759272806; cv=none; b=f8Z4959apOc62VzUkzJfMi18ZgGoWistDm3b/Cm8JH2Q9rGqJnsja6LFQKJ8miThCrCmBZrLkyW2HEpTJXhn+dIYakz1UOWXW0asYF2SkbRpcn2cRp3KcttiD3NelZy5ECFCoSJ5XTnflBMpwnBEhtlCrmuwqlR/QSpiPU/tcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759272806; c=relaxed/simple;
	bh=ftaJsDi1cTHdr3a6B+UCkg7tIDNZrC/w6D2aQacxCc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGcYhBCJna3iCADnVmrvIHdZsSQl1oA42lump5NQKSl7irwEO5yqiIvtp/vrGC47pevqA+l8R7IPCpYKaYuYtfeQam+1BmiIEJ77LlZmqtcrSPPWqH1b21Iaod43L+U/Spm04nrGOTCjotkfkybu5r5SosPrkrF7mwOi6HhXj+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNUyFLHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEEFC113CF
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 22:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759272805;
	bh=ftaJsDi1cTHdr3a6B+UCkg7tIDNZrC/w6D2aQacxCc0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WNUyFLHohpsl2ThU8cgH6OWAKn4k+OHoRoerLI8xW9KJThOiITa5Rmyn8haj457w0
	 sRQC8vPr0R7t1iWJCoZ8Fk6aYUZcZ1r+0KAz/ap7ti7HzNdCt6H4y1gMVlWbl/t27D
	 Pxd6+N9BHBNg5baXp0T82YObEEGt9kp/1K+EBmGfCv3ax3R8h35eaPEa7SJqeUMI0e
	 GytIMNhRI3A/aDP+7J7FLif/2R8X6udwHtACYCwULp7HvkjJdApbVDuEGNcIPIhZmC
	 BlZBVMZghqRLGCv7FBaflZXouQFn2PqROLoXhzDWHwn/hPg/l4mcQE8yx54vhuayjU
	 tnjUU9QbrmZdg==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-85cee530df9so708924985a.3
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 15:53:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoZggIKJ64NfDfirsL1xppOwJBsHrnNYJ73TXM+QGrtc+CY+CXH0sTjbNlOS+Ixd0Ub0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWtL1uwGMAaF6dPEmXpJCMsW/bheXrXcgWl1GMNlSxZpXa1mx
	rbBArwkgY8/7wPLu+8lu6Jlhcxmk2Yd5mR5tiLcSCOGE4uAW9b7/XkDhlLMygSA1LmrlLmrp2gF
	4fCm8Tsy8j1NmnXs/zW+v7QjV0mX621A=
X-Google-Smtp-Source: AGHT+IEcn44kGGuAkmfWg5LVPItA0vXao+JmpHbijNNt3uLu5DIz4+XEUDkslfIRHHrGXzU6pndt4RW8UsDh25ymIf4=
X-Received: by 2002:ad4:5b8e:0:b0:802:ef74:d792 with SMTP id
 6a1803df08f44-873a8c18ce7mr22955726d6.67.1759272805006; Tue, 30 Sep 2025
 15:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929125158.2488188-1-jolsa@kernel.org>
In-Reply-To: <20250929125158.2488188-1-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 30 Sep 2025 15:53:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4QQG0x_5XUHa6LUqG_voWUii=_8+m=YG7REGsEQVyAeg@mail.gmail.com>
X-Gm-Features: AS18NWBdMSrS7l90Zd2j6V1Kr8cgP4R-o0xIF2Nsx6RnG6WbSbxX-pYGAjbIr_U
Message-ID: <CAPhsuW4QQG0x_5XUHa6LUqG_voWUii=_8+m=YG7REGsEQVyAeg@mail.gmail.com>
Subject: Re: [RFC] Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"
To: Jiri Olsa <jolsa@kernel.org>
Cc: Song Liu <songliubraving@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 6:29=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> This reverts commit 83f44ae0f8afcc9da659799db8693f74847e66b3.
>
> hi,
> non hw events store first stack trace entry twice:
>
>         bpf_prog_2beb79c650d605dd_rawtracepoint_sched_process_exec_1+324
>         bpf_prog_2beb79c650d605dd_rawtracepoint_sched_process_exec_1+324
>         bpf_trace_run3+138
>         bprm_execve+1191
>         do_execveat_common.isra.0+404
>         __x64_sys_execve+56
>         do_syscall_64+130
>         entry_SYSCALL_64_after_hwframe+118
>
> I traced it to [1] from 2019, which stores regs->ip implicitly to fix
> raw tracepoints stacktrace. Revert does not seem to break raw tp
> stacktrace for me. Song, any idea? I know it's long time ;-)

I cannot recall the original issue.

I tried the revert with multiple different tests. Everything seems to
work fine. I guess we can ship this revert.

Thanks for the fix!
Song

Acked-by: Song Liu <song@kernel.org>


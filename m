Return-Path: <bpf+bounces-73563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A3C33C1B
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 03:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC150466153
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 02:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D4422F75E;
	Wed,  5 Nov 2025 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEVRAVwe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB122D785
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309256; cv=none; b=OKKc62xs4PUorP407oFJAcN1BqFM2Y6SrOKFMiBQZIFWMd/ScDfztjQjr9kElMuMRua961gLVHf2Yiiyr0yy9OZwSUxb3fUWNL6Yu6dzhEgny1FdxS31mG1a9uIvFix3RYvHhQRk42UKmn0PkRT/G0Kv/ZyDVdAq3lZYc62WHMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309256; c=relaxed/simple;
	bh=d6l6tVF+v3U1LUHA0g9+cdbVvSINZoTbFW1zscKaebc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfWHdKbgWjrtYDcOFVlU5zyxgp9WUrF/20ay+u2jYdtEYSRGiQ8oTjmWynKMED4FB1II6WfO7WcogIN7bOBoVB2UKCszCG31L38iv0Kr81ZgPWzjhYEmaEFDH6a8uwJ9a0NKl2Ylb0TY/4Gc6kwd462bce8N8zM4CUA4bnP7EWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEVRAVwe; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429b9b6ce96so4079514f8f.3
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 18:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762309253; x=1762914053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NuKJL9csLaw12N6dK7YM5v1m0+h0XQOxVo2kPLl2ec=;
        b=XEVRAVwe2euyQF7G/9x6EAC84nUAyuQ+fv0pr5omFTr5kLYT6cS/a0LhHc7IQ34uR2
         reDV1tESysD0vFcH+eMQUF2K5OBMcABzH049qi8ofUJkmHtipW0sG1Sumu3eXd+0walJ
         MSqdZrc1Km++KJ4NRwVNtZur31ILtxt7N/q21xmzDA58y0HsphGVM7rtr/TEgLB1CFPH
         tncbwUb48GqW3uMkYFOdgvMX/Cpij5bF2x+p00J6ywXfuOX3EZLsEhT6BapXTc6N/lsq
         NBjB5yUKLnR7rDRnCcESxKm8s8mRbufufOHQcZ7kxPaBCOqsd1cd2aeodNR+2wO2TI3Z
         bLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762309253; x=1762914053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NuKJL9csLaw12N6dK7YM5v1m0+h0XQOxVo2kPLl2ec=;
        b=Hsxw1IBe0ZItQXigUA9bSrwvimAgAhkLE5pdTdNJv/ViucuTkch8BUq5gr986YpY/O
         o9ip1h6H7Z3kDlTX49pRclOAvmbKPuuYme8djvNunbgZWZy0swTuLiEDvo38jigeKZOL
         cwfMNiopvDmZGV5cn4LqU0WYaLm/ERLYDvTCfoe70xGwsg/hvll+b2jg8bAjANKshWIA
         0ed1GW84vIucjlM9pWpHH+vk4UF/brgWc9yMAAt80rYHb0zgtjmN0oit+wXDZI6u+8Q3
         w2BdLnmlZOrUH5yEZkcykPB2rnIeOZ7/LnlwvC+1FMuZbVqJiOVO9Cb/uT3s7SLDjB3d
         wp4g==
X-Forwarded-Encrypted: i=1; AJvYcCVX/czetcpJtt9UDKC/0gvrUmpf13VwDD1I1xhshGtwvr0VVlWYKV8t4qh/Y6BAkULI5s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFKxwbAvi9rjkoIYsRqCN2oBOOl63caqutXM1EqxUL+ELDP/Cd
	ZN6dNj6ilVryjr2De1L5IjUMklSXei1P1nI8mtiDdQgH2VnDEnR1iV1Or2EB4QFv7kH0GX2rAHX
	BX4IVN9R0KGFQtA7XRfcWDRrnMY//wgCsZQ==
X-Gm-Gg: ASbGncvwOkLPeIWwLFhYQ3YwiSKN7h+Es1zF/xLXL8EUeC5/nvfAnDFi825keoe5DAe
	lEKeoG2AJuf5mqQQkKUIIsGFLgDfF746NtwuAYYZ0dqdAjzEP97Wyq/OeMbsrPu6NDKUyVxrY6d
	PoC5pDNetdi+FRvqJOGZ3naLo5Mdta4DW03/UHb2bxuKP6BIA1/kvSC5kjjaG4FiBfzzC63ZxDH
	jtT2mGbg5yki8wnfMVYGFjSYBKSeNjiupBlS1mfbmyKBnFAdw1428G0cWqMVp3eGT/pc81e6np0
	GdGOCAPFaC+4+sw3og==
X-Google-Smtp-Source: AGHT+IFrCx0K1L2HZkJ5pnD1XQUKG6I7hM1iTGY2qycDhc55Y4PzeSyl1wwsRSjMpqpwA0n8AddbO+fqahmtLQNjXj0=
X-Received: by 2002:a05:6000:2711:b0:429:8d50:8d2 with SMTP id
 ffacd0b85a97d-429e32df73bmr548726f8f.6.1762309252449; Tue, 04 Nov 2025
 18:20:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104215405.168643-1-jolsa@kernel.org>
In-Reply-To: <20251104215405.168643-1-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Nov 2025 18:20:41 -0800
X-Gm-Features: AWmQ_bmi4UR0I02UKHa0SHf9_b1Ol0r0yaOdgoZOC7E5qYdtKd4zLVKxJ9ne1zs
Message-ID: <CAADnVQJRv+2NT2TGd7nXbOtx_Cnsg=kOJuikOtL9aEdUVmwvag@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] x86/fgraph,bpf: Fix ORC stack unwind from return probe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 1:54=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> sending fix for ORC stack unwind issue reported in here [1], where
> the ORC unwinder won't go pass the return_to_handler function and
> we get no stacktrace.
>
> Sending fix for that together with unrelated stacktrace fix (patch 1),
> so the attached test can work properly.
>
> It's based on:
>   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
>   probes/for-next
>
> v1: https://lore.kernel.org/bpf/20251027131354.1984006-1-jolsa@kernel.org=
/
> v2: https://lore.kernel.org/bpf/20251103220924.36371-3-jolsa@kernel.org/
>
> v3 changes:
> - fix assert condition in test
>
> thanks,
> jirka
>
>
> [1] https://lore.kernel.org/bpf/aObSyt3qOnS_BMcy@krava/
> ---
> Jiri Olsa (4):
>       Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"
>       x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe
>       selftests/bpf: Add stacktrace ips test for kprobe_multi/kretprobe_m=
ulti
>       selftests/bpf: Add stacktrace ips test for raw_tp
>
>  arch/x86/events/core.c                                  |  10 +++----
>  arch/x86/include/asm/ftrace.h                           |   5 ++++
>  arch/x86/kernel/ftrace_64.S                             |   8 +++++-
>  include/linux/ftrace.h                                  |  10 ++++++-
>  tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c | 150 ++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  tools/testing/selftests/bpf/progs/stacktrace_ips.c      |  49 ++++++++++=
+++++++++++++++++++++
>  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c    |  26 ++++++++++=
+++++++
>  7 files changed, 251 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_ips=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/stacktrace_ips.c

Steven, Peter,

How should we route this?

If you take it into your tree, please send it to Linus right away,
so we can pull it into bpf/bpf-next trees.
The conflicts in selftests/bpf in the last merge window
were annoying. I don't want to see a repeat.


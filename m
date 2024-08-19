Return-Path: <bpf+bounces-37547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119CF95765A
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 23:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC57728395E
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 21:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED0715A848;
	Mon, 19 Aug 2024 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijGb8xPT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBA6158DCA
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724101935; cv=none; b=P5ji2jtyzpHyIvDEyIZ2AwNF2H1oF2GcBUysgEw76te286hNxckguvvGTQoTzLoXqwG8j2k9OqGBFseDcWgwuGzFHcEDz2Vmgy7PEujUXzq5pinTgQ6r93vHCmHJmu59uqO5Rl8RmQjmOLc83YYlCmkcdMf22kHQewv+FGwCNLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724101935; c=relaxed/simple;
	bh=aCipwc6hHS2qTKNWWM2zSVTnyEBGCUINr0T93AT20vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJ23v0LosiCYoUSoF0mwBjkseFK/UYCoy3E0R/6GaA6atHew1pSIFASWxBTCEtwjh4JuvSOyX3MuWHtDGd+ACOzopcrSLXADXGcJ9YY6nk45nT7xln5D11qUmJb0Yt0otccryRyk6Trs+K+y2624jeDO/KscCuPltJyPc87w1R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijGb8xPT; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3da6d3f22so3087109a91.0
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 14:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724101933; x=1724706733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6SyZQahzCC2Z0YfAPQ+WBK4RCyERGD0kZTkuxZ4h4A=;
        b=ijGb8xPT4KnYdiiWFYHhEOBXqPwuZVhGcHBmr1g/+IAweo0PLXs/P86FYfdc2uWjOV
         a4880TlKhIEfFbgA0YPBy3L7L6IcsRYhJN+O1iZTUcUHmL/1O6/6ZERFIX3PUldyIVn2
         1VBB2Tq3Mtrt67M837SqYHtH54QekQBKJJ4R7HR9C9pasMvhbfZiyxIHis/G/pJhG1tf
         Me4EGHKSq8XbvjhYQD8kx5uVoRXB8vs9GJJj17OQW2g0XMpD+roevgVgV5Nz7mi6UKxs
         4XQOurtOTuTXqUxNIyVvK/sQ3nkHtwxunhs1iAf/Yn8Lzg+A6YwlTxKpuRSk0KXwiw69
         YCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724101933; x=1724706733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6SyZQahzCC2Z0YfAPQ+WBK4RCyERGD0kZTkuxZ4h4A=;
        b=DckBT7JwjFOc5DvVgu0MQ2hq5Cz37mkVZRPFKe5ItR8AGj6Jy4C/YgANvFFkZ1ywWj
         knLnSQhN1ay1Qt3PVIBD+uD0B5OCXgAd1pVlYQLBxo9zokL6zXVqfW5YfMbCYSLaDk4/
         jAnNZh5U3PaMU0EyuoeyBu7xhTuxskHh4Df4ViptsfCPWyf1m/vsmNb/WF61Oiowm9Hq
         wuhGwSE45tJ3T0Nc4S6zPVzdsX/4XDR5Ux+6iG/040+G03jUODQ95PcmID6zSI9uuOrZ
         klia5L+ZAt7hpnc9F+MVSxAtK3/TVr3iKmLPEfFUwGfQFfKqEp53KvlXeaPNcS8+g86X
         16aw==
X-Forwarded-Encrypted: i=1; AJvYcCVo7BhR0Y3O5Kqd2KIp++ohV+Cp18pOoOXl/tJXMZaWvemqeG+o5oFGru8Xr20q8hbGg3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDpXu0WZstfxrARFYaDcDwyFsHbqHSB3zSZddyWwEek4dnF1zP
	5Ehsiuv6HPDID2vSvCbNKX9T1dkRhPsF0Mim5WxaCFln5ji4bbyeJG4m+RD6+pL/t8hL5NNZPVY
	XhqkAA82dUddoH2KnbWTejCFklMg=
X-Google-Smtp-Source: AGHT+IHTWbGqbuBiOJzZUboyrgu8R0QbUVJh0mx+pc9eAMeqSLN6s5/PIXsiL+YQfWZPNLB9lWSJGS3kSDAhsJ19FE4=
X-Received: by 2002:a17:90a:ce92:b0:2d3:cb16:c8e with SMTP id
 98e67ed59e1d1-2d3e0968531mr12066515a91.43.1724101932683; Mon, 19 Aug 2024
 14:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172398527264.293426.2050093948411376857.stgit@devnote2>
 <2b4d25f8fa99ae5a329f5164b6c79b81f1a4cc78688dcf5470d601f3612264ea@mail.kernel.org>
 <20240819095807.171eade07ba02ae871e4c4aa@kernel.org>
In-Reply-To: <20240819095807.171eade07ba02ae871e4c4aa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 19 Aug 2024 14:12:00 -0700
Message-ID: <CAEf4Bzb=j-tYBYzgv0PPMXiBAkJcswfVkxSyTd1PORwbFkMRsg@mail.gmail.com>
Subject: Re: [PATCH v13 00/20] tracing: fprobe: function_graph: Multi-function
 graph and fprobe on fgraph
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: bot+bpf-ci@kernel.org, kernel-ci@meta.com, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 5:58=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> Hi,
>
> Where can I get the test programs? I would like to check what the program=
s
> actually expected.
>

Hi Masami,

This is part of BPF selftests (so it's under
tools/testing/selftests/bpf). Specifically, this test is defined in

  - progs/kprobe_multi.c for BPF parts
  - prog_tests/kprobe_multi_testmod_test.c for user-space parts.

It seems to be failing on arm64 (but not on x86-64, so something
architecture-specific).

> On Sun, 18 Aug 2024 13:51:30 +0000 (UTC)
> bot+bpf-ci@kernel.org wrote:
>
> > Dear patch submitter,
> >
> > CI has tested the following submission:
> > Status:     FAILURE
> > Name:       [v13,00/20] tracing: fprobe: function_graph: Multi-function=
 graph and fprobe on fgraph
> > Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=
=3D880630&state=3D*
> > Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10440799=
833
> >
> > Failed jobs:
> > test_progs-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/r=
uns/10440799833/job/28911439106
> > test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/=
actions/runs/10440799833/job/28911439234
> > test_progs-s390x-gcc: https://github.com/kernel-patches/bpf/actions/run=
s/10440799833/job/28911405063
> > test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/ac=
tions/runs/10440799833/job/28911404959
> > veristat-x86_64-gcc: https://github.com/kernel-patches/bpf/actions/runs=
/10440799833/job/28911401263
> >
> > First test_progs failure (test_progs-aarch64-gcc):
> > #126 kprobe_multi_testmod_test
> > serial_test_kprobe_multi_testmod_test:PASS:load_kallsyms_local 0 nsec
> > #126/1 kprobe_multi_testmod_test/testmod_attach_api_syms
> > test_testmod_attach_api:PASS:fentry_raw_skel_load 0 nsec
> > trigger_module_test_read:PASS:testmod_file_open 0 nsec
> > test_testmod_attach_api:PASS:trigger_read 0 nsec
> > kprobe_multi_testmod_check:FAIL:kprobe_test1_result unexpected kprobe_t=
est1_result: actual 0 !=3D expected 1
> > kprobe_multi_testmod_check:FAIL:kprobe_test2_result unexpected kprobe_t=
est2_result: actual 0 !=3D expected 1
> > kprobe_multi_testmod_check:FAIL:kprobe_test3_result unexpected kprobe_t=
est3_result: actual 0 !=3D expected 1
> > kprobe_multi_testmod_check:FAIL:kretprobe_test1_result unexpected kretp=
robe_test1_result: actual 0 !=3D expected 1
> > kprobe_multi_testmod_check:FAIL:kretprobe_test2_result unexpected kretp=
robe_test2_result: actual 0 !=3D expected 1
> > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kretp=
robe_test3_result: actual 0 !=3D expected 1
> > #126/2 kprobe_multi_testmod_test/testmod_attach_api_addrs
> > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > test_testmod_attach_api:PASS:fentry_raw_skel_load 0 nsec
> > trigger_module_test_read:PASS:testmod_file_open 0 nsec
> > test_testmod_attach_api:PASS:trigger_read 0 nsec
> > kprobe_multi_testmod_check:FAIL:kprobe_test1_result unexpected kprobe_t=
est1_result: actual 0 !=3D expected 1
> > kprobe_multi_testmod_check:FAIL:kprobe_test2_result unexpected kprobe_t=
est2_result: actual 0 !=3D expected 1
> > kprobe_multi_testmod_check:FAIL:kprobe_test3_result unexpected kprobe_t=
est3_result: actual 0 !=3D expected 1
> > kprobe_multi_testmod_check:FAIL:kretprobe_test1_result unexpected kretp=
robe_test1_result: actual 0 !=3D expected 1
> > kprobe_multi_testmod_check:FAIL:kretprobe_test2_result unexpected kretp=
robe_test2_result: actual 0 !=3D expected 1
> > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kretp=
robe_test3_result: actual 0 !=3D expected 1
> >
> >
> > Please note: this email is coming from an unmonitored mailbox. If you h=
ave
> > questions or feedback, please reach out to the Meta Kernel CI team at
> > kernel-ci@meta.com.
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


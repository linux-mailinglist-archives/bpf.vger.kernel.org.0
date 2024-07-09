Return-Path: <bpf+bounces-34175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD9B92AD19
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 02:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492B31C21256
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3DD4A0A;
	Tue,  9 Jul 2024 00:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOPlcMdC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A471C2D;
	Tue,  9 Jul 2024 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720484729; cv=none; b=Sg+2KZ2mzT95exKt5g/v7D5OOham8AUvIGMO/Kt0b5XyoU/BvSIG6/lcaMPMZZPS6kEJlBPi1bhdTOQC9I08BFwEq/52NLyyQ2zd7sUxb61tTUM2KDs8BS4HjckIjmaAjmTocF/Zmo7PQvkj4d8ywU6q9lVOnq5xz18s+1DOqf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720484729; c=relaxed/simple;
	bh=/w9tbX3xljfsiXg0sOCh5xFvwzwHBerMyxEMGTbPdxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8f8nJjKv0bTxlD0nQ6ehPwhHNedCkEu1QJDPTrfE3Iz/BlsuyZbQwp8ckSuPWTAt2sICuKrXPYAm6GKh3CM+AarU1iWXCggLoqNYNH15KBx4RIyAEex0vzOAUWPCcRuyNsW4NXIDEPu342Jk+K+uXVFgDcrIPeRN2Wyz4VfNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOPlcMdC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70af81e8439so3708518b3a.0;
        Mon, 08 Jul 2024 17:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720484727; x=1721089527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S+BWUnAFai2npYo3jiP5TP26p/iKKf1Ssh+uMz9V24=;
        b=IOPlcMdC5dNvAYPwDsnnIIwYXH8dmNnH6D5TQf46sZ3D6K/kOgTveIW78BUVDdLMzl
         zbFlyVtXvdxTeg3WYrEmbNdm8WZDpyJcAnXJpTT7IECl+RiRsMkJ1IYW+0FQlE4TZe+I
         i/OKdFk4OpBIVG6XKtjgiKKboIw2S6ouPDdNgxSfdLCJIm3Y8XpImAm5cTsD/u/1WKD9
         tJrf+2ze3PTy64kl3UAyAh43cSKN2o72TkpcMZjRzA2xKjcKrL9U9nGC8nDtb4yS5pgq
         NPFAHDc6T3BBV0yYmciGzu4P/MqM/A7ch/edKHl2f+iettpbkd42zWhkD8djV+bUnoKn
         u90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720484727; x=1721089527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1S+BWUnAFai2npYo3jiP5TP26p/iKKf1Ssh+uMz9V24=;
        b=Uuk/u+WjIVO+4VbqbbTVV/zQi3Aim5Qq9u43x31F13rlOPBdnqf2k3jgS9ozlrRtao
         hNnBM8c/aUl2KeCKgUxt2GiES5D5s38E/+Pp/ulfBMi89VMdVXB5LavtTxGR0M/AvCVr
         2p3FrlfauEhu3HNjvsqqY3OzFSHK+QnMaHsLaOINWV0WX1018dzO0qlpJM5I9UtosoWN
         U5bmlBZRCFMlyRhPqYi95dGCU7Vy9tPBdkP6pkoIvoyQ7mf3g6gKMjA/wusX0fSJ7JA6
         6EuiplfGsRwKrQohoF86NUs+eGabixRfH1FOM/qp3BLTXfwMx0IjaYsXj5NkGI7Zekd9
         /Hlg==
X-Forwarded-Encrypted: i=1; AJvYcCVDzpU/e+OsOiZ/zlcsbTTkm7o5s6on1xOZ7HPI+kSZRzXMfgAcMdJRQLCQXGwsgv2FNVbqLEIIXLUhYop7LaVjWQloDVK+sgRmoExn+bdrCSZuwiUesKiVfpGaC0isSQtt
X-Gm-Message-State: AOJu0YyRWriPwzfgczc1r+2FFEftSBC98xBJUCym5Li5za2SdSd65U91
	h6CiHat7LSyPGO3hk3be64XRFz4NYN2hM+9oVDP21ZL/QdziGVAq1jkw3XL067ZfEQTdrYdZ29U
	6oEM21wb0MpXdaWucmW2mtHSUspw=
X-Google-Smtp-Source: AGHT+IFFcbTqw48GIuHul+dRzjWWo1YZrwwJPPawo9H3fjGF/xWVeOusidpaVx1DgJUy0eqnbcPCDOfyDKWygfn/CQE=
X-Received: by 2002:a05:6a00:10d5:b0:706:a931:20da with SMTP id
 d2e1a72fcca58-70b434f6439mr1472457b3a.3.1720484726890; Mon, 08 Jul 2024
 17:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708091241.544262971@infradead.org> <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
In-Reply-To: <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 17:25:14 -0700
Message-ID: <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org, 
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org, clm@meta.com, 
	paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:56=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Mon, 08 Jul 2024 11:12:41 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > Hi!
> >
> > These patches implement the (S)RCU based proposal to optimize uprobes.
> >
> > On my c^Htrusty old IVB-EP -- where each (of the 40) CPU calls 'func' i=
n a
> > tight loop:
> >
> >   perf probe -x ./uprobes test=3Dfunc
> >   perf stat -ae probe_uprobe:test  -- sleep 1
> >
> >   perf probe -x ./uprobes test=3Dfunc%return
> >   perf stat -ae probe_uprobe:test__return -- sleep 1
> >
> > PRE:
> >
> >   4,038,804      probe_uprobe:test
> >   2,356,275      probe_uprobe:test__return
> >
> > POST:
> >
> >   7,216,579      probe_uprobe:test
> >   6,744,786      probe_uprobe:test__return
> >
>
> Good results! So this is another series of Andrii's batch register?
> (but maybe it becomes simpler)

yes, this would be an alternative to my patches


Peter,

I didn't have time to look at the patches just yet, but I managed to
run a quick benchmark (using bench tool we have as part of BPF
selftests) to see both single-threaded performance and how the
performance scales with CPUs (now that we are not bottlenecked on
register_rwsem). Here are some results:

[root@kerneltest003.10.atn6 ~]# for num_threads in {1..20}; do ./bench \
-a -d10 -p $num_threads trig-uprobe-nop | grep Summary; done
Summary: hits    3.278 =C2=B1 0.021M/s (  3.278M/prod)
Summary: hits    4.364 =C2=B1 0.005M/s (  2.182M/prod)
Summary: hits    6.517 =C2=B1 0.011M/s (  2.172M/prod)
Summary: hits    8.203 =C2=B1 0.004M/s (  2.051M/prod)
Summary: hits    9.520 =C2=B1 0.012M/s (  1.904M/prod)
Summary: hits    8.316 =C2=B1 0.007M/s (  1.386M/prod)
Summary: hits    7.893 =C2=B1 0.037M/s (  1.128M/prod)
Summary: hits    8.490 =C2=B1 0.014M/s (  1.061M/prod)
Summary: hits    8.022 =C2=B1 0.005M/s (  0.891M/prod)
Summary: hits    8.471 =C2=B1 0.019M/s (  0.847M/prod)
Summary: hits    8.156 =C2=B1 0.021M/s (  0.741M/prod)
...


(numbers in the first column is total throughput, and xxx/prod is
per-thread throughput). Single-threaded performance (about 3.3 mln/s)
is on part with what I had with my patches. And clearly it scales
better with more thread now that register_rwsem is gone, though,
unfortunately, it doesn't really scale linearly.

Quick profiling for the 8-threaded benchmark shows that we spend >20%
in mmap_read_lock/mmap_read_unlock in find_active_uprobe. I think
that's what would prevent uprobes from scaling linearly. If you have
some good ideas on how to get rid of that, I think it would be
extremely beneficial. We also spend about 14% of the time in
srcu_read_lock(). The rest is in interrupt handling overhead, actual
user-space function overhead, and in uprobe_dispatcher() calls.

Ramping this up to 16 threads shows that mmap_rwsem is getting more
costly, up to 45% of CPU. SRCU is also growing a bit slower to 19% of
CPU. Is this expected? (I'm not familiar with the implementation
details)

P.S. Would you be able to rebase your patches on top of latest
probes/for-next, which include Jiri's sys_uretprobe changes. Right now
uretprobe benchmarks are quite unrepresentative because of that.
Thanks!


>
> Thank you,
>
> >
> > Patches also available here:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/u=
probes
> >
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


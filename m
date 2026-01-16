Return-Path: <bpf+bounces-79343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF4CD38927
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 23:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC2C2304BB77
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 22:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A69B31195A;
	Fri, 16 Jan 2026 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl6fwD5X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5236D2D8DA6
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602048; cv=pass; b=OfhcQa6EFUecCxzaW1tQJd3qyZcF55zyNuMGKaOSQslQLReyMRRmFohrYXY68jsrz9kOkQZfzKF5pJ5OIhrQZIyqc0yPh3H85V5Xfi/ZzJYlUdR07IxCara8eDh8wxOFhnhpxcUpKbxs1MHYntZG9ikIi3tOFr95+Yt5MW4OO7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602048; c=relaxed/simple;
	bh=o5En9a8wP5By67GXNTiNQjIPnUWaBuLHMV9zVL0xjhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chEwJbHmkT1okyAj6shs50yBLUAEpCWXmp8kZsUnZ3IXrUG4xKdMG85deVkWsuiZ8RfI5wUiw4TYIUHSTIw1GqJMQ3mWoQbjXWOHncPbjRJgFqJvzd+iYelSTmbB1SfV9IOuDPen1sDyQnhM8j5ctE0sCmpl78kDZm4v+30D+Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jl6fwD5X; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a07fac8aa1so17923785ad.1
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:20:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768602047; cv=none;
        d=google.com; s=arc-20240605;
        b=MHofemP0DqBarFUZqaRD60kT/LuNtxKi6dKxo9PrfcVqA2AePWp4H8qPt3Q2BBptsm
         icX5tE1e/S7Gq9etJy7RLOT3M7807EQS0AoJvikyo9JLg2YhgeHV7LFJBqpnmaY7mfy4
         737S5ln4uqGZNCeW+nO9H8ErdUVDWZ1LqAjNmT8VZt1vsMH2Z1r+nuo4A4SXWsW9V3PO
         S9pEUvHuUNgGyWl1Y+hae7lb+RfafPEsWFUasFfFidJe5uvDe1nq/sHAiz2kTeSrR7fF
         WGBk/n51vNtnInpqPd8/0wxqVh3fLnOTjijWSfxXH5HuUwhcQueRxspTbH5LJ0fj+/ui
         9rbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o5En9a8wP5By67GXNTiNQjIPnUWaBuLHMV9zVL0xjhM=;
        fh=4abOVxnohxhQ0fQveMdkk/H4wbC+/wKs01OxgiJQ1BA=;
        b=P9/1GLOP4oia9SAf2Ymqj1JSirgQ2oiac1oktWzGyIBFTXUGW3BYU/a1W72TzOZ83V
         JTtTeL8hxHfXYtAx7R4dosPLx6jXEkeDdLPOjumycIprM4e3lv4+byZBNU7exSR2s/C/
         BK4bytGb/TBN/5OROTYrxExbKsW7k5ji2Jo9U6Qs82JgeNKJcLOrm65laBbF5G+rKasl
         59LUEuqSeE2R9Gc3WDI2h5ctiWCtWA8n0tupHZH5vsz5D8K/wweDkWi6zL6vPvwJOiu9
         wAnEqhKy9tM241QG6wPSkAbDcGwApfJ6tfE8TvXUFCowJm/pE/AKLgvDqkAQ9GnZX1Xp
         ei3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602047; x=1769206847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5En9a8wP5By67GXNTiNQjIPnUWaBuLHMV9zVL0xjhM=;
        b=jl6fwD5XuK8nNz0w8naADUnEY83g5YEz8a/AJMTNwsu+p/9darZgynRx3h0TTCIPkU
         fQx5WKc/uQ9iHsZ2qE0eLzF4K6sHagBAuuYCAaJ4bPvgacdNyLKMwj7FuUh+UvvebEsB
         ujlvGefiQ16jpeIIsompuWkHE7czowuBkO+1XE8cmmFURBz1Jmhw+8ifaVXBzAMXjIEt
         svjgdadT9xkGnr25ipuogSTgwFcAdgyPf0ucI3nyrMQmpbNDj/BqDdZMj6YZDAXsxRWU
         9lgtgKxFEtEY9PBkgyhT3AHgvXFp3hrVdvONvtAw4w9uPXrpQQrNyYu6CTevJhN9i459
         5UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602047; x=1769206847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o5En9a8wP5By67GXNTiNQjIPnUWaBuLHMV9zVL0xjhM=;
        b=h65SEI5N5XH1RO+26/akgZqN1dwRN4EVh/MCUc0l1A9fD3m7k7Z2eh3IjBaGFZISjG
         oZPABPylgEwYdLTrKlbBFP0WUW4aAOS/cJ6ZE3+7cE/KBEFlaxqWlCNOp/um9zn59pkx
         zvpc+u4AMsq/N21aaO9kBEarU6CGATwBp94plwdBI7Dws1/FPK2DQCJByhjK35OXzHyt
         wAaAJXUcbmqVBCgww1DhbgnuWceXwzEZuLJH8946RjT94WVOQn0HlLirforPISRYI8tP
         s0+CerInSA8gisxcK63qYY6A85ouc5+envMA43oVwGiJIEpxCZTOBPL5b8AHafSSDz7l
         Gxcw==
X-Forwarded-Encrypted: i=1; AJvYcCXL5NueGBUR+6xoR49v/W6/rMvrFTlEjeeYwhyeKKC0++FmZPGCphC6cP54eEgmTDjlXeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3fB3/67faoFlNY6pROeGcQ795nshlAkwRwSiqy8+30pE19Up8
	cnqjtJkjP3w8t88OeWV8gnQTtBY7L/pB0xGDCx+UNrFsQ/qloU4m7yNaD8EXwl+Ze1W0T2vFVBx
	zrI0bn8BZvnAK290Cdqgn+G5wOwJC35g=
X-Gm-Gg: AY/fxX7fFb+t3dmhZt1hTCVLE0oirfIhnY2ws+TZGWpbGuloGuHxR80FlR148D7O5eJ
	Xs9zZFyi7HE1237S5z5t8Aptc9SGRszEXtPvrp7R0OIfmtr5CygtV953wADZnr2E/PyoTJOxyOi
	LXOx0QBFlVBlTYTcTkQz97Y703f2YW0O19zUe50QyvIxjfknchwUetRUWQylQImuGDKl/hFslr4
	SzPQ4w2+cWA9hQwTo+P1T6LATHv/kzohqKrOB03zZ4UhYUtIcE18DqqO2w3B8gI/BHux07/e6nG
	r4u7bX5uYXDwlPpE8hg1Rg==
X-Received: by 2002:a17:903:3888:b0:295:c2e7:7199 with SMTP id
 d9443c01a7336-2a7175a63fdmr36859055ad.29.1768602046673; Fri, 16 Jan 2026
 14:20:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com>
 <CAEf4BzYvZsjSpsDHXAuZ9G3=r4e27+c_LDpSUampw-fTfKA2=g@mail.gmail.com> <DFPUQZ5PNXKA.12KADC78HCRQ5@bootlin.com>
In-Reply-To: <DFPUQZ5PNXKA.12KADC78HCRQ5@bootlin.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jan 2026 14:20:33 -0800
X-Gm-Features: AZwV_Qj7HA8GkrLxttMYt-BAKc2j92CUeTQrxpfNtW9oL8TZwLQvAQc9j6gMlZ8
Message-ID: <CAEf4BzbT-7iRezzNRQPvQpRDA3BmkesCSijT4mPXuWb2ua=9ag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: add a new runner for bpftool tests
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 11:57=E2=80=AFPM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> Hi Andrii,
>
> On Thu Jan 15, 2026 at 6:58 PM CET, Andrii Nakryiko wrote:
> > On Wed, Jan 14, 2026 at 12:59=E2=80=AFAM Alexis Lothor=C3=A9 (eBPF Foun=
dation)
> > <alexis.lothore@bootlin.com> wrote:
> >>
> >> Hello,
> >> this series is part of the larger effort aiming to convert all
> >> standalone tests to the CI runners so that they are properly executed =
on
> >> patches submission.
> >>
> >> Some of those tests are validating bpftool behavior(test_bpftool_map.s=
h,
> >> test_bpftool_metadata.sh, test_bpftool_synctypes.py, test_bpftool.py..=
.)
> >> and so they do not integrate well in test_progs. This series proposes =
to
> >
> > Can you elaborate why they do not integrate well? In my mind,
> > test_progs should be the only runner into which we invest effort
> > (parallel tests, all the different filtering, etc; why would we have
> > to reimplement subsets of this). The fact that we have test_maps and
> > test_verifier is historical and if we had enough time we'd merge all
> > of them into test_progs.
> >
> > What exactly in test_progs would prevent us from implementing bpftool
> > test runner?
>
> I don't think there is any strong technical blocker preventing from
> integrating those tests directly into test_progs. That's rather about
> the fact that test_progs tests depends (almost) exclusively on
> libbpf/skeletons. Those bpftool tests rather need to directly execute

There are actually plenty of test in test_progs that do networking
setups, calling system() to launch various binaries, etc. So it never
was purely for libbpf/skeletons/whatnot.

So yeah, I think bpftool testing should still be implemented as one
(or many) test_progs tests (and maybe subtests), utilizing
test_progs's generic multi-process testing setup, filtering,
reporting, etc infrastructure. No need to add extra runners.

> bpftool and parse its stdout output, so I thought that it made sense to
> have a dedicated runner for this. If I'm wrong and so if those tests
> should rather be moved in the test_progs runner (eg to avoid duplicating
> the runner features), I'm fine with it. Any additional opinion on this
> is welcome.
>
> Thanks,
>
> Alexis
> --
> Alexis Lothor=C3=A9, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>


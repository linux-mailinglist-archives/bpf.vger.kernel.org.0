Return-Path: <bpf+bounces-59889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F66AD070F
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5103B2B96
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E092289E29;
	Fri,  6 Jun 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD8mVj3Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301AF2882B6
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229076; cv=none; b=Vfq6vquIhjVxylHIxx1brLZVYE+ChZJp7/zk1MXreN3ms3yfb1sRslA3RDxMIs1UhNt1mPo2EzrvT3u8rgEkC03tl2ON2u/jLGsbXZIHVJvUgtXuQLo2JaBT+CLUyMUx42n4YmhaGTUEEcoVtSUDLI/xpgnzIMGZVed+VLvLvhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229076; c=relaxed/simple;
	bh=SlXqxge8owU6P2xwr/IVFY+7KYg8Y+OqlqbBXt+chbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOnmygA5Lq52/sEkwo0SPd3SQwj67Icks+Ouc1tZ33xWLhnwqPBXX+KUfJs4yvwPTE6sZ2qi9Fow1ky5FaP/GGOJC30pU7ZYtF9cqcqmZEYozM3c6BK4en6BJANaKeARCu117nj5MoZs2RnXGIR/sO3Z83Y60mqv3Na/WDzqaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD8mVj3Q; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b1fd59851baso1311855a12.0
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749229074; x=1749833874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMirHgklVZBoyFHnM0CPcsjfCIHjd+q8nqkjwrSjDiQ=;
        b=kD8mVj3QLFZ4E4VpUIpA2a2HxBvRT4w63fURMOqKdhPyphAvkvHNnRTbivWPSmf8Ax
         m/JUesZ/BaB8ukl5aprBl4LOGXEd/BG0ATrnx02VVPd8E/XIX5y+tQJCkavCkHZFqpfh
         AicE7sUv7ZWNkp8dvbvka7LkOMOjVtZtYU5+SmesoOMqhIpwCBWm//m1TLv0b99BE3jn
         Ko1LepAduasv5ClpjoNFWBltPjc/yoyiRNLaBHuOlAdv3AyXEyu+WG/NDYWt3L2g7e40
         JEQ8XsffVUHEQJuD4k8qGi2f3z9HF+XrYcxXYywPV9vdPW9K7q3to0A7pMnvOH9S7z8Y
         3Hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749229074; x=1749833874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMirHgklVZBoyFHnM0CPcsjfCIHjd+q8nqkjwrSjDiQ=;
        b=g0VOcxlsET9/5+uhbnWIrbXeyj5ItE5tvlEA/h/YYFM6f2MCzqgs+9Rbx/CcR3dm2p
         SgQtDiV8ojWRO8D259mLXEghzX1xdFX07gc9nF6TeRmTu/DtbER5nv+OudCNkNS8A9CI
         vWyKTz5XJ2CQl32aq9QFe6EoHuoTCNanuQDq5M7+LgjuqIHS2KQCGZ1eGjQ3zVeaiI+L
         d0fWSXRaLFU4SIlXy/c5AYoOnRNtP34KjaLFylPU9dLHgWSWnYsjh3t0m3XzvBrxv2Nf
         NjxMOKnyQTUlAaSufWxUmZjKxh+da6AXSJEMSM1yLMNtWvKWmLJylbGxNofe+LpXM86J
         kZHg==
X-Forwarded-Encrypted: i=1; AJvYcCW+RZvcXBWmGI+GyXInv//0J3JYhxvIuBdGY4Oz1pOXfXlauIpfJvOfUUnSKttQurUSXSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvO/euvgpklE9qwhrqf/AX2kHSBad8UblLvv67yFRXbFvpnEUM
	qZuS0J58YfuTQ11E/uXhZ84ZYRuUC6gn3mb0vha4fhyDbj6KbI20QYp0Uall8AoqWLJgkpQ5AgU
	7kFSly7gT77ssp6XIzPCWPHGsSxRgIG0=
X-Gm-Gg: ASbGncs7vmIzsXURr8MHk6cI48TcM3cqiTK9HZJ5rR2A4LtigblSLq5hi89Yjh86MXG
	PIn0gkTGj/Os6p++KWAyq2F9UExmMv80lroZMkD25oW2uRIIfiK0GivPaFpohj7F8qg1rY5/YBB
	GPhVBRTAlCdFWI9/y4C/UyPBHE3ruInm4=
X-Google-Smtp-Source: AGHT+IHvE6Eew7mvjhvNAkd3O4B1zORonVA7tBtzB3aHvWL6LL5Cnh2Fnzn7HwebOSS/BWeATnK00CXUGyvf0FgwiaE=
X-Received: by 2002:a17:90a:c10e:b0:311:abba:53c9 with SMTP id
 98e67ed59e1d1-31346af9a80mr6717073a91.7.1749229074403; Fri, 06 Jun 2025
 09:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606032309.444401-1-yonghong.song@linux.dev>
 <CAEf4Bzb+rPo6bfYe71vOzAsqQb4JM6Gu-Hi66qPj0ioF=PFF9g@mail.gmail.com>
 <8ff0934e-3073-4535-9ec1-f9ee1379ff4e@linux.dev> <9e9d08a4-6e27-4cab-959d-e730cacd75f4@linux.dev>
In-Reply-To: <9e9d08a4-6e27-4cab-959d-e730cacd75f4@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Jun 2025 09:57:42 -0700
X-Gm-Features: AX0GCFvrgizLYaREx5AtOBwV8BnQbWpLEY8hz67tDYAYcfVVZkRGZxhEayo3GVs
Message-ID: <CAEf4BzYDkYiJdBJyPv4P_3jYJg8JegkvDOYWTam-vBgDQHOQtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: Fix a few test failures with
 arm64 64KB page
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 9:49=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 6/6/25 9:43 AM, Yonghong Song wrote:
> >
> >
> > On 6/6/25 9:30 AM, Andrii Nakryiko wrote:
> >> On Thu, Jun 5, 2025 at 8:23=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev>
> >> wrote:
> >>> My local arm64 host has 64KB page size and the VM to run test_progs
> >>> also has 64KB page size. There are a few self tests assuming 4KB page
> >>> and hence failed in my envorinment. Patch 1 tries to reduce long asse=
rt
> >> typo: environment
> >>
> >>> logs when tail failed. Patches 2-4 fixed three selftest failures.
> >> How come our BPF CI doesn't catch this on aarch64?.. Ihor, any thought=
s?
> >
> > In CI for aarch64, the page size is 4KB. For example, for this link:
> >
> > https://github.com/kernel-patches/bpf/actions/runs/15482212552/
> > job/43590176563?pr=3D9053
> >
> > Find the kconfig, and we have
> >
> >    CONFIG_ARM64_4K_PAGES=3Dy
> >    # CONFIG_ARM64_16K_PAGES is not set
> >    # CONFIG_ARM64_64K_PAGES is not set
> >
> > and for 4K page, all these tests are fine, but not for 64K page.
>
> Ah right, I just realized the host pagesize doesn't matter, the kernel
> we are running tests against needs to be re-compiled with the right
> config.
>
> If this is important to test on CI, it can be another matrix dimension
> with customized kconfig. Do we want to do that?
>

Can we just use 64KB page size for aarch64 (no 4KB variant for arm64)?
>
> >
> >
> >>
> >>> Yonghong Song (4):
> >>>    selftests/bpf: Reduce test_xdp_adjust_frags_tail_grow logs
> >>>    selftests/bpf: Fix bpf_mod_race test failure with arm64 64KB page
> >>> size
> >>>    selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm64 6=
4KB
> >>>      page size
> >>>    selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page siz=
e
> >>>
> >>>   .../selftests/bpf/prog_tests/bpf_mod_race.c    |  2 +-
> >>>   .../testing/selftests/bpf/prog_tests/ringbuf.c |  5 +++--
> >>>   .../selftests/bpf/prog_tests/user_ringbuf.c    |  6 ++++--
> >>>   .../selftests/bpf/prog_tests/xdp_adjust_tail.c | 18 ++++++++++++---=
---
> >>>   .../selftests/bpf/progs/test_ringbuf_write.c   |  5 +++--
> >>>   5 files changed, 23 insertions(+), 13 deletions(-)
> >>>
> >>> --
> >>> 2.47.1
> >>>
> >
>


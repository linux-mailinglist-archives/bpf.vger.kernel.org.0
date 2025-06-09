Return-Path: <bpf+bounces-60098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0E4AD28E4
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1ABF16EB5E
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 21:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E8C223DF0;
	Mon,  9 Jun 2025 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2989Kv/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A01F21CC57;
	Mon,  9 Jun 2025 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749505400; cv=none; b=VsUajvGNceN5hp69r3gzMbBeuxlpqLLxXBaVMhfZ9WKwDOOw/7KEgQJ5yFW1W05eOIwydPKDZSSwom7PlcTaAtW8oDeiZogWyTTQp1wQ62QinLurO3JuVz1AaoPPKpFnWgugR/ToOPFGTMx2epLUdAVPOZPva3CuHoXIYR2dcyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749505400; c=relaxed/simple;
	bh=PuHRRK5nR68ZmPfAM84f/AEo59f/9Rd1jmVg+Ph380k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BW1DihmAhJ6QuMxrEYzt2WVd4YZPhwEMcal8lREUFuQRkyCkGqO0IpdUCC4TBuz/GWUAImXZqAhhUAn/Jsyquy3PubX3a5kbh/NRq8PvW56d6OnPMtMKWWcX4S1fjr1e0SJwxtf/JjWNibuk5TT3ZRVoHsY/bg/JQHEGLhai6L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2989Kv/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso3454715a91.2;
        Mon, 09 Jun 2025 14:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749505398; x=1750110198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuHRRK5nR68ZmPfAM84f/AEo59f/9Rd1jmVg+Ph380k=;
        b=M2989Kv/G8w5W07Y0iTjthEqlN9mGDYHUMCZbDr6rr/Yt6BqR/n1hDqllCZ0uOiI9C
         QCZgaIjk4VtgU7JIXsochZo5D+dJFOp0OMnX13zg/CIWh19V/AoxG8GSDGkZLK8MT3c4
         d4whKU8FivIdoIwKB6yEz2nYkj2Ch0KmT72+JQzagnDDUGvRAb+5+0dFa5r8LskU5x9A
         MHsPUH1P3+J9jIT/EOxisHBTgc4W09iBGg/KAV+dR0Y8matAzDDg+7+ZuLFNFJSl0TEa
         xuvcQ+KUgs5IlW1fkvJ7IjkMxsNC9c1sv4S9yq6NI2zuy+AQHXsIY+9bTOtOY6kkEta0
         SYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749505398; x=1750110198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuHRRK5nR68ZmPfAM84f/AEo59f/9Rd1jmVg+Ph380k=;
        b=hUIjNPolAQ2Fj0Am2BkkUp7mp2FH+dOuLTxo91y5iUIlQPBol6K30NgBNzjPpcgX0b
         JZS4vtA260PvXmnq/3BE4H6OzhMbgc8JAMMFi+oVzyW0PhhM6Q3xMq0kEKpPxJ14iOJc
         I51HrjWgB5HIiMsHx/WS31J7KffFIMNx2aCzGc+qZaQR4EV27NMoGTJFJwk/ofB7tKLT
         yuRH9f5PnA/lhZr9gNNkjckqlvJ9tL3wjkk9G2eZccsWUcmtLmpZHwiDg6ihvTUvyxNa
         ipUHyfueRXl2b3EB9eByPi5EBnLqxm0Qb6zXPa9e+82KExH7Qc22P/Z/YVVmViFFeJjk
         lkGw==
X-Forwarded-Encrypted: i=1; AJvYcCUMdr2+SzekZC6BWZRTWSElXVuGLWDzeH9ILhh2qwxA9Fgz2Hck+mXxKlrM52zNT1twdLR7MvldQLje9jA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrsi9Hx4j44YLhvrq1zOOqz8dIOVuyS5PJqfQ14h2ECDOXXJhx
	7dQnFxQuSrNbY/x6pxyaKpDTzrGS7TDWxdfW6Lb7AGCrCCWdhooNGdMrR9EdQewKb4GzYvhAzR5
	UqdISZij/8QjnaR/KrU8W39i0k2yiE2A=
X-Gm-Gg: ASbGncuFzNFEwKVGQXja/vVKRlMrJniAzIaoPZQsR9Qh4qZLwRsOCOIYbJn8V//AuPZ
	rCmSOEMVRfMIG12XlraIR48CfZNRd5S1Memg9IoIlrvdoGqHJ+wH47GCsuAXB/aBSbwP8QfMDXE
	4UcdBFPShZAHVv0c7UwssbJgoNHOUZhsnkR82uucO27uGIE6d2eYMN3eO5WDU=
X-Google-Smtp-Source: AGHT+IEIcw8DdH2pOvZ/+yMOY5JH3rp1EcAnesMVBSgMj4IkQ75VjwtKflhIXdUhYZqL/LI2n5OnAEAEV4HZL5z+rX4=
X-Received: by 2002:a17:90b:4a0f:b0:312:1b53:5ea8 with SMTP id
 98e67ed59e1d1-313a16e8e49mr100651a91.24.1749505397926; Mon, 09 Jun 2025
 14:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c17b2e6c-3626-4d69-8784-01b13a9e2851@linux.dev>
In-Reply-To: <c17b2e6c-3626-4d69-8784-01b13a9e2851@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Jun 2025 14:43:05 -0700
X-Gm-Features: AX0GCFtrTBo4dhOgLuZj_Jm3wvz-z55kAuzr8C2ijb1P6f9tJl3IEeOnyygHaeA
Message-ID: <CAEf4BzbWZrg1Aq1p0c2h-s2Ro=Fm2Dk1uE7frFynOd3CwZqFZA@mail.gmail.com>
Subject: Re: BPF CI update: veristat-scx job
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	Kernel Team <kernel-team@meta.com>, kernel-ci@meta.com, 
	Alexei Starovoitov <ast@kernel.org>, tj@kernel.org, mkutsevol@meta.com, scottbpc@meta.com, 
	jakehillion@meta.com, mykolal@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 2:30=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> Hi everyone.
>
> In effort to improve testing of both BPF subsystem and sched-ext
> project [1], a new testing workflow has been added to BPF CI:
> veristat-scx.
>
> veristat-kernel and veristat-meta jobs have been running for a while
> now, and veristat-scx is basically adding more test cases using
> sched-ext BPF programs as input.
>
> For those who aren't aware, veristat [2] is a command line tool that
> can be used to load BPF object files into the kernel and check
> verification results, among other things. It's source code is at
> ./tools/testing/selftests/bpf/veristat.c
>
> On BPF CI, veristat-${target} job takes BPF object files (determined
> by ${target}) as input, and runs veristat on them against the kernel
> under testing. In addition to checking whether BPF program is accepted
> by the verifier, the CI job also collects verifier performance stats,
> and compares them to the baseline *failing* if a significant
> regression is detected.
>
> See an example of successful job run here:
> https://github.com/kernel-patches/bpf/actions/runs/15543439297/job/437616=
85117

Unsuccessful veristat runs are actually more interesting :) Do you
have a link to some examples with veristat failures?

>
> [1] https://github.com/sched-ext/scx
> [2] https://github.com/libbpf/veristat
>


Return-Path: <bpf+bounces-23173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7F586E7F9
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 19:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF5A1C2337F
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA101BF2A;
	Fri,  1 Mar 2024 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRfI/WgZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907D91798F
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316507; cv=none; b=Iza5dYi/0CJsoxqX5g6K2QQzbCVQPxhBuDpeXSHQ5FNOHxHzlygrS5EBiYJcyJTzLITdtG7HHso8gloIYYB12BANiPwWbWXPk3jFgBfqEOhwNS15+YYKclISyCA9EGYenu12k4T4bScQif6mMh05M8VCukmIXjazTYv/bl8xAlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316507; c=relaxed/simple;
	bh=kv2Rw/4PABtZMMkC6GMZk6j9JQ/OwXbgylVMTHXtQvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSVWZgB0sL1qZcyvDbvqzMN3EDfinLiKLmYC4hfM0h7lfTBn2kZJPhJuqhq90s4ORMEFhlee40geUOBfaR1istleGi27PuZy8zetzRcFkN0iNPQwj7fdEEajQl+ENLisY+23BRzdDdX9xhJJXYXFhlJ5bXqLFNRxsL9AhlWsLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRfI/WgZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e56a5b2812so1615249b3a.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 10:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709316504; x=1709921304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+AMEW6hmD1iL12X67fjF+zZkj7/mNvpy6OcTY70dAA=;
        b=DRfI/WgZIlDE1oT8HnEQlvZEx2P7Q8obrxtuUBmUI2FXMbUtpScEcXlPuo/h/2U1ff
         zPfc1qh/zBIUrp+FmMqBLcXhSJtlYPoN1hN+KKc8Q2b9qZHcD9E8rRjTvsvtng7Ehq7D
         IF6Rr2+hx6qSzkFZWVTGFNQHRs9nMIKu74PtpZ+sf6ASiza34u5O0m5rcBFpcI1HVlT4
         FeXAYMdWCKWv6iOYZhHElfJOfkkcXqU6v2przd7G6yG20LE7vedQpsaVXEEH3clP+jBC
         CyPDWiOBWos1/V46X8nmISH/zyquZRiSGmRzhgeuf3D/QRGB/+5Eo+7txKooru2BixZH
         UBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709316504; x=1709921304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+AMEW6hmD1iL12X67fjF+zZkj7/mNvpy6OcTY70dAA=;
        b=YVuyca8Rqtb5s9gc3/uVamIyZ/d767R5CKKb6ordqQKB+p2h3C6HQCoPlptBbHsOLZ
         jtxXynUZHhX3jDfOGX8NmkUF0sadcZY9qD2qd42xt1pDtnE0sra6pn8gWkmupdgRHMh9
         0vvfjtc9xlvwmFoJWbQXll75jfbnV5fJWHrkj/9wpWyN/9p9/ho/qQ3tkwV3ACG7ykUG
         nZgO2EhyBN/f23J4B15heX/5d/3jxf8aQNccLvDZICOg/xklyuobVW9+LHbgd78r+P/Z
         K1dD6vQjXgoiNpuCtAcWDsCYOn4vYdRkckLlmBk7D2212FNVL3xZZaeHOtL1DU9pzZgR
         p9/A==
X-Forwarded-Encrypted: i=1; AJvYcCXoxOgCONPGPQWYv0Pbxd8XT0/esN6eQ2cixmtj+Z/7uH8yjAykpjIRbO3rEj/6amjpEg590keQYGYbZeF3PU9xAh1k
X-Gm-Message-State: AOJu0Yx1DeKMyhNsPfKKNH0X7x182vaahBKwHY+OYzHzsPEA3WmeUzTn
	BtDsoipw6VLr0pTmXoO9DHm+boa/zSkGIpnStSZrmQ+n/XiZJd4a3humY2fL7bSO/ETi+qecPDT
	om813nrXkPVZf+2Al5QM6fqp0Qzk=
X-Google-Smtp-Source: AGHT+IEd45s3mMKXlHOml34P80IMVOalcAuS9N/hfjmPilJz0df22VgmXWfOfpdFcLPZMmWSYiQtbAP39xpiy59O3OU=
X-Received: by 2002:a05:6a20:8418:b0:1a1:15ff:43b with SMTP id
 c24-20020a056a20841800b001a115ff043bmr2660027pzd.23.1709316503364; Fri, 01
 Mar 2024 10:08:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeCXHKJ--iYYbmLj@krava> <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
 <ZeGPU8FRqwNuUJwd@krava> <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
 <CAEf4Bzbv5_yG8S4c22QUXp1FhLZGSSRZS6FFjXfvo=4RdAThZA@mail.gmail.com>
In-Reply-To: <CAEf4Bzbv5_yG8S4c22QUXp1FhLZGSSRZS6FFjXfvo=4RdAThZA@mail.gmail.com>
From: Yunwei 123 <yunwei356@gmail.com>
Date: Fri, 1 Mar 2024 18:08:09 +0000
Message-ID: <CAEnnukZTNs1oOGXhPRCNi_1KWkbc4XBsHDBvP4Cq9J73jD81ww@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Oleg Nesterov <oleg@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

I did some basic experiment on bpftime, which combined user space
trampoline in bpftime with a bpf_prog_test_run syscall to run eBPF
code in kernel. In my laptop, it was about 2-3x faster than original
trap based Uprobe.

The experiment code was in
https://github.com/eunomia-bpf/bpftime/blob/71f13ae80e93e8ff45e1b0320c25ff1=
4cb25b4ba/runtime/src/bpftime_prog.cpp#L113

(That's just a poc, not kernel patches)


On Fri, Mar 1, 2024 at 5:27=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 1, 2024 at 9:01=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Mar 1, 2024 at 12:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Thu, Feb 29, 2024 at 04:25:17PM -0800, Andrii Nakryiko wrote:
> > > > On Thu, Feb 29, 2024 at 6:39=E2=80=AFAM Jiri Olsa <olsajiri@gmail.c=
om> wrote:
> > > > >
> > > > > One of uprobe pain points is having slow execution that involves
> > > > > two traps in worst case scenario or single trap if the original
> > > > > instruction can be emulated. For return uprobes there's one extra
> > > > > trap on top of that.
> > > > >
> > > > > My current idea on how to make this faster is to follow the optim=
ized
> > > > > kprobes and replace the normal uprobe trap instruction with jump =
to
> > > > > user space trampoline that:
> > > > >
> > > > >   - executes syscall to call uprobe consumers callbacks
> > > >
> > > > Did you get a chance to measure relative performance of syscall vs
> > > > int3 interrupt handling? If not, do you think you'll be able to get
> > > > some numbers by the time the conference starts? This should inform =
the
> > > > decision whether it even makes sense to go through all the trouble.
> > >
> > > right, will do that
> >
> > I believe Yusheng measured syscall vs uprobe performance
> > difference during LPC. iirc it was something like 3x.
>
> Do you have a link to slides? Was it actual uprobe vs just some fast
> syscall (not doing BPF program execution) comparison? Or comparing the
> performance of int3 handling vs equivalent syscall handling.
>
> I suspect it's the former, and so probably not that representative.
> I'm curious about the performance of going
> userspace->kernel->userspace through int3 vs syscall (all other things
> being equal).
>
> > Certainly necessary to have a benchmark.
> > selftests/bpf/bench has one for uprobe.
> > Probably should extend with sys_bpf.
> >
> > Regarding:
> > > replace the normal uprobe trap instruction with jump to
> > user space trampoline
> >
> > it should probably be a call to trampoline instead of a jump.
> > Unless you plan to generate a different trampoline for every location ?
> >
> > Also how would you pick a space for a trampoline in the target process =
?
> > Analyze /proc/pid/maps and look for gaps in executable sections?
>
> kernel already does that for uretprobes, it adds a new "[uprobes]"
> memory mapping, so this part is already implemented
>
> >
> > We can start simple with a USDT that uses nop5 instead of nop1
> > and explicit single trampoline for all USDT locations
> > that saves all (callee and caller saved) registers and
> > then does sys_bpf with a new cmd.
> >
> > To replace nop5 with a call to trampoline we can use text_poke_bp
> > approach: replace 1st byte with int3, replace 2-5 with target addr,
> > replace 1st byte to make an actual call insn.
> >
> > Once patched there will be no simulation of insns or kernel traps.
> > Just normal user code that calls into trampoline, that calls sys_bpf,
> > and returns back.


Return-Path: <bpf+bounces-34704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A41989301BA
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 23:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FC5283C99
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 21:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A880848CFC;
	Fri, 12 Jul 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgjdkx8s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7BBA2E
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720820883; cv=none; b=loa6OxvTtMSmWjaELQrzff1GSdhscsGMUGm80bas0lKD2wvlqztyXt7bFNxtHAmMOpW4vQ/OkYAq4XJxRyLgDrVeqylIFqx6b2XOtf4UdiPMe5bDe7v549wE/fOKHyZoC4Xwr4F4N6iRbGv0tSyQPzzHDIM0fwsjfgnjv4xFSZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720820883; c=relaxed/simple;
	bh=I9D0BvplbT4P6ZfSmM/FKtB7oBRDO/sdPmA3DRCcj1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ss7t4XE8hT6g8vr6c9KvaCwpLWLqTX8LV3g7E67efdyS4XzoQgWI5nE7eyg37xDMHxUQo96nl5ETdctKLNlP2v2JQjKrisOUrQ8Qlnef79trs3lwgxXhn4AZKEF+L75joF9uhfSE5NPESSv8JqNPIf/Md6f3aOveYZuDTpP6UXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dgjdkx8s; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c96f037145so2022041a91.3
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 14:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720820881; x=1721425681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td9ZGLQhyPuzLNhNdKd7pq/GQqQ6iw6s90gO8rL/6Kg=;
        b=Dgjdkx8s6KyHyAKH4bRJC6NpxZWK13Vwlekpl4jV6dqRNOK8QYhgsjseQiOOZQFPCQ
         Tsb+k33PV0e97ZaXixWDwMuPfmd3tZKmZ6LyoqpD4WYQVat2MgfUubhhvRrufXOqPwIz
         SRHzdyzE5o72PmzbLGgVtcfeV+7ej3Hbg+rIsO5+i45ryQyck3V6MKWKpFsWm0LXJKdF
         SdFMi4BAji6RjEye1XDcrw+MrZcS7snHFrCIymAdAKSyw0nqFFUARqXHPbeMSum8EVdc
         YJbJAayLh+lMDF4EoTzQGvEqT415pv5HgtkTi+bufDfpC9rPaZC0n31M4MIs9JvbwsKJ
         hnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720820881; x=1721425681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=td9ZGLQhyPuzLNhNdKd7pq/GQqQ6iw6s90gO8rL/6Kg=;
        b=vuYi1u9Lwm7RdzONEKmhmLEH2936tHlzRzkeABlSEf94oU3vSzddO0OlHYe4x4T/qT
         MhCERGLMN69cwkkyX18o/6LnYPaMrlDGo/OcKcaEnWGsjZOEvIE5yf4R6EYwN9/EC8s2
         gdht+5Mwsgvi/jpfHqIpOZSCVbIfkk15/KBkMrdCi4yLIDY+ugekzuNqyQLYz4KbZKDY
         GOV8yZjZDoQOT4h20lWmKrY9oeJM+V7zc9vg3uNC5LH2D8+/34pHkNkTFoBUTs1MX294
         PrpmEBOt8DOg+sQm6aoHfQzp1BrjTLTQgsqfgz+XLRSGGJ7TPwnhVYaXzntF99pKqWen
         H3eg==
X-Forwarded-Encrypted: i=1; AJvYcCVLK6QVSkkgaxM55IdFFwHN5Xqq+v85Tim/Oe9NNgg9jvj1BsO/c8mzb+TypRW8bG0Hb0KguYn3u4OhD8P3mwH7ITZL
X-Gm-Message-State: AOJu0YwFJWMBewR0X5Q2nQ+duQn7eTFAE7bPq1yiJREQ5PiTyKNJ1kfO
	9ze4ojiDmdTxIAezDtcjGQfr4Y/FmvspZwhrNjH8RgAY5C0PBrIbO5QGc0H+om/1b3CF6m2c8qT
	3LAy/nv1McbEHXbZgL7zqYaqECDk=
X-Google-Smtp-Source: AGHT+IEXW5NOfZOvJ/hrDIDFKsB6AHPdrjS9YXeq3Q+6DNcMrMB728+O587BXxTh/MjgGvGAf6mJMLEkVflSCSRdPbA=
X-Received: by 2002:a17:90a:d34d:b0:2c8:df15:5ad7 with SMTP id
 98e67ed59e1d1-2ca35d58ab4mr9576924a91.45.1720820881078; Fri, 12 Jul 2024
 14:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711164204.1657880-1-yonghong.song@linux.dev>
 <20240711164209.1658101-1-yonghong.song@linux.dev> <CAADnVQKnWJM7mGqpHn4wy25+VJuh9KGGK9tf75qgC2Zk8+ojBA@mail.gmail.com>
 <d57143f9-de6c-49e8-af34-848ad9f19838@linux.dev>
In-Reply-To: <d57143f9-de6c-49e8-af34-848ad9f19838@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 Jul 2024 14:47:49 -0700
Message-ID: <CAEf4Bzao0X9Pwg4D40P8cO_42ZQabMnYs2zHZNgO36hR45VnGA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/2] [no_merge] selftests/bpf: Benchmark
 runtime performance with private stack
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 1:48=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 7/12/24 1:16 PM, Alexei Starovoitov wrote:
> > On Thu, Jul 11, 2024 at 9:42=E2=80=AFAM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>
> >> It is clear that the main overhead is the push/pop r9 for
> >> three calls.
> >>
> >> Five runs of the benchmarks:
> >>
> >> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
> >> no-private-stack:    0.662 =C2=B1 0.019M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> private-stack:       0.673 =C2=B1 0.017M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
> >> no-private-stack:    0.684 =C2=B1 0.005M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> private-stack:       0.676 =C2=B1 0.008M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
> >> no-private-stack:    0.673 =C2=B1 0.017M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> private-stack:       0.683 =C2=B1 0.006M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
> >> no-private-stack:    0.680 =C2=B1 0.011M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> private-stack:       0.626 =C2=B1 0.050M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
> >> no-private-stack:    0.686 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >> private-stack:       0.683 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/=
s)
> >>
> >> The performance is very similar between private-stack and no-private-s=
tack.
> > I'm not so sure.
> > What is the "perf report" before/after?
> > Are you sure that bench spends enough time inside the program itself?
> > By the look of it it seems that most of the time will be in hashmap
> > and syscall overhead.
> >
> > You need that batch's one that uses for loop and attached to a helper.
> > See commit 7df4e597ea2c ("selftests/bpf: add batched, mostly in-kernel
> > BPF triggering benchmarks")
>
> Okay, I see. The current approach is one trigger, one prog run where
> each prog run exercise 3 syscalls. I should add a loop to the bpf
> program to make bpf program spends majority of time. Will do this
> in the next revision, plus running 'perf report'.

please also benchmark on real hardware, VM will not give reliable results

>
> >
> > I think the next version doesn't need RFC tag. patch 1 lgtm.
>


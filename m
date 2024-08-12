Return-Path: <bpf+bounces-36923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5463B94F622
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C1BB2206D
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDBA18953D;
	Mon, 12 Aug 2024 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3CKDdq7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC0D13A24D;
	Mon, 12 Aug 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485438; cv=none; b=DkimOSU7YZRm92nxzt10MICBT7/+qV0GWuRD3ON2PreLFlp40KMM/3npxrn46M816Of4tX9g+kOgyweGG/kl9qjx4Y1Xy3E+PvrLBAqANET7EL1JlxXmPYnPF39iKia8X9l/jjN2TDhSyH1A8NUssHIlUvVSaxtRSmWcDII7e4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485438; c=relaxed/simple;
	bh=BSSIelT9b3lNDXNhVTXlTATdVA/AKFX98mMP/WgRPCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjLVnw/hSi/xnPtL5tCIXVF3xWqbYnPAMPNyFgPnHcrnYkqslNV4/1hXelGWWUSeoj75EW0cBXBvM4gvcjKTsF1zA9rrXsdjsfTog9NsUF4n0Hfpi7ygBSeoE1camacW5Vho+rvAcY5R1HOa0iGSCL27JZOJYHgSHjsPWf5iLdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3CKDdq7; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c3e1081804so980210a12.3;
        Mon, 12 Aug 2024 10:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723485436; x=1724090236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzMBVT5Buj7QKeGM9sscOvVq0ggegn0Fv1hQ4+00Cfo=;
        b=d3CKDdq73we+r8SMMFIK9q2UMkACoH3eOyiOTxPF67gAHAnqis1gNSBxNDfVN2zKPc
         LYVwmB5kCNgLV3fitz2+liSaF2wDJaCyIC6mV3zqNENqPt9ggSU0/ZPP77zK5avQJy72
         gs6/bFnaIwqLXonB5oSinRp19Hln9RXyQE7fb1HSJLGnu0xgv628KQL+giD/XyPqSiRL
         ugccv83/ieKkryRuxhXbMllVcmNM7pnRHQ63O9kWLRgt7l28ov2yb8boI26BQfHsQre7
         PUzNhB6R0mkqaiRDTQ83wK9YlNOhXOJwZ1HfsTyy2LHUjJ2IMHnWFNnlSB8zacbEu1lx
         kQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723485436; x=1724090236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzMBVT5Buj7QKeGM9sscOvVq0ggegn0Fv1hQ4+00Cfo=;
        b=DDS3HZLO38QQ7aMGiLR0wxnIy6K/vKExDW/HGSM32tcQlWOiGqJO/Lp5MnNA57fx3T
         Af7Ra/zSykX+Oz10VdZa/iU7yrdSauZOlic3URdAbCW294L0A9B1cmcb2aBpN1ilUOgA
         CfeecG8e/4rM9mrtKnMtyV2dp84h7f16IPu9icfBfL4qFVNI4ygrHiBR++lthcqrOaaK
         tf11EUMBOR+F9WkYMfGv77DfyIGzFDwtVvIL+NRB2BZElJG6Dva2p7/yKeI97841MMKc
         JFbA+XDlagxB2MH/88sXMt1vMuDzPaGwyi04Xwf4D7QJboAwJFub2RL8DML8jUhT/yhJ
         I+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXzKgeEk5hfcpD9AYqUbx4DVC+WpPm3a3KIyHOb394uM9z1h7fSNdIUHzkSRs5hhbwjzfG7twgNrots+g4AlkHLsP+g+9P0aLeEkULCNWC6v9sf6zC+AAgdu6Y1GJ74EnxuefPBa2+MtuzZ/1kOa1c4mjFwZ7zEHmDb4pSIN6cl40NlyT/ve+rWR5dcWJld5jsapzLuPXZPHMp3/dhjhK02n3f8VjxSFA==
X-Gm-Message-State: AOJu0YwRkP4gHoPx5U3YPKV7GNfB77m/626Ts8MdBUMRJI6xHwlFVQXQ
	h20Jr0BD9xwM2A3tqWAMqUXpRv8cJGjUcwHygJv6HxWPs+K0L9zcq5V36rUiBOKoXXypbThD0Cs
	e7Wn0PJLePzt7HTfsuNQkPXZ+zICWaxJf
X-Google-Smtp-Source: AGHT+IEWaYU5TsSpZLF5Bkdw/GK/BBXBLxCLFfdL4qcFIBnZ8hPnO9Rx+YBlm8RCzsDmaVwoTkdtAdtlP5m6paJiMC4=
X-Received: by 2002:a17:90a:cce:b0:2d1:b36c:6bc1 with SMTP id
 98e67ed59e1d1-2d3924cba8emr1091937a91.2.1723485436373; Mon, 12 Aug 2024
 10:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727094405.1362496-1-liaochang1@huawei.com>
 <7eefae59-8cd1-14a5-ef62-fc0e62b26831@huawei.com> <CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com>
 <a22d6d79-fa7e-62b2-0ac1-575068f176a5@huawei.com> <CAEf4BzbN-+p0cDnHQPDwhVaqs-r-_Ft-LdUwY2KHG1xfrmyjBQ@mail.gmail.com>
 <CAEf4BzZyCd7ECbWQyEpcB4va_U33v8BdfWVY4cMH4zN-Z1sESw@mail.gmail.com> <5a110f15-024f-d693-e04f-7892fc8d7757@huawei.com>
In-Reply-To: <5a110f15-024f-d693-e04f-7892fc8d7757@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Aug 2024 10:57:03 -0700
Message-ID: <CAEf4BzaGPB+AybJNhzD+4rT6ioLuhjp4sW3uG0ST4sCtqSjx1A@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Optimize the allocation of insn_slot for performance
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, 
	"oleg@redhat.com >> Oleg Nesterov" <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 5:05=E2=80=AFAM Liao, Chang <liaochang1@huawei.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/8/10 2:40, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Fri, Aug 9, 2024 at 11:34=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Fri, Aug 9, 2024 at 12:16=E2=80=AFAM Liao, Chang <liaochang1@huawei=
.com> wrote:
> >>>
> >>>
> >>>
> >>> =E5=9C=A8 2024/8/9 2:26, Andrii Nakryiko =E5=86=99=E9=81=93:
> >>>> On Thu, Aug 8, 2024 at 1:45=E2=80=AFAM Liao, Chang <liaochang1@huawe=
i.com> wrote:
> >>>>>
> >>>>> Hi Andrii and Oleg.
> >>>>>
> >>>>> This patch sent by me two weeks ago also aim to optimize the perfor=
mance of uprobe
> >>>>> on arm64. I notice recent discussions on the performance and scalab=
ility of uprobes
> >>>>> within the mailing list. Considering this interest, I've added you =
and other relevant
> >>>>> maintainers to the CC list for broader visibility and potential col=
laboration.
> >>>>>
> >>>>
> >>>> Hi Liao,
> >>>>
> >>>> As you can see there is an active work to improve uprobes, that
> >>>> changes lifetime management of uprobes, removes a bunch of locks tak=
en
> >>>> in the uprobe/uretprobe hot path, etc. It would be nice if you can
> >>>> hold off a bit with your changes until all that lands. And then
> >>>> re-benchmark, as costs might shift.
> >>>
> >>> Andrii, I'm trying to integrate your lockless changes into the upstre=
am
> >>> next-20240806 kernel tree. And I ran into some conflicts. please let =
me
> >>> know which kernel you're currently working on.
> >>>
> >>
> >> My patches are  based on tip/perf/core. But I also just pushed all the
> >> changes I have accumulated (including patches I haven't sent for
> >> review just yet), plus your patches for sighand lock removed applied
> >> on top into [0]. So you can take a look and use that as a base for
> >> now. Keep in mind, a bunch of those patches might still change, but
> >> this should give you the best currently achievable performance with
> >> uprobes/uretprobes. E.g., I'm getting something like below on x86-64
> >> (note somewhat linear scalability with number of CPU cores, with
> >> per-CPU performance *slowly* declining):
> >>
> >> uprobe-nop            ( 1 cpus):    3.565 =C2=B1 0.004M/s  (  3.565M/s=
/cpu)
> >> uprobe-nop            ( 2 cpus):    6.742 =C2=B1 0.009M/s  (  3.371M/s=
/cpu)
> >> uprobe-nop            ( 3 cpus):   10.029 =C2=B1 0.056M/s  (  3.343M/s=
/cpu)
> >> uprobe-nop            ( 4 cpus):   13.118 =C2=B1 0.014M/s  (  3.279M/s=
/cpu)
> >> uprobe-nop            ( 5 cpus):   16.360 =C2=B1 0.011M/s  (  3.272M/s=
/cpu)
> >> uprobe-nop            ( 6 cpus):   19.650 =C2=B1 0.045M/s  (  3.275M/s=
/cpu)
> >> uprobe-nop            ( 7 cpus):   22.926 =C2=B1 0.010M/s  (  3.275M/s=
/cpu)
> >> uprobe-nop            ( 8 cpus):   24.707 =C2=B1 0.025M/s  (  3.088M/s=
/cpu)
> >> uprobe-nop            (10 cpus):   30.842 =C2=B1 0.018M/s  (  3.084M/s=
/cpu)
> >> uprobe-nop            (12 cpus):   33.623 =C2=B1 0.037M/s  (  2.802M/s=
/cpu)
> >> uprobe-nop            (14 cpus):   39.199 =C2=B1 0.009M/s  (  2.800M/s=
/cpu)
> >> uprobe-nop            (16 cpus):   41.698 =C2=B1 0.018M/s  (  2.606M/s=
/cpu)
> >> uprobe-nop            (24 cpus):   65.078 =C2=B1 0.018M/s  (  2.712M/s=
/cpu)
> >> uprobe-nop            (32 cpus):   84.580 =C2=B1 0.017M/s  (  2.643M/s=
/cpu)
> >> uprobe-nop            (40 cpus):  101.992 =C2=B1 0.268M/s  (  2.550M/s=
/cpu)
> >> uprobe-nop            (48 cpus):  101.032 =C2=B1 1.428M/s  (  2.105M/s=
/cpu)
> >> uprobe-nop            (56 cpus):  110.986 =C2=B1 0.736M/s  (  1.982M/s=
/cpu)
> >> uprobe-nop            (64 cpus):  124.145 =C2=B1 0.110M/s  (  1.940M/s=
/cpu)
> >> uprobe-nop            (72 cpus):  134.940 =C2=B1 0.200M/s  (  1.874M/s=
/cpu)
> >> uprobe-nop            (80 cpus):  143.918 =C2=B1 0.235M/s  (  1.799M/s=
/cpu)
> >>
> >> uretprobe-nop         ( 1 cpus):    1.987 =C2=B1 0.001M/s  (  1.987M/s=
/cpu)
> >> uretprobe-nop         ( 2 cpus):    3.766 =C2=B1 0.003M/s  (  1.883M/s=
/cpu)
> >> uretprobe-nop         ( 3 cpus):    5.638 =C2=B1 0.002M/s  (  1.879M/s=
/cpu)
> >> uretprobe-nop         ( 4 cpus):    7.275 =C2=B1 0.003M/s  (  1.819M/s=
/cpu)
> >> uretprobe-nop         ( 5 cpus):    9.124 =C2=B1 0.004M/s  (  1.825M/s=
/cpu)
> >> uretprobe-nop         ( 6 cpus):   10.818 =C2=B1 0.007M/s  (  1.803M/s=
/cpu)
> >> uretprobe-nop         ( 7 cpus):   12.721 =C2=B1 0.014M/s  (  1.817M/s=
/cpu)
> >> uretprobe-nop         ( 8 cpus):   13.639 =C2=B1 0.007M/s  (  1.705M/s=
/cpu)
> >> uretprobe-nop         (10 cpus):   17.023 =C2=B1 0.009M/s  (  1.702M/s=
/cpu)
> >> uretprobe-nop         (12 cpus):   18.576 =C2=B1 0.014M/s  (  1.548M/s=
/cpu)
> >> uretprobe-nop         (14 cpus):   21.660 =C2=B1 0.004M/s  (  1.547M/s=
/cpu)
> >> uretprobe-nop         (16 cpus):   22.922 =C2=B1 0.013M/s  (  1.433M/s=
/cpu)
> >> uretprobe-nop         (24 cpus):   34.756 =C2=B1 0.069M/s  (  1.448M/s=
/cpu)
> >> uretprobe-nop         (32 cpus):   44.869 =C2=B1 0.153M/s  (  1.402M/s=
/cpu)
> >> uretprobe-nop         (40 cpus):   53.397 =C2=B1 0.220M/s  (  1.335M/s=
/cpu)
> >> uretprobe-nop         (48 cpus):   48.903 =C2=B1 2.277M/s  (  1.019M/s=
/cpu)
> >> uretprobe-nop         (56 cpus):   42.144 =C2=B1 1.206M/s  (  0.753M/s=
/cpu)
> >> uretprobe-nop         (64 cpus):   42.656 =C2=B1 1.104M/s  (  0.666M/s=
/cpu)
> >> uretprobe-nop         (72 cpus):   46.299 =C2=B1 1.443M/s  (  0.643M/s=
/cpu)
> >> uretprobe-nop         (80 cpus):   46.469 =C2=B1 0.808M/s  (  0.581M/s=
/cpu)
> >>
> >> uprobe-ret            ( 1 cpus):    1.219 =C2=B1 0.008M/s  (  1.219M/s=
/cpu)
> >> uprobe-ret            ( 2 cpus):    1.862 =C2=B1 0.008M/s  (  0.931M/s=
/cpu)
> >> uprobe-ret            ( 3 cpus):    2.874 =C2=B1 0.005M/s  (  0.958M/s=
/cpu)
> >> uprobe-ret            ( 4 cpus):    3.512 =C2=B1 0.002M/s  (  0.878M/s=
/cpu)
> >> uprobe-ret            ( 5 cpus):    3.549 =C2=B1 0.001M/s  (  0.710M/s=
/cpu)
> >> uprobe-ret            ( 6 cpus):    3.425 =C2=B1 0.003M/s  (  0.571M/s=
/cpu)
> >> uprobe-ret            ( 7 cpus):    3.551 =C2=B1 0.009M/s  (  0.507M/s=
/cpu)
> >> uprobe-ret            ( 8 cpus):    3.050 =C2=B1 0.002M/s  (  0.381M/s=
/cpu)
> >> uprobe-ret            (10 cpus):    2.706 =C2=B1 0.002M/s  (  0.271M/s=
/cpu)
> >> uprobe-ret            (12 cpus):    2.588 =C2=B1 0.003M/s  (  0.216M/s=
/cpu)
> >> uprobe-ret            (14 cpus):    2.589 =C2=B1 0.003M/s  (  0.185M/s=
/cpu)
> >> uprobe-ret            (16 cpus):    2.575 =C2=B1 0.001M/s  (  0.161M/s=
/cpu)
> >> uprobe-ret            (24 cpus):    1.808 =C2=B1 0.011M/s  (  0.075M/s=
/cpu)
> >> uprobe-ret            (32 cpus):    1.853 =C2=B1 0.001M/s  (  0.058M/s=
/cpu)
> >> uprobe-ret            (40 cpus):    1.952 =C2=B1 0.002M/s  (  0.049M/s=
/cpu)
> >> uprobe-ret            (48 cpus):    2.075 =C2=B1 0.007M/s  (  0.043M/s=
/cpu)
> >> uprobe-ret            (56 cpus):    2.441 =C2=B1 0.004M/s  (  0.044M/s=
/cpu)
> >> uprobe-ret            (64 cpus):    1.880 =C2=B1 0.012M/s  (  0.029M/s=
/cpu)
> >> uprobe-ret            (72 cpus):    0.962 =C2=B1 0.002M/s  (  0.013M/s=
/cpu)
> >> uprobe-ret            (80 cpus):    1.040 =C2=B1 0.011M/s  (  0.013M/s=
/cpu)
> >>
> >> uretprobe-ret         ( 1 cpus):    0.981 =C2=B1 0.000M/s  (  0.981M/s=
/cpu)
> >> uretprobe-ret         ( 2 cpus):    1.421 =C2=B1 0.001M/s  (  0.711M/s=
/cpu)
> >> uretprobe-ret         ( 3 cpus):    2.050 =C2=B1 0.003M/s  (  0.683M/s=
/cpu)
> >> uretprobe-ret         ( 4 cpus):    2.596 =C2=B1 0.002M/s  (  0.649M/s=
/cpu)
> >> uretprobe-ret         ( 5 cpus):    3.105 =C2=B1 0.003M/s  (  0.621M/s=
/cpu)
> >> uretprobe-ret         ( 6 cpus):    3.886 =C2=B1 0.002M/s  (  0.648M/s=
/cpu)
> >> uretprobe-ret         ( 7 cpus):    3.016 =C2=B1 0.001M/s  (  0.431M/s=
/cpu)
> >> uretprobe-ret         ( 8 cpus):    2.903 =C2=B1 0.000M/s  (  0.363M/s=
/cpu)
> >> uretprobe-ret         (10 cpus):    2.755 =C2=B1 0.001M/s  (  0.276M/s=
/cpu)
> >> uretprobe-ret         (12 cpus):    2.400 =C2=B1 0.001M/s  (  0.200M/s=
/cpu)
> >> uretprobe-ret         (14 cpus):    3.972 =C2=B1 0.001M/s  (  0.284M/s=
/cpu)
> >> uretprobe-ret         (16 cpus):    3.940 =C2=B1 0.003M/s  (  0.246M/s=
/cpu)
> >> uretprobe-ret         (24 cpus):    3.002 =C2=B1 0.003M/s  (  0.125M/s=
/cpu)
> >> uretprobe-ret         (32 cpus):    3.018 =C2=B1 0.003M/s  (  0.094M/s=
/cpu)
> >> uretprobe-ret         (40 cpus):    1.846 =C2=B1 0.000M/s  (  0.046M/s=
/cpu)
> >> uretprobe-ret         (48 cpus):    2.487 =C2=B1 0.004M/s  (  0.052M/s=
/cpu)
> >> uretprobe-ret         (56 cpus):    2.470 =C2=B1 0.006M/s  (  0.044M/s=
/cpu)
> >> uretprobe-ret         (64 cpus):    2.027 =C2=B1 0.014M/s  (  0.032M/s=
/cpu)
> >> uretprobe-ret         (72 cpus):    1.108 =C2=B1 0.011M/s  (  0.015M/s=
/cpu)
> >> uretprobe-ret         (80 cpus):    0.982 =C2=B1 0.005M/s  (  0.012M/s=
/cpu)
> >>
> >>
> >> -ret variants (single-stepping case for x86-64) still suck, but they
> >> suck 2x less now with your patches :) Clearly more work ahead for
> >> those, though.
> >>
> >
> > Quick profiling shows that it's mostly xol_take_insn_slot() and
> > xol_free_insn_slot(), now. So it seems like your planned work might
> > help here.
>
> Andrii, I'm glad we've reached a similar result, The profiling result on
> my machine reveals that about 80% cycles spent on the atomic operations
> on area->bitmap and area->slot_count. I guess the atomic access leads to
> the intensive cacheline bouncing bewteen CPUs.
>
> In the passed weekend, I have been working on another patch that optimize=
s
> the xol_take_insn_slot() and xol_free_inns_slot() for better scalability.
> This involves delaying the freeing of xol insn slots to reduce the times
> of atomic operations and cacheline bouncing. Additionally, per-task refco=
unts
> and an RCU-style management of linked-list of allocated insn slots. In sh=
ort
> summary, this patch try to replace coarse-grained atomic variables with
> finer-grained ones, aiming to elimiate the expensive atomic instructions
> in the hot path. If you or others have bandwidth and interest, I'd welcom=
e
> a brainstorming session on this topic.

I'm happy to help, but I still feel like it's best to concentrate on
landing all the other pending things for uprobe, and then switch to
optimizing the xol case.

We have:
  - RCU protection and avoiding refcounting for uprobes (I'll be
sending latest revision soon);
  - SRCU+timeout for uretprobe and single-step (pending the above
landing first);
  - removing shared nhit counter increment in trace_uprobe (I've sent
patches last week, see [0]);
  - lockless VMA -> inode -> uprobe look up (also pending for #1 to
land, and some more benchmarking for mm_lock_seq changes from Suren,
see [1]);
  - and, of course, your work to remove sighand lock.

So as you can see, there is plenty to discuss and land already, I just
don't want to spread the efforts too thin. But if you can help improve
the benchmark for ARM64, that would be a great parallel effort setting
us up for further work nicely. Thanks!

  [0] https://lore.kernel.org/bpf/20240809192357.4061484-1-andrii@kernel.or=
g/
  [1] https://lore.kernel.org/linux-mm/CAEf4BzaocU-CQsFZ=3Ds5gDM6XQ0Foss_Hr=
oFsPUesBn=3DqgJCprg@mail.gmail.com/

>
> Thanks.
>
> >
> >>
> >>   [0] https://github.com/anakryiko/linux/commits/uprobes-lockless-cumu=
lative/
> >>
> >>
> >>> Thanks.
> >>>
> >>>>
> >>>> But also see some remarks below.
> >>>>
> >>>>> Thanks.
> >>>>>

[...]


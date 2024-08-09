Return-Path: <bpf+bounces-36788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2FE94D668
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 20:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C48B21982
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 18:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902ED15665D;
	Fri,  9 Aug 2024 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwGTSooj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477422F41;
	Fri,  9 Aug 2024 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228859; cv=none; b=p5ebhLOXMBs/lh1ZqxEFjrCvgjvLXd70hp6LwGtINs4JQV87yfPo0t2DaxN+hQAllD61Y17pimOGtaE84PTL2IG1Pqd5QJvl45JRhw/x9s1Ze3pXMZOV0xb4cEzrIdKhGm+xv03/ANu5J5MYBqajEMolimcNRo5ukJE9FT4knGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228859; c=relaxed/simple;
	bh=NmIZ1ZrYzwHKkAciGOTmhaXy7PHdV7MVilDDc1L2LD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdEPf9zNfMfPfbQ0WrVynVHbDumk/d6E2YDSiWWqfMEacwdnLAxXCGoncJ5GPadn7rl3SWprKIxZYIazzF9+Rbnt2y0mtGOia9Lw752r393ek5ep+By3P5q9JffkQO9OH4rK+fyXUHrbju1vhmEkfLkQffcyKKTLcjiS1OnQU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwGTSooj; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cf213128a1so1840959a91.2;
        Fri, 09 Aug 2024 11:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723228856; x=1723833656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh9my5H825fuFcfRDYEAnqYs7Kb4WhjqX9YTpguN26U=;
        b=QwGTSoojDaeBFiN8+SbavYgPGh4WD5G2E7YL89Z8iiC2IwQLexCOK/aWF4chKSDQUv
         rv+8QJwC0yKSEIrY6uj+szGcLWSn2T0ulLWzdRSbAUC8PYkutwM0LTtxPAe616wCH0uE
         enNMnMdsMDaIWT+U/JmM7UCuRFsf5KjuTX3JEGW6fHsVfMLsHKHv6F34JVDoLOstXLu/
         hkk3Xj3uKgVST4uwyaitJNUPhEnCo2+9I7FFCMjKAyOh09gIaoN2blLUqs981s4P7imB
         ahHTy5dD6y7xqRudPwYg7nXu3R2VGMuSreC9RmAv/ayMYcUHFCWDkZqhjI8E4qlwD3vv
         ghxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723228856; x=1723833656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eh9my5H825fuFcfRDYEAnqYs7Kb4WhjqX9YTpguN26U=;
        b=QtxnMCTVA1p+ev6R93yhy1JO5b/U8WqT5UbOB/nTTiJu9ef5mhEbWkKylkN96rORSr
         UQvoteycOWq9gxIpvF3Qx91CXdGD88coW0oWgUQ97/VEagGp0OhjEusBskCkS3Jlyk8r
         k89t46mYpFHWwaqm7lOO0Najo/lI29CvRJ8MIYnhobnGNK58BRrrtTvBS2v+r04vqUFF
         F0o7p1IuceRbqfzDAOqw3uAV2FRGgWR8NHUtxL9yn84/SZbJ9tICsNXkoLSxfu1DNYXG
         oU8OYgy1nN7dDA/7GRfbosntl+src1nz9xoAjaFg4vdMDyfGSwwV44qx6i3wsL/eUy8E
         DVuw==
X-Forwarded-Encrypted: i=1; AJvYcCVfvIT84IULTV3bKdWZvg/2CE/DdoT8heOGEcOflGp3zhuYZWIWlhwJWLl3La3c4MvNziHCjsCaLMz37tdHCRJWZn87p6K5t0BQ+iR6b4CShqxJLbAC0nLqli4Yb3C9lPO/FpsfBE8zp1IqyYzrbxRsJGVWqVAGHuZFlzPMn54+umydtJckVOLp77tZPi2A9+KEWDlvYNwl46oYrrO5MRdmXJF1tIaG6A==
X-Gm-Message-State: AOJu0YyYYuXALxCQ3AKat9ACkaDEPGF6dP+Pq9sk4IBU+ktQrjI05bEy
	gkZlhL0e3BYibM5EGHCSTUOZ8gkMCq92+lXZ32KlPPfp+qqaF7q+AVqW740BhESTvDuYTzOqvGn
	7HPI+D/0H1Rvq7T6mEQumwmi7iNw=
X-Google-Smtp-Source: AGHT+IFC1QaS0C1+PjOS2CV5dP7QGmkhrOv9eSOySgEHp/QekbdFZQSaGFRmwFIMGjtf4KgdemxKpnxbYT4Gig3O284=
X-Received: by 2002:a17:90a:2d83:b0:2ca:7e7c:83ec with SMTP id
 98e67ed59e1d1-2d1e7fe24dcmr2501023a91.20.1723228856309; Fri, 09 Aug 2024
 11:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727094405.1362496-1-liaochang1@huawei.com>
 <7eefae59-8cd1-14a5-ef62-fc0e62b26831@huawei.com> <CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com>
 <a22d6d79-fa7e-62b2-0ac1-575068f176a5@huawei.com> <CAEf4BzbN-+p0cDnHQPDwhVaqs-r-_Ft-LdUwY2KHG1xfrmyjBQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbN-+p0cDnHQPDwhVaqs-r-_Ft-LdUwY2KHG1xfrmyjBQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Aug 2024 11:40:44 -0700
Message-ID: <CAEf4BzZyCd7ECbWQyEpcB4va_U33v8BdfWVY4cMH4zN-Z1sESw@mail.gmail.com>
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

On Fri, Aug 9, 2024 at 11:34=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Aug 9, 2024 at 12:16=E2=80=AFAM Liao, Chang <liaochang1@huawei.co=
m> wrote:
> >
> >
> >
> > =E5=9C=A8 2024/8/9 2:26, Andrii Nakryiko =E5=86=99=E9=81=93:
> > > On Thu, Aug 8, 2024 at 1:45=E2=80=AFAM Liao, Chang <liaochang1@huawei=
.com> wrote:
> > >>
> > >> Hi Andrii and Oleg.
> > >>
> > >> This patch sent by me two weeks ago also aim to optimize the perform=
ance of uprobe
> > >> on arm64. I notice recent discussions on the performance and scalabi=
lity of uprobes
> > >> within the mailing list. Considering this interest, I've added you a=
nd other relevant
> > >> maintainers to the CC list for broader visibility and potential coll=
aboration.
> > >>
> > >
> > > Hi Liao,
> > >
> > > As you can see there is an active work to improve uprobes, that
> > > changes lifetime management of uprobes, removes a bunch of locks take=
n
> > > in the uprobe/uretprobe hot path, etc. It would be nice if you can
> > > hold off a bit with your changes until all that lands. And then
> > > re-benchmark, as costs might shift.
> >
> > Andrii, I'm trying to integrate your lockless changes into the upstream
> > next-20240806 kernel tree. And I ran into some conflicts. please let me
> > know which kernel you're currently working on.
> >
>
> My patches are  based on tip/perf/core. But I also just pushed all the
> changes I have accumulated (including patches I haven't sent for
> review just yet), plus your patches for sighand lock removed applied
> on top into [0]. So you can take a look and use that as a base for
> now. Keep in mind, a bunch of those patches might still change, but
> this should give you the best currently achievable performance with
> uprobes/uretprobes. E.g., I'm getting something like below on x86-64
> (note somewhat linear scalability with number of CPU cores, with
> per-CPU performance *slowly* declining):
>
> uprobe-nop            ( 1 cpus):    3.565 =C2=B1 0.004M/s  (  3.565M/s/cp=
u)
> uprobe-nop            ( 2 cpus):    6.742 =C2=B1 0.009M/s  (  3.371M/s/cp=
u)
> uprobe-nop            ( 3 cpus):   10.029 =C2=B1 0.056M/s  (  3.343M/s/cp=
u)
> uprobe-nop            ( 4 cpus):   13.118 =C2=B1 0.014M/s  (  3.279M/s/cp=
u)
> uprobe-nop            ( 5 cpus):   16.360 =C2=B1 0.011M/s  (  3.272M/s/cp=
u)
> uprobe-nop            ( 6 cpus):   19.650 =C2=B1 0.045M/s  (  3.275M/s/cp=
u)
> uprobe-nop            ( 7 cpus):   22.926 =C2=B1 0.010M/s  (  3.275M/s/cp=
u)
> uprobe-nop            ( 8 cpus):   24.707 =C2=B1 0.025M/s  (  3.088M/s/cp=
u)
> uprobe-nop            (10 cpus):   30.842 =C2=B1 0.018M/s  (  3.084M/s/cp=
u)
> uprobe-nop            (12 cpus):   33.623 =C2=B1 0.037M/s  (  2.802M/s/cp=
u)
> uprobe-nop            (14 cpus):   39.199 =C2=B1 0.009M/s  (  2.800M/s/cp=
u)
> uprobe-nop            (16 cpus):   41.698 =C2=B1 0.018M/s  (  2.606M/s/cp=
u)
> uprobe-nop            (24 cpus):   65.078 =C2=B1 0.018M/s  (  2.712M/s/cp=
u)
> uprobe-nop            (32 cpus):   84.580 =C2=B1 0.017M/s  (  2.643M/s/cp=
u)
> uprobe-nop            (40 cpus):  101.992 =C2=B1 0.268M/s  (  2.550M/s/cp=
u)
> uprobe-nop            (48 cpus):  101.032 =C2=B1 1.428M/s  (  2.105M/s/cp=
u)
> uprobe-nop            (56 cpus):  110.986 =C2=B1 0.736M/s  (  1.982M/s/cp=
u)
> uprobe-nop            (64 cpus):  124.145 =C2=B1 0.110M/s  (  1.940M/s/cp=
u)
> uprobe-nop            (72 cpus):  134.940 =C2=B1 0.200M/s  (  1.874M/s/cp=
u)
> uprobe-nop            (80 cpus):  143.918 =C2=B1 0.235M/s  (  1.799M/s/cp=
u)
>
> uretprobe-nop         ( 1 cpus):    1.987 =C2=B1 0.001M/s  (  1.987M/s/cp=
u)
> uretprobe-nop         ( 2 cpus):    3.766 =C2=B1 0.003M/s  (  1.883M/s/cp=
u)
> uretprobe-nop         ( 3 cpus):    5.638 =C2=B1 0.002M/s  (  1.879M/s/cp=
u)
> uretprobe-nop         ( 4 cpus):    7.275 =C2=B1 0.003M/s  (  1.819M/s/cp=
u)
> uretprobe-nop         ( 5 cpus):    9.124 =C2=B1 0.004M/s  (  1.825M/s/cp=
u)
> uretprobe-nop         ( 6 cpus):   10.818 =C2=B1 0.007M/s  (  1.803M/s/cp=
u)
> uretprobe-nop         ( 7 cpus):   12.721 =C2=B1 0.014M/s  (  1.817M/s/cp=
u)
> uretprobe-nop         ( 8 cpus):   13.639 =C2=B1 0.007M/s  (  1.705M/s/cp=
u)
> uretprobe-nop         (10 cpus):   17.023 =C2=B1 0.009M/s  (  1.702M/s/cp=
u)
> uretprobe-nop         (12 cpus):   18.576 =C2=B1 0.014M/s  (  1.548M/s/cp=
u)
> uretprobe-nop         (14 cpus):   21.660 =C2=B1 0.004M/s  (  1.547M/s/cp=
u)
> uretprobe-nop         (16 cpus):   22.922 =C2=B1 0.013M/s  (  1.433M/s/cp=
u)
> uretprobe-nop         (24 cpus):   34.756 =C2=B1 0.069M/s  (  1.448M/s/cp=
u)
> uretprobe-nop         (32 cpus):   44.869 =C2=B1 0.153M/s  (  1.402M/s/cp=
u)
> uretprobe-nop         (40 cpus):   53.397 =C2=B1 0.220M/s  (  1.335M/s/cp=
u)
> uretprobe-nop         (48 cpus):   48.903 =C2=B1 2.277M/s  (  1.019M/s/cp=
u)
> uretprobe-nop         (56 cpus):   42.144 =C2=B1 1.206M/s  (  0.753M/s/cp=
u)
> uretprobe-nop         (64 cpus):   42.656 =C2=B1 1.104M/s  (  0.666M/s/cp=
u)
> uretprobe-nop         (72 cpus):   46.299 =C2=B1 1.443M/s  (  0.643M/s/cp=
u)
> uretprobe-nop         (80 cpus):   46.469 =C2=B1 0.808M/s  (  0.581M/s/cp=
u)
>
> uprobe-ret            ( 1 cpus):    1.219 =C2=B1 0.008M/s  (  1.219M/s/cp=
u)
> uprobe-ret            ( 2 cpus):    1.862 =C2=B1 0.008M/s  (  0.931M/s/cp=
u)
> uprobe-ret            ( 3 cpus):    2.874 =C2=B1 0.005M/s  (  0.958M/s/cp=
u)
> uprobe-ret            ( 4 cpus):    3.512 =C2=B1 0.002M/s  (  0.878M/s/cp=
u)
> uprobe-ret            ( 5 cpus):    3.549 =C2=B1 0.001M/s  (  0.710M/s/cp=
u)
> uprobe-ret            ( 6 cpus):    3.425 =C2=B1 0.003M/s  (  0.571M/s/cp=
u)
> uprobe-ret            ( 7 cpus):    3.551 =C2=B1 0.009M/s  (  0.507M/s/cp=
u)
> uprobe-ret            ( 8 cpus):    3.050 =C2=B1 0.002M/s  (  0.381M/s/cp=
u)
> uprobe-ret            (10 cpus):    2.706 =C2=B1 0.002M/s  (  0.271M/s/cp=
u)
> uprobe-ret            (12 cpus):    2.588 =C2=B1 0.003M/s  (  0.216M/s/cp=
u)
> uprobe-ret            (14 cpus):    2.589 =C2=B1 0.003M/s  (  0.185M/s/cp=
u)
> uprobe-ret            (16 cpus):    2.575 =C2=B1 0.001M/s  (  0.161M/s/cp=
u)
> uprobe-ret            (24 cpus):    1.808 =C2=B1 0.011M/s  (  0.075M/s/cp=
u)
> uprobe-ret            (32 cpus):    1.853 =C2=B1 0.001M/s  (  0.058M/s/cp=
u)
> uprobe-ret            (40 cpus):    1.952 =C2=B1 0.002M/s  (  0.049M/s/cp=
u)
> uprobe-ret            (48 cpus):    2.075 =C2=B1 0.007M/s  (  0.043M/s/cp=
u)
> uprobe-ret            (56 cpus):    2.441 =C2=B1 0.004M/s  (  0.044M/s/cp=
u)
> uprobe-ret            (64 cpus):    1.880 =C2=B1 0.012M/s  (  0.029M/s/cp=
u)
> uprobe-ret            (72 cpus):    0.962 =C2=B1 0.002M/s  (  0.013M/s/cp=
u)
> uprobe-ret            (80 cpus):    1.040 =C2=B1 0.011M/s  (  0.013M/s/cp=
u)
>
> uretprobe-ret         ( 1 cpus):    0.981 =C2=B1 0.000M/s  (  0.981M/s/cp=
u)
> uretprobe-ret         ( 2 cpus):    1.421 =C2=B1 0.001M/s  (  0.711M/s/cp=
u)
> uretprobe-ret         ( 3 cpus):    2.050 =C2=B1 0.003M/s  (  0.683M/s/cp=
u)
> uretprobe-ret         ( 4 cpus):    2.596 =C2=B1 0.002M/s  (  0.649M/s/cp=
u)
> uretprobe-ret         ( 5 cpus):    3.105 =C2=B1 0.003M/s  (  0.621M/s/cp=
u)
> uretprobe-ret         ( 6 cpus):    3.886 =C2=B1 0.002M/s  (  0.648M/s/cp=
u)
> uretprobe-ret         ( 7 cpus):    3.016 =C2=B1 0.001M/s  (  0.431M/s/cp=
u)
> uretprobe-ret         ( 8 cpus):    2.903 =C2=B1 0.000M/s  (  0.363M/s/cp=
u)
> uretprobe-ret         (10 cpus):    2.755 =C2=B1 0.001M/s  (  0.276M/s/cp=
u)
> uretprobe-ret         (12 cpus):    2.400 =C2=B1 0.001M/s  (  0.200M/s/cp=
u)
> uretprobe-ret         (14 cpus):    3.972 =C2=B1 0.001M/s  (  0.284M/s/cp=
u)
> uretprobe-ret         (16 cpus):    3.940 =C2=B1 0.003M/s  (  0.246M/s/cp=
u)
> uretprobe-ret         (24 cpus):    3.002 =C2=B1 0.003M/s  (  0.125M/s/cp=
u)
> uretprobe-ret         (32 cpus):    3.018 =C2=B1 0.003M/s  (  0.094M/s/cp=
u)
> uretprobe-ret         (40 cpus):    1.846 =C2=B1 0.000M/s  (  0.046M/s/cp=
u)
> uretprobe-ret         (48 cpus):    2.487 =C2=B1 0.004M/s  (  0.052M/s/cp=
u)
> uretprobe-ret         (56 cpus):    2.470 =C2=B1 0.006M/s  (  0.044M/s/cp=
u)
> uretprobe-ret         (64 cpus):    2.027 =C2=B1 0.014M/s  (  0.032M/s/cp=
u)
> uretprobe-ret         (72 cpus):    1.108 =C2=B1 0.011M/s  (  0.015M/s/cp=
u)
> uretprobe-ret         (80 cpus):    0.982 =C2=B1 0.005M/s  (  0.012M/s/cp=
u)
>
>
> -ret variants (single-stepping case for x86-64) still suck, but they
> suck 2x less now with your patches :) Clearly more work ahead for
> those, though.
>

Quick profiling shows that it's mostly xol_take_insn_slot() and
xol_free_insn_slot(), now. So it seems like your planned work might
help here.

>
>   [0] https://github.com/anakryiko/linux/commits/uprobes-lockless-cumulat=
ive/
>
>
> > Thanks.
> >
> > >
> > > But also see some remarks below.
> > >
> > >> Thanks.
> > >>
> > >> =E5=9C=A8 2024/7/27 17:44, Liao Chang =E5=86=99=E9=81=93:
> > >>> The profiling result of single-thread model of selftests bench reve=
als
> > >>> performance bottlenecks in find_uprobe() and caches_clean_inval_pou=
() on
> > >>> ARM64. On my local testing machine, 5% of CPU time is consumed by
> > >>> find_uprobe() for trig-uprobe-ret, while caches_clean_inval_pou() t=
ake
> > >>> about 34% of CPU time for trig-uprobe-nop and trig-uprobe-push.
> > >>>
> > >>> This patch introduce struct uprobe_breakpoint to track previously
> > >>> allocated insn_slot for frequently hit uprobe. it effectively reduc=
e the
> > >>> need for redundant insn_slot writes and subsequent expensive cache
> > >>> flush, especially on architecture like ARM64. This patch has been t=
ested
> > >>> on Kunpeng916 (Hi1616), 4 NUMA nodes, 64 cores@ 2.4GHz. The selftes=
t
> > >>> bench and Redis GET/SET benchmark result below reveal obivious
> > >>> performance gain.
> > >>>
> > >>> before-opt
> > >>> ----------
> > >>> trig-uprobe-nop:  0.371 =C2=B1 0.001M/s (0.371M/prod)
> > >>> trig-uprobe-push: 0.370 =C2=B1 0.001M/s (0.370M/prod)
> > >>> trig-uprobe-ret:  1.637 =C2=B1 0.001M/s (1.647M/prod)
> > >
> > > I'm surprised that nop and push variants are much slower than ret
> > > variant. This is exactly opposite on x86-64. Do you have an
> > > explanation why this might be happening? I see you are trying to
> > > optimize xol_get_insn_slot(), but that is (at least for x86) a slow
> > > variant of uprobe that normally shouldn't be used. Typically uprobe i=
s
> > > installed on nop (for USDT) and on function entry (which would be pus=
h
> > > variant, `push %rbp` instruction).
> > >
> > > ret variant, for x86-64, causes one extra step to go back to user
> > > space to execute original instruction out-of-line, and then trapping
> > > back to kernel for running uprobe. Which is what you normally want to
> > > avoid.
> > >
> > > What I'm getting at here. It seems like maybe arm arch is missing fas=
t
> > > emulated implementations for nops/push or whatever equivalents for
> > > ARM64 that is. Please take a look at that and see why those are slow
> > > and whether you can make those into fast uprobe cases?
> >
> > I will spend the weekend figuring out the questions you raised. Thanks =
for
> > pointing them out.
> >
> > >
> > >>> trig-uretprobe-nop:  0.331 =C2=B1 0.004M/s (0.331M/prod)
> > >>> trig-uretprobe-push: 0.333 =C2=B1 0.000M/s (0.333M/prod)
> > >>> trig-uretprobe-ret:  0.854 =C2=B1 0.002M/s (0.854M/prod)
> > >>> Redis SET (RPS) uprobe: 42728.52
> > >>> Redis GET (RPS) uprobe: 43640.18
> > >>> Redis SET (RPS) uretprobe: 40624.54
> > >>> Redis GET (RPS) uretprobe: 41180.56
> > >>>
> > >>> after-opt
> > >>> ---------
> > >>> trig-uprobe-nop:  0.916 =C2=B1 0.001M/s (0.916M/prod)
> > >>> trig-uprobe-push: 0.908 =C2=B1 0.001M/s (0.908M/prod)
> > >>> trig-uprobe-ret:  1.855 =C2=B1 0.000M/s (1.855M/prod)
> > >>> trig-uretprobe-nop:  0.640 =C2=B1 0.000M/s (0.640M/prod)
> > >>> trig-uretprobe-push: 0.633 =C2=B1 0.001M/s (0.633M/prod)
> > >>> trig-uretprobe-ret:  0.978 =C2=B1 0.003M/s (0.978M/prod)
> > >>> Redis SET (RPS) uprobe: 43939.69
> > >>> Redis GET (RPS) uprobe: 45200.80
> > >>> Redis SET (RPS) uretprobe: 41658.58
> > >>> Redis GET (RPS) uretprobe: 42805.80
> > >>>
> > >>> While some uprobes might still need to share the same insn_slot, th=
is
> > >>> patch compare the instructions in the resued insn_slot with the
> > >>> instructions execute out-of-line firstly to decides allocate a new =
one
> > >>> or not.
> > >>>
> > >>> Additionally, this patch use a rbtree associated with each thread t=
hat
> > >>> hit uprobes to manage these allocated uprobe_breakpoint data. Due t=
o the
> > >>> rbtree of uprobe_breakpoints has smaller node, better locality and =
less
> > >>> contention, it result in faster lookup times compared to find_uprob=
e().
> > >>>
> > >>> The other part of this patch are some necessary memory management f=
or
> > >>> uprobe_breakpoint data. A uprobe_breakpoint is allocated for each n=
ewly
> > >>> hit uprobe that doesn't already have a corresponding node in rbtree=
. All
> > >>> uprobe_breakpoints will be freed when thread exit.
> > >>>
> > >>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > >>> ---
> > >>>  include/linux/uprobes.h |   3 +
> > >>>  kernel/events/uprobes.c | 246 +++++++++++++++++++++++++++++++++---=
----
> > >>>  2 files changed, 211 insertions(+), 38 deletions(-)
> > >>>
> > >
> > > [...]
> >
> > --
> > BR
> > Liao, Chang


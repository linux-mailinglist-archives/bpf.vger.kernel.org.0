Return-Path: <bpf+bounces-44389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1208B9C2656
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 21:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D531F22F89
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 20:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58E31C3F00;
	Fri,  8 Nov 2024 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpLjxlQj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F11C1F0F
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096852; cv=none; b=DkflGjAj0T9Ll6paGPI8pn2NGtCOgEGHZtbMHNH1P3PlVLnxy1KHdNEhQme89EZLGR9mTHxloLKAP5ezxUsFxMhepM5g9DK0J5j3fbvWfL6FJfRkl9mIgof6c9nA2177wbEYlz4zDzOyifmNg3ALVFe75cbyX/7KNWK9ilwC93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096852; c=relaxed/simple;
	bh=AE5mwHoAI/oPgjriM/gEpVirY913213irWkWZcWZWMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oc46OTh2kuSerTfMRfCovc9M063+bEE8efU/Jk2n0y/orEYx0RLiKqATvHCBpqkQTRX7DWi0Cy1X6cSIXDp1mz6x/4rbS466cOuOlRyzP4n1ajo7c1v2l6h5T79lr0+dkd1CrOjs46b1NPZfa3rwlVgQOtI93D8SQNB/KuUvXeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpLjxlQj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so21301955e9.0
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2024 12:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731096849; x=1731701649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEaKrXU3ICDRJ6s4di/4kirqzFZ5h87GJuZbSRx8/8Y=;
        b=PpLjxlQjis4qOcLUEKA6i/X7pnkW8ujlUDJvm9U83rv8IQBWlnUQnmLokjnT1mWWrp
         GPYpZ0TIJOpcyQgXU9JXlJRcoEIHf6tyhaHgb/HOKPHES21Ud7z+fA0zQa2sXopZ3DvS
         XjlSOzVU61s8DjQmThM9JLaQ/ryPFvdXzpM1HQ4lxma9JCCArmJUbyLWsQApZgk7v36I
         we9VNWz1acLwF8RNDu3igThkb+nwdXSVG98d6j1+dvm7eaAbQ7NcuXc9jpTqV8vQ1YZ6
         GIu9hsZUbJDe9+nV7PVvfpy44kZMKaPh1lAY1jqAaVpOzudPjVPI00x/TWBTf7uDLw6V
         BVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731096849; x=1731701649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEaKrXU3ICDRJ6s4di/4kirqzFZ5h87GJuZbSRx8/8Y=;
        b=AS36kfDpadhp8fO9uzMYIbgi8acbxJfFjtw27yQndVeWAWYbnE/ZMfpChnpWG7EQuU
         Ht004szVsz1bJr8J2v2Xr14dXSGoi7/xuGNHpdpT1bbbQfB0pYTpFOoTbiP2UhWeV3z1
         lUyd651tCwEM7TQJ1ljkmCfOgQu3928Ib4kFjrCHEAYYU5/aURgRRDTwWBwATm8uTM2F
         /ABl5rDwGQPAfyPrVD8x44CRX1s9mxeaZTu/O9EehRuXHolC+KI/rkE6l6fH1qpjXiBD
         d8lO+O//BX77VD1sKeT0iZ7SoI+g576GFIZV7Un/r64sekFKfsIL7EcdR6ozoZB9jBRB
         XZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCUTZW4nR5Reido1IlF0uXP9tVZOaJ68U6nweEF6Hh5OVGlh0srRPARFbYkN7qYfC46M5q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBPGhq9Z1yWU+hylc8SEDunR56/Z7IaRxOMo3duI6yV6bSL1Aw
	BbCptTmtfd54n4O8z236T2HXT3K3Ah9GUs8B5S9u1iu1XYGWwFIVHVBJpI4sKJfbR4Rxc4Q/6bz
	9OG/ewzRvf2Tk9ZUY2Dl3xLBTttk=
X-Google-Smtp-Source: AGHT+IGgZqzDWFCRL7lGUQpiBJBztJ8uHBc9UR4OI9i+3RwfqbxnP4UiJXHEyzmBzaSkcdGvn4K8s92PmuadKcUyNhg=
X-Received: by 2002:a5d:59a3:0:b0:37d:41df:136b with SMTP id
 ffacd0b85a97d-381f172a1eemr3309796f8f.13.1731096848684; Fri, 08 Nov 2024
 12:14:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101000017.3424165-1-memxor@gmail.com> <CAP01T75OUeE8E-Lw9df84dm8ag2YmHW619f1DmPSVZ5_O89+Bg@mail.gmail.com>
 <c3f7ee7790c6f53a572ff2857433f534f4972189.camel@gmail.com>
 <CAADnVQLZ9oj4+en43UZVOOLNHfHGq2aEcR9pYwLKLeMh1rJN-w@mail.gmail.com>
 <57dfdda6a89819b65be8960c3c6953bb9b8ceed3.camel@gmail.com> <df84c4c41d3fa9cbc43738ad226bc9efc5fa495c.camel@gmail.com>
In-Reply-To: <df84c4c41d3fa9cbc43738ad226bc9efc5fa495c.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Nov 2024 12:13:57 -0800
Message-ID: <CAADnVQJNnqpoF2sNL76_Newyve8NVD2PLdq=tJyiA=tXkn_G4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/2] Handle possible NULL trusted raw_tp arguments
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <olsajiri@gmail.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2024-11-01 at 17:32 -0700, Eduard Zingerman wrote:
> > On Fri, 2024-11-01 at 17:29 -0700, Alexei Starovoitov wrote:
> >
> > [...]
> >
> > > Hmm.
> > > Puranjay touched it last with extra logic.
> > >
> > > And before that David Vernet tried to address flakiness
> > > in commit 4a54de65964d.
> > > Yonghong also noticed lockups in paravirt
> > > and added workaround 7015843afc.
> > >
> > > Your additional timeout/workaround makes sense to me,
> > > but would be good to bisect whether Puranjay's change caused it.
> >
> > I'll debug what's going on some time later today or on Sat.
>
> I finally had time to investigate this a bit.
> First, here is how to trigger lockup:
>
>   t1=3Dsend_signal/send_signal_perf_thread_remote; \
>   t2=3Dsend_signal/send_signal_nmi_thread_remote; \
>   for i in $(seq 1 100); do ./test_progs -t $t1,$t2; done
>
> Must be both tests for whatever reason.
> The failing test is 'send_signal_nmi_thread_remote'.
>
> The test is organized as parent and child processes communicating
> various events to each other. The intended sequence of events:
> - child:
>   - install SIGUSR1 handler
>   - notify parent
>   - wait for parent
> - parent:
>   - open PERF_COUNT_SW_CPU_CLOCK event
>   - attach BPF program to the event
>   - notify child
>   - enter busy loop for 10^8 iterations
>   - wait for child
> - BPF program:
>   - send SIGUSR1 to child
> - child:
>   - poll for SIGUSR1 in a busy loop
>   - notify parent
> - parent:
>   - check value communicated by child,
>     terminate test.
>
> The lockup happens because on every other test run perf event is not
> triggered, child does not receive SIGUSR1 and thus both parent and
> child are stuck.
>
> For 'send_signal_nmi_thread_remote' perf event is defined as:
>
>         struct perf_event_attr attr =3D {
>                 .sample_period =3D 1,
>                 .type =3D PERF_TYPE_HARDWARE,
>                 .config =3D PERF_COUNT_HW_CPU_CYCLES,
>         };
>
> And is opened for parent process pid.
>
> Apparently, the perf event is not always triggered between lines
> send_signal.c:165-180. And at line 180 parent enters system call,
> so cpu cycles stop ticking for 'parent', thus if perf event
> had not been triggered already it won't be triggered at all
> (as far as I understand).
>
> Applying same fix as Yonghong did in 7015843afc is sufficient to
> reliably trigger perf event:
>
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -223,7 +223,8 @@ static void test_send_signal_perf(bool signal_thread,=
 bool remote)
>  static void test_send_signal_nmi(bool signal_thread, bool remote)
>  {
>         struct perf_event_attr attr =3D {
> -               .sample_period =3D 1,
> +               .freq =3D 1,
> +               .sample_freq =3D 1000,
>                 .type =3D PERF_TYPE_HARDWARE,
>                 .config =3D PERF_COUNT_HW_CPU_CYCLES,
>         };
>
> But I don't understand why.
> As far as I can figure from kernel source code,
> sample_period is measured in nanoseconds (is it?),

I believe sample_period is a number of samples.
1 means that perf suppose to generate event very often.
It means nanoseconds only for SW cpu_cycles.

let's apply above workaround and move on. Pls send a patch.


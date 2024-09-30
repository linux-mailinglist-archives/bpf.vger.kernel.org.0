Return-Path: <bpf+bounces-40618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB07898AF9E
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 00:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC73B1C212DC
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 22:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F283A187FF6;
	Mon, 30 Sep 2024 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1f6b+oA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE32170A22
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 22:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734012; cv=none; b=MKgp5C6ftInKI0XQ9tkq2PGuaTnG5L0eVwn8GCESmKiCEb/kRfGoGf6cuzda9yKomA1V3MajW/rHgILX9owzzGxgbkrxNsqfg0R+FYAUTaWwwkpreC2qPWyPu5NgRprYDX5Q0CMkoImIE0L+iC/VKHWXZXh+O5M3FscmUh3KtAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734012; c=relaxed/simple;
	bh=HqE/+A+JpWBW06QrQUHZ9z5PBtaO/nit8ONdvAGH0k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IObEn6ZRcV0kXBmMpKtYPs/hPAAbN5Jr29h30ery668bI1Zeq/04YFn7mIUEVc45aVKwfla6xXYJaWWl+EjFfFUhAM5li9nlU0nYce1wNa4DfOUqlosTsHqT/foia8Sxdr58nSplDRLx6La8CcqEIy1lBI4PDQ4MLKaPJlwXRqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1f6b+oA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e0894f1b14so3638948a91.1
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727734010; x=1728338810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lLQVC1ZNVy7eqB5aE36eaGxTKxshtff3K5bubUxY3U=;
        b=I1f6b+oA9Dcg24BVK17laPx2IZ1dtFwHt+lQVpYr8mULsw6s10GjGzjmOOhpjiYYtT
         Ta8VA5w9+wCY8I+BNiG+6BrtKtmX2xiYA5CwUmHiv+VFUKXMQg4WlFt5dzwrDgwarEyJ
         dOMQqiTPJvZm6dvTodhH6gte0K0i6O5pgYHqkl+/tWntkFsZhRw/SJCdR/66ftFpSEE0
         Oi/iwpvbVrGEZOp7mkOGqp9gUIOze9k2nRPa+Q+xs2VkZauc2QoPDsxd+WEUp9v0JPIp
         KngD6RCgDEwQQFuk1HVqJiEIWtX6B3PsdsNxA2CdqECgjb4hTNTqsy2QzXiIJYRJkVL0
         2Ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727734010; x=1728338810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lLQVC1ZNVy7eqB5aE36eaGxTKxshtff3K5bubUxY3U=;
        b=LayZh95z7vlTFH/MXYlMjGXQ8DQeXOy+Qbh2uzw+hnideuK/3Znw/PeAhCgHHckAC1
         wgsWMzBMgtqxoT5Jye2a2qpSr8JNNc11tqKbMT7Ax5ghgv2L7TZ3t0Re5wPaAa84yH8R
         /yZ31Zu1ap3JirVGprKYucMsMbRP9U9r7RdGR1orNe1PGJidKc9fA34B2rPTMZxcLACW
         ksJnwH1kx0VjQAJLkAPkACZ5QAprq6qmJMfunE5vU4uSZu0mllL9725B3UL4aOaZw0T1
         Ao3E+XzoQLa4B1r7QLRhi7cph/CVwd0nAb9OOd7pXvCAfr5VpJiMHoPPXnEA37AuChlV
         xPuA==
X-Forwarded-Encrypted: i=1; AJvYcCUmx65bqFc76Pl1fYsMv2usp2PlVWLa1UhcfZ/VObH+quD4uUvAEJhBYq0mLV1orkFSllo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaMvdeKhXc41RMI6vJ+sxMYFXS+QFcXfwgwdWcdd6nOAlq5JsY
	jcHRMm48H8PR0Q+GJqIMEvAC7IpoUWQPPzc5Y/vkD8Xvjj5DAl1I1e+j1cDKuDK8RljCZ6MQO+P
	VnMr9aJMjGfgJUMR4YjcXb1BRSSM=
X-Google-Smtp-Source: AGHT+IEJ8Sh7W2POM9MBd8qk8XPEAzzePAVBuJH/vUOnKWlWJGk+ShoZJH7kTAYK4Hx6IaOfq/uPcFWi4oKEAx8RLeg=
X-Received: by 2002:a17:90b:118c:b0:2e0:a77e:8305 with SMTP id
 98e67ed59e1d1-2e0b8ec75d7mr13727150a91.39.1727734010446; Mon, 30 Sep 2024
 15:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919195454.73358-1-kerneljasonxing@gmail.com>
 <CAADnVQJUd_1y-Ecgw3pgd6z2jw6=ZEm5wnxQqwUnhCobw752fQ@mail.gmail.com>
 <CAL+tcoDEpGq3NfYgavc=wwgsMch=L7mh9-0J8tWv2Sv1MWCH+w@mail.gmail.com>
 <CAEf4BzaVdr_0kQo=+jPLN++PvcU6pwTjaPVEA880kgDN94TZYw@mail.gmail.com> <CAL+tcoCc+d6Tdc6dYAYNg3-zWvm6dxmGOYHOEA9zPmpi5L7=7Q@mail.gmail.com>
In-Reply-To: <CAL+tcoCc+d6Tdc6dYAYNg3-zWvm6dxmGOYHOEA9zPmpi5L7=7Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Sep 2024 15:06:37 -0700
Message-ID: <CAEf4BzYdra11s9Y7_dE5ShqaUb9nRAunYJa+x3eaqJRtp73ieA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: syscall_nrs: fix no previous prototype for "syscall_defines"
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 10:22=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> Hello Andrii,
>
> On Sat, Sep 28, 2024 at 7:08=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Sep 20, 2024 at 12:37=E2=80=AFPM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > >
> > > On Thu, Sep 19, 2024 at 11:17=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Sep 19, 2024 at 9:55=E2=80=AFPM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > In some environments (gcc treated as error in W=3D1, which is def=
ault), if we
> > > > > make -C samples/bpf/, it will be stopped because of
> > > > > "no previous prototype" error like this:
> > > > >
> > > > >   ../samples/bpf/syscall_nrs.c:7:6:
> > > > >   error: no previous prototype for =E2=80=98syscall_defines=E2=80=
=99 [-Werror=3Dmissing-prototypes]
> > > > >    void syscall_defines(void)
> > > > >         ^~~~~~~~~~~~~~~
> > > >
> > > > samples/bpf/ doesn't accept patches any more.
> > > > If this samples/test is useful, refactor it to the test_progs frame=
work.
> > > > Otherwise delete it.
> > > >
> > > > pw-bot: cr
> > >
> > > After reconsidering what Alexei said, I still feel we could take this
> > > patch? It is because:
> > > 1) the patch itself  is more of a fix instead of optimization,
> > > 2)as long as samples/bpf exists in the kernel, we cannot easily let
> > > it(issues) go and ignore it.
> > >
> > > Applying such a patch won't cause any further confusion, right? As we
> > > can see, it's like a fix which does not introduce anything new here.
> > >
> > > What do you bpf maintainers think?
> >
> > I think it's fine to minimally fix the issue in samples/bpf, but I
> > don't think this weirdly-looking extra declaration is the best fix.
>
> Thanks for your reply.
>
> >
> > Can you mark that function static? Will that work?
>
> Not really, it will print:
> samples/bpf/syscall_nrs.c:7:13: error: =E2=80=98syscall_defines=E2=80=99 =
defined but
> not used [-Werror=3Dunused-function]
>  static void syscall_defines(void)
>              ^~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> > Or, as a plan B,
> > use pragma to disable this warning, it's clearly "expected" in this
> > case.
>
> Yes, I admit the use in this function is "expected" like you said
> because this file will be converted into a .h file. Could you kindly
> show me more hints on how to disable the warning when compiling? I
> tried to remove something like "-Wmissing-prototypes", but the warning
> still happens.
>

Grep for "#pragma GCC diagnostic ignored" uses in kernel sources.

> Thanks,
> Jason


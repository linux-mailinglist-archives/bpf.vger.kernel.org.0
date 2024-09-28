Return-Path: <bpf+bounces-40459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD63C988DE6
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 07:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DDE1C20FD1
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 05:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC0A14B087;
	Sat, 28 Sep 2024 05:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhM2jRhS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98E74C6D
	for <bpf@vger.kernel.org>; Sat, 28 Sep 2024 05:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727500961; cv=none; b=hpLYsIi29xT66qJvUkNoSinymqZwt37DMJNNDxStReR3Hr54iFokxw2DzK7gLAoTn9Wf7nYSd3EGh2YU9tW59D7ODDpF7w3zi3ASTqjs53Hkt4UBQfl9p+3za6oPokfU7nckWIBTdX6OhsZ9sQB2iglzM/gVgx2pvHtFlZST//k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727500961; c=relaxed/simple;
	bh=2nDpViamoI1bwtyiEAXizaQVB6Mqardn/eew17ip/f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIzLbET8pcOfvMSIcBGK8llZqRGpy1BAimQE70t4ZP2PyBw042+M2fMROJoZ5Uj1O3c18utEovVUeqWD7NLRNxTANtEN/Jf4dRHv+yciw3vXRzH+3RzcCSLl3ugRxAYKbUVkKMp/o0NItgxDKvQZW/qRCy+2fDKBp5erzZ3xSqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhM2jRhS; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a1a90bd015so10747195ab.1
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 22:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727500959; x=1728105759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/owLYaRltREKd6v/tI/QKEjagYCNrw39z7d9oWaW1bI=;
        b=JhM2jRhSmjugGzW7voTqOPSYIpxOM2KFwxbFZVSfKRQM8Al/3hx+5axS8eDiEs8FCH
         J+tHL0BgwZl9jLWa4iV0RpJmYYeKWIkiWLiTYjr8eRfzMLgjw0T2eY4JyHUkJRaXakX+
         FqhFdnbE+oXcGHq1WhWh8CPSJGBxc+tfoOt3cfETX2bD/bhSZlUcllbF/FQmCeCUvC8z
         7x8sSwr2D4KNOYThmknYXAmFMO71+YTDiQuCD4ITZ5/U/o0omtZOfkrCiyn0nEpzO0gu
         wBuzEAV62dcmUpwkSoo8ClXgitMGXGKE+kYEc8OHI9aYlpS3yX4VbgunPbGgoP7N0ryZ
         iMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727500959; x=1728105759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/owLYaRltREKd6v/tI/QKEjagYCNrw39z7d9oWaW1bI=;
        b=NPwUsuO3yKOS+xf+0Oi4EOPSGVAQyq9MoSD1zumoEiggezw9K4+UAsjb5hJXKRwhvN
         nwj8J+3rr3LYKsvT+8KV7HHD6GBlhvNa/kgpkP22UBy+CRp8RMvuXawYoyO+RTCawJqM
         //aF2v3PCDoXTIxvhC4j3hBoyWSzmiDBCz4cPx6vF653fm01jPg6gasYGIP7qr7EWcnN
         GOXEtEloecWWZ5Ll0WR4HFD8fuiu6LWyU1PVVmcP/Y0kw+O8pIa+E3pgfQm5PluPcDK+
         to5jRoGQSz54QQ2kWD2aSxyOZjaAWOOhHeBBl3QpPZzTfaMDy4u3J0Y3CtuwxZIk/KnR
         WqSw==
X-Forwarded-Encrypted: i=1; AJvYcCXsnJvyMmMtFcmI4M5FzH9wbRsySsMpcMB3eSY1owx8v+ms2ODQJcmXRP9fGcQB0YhDcak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYIDRg/BNOxeyaI7hCZqmDAXeRxLdzUP2zK2LJp++CHfARL/5w
	P6VfoW3n0Fbo9vi1TY/jh8rNrLxPalKLF9V8ECkPF9OCr5U8QVAw4NBghPW3W0JJ8X4NOS+PV+a
	ANsqaUQVnRUyzJA1/VnHhQqlgpP0=
X-Google-Smtp-Source: AGHT+IEA3bgAqKDOo6TJbwTi83RXkZeUaax0KV4PBBarNWcNxkNA0bM3s3GcyK+vosKA0YcHuKEXSPjAQVPk+9UEtvw=
X-Received: by 2002:a05:6e02:1a0c:b0:3a0:a385:911d with SMTP id
 e9e14a558f8ab-3a344fcc3e1mr52879775ab.0.1727500958620; Fri, 27 Sep 2024
 22:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919195454.73358-1-kerneljasonxing@gmail.com>
 <CAADnVQJUd_1y-Ecgw3pgd6z2jw6=ZEm5wnxQqwUnhCobw752fQ@mail.gmail.com>
 <CAL+tcoDEpGq3NfYgavc=wwgsMch=L7mh9-0J8tWv2Sv1MWCH+w@mail.gmail.com> <CAEf4BzaVdr_0kQo=+jPLN++PvcU6pwTjaPVEA880kgDN94TZYw@mail.gmail.com>
In-Reply-To: <CAEf4BzaVdr_0kQo=+jPLN++PvcU6pwTjaPVEA880kgDN94TZYw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 28 Sep 2024 13:22:02 +0800
Message-ID: <CAL+tcoCc+d6Tdc6dYAYNg3-zWvm6dxmGOYHOEA9zPmpi5L7=7Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: syscall_nrs: fix no previous prototype for "syscall_defines"
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andrii,

On Sat, Sep 28, 2024 at 7:08=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Sep 20, 2024 at 12:37=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > On Thu, Sep 19, 2024 at 11:17=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Sep 19, 2024 at 9:55=E2=80=AFPM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > In some environments (gcc treated as error in W=3D1, which is defau=
lt), if we
> > > > make -C samples/bpf/, it will be stopped because of
> > > > "no previous prototype" error like this:
> > > >
> > > >   ../samples/bpf/syscall_nrs.c:7:6:
> > > >   error: no previous prototype for =E2=80=98syscall_defines=E2=80=
=99 [-Werror=3Dmissing-prototypes]
> > > >    void syscall_defines(void)
> > > >         ^~~~~~~~~~~~~~~
> > >
> > > samples/bpf/ doesn't accept patches any more.
> > > If this samples/test is useful, refactor it to the test_progs framewo=
rk.
> > > Otherwise delete it.
> > >
> > > pw-bot: cr
> >
> > After reconsidering what Alexei said, I still feel we could take this
> > patch? It is because:
> > 1) the patch itself  is more of a fix instead of optimization,
> > 2)as long as samples/bpf exists in the kernel, we cannot easily let
> > it(issues) go and ignore it.
> >
> > Applying such a patch won't cause any further confusion, right? As we
> > can see, it's like a fix which does not introduce anything new here.
> >
> > What do you bpf maintainers think?
>
> I think it's fine to minimally fix the issue in samples/bpf, but I
> don't think this weirdly-looking extra declaration is the best fix.

Thanks for your reply.

>
> Can you mark that function static? Will that work?

Not really, it will print:
samples/bpf/syscall_nrs.c:7:13: error: =E2=80=98syscall_defines=E2=80=99 de=
fined but
not used [-Werror=3Dunused-function]
 static void syscall_defines(void)
             ^~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

> Or, as a plan B,
> use pragma to disable this warning, it's clearly "expected" in this
> case.

Yes, I admit the use in this function is "expected" like you said
because this file will be converted into a .h file. Could you kindly
show me more hints on how to disable the warning when compiling? I
tried to remove something like "-Wmissing-prototypes", but the warning
still happens.

Thanks,
Jason


Return-Path: <bpf+bounces-40627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECE898B194
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 02:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA2DB20C2E
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 00:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B9F4A28;
	Tue,  1 Oct 2024 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSe59XIj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1855136C
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727743936; cv=none; b=espRLvwfel6c5Er28thP5nLevydHggV3US44lJA7lXDGhCCbyi3sAjyuhRNCFvO1Z0ysixUhw29v3/9eTejuS9gQUjwD+Gvo2LMCqN/HtZe9//bAyj4eWl5WH0iK441+cgLFfVS+sfJlw4BB8AeaVJ0xijoklF9AukT8KLRJHa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727743936; c=relaxed/simple;
	bh=6wWRKA9CKe7tfRPw/6lZ6LXEQ2KP9Rsi+pyPYv87dHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNtNSOzJzITcqWXRvfb6FeyVBGLIIqJ9W6kCKVZ5ld3DvA86SWecYvuH8qPmSiKqHhLoU6PzTgLkD0vKve5fPyDl/P/zu2VT620RVxirWSbdGwLprFLIzsNlqfv0BBTCi3Ce6yvoditvw44N78KEGsMZizYGRSKOJfvTP9ou9FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSe59XIj; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-831e62bfa98so218796239f.1
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 17:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727743934; x=1728348734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDYZtDiJ2e+WHYBmMIkA/4o+ha176n0hKAr5kaz8mC8=;
        b=gSe59XIj6pinvl5xSjr3ESAVWgHwlPylXpnxBtJHEGardnUgz9b0fWBEcRvuL7G0GK
         HSc5F7W3cF8DUNpYTeYQtZqx6Diy/3Tat9+Il/s/ZqLNWUIpXtIduEvRVNPGZO7+iKBI
         rOzruXsLSX9W5SwlpskKFfofkAjtWUgAB92YorwfevsPRC9+EBKGCv21WqB2yHoVBisP
         gDALyjH14Jz0IsPAZZZE84NutcYWKNBtrYC/C5r35Y4/Ar8mRk2FaaKH3j6fBcyicxPd
         05h88G8wvbR5/0sBriOGBPJtsRfBT4vTSuilj51CTH35Gl0CICMyGKpawtUKv3xzuyaK
         EcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727743934; x=1728348734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDYZtDiJ2e+WHYBmMIkA/4o+ha176n0hKAr5kaz8mC8=;
        b=xR+gGnGOK42gj4ZD/G30ryvsXhip6d98KWs54CjCOjpOKWY/RzlSgpa5poQy6nMRzc
         lLQPVHBjbkXQX++0bRDxFy38I5od8Fe5L7inuGYQIHrOavkv6GFFgQrTI7H2+0CtmtcI
         l6qmCZcXiHheUj6/rkJufwxOD7lv8ul1S2FFuUr380fA5CtGufRkPCtVXod5G2ZMnlta
         y3zFBGN1Yf5x+moB+6lCNqHPKJ0UdeF0/4gQqEMRMxdqOengA3O0WZiygd6bIZ5kvP6P
         kbJXAUY2gRNy24adu20UkiL4YZiU+6Oxws8HZ4Gn6Z29mmfvd5AOiVv2K+PhIXFxi2tV
         PFWA==
X-Forwarded-Encrypted: i=1; AJvYcCU5v9Uin7geXQeRFMFoDKFi8Nn780cKwnDgWWvK3hIZ4FsUQfdlWrRnnG3YKM/7PZk8kSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp0hnwvsR8Kj6Qr+xebemHel9JP3Hc/Jo5GacTrpB6Ag6Anh2P
	VzMel1CmSoNSrjnQGpRsY8OVIGRF20JXxIITpaJ7rGQuSTsDsWaLxv4UpUNZ4K9cugN/omQJzBO
	m1ZecNK+tZCdtbrFEMS4c2uD2U2VK7w==
X-Google-Smtp-Source: AGHT+IHeF6U+QLZ8LEDyt6/aflCpDHj1jAnXKQmkz2bTqa46CQfCnryx1jUTXtlnHa9ZrjNWgLLwMCYBn0r7b0LgEfs=
X-Received: by 2002:a05:6e02:1a62:b0:3a0:933a:2a0a with SMTP id
 e9e14a558f8ab-3a3451691a8mr122442495ab.7.1727743934184; Mon, 30 Sep 2024
 17:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919195454.73358-1-kerneljasonxing@gmail.com>
 <CAADnVQJUd_1y-Ecgw3pgd6z2jw6=ZEm5wnxQqwUnhCobw752fQ@mail.gmail.com>
 <CAL+tcoDEpGq3NfYgavc=wwgsMch=L7mh9-0J8tWv2Sv1MWCH+w@mail.gmail.com>
 <CAEf4BzaVdr_0kQo=+jPLN++PvcU6pwTjaPVEA880kgDN94TZYw@mail.gmail.com>
 <CAL+tcoCc+d6Tdc6dYAYNg3-zWvm6dxmGOYHOEA9zPmpi5L7=7Q@mail.gmail.com> <CAEf4BzYdra11s9Y7_dE5ShqaUb9nRAunYJa+x3eaqJRtp73ieA@mail.gmail.com>
In-Reply-To: <CAEf4BzYdra11s9Y7_dE5ShqaUb9nRAunYJa+x3eaqJRtp73ieA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 1 Oct 2024 08:51:38 +0800
Message-ID: <CAL+tcoD3k7sPGXG_LfTRDrtXjBVQv+e+AXa9Q52WjdXrRERMPA@mail.gmail.com>
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

On Tue, Oct 1, 2024 at 6:06=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Sep 27, 2024 at 10:22=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > Hello Andrii,
> >
> > On Sat, Sep 28, 2024 at 7:08=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Sep 20, 2024 at 12:37=E2=80=AFPM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > >
> > > > On Thu, Sep 19, 2024 at 11:17=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Thu, Sep 19, 2024 at 9:55=E2=80=AFPM Jason Xing <kerneljasonxi=
ng@gmail.com> wrote:
> > > > > >
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > In some environments (gcc treated as error in W=3D1, which is d=
efault), if we
> > > > > > make -C samples/bpf/, it will be stopped because of
> > > > > > "no previous prototype" error like this:
> > > > > >
> > > > > >   ../samples/bpf/syscall_nrs.c:7:6:
> > > > > >   error: no previous prototype for =E2=80=98syscall_defines=E2=
=80=99 [-Werror=3Dmissing-prototypes]
> > > > > >    void syscall_defines(void)
> > > > > >         ^~~~~~~~~~~~~~~
> > > > >
> > > > > samples/bpf/ doesn't accept patches any more.
> > > > > If this samples/test is useful, refactor it to the test_progs fra=
mework.
> > > > > Otherwise delete it.
> > > > >
> > > > > pw-bot: cr
> > > >
> > > > After reconsidering what Alexei said, I still feel we could take th=
is
> > > > patch? It is because:
> > > > 1) the patch itself  is more of a fix instead of optimization,
> > > > 2)as long as samples/bpf exists in the kernel, we cannot easily let
> > > > it(issues) go and ignore it.
> > > >
> > > > Applying such a patch won't cause any further confusion, right? As =
we
> > > > can see, it's like a fix which does not introduce anything new here=
.
> > > >
> > > > What do you bpf maintainers think?
> > >
> > > I think it's fine to minimally fix the issue in samples/bpf, but I
> > > don't think this weirdly-looking extra declaration is the best fix.
> >
> > Thanks for your reply.
> >
> > >
> > > Can you mark that function static? Will that work?
> >
> > Not really, it will print:
> > samples/bpf/syscall_nrs.c:7:13: error: =E2=80=98syscall_defines=E2=80=
=99 defined but
> > not used [-Werror=3Dunused-function]
> >  static void syscall_defines(void)
> >              ^~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> >
> > > Or, as a plan B,
> > > use pragma to disable this warning, it's clearly "expected" in this
> > > case.
> >
> > Yes, I admit the use in this function is "expected" like you said
> > because this file will be converted into a .h file. Could you kindly
> > show me more hints on how to disable the warning when compiling? I
> > tried to remove something like "-Wmissing-prototypes", but the warning
> > still happens.
> >
>
> Grep for "#pragma GCC diagnostic ignored" uses in kernel sources.

Thanks a lot! It works. Let me re-post it to "fix" this issue.

Thanks,
Jason


Return-Path: <bpf+bounces-34304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7366B92C5AD
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 23:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E57B21F1C
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 21:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24874189F27;
	Tue,  9 Jul 2024 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3tMebB5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E6187858;
	Tue,  9 Jul 2024 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720561526; cv=none; b=hAQdyJoOwHI8mAcOH+ev1xtP+crWdpSaO7wjcKfBLnQq0Va8B6OKIvNGWsPKHioHvDk9ItrR0j0NbSGHitCdpW6Y6ael9ziqx2Gms5p8hY7tYtNWzXY1TqVJZbLwtkHAeShcD6ZXkpeCrIHPeHNBNVuof10PqJDxPNzDEWEUIEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720561526; c=relaxed/simple;
	bh=47GxMDApqitLxXRKtZWdfCsEzc5UQXsZKOKiv9YYi+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a55TJqR5f5zvpbNhCGsyWyLSn+3QJPqJ9ZeIeh+wjT4LLtpyne261o3i9hhDIi/m4N7swG0bIyAfFMw8vpi7D0myGyh4gVxrb1g+b/OMBa76/8bjIsZwOIK1mKFLSOA22SuBlextRrKoAI8aOctl655zdqsoeg2ppG34+tnW0sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3tMebB5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fbc09ef46aso7430575ad.3;
        Tue, 09 Jul 2024 14:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720561525; x=1721166325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47GxMDApqitLxXRKtZWdfCsEzc5UQXsZKOKiv9YYi+k=;
        b=j3tMebB5MoDXvVY60PcDFqvlUz6K5O7Gc4Tr7MzBVQC5oWE39a/n7z6dbrZS2M3bE1
         UEAdOd81uTMniqAKqoeV4KvlQTmjQ3Vp9YPHV78m4n+fVLkw86Dy6HvUG/kO0o/yIgkH
         7mZabH2UhtHctlOFheMqgRCt/lB9SCFtY2at6w2Vo/qaezPRhJM07H+jDpGYzx1Dj+q9
         94+H7zXeDyi5FyHBgQMAR0vufcoiKzCU1Z/sWEQNaVuVI97mIizg7i/1EH1XKcaNcu4V
         tlzOPuHvtjp7SCMIbIR2gEepUPS6CzKpY8ZjBJuC+fAVyKMfpyyc9rAiDkfGs25jV3ld
         MVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720561525; x=1721166325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47GxMDApqitLxXRKtZWdfCsEzc5UQXsZKOKiv9YYi+k=;
        b=NRzpZgm8RNPKkB4i3jxy+eGoYi3nQRu07zV0YfkEnuxtel/xOyekJOTaiYwObFUW8a
         RNQb8YqSm77UyRDx94rrcN4ZL2ufVEIl7AvTjVSHW//Rf3eVcQhSe1bbsNU4TUYQVoN4
         zdG6fB7+9n26wafDjOxFg2X+YTXSH381/F2QJVFDRvva8xeP3GYsnH3NYGI9DlhW6QBu
         a6UeTc+upLK1bW+U0eUHHUvH+KjKKBnxUeXl95A1sTcfk0DUUPkX703TYH8RHAc3bO9J
         EGkyaeOMvcQt4LmoP6nBiOSXvW8YRGYtxF0URT3cJ7bCbMM2xwMzDnQoT+tmB8iebfMA
         5A5w==
X-Forwarded-Encrypted: i=1; AJvYcCUt4u4bBCs4LGkePV7ISQVVJBNGHD/MbyvrGIiTGxI8SzE9f0DsjEsFElfb1PDHx1KeWigK8DRJuK0NmHmYEyuNeYY2nMmNrH+UvRIfW0BUhc07aBvdeS408TY/JDM11mFM97xULsiJ
X-Gm-Message-State: AOJu0Yw4dH0jNXxAiZRrUUUGLuEeGK0QGMwtjZBSG1Z4S58BQOlRyzjy
	DJMPMkn86neDVDuTFDoqfkozDHu+rMYgyZbIY6LPMGQmFSkJCj46a8aByIT0nqGI1mlFtHBtXbB
	Qpe83y9J0BJCeslI8cuJAfVIaPuo=
X-Google-Smtp-Source: AGHT+IHUizmw7NpbCiqLKbQaVrDWA2o1a/KVKzOKhSFdejm9AfKNAssR0ZR38DsceoyQ46T3d7QAOp3vAmy8h5pGUAI=
X-Received: by 2002:a05:6a20:da86:b0:1c0:e279:9db3 with SMTP id
 adf61e73a8af0-1c29820384amr3991994637.5.1720561524554; Tue, 09 Jul 2024
 14:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <20240701223935.3783951-5-andrii@kernel.org>
 <20240705153705.GA18551@redhat.com> <20240707144653.GB11914@redhat.com>
 <CAEf4BzYZCVNFQcVBPue4uom+StiCQA6ObR7Z-sKzcEZyTiSyRA@mail.gmail.com>
 <20240709184754.GA3892@redhat.com> <CAEf4BzZFJ-fQRJELsCYRjdPg8ezQwOOEhHbF9Nb5=4e8WE9bzQ@mail.gmail.com>
 <20240709211642.GA6162@redhat.com>
In-Reply-To: <20240709211642.GA6162@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2024 14:45:11 -0700
Message-ID: <CAEf4BzaXDLdBWJY1EzEbBSQhBo3UmF_bnuGGiE8cCSGvGBLZpA@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and lifetime management
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 2:33=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 07/09, Andrii Nakryiko wrote:
> >
> > On Tue, Jul 9, 2024 at 11:49=E2=80=AFAM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > > Yep, that would be unfortunate (just like SIGILL sent when uretprob=
e
> > > > detects "improper" stack pointer progression, for example),
> > >
> > > In this case we a) assume that user-space tries to fool the kernel an=
d
> >
> > Well, it's a bad assumption. User space might just be using fibers and
> > managing its own stack.
>
> Do you mean something like the "go" language?
>

No, I think it was C++ application. I think we have some uses of
fibers in which an application does its own user-space scheduling and
manages stack in user space. But it's basically the same class of
problems that you'd get with Go, yes.

> Yes, not supported. And from the kernel perspective it still looks as if
> user-space tries to fool the kernel. I mean, if you insert a ret-probe,
> the kernel assumes that it "owns" the stack, if nothing else the kernel
> has to change the ret-address on stack.
>
> I agree, this is not good. But again, what else the kernel can do in
> this case?

Not that I'm proposing this, but kernel could probably maintain a
lookup table keyed by thread stack pointer, instead of maintaining
implicit stack (but that would probably be more expensive). With some
limits and stuff this probably would work fine.

>
> > > Not really expected, and that is why the "TODO" comment in _unregiste=
r()
> > > was never implemented. Although the real reason is that we are lazy ;=
)
> >
> > Worked fine for 10+ years, which says something ;)
>
> Or may be it doesn't but we do not know because this code doesn't do
> uprobe_warn() ;)

sure :)

>
> Oleg.
>


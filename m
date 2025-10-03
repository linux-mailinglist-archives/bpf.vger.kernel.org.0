Return-Path: <bpf+bounces-70315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFCBBB787B
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 18:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E5F19C6E63
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCAD2BD5A1;
	Fri,  3 Oct 2025 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjeUCjps"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4265228DB56
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508708; cv=none; b=Kyd8tfABkDlge3KcpiIWmNF1f6UQnnKuN6In1qaDoaxVVB7IMNG3JMmHMVHmWoCnPLrRj8DxFt3jhp8UeVJ5q2Hlw9eYP4KOtiMQ1tEKZIr5gUiqD1goNP66xHJtbt+/1whlZ6YPnzOgOBUBDqIRVmcvufFJH0b356Wbr+fIPY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508708; c=relaxed/simple;
	bh=cnHKFDW3suOLqNZc/IzOJL+zwHa5UHgMn3MxBKRFyPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qm598NQSUk0jj5MCeM80Vmbh5H3+6WRfHVdk8sm94AwPNDzdFB4mK/nqhmLa4O8ZMEyHsOx2LxNNppA86iUNJUVXEeDqbDiem11B7ScOQTlGmsD/igZNOMhn4UW0Jn4q/QsoPc5sC7o8ZgoOWdhT4Lw9gMUcJgnXYllKfcVNcR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjeUCjps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF39AC4CEF7
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 16:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759508707;
	bh=cnHKFDW3suOLqNZc/IzOJL+zwHa5UHgMn3MxBKRFyPc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EjeUCjps2eOUK1cqsIq0ZlBHv+1goEFOaQYsvSz4dXcl2RFF6mvfQN7sWfOr14p83
	 sYC8N8FukC53EWOiX+IwxKyZk/67b1wvGsTegLb24kqDcG0pIm2AWMEaXycZtB4h54
	 IaPEv1GQxIVsj/FPrkqTLxb3B9PiEJw3fGfamFHp0hGFZVUZiPEd2+FcCAPWNmIoRT
	 C0sMUw+aoXBpvLIs0+nkUjq32dCG3w3EyJRWPN1bGdlDlw7mI9ZxGM7eMhSXbOg70z
	 Krf6RK+a9UD12GCwjnRCrgCTq/x1GB4YS+qoEdQZvetKnAuISYZ7twLP8YdzyIh2Oj
	 v0SnWKC36kKqg==
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so1437458f8f.0
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 09:25:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtp+N+VbG3D2oct5HO+Wp2F1Xd+x9Om5Y6vvA46cXXKRK/Vw2WRjwyzKEGfSUvyiQJXQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFtPGCXjSMkWSi7co5IHYKnLRbTS7o5WYa61kebmeme04a/Fo6
	sgkhtztrnDYL+HJbdzUqrgIt4x1QgTwIGLlyp+m1IlSsFtir0ST66rOY4iDRem24T+4BCTyEIsv
	tuS+JiCoWzt2byMS8QX7poUJi536rHIBFckyB+mSH
X-Google-Smtp-Source: AGHT+IEf+2y5XnJz6llQY0r9BsEEqWNo/dQEiKY0GDpAMZQw53/BgzklJv33Ppp0ADo3opKjKmoNz0+U8rv1/ZF9bgI=
X-Received: by 2002:a05:6000:2008:b0:3ec:dd26:6405 with SMTP id
 ffacd0b85a97d-42567164de1mr2673305f8f.26.1759508706270; Fri, 03 Oct 2025
 09:25:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com> <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
In-Reply-To: <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 3 Oct 2025 18:24:54 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com>
X-Gm-Features: AS18NWCjxnmUM-_G-6QSCL0tJFnM-pNuX_ajVOVOKygGYunSF2O3H1eByT4oL_I
Message-ID: <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, ast@kernel.org, 
	james.bottomley@hansenpartnership.com, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kys@microsoft.com, 
	daniel@iogearbox.net, andrii@kernel.org, wufan@linux.microsoft.com, 
	qmo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 4:36=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Thu, Oct 2, 2025 at 9:48=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrot=
e:
> > On Wed, Oct 1, 2025 at 11:37=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > With the lack of engagement from the BPF devs, I'm now at the point
> > > where I'm asking Linus to comment on the current situation around
> >
> > The lack of engagement is because Blaise has repeatedly sent patches
> > and ignored maintainer feedback and continued pushing a broken
> > approach.
>
> I'm sorry you feel that way, but that simply does not appear to be the
> case.  Looking at the archives from this year I see that Blase has
> proposed three different approaches[7][8][9] to verifying signed BPF
> programs, with each new approach a result of the feedback received.
>
> > The community, in fact, prioritized the signing work to unblock your us=
e-case.
>
> As mentioned previously, many times over, while your signature scheme
> may satisfy your own
> requirements, it does not provide a workable solution for use cases
> that have more stringent security requirements.  Blaise's latest
> approach, a small patch on top of your patchset, is an attempt to
> bridge that divide.
>
> > Blaise's implementation ...
>
> I think Blaise's response addressed your other comments rather well so
> I'll just skip over those points.
>
> > > To make it clear at the start, Blaise's patchset does not change,
> > > block, or otherwise prevent the BPF program signature scheme
> > > implemented in KP's patchset.  Blaise intentionally designed his
> > > patches such that the two signature schemes can coexist together in
> >
> > We cannot have multiple signature schemes, this is not the experience
> > we want for BPF users.
>
> In a perfect world there would be a singular BPF signature scheme
> which would satisfy all the different use cases, but the sad reality
> is that your signature scheme which Alexei sent to Linus during this
> merge window falls short of that goal.  Blaise's patch is an attempt
> to provide a solution for the BPF use cases that are not sufficiently
> addressed by your signature scheme.

I am failing to understand your security requirements.

>
> > > Relying on a light skeleton to verify the BPF program means that any
> > > verification failures in the light skeleton will be "lost" as there i=
s
> > > no way to convey an error code back to the user who is attempting the
> >
> > This is not correct, the error is propagated back if the loader program=
 fails.
>
> The loader BPF program which verifies the original BPF program, stored
> as a map as part of the light skeleton, is not executed as part of the
> original bpf() syscall issued from userspace.  The loader BPF program,
> and its verification code, is executed during a subsequent call.  It
> is possible for the PKCS7 signature on the loader to pass, with the
> kernel reporting a successful program load, the LSM authorizing the
> load based on a good signature, and audit recording a successful
> signature verification yet the loader could still fail the integrity
> check on the original BPF program, leaving the system with a false
> positive on the BPF program load and a "questionable" audit trail.
>
> > You keep mentioning having visibility  in the LSM code and I again
> > ask, to implement what specific security policy and there is no clear
> > answer?
>
> No one policy can satisfy the different security requirements of all
> known users, simply look at all of the LSMs (including the BPF LSM)
> which support different security policies as a real world example of
> this.  Even the presence of the LSM framework as an abstract layer is
> an admission that no one policy, or model, solves all problems.
> Instead, the goal is to ensure we have mechanisms in place which are
> flexible enough to support a number of different policies and models.

Please share concrete policies you would like to implement, this is very va=
gue.

- KP

>
> [7] https://lore.kernel.org/all/20250109214617.485144-1-bboscaccy@linux.m=
icrosoft.com/
> [8] https://lore.kernel.org/linux-security-module/20250321164537.16719-1-=
bboscaccy@linux.microsoft.com/
> [9] https://lore.kernel.org/linux-security-module/87sei58vy3.fsf@microsof=
t.com/
>
> --
> paul-moore.com


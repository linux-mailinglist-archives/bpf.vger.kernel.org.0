Return-Path: <bpf+bounces-17242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB5680AE4A
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 21:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986D51C20898
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 20:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E7B46BBF;
	Fri,  8 Dec 2023 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ORyh82rA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D1D1720
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 12:51:59 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso2521714276.2
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 12:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702068719; x=1702673519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q69Rd2ZLQxWoA6Uc/juMGm2JEJPvLMOIaXgd+4m95hQ=;
        b=ORyh82rAIo4e/3YM9ItpbAdt50d4vdwXDCfyhjQyKklbZJhNHw6O8a9knj1eB/r5eM
         GxVRqoJPHhK/qonWey5K+QyOxKOAJ1NXT2HmJPcyrINCdqdqRpMzBP6Ym80LhDPF7+yw
         C/+Eg7qXhkEgsaiJyjk3QW9cXF8jUTd/vWDzBnRttJSfXeoEbjjTaGF6Af/jdB+W4RVu
         elKRZeSUdR96cgbdU+q6B1WWe8sfT0bvlXoH+nD9coy9U/ZF++r4r9y8Oe0JAdL3GLpn
         DyzTCY5Vjyg8u15zPiPPdFr/zprs3O5+p2sMtUwPs8Uyb3S8gJKVWZZ6kdlovPtgt30S
         WNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702068719; x=1702673519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q69Rd2ZLQxWoA6Uc/juMGm2JEJPvLMOIaXgd+4m95hQ=;
        b=P42TQt1P88nfRnVLnNv16kag9fjGRjnY3J3gh/hAfd6WqKG6mHhG/rIe3VdpEj98Gb
         03pnALF8Xo2nuzE0pZDj2aV5ExnzEVNqn18AOTOMBBTgJlRT3YmDlhIHRvDi4qsnnCYK
         QvgxSdbaIgd7QqfZQDHCBsMB/sSUykcVAYSze8VWHGpaJRWQVC4YDm6mTo6AUOVel6a4
         AcO12KdAlTXyWofLuZMbTIssHr8ZbHTnQ7vZwDgQnbk3trZARodfxH+i2EcLFc4snaxJ
         WtP/eNWU96XPopVSQ8dtoMNbbVh4U2Q413vFflAhtWVHowbqrUEIuOx9YwrqEhqXAWZJ
         +2sQ==
X-Gm-Message-State: AOJu0YzgNZSkOmFpDpbbDEfzqs/YZWmFOYJjg0kYRESAK0v3QXe5apcT
	53fprYVIPX36F//9V81fBn/uDRt//26mKYIHI5Ng
X-Google-Smtp-Source: AGHT+IGTzCymo9qSR91Ej0WgrRFEVb3pLiDK8nnRh5O5xjOkCCKtblU91SjomPzBo+3IFIf6dg+ncqRXupj58wTpqgY=
X-Received: by 2002:a5b:70d:0:b0:db5:3b54:5de7 with SMTP id
 g13-20020a5b070d000000b00db53b545de7mr493619ybq.3.1702068718762; Fri, 08 Dec
 2023 12:51:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110222038.1450156-1-kpsingh@kernel.org> <20231110222038.1450156-6-kpsingh@kernel.org>
 <202312080934.6D172E5@keescook> <CAHC9VhTOze46yxPUURQ+4F1XiSEVhrTsZvYfVAZGLgXj0F9jOA@mail.gmail.com>
 <CAHC9VhRguzX9gfuxW3oC0pOpttJ+xE6Q84Y70njjchJGawpXdg@mail.gmail.com> <202312081019.C174F3DDE5@keescook>
In-Reply-To: <202312081019.C174F3DDE5@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Dec 2023 15:51:47 -0500
Message-ID: <CAHC9VhRNSonUXwneN1j0gpO-ky_YOzWsiJo_g+b0P86c9Am8WQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To: Kees Cook <keescook@chromium.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 1:22=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
> On Fri, Dec 08, 2023 at 12:55:16PM -0500, Paul Moore wrote:
> > On Fri, Dec 8, 2023 at 12:46=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Fri, Dec 8, 2023 at 12:36=E2=80=AFPM Kees Cook <keescook@chromium.=
org> wrote:
> > > > On Fri, Nov 10, 2023 at 11:20:37PM +0100, KP Singh wrote:
> > > > > [...]
> > > > > ---
> > > > >  security/Kconfig | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > >
> > > > Did something go missing from this patch? I don't see anything depe=
nding
> > > > on CONFIG_SECURITY_HOOK_LIKELY (I think this was working in v7, tho=
ugh?)
> >
> > I guess while I'm at it, and for the sake of the mailing list, it is
> > worth mentioning that I voiced my dislike of the
> > CONFIG_SECURITY_HOOK_LIKELY Kconfig option earlier this year yet it
> > continues to appear in the patchset.  It's hard to give something
> > priority when I do provide some feedback and it is apparently ignored.
>
> The CONFIG was created specifically to address earlier concerns about
> not being able to choose whether to use this performance improvement. :P
> What's the right direction forward?

Are you honestly uncertain after our discussions today?  I'll be
honest and say that I'm a little confused as I thought I made it very
clear when I told you to just be patient off-list, and reminded you in
this thread that the patchset was in my review queue and I will get to
it once it bubbles to the top.  I don't know what else to say here ...
?

As far as the CONFIG_SECURITY_HOOK_LIKELY patch, looking back at my
comments from September [1] there is a clear statement that I am not
in favor of this patch along with a brief explanation as to why:

 "I'm not in favor of adding a Kconfig option for something
  like this.  If you have an extremely well defined use case
  then you can probably do the work to figure out the
  "correct" value for the tunable, but for a general purpose
  kernel build that will have different LSMs active, a
  variety of different BPF LSM hook implementations at
  different times, etc. there is little hope to getting this
  right."

... and that was back when the knob actually did something, as you
pointed out in this thread, the v8 version of this patch doesn't
appear to do anything, which is really baffling and not a good sign.
As far as what to do about this patch, in our off-list discussion I
asked you and KP to refrain from respinning the patchset just to get
rid of this patch, but keep it in mind for future submissions.

Hopefully by repeating the important bits of the conversation you now
understand that there is nothing you can do at this moment to speed my
review of this patchset, but there are things you, and KP, can do in
the future if additional respins are needed.  However, if you are
still confused, it may be best to go do something else for a bit and
then revisit this email because there is nothing more that I can say
on this topic at this point in time.

[1] https://lore.kernel.org/linux-security-module/CAHC9VhSSX0KRuWRURUmt2tUi=
s6fbbmozUbcoeAPkLRmfR2jqAg@mail.gmail.com/

--=20
paul-moore.com


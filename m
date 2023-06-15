Return-Path: <bpf+bounces-2680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC97322DE
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 00:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF033281548
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 22:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21AB6106;
	Thu, 15 Jun 2023 22:48:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7508B7464
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 22:48:52 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446021FF7;
	Thu, 15 Jun 2023 15:48:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-982a99fda0dso152870766b.1;
        Thu, 15 Jun 2023 15:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686869329; x=1689461329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBGpFuGRUhV5pr54u8KylWf9NrEzngRZbN+P89tTIS0=;
        b=lI1k1VXdjAH8r9QWL5oFe3y0Ie0WQCeGy+gS05PBn9TB+5mt+1gC8zbipz6FQixBdW
         hOLQlKzvQjjPep+JTH859k/z1R5kvxDcUDDZDLEZWFF3IfZ7Oc2i7D+O584BNvfAM2+n
         wWoIGXqUnE0DhMqrAbqMN+Da79DU7/9DnOXeGupZZV7l2yqoXWLNOeauhfGjNLUK0lON
         AAENXpiCYZLdyZLb6vOzRggOs5oTgX7n9FIWjoLwVMZolC1Sj9wPo2+sitoIl6vpycIC
         Zhzdr0X049bbI8rHL3YO4nc5r1V67tP5ZO2nDw9ES+hkx7D+b8wW68bqcQB/Y3so3k0n
         XWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686869329; x=1689461329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBGpFuGRUhV5pr54u8KylWf9NrEzngRZbN+P89tTIS0=;
        b=U7rAGvoYMn7fqako9vZoXqYbtFo3bxzprGurSVm+3U1o/iaqbHWAKf4RtdYJzHrDQH
         qZKksupBrT69Obf36D8lN+zBwNq3vziYDvNoZmXiIi1tAwxOy0Yu+eWB0n6Hc2/kI1QK
         YA8BADgtBatXc5Mh0cgS0rTWU94RcscZdpKQF5IE4wp7g3JIJc/EBoNj/X/mW6i1b38L
         AhBOWVryr1QzPxatFV2WcDQkNLoK0CD8KqikRso3OyOGG1dQVXttp46dZwYbWQNBIbSz
         0PeU67l1M6u8D2UPpumA0WXvunwBHd1wMNhnMQf5tdAiuEwuOgwkNIzDfyPXQ1HO/mt7
         4/qw==
X-Gm-Message-State: AC+VfDzjJTvKC99MlyAL+QrRuxMaqG43eECna1yaU+9JifeExHhDqZXX
	2o6RzR4Il3HwivobV1N8bEu3oQ80H2+2I0H2w3s=
X-Google-Smtp-Source: ACHHUZ6yr8QuWOXa/V8SnguyEEf3r8lrc17r3X8ZcQcGr7TTE4sfH/IoMEa4778qQkvNfN3Fgc0l2Jh54TieEGVMVVw=
X-Received: by 2002:a17:907:1c9c:b0:960:d9d:ffb5 with SMTP id
 nb28-20020a1709071c9c00b009600d9dffb5mr390112ejc.41.1686869328485; Thu, 15
 Jun 2023 15:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <CAEiveUdNrHfVXzF_6ogChifKyje3kA07pd8mpP+s24AEbKD7Cg@mail.gmail.com>
 <CAEf4BzaDDqfODPS9MM5twXiXdDCAMs2U2-XK+gGPuSpnGFh=pQ@mail.gmail.com>
 <CAEiveUeDLr00SjyU=SMSc4XbHSA6LTn4U2DHr12760rbo5WqSw@mail.gmail.com>
 <CAEf4BzaQSKBJ_+8HaHdBHa9_guL_QCVgHZHb6jpCqv6CboCniQ@mail.gmail.com>
 <CAEiveUdU7On9c27iek2rRmqSLFTKduNUtjEAD0iaCPQ4wZoH6Q@mail.gmail.com> <20230614-geruch-verzug-db3903a52383@brauner>
In-Reply-To: <20230614-geruch-verzug-db3903a52383@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jun 2023 15:48:36 -0700
Message-ID: <CAEf4BzawogpzENKC=KYk+mvc375ZF8Rs0gnu5grOywUsM0AV+Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Christian Brauner <brauner@kernel.org>
Cc: Djalal Harouni <tixxdz@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org, 
	kernel-team@meta.com, Sargun Dhillon <sargun@sargun.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 14, 2023 at 2:39=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Jun 14, 2023 at 02:23:02AM +0200, Djalal Harouni wrote:
> > On Tue, Jun 13, 2023 at 12:27=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Jun 12, 2023 at 5:02=E2=80=AFAM Djalal Harouni <tixxdz@gmail.=
com> wrote:
> > > >
> > > > On Sat, Jun 10, 2023 at 12:57=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jun 9, 2023 at 3:30=E2=80=AFPM Djalal Harouni <tixxdz@gma=
il.com> wrote:
> > > > > >
> > > > > > Hi Andrii,
> > > > > >
> > > > > > On Thu, Jun 8, 2023 at 1:54=E2=80=AFAM Andrii Nakryiko <andrii@=
kernel.org> wrote:
> > > > > > >
> > > > > > > ...
> > > > > > > creating new BPF objects like BPF programs, BPF maps, etc.
> > > > > >
> > > > > > Is there a reason for coupling this only with the userns?
> > > > >
> > > > > There is no coupling. Without userns it is at least possible to g=
rant
> > > > > CAP_BPF and other capabilities from init ns. With user namespace =
that
> > > > > becomes impossible.
> > > >
> > > > But these are not the same: delegate full cap vs delegate an fd mas=
k?
> > >
> > > What FD mask are we talking about here? I don't recall us talking
> > > about any FD masks, so this one is a bit confusing without more
> > > context.
> >
> > Ah err, sorry yes referring to fd token (which I assumed is a mask of
> > allowed operations or something like that).
> >
> > So I want the possibility to delegate the fd token in the init userns.
> >
> > > >
> > > > One can argue unprivileged in init userns is the same privileged in
> > > > nested userns
> > > > Getting to delegate fd in init userns, then in nested ones seems lo=
gical...
> > >
> > > Again, sorry, I'm not following. Can you please elaborate what you me=
an?
> >
> > I mean can we use the fd token in the init user namespace too? not
> > only in the nested user namespaces but in the first one? Sorry I
> > didn't check the code.
> >

[...]

> >
> > > >
> > > > Having the fd or "token" that gives access rights pinned in two
> > > > separate bpffs mounts seems too much, it crosses namespaces (mount,
> > > > userns etc), environments setup by privileged...
> > >
> > > See above, there is nothing namespaceable about BPF itself, and BPF
> > > token as well. If some production setup benefits from pinning one BPF
> > > token in multiple places, I don't see the problem with that.
> > >
> > > >
> > > > I would just make it per bpffs mount and that's it, nothing more. I=
f a
> > > > program wants to bind mount it somewhere else then it's not a bpf
> > > > problem.
> > >
> > > And if some application wants to pin BPF token, why would that be BPF
> > > subsystem's problem as well?
> >
> > The credentials, capabilities, keyring, different namespaces, etc are
> > all attached to the owning user namespace, if the BPF subsystem goes
> > its own way and creates a token to split up CAP_BPF without following
> > that model, then it's definitely a BPF subsystem problem...  I don't
> > recommend that.
> >
> > Feels it's going more of a system-wide approach opening BPF
> > functionality where ultimately it clashes with the argument: delegate
> > a subset of BPF functionality to a *trusted* unprivileged application.
> > My reading of delegation is within a container/service hierarchy
> > nothing more.
>
> You're making the exact arguments that Lennart, Aleksa, and I have been
> making in the LSFMM presentation about this topic. It's even recorded:

Alright, so (I think) I get a pretty good feel now for what the main
concerns are, and why people are trying to push this to be an FS. And
it's not so much that BPF token grants bpf() syscall usage to unpriv
(but trusted) workloads or that BPF itself is not namespaceable. The
main worry is that BPF token, once issues, could be
illegally/uncontrollably passed outside of container, intentionally or
not. And by having this association with mount namespace (through BPF
FS) we automatically limit the sharing to only contain that has access
to that BPF FS.

So I agree that it makes sense to have this mount namespace
association, but I also would like to keep BPF token to be a separate
entity from BPF FS itself, and have the ability to have multiple
different BPF tokens exposed in a single BPF FS instance. I think the
latter is important.

So how about this slight modification: when a BPF token is created
using BPF_TOKEN_CREATE command, the user has to provide an FD for
"associated" BPF FS instance (superblock). What that does is allows
BPF token to be created with BPF FS and/or mount namespace association
set in stone. After that BPF token can only be pinned in that BPF FS
instance and cannot leave the boundaries of that mount namespace
(specific details to be worked out, this is new area for me, so I'm
sorry if I'm missing nuances).

What this slight tweak gives us is that we can still have multiple BPF
token instances within a single BPF FS. It is still pinnable/gettable
through common bpf() syscall's BPF_OBJ_PIN/BPF_OBJ_GET commands. You
still can have more nuances file permission and getting BPF token can
be controlled further through LSM. Also we still get to use an
extensible and familiar (to BPF users) bpf_attr binary approach.
Basically, it is very much native to BPF subsystem, but it is mount
namespace-bound like was requested by proponents of merging BPF token
and BPF FS together.

I assume that this BPF FS fd can be fetched using fsopen() or fspick()
syscalls, is that right?

WDYT? Does that sound like it would address all the above concerns?
Please point to any important details I might be missing (as I
mentioned, very unfamiliar territory).

>
> https://youtu.be/4CCRTWEZLpw?t=3D1546
>
> So we fully agree with you here.

I actually just rewatched that entire discussion. :) And after talking
about BPF token at length in the halls of the conference and email
discussions on this patch set, it was very useful to relisten (again)
all the finer points that were made back then. Thanks for the
remainder and the link.


Return-Path: <bpf+bounces-3503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1F473EE6A
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 00:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5451C209D8
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 22:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E6815AF0;
	Mon, 26 Jun 2023 22:09:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33E15AC5
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 22:09:06 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F01746B7;
	Mon, 26 Jun 2023 15:09:04 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f766777605so5093102e87.1;
        Mon, 26 Jun 2023 15:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687817343; x=1690409343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o88uEek2qt8JTqJBZtm5tLmkocNkZHgPWP8mwmJ9uNE=;
        b=WmR8YLURE18f1WqA9wat0mhH6uBLHQL2nG0d56bG2tk4Nw0N0QxG6oJbAm6ue/njH4
         7xvBt1b5b+zyjgYeGe2/OBEoXxyAbk4oy1ZwwJuFXpTvosBCGc2LhvapOBAqWx1Oc0Kc
         8e0zsyxBEkR6UudY6un7e00xqLXeibxEUGnPusVRmncz4KbFi0hgRf+mzX6JcSUAas/W
         oB1qmXsvdv1+dr65+ZBlonO57piotn89pLChjKqscGwRR6Rh8sNODXUnQ1DOXXjbqIRW
         v52L8riZVrs1zaGwnJFqgtvMPpJCmyHNxoDMU4UBIwRTaLXFfQPvx+JwhYHXg8XYM9ta
         o0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687817343; x=1690409343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o88uEek2qt8JTqJBZtm5tLmkocNkZHgPWP8mwmJ9uNE=;
        b=fJxsn11U/xmzhh3r+pIEUdbY/hpgs+bDNKHJz7XVj85YnFHOwONqx8E6piJciRlJja
         MLwk7ofkEOmgdeQJi17kfCDMHjGHZAKplYN7GGPRBTfUJcyWVK3JDq+f88fy22thZGsA
         EN4WnSGWQTgyqC7+6p/fg91l1w3phdu1BcxBZonxkBcIsbYEKe/WYzcWWlCQ2ck4aZ+4
         25mI24RYrADp6ieMDST59VAL8hwrOP7L4MUyTsJvAPW0FVJEuMGcWW7kTGodXhnn8YP9
         xuMbDfgnSCW42aqSHqpViuEeX1XixDQiZVVKGubeRTmWhuN7MoRu17f4GjhsRaY1YrFJ
         +NKQ==
X-Gm-Message-State: AC+VfDxuZlPBCYDe3OBnSUlgEH1XuD8gGmKjoRdVydXZH4fLpkK0CA8K
	s7Wxi+dKyx7uKR0rVxklZMhth/6EqIGJgzHyvBQ=
X-Google-Smtp-Source: ACHHUZ4o/ABHT2qoh5j+2KynUtRADAjdNCY38deVgx/cEaVPp9k+WeEwB1rf3un730VIi0sYMlkh5RNC2dSH3fgmug8=
X-Received: by 2002:a05:6512:1cd:b0:4f9:573a:689d with SMTP id
 f13-20020a05651201cd00b004f9573a689dmr9407336lfp.37.1687817342393; Mon, 26
 Jun 2023 15:09:02 -0700 (PDT)
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
 <CAEiveUdU7On9c27iek2rRmqSLFTKduNUtjEAD0iaCPQ4wZoH6Q@mail.gmail.com>
 <20230614-geruch-verzug-db3903a52383@brauner> <CAEf4BzawogpzENKC=KYk+mvc375ZF8Rs0gnu5grOywUsM0AV+Q@mail.gmail.com>
 <8f291af1-a91f-4c6f-ee19-1998cdb7ce1d@iogearbox.net>
In-Reply-To: <8f291af1-a91f-4c6f-ee19-1998cdb7ce1d@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Jun 2023 15:08:49 -0700
Message-ID: <CAEf4BzZ5uDcc2CjYyguRQB+ghuu-MspM=G9rPKUXffb9cXme9g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Christian Brauner <brauner@kernel.org>, Djalal Harouni <tixxdz@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
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

On Fri, Jun 23, 2023 at 3:18=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 6/16/23 12:48 AM, Andrii Nakryiko wrote:
> > On Wed, Jun 14, 2023 at 2:39=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> >> On Wed, Jun 14, 2023 at 02:23:02AM +0200, Djalal Harouni wrote:
> >>> On Tue, Jun 13, 2023 at 12:27=E2=80=AFAM Andrii Nakryiko
> >>> <andrii.nakryiko@gmail.com> wrote:
> >>>> On Mon, Jun 12, 2023 at 5:02=E2=80=AFAM Djalal Harouni <tixxdz@gmail=
.com> wrote:
> >>>>> On Sat, Jun 10, 2023 at 12:57=E2=80=AFAM Andrii Nakryiko
> >>>>> <andrii.nakryiko@gmail.com> wrote:
> >>>>>> On Fri, Jun 9, 2023 at 3:30=E2=80=AFPM Djalal Harouni <tixxdz@gmai=
l.com> wrote:
> >>>>>>>
> >>>>>>> Hi Andrii,
> >>>>>>>
> >>>>>>> On Thu, Jun 8, 2023 at 1:54=E2=80=AFAM Andrii Nakryiko <andrii@ke=
rnel.org> wrote:
> >>>>>>>>
> >>>>>>>> ...
> >>>>>>>> creating new BPF objects like BPF programs, BPF maps, etc.
> >>>>>>>
> >>>>>>> Is there a reason for coupling this only with the userns?
> >>>>>>
> >>>>>> There is no coupling. Without userns it is at least possible to gr=
ant
> >>>>>> CAP_BPF and other capabilities from init ns. With user namespace t=
hat
> >>>>>> becomes impossible.
> >>>>>
> >>>>> But these are not the same: delegate full cap vs delegate an fd mas=
k?
> >>>>
> >>>> What FD mask are we talking about here? I don't recall us talking
> >>>> about any FD masks, so this one is a bit confusing without more
> >>>> context.
> >>>
> >>> Ah err, sorry yes referring to fd token (which I assumed is a mask of
> >>> allowed operations or something like that).
> >>>
> >>> So I want the possibility to delegate the fd token in the init userns=
.
> >>>
> >>>>>
> >>>>> One can argue unprivileged in init userns is the same privileged in
> >>>>> nested userns
> >>>>> Getting to delegate fd in init userns, then in nested ones seems lo=
gical...
> >>>>
> >>>> Again, sorry, I'm not following. Can you please elaborate what you m=
ean?
> >>>
> >>> I mean can we use the fd token in the init user namespace too? not
> >>> only in the nested user namespaces but in the first one? Sorry I
> >>> didn't check the code.
> >>>
> >
> > [...]
> >
> >>>
> >>>>> Having the fd or "token" that gives access rights pinned in two
> >>>>> separate bpffs mounts seems too much, it crosses namespaces (mount,
> >>>>> userns etc), environments setup by privileged...
> >>>>
> >>>> See above, there is nothing namespaceable about BPF itself, and BPF
> >>>> token as well. If some production setup benefits from pinning one BP=
F
> >>>> token in multiple places, I don't see the problem with that.
> >>>>
> >>>>>
> >>>>> I would just make it per bpffs mount and that's it, nothing more. I=
f a
> >>>>> program wants to bind mount it somewhere else then it's not a bpf
> >>>>> problem.
> >>>>
> >>>> And if some application wants to pin BPF token, why would that be BP=
F
> >>>> subsystem's problem as well?
> >>>
> >>> The credentials, capabilities, keyring, different namespaces, etc are
> >>> all attached to the owning user namespace, if the BPF subsystem goes
> >>> its own way and creates a token to split up CAP_BPF without following
> >>> that model, then it's definitely a BPF subsystem problem...  I don't
> >>> recommend that.
> >>>
> >>> Feels it's going more of a system-wide approach opening BPF
> >>> functionality where ultimately it clashes with the argument: delegate
> >>> a subset of BPF functionality to a *trusted* unprivileged application=
.
> >>> My reading of delegation is within a container/service hierarchy
> >>> nothing more.
> >>
> >> You're making the exact arguments that Lennart, Aleksa, and I have bee=
n
> >> making in the LSFMM presentation about this topic. It's even recorded:
> >
> > Alright, so (I think) I get a pretty good feel now for what the main
> > concerns are, and why people are trying to push this to be an FS. And
> > it's not so much that BPF token grants bpf() syscall usage to unpriv
> > (but trusted) workloads or that BPF itself is not namespaceable. The
> > main worry is that BPF token, once issues, could be
> > illegally/uncontrollably passed outside of container, intentionally or
> > not. And by having this association with mount namespace (through BPF
> > FS) we automatically limit the sharing to only contain that has access
> > to that BPF FS.
>
> +1
>
> > So I agree that it makes sense to have this mount namespace
> > association, but I also would like to keep BPF token to be a separate
> > entity from BPF FS itself, and have the ability to have multiple
> > different BPF tokens exposed in a single BPF FS instance. I think the
> > latter is important.
> >
> > So how about this slight modification: when a BPF token is created
> > using BPF_TOKEN_CREATE command, the user has to provide an FD for
> > "associated" BPF FS instance (superblock). What that does is allows
> > BPF token to be created with BPF FS and/or mount namespace association
> > set in stone. After that BPF token can only be pinned in that BPF FS
> > instance and cannot leave the boundaries of that mount namespace
> > (specific details to be worked out, this is new area for me, so I'm
> > sorry if I'm missing nuances).
>
> Given bpffs is not a singleton and there can be multiple bpffs instances
> in a container, couldn't we make the token a special bpffs mount/mode?
> Something like single .token file in that mount (for example) which can
> be opened and the fd then passed along for prog/map creation? And given
> the multiple mounts, this also allows potentially for multiple tokens?
> In other words, this is already set up by the container manager when it
> sets up mounts rather than later, and the regular bpffs instance is sth
> separate from all that. Meaning, in your container you get the usual
> bpffs instance and then one or more special bpffs instances as tokens
> at different paths (and in future they could unlock different subset of
> bpf functionality for example).

Just from a technical point of view we could do that. But I see a lot
of value in keeping BPF token creation as part of BPF syscall and its
API. And the main issue, I believe, was not allowing BPF token to
escape the intended container, which should be more than covered by
BPF_TOKEN_CREATE pinning a token into provided BPF FS instance and not
allowing it to be repinned after that.

>
> Thanks,
> Daniel


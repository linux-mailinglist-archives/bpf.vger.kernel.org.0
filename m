Return-Path: <bpf+bounces-666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A867705599
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 20:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5668C1C20EDB
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACA120998;
	Tue, 16 May 2023 18:02:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BDC101CF
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 18:02:58 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABCB59FB
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 11:02:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso2204818a12.1
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 11:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684260174; x=1686852174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4peAVBcL5i5doSRvVv+WdPIVZ1MSX5m0hQglQHGBRA=;
        b=EOlGfNHuA334mUm/YEBsSzYNejtysCo7s868coKjhpjUpYVgTcAHPG5706hCUp/dne
         fBAiDUyLm0mbticOJt/kl5tQxN1qrtS3X1QxwOVBUNGi1zqENnCgXzdMKAqV73balCCi
         bE4joT+1Ny2p3KHo7+DB5hefKBlyUOQ2VHe5mZKS3CjTpo+qZjYIguRRlc6hmpabyc4M
         UE0OdS49TQhJO2gTCNj0Kcl7s2By9aiwcli8VPsuZAxdFF4DPlJG0uNJCwHCdt2sr0kY
         oRTjqMw4paYball8bs+fJJiwhUUI8zSb8VV8xifI3NHTgxSl21YjJqjS5ezTStr8TJW3
         9wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684260174; x=1686852174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4peAVBcL5i5doSRvVv+WdPIVZ1MSX5m0hQglQHGBRA=;
        b=lalzNwOWaAf4gePor2jcK5OVQJ/G5oLFRSzyOAC5DuiTZFBZDjnk2iQiTg1FEwdz95
         rdDGSDdWMxFAmPs0T/5t1KSqTKHLWriRcyPyCk3WzQ50EupOksXvDvAGTZR5JVvuEepP
         t/usp3oci+wYRq1fpX2TGPepN3xXiwSauKi1tRioCoxqPt8tbDTNw6QXwgWUwOJ/Y7+q
         JDMxwfzGsQxV3ngw9ukz4/uNh0EyijQrC7YD2YuWkVPIRRJ+cj6WTgJjU3VDMNHhSvq6
         bjl16iCyzAhN94OGSQtuG7azoaUgLiouVYWgiujaWBYp6B3LjvyXGeW5yy2s4NfESFKF
         +grQ==
X-Gm-Message-State: AC+VfDzzINJauMBwtjsgisBNK6DNluYqg/7SF61i7mkQWYlritlGkWsd
	JhV8bN5x4c09whCJgW6sykqgl8+5/F5ZXI8Q7gGJyhJ22seY9A==
X-Google-Smtp-Source: ACHHUZ67CAuWPIONMWv/f6uG9S0rFft6iOW0k/3jYC0ImWIMXmdRnuMCoUMJAdZWjTeOIW23LYBqxV2VZBJrTnl0n78=
X-Received: by 2002:a17:907:7d88:b0:967:2595:b099 with SMTP id
 oz8-20020a1709077d8800b009672595b099mr24299962ejc.28.1684260174119; Tue, 16
 May 2023 11:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230516001348.286414-1-andrii@kernel.org> <20230516001348.286414-2-andrii@kernel.org>
 <20230516-briefe-blutzellen-0432957bdd15@brauner>
In-Reply-To: <20230516-briefe-blutzellen-0432957bdd15@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 May 2023 11:02:42 -0700
Message-ID: <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: support O_PATH FDs in BPF_OBJ_PIN and
 BPF_OBJ_GET commands
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, cyphar@cyphar.com, 
	lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 2:07=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, May 15, 2023 at 05:13:46PM -0700, Andrii Nakryiko wrote:
> > Current UAPI of BPF_OBJ_PIN and BPF_OBJ_GET commands of bpf() syscall
> > forces users to specify pinning location as a string-based absolute or
> > relative (to current working directory) path. This has various
> > implications related to security (e.g., symlink-based attacks), forces
> > BPF FS to be exposed in the file system, which can cause races with
> > other applications.
> >
> > One of the feedbacks we got from folks working with containers heavily
> > was that inability to use purely FD-based location specification was an
> > unfortunate limitation and hindrance for BPF_OBJ_PIN and BPF_OBJ_GET
> > commands. This patch closes this oversight, adding path_fd field to
>
> Cool!
>
> > BPF_OBJ_PIN and BPF_OBJ_GET UAPI, following conventions established by
> > *at() syscalls for dirfd + pathname combinations.
> >
> > This now allows interesting possibilities like working with detached BP=
F
> > FS mount (e.g., to perform multiple pinnings without running a risk of
> > someone interfering with them), and generally making pinning/getting
> > more secure and not prone to any races and/or security attacks.
> >
> > This is demonstrated by a selftest added in subsequent patch that takes
> > advantage of new mount APIs (fsopen, fsconfig, fsmount) to demonstrate
> > creating detached BPF FS mount, pinning, and then getting BPF map out o=
f
> > it, all while never exposing this private instance of BPF FS to outside
> > worlds.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h            |  4 ++--
> >  include/uapi/linux/bpf.h       |  5 +++++
> >  kernel/bpf/inode.c             | 16 ++++++++--------
> >  kernel/bpf/syscall.c           |  8 +++++---
> >  tools/include/uapi/linux/bpf.h |  5 +++++
> >  5 files changed, 25 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 36e4b2d8cca2..f58895830ada 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2077,8 +2077,8 @@ struct file *bpf_link_new_file(struct bpf_link *l=
ink, int *reserved_fd);
> >  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
> >  struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
> >
> > -int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
> > -int bpf_obj_get_user(const char __user *pathname, int flags);
> > +int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname=
);
> > +int bpf_obj_get_user(int path_fd, const char __user *pathname, int fla=
gs);
> >
> >  #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
> >  #define DEFINE_BPF_ITER_FUNC(target, args...)                        \
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 1bb11a6ee667..db2870a52ce0 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1420,6 +1420,11 @@ union bpf_attr {
> >               __aligned_u64   pathname;
> >               __u32           bpf_fd;
> >               __u32           file_flags;
> > +             /* same as dirfd in openat() syscall; see openat(2)
> > +              * manpage for details of dirfd/path_fd and pathname sema=
ntics;
> > +              * zero path_fd implies AT_FDCWD behavior
> > +              */
> > +             __u32           path_fd;
> >       };
>
> So 0 is a valid file descriptor and can trivially be created and made to
> refer to any file. Is this a conscious decision to have a zero value
> imply AT_FDCWD and have you done this somewhere else in bpf already?
> Because that's contrary to how any file descriptor based apis work.
>
> How this is usually solved for extensible structs is to have a flag
> field that raises a flag to indicate that the fd fiel is set and thus 0
> can be used as a valid value.
>
> The way you're doing it right now is very counterintuitive to userspace
> and pretty much guaranteed to cause subtle bugs.

Yes, it's a very bpf()-specific convention we've settled on a while
ago. It allows a cleaner and simpler backwards compatibility story
without having to introduce new flags every single time. Most of BPF
UAPI by now dictates that (otherwise valid) FD 0 can't be used to pass
it to bpf() syscall. Most of the time users will be blissfully unaware
because libbpf and other BPF libraries are checking for fd =3D=3D 0 and
dup()'ing them to avoid ever returning FD 0 to the user.

tl;dr, a conscious decision consistent with the rest of BPF UAPI. It
is a bpf() peculiarity, yes.


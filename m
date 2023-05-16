Return-Path: <bpf+bounces-667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DAF70559A
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 20:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210DF281782
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 18:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C04209A7;
	Tue, 16 May 2023 18:03:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DBF101CF
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 18:03:12 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154D1E0
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 11:03:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-965a68abfd4so2746744466b.2
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 11:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684260188; x=1686852188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9VUNW+oZlO1nDPY10jKxCAsAFdy5XtW+dISPI0ctvI=;
        b=Cq7DiaIRjhL0HGEkD6RM/Ik1EBW2WgNkWkBIJzSoOawEhb6uB5Q5RA3ZRBD7c1WcUX
         ATMOpVp6wOqy1lsWotlIwRcVRDxY0DC+1/1yhRIGAmfqwSeT5lzom27dobou3mwsTVrm
         hK74u6XVVAK5UY74RKbAxEobcsNrK+2+CHQFowl7lx3P7sz5AeC2/9pZloMJ5I0zot+C
         rN9AvsnP/2Y9ZNQXCOW1tB3fckPAgXY9G2IoiuC8zHf7F+qOPBcS7culfXI0/cRblbUc
         lU6k1M2UVKwsL0Wgq5d4v2zxVS8dfWkiSR/rlKc1xT5lfr9aCbTXA1VSNzXn7qEhaUuu
         DLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684260188; x=1686852188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9VUNW+oZlO1nDPY10jKxCAsAFdy5XtW+dISPI0ctvI=;
        b=SpeZ/FGIjX1lwKzV3jynZdvNsFzmX4zkuGJokKqgMPkgLLFVH+nQNYZAlUq9ikMn1N
         TrgwDIGozxWV44a1fPnF53bNP3d084BFpwb0SBWkXIu9wcV3Be+zrQDQTAR+lWMxdcVs
         YWHSnr2ge0MasUHMQBxVwYxzlXNIEQKS/ZiSCN7IOXf0azabKviWvxayjwQ3yYPPJl6S
         auVEZqJNVYzsNyrPTIHxFcwNxhx9dfVK/BT+xUfVngXwkHGZjoDxK0W9Z2oLPB5AgcQ3
         Xcg+gO6Zu71HaRj1mVZtABoTKBJli/Bd4UaZj9DhBLhq3KPBNmXz/eAAMWuDTo3Je6WP
         guEw==
X-Gm-Message-State: AC+VfDw+FtVk87qib1vqrfYkzztRju1cFt411ukGZ2epImiNZiirx2c5
	k/+qGh47seLTQZxo5mowxgsOrWglOcLaFKw+l/I=
X-Google-Smtp-Source: ACHHUZ4CODB1d03SPwNdeMv7rtiSUnvQgYqtGzg3meZxbFQgcWWDSD/mRApRxWj2e2WNIbeXvubv6ry4gbqRGCAuTh4=
X-Received: by 2002:a17:907:7f19:b0:947:335f:5a0d with SMTP id
 qf25-20020a1709077f1900b00947335f5a0dmr43167396ejc.62.1684260188348; Tue, 16
 May 2023 11:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230516001348.286414-1-andrii@kernel.org> <20230516001348.286414-2-andrii@kernel.org>
 <ZGNERLZH65QgGGEE@krava>
In-Reply-To: <ZGNERLZH65QgGGEE@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 May 2023 11:02:56 -0700
Message-ID: <CAEf4BzbG3fKBxEsA96u33tSNsNe3iOihs5WOkhp9wSc1fN90sA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: support O_PATH FDs in BPF_OBJ_PIN and
 BPF_OBJ_GET commands
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, cyphar@cyphar.com, 
	brauner@kernel.org, lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 1:52=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
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
>
> I'd probably call it dir_fd to emphasize the similarity,
> but I don't mind path_fd as well

I considered that, but it's really not necessarily a directory, it
could be a specific file location (with O_PATH), so I felt like a more
generic "path_fd" would be better (plus we have *path*name to combine
with). It's minor, I can be convinced if others feel strongly about
this.


>
> I have a note that you suggested to introduce this for uprobe
> multi link as well, so I'll do something similar
>
> lgtm
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> jirka
>
> >       };
> >
> >       struct { /* anonymous struct used by BPF_PROG_ATTACH/DETACH comma=
nds */
> > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > index 9948b542a470..13bb54f6bd17 100644
> > --- a/kernel/bpf/inode.c
> > +++ b/kernel/bpf/inode.c

[...]


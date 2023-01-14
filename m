Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8AA66A80B
	for <lists+bpf@lfdr.de>; Sat, 14 Jan 2023 02:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjANBOY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 20:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjANBOX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 20:14:23 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188C97EC90
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 17:14:22 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id v6so13117424ejg.6
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 17:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEu0meEXt7LAkZcUKGTJi8VHkhoGIgRrfXJqNq7O2nI=;
        b=PFezdE1+8lLhCbW8A94fG2d4g8tV738SErnGVnshbuINVrA6eK3EbClB/FhyRXGpWR
         6z5ALUIFqC8N5IgwQjC7AgYmQDbx7JTG0BJ7vkc1vzk8MaAfrpO7XvStd8CBdvbeg/kh
         /TK1ey9DqjJ5LmOopUMsFakhB6K+Itbo9PApAZooRsvEwfRC0gf1Hr1AkUgEH19IJuln
         XTf6I5g06kmg2wVTWDAdmRoXEWitAQF3QO6B1AK4WVAA08ngvluXcuqCtqYc9WlN0VMz
         mLf+mUuMTMKEnhnshKmYGdavIKoaCG8Z6HsNlckrWNcjX1w8pJN/n0xIOq45FStaGHEc
         BbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEu0meEXt7LAkZcUKGTJi8VHkhoGIgRrfXJqNq7O2nI=;
        b=jHu5yhJdA8hdIy/GDYP4eriCkIx7jfnOOhob27eLaKiuEPHbWrMMHmH2wsMZn18o6P
         ARZ0uUOX/KBg9gcBfGMe2AfR3i0DmVqJtxYJlF3NQpGCyBEDgYx5TVKP7dEYV5kE5Wng
         YLYTYpWKYTgUoSZm9qZqEGr2EcrwtL4nCxjyNfd4dSOhqRtiYTytQC6Umc0t2ypayOD7
         Wvv27fDD6HoLINVlISpRVB6rYddqOFj6xvScQnPZQhLbMfxKcycGoeeDz22NYYgbJP13
         AxKRrKxJ+QbPNuX3BBKgx9soETatHBF1JPTdCClMPqgkjI410ndL3wHM/Om/fY/Tp9R5
         T0tA==
X-Gm-Message-State: AFqh2kr2cBGKmmHDTW+4HUr6VeFTIdcJlxLi8qh8pg8YhSBb0XgEG6c8
        I5bJL2KY+tYp4ZWiIz32Nb7p1yXMyAOpeZbvu74=
X-Google-Smtp-Source: AMrXdXtqERTA9czsG/qCFBLntMGklMi0z9lhKeCVnm9+XmH3LHKlhhhxXBdOv3HFtldkA4G8W+9HVT94aXisOKn5hLQ=
X-Received: by 2002:a17:906:369b:b0:83d:2544:a11 with SMTP id
 a27-20020a170906369b00b0083d25440a11mr7496846ejc.226.1673658860444; Fri, 13
 Jan 2023 17:14:20 -0800 (PST)
MIME-Version: 1.0
References: <CA+khW7ju-gewZVNxopBi3Uvhiv8Wb=a-D4gaW3MD-NkUg0WSSg@mail.gmail.com>
 <CAEf4BzYztcahNoFH_CvtWz_1dTA3SSYv+zOorsyP0TfX-2EdaA@mail.gmail.com> <CA+khW7gXaHwxZjS1sp0oAF-t0jk0+CnwxdhV9kqyBfqEVack-w@mail.gmail.com>
In-Reply-To: <CA+khW7gXaHwxZjS1sp0oAF-t0jk0+CnwxdhV9kqyBfqEVack-w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Jan 2023 17:14:08 -0800
Message-ID: <CAEf4BzaQPtFMkcJdH4m5S0X5t3UD1M0M_bJk9Z65Zspb5bbxgA@mail.gmail.com>
Subject: Re: CORE feature request: support checking field type directly
To:     Hao Luo <haoluo@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 13, 2023 at 5:06 PM Hao Luo <haoluo@google.com> wrote:
>
> On Fri, Jan 13, 2023 at 3:41 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jan 12, 2023 at 2:18 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > Hi all,
> > >
> > > Feature request:
> > >
> > > To support checking the type of a specific field directly.
> > >
> > > Background:
> > >
> > > Currently, As far as I know, CORE is able to check a field=E2=80=99s
> > > existence, offset, size and signedness, but not the field=E2=80=99s t=
ype
> > > directly.
> > >
> > > There are changes that convert a field from a scalar type to a struct
> > > type, without changing the field=E2=80=99s name, offset or size. In t=
hat case,
> > > it is currently difficult to use CORE to check such changes. For a
> > > concrete example,
> > >
> > > Commit 94a9717b3c (=E2=80=9Clocking/rwsem: Make rwsem->owner an atomi=
c_long_t=E2=80=9D)
> > >
> > > Changed the type of rw_semaphore::owner from tast_struct * to
> > > atomic_long_t. In that change, the field name, offset and size remain
> > > the same. But the BPF program code used to extract the value is
> > > different. For the kernel where the field is a pointer, we can write:
> > >
> > > sem->owner
> > >
> > > While in the kernel where the field is an atomic, we need to write:
> > >
> > > sem->owner.counter.
> > >
> > > It would be great to be able to check a field=E2=80=99s type directly=
.
> > > Probably something like:
> > >
> > > #include =E2=80=9Cvmlinux.h=E2=80=9D
> > >
> > > struct rw_semaphore__old {
> > >         struct task_struct *owner;
> > > };
> > >
> > > struct rw_semaphore__new {
> > >         atomic_long_t owner;
> > > };
> > >
> > > u64 owner;
> > > if (bpf_core_field_type_is(sem->owner, struct task_struct *)) {
> > >         struct rw_semaphore__old *old =3D (struct rw_semaphore__old *=
)sem;
> > >         owner =3D (u64)sem->owner;
> > > } else if (bpf_core_field_type_is(sem->owner, atomic_long_t)) {
> > >         struct rw_semaphore__new *new =3D (struct rw_semaphore__new *=
)sem;
> > >         owner =3D new->owner.counter;
> > > }
> > >
> >
> > Have you tried bpf_core_type_matches()? It seems like exactly what you
> > are looking for? See [0] for logic of what constitutes "a match".
> >
>
> It seems bpf_core_type_matches() is for the userspace code. I'm

It's in the same family as bpf_type_{exists,size}() and
bpf_field_{exists,size,offset}(). It's purely BPF-side. Please grep
for bpf_core_type_matches() in selftests/bpf.

> looking for type checking in the BPF code. We probably don't need to
> check type equivalence, just comparing the btf_id of the field's type
> and the btf_id of a target type may be sufficient.

With the example above something like below should work:

struct rw_semaphore__old {
        struct task_struct *owner;
};

struct rw_semaphore__new {
        atomic_long_t owner;
};

u64 owner;
if (bpf_core_type_matches(struct rw_semaphore__old) /* owner is
task_struct pointer */) {
        struct rw_semaphore__old *old =3D (struct rw_semaphore__old *)sem;
        owner =3D (u64)sem->owner;
} else if (bpf_core_type_matches(struct rw_semaphore__old) /* owner
field is atomic_long_t */) {
        struct rw_semaphore__new *new =3D (struct rw_semaphore__new *)sem;
        owner =3D new->owner.counter;
}

>
> The commit 94a9717b3c (=E2=80=9Clocking/rwsem: Make rwsem->owner an
> atomic_long_t=E2=80=9D) is rare, but the 'owner' field is useful for trac=
king
> the owner of a kernel lock.

We implemented bpf_core_type_matches() to detect tracepoint changes,
which is equivalent (if not harder) use case. Give it a try.

>
> >   [0] https://github.com/libbpf/libbpf/blob/master/src/relo_core.c#L151=
7-L1543
> >
> > > Hao

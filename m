Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9771A66A7EC
	for <lists+bpf@lfdr.de>; Sat, 14 Jan 2023 02:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjANBGg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 20:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjANBGf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 20:06:35 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F9188DFA
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 17:06:30 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 36so16067617pgp.10
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 17:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqw/bQAKusqK4Xcm9pCpthEsnZi5z4r1J6Tr2tBl9RQ=;
        b=RQa8ShGM/Wrq3oOprNHWfOd3D/D0Rif0TS8WT9d5PDGPq7yPElBeRFkPELA4P2ZiGu
         32wECqA/G7RvXTQcoFcCmEoweFcZXTl7G5h2/f48p2T87Q6LlRTkeafzxBx9D8HUf09R
         kDp/Mae5pHNBb+MnF9n4JByv63JefCgb/VkTxr8oxtC0jUvMKgJnsOtKGzOrAVtKbBHs
         KtgFchwSQRDt5Mx6u8zZnIKFOHOGM6gGRuMAP5XfrNHNy1yWQ+tD4kBGmje52EmCR0jP
         1CLOa9hh9Na6tfT/Vp0OgRxhnaUfgch9d7HRmBnxAuWKS/PVMr2diNIqvzGOyfZ4myaG
         hBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqw/bQAKusqK4Xcm9pCpthEsnZi5z4r1J6Tr2tBl9RQ=;
        b=gtJUddT0q9RFJdSrDI3Oa5cEW5NiYAhjkTa+T7h5o80FMkHOKSLK2J3sE4IZeGrGfQ
         v/jlYAYCYFUqJpzKBSIkPXclWLUcBCeXopN40w87oTg9yUGAWtz57OTjXcVIzMQe7qZP
         3nX40nig4Grh6SB4n1ftI2dDijhHjVCNPfJGaLYFruXN/SzqB7xNHShvr95CO3G6BVod
         TIRcJ7/lxyi/sM7Dcohda6MAGEFmAwDWHRuLDyp3UymXBS+LyzVAzcbxB6FMs/GS2Z1H
         jHM82/ik7Sw+qTDtX8j45AgnB/BA5xk7Y4QQCUl6fpORaQXXThS32wl4sIr0fMF2uzj0
         hQXw==
X-Gm-Message-State: AFqh2kp/jYKcZRBTeMBgUFSWEdm1ifYY3GqAVa3AWr8oJjTSyGvDIZi3
        U6M6bb9nPKH7VvNYADMA0PLhzVwajg32mKc39ygKoA==
X-Google-Smtp-Source: AMrXdXtPiWXIzPHJ7GpDpqWR+KW/r2qdu6m6+A8OS29T96f5P5m7cy7xqg1fKr6CKyynK3JXKD/mwy+JAyHahUMGKN0=
X-Received: by 2002:a63:4519:0:b0:47c:948e:c0bf with SMTP id
 s25-20020a634519000000b0047c948ec0bfmr7368647pga.240.1673658389952; Fri, 13
 Jan 2023 17:06:29 -0800 (PST)
MIME-Version: 1.0
References: <CA+khW7ju-gewZVNxopBi3Uvhiv8Wb=a-D4gaW3MD-NkUg0WSSg@mail.gmail.com>
 <CAEf4BzYztcahNoFH_CvtWz_1dTA3SSYv+zOorsyP0TfX-2EdaA@mail.gmail.com>
In-Reply-To: <CAEf4BzYztcahNoFH_CvtWz_1dTA3SSYv+zOorsyP0TfX-2EdaA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 13 Jan 2023 17:06:18 -0800
Message-ID: <CA+khW7gXaHwxZjS1sp0oAF-t0jk0+CnwxdhV9kqyBfqEVack-w@mail.gmail.com>
Subject: Re: CORE feature request: support checking field type directly
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 13, 2023 at 3:41 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jan 12, 2023 at 2:18 PM Hao Luo <haoluo@google.com> wrote:
> >
> > Hi all,
> >
> > Feature request:
> >
> > To support checking the type of a specific field directly.
> >
> > Background:
> >
> > Currently, As far as I know, CORE is able to check a field=E2=80=99s
> > existence, offset, size and signedness, but not the field=E2=80=99s typ=
e
> > directly.
> >
> > There are changes that convert a field from a scalar type to a struct
> > type, without changing the field=E2=80=99s name, offset or size. In tha=
t case,
> > it is currently difficult to use CORE to check such changes. For a
> > concrete example,
> >
> > Commit 94a9717b3c (=E2=80=9Clocking/rwsem: Make rwsem->owner an atomic_=
long_t=E2=80=9D)
> >
> > Changed the type of rw_semaphore::owner from tast_struct * to
> > atomic_long_t. In that change, the field name, offset and size remain
> > the same. But the BPF program code used to extract the value is
> > different. For the kernel where the field is a pointer, we can write:
> >
> > sem->owner
> >
> > While in the kernel where the field is an atomic, we need to write:
> >
> > sem->owner.counter.
> >
> > It would be great to be able to check a field=E2=80=99s type directly.
> > Probably something like:
> >
> > #include =E2=80=9Cvmlinux.h=E2=80=9D
> >
> > struct rw_semaphore__old {
> >         struct task_struct *owner;
> > };
> >
> > struct rw_semaphore__new {
> >         atomic_long_t owner;
> > };
> >
> > u64 owner;
> > if (bpf_core_field_type_is(sem->owner, struct task_struct *)) {
> >         struct rw_semaphore__old *old =3D (struct rw_semaphore__old *)s=
em;
> >         owner =3D (u64)sem->owner;
> > } else if (bpf_core_field_type_is(sem->owner, atomic_long_t)) {
> >         struct rw_semaphore__new *new =3D (struct rw_semaphore__new *)s=
em;
> >         owner =3D new->owner.counter;
> > }
> >
>
> Have you tried bpf_core_type_matches()? It seems like exactly what you
> are looking for? See [0] for logic of what constitutes "a match".
>

It seems bpf_core_type_matches() is for the userspace code. I'm
looking for type checking in the BPF code. We probably don't need to
check type equivalence, just comparing the btf_id of the field's type
and the btf_id of a target type may be sufficient.

The commit 94a9717b3c (=E2=80=9Clocking/rwsem: Make rwsem->owner an
atomic_long_t=E2=80=9D) is rare, but the 'owner' field is useful for tracki=
ng
the owner of a kernel lock.

>   [0] https://github.com/libbpf/libbpf/blob/master/src/relo_core.c#L1517-=
L1543
>
> > Hao

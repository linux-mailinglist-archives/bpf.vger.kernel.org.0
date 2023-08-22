Return-Path: <bpf+bounces-8321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB05784D8A
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 01:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5CD2811C5
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 23:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CDB20F07;
	Tue, 22 Aug 2023 23:57:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A169920EE3
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 23:57:32 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5ADCF9
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 16:57:30 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ffa94a7a47so6422188e87.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 16:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692748649; x=1693353449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWYaBGV4dj11HYH60TaE8jvIxCM/yVvdzZVC9rCIluM=;
        b=h8ZVbeaQLRixTzJdzTtDFAk6vc1G5yKjcgvv47vcUmgAKIy5NgFSUxUu6ehA5GagKl
         MDRzhUicl6cOQu06zQR+NNcFC2cXMIIc15gajhqKiJTT4W+I8h8hTY6D5sFNuVbh45dU
         tEWSSaFhtuzHKAZZLIBy4vF04tYdXkjZFDAF/M+IlB19BuYHS8tFG+2j2mBWYcerFKPp
         I8X1kASfk1mRqa4WywvfvVkj+gCDCicneKWrINOykGXfDEQuBvJGFomqz1N4pXpaBvYV
         4JSNyqDrWdru+XVMFRJMvPVgiN6WYnbjcXmkOlVXfZ0Uc1AaWcSIqHyXGXTHENqcD1DU
         QYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692748649; x=1693353449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWYaBGV4dj11HYH60TaE8jvIxCM/yVvdzZVC9rCIluM=;
        b=KHzil/t3XBvMOEcWnmxUORajdk8hQrkS2BrM5wg2c+O+jR+zbletTzRgfUancnTvm4
         8SFbvqTF/EYxK+Jy23tHe/y4cTMhUCg3PXAt3uWQKwfEyhwIITLQ50oNxL6QW006Qd4C
         xd1muL6eSWWcwIqbYodUnP/nQAXx6P6vBuUvo2ZDTNsMwFElmgZtvZXNZQTM1fEfjeMc
         Yc6iu2UnEfFmrIYBFoF4/H6GwtMMYBN3HETqNziTpIeqwkMBjmi+Ft3k+19bB33Uv6z1
         EL3hHC1hj4iIa1kdd44q6LnJgtvUeEPQdBtmZj7wsTVrdIs6u+3sxZAXf93zfNkULxBH
         lRhQ==
X-Gm-Message-State: AOJu0YwlsAMHl7MMxLID5MjJqRXIiqL5IvXXBelbP5gO4VB7phEPHUej
	nNVz5w8HwPDssE7duR2b7M11jN/NybkN0BMpPd0=
X-Google-Smtp-Source: AGHT+IEdvu+kCeXJI0HGCoJiHN0yZEh7heXwtX06bP2Eyg22a+IzNOjz5hN9eQ0ISbcP55BvHg3tmeOeMSqkzQ3A2+g=
X-Received: by 2002:a05:6512:2395:b0:4fb:8ee0:b8a5 with SMTP id
 c21-20020a056512239500b004fb8ee0b8a5mr9874175lfv.46.1692748648624; Tue, 22
 Aug 2023 16:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822050558.2937659-1-davemarchevsky@fb.com>
 <20230822050558.2937659-3-davemarchevsky@fb.com> <04626310-a4c3-8192-9aee-11af5d692817@linux.dev>
 <5df1b876-9465-4de2-42d5-a59426d141aa@linux.dev> <c5470820-6e5d-2755-05f9-f932cacd395f@linux.dev>
 <CAADnVQKffM8=3b_hD0EDM9r-rEwipKGmA2rSz=G_FOXaBUp+6g@mail.gmail.com>
In-Reply-To: <CAADnVQKffM8=3b_hD0EDM9r-rEwipKGmA2rSz=G_FOXaBUp+6g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Aug 2023 16:57:16 -0700
Message-ID: <CAEf4BzbPeO21gQ+ud_LHTeHVGg6TJZ0Z8w4QW8DvNihtrN3gYA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/3] bpf: Introduce task_vma open-coded
 iterator kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, David Marchevsky <david.marchevsky@linux.dev>, 
	Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Stanislav Fomichev <sdf@google.com>, 
	Nathan Slingerland <slinger@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 3:37=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 22, 2023 at 1:14=E2=80=AFPM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> >
> >
> > On 8/22/23 12:19 PM, David Marchevsky wrote:
> > > On 8/22/23 1:42 PM, Yonghong Song wrote:
> > >>
> > >>
> > >> On 8/21/23 10:05 PM, Dave Marchevsky wrote:
> > >>> This patch adds kfuncs bpf_iter_task_vma_{new,next,destroy} which a=
llow
> > >>> creation and manipulation of struct bpf_iter_task_vma in open-coded
> > >>> iterator style. BPF programs can use these kfuncs directly or throu=
gh
> > >>> bpf_for_each macro for natural-looking iteration of all task vmas.
> > >>>
> > >>> The implementation borrows heavily from bpf_find_vma helper's locki=
ng -
> > >>> differing only in that it holds the mmap_read lock for all iteratio=
ns
> > >>> while the helper only executes its provided callback on a maximum o=
f 1
> > >>> vma. Aside from locking, struct vma_iterator and vma_next do all th=
e
> > >>> heavy lifting.
> > >>>
> > >>> The newly-added struct bpf_iter_task_vma has a name collision with =
a
> > >>> selftest for the seq_file task_vma iter's bpf skel, so the selftest=
s/bpf/progs
> > >>> file is renamed in order to avoid the collision.
> > >>>
> > >>> A pointer to an inner data struct, struct bpf_iter_task_vma_kern_da=
ta, is the
> > >>> only field in struct bpf_iter_task_vma. This is because the inner d=
ata
> > >>> struct contains a struct vma_iterator (not ptr), whose size is like=
ly to
> > >>> change under us. If bpf_iter_task_vma_kern contained vma_iterator d=
irectly
> > >>> such a change would require change in opaque bpf_iter_task_vma stru=
ct's
> > >>> size. So better to allocate vma_iterator using BPF allocator, and s=
ince
> > >>> that alloc must already succeed, might as well allocate all iter fi=
elds,
> > >>> thereby freezing struct bpf_iter_task_vma size.
> > >>>
> > >>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > >>> Cc: Nathan Slingerland <slinger@meta.com>
> > >>> ---
> > >>>    include/uapi/linux/bpf.h                      |  4 +
> > >>>    kernel/bpf/helpers.c                          |  3 +
> > >>>    kernel/bpf/task_iter.c                        | 84 +++++++++++++=
++++++
> > >>>    tools/include/uapi/linux/bpf.h                |  4 +
> > >>>    tools/lib/bpf/bpf_helpers.h                   |  8 ++
> > >>>    .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++---
> > >>>    ...f_iter_task_vma.c =3D> bpf_iter_task_vmas.c} |  0
> > >>>    7 files changed, 116 insertions(+), 13 deletions(-)
> > >>>    rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c =
=3D> bpf_iter_task_vmas.c} (100%)
> > >>>
> > >>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > >>> index 8790b3962e4b..49fc1989a548 100644
> > >>> --- a/include/uapi/linux/bpf.h
> > >>> +++ b/include/uapi/linux/bpf.h
> > >>> @@ -7311,4 +7311,8 @@ struct bpf_iter_num {
> > >>>        __u64 __opaque[1];
> > >>>    } __attribute__((aligned(8)));
> > >>>    +struct bpf_iter_task_vma {
> > >>> +    __u64 __opaque[1]; /* See bpf_iter_num comment above */
> > >>> +} __attribute__((aligned(8)));
> > >>
> > >> In the future, we might have bpf_iter_cgroup, bpf_iter_task, bpf_ite=
r_cgroup_task, etc. They may all use the same struct
> > >> like
> > >>    struct bpf_iter_<...> {
> > >>      __u64 __opaque[1];
> > >>    } __attribute__((aligned(8)));
> > >>
> > >> Maybe we want a generic one instead of having lots of
> > >> structs with the same underline definition? For example,
> > >>    struct bpf_iter_generic
> > >> ?
> > >>
> > >
> > > The bpf_for_each macro assumes a consistent naming scheme for opaque =
iter struct
> > > and associated kfuncs. Having a 'bpf_iter_generic' shared amongst mul=
tiple types
> > > of iters would break the scheme. We could:
> > >
> > >    * Add bpf_for_each_generic that only uses bpf_iter_generic
> > >      * This exposes implementation details in an ugly way, though.
> > >    * Do some macro magic to pick bpf_iter_generic for some types of i=
ters, and
> > >      use consistent naming pattern for others.
> > >      * I'm not sure how to do this with preprocessor
> > >    * Migrate all opaque iter structs to only contain pointer to bpf_m=
em_alloc'd
> > >      data struct, and use bpf_iter_generic for all of them
> > >      * Probably need to see more iter implementation / usage before m=
aking such
> > >        a change
> > >    * Do 'typedef __u64 __aligned(8) bpf_iter_<...>
> > >      * BTF_KIND_TYPEDEF intead of BTF_KIND_STRUCT might throw off som=
e verifier
> > >        logic. Could do similar typedef w/ struct to try to work aroun=
d
> > >        it.
> > >
> > > Let me know what you think. Personally I considered doing typedef whi=
le
> > > implementing this, so that's the alternative I'd choose.
> >
> > Okay, since we have naming convention restriction, typedef probably the
> > best option, something like
> >    typedef struct bpf_iter_num bpf_iter_task_vma
> > ?
> >
> > Verifier might need to be changed if verifier strips all modifiers
> > (including tyypedef) to find the struct name.
>
> I don't quite see how typedef helps here.
> Say we do:
> struct bpf_iter_task_vma {
>      __u64 __opaque[1];
> } __attribute__((aligned(8)));
>
> as Dave is proposing.
> Then tomorrow we add another bpf_iter_foo that is exactly the same opaque=
[1].
> And we will have bpf_iter_num, bpf_iter_task_vma, bpf_iter_foo structs
> with the same layout. So what? Eye sore?
> In case we need to extend task_vma from 1 to 2 it will be easier to do
> when all of them are separate structs.
>
> And typedef has unknown verification implications.

+1, I wouldn't complicate things and have a proper struct with strict
naming convention for each iter kind

>
> Either way we need to find a way to move these structs from uapi/bpf.h
> along with bpf_rb_root and friends to some "obviously unstable" header.

I don't think we have to add struct bpf_iter_task_vma to uapi/bpf.h at
all and rely on it coming from vmlinux.h. As I mentioned in previous
email, num iterator is a bit special in its generality and simplicity
(which allows to be confident it won't need to be changed), while
other iterators should be treated as more unstable and come from
vmlinux.h (or wherever else kfuncs will be coming from in the future).

tl;dr: we can define this struct right next to where we defined
bpf_iter_task_vma_new() kfunc. Unless I'm missing some complication,
of course.


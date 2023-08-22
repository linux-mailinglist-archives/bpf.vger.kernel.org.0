Return-Path: <bpf+bounces-8311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFD9784CE2
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 00:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E8F2811C7
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 22:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5C427713;
	Tue, 22 Aug 2023 22:37:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE5D2019C
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 22:37:05 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A58CEE
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 15:37:03 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so78868411fa.2
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 15:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692743822; x=1693348622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZF4tqhR3UX958PA0TnuRxw8X/WEh7TUrK02NPFRSZsY=;
        b=KoSB0lTDDcn22lrmnEtsZxWSdRH8cFpMiLX8mk6p75QrR3wMepS05L/UQ9dbkf8W6J
         mXXqxyRlX4Ej+AoHhOUibERkRuFDDAHEQ7nlevo7UygAzfaxcOQw6SP1Lt0VREqJZaSC
         YmND9Lz9w4t9Xcmr+tPM8cw9clrkdAOLBqdrk/AhCLZwnHUWns7K40W/geDo/DK1yMDV
         uXqKUA4x/ylDXJfw3V5pyPNJXXoW9eTOAy8AUfS8lA9bFcmOPKzLakGZWbp3nLyHnecc
         hsPjRrQ8LTEmLHvQDnnLoUs9i7QPybioLAaU0WwS+CG+C/fpRl/9C8r+0bK0jS7YYJ5N
         IMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692743822; x=1693348622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZF4tqhR3UX958PA0TnuRxw8X/WEh7TUrK02NPFRSZsY=;
        b=bpO3jyGV0GFAqHHDnxXsat1VK1WG9T97m3o4zpGsx9gZYT+ZKiZP1zXzLyH9ZjORzH
         I1zz7eAXBsh1v61ndbmVDb9gJQ3bvXKANwjQ32G85q1RMimPaSUKQeVCEXG1VZJLkyut
         tpF74ZW+IS047zgObTtN+P/L8K2L5rFrNspoXVAEofiM5BLhXkhiHO+mHgF86wL0H+Yb
         FpXpTBpyK+RdJTTNibX4mlqWSxj3TXHssHqzKbH+xMxvEbs+ciG9nPKg5j5tlPAx3mMl
         6CcJCpcUSY1UuQCXEI7o6RlrguPC/u305uqAP4JB8OLCWIT4dcGedfyC+VGRlz6dz5g4
         nAlA==
X-Gm-Message-State: AOJu0YzKhU3/HIB6HuvnKX9hI8wThpBuBvkw4Ed4W9JvWmh+9IlcKa0D
	rr65iFzZZ9WsE+BB+drVU31PPacaEhhVRyAkk3E=
X-Google-Smtp-Source: AGHT+IG3uk99yRv3SF7sLfgzCcYtLDrYXBXolcfqXdtMJ1Y87yzbYC4Zr2V+1EhGm2IRRKD4+poVO9ys1NZT2py8CvM=
X-Received: by 2002:a2e:9d94:0:b0:2bc:da3e:3bda with SMTP id
 c20-20020a2e9d94000000b002bcda3e3bdamr376797ljj.2.1692743821440; Tue, 22 Aug
 2023 15:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822050558.2937659-1-davemarchevsky@fb.com>
 <20230822050558.2937659-3-davemarchevsky@fb.com> <04626310-a4c3-8192-9aee-11af5d692817@linux.dev>
 <5df1b876-9465-4de2-42d5-a59426d141aa@linux.dev> <c5470820-6e5d-2755-05f9-f932cacd395f@linux.dev>
In-Reply-To: <c5470820-6e5d-2755-05f9-f932cacd395f@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Aug 2023 15:36:50 -0700
Message-ID: <CAADnVQKffM8=3b_hD0EDM9r-rEwipKGmA2rSz=G_FOXaBUp+6g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/3] bpf: Introduce task_vma open-coded
 iterator kfuncs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: David Marchevsky <david.marchevsky@linux.dev>, Dave Marchevsky <davemarchevsky@fb.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Stanislav Fomichev <sdf@google.com>, Nathan Slingerland <slinger@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 1:14=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 8/22/23 12:19 PM, David Marchevsky wrote:
> > On 8/22/23 1:42 PM, Yonghong Song wrote:
> >>
> >>
> >> On 8/21/23 10:05 PM, Dave Marchevsky wrote:
> >>> This patch adds kfuncs bpf_iter_task_vma_{new,next,destroy} which all=
ow
> >>> creation and manipulation of struct bpf_iter_task_vma in open-coded
> >>> iterator style. BPF programs can use these kfuncs directly or through
> >>> bpf_for_each macro for natural-looking iteration of all task vmas.
> >>>
> >>> The implementation borrows heavily from bpf_find_vma helper's locking=
 -
> >>> differing only in that it holds the mmap_read lock for all iterations
> >>> while the helper only executes its provided callback on a maximum of =
1
> >>> vma. Aside from locking, struct vma_iterator and vma_next do all the
> >>> heavy lifting.
> >>>
> >>> The newly-added struct bpf_iter_task_vma has a name collision with a
> >>> selftest for the seq_file task_vma iter's bpf skel, so the selftests/=
bpf/progs
> >>> file is renamed in order to avoid the collision.
> >>>
> >>> A pointer to an inner data struct, struct bpf_iter_task_vma_kern_data=
, is the
> >>> only field in struct bpf_iter_task_vma. This is because the inner dat=
a
> >>> struct contains a struct vma_iterator (not ptr), whose size is likely=
 to
> >>> change under us. If bpf_iter_task_vma_kern contained vma_iterator dir=
ectly
> >>> such a change would require change in opaque bpf_iter_task_vma struct=
's
> >>> size. So better to allocate vma_iterator using BPF allocator, and sin=
ce
> >>> that alloc must already succeed, might as well allocate all iter fiel=
ds,
> >>> thereby freezing struct bpf_iter_task_vma size.
> >>>
> >>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> >>> Cc: Nathan Slingerland <slinger@meta.com>
> >>> ---
> >>>    include/uapi/linux/bpf.h                      |  4 +
> >>>    kernel/bpf/helpers.c                          |  3 +
> >>>    kernel/bpf/task_iter.c                        | 84 +++++++++++++++=
++++
> >>>    tools/include/uapi/linux/bpf.h                |  4 +
> >>>    tools/lib/bpf/bpf_helpers.h                   |  8 ++
> >>>    .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++---
> >>>    ...f_iter_task_vma.c =3D> bpf_iter_task_vmas.c} |  0
> >>>    7 files changed, 116 insertions(+), 13 deletions(-)
> >>>    rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c =3D>=
 bpf_iter_task_vmas.c} (100%)
> >>>
> >>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >>> index 8790b3962e4b..49fc1989a548 100644
> >>> --- a/include/uapi/linux/bpf.h
> >>> +++ b/include/uapi/linux/bpf.h
> >>> @@ -7311,4 +7311,8 @@ struct bpf_iter_num {
> >>>        __u64 __opaque[1];
> >>>    } __attribute__((aligned(8)));
> >>>    +struct bpf_iter_task_vma {
> >>> +    __u64 __opaque[1]; /* See bpf_iter_num comment above */
> >>> +} __attribute__((aligned(8)));
> >>
> >> In the future, we might have bpf_iter_cgroup, bpf_iter_task, bpf_iter_=
cgroup_task, etc. They may all use the same struct
> >> like
> >>    struct bpf_iter_<...> {
> >>      __u64 __opaque[1];
> >>    } __attribute__((aligned(8)));
> >>
> >> Maybe we want a generic one instead of having lots of
> >> structs with the same underline definition? For example,
> >>    struct bpf_iter_generic
> >> ?
> >>
> >
> > The bpf_for_each macro assumes a consistent naming scheme for opaque it=
er struct
> > and associated kfuncs. Having a 'bpf_iter_generic' shared amongst multi=
ple types
> > of iters would break the scheme. We could:
> >
> >    * Add bpf_for_each_generic that only uses bpf_iter_generic
> >      * This exposes implementation details in an ugly way, though.
> >    * Do some macro magic to pick bpf_iter_generic for some types of ite=
rs, and
> >      use consistent naming pattern for others.
> >      * I'm not sure how to do this with preprocessor
> >    * Migrate all opaque iter structs to only contain pointer to bpf_mem=
_alloc'd
> >      data struct, and use bpf_iter_generic for all of them
> >      * Probably need to see more iter implementation / usage before mak=
ing such
> >        a change
> >    * Do 'typedef __u64 __aligned(8) bpf_iter_<...>
> >      * BTF_KIND_TYPEDEF intead of BTF_KIND_STRUCT might throw off some =
verifier
> >        logic. Could do similar typedef w/ struct to try to work around
> >        it.
> >
> > Let me know what you think. Personally I considered doing typedef while
> > implementing this, so that's the alternative I'd choose.
>
> Okay, since we have naming convention restriction, typedef probably the
> best option, something like
>    typedef struct bpf_iter_num bpf_iter_task_vma
> ?
>
> Verifier might need to be changed if verifier strips all modifiers
> (including tyypedef) to find the struct name.

I don't quite see how typedef helps here.
Say we do:
struct bpf_iter_task_vma {
     __u64 __opaque[1];
} __attribute__((aligned(8)));

as Dave is proposing.
Then tomorrow we add another bpf_iter_foo that is exactly the same opaque[1=
].
And we will have bpf_iter_num, bpf_iter_task_vma, bpf_iter_foo structs
with the same layout. So what? Eye sore?
In case we need to extend task_vma from 1 to 2 it will be easier to do
when all of them are separate structs.

And typedef has unknown verification implications.

Either way we need to find a way to move these structs from uapi/bpf.h
along with bpf_rb_root and friends to some "obviously unstable" header.


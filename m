Return-Path: <bpf+bounces-7593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A24779591
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 19:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCA7281A2F
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 17:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2563219C4;
	Fri, 11 Aug 2023 17:03:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB22DEAF9
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 17:03:59 +0000 (UTC)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BDD19F
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 10:03:58 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-26b2daf44c3so675953a91.3
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691773438; x=1692378238;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X+aEC/ljquqUkZGMqqsO713y8QEhpsiG2wta3ptRrcM=;
        b=Uf8CCmEeTzDy/8X5mYCoe2EvBY7OqGqUFuuzTU3g9nQ+zfma0K53oj1d2RnxG5Ay/p
         nj1mCNpfhmhX2BUvIf7VF4w3SZ/y4AM4M1fY7OQTeVe8HMOgsevjvFIB0qZu5ULs+JrM
         3xJTrQlCnQeeF1kBhNoFjxCAPWU2A5M+c/LTQEle5BdGnD58l+PG185ohFeta6xG4Q9s
         jOckHXJQg0VBLQsjFWifo4+KESCdNfjibNuHozo5AtSLInq4msiOry+BrJ6Py8jfhz6s
         0B/pMPcm+slwEFCg5h9wobevwoArsfYxSaZEl9fqTR5YAXZk4JLkGXhdQztdlJSXwigr
         kDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773438; x=1692378238;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+aEC/ljquqUkZGMqqsO713y8QEhpsiG2wta3ptRrcM=;
        b=QJHOq3JVstSxvH43xaEll3aImSYD2GO2t5BaT9XbWj/hPqeO6Xg2CWYCBF2G6E5XMo
         rt8kYKsqCwH4vKVuNP2RZH1VnhAMbJ8Q4y8x3D33igdoLtBgqhIR8EIAfLmJvEeIDGxf
         W7bNEGSunlgO69UbLcfexIhdRkiV0i6+m+S5+mW4FmrFO9gM3ORjyvZe6DPuMDJGdUXW
         hzOsdfROOgURyGDihPCX5S3sSS7MYsWQzk541rpQHohJdGv8Cq23ZMBkHQxn4Dg3d0Ew
         3NMrsQw0maKel7/iAA/4vr7D3TqLFnMRqTZzwUdnME3QKKwP0wfl7UJAl6Vc7o5qjtdY
         7Qlw==
X-Gm-Message-State: AOJu0Yw9wFXKHKf26UwU+3FEsA1g70fOF+uZNY4TBe0tLwpvCzD4jV+b
	Dl8+907lnm8JKUcHuZaRriVqABU=
X-Google-Smtp-Source: AGHT+IEsZmRt3qryW/cn8xRBJZFjw2tfbtre91KZnBefrT0fECP26eGN4fqjFtPrwkNXo48Siou09Gg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:e74b:b0:1bc:5182:1ddb with SMTP id
 p11-20020a170902e74b00b001bc51821ddbmr927520plf.3.1691773438134; Fri, 11 Aug
 2023 10:03:58 -0700 (PDT)
Date: Fri, 11 Aug 2023 10:03:56 -0700
In-Reply-To: <d000d817-54b9-f6b8-dcb3-d417ed2cbc97@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810183513.684836-1-davemarchevsky@fb.com>
 <20230810183513.684836-3-davemarchevsky@fb.com> <ZNVdP0mA9REeLQJj@google.com> <d000d817-54b9-f6b8-dcb3-d417ed2cbc97@linux.dev>
Message-ID: <ZNZp/Pb7HGi2y4Q+@google.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Introduce task_vma open-coded iterator kfuncs
From: Stanislav Fomichev <sdf@google.com>
To: David Marchevsky <david.marchevsky@linux.dev>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Nathan Slingerland <slinger@meta.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/11, David Marchevsky wrote:
> On 8/10/23 5:57 PM, Stanislav Fomichev wrote:
> > On 08/10, Dave Marchevsky wrote:
> >> This patch adds kfuncs bpf_iter_task_vma_{new,next,destroy} which allow
> >> creation and manipulation of struct bpf_iter_task_vma in open-coded
> >> iterator style. BPF programs can use these kfuncs directly or through
> >> bpf_for_each macro for natural-looking iteration of all task vmas.
> >>
> >> The implementation borrows heavily from bpf_find_vma helper's locking -
> >> differing only in that it holds the mmap_read lock for all iterations
> >> while the helper only executes its provided callback on a maximum of 1
> >> vma. Aside from locking, struct vma_iterator and vma_next do all the
> >> heavy lifting.
> >>
> >> The newly-added struct bpf_iter_task_vma has a name collision with a
> >> selftest for the seq_file task_vma iter's bpf skel, so the selftests/bpf/progs
> >> file is renamed in order to avoid the collision.
> >>
> >> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> >> Cc: Nathan Slingerland <slinger@meta.com>
> >> ---
> >>  include/uapi/linux/bpf.h                      |  5 ++
> >>  kernel/bpf/helpers.c                          |  3 +
> >>  kernel/bpf/task_iter.c                        | 56 +++++++++++++++++++
> >>  tools/include/uapi/linux/bpf.h                |  5 ++
> >>  tools/lib/bpf/bpf_helpers.h                   |  8 +++
> >>  .../selftests/bpf/prog_tests/bpf_iter.c       | 26 ++++-----
> >>  ...f_iter_task_vma.c => bpf_iter_task_vmas.c} |  0
> >>  7 files changed, 90 insertions(+), 13 deletions(-)
> >>  rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c => bpf_iter_task_vmas.c} (100%)
> >>
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index d21deb46f49f..c4a65968f9f5 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -7291,4 +7291,9 @@ struct bpf_iter_num {
> >>  	__u64 __opaque[1];
> >>  } __attribute__((aligned(8)));
> >>  
> >> +struct bpf_iter_task_vma {
> > 
> > [..]
> > 
> >> +	__u64 __opaque[9]; /* See bpf_iter_num comment above */
> >> +	char __opaque_c[3];
> > 
> > Everything in the series makes sense, but this part is a big confusing
> > when reading without too much context. If you're gonna do a respin, maybe:
> > 
> > - __opaque_c[8*9+3] (or whatever the size is)? any reason for separate
> >   __u64 + char?
> 
> IIUC this is because BTF generation doesn't pick up __attribute__((aligned(8))),
> so if a vmlinux.h is generated via 'bpftool btf dump file vmlinux format c' and
> this struct only contains chars, it won't have the correct alignment.
> 
> I'm not sure if the bitfield approach taken by bpf_{list,rb}_node similar has
> the same effect. Some quick googling indicates that if it does, it's probably
> not in the C standard.

Ugh, the alignment, right..

> But yeah, I agree that it's ugly. While we're on the topic, WDYT about my
> comment in the cover letter about this struct (copied here for convenience):
> 
>   * The struct vma_iterator wrapped by struct bpf_iter_task_vma itself wraps
>     struct ma_state. Because we need the entire struct, not a ptr, changes to
>     either struct vma_iterator or struct ma_state will necessitate changing the
>     opaque struct bpf_iter_task_vma to account for the new size. This feels a
>     bit brittle. We could instead use bpf_mem_alloc to allocate a struct
>     vma_iterator in bpf_iter_task_vma_new and have struct bpf_iter_task_vma
>     point to that, but that's not quite equivalent as BPF progs will usually
>     use the stack for this struct via bpf_for_each. Went with the simpler route
>     for now.

LGTM! (assuming you'll keep non-pointer; looking at that other thread
where Yonghong suggests to go with the ptr...)

> > - maybe worth adding something like /* Opaque representation of
> >   bpf_iter_task_vma_kern; see bpf_iter_num comment above */.
> >   that bpf_iter_task_vma<>bpf_iter_task_vma_kern wasn't super apparent
> >   until I got to the BUG_ON part
> 
> It feels weird to refer to the non-UAPI _kern struct in uapi header. Maybe
> better to add a comment to the _kern struct referring to this one? I don't
> feel strongly either way, though.

Yeah, good point, let's keep as is.


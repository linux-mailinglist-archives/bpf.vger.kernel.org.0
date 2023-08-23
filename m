Return-Path: <bpf+bounces-8365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9969785B5F
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 17:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629F1281275
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 15:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE909C2DD;
	Wed, 23 Aug 2023 15:03:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9A9448
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 15:03:37 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7E4CDF
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 08:03:35 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bba6fc4339so88204391fa.2
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 08:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692803013; x=1693407813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7YH4PFknUxnii9xhnO+wYeS+8+9l0QWgBuPtOYuo/s=;
        b=RW+sItW4aCk0L99zjLqlJB6OcTH4oFHafitOXyJPU5lrRLcTLX2unIhOCou/lNbZ7f
         IUkHq+zes7B5M+V5x2gqGv/5ETIRSsCMKVfU40zTlGgUi/q8EAwcQqGn1gTtVxpZB/2S
         7AhTGrJHErKOcm6aKPPKBpU8A+LBPngCRByAXRjwpW8l/fU13kssEgNOqgT2yuVCsVbG
         ORL3BqctoxDNq4w8AvZwHCEuKn5/GtXpVCK/2g6f/FOnFepukXjU41sfOWup+XNQOpEl
         bNXKsyyEauyFltW3dLPHY3Cpmt9dztX6obEjhhj9crNg9UwDw94VaGv1kzXn7GwBENl3
         FkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692803013; x=1693407813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7YH4PFknUxnii9xhnO+wYeS+8+9l0QWgBuPtOYuo/s=;
        b=PrLKTk5ZWmsjuQ5yIfXZK02kEekvo2ea2Y1Jax73gZ0OfIEuDV8WENYOlS009ikg/n
         9PNXZtEqHbow+wlb4jpD94nd8pP9S+ckJm+t4lBusenpbeRguWz5bN7iMUrcZ7IYI0YP
         5ArIdhPWPlNwWjRwjaojlgURQYIWwCy/VKv3h0WvDoEvgd+048DOM3Gi22+6BdgO/jVO
         zBpIF3ovkmA/2ZNy6+y1WCCPJf7oenEWSgGFOUI+TdZsAX+mVWPL9kG04d6MjxnuNSj+
         gpLU2eltZ9qtpO2M+Oid22mF2b0sWfU+vloM5lKtW7yrkxfCeIc0FK6Kno/Okz9EP5nC
         FGng==
X-Gm-Message-State: AOJu0YxWM1H9ELTajNAK29UafG5kQhOJNHNo7bzCqAppCLpdepohrLkC
	ZMRbBBISGJMg8Z5hcKRn30OUzANi+P61ymuSkXA=
X-Google-Smtp-Source: AGHT+IHFervY97Xcg3nyBa/YtDeEnzcDxHXPk+OIPD0HcuOsUzlUUxxKHuOfaFFX7jxsrhoBnLp3T79xTEbAcJ8/XqU=
X-Received: by 2002:a05:651c:20c:b0:2b1:ad15:fe38 with SMTP id
 y12-20020a05651c020c00b002b1ad15fe38mr9774938ljn.3.1692803013263; Wed, 23 Aug
 2023 08:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822050558.2937659-1-davemarchevsky@fb.com>
 <20230822050558.2937659-3-davemarchevsky@fb.com> <CAEf4BzZouNbzP7xOPxnU_Xzof2-L0fNE4CcjCcUJpJjAdyPJSw@mail.gmail.com>
 <36463876-1370-71d6-78f3-2350278f61c7@linux.dev>
In-Reply-To: <36463876-1370-71d6-78f3-2350278f61c7@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Aug 2023 08:03:22 -0700
Message-ID: <CAADnVQK4LVKS7QUYbVOzHFLj1zv9_vieOVAqcoCULZorQ4wjMA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/3] bpf: Introduce task_vma open-coded
 iterator kfuncs
To: David Marchevsky <david.marchevsky@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Nathan Slingerland <slinger@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 12:26=E2=80=AFAM David Marchevsky
<david.marchevsky@linux.dev> wrote:
>
> On 8/22/23 7:52 PM, Andrii Nakryiko wrote:
> > On Mon, Aug 21, 2023 at 10:06=E2=80=AFPM Dave Marchevsky <davemarchevsk=
y@fb.com> wrote:
> >>
> >> This patch adds kfuncs bpf_iter_task_vma_{new,next,destroy} which allo=
w
> >> creation and manipulation of struct bpf_iter_task_vma in open-coded
> >> iterator style. BPF programs can use these kfuncs directly or through
> >> bpf_for_each macro for natural-looking iteration of all task vmas.
> >>
> >> The implementation borrows heavily from bpf_find_vma helper's locking =
-
> >> differing only in that it holds the mmap_read lock for all iterations
> >> while the helper only executes its provided callback on a maximum of 1
> >> vma. Aside from locking, struct vma_iterator and vma_next do all the
> >> heavy lifting.
> >>
> >> The newly-added struct bpf_iter_task_vma has a name collision with a
> >> selftest for the seq_file task_vma iter's bpf skel, so the selftests/b=
pf/progs
> >> file is renamed in order to avoid the collision.
> >>
> >> A pointer to an inner data struct, struct bpf_iter_task_vma_kern_data,=
 is the
> >> only field in struct bpf_iter_task_vma. This is because the inner data
> >> struct contains a struct vma_iterator (not ptr), whose size is likely =
to
> >> change under us. If bpf_iter_task_vma_kern contained vma_iterator dire=
ctly
> >> such a change would require change in opaque bpf_iter_task_vma struct'=
s
> >> size. So better to allocate vma_iterator using BPF allocator, and sinc=
e
> >> that alloc must already succeed, might as well allocate all iter field=
s,
> >> thereby freezing struct bpf_iter_task_vma size.
> >>
> >> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> >> Cc: Nathan Slingerland <slinger@meta.com>
> >> ---
> >>  include/uapi/linux/bpf.h                      |  4 +
> >>  kernel/bpf/helpers.c                          |  3 +
> >>  kernel/bpf/task_iter.c                        | 84 ++++++++++++++++++=
+
> >>  tools/include/uapi/linux/bpf.h                |  4 +
> >>  tools/lib/bpf/bpf_helpers.h                   |  8 ++
> >>  .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++---
> >>  ...f_iter_task_vma.c =3D> bpf_iter_task_vmas.c} |  0
> >>  7 files changed, 116 insertions(+), 13 deletions(-)
> >>  rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c =3D> bp=
f_iter_task_vmas.c} (100%)
> >>
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index 8790b3962e4b..49fc1989a548 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -7311,4 +7311,8 @@ struct bpf_iter_num {
> >>         __u64 __opaque[1];
> >>  } __attribute__((aligned(8)));
> >>
> >> +struct bpf_iter_task_vma {
> >> +       __u64 __opaque[1]; /* See bpf_iter_num comment above */
> >> +} __attribute__((aligned(8)));
> >> +
> >>  #endif /* _UAPI__LINUX_BPF_H__ */
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index eb91cae0612a..7a06dea749f1 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -2482,6 +2482,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET=
_NULL)
> >>  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> >>  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
> >>  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> >> +BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW)
> >> +BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL=
)
> >> +BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
> >>  BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> >>  BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> >>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> >> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> >> index c4ab9d6cdbe9..51c2dce435c1 100644
> >> --- a/kernel/bpf/task_iter.c
> >> +++ b/kernel/bpf/task_iter.c
> >> @@ -7,7 +7,9 @@
> >>  #include <linux/fs.h>
> >>  #include <linux/fdtable.h>
> >>  #include <linux/filter.h>
> >> +#include <linux/bpf_mem_alloc.h>
> >>  #include <linux/btf_ids.h>
> >> +#include <linux/mm_types.h>
> >>  #include "mmap_unlock_work.h"
> >>
> >>  static const char * const iter_task_type_names[] =3D {
> >> @@ -823,6 +825,88 @@ const struct bpf_func_proto bpf_find_vma_proto =
=3D {
> >>         .arg5_type      =3D ARG_ANYTHING,
> >>  };
> >>
> >> +struct bpf_iter_task_vma_kern_data {
> >> +       struct task_struct *task;
> >> +       struct mm_struct *mm;
> >> +       struct mmap_unlock_irq_work *work;
> >> +       struct vma_iterator vmi;
> >> +};
> >> +
> >> +/* Non-opaque version of uapi bpf_iter_task_vma */
> >> +struct bpf_iter_task_vma_kern {
> >> +       struct bpf_iter_task_vma_kern_data *data;
> >> +} __attribute__((aligned(8)));
> >> +
> >
> > it's a bit worrying that we'll rely on memory allocation inside NMI to
> > be able to use this. I'm missing previous email discussion (I declared
> > email bankruptcy after long vacation), but I suppose the option to fix
> > bpf_iter_task_vma (to 88 bytes: 64 for vma_iterator + 24 for extra
> > pointers), or even to 96 to have a bit of headroom in case we need a
> > bit more space was rejected? It seems unlikely that vma_iterator will
> > have to grow, but if it does, it has 5 bytes of padding right now for
> > various flags, plus we can have extra 8 bytes reserved just in case.
> >
> > I know it's a big struct and will take a big chunk of the BPF stack,
> > but I'm a bit worried about both the performance implication of mem
> > alloc under NMI, and allocation failing.
> >
> > Maybe the worry is overblown, but I thought I'll bring it up anyways.
> >
>
> Few tangential trains of thought here, separated by multiple newlines
> for easier reading.
>
>
> IIUC the any-context BPF allocator will not actually allocate memory in N=
MI
> context, instead relying on its existing pre-filled caches.
>
> Alexei's patch adding the allocator says ([0]):
>
>   The allocators are NMI-safe from bpf programs only. They are not NMI-sa=
fe in general.
>
> So sounds bpf_mem_alloc in a kfunc called by a BPF program is NMI-safe.
>
>
> That's not to say that I'm happy about adding a fallible bpf_mem_alloc ca=
ll here
> before the kfunc can do anything useful. But it seems like the best way t=
o
> guarantee that we never see a mailing list message like:
>
>   Hello, I just added a field to 'struct ma_state' in my subsystem and it=
 seems
>   I've triggered a BUILD_BUG_ON in this far-away BPF subsystem. It looks =
like
>   you're making stability guarantees based on the size of my internal str=
uct.
>   What the hell?
>
> Sure, after I remove the kfuncs and struct bpf_iter_task_vma fwd decl fro=
m
> bpf_helpers.h - per your other comment below - we can do the whole "kfunc=
s
> aren't uapi and this struct bpf_iter_task_vma is coming from vmlinux.h,
> not some stable header" spiel and convince this hypothetical person. Not =
having
> to do the spiel here reinforces the more general "Modern BPF exposes
> functionality w/ kfuncs and kptrs, which are inherently _unstable_" messa=
ging
> more effectively than having to explain.
>
>
> If we go back to putting struct vma_iterator on the BPF stack, I think we
> definitely want to keep the BUILD_BUG_ON. If it were removed and vma_iter=
ator
> size changes, that would affect portability of BPF programs that assume t=
he old
> size of bpf_iter_task_vma, no? Which bpf_for_each is doing since it puts
> bpf_iter_task_vma on the stack.
>
> Is there some CO-RE technique that would handle above scenario portably? =
I
> can't think of anything straightforward. Maybe if BPF prog BTF only had
> a fwd decl for bpf_iter_task_vma, and size thus had to be taken from
> vmlinux BTF. But that would fail to compile since it the struct goes
> on the stack. Maybe use some placeholder size for compilation and use
> BTF tag to tell libbpf to patch insns w/ vmlinux's size for this struct?
>
>
> Re: padding bytes, seems worse to me than not using them. Have to make
> assumptions about far-away struct, specifically vma_iterator
> which landed quite recently as part of maple tree series. The assumptions
> don't prevent my hypothetical mailing list confusion from happening, incr=
eases
> the confusion if it does happen ("I added a small field recently, why did=
n't
> this break then? If it's explicitly and intentionally unstable, why add
> padding bytes?")
>
>   [0]: https://lore.kernel.org/bpf/20220902211058.60789-2-alexei.starovoi=
tov@gmail.com

+1
imo struct bpf_iter_task_vma_kern is a bit too big to put on bpf prog stack=
.
bpf_mem_alloc short term is a lesser evil imo.
Long term we need to think how to extend bpf ISA with alloca.
It's time to figure out how to grow the stack.


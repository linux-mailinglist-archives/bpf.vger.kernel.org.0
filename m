Return-Path: <bpf+bounces-61009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E2DADF943
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 00:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF983AA20F
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 22:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED7927E066;
	Wed, 18 Jun 2025 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ8WbRuI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82AD21E08A
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750285149; cv=none; b=ElSnCv+cms+T/l7tq//j0Gmc0mZ/OGGFiHRoNnAZM/3qndqsiNxsBMUTPtod5jWrgCTFHXETWIt07M4dcoV5jE82ytMPJN/vYoGCHYJAkDCSLiRjm3mrh6P7o/I/lrsZsFVfZap7muXY0Km3jJzBzhUxCg5yRiYKQU6WJQFFXi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750285149; c=relaxed/simple;
	bh=A6ekrxsynkYSBvHxcHXmMDka5K3Kr2q2KudyywMrUPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQjXtsPjdWEPuimXNFv6RChlBaPFgTYOptFux8u2r9cdtyVc0oZcBVCIknXdmsSUjlKKrn6wFc+Qk8jqylkm7uFldH8sYjxqMmOSgKfktD7gVw0y9q9zwCP3TJOQiqMFnU2PMv7+khbYD4qGib4WswwE3Hp3PdC81mm0hYPttms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ8WbRuI; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e81826d5b72so216847276.3
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750285146; x=1750889946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psx6ZbQtRpnTp68SWSZphy2vBVeymnnZVaLsWa5pZ+w=;
        b=CQ8WbRuIs66NAT+17zCbPuOPBjndLYQhNcK7wBOxolew7JSdWXbaSdTjLMlpUpelbe
         dffWjNg+Js+kpMXQNwmgrn/8VeslPDM6W2gdAIWqDx0itijF71aH5SLc5B6fLtk1TkpG
         a0r1QhFWYqXxk1J63MAexat+r+I4MfQJuIo413FjlE+67NK2bqk6zv4LBR0Anya8T3uf
         BWg3ybwI1d+PaX0gsPwaFRRlUbzqf6OlB07ppsv/gkjLUrKG05a95i37uLYy0F1F/iKs
         ummExXPU4VePp9GK/DxEon0uuAAnjdeNyfy4MRNdbSXSllfQVc795UY4V6PIze/LrE/m
         HGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750285146; x=1750889946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psx6ZbQtRpnTp68SWSZphy2vBVeymnnZVaLsWa5pZ+w=;
        b=Gybc9JqzGy6+oiV60rU+WGv4RM4LDcHkyPe/g24A1rBMp3YjFYlwRhhho5TrFy+t/z
         vxEsMurWa8KAUXsBPQpOZ+uMUK4VwBdvhavXYvlbQx4I70BwkUUZl9KMO4wLT6JXoz+a
         n3To1kGffXjfTd35YwsbfMA2QULs5KIWypITkNjNvBRafMQhmN1aH5StuEIRWxjSi08t
         LSrTLNDW2HcwQrg3Hnscuaz6rkZcuOCrg/E4LCOBeoTj2G7wkRPMEsI496Kk88sEiTTO
         T8ZboPCnH2DOxPOzux7tIcRhF6UuM/EjukHihSS6zO26dQOOK8FZyN6KrvlmAsMznOJ4
         W2Dg==
X-Gm-Message-State: AOJu0YwR1482g2Z3/tpTScdoFIOq1FX6AcjNYa6fjVXM4Sv/0U8ImNVJ
	eGgMpPFytDYLFD/pC5CfPTeQ1kT1786oXEvDKA3733iP3V2yt0ZPCKDXSRtbu6q0sBri+M+uX7f
	iwroEl4sCGXT0LKIpRMRv6PxLdcBJFuo=
X-Gm-Gg: ASbGncvJlTYhcoG0lMnIWcEJ3wkQuByws3quBDL9njVJe+xKFHu6rXGPpaVYB/Nlgmw
	Q1HHbaC4EUy4mw0OZ/2tbCbaNHk+cr4FmkY8ShARF1s4TWK6GHyFej36B3365hvh/1XN8wjOgeW
	MmfsAo9rKRIMUXEjlWIi+5Lf0Tufr1KBjwd4ikn9fjM+jqCgwy4EfdyrQWrg==
X-Google-Smtp-Source: AGHT+IE8UQrIZxicXW6tmKcoJtViuXJ+MZF0yLdCHFGtdNVEe1NcgY7WAtefXkyXuuAR0w6MtIjTPejLdpbnU7FY/Nw=
X-Received: by 2002:a05:6902:2503:b0:e81:869c:e616 with SMTP id
 3f1490d57ef6-e822ac7595cmr22037629276.24.1750285146510; Wed, 18 Jun 2025
 15:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609232746.1030044-1-ameryhung@gmail.com> <CAEf4BzbFaPMG4C4h1BX_Wa2gzO-DvCosPFHosCph1u7++KwhPQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbFaPMG4C4h1BX_Wa2gzO-DvCosPFHosCph1u7++KwhPQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 18 Jun 2025 15:18:54 -0700
X-Gm-Features: AX0GCFs-ErlOvYVcWkwjfp3zVo9daPuoIltjei_RqcDsee344QxduAX5gwnuSj8
Message-ID: <CAMB2axP_shzLPp=aFiuMtea=ALjcMtHe3ddaEBYsDF-hbDH9Rw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Save struct_ops instance pointer in bpf_prog_aux
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:08=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jun 9, 2025 at 4:27=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
> >
> > Allows struct_ops implementors to infer the calling struct_ops instance
> > inside a kfunc through prog->aux->this_st_ops. A new field, flags, is
> > added to bpf_struct_ops. If BPF_STRUCT_OPS_F_THIS_PTR is set in flags,
> > a pointer to the struct_ops structure registered to the kernel (i.e.,
> > kvalue->data) will be saved to prog->aux->this_st_ops. To access it in
> > a kfunc, use BPF_STRUCT_OPS_F_THIS_PTR with __prog argument [0]. The
> > verifier will fixup the argument with a pointer to prog->aux. this_st_o=
ps
> > is protected by rcu and is valid until a struct_ops map is unregistered
> > updated.
> >
> > For a struct_ops map with BPF_STRUCT_OPS_F_THIS_PTR, to make sure all
> > programs in it have the same this_st_ops, cmpxchg is used. Only if a
> > program is not already used in another struct_ops map also with
> > BPF_STRUCT_OPS_F_THIS_PTR can it be assigned to the current struct_ops
> > map.
> >
>
> Have you considered an alternative to storing this_st_ops in
> bpf_prog_aux by setting it at runtime (in struct_ops trampoline) into
> bpf_run_ctx (which I think all struct ops programs have set), and then
> letting any struct_ops kfunc just access it through current (see other
> uses of bpf_run_ctx, if you are unfamiliar). This would avoid all this
> business with extra flags and passing bpf_prog_aux as an extra
> argument.
>

I didn't know this. Thanks for suggesting an alternative!

> There will be no "only one struct_ops for this BPF program" limitation
> either: technically, you could have the same BPF program used from two
> struct_ops maps just fine (even at the same time). Then depending on
> which struct_ops is currently active, you'd have a corresponding
> bpf_run_ctx's struct_ops pointer. It feels like a cleaner approach to
> me.
>

This is a cleaner approach for struct_ops operators. To make it work
for kfuncs called in timer callback, I think prog->aux->st_ops is
still needed, but at least we can unify how to get this_st_ops in
kfunc, in a way that does not requires adding __prog to every kfuncs.

+enum bpf_run_ctx_type {
+        BPF_CG_RUN_CTX =3D 0,
+        BPF_TRACE_RUN_CTX,
+        BPF_TRAMP_RUN_CTX,
+        BPF_TIMER_RUN_CTX,
+};

struct bpf_run_ctx {
+        enum bpf_run_ctx_type type;
};

+struct bpf_timer_run_ctx {
+        struct bpf_prog_aux *aux;
+};

struct bpf_tramp_run_ctx {
        ...
+        void *st_ops;
};

In bpf_struct_ops_prepare_trampoline(), the st_ops assignment will be
emitted to the trampoline.

In bpf_timer_cb(), prepare bpf_timer_run_ctx, where st_ops comes from
prog->aux->this_st_ops and set current->bpf_ctx.

Finally, in kfuncs that want to know the current struct_ops, call this
new function below:

+void *bpf_struct_ops_current_st_ops(void)
+{
+        struct bpf_prog_aux aux;
+
+        if (!current->bpf_ctx)
+                return NULL;
+
+        switch(current->bpf_ctx->type) {
+        case BPF_TRAMP_RUN_CTX:
+                return (struct bpf_tramp_run_ctx *)(current->bpf_ctx)->st_=
ops;
+        case BPF_TIMER_RUN_CTX:
+                aux =3D (struct bpf_timer_run_ctx *)(current->bpf_ctx)->au=
x;
+                return rcu_dereference(aux->this_st_ops);
+        }
+        return NULL;
+}

What do you think?

> And in the trampoline itself it would be a hard-coded single word
> assignment on the stack, so should be basically a no-op from
> performance point of view.
>
> > [0]
> > commit bc049387b41f ("bpf: Add support for __prog argument suffix to
> > pass in prog->aux")
> > https://lore.kernel.org/r/20250513142812.1021591-1-memxor@gmail.com
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  include/linux/bpf.h         | 10 ++++++++++
> >  kernel/bpf/bpf_struct_ops.c | 38 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 48 insertions(+)
> >
>
> [...]


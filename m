Return-Path: <bpf+bounces-57537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B23CBAAC93F
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 17:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DB8980A56
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BB027EC97;
	Tue,  6 May 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGXoJ7lz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734D283137
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746544687; cv=none; b=A8awrEHpo/zGhhwhdgfm7lCeLWYIzLAQpkLf7UzvOI/lTKv4xzdpmnVSN68x7Brv3GcsK/7/0iXVEnSSBuRGTYcTSd9e9xAmPYARYdqz83c+SMhb5QX4VS66oXOQYWUsqk2LG5MSnkPP6T2xof+ctymmeBbJU4fkwnbE+KHULTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746544687; c=relaxed/simple;
	bh=Sd9vZYgWQ7XzyXuSOYEhqeLzOmOsZJixyaNNlgm4Jr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+Gk7JihnDwcS3zz1FNLavLpyLENgw0DQTRN4SPfcrCYKBjH6EMTtrFrzve+AJKKBoS9NcFh2rzajygKif38Tc/f5N1RXnuirX2eCePKS4nPhOEgRh5Dsl+kUSqXrnTVzjl35LWLepKh6bZnRpQIgAYNfSM0yEhxHiptMVe73HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGXoJ7lz; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso8126496b3a.2
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746544685; x=1747149485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kari3vpwMLwe8S6NfFA8J4eQRekzS/oOZnJO4wUiEjY=;
        b=CGXoJ7lzn0KgpFbCa4ICbx54YRfeb35meQba/Y0sRPt/ye+TNtW5qTQEKHdB9eOx8v
         E2vVYhUSvFzG54dfjLCXmrtwWBaTEHrnatb7dCkSEjO4AOnWQGUXJZmScOf17clJPxlF
         EIlHRSlvu1w+rBByBmzFGRu0Z9gwa+uN7xs646JNZ+eGFQuMgyd5EXRRVnqQ2c4E26EH
         RbW9Z4EG/g0Nl87MWThpXU8eUdULJTyPb5DEVQwiDrhcVOHcnwVbryB90Nfwj72cNoR0
         ef5Sg9o8lOAucp5xzfrvEPYNhjguim2Hshqe2UWlexFY0voBRy69KYhuCJmubR7KFVXH
         4YiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746544685; x=1747149485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kari3vpwMLwe8S6NfFA8J4eQRekzS/oOZnJO4wUiEjY=;
        b=eyrUPvlD/ZVGTOwPRPIiiekxPgwo3RSkSi+bcw4zaxeRJNj83ZaCxKL0PZg0PXESt/
         wXQ3AG0m7DrSlWYLSDgRIHE2XSuLHasCqoGe1OP/jQuvL6A+BLn+IoKnq+LbAyKHJxH2
         qiSq5vPfQ/PL+1Jwx4k7hpCjYPtCcKqCQAYn1gU2nMzXNp+ZZziN9QhQUDMCowKnsnPs
         DwnXYOevrciLd830kO/pmPMxvsNzFsNZlwxsBEF7ndDkCQizROw67r68r+/WUyTq9NMB
         PDhFFMYSpZNusMfVKcqLd5IrtgrKBH1LpQc1bKRorTfwmFt0M7DcNj37ir0Uo0YiR1hs
         As5g==
X-Forwarded-Encrypted: i=1; AJvYcCXUUmkTWkQgIyxqeQatw4Yx90Do9ckl6rq3ZCri5DFoHtSyvkh0DVMcMjd9YxUcfWYnvr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ZtfmNwKWxm6noK63/uL3E1pUKF3uk7nBzTPMBFPnL5d+153P
	Fk3WygnkqT4vWntuYRE3DGlnYJR2AyPIrst2n//gSE32bPt4gxp76E/+tdOUF9JmCekCpSzki6L
	FUza6qX1ZMMVV7zGt07zKXKSGeiLo1kLZ
X-Gm-Gg: ASbGncvhg6bvOoJnRRqrqGH3DXteN63WlAvbTWeBeXOlQLWPLa1K4jz2L2RtPdXFWEh
	5LDBO3yJSiNPVc0QxteSDqAEH5Eg7aVahALYEs2N24QTiQWuQYEzLTrHfBZYpEZHEFInP6OIO+C
	YPKUJA0bDZbuVxOMEjNQls
X-Google-Smtp-Source: AGHT+IECj1SHsItOHqoEaulnGdSZUSYnIKS4SOkx1FXQkHwrzJEUIq3IO4JCXoFIBJJDz6CIMdGIAZzoxghDi2TAFC0=
X-Received: by 2002:a05:6a00:e12:b0:73c:c11:b42e with SMTP id
 d2e1a72fcca58-74091afceacmr4929675b3a.20.1746544685142; Tue, 06 May 2025
 08:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502190621.41549-1-mykyta.yatsenko5@gmail.com>
 <20250502190621.41549-3-mykyta.yatsenko5@gmail.com> <CAADnVQ+PyzpJutq44dWtfX+YfkKuzRtmLTB7f7vgFtY+P-rjog@mail.gmail.com>
 <2f0665c3-9b8b-4069-a751-6054cbb68b88@gmail.com>
In-Reply-To: <2f0665c3-9b8b-4069-a751-6054cbb68b88@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 May 2025 08:17:53 -0700
X-Gm-Features: ATxdqUGTQf_W8QsqRp82wsCaL6p8nsvAMWeJEtJDWYYW9dBLzfJD6-cSTbmDVhg
Message-ID: <CAEf4BzZt49UXtM1n=ACCxpMnr7aFc9PaGHAjojoozjFbjQVcug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: implement dynptr copy kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 3:32=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 02/05/2025 22:32, Alexei Starovoitov wrote:
> > On Fri, May 2, 2025 at 12:06=E2=80=AFPM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> This patch introduces a new set of kfuncs for working with dynptrs in
> >> BPF programs, enabling reading variable-length user or kernel data
> >> into dynptr directly. To enable memory-safety, verifier allows only
> >> constant-sized reads via existing bpf_probe_read_{user|kernel} etc.
> >> kfuncs, dynptr-based kfuncs allow dynamically-sized reads without memo=
ry
> >> safety shortcomings.
> >>
> >> The following kfuncs are introduced:
> >> * `bpf_probe_read_kernel_dynptr()`: probes kernel-space data into a dy=
nptr
> >> * `bpf_probe_read_user_dynptr()`: probes user-space data into a dynptr
> >> * `bpf_probe_read_kernel_str_dynptr()`: probes kernel-space string int=
o
> >> a dynptr
> >> * `bpf_probe_read_user_str_dynptr()`: probes user-space string into a
> >> dynptr
> >> * `bpf_copy_from_user_dynptr()`: sleepable, copies user-space data int=
o
> >> a dynptr for the current task
> >> * `bpf_copy_from_user_str_dynptr()`: sleepable, copies user-space stri=
ng
> >> into a dynptr for the current task
> >> * `bpf_copy_from_user_task_dynptr()`: sleepable, copies user-space dat=
a
> >> of the task into a dynptr
> >> * `bpf_copy_from_user_task_str_dynptr()`: sleepable, copies user-space
> >> string of the task into a dynptr
> >>
> >> The implementation is built on two generic functions:
> >>   * __bpf_dynptr_copy
> >>   * __bpf_dynptr_copy_str
> >> These functions take function pointers as arguments, enabling the
> >> copying of data from various sources, including both kernel and user
> >> space. Notably, these indirect calls are typically inlined.
> >>
> >> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   kernel/bpf/helpers.c     |   8 ++
> >>   kernel/trace/bpf_trace.c | 199 +++++++++++++++++++++++++++++++++++++=
++
> >>   2 files changed, 207 insertions(+)
> >>
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index 2aad7c57425b..7d72d3e87324 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -3294,6 +3294,14 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF=
_ITER_NEXT | KF_RET_NULL | KF_SLE
> >>   BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF=
_SLEEPABLE)
> >>   BTF_ID_FLAGS(func, bpf_local_irq_save)
> >>   BTF_ID_FLAGS(func, bpf_local_irq_restore)
> >> +BTF_ID_FLAGS(func, bpf_probe_read_user_dynptr)
> >> +BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr)
> >> +BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr)
> >> +BTF_ID_FLAGS(func, bpf_probe_read_kernel_str_dynptr)
> >> +BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLEEPABLE)
> >> +BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
> >> +BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE)
> >> +BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE)
> > They need to have KF_TRUSTED_ARGS, otherwise legacy ptr_to_btf_id
> > can be passed in.
> >
> >>   BTF_KFUNCS_END(common_btf_ids)
> >>
> >>   static const struct btf_kfunc_id_set common_kfunc_set =3D {
> >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >> index 52c432a44aeb..52926d572006 100644
> >> --- a/kernel/trace/bpf_trace.c
> >> +++ b/kernel/trace/bpf_trace.c
> >> @@ -3499,6 +3499,147 @@ static int __init bpf_kprobe_multi_kfuncs_init=
(void)
> >>
> >>   late_initcall(bpf_kprobe_multi_kfuncs_init);
> >>
> >> +typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct=
 task_struct *tsk);
> >> +
> >> +static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *d=
ptr, u32 doff, u32 size,
> > why always_inline?
> Just wanted to get rid of the overhead of having implementation in the
> generic __bpf_dynptr_copy()
> (Removes one jmp, perhaps not a big deal)

This __always_inline is there to make sure the compiler doesn't
generate indirect calls into callbacks, which is more expensive,
especially on some kernel configurations. So this is less about
inlining implementation of __bpf_dyntpr_copy() logic itself for
performance reasons, rather than to allow compiler to put direct calls
into all the specific callback implementations
(copy_user_data_sleepable, copy_user_data_nofault, and so on).

Please put this explanation in the commit message for the next
revision, and maybe also leave a small comment next to
__bpf_dynptr_copy_str and __bpf_dynptr_copy.

> >
> > patch 1 already adds overhead in non-LTO build,
> > since small helper bpf_dynptr_check_off_len() will not be inlined.
> Thanks for pointing this one, I guess bpf_dynptr_check_off_len()
> implementation should be moved to header
> and be inlined?
> > This __always_inline looks odd and probably wrong
> > from optimizations pov.
> >
> > All other __always_inline look wrong too.
> >
> >

[...]


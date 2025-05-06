Return-Path: <bpf+bounces-57539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ED5AACA6D
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 18:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449131BA8375
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85649283CB0;
	Tue,  6 May 2025 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXTVJQY5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE6027933C
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547606; cv=none; b=S5sJkOs+gaqLaUH/3qxQ21aQAVM74vvZffpUk2TTE/+CwWLYPOyxiZssZjVyiF748hs/gotluLnsH8sQJpN1EEK6+VwNdKaZlnm/WGIbsiwY8GGB9YcLsZ/TKviRMVM9zzIYH3QQQThi7wrpLJJ48SRWHeqTAA8K/ffXO44tSBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547606; c=relaxed/simple;
	bh=h9RutqGYBu2uRfKJugqIvlqCpWQFAhP3kBdxw6PAQp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GynG/FvWm2JQYay5hPzi0B4qttPq4NcRkHtLIfrXiAd0Ew/ktI4RNRlguPajT03tRlGpCzx4KwYocokrU1wu3/3A1l4u744G7ALN73ZRHCvkLwb9mX2uR9tyzguci1WhCtoTXQI9SOLEyVhnNcwZzqbhTOhnnaPdg+muttxmd/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXTVJQY5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-391342fc0b5so3505575f8f.3
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 09:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746547602; x=1747152402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THt1Q79bB0MS5OpLVKQyh/mQlif2jBbvrIPdQ9lr76Y=;
        b=kXTVJQY5ZNZqFkU/Rj3oEGFAg85YITi2FxFHysiBcE4uAFSwjr2rfmNBJUTqStR2Cf
         ccTFnA+LxjeaRVDJkez3oGyGVQ+irZuyfe7PHC+i9LwX9OjC+xGiHUgGMCFG+mDKMF//
         lZ68fxLKq/anF1ghoUGKOQjSDWetsMyQZEV4B98NyQjEg1OgPksErGd/f1eROw6zDYCr
         Ouzb6xyrvEfgxhK8Tol4MNqRuT1GIHu4lElsMkV4QUOFQ1s3ru3ZZymwYSX+PvIzKkZx
         aSkjhPjVZTVLA++wnysG3jIeNybImFzZYH5Pq93uYuik4pfUBJULhwD2NFqzVMCFueRA
         3fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746547602; x=1747152402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THt1Q79bB0MS5OpLVKQyh/mQlif2jBbvrIPdQ9lr76Y=;
        b=tFaX0GalCIyMI8SgOj/WZw12mhamZRRsQapghPvtV2lYBNNCrDwBRSAcf38KrizBuL
         bS/tufzpfr/S4MrzdUQiuObWd7dWDB1ehbl0VV3EXC3dWGJFmQXV0qTmqmicWaq4ovgp
         7NhBrAflENzq0i441RkpWxeE1xCw/PZcLTDsk9d7Rprkm612pQUzvDtGe76621/xFF2d
         Ifn2e5jwSBfQdb1wteVS+UhUaPoQ7PoJrh413AyZMzkc5fKmWlUzMmnEQ4z9AMDwWjSo
         jQ20EA8p+tLNTP7bkA+ocydpjpYTqgVp+PQKQz0wtimpXezyhlKH/Tvu3zqI6GIRHUz0
         qusw==
X-Gm-Message-State: AOJu0YyOe5pLsG962AdE3nkFhuKStzgoyAHRxfSWFi8j5TySXUw7Sa0R
	4a3cQrrSFCkuIxbwE6uVYHgPQsHW2yUPkY7YbzZqCxiywFDFylboswzaJJTaRIG0eI6ap7dMreI
	PZg2dmP0LwNvgO3VveLquHkksg0E=
X-Gm-Gg: ASbGnctw7PpZr8MCBMBEyf6NDCiRcaJzgDCU7ZIkS/FKE65IsVgmBXb62UqE66pIR3w
	SM6c/bkCEocoKBRxJk7TS9BuhW+Omm0SYInuIdZVB+mmwxoZj3ed+GbJSFDr6nWer6w0bxTN4Lo
	BfdCwV5ipHM+0OmcWGGalIDbBtHiJvKfUzFO3a2Q==
X-Google-Smtp-Source: AGHT+IE3n3nlCQfNGnQGAJMXACojkVoeYm1o2OVNGtcnV7zZe7+M2vhC1F++TKSjruTGQgtppiZQwUNWMkGBaH+ezus=
X-Received: by 2002:a5d:5f8b:0:b0:39c:30cd:352c with SMTP id
 ffacd0b85a97d-3a0b4a05df1mr11535f8f.8.1746547602213; Tue, 06 May 2025
 09:06:42 -0700 (PDT)
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
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 May 2025 09:06:30 -0700
X-Gm-Features: ATxdqUHggn-MF30lvY57e9VaBJsNEVJ_BfXvuekmmU1mYeo-HIqxQKaCL9swQNs
Message-ID: <CAADnVQK1XwpO6ZLfy7z_sou8HuFBkaOjr1HhTGtMUFrHD+dB6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: implement dynptr copy kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
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

As Andrii suggested please add a comment right in the code
to explain what this always_inline is for.

> >
> > patch 1 already adds overhead in non-LTO build,
> > since small helper bpf_dynptr_check_off_len() will not be inlined.
> Thanks for pointing this one, I guess bpf_dynptr_check_off_len()
> implementation should be moved to header
> and be inlined?

Yes. Please. Otherwise saving on indirect call, but wasting
a direct call for a tiny function looks odd.


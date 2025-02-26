Return-Path: <bpf+bounces-52602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAECA45282
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 02:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66586179EBA
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 01:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511B71AAA0F;
	Wed, 26 Feb 2025 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzdcF+nP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D351A9B52;
	Wed, 26 Feb 2025 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535082; cv=none; b=ro8Up6aAk30ojoO3vYp59i+ljV4OKgG5ii39Gki0gt/YwE5mOYJAUmvJZX3uGLGSHqWBb7M0hYR2v7qKgpyGaXXUx2M1cuJ1cuCgGqSaPTs4BGawm9ipSmQ7RZr6nZIud7a0UGVV/78uydGiLoyE1XLCeRtg63qeW2xronKAfHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535082; c=relaxed/simple;
	bh=wdN1jaQODGwx5/NgvAuOzU3s+ziBsjzTgRgg3aLVOjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=od1OvJDomZ1VXGyRR3E3jgs58eD4Vvyjf+QHdCWYZZx2cTYTZlE+p2Efiqtlsuj/IjB1+bW6IpC6jAfN5q6wy87GDQc4kafEmXgHI8PsEqeAjSPZNGUempJlxL5grfUHz0cTyxe3AZ3+h72ZuTQEcNi33g6qH7RtPbCeZaD5E90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzdcF+nP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-439946a49e1so40011155e9.0;
        Tue, 25 Feb 2025 17:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740535079; x=1741139879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHzaes6TH6B7hJXqk1Wlg42S/TR2u3UC1epvW9tSF1I=;
        b=WzdcF+nPZZwsSgG4Jwl9Gm2i6qdLRH8VGFJN4j96fUmiU0MbDfgy7L6nSx513hbsbZ
         Y+2t9YLYS2vPk7r9BgyRM80oXQs9sKp6QQ2A+K3QAVhvNgWzbQNDQ46mPuBmiYNuopJF
         kyCRzGmmI7v0Iy28SfSD+aft2W/CKxgPtjUHrnA8g2afCrTHdt4jALBoIik23zxVk/RD
         4kJmS/HKjhDS8X6ysxdsAEtyHSfEelVsJBxOT8c3tVZszikspXx3u40995rSbi9zqrxr
         sk7O+btogpFNT2f6NLZJxRcTvIVOKZdEFtBSnB0qjN0UmvFIsWs8gxz+4qs3oQTOVStr
         ivvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740535079; x=1741139879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHzaes6TH6B7hJXqk1Wlg42S/TR2u3UC1epvW9tSF1I=;
        b=foZ5jN77/yoHBpainZrmzbi8oRVlwq1Ax9whzCU3g6MggaOn1TUC9iKjxUDVSDyZD2
         +P6/md/fCpVDj8/+2lqKIqIAYRl6vJzaxISvugHCe6+Fp0JORkeRtok1xF/mzptHqYm4
         1mWnqj2RMjDCsR2qtTbHTyEOWYaXA0boWB1h6SLgGIHHcAkviUFIk/MgVZ86T/etVRyO
         iJfBexwnY2XcLpVNJp4BiKDLCWLtJ80qN3r/PKo5BdZ+ParnoCRWgOqt06nvm9k3O00J
         Sk82VnKdip2R1czn9HWCoOjtC7wKbKX8jsUuKlVbgorgjhnYvjsCodF4ehewT96Zba8O
         65vw==
X-Forwarded-Encrypted: i=1; AJvYcCV1brfLxmm6TVdi9gbu48Jw04fggVBxNrtt9tw22SatH8Rjp02Q/BoI7LoV7nEfBVUoNKI=@vger.kernel.org, AJvYcCVSukvfaTIRQyizBU+MGQ2Z4IpNVQlvGQizEMFe/Ry3TAAJ4niOQv89uoz7W4MjZ4LE8X2HUUvmVk4+buYe@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf8ordNZ81wptuz0AyidRBKSEYcrQRtIogPFaSKh/SNvrT69Hs
	5pmztOd88DOXMw1mHugLpYKwS3MKrOReuGwcR21tPjp/7zGf8vyKhtodeEpd/d1Ye2JG4ohcUwu
	Yyazwc4qjPrPcrdE6Re4WbQfB588=
X-Gm-Gg: ASbGncsmMMsSVPpoOUDkbC8ebuSw0pIKtmC63+coCHrsxLYYc4p5Gg92r5k2i75idcY
	aVCpoJBg7OqahxRcpH+k53ITfb7ks57LAyesCj+bevHdjI0TrcDE4FYsX1JjGvpS5bxWFGTQdhq
	m7Sq14D8EC/p1ecP0zdveqogo=
X-Google-Smtp-Source: AGHT+IFO6/dJyoTf/Xa1UP3OB5XVQqcvDm13BIuavJhyPluLlJK5clgZ3kqtohjqlYYhjC8zaIwj8uhogoYr6zzuyzo=
X-Received: by 2002:a05:600c:450c:b0:434:fb65:ebbb with SMTP id
 5b1f17b1804b1-43ab8fe995amr12456765e9.17.1740535078910; Tue, 25 Feb 2025
 17:57:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080FFF4113C70F7862AAA5D99FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLR0=L7xwh1SpDfcxRUhVE18k_L8g3Kx+Ykidt7f+=UhQ@mail.gmail.com> <AM6PR03MB50802FB7A70353605235806E99C32@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB50802FB7A70353605235806E99C32@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Feb 2025 17:57:47 -0800
X-Gm-Features: AQ5f1Jo_CUowQ4QBm9bjekRCzahCOwBtZ3wBGebmjJg5fbjCMlLjByLydrkMYYM
Message-ID: <CAADnVQ+TzLc=Z_Rp-UC6s9gg5hB1byd_w7oT807z44NuKC_TxA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 4/6] bpf: Add bpf runtime hooks for tracking
 runtime acquire/release
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 3:34=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> On 2025/2/25 22:12, Alexei Starovoitov wrote:
> > On Thu, Feb 13, 2025 at 4:36=E2=80=AFPM Juntong Deng <juntong.deng@outl=
ook.com> wrote:
> >>
> >> +void *bpf_runtime_acquire_hook(void *arg1, void *arg2, void *arg3,
> >> +                              void *arg4, void *arg5, void *arg6 /* k=
func addr */)
> >> +{
> >> +       struct btf_struct_kfunc *struct_kfunc, dummy_key;
> >> +       struct btf_struct_kfunc_tab *tab;
> >> +       struct bpf_run_ctx *bpf_ctx;
> >> +       struct bpf_ref_node *node;
> >> +       bpf_kfunc_t kfunc;
> >> +       struct btf *btf;
> >> +       void *kfunc_ret;
> >> +
> >> +       kfunc =3D (bpf_kfunc_t)arg6;
> >> +       kfunc_ret =3D kfunc(arg1, arg2, arg3, arg4, arg5);
> >> +
> >> +       if (!kfunc_ret)
> >> +               return kfunc_ret;
> >> +
> >> +       bpf_ctx =3D current->bpf_ctx;
> >> +       btf =3D bpf_get_btf_vmlinux();
> >> +
> >> +       tab =3D btf->acquire_kfunc_tab;
> >> +       if (!tab)
> >> +               return kfunc_ret;
> >> +
> >> +       dummy_key.kfunc_addr =3D (unsigned long)arg6;
> >> +       struct_kfunc =3D bsearch(&dummy_key, tab->set, tab->cnt,
> >> +                              sizeof(struct btf_struct_kfunc),
> >> +                              btf_kfunc_addr_cmp_func);
> >> +
> >> +       node =3D list_first_entry(&bpf_ctx->free_ref_list, struct bpf_=
ref_node, lnode);
> >> +       node->obj_addr =3D (unsigned long)kfunc_ret;
> >> +       node->struct_btf_id =3D struct_kfunc->struct_btf_id;
> >> +
> >> +       list_del(&node->lnode);
> >> +       hash_add(bpf_ctx->active_ref_list, &node->hnode, node->obj_add=
r);
> >> +
> >> +       pr_info("bpf prog acquire obj addr =3D %lx, btf id =3D %d\n",
> >> +               node->obj_addr, node->struct_btf_id);
> >> +       print_bpf_active_refs();
> >> +
> >> +       return kfunc_ret;
> >> +}
> >> +
> >> +void bpf_runtime_release_hook(void *arg1, void *arg2, void *arg3,
> >> +                             void *arg4, void *arg5, void *arg6 /* kf=
unc addr */)
> >> +{
> >> +       struct bpf_run_ctx *bpf_ctx;
> >> +       struct bpf_ref_node *node;
> >> +       bpf_kfunc_t kfunc;
> >> +
> >> +       kfunc =3D (bpf_kfunc_t)arg6;
> >> +       kfunc(arg1, arg2, arg3, arg4, arg5);
> >> +
> >> +       bpf_ctx =3D current->bpf_ctx;
> >> +
> >> +       hash_for_each_possible(bpf_ctx->active_ref_list, node, hnode, =
(unsigned long)arg1) {
> >> +               if (node->obj_addr =3D=3D (unsigned long)arg1) {
> >> +                       hash_del(&node->hnode);
> >> +                       list_add(&node->lnode, &bpf_ctx->free_ref_list=
);
> >> +
> >> +                       pr_info("bpf prog release obj addr =3D %lx, bt=
f id =3D %d\n",
> >> +                               node->obj_addr, node->struct_btf_id);
> >> +               }
> >> +       }
> >> +
> >> +       print_bpf_active_refs();
> >> +}
> >
> > So for every acq/rel the above two function will be called
> > and you call this:
> > "
> > perhaps we can use some low overhead runtime solution first as a
> > not too bad alternative
> > "
> >
> > low overhead ?!
> >
> > acq/rel kfuncs can be very hot.
> > To the level that single atomic_inc() is a noticeable overhead.
> > Doing above is an obvious no-go in any production setup.
> >
> >> Before the bpf program actually runs, we can allocate the maximum
> >> possible number of reference nodes to record reference information.
> >
> > This is an incorrect assumption.
> > Look at register_btf_id_dtor_kfuncs()
> > that patch 1 is sort-of trying to reinvent.
> > Acquired objects can be stashed with single xchg instruction and
> > people are not happy with performance either.
> > An acquire kfunc plus inlined bpf_kptr_xchg is too slow in some cases.
> > A bunch of bpf progs operate under constraints where nanoseconds count.
> > That's why we rely on static verification where possible.
> > Everytime we introduce run-time safety checks (like bpf_arena) we
> > sacrifice some use cases.
> > So, no, this proposal is not a solution.
>
> OK, I agree, if single atomic_inc() is a noticeable overhead, then any
> runtime solution is not applicable.
>
> (I had thought about using btf id as another argument to further
> eliminate the O(log n) overhead of binary search, but now it is
> obviously not enough)
>
>
> I am not sure, BPF runtime hooks seem to be a general feature, maybe it
> can be used in other scenarios?
>
> Do you think there would be value in non-intrusive bpf program behavior
> tracking if it is only enabled in certain modes?
>
> For example, to help us debug/diagnose bpf programs.

Unlikely. In general we don't add debug code to the kernel.
There are exceptions like lockdep and kasan that are there to
debug the kernel itself and they're not enabled in prod.
I don't see a use case for "let's replace all kfuncs with a wrapper".
perf record/report works on bpf progs, so profiling/perf analysis
part of bpf prog is solved.
Debugging of bpf prog for correctness is a different story.
It's an interesting challenge on its own, but
wrapping kfuncs won't help.
Debugging bpf prog is not much different than debugging normal kernel code.
Sprinkle printk is typically the answer.


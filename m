Return-Path: <bpf+bounces-50078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8045CA2273D
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 01:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C6C188655D
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 00:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51857464;
	Thu, 30 Jan 2025 00:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fta9FzCi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C848F64;
	Thu, 30 Jan 2025 00:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738197164; cv=none; b=ACnvzDqTCKchIGOMqGmmeEYwr1OdPnS79Kvo3cL258pIRrO5YXdGnnNQZlNDWb7PUwpdY2w7HM7aYZ9Zzxlp/PgJCruMrCRkFkVhvo3MoA5IzlaAuIO7DFCtkzH9VtFEds5n0H0HKC74uTJ70wmMbwtKcxTn686rBtrf2GGmFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738197164; c=relaxed/simple;
	bh=DDB7bg56NMUnL0uBNcrrhWdgBIpdvW8qwY9az36IAfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7abOcasJdg+PaHDPNfswIPc6cej98549PU1pqYCisbftnhkUG+lNHJDXwSpVjpxTmRnzdpEKAS4QYsbCm5HLX0/e6BSE2G19may1IlH6yiPHaGek5asN1ZMhjPHorvZH4JOTFLZJyM85O44JhUv1D69fVo/v7QBgY5CwT9L0L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fta9FzCi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361c705434so1148515e9.3;
        Wed, 29 Jan 2025 16:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738197161; x=1738801961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNzfEvmIosIfU1ngPn58wZoWxqS9wyN0+JhAfuT1oug=;
        b=Fta9FzCiGATtqLCWiQGJ4rLgYLEKRB3UIId2CFBHrFARsdSELM/hfaBGa/he8btNGO
         H79IZaMkdTTclIK5RQNeH4LC4cTTs1n84KCg7uQuV30vngfEyj1Z14OcQvRVDyUydzSx
         rmTQz6j0Rh4DIUMiKrWVe+4VqNEkLJO4TBvEBOcCgVuU9J+u88JUTuQVoUz+CDz7ZcGt
         zttCPyn+VcO38DHIRfxHyNYjnjJ+BQG0XACv2R//ZTK1Gj6Vl8RUeuoEsoOoOrdrADII
         FE4RsNw4+EuMnc/1I6ZpaVt26cF2vMh2L1LjdImmm+C4bljLeBagOthiE+0I+J1eEqSs
         FgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738197161; x=1738801961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNzfEvmIosIfU1ngPn58wZoWxqS9wyN0+JhAfuT1oug=;
        b=FmK+n5bQ9Ow8rn5Adew4IxTOp6jwYNRaYfzLkpo8mRSYHNU+Zz/Oeb5VLMMDl/7sGU
         0kfchtpYLRyplw/rHVwtPXidEploo3pNBjxN5mb6u88YzdHlxW/7sC3sDVomsY6dVO+W
         Ufnh501y535kzrl2vwpENcyofXSeXjyltszTd5PWiYD8FAtG+FGe6g1t2iNVF4DoRoR/
         bbeazNEWha8gMlgrscAF+g2wUH5Oo8C/7rxidgvLtGOwtARwYUQv29eLOw/fp86exr4C
         wsTQFLnsjZG3czNUiblm+bPyWm9JFkyNb/7jn9JfvF0iGOHsaPAMPoKqeT+tZiVEk4Mf
         Hj2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUd/9pPpmZZYY3qoFARzvfk92KbCbIW5fX6K2wEqiEGPMt8/wjhNZ9GQl1fnOjiuPN3q/I=@vger.kernel.org, AJvYcCVyerlau0Em0GoWQ4G4NmfdL0eggwoKQCAHaie/TH3gxnCtxW3nxj26wZtQUv1XeUjd7Zy2ExkWvxpLmcwL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt2wwRhwkQw1lA3UOoI9FwGLpnp/r7Crbr1GMgLtsO3WdMUq+W
	y1RHwLP1XZHwCcufeD9QCBXfHUoLaGgTEw4hZhPFq8sN+d4Cl36DZEzry29a9t6xenRoGYNbWXJ
	UBwaZoN0Q2geD8aGFGN/NTp+olYE=
X-Gm-Gg: ASbGnctKzt4Io+z0V1TsjCoe9tGffUGgvc23MlP1/uH1lXcyEg2LdiQSmpa9vrKGWnd
	WsB2a01obYhJ4qs3F9yF31j2XlnqEF8HthY89xctHupfwTF1Ixr3arkHDf+WEK9ZAjFPLZxMW9r
	f7hN9PAhTDZuu9aK6BEOkNj4GjVEs2
X-Google-Smtp-Source: AGHT+IEeFINjC/PS45B3CX1IvC3COG13SjBgpFW6KdRZ53J9i76fzk41QBl+YeP3YC6GTiac3T6gmvBce6S9cZmsyY0=
X-Received: by 2002:a05:600c:3d96:b0:434:fe3c:c67c with SMTP id
 5b1f17b1804b1-438dc41d7b0mr39398365e9.26.1738197160384; Wed, 29 Jan 2025
 16:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50802A825536C00D2B53333C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLidcL-WU-VWXZtBph=qjJfAhoyrsYWyL7JwB0ZEH5KFQ@mail.gmail.com> <AM6PR03MB508053DF89CDFEB95CBEB20C99E32@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB508053DF89CDFEB95CBEB20C99E32@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Jan 2025 16:32:29 -0800
X-Gm-Features: AWEUYZlwuECsWL28zSlFQ_NeuuPdVQ0K8Lec8PolHq1YLAepHv0utvfsqH1Vnpw
Message-ID: <CAADnVQJN+C2Bdoe1w62vmDrPhcoweBxBy8Ck4a_SWrd5k=493A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 6/7] sched_ext: Make SCX use BPF capabilities
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 2:45=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> On 2025/1/24 04:52, Alexei Starovoitov wrote:
> > On Thu, Jan 16, 2025 at 11:47=E2=80=AFAM Juntong Deng <juntong.deng@out=
look.com> wrote:
> >>
> >> This patch modifies SCX to use BPF capabilities.
> >>
> >> Make all SCX kfuncs register to BPF capabilities instead of
> >> BPF_PROG_TYPE_STRUCT_OPS.
> >>
> >> Add bpf_scx_bpf_capabilities_adjust as bpf_capabilities_adjust
> >> callback function.
> >>
> >> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> >> ---
> >>   kernel/sched/ext.c | 74 ++++++++++++++++++++++++++++++++++++++------=
--
> >>   1 file changed, 62 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> >> index 7fff1d045477..53cc7c3ed80b 100644
> >> --- a/kernel/sched/ext.c
> >> +++ b/kernel/sched/ext.c
> >> @@ -5765,10 +5765,66 @@ bpf_scx_get_func_proto(enum bpf_func_id func_i=
d, const struct bpf_prog *prog)
> >>          }
> >>   }
> >
> > 'capabilities' name doesn't fit.
> > The word already has its meaning in the kernel.
> > It cannot be reused for a different purpose.
> >
> >> +static int bpf_scx_bpf_capabilities_adjust(unsigned long *bpf_capabil=
ities,
> >> +                                          u32 context_info, bool ente=
r)
> >> +{
> >> +       if (enter) {
> >> +               switch (context_info) {
> >> +               case offsetof(struct sched_ext_ops, select_cpu):
> >> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CA=
P_SCX_KF_SELECT_CPU);
> >> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CA=
P_SCX_KF_ENQUEUE);
> >> +                       break;
> >> +               case offsetof(struct sched_ext_ops, enqueue):
> >> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CA=
P_SCX_KF_ENQUEUE);
> >> +                       break;
> >> +               case offsetof(struct sched_ext_ops, dispatch):
> >> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CA=
P_SCX_KF_DISPATCH);
> >> +                       break;
> >> +               case offsetof(struct sched_ext_ops, running):
> >> +               case offsetof(struct sched_ext_ops, stopping):
> >> +               case offsetof(struct sched_ext_ops, enable):
> >> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CA=
P_SCX_KF_REST);
> >> +                       break;
> >> +               case offsetof(struct sched_ext_ops, init):
> >> +               case offsetof(struct sched_ext_ops, exit):
> >> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CA=
P_SCX_KF_UNLOCKED);
> >> +                       break;
> >> +               default:
> >> +                       return -EINVAL;
> >> +               }
> >> +       } else {
> >> +               switch (context_info) {
> >> +               case offsetof(struct sched_ext_ops, select_cpu):
> >> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_C=
AP_SCX_KF_SELECT_CPU);
> >> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_C=
AP_SCX_KF_ENQUEUE);
> >> +                       break;
> >> +               case offsetof(struct sched_ext_ops, enqueue):
> >> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_C=
AP_SCX_KF_ENQUEUE);
> >> +                       break;
> >> +               case offsetof(struct sched_ext_ops, dispatch):
> >> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_C=
AP_SCX_KF_DISPATCH);
> >> +                       break;
> >> +               case offsetof(struct sched_ext_ops, running):
> >> +               case offsetof(struct sched_ext_ops, stopping):
> >> +               case offsetof(struct sched_ext_ops, enable):
> >> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_C=
AP_SCX_KF_REST);
> >> +                       break;
> >> +               case offsetof(struct sched_ext_ops, init):
> >> +               case offsetof(struct sched_ext_ops, exit):
> >> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_C=
AP_SCX_KF_UNLOCKED);
> >> +                       break;
> >> +               default:
> >> +                       return -EINVAL;
> >> +               }
> >> +       }
> >> +       return 0;
> >> +}
> >
> > and this callback defeats the whole point of u32 bitmask.
> >
>
> Yes, you are right, I agree that procedural callbacks defeat the purpose
> of BPF capabilities.
>
> > In earlier patch
> > env->context_info =3D __btf_member_bit_offset(t, member) / 8; // moff
> >
> > is also wrong.
> > The context_info name is too generic and misleading.
> > and 'env' isn't a right place to save moff.
> >
> > Let's try to implement what was discussed earlier:
> >
> > 1
> > After successful check_struct_ops_btf_id() save moff in
> > prog->aux->attach_st_ops_member_off.
> >
> > 2
> > Add .filter callback to sched-ext kfunc registration path and
> > let it allow/deny kfuncs based on st_ops attach point.
> >
> > 3
> > Remove scx_kf_allow() and current->scx.kf_mask.
> >
> > That will be a nice perf win and will prove that
> > this approach works end-to-end.
>
> I am trying, but I found a problem (bug?) when I added test cases
> to bpf_testmod.c.
>
> Filters currently do not work with kernel modules.
>
> Filters rely heavily on (bpf_fs_kfunc_set_ids as an example)
>
> if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id)
>
> exclude kfuncs that are not part of its own set
> (__btf_kfunc_id_set_contains performs all the filters for each kfunc),
> otherwise it will result in false rejects.
>
> But this method cannot be used in kernel modules because the BTF ids of
> all kfuncs are relocated.
>
> The BTF ids of all kfuncs in the kernel module will be relocated by
> btf_relocate_id in btf_populate_kfunc_set.
>
> This results in the kfunc_id passed into the filter being different from
> the BTF id in set_ids.
>
> One possible solution is to export btf_relocate_id and
> btf_get_module_btf, and let the kernel module do the relocation itself.
>
> But I am not sure exporting them is a good idea.
>
> Do you have any suggestions?

That's not a problem to fix today.
Currently only sched-ext needs this new ->filter() logic
and it's builtin.
Let's prototype the steps 1,2,3 end-to-end and see whether
anything big is missing.
The lack of bpf_testmod can be addressed later if the whole
approach works for sched-ext.

> In addition, BTF_KFUNC_FILTER_MAX_CNT is currently 16, which is not a
> large enough size.
>
> If we use filters to enforce restrictions on struct_ops for different
> contexts, then each different context needs a filter.
>
> All filters for scenarios using struct_ops (SCX, HID, TCP congestion,
> etc.) are placed in the same struct btf_kfunc_hook_filter
> (filters array).
>
> It is foreseeable that the 16 slots will be exhausted soon.
>
> Should we change it to a linked list?

No. Don't fix what is not broken.
We have a concrete run-time inefficiency on sched-ext side
let's address that first and deal with everything later.
Not the other way around.


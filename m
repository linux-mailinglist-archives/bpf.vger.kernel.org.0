Return-Path: <bpf+bounces-47289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B6C9F714A
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 01:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC8916AC63
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 00:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8935C8BEE;
	Thu, 19 Dec 2024 00:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqUoI83P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FD517C;
	Thu, 19 Dec 2024 00:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734567490; cv=none; b=kg3Y26H7yIMR17vLxtE8V9J+pX4qYdVyHazgVNFzD314b5sTOR9oKhh+O0JPs4tbD0ern4MHOKUVYTOSR9mimiwS2KBQM40vw/syCnHuJD4bwb3s+/ltefrdLJCx5DBZos26bfbDibuy3c8Kfftwo7ZrNe3zA2W3fAsa2ocAXwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734567490; c=relaxed/simple;
	bh=3nMMzhab8rGgGn1eCpiUJHnKpt5lb5dLBY/jaiTRmAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAFtv7vpL9h3/TU4XheT5tHc4Q5jN+nIHrBLeMl3spgqUS1koIzLX5Syg4mZD3KgICsulEDQ+ckzYDYLniaHLG2GLOmym5a0PUPkId/6g3LqTob5f1nV4R4zZWgP+GLd/z9dFDJssKQp4EiqMg8UixK7LQDvbB/LgvlE8cXrjt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqUoI83P; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385eed29d17so132711f8f.0;
        Wed, 18 Dec 2024 16:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734567486; x=1735172286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocjGNIZOXTAe/187ptT/PLf4c0wni1IvAs8DZOiJ7g4=;
        b=BqUoI83PnxzUiTd7IKsnCrBw03+sl45VcGdMAKtKJqxRKAO4Zk6Hhj+W2OG6g6AKsY
         XPXgAdyGPLZQ3EscoMHtFhuNcE5jxqZOCXrgSsCIYWC19syonT8hR7yksSlwGazWF1P7
         L4h/97p6hzwLsu6CurF0SUEPYRZU0Qn8tvD9UJnJOjfaYof8BGTa3tVxVGYnhyEWshMQ
         zOEHfXu5eanxFUwDDngKG9ZNKsIJPKVkZ35+cqz8lT82eDzr+AIGry9Up4MzTocPtUKT
         BBrjrY8XlO6osNgSV2+TWwP+68sloLHSJeAJ74BHXSzkKSXwvuxbJ5pBwagMx3R4X4t0
         SH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734567486; x=1735172286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocjGNIZOXTAe/187ptT/PLf4c0wni1IvAs8DZOiJ7g4=;
        b=N3DVbcZvTK8xu3J+M4xY8DQb6FUDcdG/xGyVWHsHh+IIOI5THksQWLXm1W8Lj2La2F
         TzrmcwrCzKKLJ4rNqxnus86iIhVv/gJf9X0xUgSWzIFkcG/2+Gzlk/d16awvUjlvILo1
         RsTrUJVAUYmLHi0ulBrpmsfhoU/cY1diwSvp4OnkAFN9X0XLEYiaQbV7YxLAwpJcIE/w
         Yz2jN0ZOejYl6GpO67LFVHtAvdtoCjCoyJGoZ1DerpaID8Sezk63qJB69r+aD/KnyaE6
         0HyuZ1H7DB4bOGGG5BnFXYE7C9TMXNZX4QYRCd4mZ0KLqLYo2bi59QrIf3byJ3e+Zquo
         C84Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqS7x8vetLpF+23zdGWhYcZEb+uHxnR7jx/DPNugOamPhTfXqYhuanL2JoKgqJXmpduM4jNMWsXqXf/yTvGEDcyMgTNdlp@vger.kernel.org, AJvYcCVjAB0+izeUl5Sr1h8XGRAHu+YWpHyqTU2Wa6eUa6vuJ/RKmWPRIhZlEi6L3gXMV0ly86s=@vger.kernel.org, AJvYcCVnpP8RBeZM5lTOx18KrKjdGqeEO/PCS6q6IsY3+tQv31EqFBlL+hsSC76b8v29XiLDRDOCrYoi0PmdQTqg@vger.kernel.org
X-Gm-Message-State: AOJu0YwDbXSf7nffYyxv9ik0swYnr08Yn5MOR+AvvdIkYf0iwie5Z+zE
	Hv1JSit1S5MV0cTTiH5ltVOtlX/4ILDdMy9GbmzKbSTXpQqH5+DwuskBbUdiBDygy6HYNNFlnPB
	W5uJIHkn1NfnrLeFrZfrg+n46n80=
X-Gm-Gg: ASbGncszYRqDstTI/34laZs5PVlrsbQPK3JSWDGmaD/+LuycKwM7bzYBZDwK533gJAQ
	mCqjW56sw0DyrAPV0r2cVS4OCr/GHNVvcZAtQgA==
X-Google-Smtp-Source: AGHT+IE7zrIRkEdfBtKKDqD0ZtdqypQLYrkus+P+4ue1HEXEgpnGcTL+NsYBTMNoDCXxwWLno8+ZBpk3i5xFbbZE7MM=
X-Received: by 2002:a05:6000:1b8b:b0:388:da2a:653d with SMTP id
 ffacd0b85a97d-388e4dadd2fmr3911916f8f.56.1734567486335; Wed, 18 Dec 2024
 16:18:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218044711.1723221-1-song@kernel.org> <20241218044711.1723221-5-song@kernel.org>
 <CAADnVQK2chjFr8EwpzbnsqLwGRfoxjRs6yXDXmUuBRFo-iwV_A@mail.gmail.com> <BF2BF0EC-90C2-4BFC-B1F3-D842AE1B7761@fb.com>
In-Reply-To: <BF2BF0EC-90C2-4BFC-B1F3-D842AE1B7761@fb.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Dec 2024 16:17:55 -0800
Message-ID: <CAADnVQ+vgt=LV+3srtGQUtKKc3ohZkaMdHyouXThNmYG2qGoYg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/5] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 1:47=E2=80=AFPM Song Liu <songliubraving@meta.com> =
wrote:
>
> Hi Alexei,
>
> Thanks for the review!
>
> > On Dec 18, 2024, at 1:20=E2=80=AFPM, Alexei Starovoitov <alexei.starovo=
itov@gmail.com> wrote:
> >
> > On Tue, Dec 17, 2024 at 8:48=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> >>
> >>
> >> BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> >> @@ -170,6 +330,10 @@ BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
> >> BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
> >> BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARG=
S)
> >> BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> >> +BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_AR=
GS)
> >> +BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED=
_ARGS)
> >> +BTF_ID_FLAGS(func, bpf_set_dentry_xattr_locked, KF_SLEEPABLE | KF_TRU=
STED_ARGS)
> >> +BTF_ID_FLAGS(func, bpf_remove_dentry_xattr_locked, KF_SLEEPABLE | KF_=
TRUSTED_ARGS)
> >> BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
> >
> > The _locked() versions shouldn't be exposed to bpf prog.
> > Don't add them to the above set.
> >
> > Also we need to somehow exclude them from being dumped into vmlinux.h
> >
> >> static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc=
_id)
> >> @@ -186,6 +350,37 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc=
_set =3D {
> >>        .filter =3D bpf_fs_kfuncs_filter,
> >> };
>
> [...]
>
> >> + */
> >> +static void remap_kfunc_locked_func_id(struct bpf_verifier_env *env, =
struct bpf_insn *insn)
> >> +{
> >> +       u32 func_id =3D insn->imm;
> >> +
> >> +       if (bpf_lsm_has_d_inode_locked(env->prog)) {
> >> +               if (func_id =3D=3D special_kfunc_list[KF_bpf_set_dentr=
y_xattr])
> >> +                       insn->imm =3D  special_kfunc_list[KF_bpf_set_d=
entry_xattr_locked];
> >> +               else if (func_id =3D=3D special_kfunc_list[KF_bpf_remo=
ve_dentry_xattr])
> >> +                       insn->imm =3D special_kfunc_list[KF_bpf_remove=
_dentry_xattr_locked];
> >> +       } else {
> >> +               if (func_id =3D=3D special_kfunc_list[KF_bpf_set_dentr=
y_xattr_locked])
> >> +                       insn->imm =3D  special_kfunc_list[KF_bpf_set_d=
entry_xattr];
> >
> > This part is not necessary.
> > _locked() shouldn't be exposed and it should be an error
> > if bpf prog attempts to use invalid kfunc.
>
> I was implementing this in different way than the solution you and Kumar
> suggested. Instead of updating this in add_kfunc_call, check_kfunc_call,
> and fixup_kfunc_call, remap_kfunc_locked_func_id happens before
> add_kfunc_call. Then, for the rest of the process, the verifier handles
> _locked version and not _locked version as two different kfuncs. This is
> why we need the _locked version in bpf_fs_kfunc_set_ids. I personally
> think this approach is a lot cleaner.

I see. Blind rewrite in add_kfunc_call() looks simpler,
but allowing progs call _locked() version directly is not clean.

See specialize_kfunc() as an existing approach that does polymorphism.

_locked() doesn't need to be __bpf_kfunc annotated.
It can be just like bpf_dynptr_from_skb_rdonly.

There will be no issue with vmlinux.h as well.


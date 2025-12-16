Return-Path: <bpf+bounces-76746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 923B8CC4ECA
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0BD13007A99
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4419133C539;
	Tue, 16 Dec 2025 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hva9esgN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3833555B
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765910297; cv=none; b=nw2teVMN/0SD1QNI6KUmCM58CKSFD1707egYlTakolrsjCg7P4KLozWFy01fbxdwg4DNEZWpncllY78hEuLOgiHSelkYUabjECTq2VmYmLtVK68gdDamik+IFVh/lUB3KEETL7dyhXw15FRdNG+zlASghpLV/4BNSF16dtr7mIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765910297; c=relaxed/simple;
	bh=bmqRT+CXaLg9LDfi3NJNLdJbHsVhOQ3MZZiKOZELRPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhNftcfwVfPfTeAL1MmTngCxIzaABIVPQQ3OZN5LpoZ76aq76/9BXqEFnZniacR7NsHQkG5Fj6uf6wfDuDKwDVvk29FPQon5fPKmgra0vxYfFeeptYmBRV9H5UV2MyLok7nJQir+Ww+C06Yh0MP9XTmZCcIFid19kzilzBsA2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hva9esgN; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c27d14559so3026506a91.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 10:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765910295; x=1766515095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NpSLKxwLjHlfQrNl/9y7NoB/daOF2LvmIGA3+Zw7WY=;
        b=hva9esgN6MCCmo0bDbKmCkWroBVCHc3Zx3W45OVXYWEYP1rshFh1eJK1w3NQxau2Ii
         pAefY9xD1dGQEcTp1gy5J2JRSn3Zb5PLNm08U5U8Nxz52cSw2mfRpDSyEXHpBu1FPtBS
         stmIT+NzX1J+0v6nCrrIrhAgNgtCbQPzj8wXjdNNHL3xNCJTEcuIvJRbj8RTnhKtWjWf
         z3p3a08DvG+uGh7vTZU+n+5pVKLHduo+sQaLdqwmPmu17rDML2xng5QGDSzUmKmnELeK
         OMzBZNaLUbmKA5i6VU5UJJRUEPhQMBdIjdm5sKhnvYPddzZBpn/5SoMVjyxDIqsr/Q3o
         qjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765910295; x=1766515095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+NpSLKxwLjHlfQrNl/9y7NoB/daOF2LvmIGA3+Zw7WY=;
        b=vTmGVQJIxMV4sbPdVKQhM4eDEq9lc7+8ay2PDTyskoptvjqCplmpUUabNLMWAdFQE1
         UQ1Swhi2/0oBhkrzikMnAfdt47coZ4cAlRI2SIQrLx4MJ2Acca2OuTVx3ssfGz5oauh1
         /atppxtL23V51VmVJ59gMz89i3TUQe6xmvV75sabjnyK3S3zuLQ49W8TrHQvmTsvuHpz
         gaypNRFH46euozAj7NaEAkjzp35E0md0FVCQBWJ5uAks068Gp+lLIR4PzTDvQGUb9GMc
         Xkt9JPUWpmAAVqAF6acUsH7ZaR9T1tZMnlZU6YwxML/ktGYrfj80CwZhC2xjgV/7cpeM
         zyEA==
X-Forwarded-Encrypted: i=1; AJvYcCXdytqfriqtIxfZK5/Zb6b6bA/ZX7QDc/WctxDgUwiPBzx+7bpku/bVkU8j9cNAZmVi58s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXdzYwrZ+xojMUWuLkYd5b1Pw2woEoetmi4/Kv7h8W3nM/NW/m
	2ZjgfQm3LGe0q4IRBDeCsjROlS+D8Ve0stTHtWyz/BIwP9wS6Vtqsr2MWEVLDOYNwSHGrIfxcby
	DhjMd+gMTQ1/rFAa4X7upGtuUFv0FG+s=
X-Gm-Gg: AY/fxX5Re/4gVzhmiESiMjhHNQ8jx99jlLk2hFi0ZTro68245GIZUjKujbWbeyXgB1d
	1DRsAog/fMdR54SwgG7uv5y6Aqh14HQ3eiBTdogZj2tuL80YOokHZD5ktlj/YskC8FPOLyhqCFG
	ItaS7k5x/h3VcwKbATGlUCSMA+SA4h09Y+flsedPIc7o7PYkiDc1YPIZ8Pe/VP4D+3H/w/xwo4P
	VyCAPKyEteLpTTzpdUTkpvF+8/xD6zgwjEJ0e6mqlOODeTOBd8fOupodxaw0SIW2CcLNjsVGDh4
	c9Hq/tMPvQ4=
X-Google-Smtp-Source: AGHT+IE6jNpRTJNc2Wx/sUwqD+E0Woo54Si+ejrTmEM6h/2u9FU0CNWYJdgBFlIxBT4DEk3sglqOhP8MB4T8w97ujsw=
X-Received: by 2002:a17:90b:51c7:b0:340:c151:2d66 with SMTP id
 98e67ed59e1d1-34abd858b30mr13576434a91.30.1765910294946; Tue, 16 Dec 2025
 10:38:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216173325.98465-3-emil@etsalapatis.com> <0447c47ac58306546a5dbdbad2601f3e77fa8eb24f3a4254dda3a39f6133e68f@mail.kernel.org>
In-Reply-To: <0447c47ac58306546a5dbdbad2601f3e77fa8eb24f3a4254dda3a39f6133e68f@mail.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 10:38:02 -0800
X-Gm-Features: AQt7F2rJXyGM8nZzI9Y4eqyg3rJmxr5dcJnO6STELw69Vv8zvVKXpg3Y_iUQfMw
Message-ID: <CAEf4BzazeSaj5MgF01uDMOdiMDSA=YVU=kvzSDKB_Hx7NOARtw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] bpf/verifier: do not limit maximum direct offset
 into arena map
To: bot+bpf-ci@kernel.org, Anton Protopopov <a.s.protopopov@gmail.com>
Cc: emil@etsalapatis.com, bpf@vger.kernel.org, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	memxor@gmail.com, yonghong.song@linux.dev, martin.lau@kernel.org, 
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 10:02=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a31c032b2dd6..d6b8a77fbe3b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -21132,11 +21132,6 @@ static int resolve_pseudo_ldimm64(struct bpf_v=
erifier_env *env)
> >               } else {
> >                       u32 off =3D insn[1].imm;
> >
> > -                     if (off >=3D BPF_MAX_VAR_OFF) {
> > -                             verbose(env, "direct value offset of %u i=
s not allowed\n", off);
> > -                             return -EINVAL;
> > -                     }
> > -
> >                       if (!map->ops->map_direct_value_addr) {
> >                               verbose(env, "no direct value access supp=
ort for this map type\n");
> >                               return -EINVAL;
>
> The map_direct_value_addr() implementations for array and arena maps
> return only the base address, and then resolve_pseudo_ldimm64() adds the
> offset at line 21148:
>
>     aux->map_off =3D off;
>     addr +=3D off;
>
> However, insn_array_map_direct_value_addr() (kernel/bpf/bpf_insn_array.c)
> has a different implementation pattern:
>
>     static int insn_array_map_direct_value_addr(const struct bpf_map *map=
,
>                                                  u64 *imm, u32 off)
>     {
>         struct bpf_insn_array *insn_array =3D cast_insn_array(map);
>
>         if ((off % sizeof(long)) !=3D 0 ||
>             (off / sizeof(long)) >=3D map->max_entries)
>             return -EINVAL;
>
>         /* from BPF's point of view, this map is a jump table */
>         *imm =3D (unsigned long)insn_array->ips + off;
>
>         return 0;
>     }
>
> Notice that insn_array adds the offset to the base address inside the
> function (line: *imm =3D (unsigned long)insn_array->ips + off). When
> resolve_pseudo_ldimm64() then adds the offset again at line 21148, the
> result is:
>
>     addr =3D (insn_array->ips + off) + off =3D insn_array->ips + 2*off
>
> Can this cause insn_array maps to access incorrect array elements? For
> example, if a program requests offset 32 (which passes the bounds check
> since 32/8 =3D 4 < max_entries), the actual offset becomes 64, potentiall=
y
> accessing insn_array->ips[8] when max_entries is only 10.

That's a question to Anton (cc'ed), not really related to this patch.
Anton, please check and send a fix, if necessary.

>
> Before this commit, the BPF_MAX_VAR_OFF limit (512MiB) prevented the
> double-offset from becoming too large, but removing this limit allows
> offsets up to UINT32_MAX, making the doubled offset up to 8GB.
>
> > diff --git a/tools/testing/selftests/bpf/verifier/direct_value_access.c=
 b/tools/testing/selftests/bpf/verifier/direct_value_access.c
> > index c0648dc009b5..e569d119fb60 100644
> > --- a/tools/testing/selftests/bpf/verifier/direct_value_access.c
> > +++ b/tools/testing/selftests/bpf/verifier/direct_value_access.c
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/202773=
71964


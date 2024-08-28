Return-Path: <bpf+bounces-38320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FE996344E
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 00:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DB01C22A0A
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 22:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498D3165EFB;
	Wed, 28 Aug 2024 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aup3wiqu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BA81586CF
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724882538; cv=none; b=ezvGQclzs+d7k1UXLaB7+9ED7kccBh4Gn3NhPiaDQZI/6Um6ZYrho93mQK/8X9UjA14m92jGUijsYhYlVYLRe3IzMpfO5ZOC82eGFdxdNYqiVvGihye+c0FT+QVVHo1bvgqw+u8jSXf1oIHdQfhMBCk1NkM0A5LVYoPBbVbt0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724882538; c=relaxed/simple;
	bh=LwNWUqmvYob5g6SWQrkiVvdJRQ3zBxvPdeSLY13IAL8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hN1kffDmBo3pOi70NR2asxPeSDXXaxzVuaFtnkFFOkJimAVzJLBQZHKNN5mnNKppcFR0MaCH0bwfd7XEtHz88/uAsKCF4XWPUnFE6XCLT3pBxME5JOnp9Hd59Lul0GRiAJb8iP0E4zprMNIFyLjoQloi5GZIWsXJ8/SG3aFWNW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aup3wiqu; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71433096e89so6165351b3a.3
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 15:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724882537; x=1725487337; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gvUlonW5WjMSS24X0G9RzaIySVKz0rXKQNbsy5fRgKM=;
        b=Aup3wiquHJadTwvYu/ZeQG32USuEiavUzHyO5wVpsBjO0DAaiKr+29KKjuYn0g2o+9
         ib5CujuGxEyx9AKDiX9yhC+Zw+oLStXsObv+qWKSZTvnMTkBdOv/gh6bVXRcMbsPg5xr
         K/H1HprWnRaaxDRSWCexbKF8QhApGvINaYUF0zE2nwqrMMOdG4TUofVZYKMTA8a+sNPF
         bkf8n3ZK90wt05yqvllCRod7gPa4rdxNMoeMz1IEC0BDmJOdKC3jfQJN8JZAxSCMJ6bm
         MOmXWIeKZ/s7DW7iXx3KwFwAF2hOyKSdNO7LQLhScBhtxcNkmYZN4fYr3ZF1T9FXonAN
         nKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724882537; x=1725487337;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvUlonW5WjMSS24X0G9RzaIySVKz0rXKQNbsy5fRgKM=;
        b=pPr7ENUdsrwPeworFvn9mQBku4e9ImM1nStHZ8rUcv1KvBjwEt7r6RuQ5Auaw/PhYb
         w/IlNrkaDOYtHMXd1aWXFW31Kj+qn3BNPaVN5RPgL35Mj5fUJvhRBSUiygeu5zKjhyom
         07gDd1t7wDuqyl0+pG+6BtjJPJnk3enFftegmMrqKuVmBbmYubSCjcTQcDrt+uYUQ9es
         W1CKzzTE9F/cD7BJg/5LDU2fGTYXMAUuvxglVXH+mtQC4j0Ushwrxmso1Y26p19Arwtr
         1CxjHstwbumF4bxqeRZ9W1TxJJXtsoh2nKga0X/6zWZgkkIyjXiL0eOVFLKv4LxGBXPG
         TTgA==
X-Forwarded-Encrypted: i=1; AJvYcCUo6y2T7JQTiLGajjaMF3yvu+bpSY2qwnDHDZ7MRiOJN6KGMfgUo9gT5HHFn6aocRUHvfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6XooG1UyxYFW23AjVwnqWAB9ETl94HjKPKp+khZ50TV9ilPn
	5kHO38fx7AHf5GVPaeUaAuxKu4NmnScjfbXrn2+XeGJl6DKQbyAreDxu9A==
X-Google-Smtp-Source: AGHT+IE8XQjljzPetUhaL3pNpfmaMCOliE2ANt7oHUwP+Ijlod6p2u7nZs7ZFrcCE1jqO9QZAMdtag==
X-Received: by 2002:a05:6a00:91a0:b0:70d:2b1b:a37f with SMTP id d2e1a72fcca58-715dfc22895mr1056421b3a.24.1724882536589;
        Wed, 28 Aug 2024 15:02:16 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715c49aa23dsm3136475b3a.5.2024.08.28.15.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 15:02:15 -0700 (PDT)
Message-ID: <b48f348c76dd5b724384aef7c7c067877b28ee5b.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: do not update vmlinux.h
 unnecessarily
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org,
 andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com
Date: Wed, 28 Aug 2024 15:02:11 -0700
In-Reply-To: <20240828174608.377204-2-ihor.solodrai@pm.me>
References: <20240828174608.377204-1-ihor.solodrai@pm.me>
	 <20240828174608.377204-2-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-28 at 17:46 +0000, Ihor Solodrai wrote:
> %.bpf.o objects depend on vmlinux.h, which makes them transitively
> dependent on unnecessary libbpf headers. However vmlinux.h doesn't
> actually change as often.
>=20
> When generating vmlinux.h, compare it to a previous version and update
> it only if there are changes.
>=20
> Example of build time improvement (after first clean build):
>   $ touch ../../../lib/bpf/bpf.h
>   $ time make -j8
> Before: real  1m37.592s
> After:  real  0m27.310s
>=20
> Notice that %.bpf.o gen step is skipped if vmlinux.h hasn't changed.
>=20
> Link: https://lore.kernel.org/bpf/CAEf4BzY1z5cC7BKye8=3DA8aTVxpsCzD=3Dp1j=
dTfKC7i0XVuYoHUQ@mail.gmail.com
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---

Unfortunately, I think that this is a half-measure.
E.g. the following command forces tests rebuild for me:

  touch ../../../../kernel/bpf/verifier.c; \
  make -j22 -C ../../../../; \
  time make test_progs

To workaround this we need to enable reproducible_build option:

    diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
    index b75f09f3f424..8cd648f3e32b 100644
    --- a/scripts/Makefile.btf
    +++ b/scripts/Makefile.btf
    @@ -19,7 +19,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)     =
 +=3D --skip_encoding_btf_inconsis
     else

     # Switch to using --btf_features for v1.26 and later.
    -pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j --btf_feature=
s=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consiste=
nt_func,decl_tag_kfuncs
    +pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j --btf_feature=
s=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consiste=
nt_func,decl_tag_kfuncs,reproducible_build

     ifneq ($(KBUILD_EXTMOD),)
     module-pahole-flags-$(call test-ge, $(pahole-ver), 126) +=3D --btf_fea=
tures=3Ddistilled_base

Question to the mailing list: do we want this?

[...]



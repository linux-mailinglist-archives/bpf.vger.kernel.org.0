Return-Path: <bpf+bounces-61478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 925BEAE73D1
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 02:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07D2171E47
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B3C8634C;
	Wed, 25 Jun 2025 00:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTQyq/+T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B242B9A5
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 00:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750811385; cv=none; b=cqYom2zCm4nv6gFiIuKLGZbaKJgWjNgXn/mvV973QeFXMGzb3HDUwrIkZWq0QzGuRx0mocJW0Pu2rxEfvigkLUzXigEDW0nnHEC+dAZSOnYiQxiqh+sb00PeQO3lEvrv/nuR3pxtsHwcfdE//AjupFM4oo8076sy/I3hCYZoics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750811385; c=relaxed/simple;
	bh=0uUUVP8j6Q3URCazKiS7D7m7TeBJDfjthqG9y6BL+zA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CMi5oc6AZFgQtz8hpy1A57UZCveHQj9tW90hQkAbVdz2MmNtncvjaltv4tMGOnDk/Y/adt1n6S0kvIqlrBISrHEICJH5LQQK4d9BWQfM8GbdHI3BH/rArxFI8L3IXrDJ6l316J1OGIcYQ0Lq42/D18yRF37YqmDq9hpkpLDRStg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTQyq/+T; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235f9ea8d08so11443955ad.1
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 17:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750811383; x=1751416183; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vfu1NeZRg3cD0kfl33EOpOMD0JyfBGhfysSfOeWiJ4w=;
        b=PTQyq/+TEhSDKZnCtcJAan/ZFZALN60b9ZrHXyTZfpbFXg6PRzc44BdXRfW5Lav3v7
         +9/Tv0oUAc1PVMQi3L7sMK2o3VctGQFAItDTThwrQm1IqhM4FANsW/2iLjLgeOfcWPTG
         nXwmoMJ2c35g3P1edz01WJn+P/ZQcZgwa9pKgiTMiV1U3bks4u175aZFZAENWFTTsnBI
         slvf98RIUxNRuikDVA6wGv299H2CGZNswH/McOurNsfurRdIHBbWiAv+nvZXS4hn7pzT
         l+wK40lWiUGbYdb7kjA2ntx7htdjYaTByVxkvogoFnXINxc2Bjp4GQ2qsVUsiwubOtrW
         yS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750811383; x=1751416183;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vfu1NeZRg3cD0kfl33EOpOMD0JyfBGhfysSfOeWiJ4w=;
        b=WXpp3fT/QihXFK7+AVVVZfuAwgaY1+YrF7UL5ovthPS2162NaNu1adufzcJPkpnutX
         E/NvuEULaESuDWb61Br6Gy9wULNVgjEc9gPdxsVk7ea6P51DRO0sSrjp3e0KJ7mq2n8d
         mhklVIOtBu9W7wVqTTjB+sZc8S/xcIUTO8+LXMmoaJnFkMoch4jc7l0kDxuVmL0AWWCs
         e++j2Kzq5+PbQTDf+nq9HO79ebKI2d9HPyYk5LD4oOSEibRj52QccLG0ofLaShAWqGPz
         gqv9wLfDxwr16mXhcXdZNYMEoTLcBkRVau5B7VlGtZ5K1UgF24wCJHjamfXpHg5nQNJy
         smPg==
X-Forwarded-Encrypted: i=1; AJvYcCUj62kiV8QzKs805tCvxjc8FT7TeUv16fz6rJM8pxyPY1+9imBf+ZLaWjJlqWA2EmHL1Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YykF8qNRRVNxaSaCSQqIU+9hquJLPZDctqyITr5xX96zbxL5a6k
	cl5ott0ZlSyACUGsSaO3Kude3VId5NTUVPmng8wERSazEjgfmTuG+LKd
X-Gm-Gg: ASbGncvqXy7lsP+YGs2MduUP2usYa07YYnqOw9tOTr7e/GhZgTe7/kSsCKCcU4j3+Yl
	isR3tw5Ndcgd0g+opovfGxKFYeVanMO38QPDVTSFb84iPzDE1vPFXe2nwbHjlr6zmiYsaKQRYOA
	WARD93m7eJLsdAN0QYjPzyChmwUFXYz33ph6LVrGDj3uZlE6N6iNuV2wGTGrjb9xRhXZBDzHI22
	SbhPH+3F/n14BLsw2BXKb00LID3jJsr77BEOWNEJUcZQF+aMvpRbrHl741vOPRMQeb/j62+1IWr
	TKzkUbCo5azwsst0IK7o25rHlG1FXCGvzd6n7PPoebQ4necGvDwgfYkDwZRZXrEAD0h/3QBZWH0
	1WAbYz0ie9A==
X-Google-Smtp-Source: AGHT+IGVrBt1KHojiNDD4N7nsGU8E0MQtDFGMLRlillxxllXVHNg5Eoqnaa8fEokyZbEhApOIKdJww==
X-Received: by 2002:a17:903:41c3:b0:234:a66d:cce5 with SMTP id d9443c01a7336-2382407fdf9mr19887665ad.46.1750811382870;
        Tue, 24 Jun 2025 17:29:42 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9b77:d425:d62:b7ce? ([2620:10d:c090:500::6:f262])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8393541sm121737605ad.27.2025.06.24.17.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 17:29:42 -0700 (PDT)
Message-ID: <7aa3235b66f293228ab43b8fe876723a7aff67d5.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Add range tracking for BPF_NEG
From: Eduard Zingerman <eddyz87@gmail.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: kernel-team@meta.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev
Date: Tue, 24 Jun 2025 17:29:41 -0700
In-Reply-To: <20250624233328.313573-2-song@kernel.org>
References: <20250624233328.313573-1-song@kernel.org>
	 <20250624233328.313573-2-song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-24 at 16:33 -0700, Song Liu wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c=
 b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
> index fcea9819e359..799eccd181b5 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
> @@ -225,9 +225,7 @@ l2_%=3D:	r0 =3D 1;						\
> =20
>  SEC("socket")
>  __description("map access: known scalar +=3D value_ptr unknown vs unknow=
n (lt)")
> -__success __failure_unpriv
> -__msg_unpriv("R1 tried to add from different maps, paths or scalars")
> -__retval(1)
> +__success __success_unpriv __retval(1)
>  __naked void ptr_unknown_vs_unknown_lt(void)
>  {
>  	asm volatile ("					\
> @@ -265,9 +263,7 @@ l2_%=3D:	r0 =3D 1;						\
> =20
>  SEC("socket")
>  __description("map access: known scalar +=3D value_ptr unknown vs unknow=
n (gt)")
> -__success __failure_unpriv
> -__msg_unpriv("R1 tried to add from different maps, paths or scalars")
> -__retval(1)
> +__success __success_unpriv __retval(1)
>  __naked void ptr_unknown_vs_unknown_gt(void)
>  {
>  	asm volatile ("					\

Apologies for not being clear in previous messages.
Could you please avoid flipping these tests from __failure_unpriv to __succ=
ess_unpriv?
Instead, the tests should be rewritten to conjure an unbound scalar
value in some different way. For example like below:

diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c b=
/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
index fcea9819e359..3593b15d11af 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
@@ -231,6 +231,10 @@ __retval(1)
 __naked void ptr_unknown_vs_unknown_lt(void)
 {
        asm volatile ("                                 \
+       r8 =3D r1;                                        \
+       call %[bpf_get_prandom_u32];                    \
+       r9 =3D r0;                                        \
+       r1 =3D r8;                                        \
        r0 =3D *(u32*)(r1 + %[__sk_buff_len]);            \
        r1 =3D 0;                                         \
        *(u64*)(r10 - 8) =3D r1;                          \
@@ -244,12 +248,10 @@ l1_%=3D:    call %[bpf_map_lookup_elem];             =
       \
        if r0 =3D=3D 0 goto l2_%=3D;                          \
        r4 =3D *(u8*)(r0 + 0);                            \
        if r4 =3D=3D 1 goto l3_%=3D;                          \
-       r1 =3D 6;                                         \
-       r1 =3D -r1;                                       \
+       r1 =3D r9;                                        \
        r1 &=3D 0x3;                                      \
        goto l4_%=3D;                                     \
-l3_%=3D: r1 =3D 6;                                         \
-       r1 =3D -r1;                                       \
+l3_%=3D: r1 =3D r9;                                        \
        r1 &=3D 0x7;                                      \
 l4_%=3D: r1 +=3D r0;                                       \
        r0 =3D *(u8*)(r1 + 0);                            \
@@ -259,7 +261,8 @@ l2_%=3D:      r0 =3D 1;                                =
         \
        : __imm(bpf_map_lookup_elem),
          __imm_addr(map_array_48b),
          __imm_addr(map_hash_16b),
-         __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+         __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len)),
+         __imm(bpf_get_prandom_u32)
        : __clobber_all);
 }


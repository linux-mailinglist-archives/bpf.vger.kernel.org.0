Return-Path: <bpf+bounces-69617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044FEB9C2AD
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 22:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA80188732B
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 20:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFC1329F24;
	Wed, 24 Sep 2025 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYe/k7S7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4332329F16
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746427; cv=none; b=s0XuoMUoad24Omr6IGBdHng5UkgXqVX5BI4jD/usW688QCsjU8fOUnZ86uYFiqMM3oT/PftrTjFAsptX3ClGKpxhP2aAeGUtpczCewWK3MeSgcYz4ElPcPxxyg/nxGMfiujIBYfgd9A8Mn8JqkExpHyslRlN19kbu8C9YQoUbWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746427; c=relaxed/simple;
	bh=4Fqgnj4/wkBm7xOxpZcAuwCsEPG7u40JNdDl2/tIfGQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qDzLNC5ep3u4kWFG1SeSlqdRidrhDRyU8CEfZH87JFh767IIepGk6+nxlqXJW9l0o14R1XIxYJdBMuESF3MAZbpK7mnnAkuUa7FmlNOu6mGvz6/Iw+W1H1KllNO4MWB66X2boQC/U0Cu4XOvCwpgxySgBU5xwS8m5uQUrhmstXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYe/k7S7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-26f0c5455e2so2060785ad.3
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758746425; x=1759351225; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s0Boh4NKVepwXmX6bK2VIVaBavWsTwXW7UYm37KNjGc=;
        b=GYe/k7S7nLCfRoEuImuzAmZOnnEUK7a9u94ldIjZOqZjzDPuPQBGW/mApgYNGCNt8E
         s312yRaN2mSg2jxs3ji7a+vT9Lr8Q5OwDGAoDIiR/99WJR8ppN+hcCPdGxpIJDWPlmog
         jIUkWwcdOrE2I57n+gBIkv/n7VC63jSdmMKHvUdIs3s28nuJqxG5XXwPMPD5xnVJEvkc
         noGfgjlZZrfWIziANDJYDTyxt5U2/WNiWzsX4cWL1OBoWzcosjy23mM/8mgnwiRrHzNm
         h8brVpeDAFPmfV5eXW1qxnp3R7algG6WxCsEqnsYcnwLpYoyHB5Dx2vAkRmeheuUU5zW
         yQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758746425; x=1759351225;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0Boh4NKVepwXmX6bK2VIVaBavWsTwXW7UYm37KNjGc=;
        b=a+o6aQuLJupfkNPTxSl0X1M1RB/odk1RqjYdaLMKNW7gD/Et3mjA/00jJlKxx0ZJEo
         QxVzBgVJUod+B5CjyNcNLE/Bty4pma3xp6LFlZixtzZmvk4yexmyw2aeaaNq2aF/8HRw
         16/7reZUjgE6qmrAbZLd9hj2JqPrQDA5lN1vxHl8yGFktMnp5rRxfluBU4Xic/Uu0GrE
         PF7zRuO5l0d4if0mqIJTQW6/0QTxJLKcqnI6sDxf4fWYdo8Z8douTE3V6gZDEEPTKFFx
         K4Rxdz7yLa9YPd75seOvoq7A0avJOSHZJp4CPx5PEjSo2kzMTEHjyU+nJR9ANO41D+4b
         H8HQ==
X-Gm-Message-State: AOJu0YzTItf9X8nRmIjlcB/6Znlh9xntd38lTlxlbRnrwykBCGTNYlJe
	lVk8wPr9pjxJZLC1WZHaQd0PIsHb1SP39m+E/yC+XtnxhRuMdOh+4Tz78dKXqt1i
X-Gm-Gg: ASbGncu0pUxW56fsNRYHTqwPRzvA/j7BDXXURbiO8wGgVUVNOv86nu91o/bHp3bjVvF
	OdyKXa5hnL6dHojGfKB/C9fvLsHURcDsCiTWubL/ymOFOLbQwWEaNr2/1QbI/LyZG454zLxOXRV
	mgR9Q8kNAUpWsIPSHtRYjA49LJpGTrIErc1WPsJs+Ck+95C070kzz294GLUPCMRqp1aMR18BtJu
	3KCaTLyRDd2YEHfjXNEVzxStX1GGL6voSVuobB/wHHvNjoWwcskCNgkRDCxCJ3VpUFmCiq5xeUk
	JDVcqtbXwPBu2GwDRR2vZiSl+7/0KgEKIVetySZxWieqe7KHkcK9KapPyVA6rWz6+WGRDJh9Rpk
	kf0UTBlWRbGHkse5RTsWSJ6lCdkfDhizj
X-Google-Smtp-Source: AGHT+IEMT+KW8NH9w0tGhe+5aC3Xz78byi6FsgGymBvt/KPtUrj3luXu65LUuNLGcdbF7HXh7tUkAQ==
X-Received: by 2002:a17:902:e5cb:b0:25c:5bda:53a8 with SMTP id d9443c01a7336-27ed4a31173mr9771725ad.37.1758746425150;
        Wed, 24 Sep 2025 13:40:25 -0700 (PDT)
Received: from [10.20.185.92] ([204.239.251.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cdcccsm1636925ad.31.2025.09.24.13.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 13:40:24 -0700 (PDT)
Message-ID: <8430f47f73d8d55a698e85341ece81955355c1fd.camel@gmail.com>
Subject: Re: [bug report] bpf: callchain sensitive stack liveness tracking
 using CFG
From: Eduard Zingerman <eddyz87@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: bpf@vger.kernel.org
Date: Wed, 24 Sep 2025 13:40:24 -0700
In-Reply-To: <aNQfvqHgUDKjsjDt@stanley.mountain>
References: <aNQfvqHgUDKjsjDt@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-24 at 19:43 +0300, Dan Carpenter wrote:
> Hello Eduard Zingerman,
>=20
> Commit b3698c356ad9 ("bpf: callchain sensitive stack liveness
> tracking using CFG") from Sep 18, 2025 (linux-next), leads to the
> following Smatch static checker warning:
>=20
> 	kernel/bpf/liveness.c:527 propagate_to_outer_instance()
> 	error: 'outer_instance' dereferencing possible ERR_PTR()
>=20
> kernel/bpf/liveness.c
>     514 static int propagate_to_outer_instance(struct bpf_verifier_env *e=
nv,
>     515                                        struct func_instance *inst=
ance)
>     516 {
>     517         struct callchain *callchain =3D &instance->callchain;
>     518         u32 this_subprog_start, callsite, frame;
>     519         struct func_instance *outer_instance;
>     520         struct per_frame_masks *insn;
>     521         int err;
>     522=20
>     523         this_subprog_start =3D callchain_subprog_start(callchain)=
;
>     524         outer_instance =3D get_outer_instance(env, instance);
>=20
> This needs if (IS_ERR(outer_instance)) check.

Hi Dan,

Thank you for the report. Luckily, this is not a big problem,
because of the program logic, this should not ever happen in practice:
if instance for inner callchain exist, instance for outer callchain
is guaranteed to exist.
But I agree, adding an error check removes the need to think about it.

>=20
>     525         callsite =3D callchain->callsites[callchain->curframe - 1=
];
>     526=20
> --> 527         reset_stack_write_marks(env, outer_instance, callsite);
>                                              ^^^^^^^^^^^^^^
>=20
>     528         for (frame =3D 0; frame < callchain->curframe; frame++) {
>     529                 insn =3D get_frame_masks(instance, frame, this_su=
bprog_start);
>     530                 if (!insn)
>     531                         continue;
>     532                 bpf_mark_stack_write(env, frame, insn->must_write=
_acc);
>     533                 err =3D mark_stack_read(env, outer_instance, fram=
e, callsite, insn->live_before);
>     534                 if (err)
>     535                         return err;
>     536         }
>     537         commit_stack_write_marks(env, outer_instance);
>     538         return 0;
>     539 }
>=20
> regards,
> dan carpenter



Return-Path: <bpf+bounces-73978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDD3C415C4
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 19:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04D21897377
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 18:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F411D33C534;
	Fri,  7 Nov 2025 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxkRGH2T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACB733CE94
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541913; cv=none; b=hQEn+/FF0IbkiHshnikQDs4LL12T87ra2OkiVWDN38XzXfUau/MzzvUCZPY34OvjELKJhkx7c0O8mNA9eyY9Ny1wty3dlZW+ggPea0xdGkbdIu9wg5l+D5+ZFSlT0e3bc0pxIwLoxECZRS88ojF4aDPKQvkZVXpB+c28qQt78Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541913; c=relaxed/simple;
	bh=RjrzCirQRAEDbjwBlo3vQ/iH4XgQ/gFqjek9EfoLwkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fD3kaWW7Q1JeQCHGD5Ku2iIk9iXBnJ0UH47N/Rb42YMXJAUusRaX8cOCq+ljd1w97TcsR4fDx/oyfVoxKDeeQ8ZkR02ar8y7HdQUVu5vs24aXdFVOwcwZHEVNUyK/Q+2M2ffzPIoC68KFfK+LEfCgzeHwRI2LLxx9diMy0AJujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxkRGH2T; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-28a5b8b12a1so9836295ad.0
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 10:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541911; x=1763146711; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RjrzCirQRAEDbjwBlo3vQ/iH4XgQ/gFqjek9EfoLwkI=;
        b=PxkRGH2TIiAF0PDEfx7e261KG4HHCHINVzILcYN2g3JsxpgBrE9iAKZtrwtiFKhs8H
         HLTeK2tGIABxPeo7KZaKvq0Qrmo4ppG0xcf637oop5SrT25Y6+4Od7pdC5j9NSoTgORg
         g7zFOtBbD1AMQoGuNubrEXs2QpxHTEZ4AoYGDXpH8Sv+6RNOphIkpgcrxameXZHtNwYD
         NbzRGs/aPSbBX54hmOxIL0i8m+j62Xbr6RkRA7KW7ly5RNcrBWxctS99M2JSPnOQZX8N
         ob9Ahigb7wOKIjvNAdjrkdsbw/VFRRysivR5X6L57z8/fu4SkaFL/2E/nZtPF8wrjW/G
         UunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541911; x=1763146711;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjrzCirQRAEDbjwBlo3vQ/iH4XgQ/gFqjek9EfoLwkI=;
        b=Bw9sMpgcaM7QNI2QHHtr/VdJJf5ICfuZIIOT2Atf+QHQu4U/MoDWGTPWxZuDJDwczd
         QqIAnW/LzWkJpt+WoNNl2pslZQNyuaa21o6pzMIKcIVcJvWwMHLJnasKhZ7kL1Mu/xGx
         1WcX8QQZ9LJMrRW27XUX0r5fWk76c76BI5BK9wJW8zIBlL+gHJKxEBElQ6fxB1jC0un8
         Rq0hABuO01xIiCMllPEKmFuQGmtPxUgStAPIE4VEy7M3fjNwv2nOEwaL6VhvUHLEJb5V
         nVr9zz7SwDyka4uu7MHSjqNRD2WQXdOfkX5rLdILqR50Lcwf8/w4pIgzMqCddm6YiM3m
         kElQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx3WhijssGhFbXGYzI3PiPFQ9iWsG7XOS47ztTHk1UQemvKERr8mkJtPMsGG/a+5X/BoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN4pXQYwSRYJpo0J8KQqTdwIX1cp5mTHkEGH5TDE+7pud6Eu+s
	ma+Xexjlp7M4IrBdnDyTsVn/zvpbKdQN6GSDMoEew4bSdWA40bihfbji
X-Gm-Gg: ASbGncsVCwl3IZubElyPfU9MWCrSsPDNQWNOI2tI/6ZGpgVjQ850FMs4MPAdvcRiNk6
	bx4Eu3TLo2IG3A1IXt7nVRm4KNsJJgKZY2jS1Xfn0WT77mE7/tRZAEaVNFo5JOAsCg0ZM9ILeiM
	oN8k95ZMgD3dfFirMRfqNPDv+kCkhKJ15pniUvLIOYDItVCF19N0pqy2agQ6hvjUHNbWZVNg8p5
	U0Hb32p/KGeypZ3cfxhoy4qPepWuxf8ylg2CbfCX3nw4oRtWg3QQs38aO/6t8ye1EsN8c35lrlI
	rDmMT1V8j9L+vlKeWL39YKYeL7RxZpqVU6nNMbw130vsZj1X7m9wgOG0bVaHy+Yjw3eSO7a2kKD
	qTdEpQw7p3IoM6q8NyDitegjhXJT0NM90aIsWr6QLEHkZiQeQ/KxGlGwVImOyE9QF4s3+gUls
X-Google-Smtp-Source: AGHT+IGpMuuRbaDk+Z+7AaaKmSwq/CPtj/ja76biPbWaMcvP2DENiGEkr+xomRRcSSIxRfBq0JnZdg==
X-Received: by 2002:a17:903:1745:b0:295:5945:2920 with SMTP id d9443c01a7336-297e56c9ea9mr1236415ad.34.1762541911527;
        Fri, 07 Nov 2025 10:58:31 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e5bdsm66901325ad.39.2025.11.07.10.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:31 -0800 (PST)
Message-ID: <5a8c765f8e2b4473d9833d468ea43ad8ea7e57b6.camel@gmail.com>
Subject: Re: [PATCH v5 6/7] btf: Add lazy sorting validation for binary
 search
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, bot+bpf-ci@kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 zhangxiaoqin@xiaomi.com, LKML	 <linux-kernel@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>, Alan Maguire	 <alan.maguire@oracle.com>, Song Liu
 <song@kernel.org>, pengdonglin	 <pengdonglin@xiaomi.com>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann	 <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>,
 Chris Mason <clm@meta.com>, Ihor Solodrai	 <ihor.solodrai@linux.dev>
Date: Fri, 07 Nov 2025 10:58:27 -0800
In-Reply-To: <CAADnVQLkS0o+fzh8SckPpdSQ+YZgbBBwsCgeqHk_76pZ+cchXQ@mail.gmail.com>
References: <20251106131956.1222864-7-dolinux.peng@gmail.com>
	 <d57f3e256038e115f7d82b4e6b26d8da80d3c8d8afb4f0c627e0b435dee7eaf6@mail.kernel.org>
	 <CAErzpmtRYnSpLuO=oM7GgW0Sss2+kQ2cJsZiDmZmz04fD0Noyg@mail.gmail.com>
	 <74d4c8e40e61dad369607ecd8b98f58a515479f0.camel@gmail.com>
	 <CAADnVQLkS0o+fzh8SckPpdSQ+YZgbBBwsCgeqHk_76pZ+cchXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 10:54 -0800, Alexei Starovoitov wrote:

[...]

> > > > > @@ -610,7 +674,7 @@ s32 btf_find_by_name_kind(const struct
> > > > > btf
> > > > > *btf, const char *name, u8 kind)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > >=20
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (btf->nr_sorted_types !=3D BTF_NEED_=
SORT_CHECK) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (btf_check_sorted((struct btf *)btf)=
) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> > > >=20
> > > > The const cast here enables the concurrent writes discussed
> > > > above.
> > > > Is
> > > > there a reason to mark the btf parameter as const if we're
> > > > modifying it?
> > >=20
> > > Hi team, is casting away const an acceptable approach for our
> > > codebase?
> >=20
> > Casting away const is undefined behaviour, e.g. see paragraph
> > 6.7.3.6
> > N1570 ISO/IEC 9899:201x Programming languages =E2=80=94 C.
> >=20
> > Both of the problems above can be avoided if kernel will do sorted
> > check non-lazily. But Andrii and Alexei seem to like that property.
>=20
> Ihor is going to move BTF manipulations into resolve_btfid.
> Sorting of BTF should be in resolve_btfid as well.
> This way the build process will guarantee that BTF is sorted
> to the kernel liking. So the kernel doesn't even need to check
> that BTF is sorted.

This would be great.
Does this imply that module BTFs are sorted too?


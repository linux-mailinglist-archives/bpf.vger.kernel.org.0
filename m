Return-Path: <bpf+bounces-78188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F17D00BC8
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 03:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DE2230245D9
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 02:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1539526B2DA;
	Thu,  8 Jan 2026 02:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKrdHrZk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D20C18AE2
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 02:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767840834; cv=none; b=I7vd3AdTOZGrkIXIge1QrVJCThmR1O/YaTdTb8SZ66epim/yOoiTxyDsWMTsS1HGKAjH86YEJKRbDVITpf6+mRGL6YfKXSkDeFKm295C1B5WXVnPuFPWaP/ma8NPYo4YZpnFSWtHUMQXXsLAr5fc93uD8y9O3OkamaGPBGoaJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767840834; c=relaxed/simple;
	bh=Me82hG12KkvjoheaWtxZ9QjNDyrlIj3htOyxES/dasM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7ve6vlrYxTJnzHd8vQnpXK34wscOHZyId9vIDd5hwjksjCzmgm8Hc/cfGXXnxgyYuJFoOBCD7Gdb/C2SFT54wAPGTJIHLnf3cQQjiLjodJ08OscZjhUFKbBBS68ubLGuLXExeuX/+loSIEeK+o1vbaUKA+kPyuE+ylPBR+xTw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKrdHrZk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so1438770f8f.3
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 18:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767840831; x=1768445631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeigwwto9xme0VMTpwv3pEFxa5Z1vhoQ8IGxPY8PzUU=;
        b=BKrdHrZkMW+ev0keRgkL3rsfsZsoRjfNmArwZZZkelP9+8QUEoqO/nYRMapc4dxAp1
         Vdymv38DzldktDVO6f2yhPARbeYrhnv/10PC90ox15NpUyOBOAh1tpWarzpD7W/eD8el
         fQf1SkoG7jSZEheWtb2xu99GDxUbAmrKtd/vCksSpJYwTPmM7W2XjcEi5JX3pMWlSNLI
         2MQixL+P6EWkY4hl2EJq+GYOD0Z2Dlp+2E/wAlTA8s0nLuWzfAxtQarjWtm2j03BXUIi
         9TdXVGa2iNqrp7TZUIyzmPXiczr/mTDBBjOT9+HOa4c9Jz6uUk3SUJ2jNHq3LO1yOwvf
         tDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767840831; x=1768445631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aeigwwto9xme0VMTpwv3pEFxa5Z1vhoQ8IGxPY8PzUU=;
        b=Knp4M0d11zgpF/MKpxIwUPmwClq3rB7HEIgsbleRI/t05NxF3B18y2rF8WQNPBdCSN
         wS6zd4mMs/v8eQKj7JISunDffuGYU7aVkY1X9wN4FNSikg1V4rvpjPCCdreIsivsG5Gq
         TgqGWjUb+RPiAR5GKHh0pD+R97tOgZVTdrZKldIwbyhhuunY74oWBxCjAavwuYSIVKvE
         4Ow3QE14etIUigeZUUoqZA8VSTOUt9pCi5UtiXb9uqwFgel17S1kjrUtG4XIsCYIlYzX
         zUxqK/qmgPSa5fjVbic4g+iMPFxYY0jRl+Qhnr4fMRliRcrX5Rgf53hhH7X4VW9l/AjV
         qWww==
X-Forwarded-Encrypted: i=1; AJvYcCWLcKKSlRUvtVjrcuBPvSpuZPUja8SDjVKizOuwAWCqXIF9QYFLQaDfFeW8TLDS9IFB/IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSZZ14xgw14EMH3/TOprkwXjaaWpEEk3InKN2i6xI0OX2boFoC
	n4m3yVzU4uWXRVqfr3txmm4ZiBvqfCgiMdmT8Ldr1sZj7pLMYV8pyAWpWv1a17znCPZq+R4MCpu
	jxLKiqYg8k5kJCgoSNffxXy6H6PBJNuzv00ad
X-Gm-Gg: AY/fxX6RGb7dLMrjtEFoCChWXo3bbsdfiOV6xZUzDs+EavbtFXv1R+XCt0wciC0PRSW
	dMzxppwhA5rNGDbXYPoxumjytUi+sP4b1X+TO/IjuAFkvV/9Pbm0M8ZpeX+Y/ZmGiJXj4mT0m5e
	E+wqcH0hryavDW08TN7d56eKkElDkZEvFWw8OzH+zMiZ2cHLQ6HC+Qs6MbTB6IeyI5kC03g0twt
	oyaH5nYG4FJ5H9eAd384+8uaObamhVn+sWbYt+jxkrKbDGjkZ1uIQrouBsnDbgO/yQXtPPnEygf
	AJ9q+j+miTY5zpT6dYfHG1pKVwow
X-Google-Smtp-Source: AGHT+IHI2CTpVPDPv77S1k4b5QxvMsEq7pAgZB43DzIBs6k48oSef2jUb5i9Kuu/AUkVkp8HorTkZZ8DqFfnxFDOzyc=
X-Received: by 2002:a05:6000:200d:b0:432:8504:8989 with SMTP id
 ffacd0b85a97d-432c37c32bemr5383308f8f.56.1767840831171; Wed, 07 Jan 2026
 18:53:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107203941.1063754-1-puranjay@kernel.org> <20260107203941.1063754-2-puranjay@kernel.org>
 <5fa1d856b98cb7f0cb4eb402f616946b0c6c9211.camel@gmail.com> <5e6bfb044463123d7671cf1eb4b9b416c5fe5c1d.camel@gmail.com>
In-Reply-To: <5e6bfb044463123d7671cf1eb4b9b416c5fe5c1d.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Jan 2026 18:53:39 -0800
X-Gm-Features: AQt7F2qcXe8Rk_GgMLWberYsud4O37H99SUUZVhMFWZYnCZl6mYFj7a0vdkis9o
Message-ID: <CAADnVQJuRbnuuj6W77ZJTe22+JDUMGAJN+grSTTtU_HdGh=VtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Support negative offsets and BPF_SUB
 for linked register tracking
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 5:47=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2026-01-07 at 17:40 -0800, Eduard Zingerman wrote:
> > On Wed, 2026-01-07 at 12:39 -0800, Puranjay Mohan wrote:
> > > Extend the linked register tracking to support:
> > >
> > > 1. Negative offsets via BPF_ADD (e.g., r1 +=3D -4)
> > > 2. BPF_SUB operations (e.g., r1 -=3D 4), which is treated as r1 +=3D =
-4
> > >
> > > Previously, the verifier only tracked positive constant deltas betwee=
n
> > > linked registers using BPF_ADD. This limitation meant patterns like:
> > >
> > >   r1 =3D r0
> > >   r1 +=3D -4
> > >   if r1 s>=3D 0 goto ...   // r1 >=3D 0 implies r0 >=3D 4
> > >   // verifier couldn't propagate bounds back to r0
> > >
> > > With this change, the verifier can now track negative deltas in reg->=
off
> > > (which is already s32), enabling bound propagation for the above patt=
ern.
> > >
> > > The changes include:
> > > - Accept BPF_SUB in addition to BPF_ADD
> > > - Change overflow check from val > (u32)S32_MAX to checking if val fi=
ts
> > >   in s32 range: (s64)val !=3D (s64)(s32)val
> > > - For BPF_SUB, negate the offset with a guard against S32_MIN overflo=
w
> > > - Keep !alu32 restriction as 32-bit ALU has known issues with upper b=
its
> >
> > This is because we don't know if other registers with the same id have
> > their upper 32-bits as zeroes, right?
>
> Nah, we do know if their upper halves are zeroes or not,
> registers with same id are identical up to the ->off field.
> So, it appears that this restriction can be partially lifted if we
> check if dst_reg upper half is zero before operation.
> Wdyt?

Let's figure out how to support w-registers too.
Hao Sun's 1st category:
https://lore.kernel.org/bpf/CACkBjsauBbmKRAgEhOujtpGBeAWksar9yS+0hk1i9pLYwt=
QN3A@mail.gmail.com/
is exactly this missing feature.
Instead of adding them as failures in patch 2, let's make them successes.

pw-bot: cr


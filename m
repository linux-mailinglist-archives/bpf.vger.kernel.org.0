Return-Path: <bpf+bounces-45286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC369D40CC
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 18:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86D5B2B7A5
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 16:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AE7145B10;
	Wed, 20 Nov 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDlgQbp3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB37044C77;
	Wed, 20 Nov 2024 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118865; cv=none; b=lwse4KNaVYg2uBcjy91MjE8ApH2Lk/Zdx6enCvxQCK3SkGRLMqcYf6F202Adw+tyHfln2I0tKFmJgp/UwFX6n9o3sWl6/0pFONyu0fcG1KIKutucdQpwXBiLUMahgUpwRK8r+xSQQZp3s/CI+tdh+VMGWOkLVtxpIE6snjKV1Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118865; c=relaxed/simple;
	bh=aO9TKFKPXbpzZpQOYdLRcgOnIQRaSyBu7w9NImnsmsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3Z9q/xJhIlOwDrxOJ3lK97USTlmjNyOcCae6JmTXv1tlg+kyzJDE6o2/2W04K+rfgosw6rEn3S3c0n89vlNdPVtLRRnCTLdjM5phRIvsrZNKkqbuD1Xa1Dpo3mQ18BFBvik1WYv8VCiqfZtn+FfLyyD0M9SV1WsNR+4y+Up3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDlgQbp3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3823f1ed492so614977f8f.1;
        Wed, 20 Nov 2024 08:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732118862; x=1732723662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aO9TKFKPXbpzZpQOYdLRcgOnIQRaSyBu7w9NImnsmsE=;
        b=hDlgQbp3Q4LHFX2aooP4FsOpdySNws7Q80jZ8Qfez0OIcdHfMxQVNQpB9v1uaU2v/6
         hduzVDX4ke1t8PCftPhHq1/VOtm+icmzcF0Va3UEMw4SDYO3fTV7SQiuArXKxE9sH+zt
         HFX5KaNEtEVOgNSfQ86UODh47uXe2U8i8aTdIw5QZLXLcRiSQvsU4uXt681fWa5zVXmj
         6gyCXEzOALVircbcZqE7t1I4ZlThzOxM/YuA5IxQEm1xgSuz5DyaP3fwBBnMtXMev3Xd
         X46RZSU09TPiyGK9I4AMMdzq669MX5OZFzMIY7NPQxYRSc+mKWse9KJLDNPy4rrICGS2
         Ow7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732118862; x=1732723662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aO9TKFKPXbpzZpQOYdLRcgOnIQRaSyBu7w9NImnsmsE=;
        b=xGN8gG6e92aEV3kwudiiJFKn7apBJ9VzrqjeOZkVZpa9SuBmYfXkY/OgZX0P9xcp5e
         GAeU2/06xLq+z2Ytb7YI2mAPPl449Jiyqixbxz9UxYxhCxZlpt5Oe6Ks5PuIWPMi0ew1
         yhCLG2/r3t58RCbFrBDbWxP0YKpJ4R4KKXQejXn2hjXggaCEq/xzuPs1czVKJnoHrkTc
         w6Nhg23jxv1Vf7x1yfHf/099wkhgv2QlY9q2qE2pMcUsOD7h51vs8y14x0Fot/q8lhwn
         urdo3f9A4QaW4iRXtUDQIHosAyoplWtURkzRXiqATyqIMseYJeJJa/N3vTtlmiigLltT
         z00w==
X-Forwarded-Encrypted: i=1; AJvYcCVJIOo91gmJzYGO7/7oNOtoQiY0xUz+GQoJc5r1/Q5hQ60THThpElP135v6+UvJfy+0ai30WuUAem9OhKs=@vger.kernel.org, AJvYcCXChBfuYSlofYIvEjSdeNAacldQ3eGOKq5hvZuj/a2df6I9zR6c+uIZN6IHRg2C0CxOXfuZ63eU@vger.kernel.org
X-Gm-Message-State: AOJu0YzJM0/hanWgjpeWCKE/urlQUqSHC1zVbXlTcgAVVMomxgKDGqGc
	TgC16E8ayGBu4QnBjfXDwFagziArMQSdOTtpQenqPivo8VH4TmIqb+iar3qIfl/Weq7PoamlCeN
	SSoE8G9M8Zr8QZoKefwo1x0wuIRSL1w==
X-Google-Smtp-Source: AGHT+IER19cs4sf33fj71/KdeC2bmUz2qJiOH/3CwjU2YUbA7W8Lei2R7xOzyjFNQyjpAY+9DrOmVMYouOIU50rMkJ4=
X-Received: by 2002:a5d:5f48:0:b0:382:498a:9cc4 with SMTP id
 ffacd0b85a97d-382544c19f7mr2706793f8f.9.1732118861694; Wed, 20 Nov 2024
 08:07:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1692748902.git.dxu@dxuuu.xyz> <eb20fd2c-0fb7-48f7-9fd0-4d654363f4da@app.fastmail.com>
 <CAADnVQ+T2nSCA8Tcddh8eD27CnvD1E3vPK0zutDt8Boz7MURQA@mail.gmail.com> <7ec1a922-30c5-4899-a23f-11e3ef9d6fef@app.fastmail.com>
In-Reply-To: <7ec1a922-30c5-4899-a23f-11e3ef9d6fef@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 Nov 2024 08:07:29 -0800
Message-ID: <CAADnVQJ5NnDqx_TMbwHOPySUaJRE-N5K7L_whDsfeyMRBNOFkA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/2] Improve prog array uref semantics
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 7:55=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
>
>
> On Sat, Nov 16, 2024, at 2:17 PM, Alexei Starovoitov wrote:
> > On Tue, Oct 29, 2024 at 11:36=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrot=
e:
> >>
> >> Hey Daniel,
> >>
> >> On Wed, Aug 23, 2023, at 9:08 AM, Daniel Xu wrote:
> >> > This patchset changes the behavior of TC and XDP hooks during attach=
ment
> >> > such that any BPF_MAP_TYPE_PROG_ARRAY that the prog uses has an extr=
a
> >> > uref taken.
> >> >
> >> > The goal behind this change is to try and prevent confusion for the
> >> > majority of use cases. The current behavior where when the last uref=
 is
> >> > dropped the prog array map is emptied is quite confusing. Confusing
> >> > enough for there to be multiple references to it in ebpf-go [0][1].
> >> >
> >> > Completely solving the problem is difficult. As stated in c9da161c65=
17
> >> > ("bpf: fix clearing on persistent program array maps"), it is
> >> > difficult-to-impossible to walk the full dependency graph b/c it is =
too
> >> > dynamic.
> >> >
> >> > However in practice, I've found that all progs in a tailcall chain
> >> > share the same prog array map. Knowing that, if we take a uref on an=
y
> >> > used prog array map when the program is attached, we can simplify th=
e
> >> > majority use case and make it more ergonomic.
> >
> > Are you proposing to inc map uref when prog is attached?
> >
> > But that re-adds the circular dependency that uref concept is solving.
> > When prog is inserted into prog array prog refcnt is incremented.
> > So if prog also incremented uref. The user space can exit
> > but prog array and progs will stay there though nothing is using them.
> > I guess I'm missing the idea.
>
> IIRC the old-style tc/xdp attachment is the one incrementing the uref.

uref is incremented when FD is given to user space and
file->release() callback decrements uref.

I don't think any of the attach operations mess with uref.
At least they shouldn't.

> Once
> whatever program there is detached the uref is dropped. So I don't think
> any circular refs can happen unless a prog can somehow prevent its own
> detachment.
>
> Could be mis-remembering though.
>
> Thanks,
> Daniel


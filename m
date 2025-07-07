Return-Path: <bpf+bounces-62570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66679AFBE80
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219C61AA7307
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 23:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A395231A3B;
	Mon,  7 Jul 2025 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0ZkPWqX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CCC1373
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751929591; cv=none; b=VOGJ3AMimazteqd4SjbOMcywz3kBiC/k86avN0DGPy/wfs/PZzDBZD/VKKUJvENgaCYBCpRNmDESKfYOcxTWC5cjSt7AI9CQ5Bb7ln9EJGjqQNipMMmQ30EzKrRdn/jey9yGNFiCkJ5IiANbTTnwknM3K7gO9OwkL2CzhJRKWk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751929591; c=relaxed/simple;
	bh=N+jXu/m3hHYkPZ3dhzilSlleb9hfoLobSR9B8lr1sfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5ek4dJSXP+IMy10KCTHfh4pxi/C8ajo7R4V1/9xyJ1lTQ6qSW2sBfNfVltsOUrwoj/FNvGvLhw9nWVZrpf+0/r6sMIVJguEfK4jmYp+yTe51++W8LZeQoMXkQTMyjBZse8gD3NvRI/qg/RmbFKyjHM+kvHqkhpI5Qz/t9VW1p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0ZkPWqX; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso1659823f8f.0
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 16:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751929587; x=1752534387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzPZe2+MV8wswI/EVBHwpNbuwFy6M4hIZ4qah2B9hR4=;
        b=Q0ZkPWqXmySkNXfrYfE7eOtB9kaZF46+iaOH8mc3PWAWznAWxFCsdvn0WDiEDt2ORT
         AxyVky65Hz55wFQn7HdLWN21se/s6paHg4nYFV3KHEfirFUlyjruPanJFUMVBXiZIrIz
         RlwfS3uvPtQ6QVBzo1CzVrxagz+9ihQ8jEwR+R8sw9DE3qIyNK7L9ESfWvzlbMaNRoD0
         gwMeH5ZeWvdmiNF1mmFKg+VWdT+MZRS9jiyraD9YKWLqpXPsa6U3jlbygyVI3LcVglOj
         Ot1xsX/+7rGkomeDqud2uKMl8/HxZWiFa6Ovefq80+fP1N/ICR1JQpbUrczwlsGYGUcx
         JNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751929587; x=1752534387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzPZe2+MV8wswI/EVBHwpNbuwFy6M4hIZ4qah2B9hR4=;
        b=M7IhUzNuaTnLIT8xM3js0Hbo43bT+uJ0s8/owyMHTGLkqfxE25nMpY2kVIIKLGnU0U
         dH9VvnGTtclUNSKq9LnE5b8zYmBFxEcr9vlqBiM51WkSljIGT9vd7aJqYzEnMuPQRoPo
         /cW8wQVwXR9oKbVkkqV2OmMKavdSseg1Y3HXfCgrYpTa724XdXp+kplRM5im3fixfRYA
         K4e2OwdCQKvtkg0lUvO2OqCjGJZIDD0e9FmadqYhoSUoZ9Ztsge5Tpo8hdOh57bg2Mmq
         iP2lBCBJKbJPK61e+wqJo+9PLYDLHpfz6a0c6MtZ08EdwmQ2sPkR8+hQ1/EWSSZSxWHQ
         8h7w==
X-Forwarded-Encrypted: i=1; AJvYcCVZe8G7huhF1uBgSjjCNT7RSo0CdJMwmmYEvmjpPT8+VOXnA8Yt4kz3Xa4cSKU4+hVI3Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiuWWoT9fQ56q0nMM/oGZiIMV7/++FMf0qcm99m++I0Iq4DMZg
	d7f18+kmEU06nBBY6wkwWM4acqzPiwcbaS/SJ6jgBBfr/laEyyagZQTXPyr2och1KlaEAOpuakh
	YLGl41wujoG+wL+/5I0bs9QRyyUhwSS4=
X-Gm-Gg: ASbGncsJ5yvVqZQ+JdBpZD0NDh5iEduFVfPPNDRg7J3lIpxO6BxaAES12Q/FZ5bVN5T
	oMjC6SbBBNWd71YqO8XN2p9bbPaPVVm7sllKbUl4+WTNJjwzlzZVyWKVYf/UsSEVkd/t8JvwtDg
	/SnA8eL6YUXMGYF8sR6hNV4i6R0ls/wqo8N2FOntBfJ2KGI3A1W2hxUAr3v5NfBIJHBfr5yfht
X-Google-Smtp-Source: AGHT+IGnNUwwlSV/tYcl81YJNzcIpfQGl2D0Dl/9phYgGf/o3AelyGMtaYtd9hacEV7YIXMUhUCyZm1EW+0GUURM83o=
X-Received: by 2002:a5d:5e8b:0:b0:3a4:fc52:f5d4 with SMTP id
 ffacd0b85a97d-3b5ddefa655mr326693f8f.47.1751929587243; Mon, 07 Jul 2025
 16:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1A9DA34D-7AC9-4A77-A07D-46B4DD0E3136@oracle.com>
 <CAADnVQKDeKmz95rHT4sRX9JhrRiBR06wngVck_cVzmGtDMiK7w@mail.gmail.com> <5B89E759-2B80-433F-92AD-9B0CB16C2308@oracle.com>
In-Reply-To: <5B89E759-2B80-433F-92AD-9B0CB16C2308@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 7 Jul 2025 16:06:15 -0700
X-Gm-Features: Ac12FXy9wTrO89TVgX7kedjGl7DAP64RqVTTh10O3MQQ5AdIuaTpCSK7aD-7tCc
Message-ID: <CAADnVQ+NOs9hJW=hFeAtOmtNdQ_CT6zdMu1FnhM3xKD-oYiKZA@mail.gmail.com>
Subject: Re: [External] : Re: Potential BPF Arena Security Vulnerability,
 Possible Memory Access and Overflow Issues
To: Yifei Liu <yifei.l.liu@oracle.com>
Cc: "ast@kernel.org" <ast@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 2:43=E2=80=AFPM Yifei Liu <yifei.l.liu@oracle.com> w=
rote:
>
>
>
> > On Jul 7, 2025, at 2:19=E2=80=AFPM, Alexei Starovoitov <alexei.starovoi=
tov@gmail.com> wrote:
> >
> > On Mon, Jul 7, 2025 at 1:44=E2=80=AFPM Yifei Liu <yifei.l.liu@oracle.co=
m> wrote:
> >>
> >> Hi Alexei,
> >>
> >> I recently noticed that the verifier_arena_large selftest would fail o=
n the overflow and underflow section for 64k page size kernels. After a dee=
per investigation, the similar issue is also reproducible on 4k page size o=
ver both x86 and aarch64 platforms.
> >>
> >> The root reason of this failure looks to be a failed or missing check =
of the pointer upper 32-bit from the user space. User space could access th=
e arena space value even the pointer is not in the assigned user space poin=
ter range. For example, if the user_vm_start is 7f7d26200000 and arena size=
 is 4G (end upper bound is 7f7e26200000), when I set *(7f7e26200000 - 65536=
) =3D 20, I could also get the value of (7f7d26200000 - 65536) as 20. It sh=
ould be 0 if that is out of the range.
> >>
> >> Could you please take a look at this issue? Or could you please point =
me where is the place doing the address translation and I could try to prov=
ide a patch for this?
> >>
> >> Thank you very much.
> >> Yifei
> >>
> >> Methods on reproduce:
> >> 1. Use a 64k page size arm based kernel and run verifier_arena_large s=
elftest, it would failed on return 12 and 13. Or
> >
> > Are you sure you're running the latest kernel ?
> > This sounds like issue fixed in commit 517e8a7835e8 ("bpf: Fix
> > softlockup in arena_map_free on 64k page kernel=E2=80=9D)
> Thanks for the reply. I do check this fix and it is not related to the on=
e I mentioned above. It just fix the guard
> range so that it would not set the start address without page alignment.
>
> >
> > In general this is not a security vulnerability in any way.
> > 32-bit wraparound is there by design.
>
> If we do not check the upper 32-bit value, it would be wide open for user=
-space to access the arena space.
> And maybe even the user-space process cannot access the memory outside th=
e 4G area because it would
> try to translate all the pointers to that area.

No idea what you're trying to say.

> Plus, it would consistently fail the verifier_arena_large selftest for 64=
k page size kernels. Maybe we want to
> skip some of the overflow/underflow tests if the page size is 64k?

Skip without full understanding is not a good idea.
This test does:
        if (*(page1 + PAGE_SIZE) !=3D 0)
                return 11;
        if (*(page1 - PAGE_SIZE) !=3D 0)
                return 12;
        if (*(page2 + PAGE_SIZE) !=3D 0)
                return 13;
        if (*(page2 - PAGE_SIZE) !=3D 0)

which gets compiled into bpf insns with positive and negative 16-bit offset=
s.
When PAGE_SIZE is 64k the code is compiled into some other form,
since constant doesn't fit into 'off' field.
So the code is not checking what it is supposed to.
One way is to use inline asm. Another is to replace PAGE_SIZE
with an actual 4k constant in big_alloc1() test.


Return-Path: <bpf+bounces-78940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC40D208D4
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E567C301A63F
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 17:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD762FFF8D;
	Wed, 14 Jan 2026 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwlHug+p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5726B30101F
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411792; cv=none; b=B6eHaPZcmW7ov+uQmC/GAklbVDFhvtnoKMJCpvhR4YlSrmcFuUStj45fERwVMq53WeBJHLCUqtxY7xz+61lfNjRjR9+f0YbM24AuqnMxMXSJBEZRM6DJzG74lMhah5BysVc4Qs4pcGYxmTrCqlBHlMsU4+/g20h8f1v+JHgQJVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411792; c=relaxed/simple;
	bh=027wvgV5prb3lJXLpq19bmn+kIaf9KS5TCWPNV78EN4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p1YqZZ2isgwJ8/kRDrfejOwLBFW6Y3xp4SJjAim242dL3NvYY2ivX8eVXxzMqIk7z6ZNHnvH57z5TTOBPVM/zWn7O21NNoLM7ObzeDz1MZw5cNTHNQ+IiJZClgpKNomysmFkr2h2VxnmVpRY8nT6Y41W65Sr62k1W7hwUSXI8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwlHug+p; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ae61424095so58815eec.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 09:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768411788; x=1769016588; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uouk647O+/pS58btFtb5pw9C4TMykDaxVsldNCqHCIY=;
        b=WwlHug+p2Ko0JtNWGnFd52YaDG7WYSFNFqhtD2ulLksYvcP6b/w1LfdM5XDzkl/i1A
         ypEzix7M7OW27Kqbjwbzmw2iKF6Yzs6p71ZdtmjYVi5G0U/APd8j+ONnuzmBWfx8jdp1
         Rmq0gTbf+C7EbdrprqwL9dyUnHVyG8xmosOI40qQzSQCXbNLWklbghv+j5aS0r7CBwwi
         BuS77EgKkA0mWmAJRUDz6wRJJM5WnL15PaYMEC8lgxUWKaOqYNW44YFX1VM7shCN5d1V
         EKJsTUlK8x1mfk2IJhlhO5qPac7pdW9Ysb6dpLOZ3m2Pm4eSoeUkE2wMOKh9upDdOaUj
         QO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768411788; x=1769016588;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uouk647O+/pS58btFtb5pw9C4TMykDaxVsldNCqHCIY=;
        b=GxT4qVMBlyxKlo1w14YCQNrvkekCpAZjpsRvkEvUQEiE4vGotDibEaFPK6MKBDu+VO
         WtKBwXzSBliBrJ3F3VixUOopH6RF+4JxLVjHZQaAGd/dCB8JOjco+DNGSSNdANZfsjzk
         jejxp4vHzt59B0iXvmPBW4jCBx55f7FKUdaxWodssyWrIF8AzIlG7U+E/T/5w6LQ60vw
         EtsY20AKHR3Hf83PiHRP2f3BN22Vu+v0kzhFMCSKnk8qp0NexuWDXejwL1eoUS6mjA1e
         zxNkM5PaVt6mUN5FfQFwaLj8Du7OW4dTCE9Pl16XTqBUktQbfPQXnjTnDsnIe7kueH9d
         IiEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVikp/ljXRmsJ/bRMjwSnxfXqHgg9jnbdmji7ByziT1E3dAK6cYOdpqRdF9eoG44SWsJh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykTgbMACnHv2tFwPjdzlBxASo3pDBrX1SknQ/P9mOf9yDsyhgD
	GY8iOi001PGFQDg2FbqgLWRopjpap6OZQ3M2ghk2jzTFlQTSEi2Vbd3eZc0MGn4p
X-Gm-Gg: AY/fxX7gWsOuHKJNey3zLS8BhI/jrRjguUK/63KfxNW4o4aVHegwcbG45n9pTv/z8BK
	zjhSXFdh4kyIEoSZ1hfNT9stQc3SH2wC+A+/631w105EUQNLdWrQ71LXN+4w/jdwSUwUy+Ug2/K
	x/OPksrxbQk/OhR9rvZxeDEkVGVltkcNCp0ZaLeRogb6cCvXAz9nE5d8DJfb/XclVDUOrzgiQ9b
	p8WPm46FogswQzj4OCNss6LVLCExOh38DXvWeK+XfWYPJcRexLbweesJbVR/MtZ1L9QIekJsPnL
	4pxpyVJ9i0ziP5iXDMaFp7LvbvYrfCb1c9iBgQ7/bIhFuosIyH2LiqxKDnJarDiS181P5P1BnlL
	VwmHWQvUJwUymm9poiVjV87wJZL0mQSi0C2C+Tp3bi5KfFlo9kS9ywEaqHAvztOygXfGFUe68Pf
	Z/CpdIt5XMBj710nWGmicxw5OoY8tFl1jc6ryQdkrp7a8Eh6Sf/fWxf8zXsfd0Xx67vw==
X-Received: by 2002:a05:7300:ec01:b0:2ae:2bb8:a6fd with SMTP id 5a478bee46e88-2b487086652mr4668333eec.24.1768411788139;
        Wed, 14 Jan 2026 09:29:48 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:19da:d3de:fbdf:aaba? ([2620:10d:c090:500::c9bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707d57aasm19058173eec.30.2026.01.14.09.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:29:47 -0800 (PST)
Message-ID: <d9369d16c7f8975772b988d95e494471172e2293.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/2] bpf: Live registers computation with
 gotox
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>,  Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 14 Jan 2026 09:29:45 -0800
In-Reply-To: <20260114162544.83253-1-a.s.protopopov@gmail.com>
References: <20260114162544.83253-1-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-14 at 16:25 +0000, Anton Protopopov wrote:
> While adding a selftest for live registers computation with gotox,
> I've noticed that the code is actually incomplete. Namely, the
> destination register rX in `gotox rX` wasn't actually considered
> as used. Fix this and add a selftest.
>=20
> v1 -> v2:
>   * only enable the new selftest on x86 and arm64
>=20
> v1: https://lore.kernel.org/bpf/20260114113314.32649-1-a.s.protopopov@gma=
il.com/T/#t
>=20
> Anton Protopopov (2):
>   bpf: Properly mark live registers for indirect jumps
>   selftests/bpf: Extend live regs tests with a test for gotox
>=20
>  kernel/bpf/verifier.c                         |  6 +++
>  .../bpf/progs/compute_live_registers.c        | 41 +++++++++++++++++++
>  2 files changed, 47 insertions(+)

Huh, how did we miss this one?
Thank you for the patches.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


Return-Path: <bpf+bounces-79244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85848D3178B
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B9DA309482E
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 12:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F256E22D7B6;
	Fri, 16 Jan 2026 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8tYHRXM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041971F1932
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568395; cv=pass; b=eg01kkb1R7LdFNQME5OcDHne/OLCNO6TM9BKdyj9556ynJoq5TN97hTiE6ADkXHgY6/ALA4Ar2XOnN4fEQeG95Nv66ttMghviGDfe71idufvGfmHZQLruEWGLNk7VEKkA3FXtInF3PoMKZXw143HBOJ2MxwBBpgLsw2X7Vnr48o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568395; c=relaxed/simple;
	bh=5XrZEu7IM2qF9d+CyS0+9uAYhKYc+7JWy68FH5vx7/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UETN46cs5ihQDy5u0bNxo16fgISiSMVfQDPLbM7wQhzn34pOMXGozKKDhuD0gaLzBECakv1cu5sgXCWwbXIJcyIViD+gan8v/yttcghEcGWg9v1scG6JuRNXETjUa73InPMB1QkiYgHpx8lXONUsHCZhqHNbnJS3IUzd8BHm00c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8tYHRXM; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b876798b97eso333911666b.1
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 04:59:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768568392; cv=none;
        d=google.com; s=arc-20240605;
        b=SspwiaIY8HqeZoLRF1ttzd/t0DSxnOKwnNfMixdDxze32mYfdZnywsrK5PHOI41RJN
         PCy1xQJGyGTqDkml/bhD7F9k9oz+FLUVe9tEMcw7d2Ze6NL7Y4vAKhmvkkdA+lWYTJQJ
         6GGMLKJ1RgfgeF+6gcXA++Zi+m1eyv/Sr5F73bfEGTSKQ4L62q6QamKjo30Z17xj+XSu
         Qq7PQLXjHpGUkM1laDG0Gc63u9igRUA1HN1FWfhDw5qTgFn7hBMll8ttoo6m+0aDogob
         q50k1LQFYZoqGUdepdr7mHgm/EiKmnDYD9gHsRxiVdeiQ5aaNOERkJW4GY82KS6HuMR5
         pBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KaFtW2Z8I9yicCNtr1Z0UdrlsofWrWtI4cSYysTIiSU=;
        fh=s/U2tX1QyS+6Cr3UC+tsC37VXjN1NmMqAyctztF2ai4=;
        b=Wt+ZWIBn1c7T7j4r/syVGpq3BuBXtJrtiKLab/x3N7B8LCU6SWsQVBxOpEUw8/G0hw
         fGjex4Bsgkfw6kmVkr2UcKKAV1KzgmHkpitzx2XLKemY9Krm7eC/y/lYS/85v1hrqZN6
         2WZpaOCTWodpYYkUBPwEWdEx2xcmxi9pwmTOstUU/oNea7MDHsSj0VXy+w8aYk8MH7AV
         kkUTRqXeyyWOQjUFzpKO5c9L6Makp5fO0WCK+7FOhg3l2NcTiYx4Mi3QEBP67X+V6l1R
         wJ1AEhXVUgJKF0/xphSUdPwtQnn263e73cpVVUoJLEW5In4Nh/Us8AR3EJq7e/j2i/ek
         tbWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768568392; x=1769173192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaFtW2Z8I9yicCNtr1Z0UdrlsofWrWtI4cSYysTIiSU=;
        b=N8tYHRXMdLyirKM9f0fvzdrbkhZpeIQ2kaVmwwFJH87TbFxKccgnHswN1oxMPw55mP
         RggkE81x5J6ANYGye6tKvnw9ADzzkn8BUxLc/GQFUuMT0vqreH86ar6Hz3yRV4n/Fpjk
         RHGkCCJvOaTIM9HO2Dgdxo9PjucP25r2PmjwzqJ7CZfTLgpf239/Zj39vP2BGksGqHvq
         WFJBXwsuwrfdmxSdLemL+nHuAR5+Aeq9F7sjGznDRK9+dgEU0xkBgMMW7ONR/byjg184
         9vSwItJD+h83K2hfdew1diJUQnIX2rp/Z10Rgd2LsMCXUSpRm8lUpDJ1W9KdDHDqJi5P
         VnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768568392; x=1769173192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KaFtW2Z8I9yicCNtr1Z0UdrlsofWrWtI4cSYysTIiSU=;
        b=eGFdPkGSl86jhtDOJXWH3Juf2WHDrxx2fxSFYQH7z4Ce1ys7Kt39c2ARd/YOWyD7uH
         2hPH5MHJpLerAB7duheRaOqKtm3+JdScEub4ghpVEMQ08Z53YMNO66kgci/NW1l4OUeN
         M8t1HrqvvJfpHADg6YDzgCW4YIX0FyQcgO4CY/yCu5TpTMriiFhicOmmPxU4gMZw0jX2
         0Ylqi91hVM11KgV3FgOrLZovXXT7MlNAj0dleG3xqSC9XptQI+EpXjEetqTdvU8nVEpA
         V+/Btj/ouPwYh5jT+RYgf+9jSN4cnlzhDXTePJEx8ksQ2HlHOb+Jx62oW5p/DDgl9cDU
         tLng==
X-Gm-Message-State: AOJu0YwG4NeqqzY8Vj7ozRtx8DSbxFBwIgR5TfmxJRq9ja0SW9kQWcr7
	tVoYzkqnnVXwtJuQbe9bkkj4GjQ/msr1LYJk9HmMQ+KQTzoZyQ8p+zAZZOigx13K+6qC8912D/9
	wKuFoS9qpkR2wM/k3x52O7iYlr9laWoE=
X-Gm-Gg: AY/fxX7qRkOoLrYXN84ZFbso5mpBIv9+TKjtON2QNNp1poB0/MC9ILEQDSMXZWHdfx6
	OrXKiXAOPf+2+6qFBAFPcspVBPQ2I0MxRIaXcf2ZHHiCerCn2KHmgtxQYj7nySsVhK3mvRb7Vlx
	PNCgHXNs/Bm2czOvzJQR0xCZG6/gUINWkugfqPGfGsqSuRffb7UI6SxVx84hz9qQCbCf/EnJ2mM
	pUVGfSmBv51qFGzMxYPjlqpvchwUII6h4MZyD1DEM/BDYBjG7oQ2lfFdavzPt7GcZqcSt4=
X-Received: by 2002:a17:907:848:b0:b87:2780:1b34 with SMTP id
 a640c23a62f3a-b879324d779mr259027066b.61.1768568392170; Fri, 16 Jan 2026
 04:59:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115151143.1344724-1-puranjay@kernel.org> <20260115151143.1344724-2-puranjay@kernel.org>
 <CAEf4BzbXo0FCxJwjrk_O0YBCPkDW0a5-gFW8VEbQDqu4P-XP+Q@mail.gmail.com>
In-Reply-To: <CAEf4BzbXo0FCxJwjrk_O0YBCPkDW0a5-gFW8VEbQDqu4P-XP+Q@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 16 Jan 2026 13:59:40 +0100
X-Gm-Features: AZwV_Qjv5JmkUIH3YMI7doKlz10bV_lCFrAqPbJG-eWCc7frFESVw2Ucl3F67ZA
Message-ID: <CANk7y0gMC6VYwgzebi8SvV4EFGvEhNiGo8JXus2XnXxEVJ+zRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Preserve id of register in sync_linked_regs()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 11:43=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jan 15, 2026 at 7:11=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > sync_linked_regs() copies the id of known_reg to reg when propagating
> > bounds of known_reg to reg using the off of known_reg, but when
> > known_reg was linked to reg like:
> >
> > known_reg =3D reg         ; both known_reg and reg get same id
> > known_reg +=3D 4          ; known_reg gets off =3D 4, and its id gets B=
PF_ADD_CONST
> >
> > now when a call to sync_linked_regs() happens, let's say with the follo=
wing:
> >
> > if known_reg >=3D 10 goto pc+2
> >
> > known_reg's new bounds are propagated to reg but now reg gets
> > BPF_ADD_CONST from the copy.
> >
> > This means if another link to reg is created like:
> >
> > another_reg =3D reg       ; another_reg should get the id of reg but
> >                           assign_scalar_id_before_mov() sees
> >                           BPF_ADD_CONST on reg and assigns a new id to =
it.
> >
> > As reg has a new id now, known_reg's link to reg is broken. If we find
> > new bounds for known_reg, they will not be propagated to reg.
> >
> > This can be seen in the selftest added in the next commit:
> >
> > 0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
> > 1: (57) r0 &=3D 255                     ; R0=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D(0x0; 0xff))
> > 2: (bf) r1 =3D r0                       ; R0=3Dscalar(id=3D1,smin=3Dsmi=
n32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D(0x0; 0xff)) R1=3Dsca=
lar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D=
(0x0; 0xff))
> > 3: (07) r1 +=3D 4                       ; R1=3Dscalar(id=3D1+4,smin=3Du=
min=3Dsmin32=3Dumin32=3D4,smax=3Dumax=3Dsmax32=3Dumax32=3D259,var_off=3D(0x=
0; 0x1ff))
> > 4: (a5) if r1 < 0xa goto pc+4         ; R1=3Dscalar(id=3D1+4,smin=3Dumi=
n=3Dsmin32=3Dumin32=3D10,smax=3Dumax=3Dsmax32=3Dumax32=3D259,var_off=3D(0x0=
; 0x1ff))
> > 5: (bf) r2 =3D r0                       ; R0=3Dscalar(id=3D2,smin=3Dumi=
n=3Dsmin32=3Dumin32=3D6,smax=3Dumax=3Dsmax32=3Dumax32=3D255) R2=3Dscalar(id=
=3D2,smin=3Dumin=3Dsmin32=3Dumin32=3D6,smax=3Dumax=3Dsmax32=3Dumax32=3D255)
> > 6: (a5) if r1 < 0xe goto pc+2         ; R1=3Dscalar(id=3D1+4,smin=3Dumi=
n=3Dsmin32=3Dumin32=3D14,smax=3Dumax=3Dsmax32=3Dumax32=3D259,var_off=3D(0x0=
; 0x1ff))
> > 7: (35) if r0 >=3D 0xa goto pc+1        ; R0=3Dscalar(id=3D2,smin=3Dumi=
n=3Dsmin32=3Dumin32=3D6,smax=3Dumax=3Dsmax32=3Dumax32=3D9,var_off=3D(0x0; 0=
xf))
> > 8: (37) r0 /=3D 0
> > div by zero
> >
> > When 4 is verified, r1's bounds are propagated to r0 but r0 also gets
> > BPF_ADD_CONST (bug).
> > When 5 is verified, r0 gets a new id (2) and its link with r1 is broken=
.
> >
> > After 6 we know r1 has bounds [14, 259] and therefore r0 should have
> > bounds [10, 255], therefore the branch at 7 is always taken. But becaus=
e
> > r0's id was changed to 2, r1's new bounds are not propagated to r0.
> > The verifier still thinks r0 has bounds [6, 255] before 7 and execution
> > can reach div by zero.
> >
> > Fix this by preserving id in sync_linked_regs() like off and subreg_def=
.
>
> We should mark_reg_scratched() all the registers that got new IDs or
> new ranges or offsets. Basically, if anything about register state was
> changed, even if verified instruction doesn't work with that register
> directly, all affected registers (we can think about this as side
> effects) should be "scratched" and emitted in the verifier log.
>

I agree, will send a separate patch for this.


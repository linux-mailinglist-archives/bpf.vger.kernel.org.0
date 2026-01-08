Return-Path: <bpf+bounces-78258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5E6D0678A
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 23:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC7AF302EF74
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 22:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D673382D2;
	Thu,  8 Jan 2026 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KP4G76vN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5082332C33D
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912491; cv=pass; b=R1SSrC5tiik+qXQzFmOXDcVTUgZuWvQM2kPe9qG4gG4YgEFPeM0OPdEY0WyA7D9tOeT8jfk0W2431il4f+0ad8YY1tW9sOcGevCklcqgYiv2oa/sPce6760DhPuXnuSCEQNuqlpMnpL5tzXq3d2eXoCfu5vT1E36l6nvc/Kr0FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912491; c=relaxed/simple;
	bh=WV9pPdU0/t3bo7zpdI6NRHH4RIbqWrXSjDNktz3inOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drDZGwLwLOn1vAv612g7mh53xMsBb4AGHqHHDAZoiqsBV3zStiMyJQaiAT9DIyNWSNPIxR92yG4f654sUWJeLuRrwqS5MrzWS8CFZb+mC1jJvXmKag4uQw8DKiWMg0xlT6tVQYCLhwfasMN1+fasunaXjYetlp+baumkPLYFN/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KP4G76vN; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4edb8d6e98aso180951cf.0
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 14:48:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767912488; cv=none;
        d=google.com; s=arc-20240605;
        b=bDdiYKL/Z0aGwgesFw63xMyc6vCpjYXUQCMHlivX+PclgBMgbeBU+EJ+c6tGP7Qtq4
         41HwlGFkdcBOsjEgKBCSlMWnNbTSsBoTlfVlnUxuPv7mbWcqgOY2xu7Jxkzvma2mNWHG
         lm3WPB8okiugee5g5ug96rc4DZ325Ok7Yt5tmlgykvIc1ObRegA80JBCSHgnexYhiHYo
         JE4Q77BSmmfHbZyTGASGOKg2vBx+iFtPMnARtZiszWQH+7MNuP5q4ro0KQXdUNF5Br1M
         Gs5BjVKgMkbN5eIWs86o4rL8u12Vv4FvqcqUwSQfSLKz2rcMswDqTHnSeslW4h+2SKgS
         yjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WV9pPdU0/t3bo7zpdI6NRHH4RIbqWrXSjDNktz3inOI=;
        fh=rEF4SgRMYoulzJ1sWLHFRKPFcIeGNBr5BH7vVAB2DMw=;
        b=RiYkE3je19+iflTHSe3+eMVJy6CHo2cjM/9UG60h+JF7H5RanVokng2NVnrveKMFbY
         MIj6XPGNHYqO57Vo7to8ET8jm+k+nH2xifdqfk6Gxqi5FTci82gklV6MyDMuz2qEqhSs
         pTvcA8PXB+wYS6F6h5fKiIQE1qXyZ7uvVLs3QvE/MkDxX7B+7wwQJkMSNpyIlxISyd2u
         3ZfTC3Qe91Oq+8DA4v7M+tzskXHeymjUZZ3vWfEQ6qs02DV4ES2FBNttjaaxU5RDN7NG
         DKrJ80wIA9IrYLTdARr2hxNO8wDXegTRrjwCnZ5jZHZ6gzY9E3a3184/A68PXySma19h
         vGhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767912488; x=1768517288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV9pPdU0/t3bo7zpdI6NRHH4RIbqWrXSjDNktz3inOI=;
        b=KP4G76vNV8G2QJOzBZ3cs5ZC6bKRcr8+OPMKDkbNwQDkQxb+3lMTpACN3HVSNG9/Dv
         FLkKWfMtfH2Ic+yEEMP8peZE8gI3EGYV7ESz4VWTYr9Qd5/ANShPi8YR1NnIvlGecadL
         bSLz+SPPPu7zrn0o9Yg4WtX5DAxMce8uycGg32Vx6GMCx3ixgYBYzaZzYe2v1oRxVqZa
         9muz9upsFMIDXxg40v9qkD6BeUUGgYCwvvkvJcRi4iMsIB1AAdggE29ylmJVaiZ3/Khe
         87oC/F4AT3Qf4i4f6Pm945K4cbyH9cZo22WZNfrz8OMHRZ76yH+357zeIQHzuKABVaH4
         VK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767912488; x=1768517288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WV9pPdU0/t3bo7zpdI6NRHH4RIbqWrXSjDNktz3inOI=;
        b=lDQAVDNEB9CHdRroToBjdKi/aXpxN93SjHg5FwVmIqaWEUhpmXu8FZBaux+eHlIi3Z
         SYzQvJUX1PTWNOcvNCvmfxEyrSjnrqphe0M5dQ4wcyUr8fj7l2qwUg71uxnHBAgLOagF
         eyuWb0zyGTJEAqAFy0nYzbvC8OTT3F/qk5Cl6Lrtxjw1lOr0ocJOHlFVj/OHG5hh376P
         1ctIdXgVl+ZEjupqsyyaqJZwyMm2PxNNe8sCbnw2ivLajLLbWrgMpjrIb3r3VSgfiqLC
         m1egh4uTHcqpx8V54cQTv7MKE6eeweFp7+BVT+ZSucweGeV4OE5isoSJ0dJKn59PqNqB
         i0Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXu4EmaaMYFb9JJLv+srR2NIjmkgjbbhmIWGTrnrO/3VCiokIzrG6QE6VDQFTJBY3o6P7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWHiSI7p8EEsPWI0e1DrTPNqSc/BKm9HTPwnwtbPsiOSvJ6Xdh
	ZHKfAXrquCu1+YsmODsk0bOIs19/vjJpeKsqGMx/pQ4JAGfn74HZwZERA9GYAgX4tYDoRDV9Qms
	KhTTPVFwPlRsZyUtZJ4e18I2iZ9BYy8ol+Y4hYI6C
X-Gm-Gg: AY/fxX5hdxmcFfVUgY9bX7bQldmVtMykY5IQIs8YPMasJ3GDr/poUMAxa6zSzvGhatA
	q52xCJ9OitnIJrIUVfDylVJJsL2k8YfUmLz5ZYtn+TSSei6mpzDb95ZoOcjdpY9jiiEPLhDENRn
	MqreqwE6d5YQWdOHb94nhdxCB6h6dBLjZ6noXNETHWoKJ9UgidcraahDyYZ/iDaU2H10J/QcwO8
	wAJVHK1nWePQb+j/MnCuIIGdkDqb8ThGZsIM44OkM4w0NzLF/jhs3+83JapitMasq0PqHOuyciK
	PGAgyfILazgiZsjAxnK0ddDxRr1nLBGeDTH8au1Bt8Kk+SLczO7x+JAUVs0=
X-Received: by 2002:ac8:7dc8:0:b0:4f3:54eb:f26e with SMTP id
 d75a77b69052e-4ffcb1703famr1912391cf.1.1767912487896; Thu, 08 Jan 2026
 14:48:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com> <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
In-Reply-To: <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 8 Jan 2026 17:47:51 -0500
X-Gm-Features: AQt7F2rHIoIx_fDko3yxcFPFIn-ukKfEKFlHAg0ugBLMmvSi3Dr6twPz-fvm6JM
Message-ID: <CADVnQykyiM=qDoa_7zFhrZ4Q_D8FPN0_FhUn+k16cLHM9WBOCw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill cases
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com, 
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:46=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.co=
m> wrote:
> >
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Linux Accurate ECN test sets using ACE counters and AccECN options to
> > cover several scenarios: Connection teardown, different ACK conditions,
> > counter wrapping, SACK space grabbing, fallback schemes, negotiation
> > retransmission/reorder/loss, AccECN option drop/loss, different
> > handshake reflectors, data with marking, and different sysctl values.
> >
> > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > ---

A third note:

(3)


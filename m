Return-Path: <bpf+bounces-62583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBB9AFBF7B
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDF43AFE94
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 00:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738C11DD889;
	Tue,  8 Jul 2025 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqTK3vz8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F9128819
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935906; cv=none; b=T0nEkku1M9G0uLtg0ZCUEIivmwsn1vpf2TZNnZppdXzqc5wWD5zJbB5t0EvshneUGj8cN2Mza3RJuOmfI8dY5lRKWgFIEPIsEydWSV35tI5lYIQNHyemXA11WRYNjWrN5Pb/O386gcwt39Y9d/yFnYmwaeZFzDhARrLAobeoIaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935906; c=relaxed/simple;
	bh=I3i4z3inVkqxvlOQrOErnFTTFQLcmxaJcQj9xIfqv6Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bA9htXlwUZNYC8ziS6da/Wkxa/flhUvo5da3ZILWjd0W28VXFNf2EnRw1Y/ywReCs60lqV3Dq7SC/AzVa3my1YIo1VallkA2hj8YklKZVEKpLFO0v21faW5gJGFgj8/awqwtnLLxxyiW04r+aYHZCnzd6igQqGd9FTMf8ueB7uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqTK3vz8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234b9dfb842so34247205ad.1
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 17:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751935904; x=1752540704; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jg0dDU2xo8we0ZpzR/pOtATbh+OGP1xXwNeQSnucsmo=;
        b=kqTK3vz87oA8WqR7+taxjEzZ3W6YRboyCv/o1lnIUObSWK0PHd2a2zuwR05LTDfw5J
         ag22SjL+2lFV1kJJrK5ttQXW2ZFR5RaEd+XFlGq7ownrRsrS2UjfOXc1bFPLyFA6HtcX
         9qQk87F73MECEErL+xKR4BNaF3bw/pTU8wl2R8wXX9MSbrqpvhMvg/FLzOvWBgI/pymd
         thqw9zR15FciZ0s4GEsh8cH1f76hwL2lih4HTpsn+n37EObjE88mhm8/BMgEOIq4c+iq
         Bhi9lm4zNEm6iJ2EHt/IU7174Pbd1DNKg6eUggpWJMOFtQwqo3LPZiP4ApmidzIQs7fa
         Xa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751935904; x=1752540704;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jg0dDU2xo8we0ZpzR/pOtATbh+OGP1xXwNeQSnucsmo=;
        b=cn8B/VpDPI+1wcfq+skKsZR42w5oZ6bZ8WowdUqwaVBx5AL4vN+8S9xpw407UEGnbM
         til99kXNzVVZNwZfGwnGcTpRlJ/rM68GqCkZz6k4yXYmV2AD2sQ/NFHbwpGRAoVoaYiN
         yhPmRTy+UIsao/BpyQo3evnqV2+RseSMDexXgntFWaF1hR8wNX6BkEJKMDvBliKLEWom
         zR89Lli+hZgtHaLftjw5KNzBXC5mjhubDFjC+1N/JvF/hskmNktMKVFxAwWu2VCeivlc
         +CqQYOvMZZEcoUlheLo96/ViBZqG8WFLHNOs+HpZxwp0O+eATGCpDSAHfstQtGxVO+f/
         Cb6g==
X-Forwarded-Encrypted: i=1; AJvYcCU5JVMR7QSBHieXMPFmGVyfCf9iCBPkvmfWob22TTDSkXPVIIVjXQIZBimoTIhbsHLDKNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3O6FXVLQ0XvFj+l0EagqPBJNVsPmJfxkan4shl1Lz2poT7Da+
	mCYUf59Q+84gtNFvgd/erE+q9EAkadcKZXOj8cePMFaL9AVpZS1ktNZF
X-Gm-Gg: ASbGncslr9AJAUEyaqJ6Z+sOl/ik6IRaAcRpFieRWWhzT7BcAQQPl8FeTZ96v7cfU++
	ti0EChMKQSSMrGMKfP9Ktvyf1rCKFLnGQXrW1rTSLVYuzSVVuzYXz1+zeU3PoZhGSrLQ7ul1b8I
	pwHFaGNAr7OekA9rHRydOCqkFcBESNhFE3+behYT59NPVhiUZamQI+aNw/+CtyqnumUZERsSL1g
	TmRzZ111Y+laSVSPI9ApoNUpYJ2r7/fMK2S1JzXOIJMRJjNWRLOYm4KNIr0URglAPizsxLAdeeV
	5Stw+ahJt9FB+f5YG5cd5k34uam2pAVShdKEMe2U6helzXvNDjLa3MtlwFsc7QSPUDk=
X-Google-Smtp-Source: AGHT+IGYkMJLNtt1JjeiIhx9nu3agojM9DNTiW3n9PkK+864ghcKoeRCMbFXLFqeT8UqNEjLAooCiw==
X-Received: by 2002:a17:902:cf05:b0:21f:4649:fd49 with SMTP id d9443c01a7336-23c875db9d1mr203864445ad.49.1751935903872;
        Mon, 07 Jul 2025 17:51:43 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:6ad])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455e74fsm101919145ad.99.2025.07.07.17.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 17:51:43 -0700 (PDT)
Message-ID: <5b05cc186350a1639fb49feb9b5d522b6a7e2550.camel@gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Anton Protopopov	 <aspsk@isovalent.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Quentin Monnet	 <qmo@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>
Date: Mon, 07 Jul 2025 17:51:41 -0700
In-Reply-To: <CAADnVQ+3hutu3Fth3nnVJTAJjQUbOT+G5MPCBRYNtXEiDi1WGA@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
	 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
	 <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
	 <aFLWaNSsV7M2gV98@mail.gmail.com>
	 <e726d778a3cf75e3ceec54f5f43b9d5d66ba5e97.camel@gmail.com>
	 <CAADnVQLaBuDYBoQvVtug63MJO+2=oqb9PYap8Jv+U8HB4ETe9Q@mail.gmail.com>
	 <88c63c574dfd7d3845ac4e558643ab52e77f81dc.camel@gmail.com>
	 <CAADnVQLp=ED2XAVhgO5jgSt6Cptkw6-H19Qr+s63m+jjCDwXRg@mail.gmail.com>
	 <2dd335c0c9152a9941f42a4e70a95846f7d6de49.camel@gmail.com>
	 <CAADnVQ+3hutu3Fth3nnVJTAJjQUbOT+G5MPCBRYNtXEiDi1WGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-07 at 17:49 -0700, Alexei Starovoitov wrote:
> On Mon, Jul 7, 2025 at 5:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Mon, 2025-07-07 at 17:12 -0700, Alexei Starovoitov wrote:
> >=20
> > [...]
> >=20
> > > > check_cfg(), right, thank you.
> > > > But still, this feels like an artificial limitation.
> > > > Just because we have a check_cfg() pass as a separate thing we need
> > > > this hint.
> > >=20
> > > and insn_successors().
> > > All of them have to work before the main verifier analysis.
> >=20
> > Yeah, I see.
> > In theory, it shouldn't be hard to write a reaching definitions
> > analysis and make it do an additional pass once a connection between
> > gotox and a map is established.  And have this run before main
> > verification pass.
>=20
> Yes. In theory :) But we don't have it today.
> Hence I don't understand the pushback to llvm-aid.
> If/when such dataflow analysis is available, we can drop llvm-aid.

No pushback, I forgot about changes needed in check_cfg() + I need to
rant a bit.


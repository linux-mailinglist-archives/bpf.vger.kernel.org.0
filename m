Return-Path: <bpf+bounces-61474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85684AE73AD
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 02:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C959816E75C
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173411863E;
	Wed, 25 Jun 2025 00:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7ALmAIQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAC030748D
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 00:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750810559; cv=none; b=Vl1R7y8l999xpeESSNXCcdY/yzUF6DPx2Ql3Gl49iMFB9JfjzvZWjZI/ZSNRuMpGw0CU3vh8qVnfKpDj+FBeInMFVLGH/eH0l7csM/IMmvKzFroq7shYMIWxPUCujqha2udeWf0Sr+DUtJcbYzpS5o7WyQa28xPXjqbtwO+aR3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750810559; c=relaxed/simple;
	bh=gJEqOY5MsAD/pPN6amihkynh/D2izSQb5CNqalZMKlA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XLrXsh0D6VLwGofvy04DLh0qHKRjl/CIgEGSg6PJyiDtTgdbku78UrPZF67VuFASSbUA+FdllM7k34fodjTdt9+ssG129jYykucbmhtpyjyqB6nz0xzlx4LZfGNSgohJ2S+KLjCAkRs48Y/S9t4nzZMB5rgJMOW6RBONSk3g+Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7ALmAIQ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2fca9dc5f8so1087890a12.1
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 17:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750810557; x=1751415357; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1m05b87yezg0o9wu4MlqGOA42pIv6fdisFWRj5Qna0E=;
        b=J7ALmAIQvxguRh6QXR1wqwmx3BZ6NONM84hFX6w33zzuS/vyhEIklEq0npxb9ENLZc
         /0UWySXonJqMwjYwHLHbOv3t6Oh/8Rw2oLK+5Eo6rDC2pfEyDox7adeV4Tps03GFy2KW
         OPIVGkXLi3u28Dync8AM0D+mWe+MfsRfr8ptu/4F/eN8WpTR0U+l/HX+ax64lcG7j3A1
         5yD8r3vKNDLF38AbEkX/7C8dSAYZk5B9BQ9RbCaZGmIrUNXR+a5knCPsonyoBez1Aff0
         uFn3JdEv4JLtNU/1W1Ke6dFHxz+lKz4DOq5P9LsPqkpRvHv5qFVEX0IzO6VXuqlRPk5J
         gG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750810557; x=1751415357;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1m05b87yezg0o9wu4MlqGOA42pIv6fdisFWRj5Qna0E=;
        b=V6qQEfGp+sZ+xqkKW+H5Q6eAW8pvRi0egyuSJBlqdYx1Uzncl68o7Y+rShO8Ol81rz
         SXE5qD8fykFcoOm7DIaxOlZZnz0jWDOhw+agoBHTCqN1nBi/cf2vq6kCQSywcw8MDp1B
         vDSYOV/oGu6W3vgFnvGm/mcIOjTatVuRT0IBkxpg4drQxEQzkFW7DQf63ZsXDYGKIKAg
         JEVhgPYrIlq9kyabYTl7dcKOxXZDbnR6u01bz7OgjDceKimk/C++gDClFLAIxs32wAxD
         kuldm4RNR0vMLJMwSmVjrm4udBpWjhMl+S0a8/yV6d2wVFlGOmHdyIL+8GOWYYvF2H3s
         ow0A==
X-Gm-Message-State: AOJu0YyNT/7y8GCa7g3qXOHHWduZ3DKXh9ZmugqV6SuTeMYvr/BxfmHb
	Q8qaSGyibHn/MWWavmg0xgI2vaZIgJa8LzHWkMlbu52GtxEWkFleRKrrJFMgCnKrhvY=
X-Gm-Gg: ASbGnct0o+VwJqbqbyZMdPghrTdAT5m7R8oTosn657VtpqIWSfZn4pBkGsHrCeKMUWD
	r07H6kttoYFDrO2WJ9SWyigEFqimCpcvwYu7zDqFl893HPYOrWvyAvhvJnbT7DhMZLYBcLFx3Fz
	MpeRIlfAzhCBF6ckGv66lYFSOuA0Ry1hD9fde9aElN5IH9qpQDhbPEKg7hCCfk6+PhEEOic0KFk
	NF/OnJ76Q3jRfZS23hxcvAy6va5LoJu1NOeUiEpxN0/W7mv0oi5uWOX73uY07C/7J29uJEFtanw
	do/VibBK7G34f35YWbVnq247I3/x103L1Y+1rYFrgKkz95WuoOK0XE4shJ9slmzot4xmAE7g6eE
	73+hE4U3wdw==
X-Google-Smtp-Source: AGHT+IHWnoOhriYqfUgJB83UEdktuSFkX3voKhngG8DvHQmThSQo+pO0dfsYiqrAeCfqn5wumm69OQ==
X-Received: by 2002:a17:90b:164d:b0:312:25dd:1c86 with SMTP id 98e67ed59e1d1-315f2698b39mr1391933a91.18.1750810557526;
        Tue, 24 Jun 2025 17:15:57 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9b77:d425:d62:b7ce? ([2620:10d:c090:500::6:f262])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f53dbf50sm280262a91.35.2025.06.24.17.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 17:15:57 -0700 (PDT)
Message-ID: <63fa058d2be2c91cd8c2835ee7d88b745dad2849.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: allow void* cast using
 bpf_rdonly_cast()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>
Date: Tue, 24 Jun 2025 17:15:55 -0700
In-Reply-To: <CAADnVQ+OjowmcVdYkAR-VLZUWNbvkG=i78gV4-76YdFJL2DJ6Q@mail.gmail.com>
References: <20250625000520.2700423-1-eddyz87@gmail.com>
	 <20250625000520.2700423-3-eddyz87@gmail.com>
	 <CAADnVQ+OjowmcVdYkAR-VLZUWNbvkG=i78gV4-76YdFJL2DJ6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-24 at 17:11 -0700, Alexei Starovoitov wrote:

[...]

> >  enum bpf_features {
> > -       __MAX_BPF_FEAT =3D 0,
> > +       BPF_FEAT_RDONLY_CAST_TO_VOID =3D 0,
> > +       __MAX_BPF_FEAT =3D 1,
>=20
> and the idea is to manually adjust it every time?!
> That's way too much churn.
> Either remove it or keep it without assignment.
> Just as __MAX_BPF_FEAT. Like similar thing in enum bpf_link_type.

I probably did not understand your previous message:

   > > +enum bpf_features {
   > > +       BPF_FEAT_RDONLY_CAST_TO_VOID =3D 0,
   > > +       BPF_FEAT_TOTAL,
   >=20
   > I don't see the value of 'total', but not strongly against it.
   > But pls be consistent with __MAX_BPF_CMD, __MAX_BPF_MAP_TYPE, ...
   > Say, __MAX_BPF_FEAT ?
   >=20
   >=20
   > Also it's better to introduce this enum in some earlier patch,
   > and then always add BTF_FEAT_... to this enum
   > in the same patch that adds the feature to make
   > sure backports won't screw it up.
   > Another rule should be to always assign a number to it.


Specifically: "Another rule should be to always assign a number to it."
The BPF_FEAT_RDONLY_CAST_TO_VOID already had a number, so I assumed
you were talking about __MAX_BPF_FEAT.
What did you mean?


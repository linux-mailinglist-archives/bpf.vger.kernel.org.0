Return-Path: <bpf+bounces-78173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAACD00946
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 02:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43A5B3010FDA
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 01:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780091F1534;
	Thu,  8 Jan 2026 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epLoKijd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2749F9C0
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767836854; cv=none; b=AL03zZHI/rmmBpL5x4Q2EE8g9j+dTDAZeMbMp+Yc5gMXdPSHc2M2MBDcMsR3FM3PCCddnyXQ2ovBmfUhcsaDxnAnehWMeNkoWyiV4NC42H+LGLdJqcimcH3MFopFtW8OlSjZmXqkUazwkvPp886u3oNx/8mUK39s/DtSkGAjt9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767836854; c=relaxed/simple;
	bh=d6kAMiiOVEYlunwGnBPBqNvr5MxngnJqAGt6zAJDAvE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D7G53SZH4PE/dZFWJcHqklq92BgHvzTPNehQIVR7hiXvs21o3QQIQZPZXKXUPZELa2t7Ui4Ux8o2NoPpsk6mRWztMU7gzVwvTOKa4+/XN7Bry4a+P2QW1XiQkYjXE0PFIr64c1WzW2AciSZtKjZIq59cznmWKtYINVifwluFjDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epLoKijd; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-11f36012fb2so2965832c88.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 17:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767836852; x=1768441652; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XqG8F1o/gXgOp/lkCGLKEWrGr3qJQ4KdmWnSdsL6lOQ=;
        b=epLoKijdtgdqDMNgHIzxMMSdv1w8oV3xN2czvZAXcgCwOY+dZJZwP1Vs6OktgRuj9g
         y04UpcQwXs+twUjKpduLYPAf2xW7tySDQ9qwxw8VaBIKt++9TKcqZ0g3kI54rfrPDf+f
         CqXX0PzgyQpF0WMEJ6NMoUJMGStNUxU1GPatdXpqNNPH3hhsH6Jt9Kl3Xxxwft4S+DSu
         5jFR1/yxaSWEOzItwliUG1rB8YumZKfYUbrAwQAyMvsgE1q5ku06WTIxqEuxtdBXsJlP
         U3GoNJ0wWV365bm4HUJWPxoUqxZF6qdLShwi/lBRSGj+cepcjBOPkEkn3YTDDQ7CySkH
         ZuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767836852; x=1768441652;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqG8F1o/gXgOp/lkCGLKEWrGr3qJQ4KdmWnSdsL6lOQ=;
        b=JkTIks6qZyPoR51+SWuVkxi3MuF8V0RRNnz2w/AosnHnwUCaRFX1IYSiTZXVL5R5z1
         da4lMexhBdhUyVWOtStQGo2sazQ6Lhjh9BP0/NpmYO55m1wVsFUFpMwNzSUn4zC4+8Dh
         /p3kNNOExF+bYYmxNYpAodzsuy/QLfH/jN1S3gIw/ZgcuOM/Q2hWoZaZdxNEiJ2CwWOf
         uSuXUAMNvShAJ9lqjdmoyeprV5yaZ8FJTbJoXPBo9xNqI5UwbbP8ZGmEQvcykGYLA/WD
         KeQto/HUxD7fxdjsxuo26H2EVK1sH/HJiX6YsTvFFr0RJ6izRn2DiAvu0WYau8RliPk5
         R4Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWf1BuRKyghmpCkZlGEpu+oBoKKcT67AlZG+K3q6IZ1QOR9FNLj2xLKZlIhBtHYnJO/3ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT1d+or2Op7z9dcQSQA7nNGRYsnN7Nr7Q0r+DDkSer4WEFI6c/
	+3smPOzsE8Z8rbRBUlkgTPUPWmQ9UPX6YmDxXZ/NrW4fjRdMhGwIYpNo
X-Gm-Gg: AY/fxX4mvB4EHjCYTy2wA6lWc6FpKXFVpgdgxRTPxTFYZr0CFrn2NnIcnyElhsqNRwI
	CkPT2dWWyLa/PjxQXixy5A76LUEko5LW2IQBgcQ6ZK7J9WRce3pNvgKzQJthBliV3cmkB9ZALTA
	XWGqnDd32D/D4KNClU3m/+6z0Lnd+qQpHzoDGnBAVhQ4agQwPYjyaPi5UurqCIiqbABAqYBqD+Q
	BuISPaBVt8rqgLrfK3P2iFYknhjiJ/bqseg+Zj0XFuVWoU8ueGaaOnASiTJ9IuzqaSloCWrjvtk
	GQPvLVWqy2A1R6Q2ADgNFaoS49kJ3mtLFOUHRNBrCur+djZ0GIG+LWPCKaYcl17mlaf7mVvSh6n
	v6798lL7fOvkJkgS1HB+Qwy8yCjClKFbzX7V5dCGg1kGRYcrDU7l5KL2SE6kNapYr1v6TCeKGro
	zEe4Ee3aAMKniZeE8gjBM7YI+fJWfB9mGLVvZy
X-Google-Smtp-Source: AGHT+IEvY4W9V4g03s1XI2YcL7SbIHE/z0xJKEBFRKSZce3D31rieu1271zHbtKzRsrAhkcfX7fnBA==
X-Received: by 2002:a05:7022:e23:b0:11b:baa5:f4d1 with SMTP id a92af1059eb24-121f8ac1583mr3505845c88.6.1767836851411;
        Wed, 07 Jan 2026 17:47:31 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:6741:9f57:1ccc:45f2? ([2620:10d:c090:500::2:4706])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248bb6esm11850990c88.12.2026.01.07.17.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 17:47:31 -0800 (PST)
Message-ID: <5e6bfb044463123d7671cf1eb4b9b416c5fe5c1d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Support negative offsets and BPF_SUB
 for linked register tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Wed, 07 Jan 2026 17:47:29 -0800
In-Reply-To: <5fa1d856b98cb7f0cb4eb402f616946b0c6c9211.camel@gmail.com>
References: <20260107203941.1063754-1-puranjay@kernel.org>
		 <20260107203941.1063754-2-puranjay@kernel.org>
	 <5fa1d856b98cb7f0cb4eb402f616946b0c6c9211.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-07 at 17:40 -0800, Eduard Zingerman wrote:
> On Wed, 2026-01-07 at 12:39 -0800, Puranjay Mohan wrote:
> > Extend the linked register tracking to support:
> >=20
> > 1. Negative offsets via BPF_ADD (e.g., r1 +=3D -4)
> > 2. BPF_SUB operations (e.g., r1 -=3D 4), which is treated as r1 +=3D -4
> >=20
> > Previously, the verifier only tracked positive constant deltas between
> > linked registers using BPF_ADD. This limitation meant patterns like:
> >=20
> >   r1 =3D r0
> >   r1 +=3D -4
> >   if r1 s>=3D 0 goto ...   // r1 >=3D 0 implies r0 >=3D 4
> >   // verifier couldn't propagate bounds back to r0
> >=20
> > With this change, the verifier can now track negative deltas in reg->of=
f
> > (which is already s32), enabling bound propagation for the above patter=
n.
> >=20
> > The changes include:
> > - Accept BPF_SUB in addition to BPF_ADD
> > - Change overflow check from val > (u32)S32_MAX to checking if val fits
> >   in s32 range: (s64)val !=3D (s64)(s32)val
> > - For BPF_SUB, negate the offset with a guard against S32_MIN overflow
> > - Keep !alu32 restriction as 32-bit ALU has known issues with upper bit=
s
>=20
> This is because we don't know if other registers with the same id have
> their upper 32-bits as zeroes, right?

Nah, we do know if their upper halves are zeroes or not,
registers with same id are identical up to the ->off field.
So, it appears that this restriction can be partially lifted if we
check if dst_reg upper half is zero before operation.
Wdyt?

> I'm curious how often we hit this limitation in practice, I would
> expect code operating on 32-bit values to hit this from time to time.
> E.g. see example in [1] (but it is mitigated by an LLVM workaround).
>=20
> [1] https://github.com/eddyz87/cauldron-25-llvm-workarounds/blob/master/d=
raft.md#bpfadjustoptimplserializeicmpcrossbb
>=20
> >=20
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
>=20
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> [...]


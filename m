Return-Path: <bpf+bounces-71044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8CDBE0581
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 21:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2CC84E55E4
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 19:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FFC30147D;
	Wed, 15 Oct 2025 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/x+09oH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A7E27E05F
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555948; cv=none; b=hAiAFcAsax679phSmvNGSM0u9fj7H9YlqHUDEWIXioCBg4JXWiTbkiBImSc3VuVS1xqxY320yCJRici0/ziHw1RQ6bzQCRdsSVrzdQVIDZ2DNAf6POqP/uZsVPGP7NNVand3ZSjbCq1BYTCU+2WhxZ+2n0p15o09/iyOzC14awc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555948; c=relaxed/simple;
	bh=Kfw/fZirXNRhVeaoUUjxHHITIVv6Pl4m6rQd71vPf0I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f+FbEuBQdbU46C3G/OyDQwX+LHMaDaF5dm0d5M48uyo79PIHijgNOj+u3FLCJhLKw6YQ2P1RS4kO5e+oyhKaq5YoAfgCCLrjI4Zrg6J22ykSZOQHVbosF2WN5X0IWxDZ9GDkPGAOeARNgqy5l7iX0kmn06AU9J5K1qX29c+kD5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/x+09oH; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b62fcddfa21so4300969a12.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 12:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760555944; x=1761160744; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4joM1Lbn6lO9ThZ0e+6uMuKlXzteGkUrdnSbxD3i9l0=;
        b=D/x+09oH9FGUrx8Kx57K7tYY0iRJedtAphApjaRNbEOZjQra9RMLN+yao09Pum4DcI
         Hp0N/eiTZs2ilnujOCV5n2TUrNP9I7GtXFS2w1PEhcgnYBovOvZtyCWVTnmAQSj2WoiP
         wPT6l8P/axOIlk6obVhAG+2wuKtRFargZCkS5gHCzUE79PQCByaKi8ER9OoXuMKs0/tk
         kxzCWmECDDK2xsAEcXNaQsRYBsF3JupWzEsc7zyNuhKMEwMjp9Begyo+7WvQYELxg/mB
         LPPS0TomII6ZLqlBIaMegUA5sToGtk2g4av+27c8U+VgjQgWy7si2hSy/48TwU2R/3yt
         Cf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760555944; x=1761160744;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4joM1Lbn6lO9ThZ0e+6uMuKlXzteGkUrdnSbxD3i9l0=;
        b=G1+iAjoBqI3jJ37RwOZoRQUCwAFt7FNCt+VQDU6hCFMcKx2weoagpubiz1EFY/Wpya
         kgNgPR8Lxb+bcmsK/1dhlToHdsMgQ9XXsurb4YvSBXWC5dEz/oJK6MG1Zk0fsysMa/sC
         g087EEwErMjv31A1ktpk/bSDADSpIlXoGBInUx2PYvpQDfp50JrVkFhLo9noUE1p5/+f
         0OvdYoAGb0WPDqA5PS5yYj2oSXyYL6h37s9OO1KFUQ9fH5wh/lNzsQXvVBStt+wSWkQX
         0Wd8lVW6JJGfPUAJw4K7HTxCsqucrmkwcZVu8+8iBQn5MQHBh9HeWIu7REKNc+qwxWLE
         lwrg==
X-Forwarded-Encrypted: i=1; AJvYcCXO2LPZ/0B4sWoKS4NkmCEna3aH8XuIJ2BPj1qMWC8Hc1kIShTHGl2ekejn/Nb7t2Shx00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxznZzRu2y130hLvLAbxy6G+u/iSmrWAj/KyYmJS06rPF5La/0W
	qQ0wBqo55eOam3tDOvcp2/J4wlEUnjZpsc+T9PYSvlxxd1/66nFJthkv
X-Gm-Gg: ASbGncsCiea6nF3H1MYxAYs7tW+nOmkw/M5kZfuzss4G5Z401IXhB9Hkxav9YRvVwrx
	FtacyzyFDXNYlSrVfUbb4w/lweLbWZ+ynZ7yg+bU2dbpa5tnYie3kBT5Jark7irq5mdX72zqz6D
	VUrTeF5qaD3JBZ4zfwdB9JIl/BEjMhX+jJZhRiX053GGFINQe6SmieoiyEY1lTDtx4hzRvALctQ
	nywNmaUpfTimlAEGI54jJjeIUy7rBALOfAt3RwBKicqTZKouRUdy9i86QaoltFdJL6K8BA1FNO8
	KfXKPwcYu4TkCOUXv1lFTX8uuolzrOQNtqpVoVgLSr9vjGK31TZcL2y28XfxNkdyZPcuHuJzZ4P
	d/VHeAExvGETouY/TsJ6hDbqlFxS0bvP2NlZdP4skHyX5WFFeXwxnyptlX2cl7pbrhaeHkSEUop
	N2gK/wRDaFGMMEUWZE3xk=
X-Google-Smtp-Source: AGHT+IGQSMXT2GAhp2uLSDtNWOB5A6zp5XP8dX1ZQi3MvQ+bKn4zSOvkdFjFu5CezHHYXwUgEpMb/w==
X-Received: by 2002:a17:902:f612:b0:269:8072:5be7 with SMTP id d9443c01a7336-29027303931mr375141775ad.56.1760555944310;
        Wed, 15 Oct 2025 12:19:04 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7b4a2sm3986765ad.67.2025.10.15.12.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:19:03 -0700 (PDT)
Message-ID: <895ebc85e6ced1d8eed83eae13a652a737b34850.camel@gmail.com>
Subject: Re: [RFC PATCH v2 02/11] bpf: widen dynptr size/offset to 64 bit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 15 Oct 2025 12:19:01 -0700
In-Reply-To: <20251015161155.120148-3-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
	 <20251015161155.120148-3-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Dynptr currently caps size and offset at 24 bits, which isn=E2=80=99t suf=
ficient
> for file-backed use cases; even 32 bits can be limiting. Refactor dynptr
> helpers/kfuncs to use 64-bit size and offset, ensuring consistency
> across the APIs.
>=20
> This change does not affect internals of xdp, skb or other dynptrs,
> which continue to behave as before.
>=20
> The widening enables large-file access support via dynptr, implemented
> in the next patches.

Nit: still think that mentioning that this change does not break
     binary compatibility is important.

> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

I grepped references to functions changed in this patch, all changes
seem to be consistent. The only places with leftover u32 is:

  ./fs/verity/measure.c:  u32 dynptr_sz =3D __bpf_dynptr_size(digest_ptr);

But it is probably fine to keep it as-is.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


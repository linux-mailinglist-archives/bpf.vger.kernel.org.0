Return-Path: <bpf+bounces-74634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E4AC5FEDC
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63F0C35819F
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4449F1E9B35;
	Sat, 15 Nov 2025 02:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPGRF6jD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796D617A300
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174931; cv=none; b=s/lVePMwzw5KZVHqfgSzAZvOAVqzWR/xs4HOqxH4vnVLCG5tRhI7mBbN5ntcDEaZlKwsBSaUWZRwn5e361tJZv3fpj9t2ecHJID6Y7M43XxCItc1Mr6VE1I4e2avibrg+FbGbAmEVglt/UvRiFmuAdo7IWqETO0vQO2LyTHIzF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174931; c=relaxed/simple;
	bh=A542wW2tt6U1hCZi9ET9sypR0K4UXL8BjpTEGoFdQpE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uXUBTyIZZFJhJAMVRk7rWB9JscOVqfd46X93pBAEgBZr1y0CY9YSJQNT+dvbboQgUYD4EdwhBuddTA/YUH0CX2cCZxoW3NTqS0pRY5djlOY3KAMBWn7LFjEc5l1IyMBt+fhHPugTV0NnrQ7NKEyAnRuP9Td6cAHExaA90fz2eRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPGRF6jD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297d4ac44fbso27600475ad.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763174930; x=1763779730; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dfk+MbsLbFdAdM8FyWm7dTdZHIb10yDkH6iaeIr2SP8=;
        b=JPGRF6jD4NjFs2K+UIEcVfFFQdhx6ms6QeNzJTCO8hbpnpj2R3MSiKPjWP/2LUnlbO
         Ff/L0JucQ5D3S6tFkDzzIz14U9Ixx9u0keCbyxGogwUqlZsx63JJJb2aXRF3jfoV0cnA
         ME0Vjzqu0qKnWxBAWIi9uFxU3xvCI4qV0Kudxqfpy1KYFjlrmMFdWqNM7Faogwl/TIhC
         iHOsyqXk2liiyzN8+UUpwjSt+MTnlYiHKnnKhk51Tq/OvD5IYHqHQL/5ADzOltkZ+Jcx
         m0rqGBKIvnuEP8b+/guEGV7AZw2Be+6G6KAMdzbOXDExx6dEP3p4219jJrpyWFWnmsar
         q5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763174930; x=1763779730;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfk+MbsLbFdAdM8FyWm7dTdZHIb10yDkH6iaeIr2SP8=;
        b=ibnNBNU088q0hevWKIV39MdD38hrs2xU+Ihf+3AUIbbR1AGLrsXSWIXJgNXPthcRSb
         s2aZRHLjnYiVRjJK4oy04vyAMgfMC6bMuubl5kZnED/rQPQinkL3AvTC+N1K6psQ2xS4
         wRMWbl/z7oyWHDDDILkvBoSEkza0hgClCYQh1zDWEvB440Y6K7oexp9hULlYvLpUSdXe
         b9fViquYdEaF0mX0noOpdbE7iBSPfjrUgC0CNhH4CpDNtMuDAHvMMXbRJaXU5IXbgQRB
         ublJJoqWNYDf5L8Qh6dGwiMKGd7OpUOxmzeeLT9JMT7jtLQFeGlD9HdwxWlTpJdmoXBO
         hfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBVDr08YUr6xTthtp1/xNo8db5DfqRVhtnPD/C5o4YgrLwULRP4f6+RugAQ/24ulIrHQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0iMDIYqsNoI4fU0PDZEW3TOdy2LA1DEDC4J/t1eu643rGCLhW
	pBzQwp0CYxeSa8eftDOrEnUuSiG762oLPu0mKbIJFSmbljHbgDfV7+P7
X-Gm-Gg: ASbGncvmMROPjE+P0SgYYJLd7FVO3zq0oybhxpc+BxuTxo3HBvv6AuKurVzvCJ6Via2
	4Kol4f3+g6y4Kf+bAQYqA4kimrXvgMR71NlC4/UrnOslZrdedfZti+jzogRvCXgniUtC/VLZm+6
	cNvahjkbvwn+jtDeLfBnppQ83NRalNktUMF5BqcuPz+w1Pc5W2n+ZrIS1FajRpX+YbvXONQPgc2
	RZ6wk3f5ApNdRx626jRgb/VtRizxrrHa9IZ3fklbueuCSy0+sp9auvN7H2ZPOSUFU09gM+z6HkN
	lkjN2z4DTegoLPcAY2p5iqrkCCeYasosC0V8Wud36BRiBJ71+sGeaSYnc/BLkpckhYDmtbhyxFX
	09tUfMyg0FCv87jegjeSczoGAIfvyZJqs+X9MPuXOQ+ZOyav9MkOfF4401EERCXep6sZ7u01oeA
	==
X-Google-Smtp-Source: AGHT+IEZbs3xjIKZ6gJ9leTVv5QHlhnvrPX+vb2s/ZmkPHUDFA22JttV9lUP9SclfOPz4QaDYleySg==
X-Received: by 2002:a17:902:e748:b0:294:fc77:f041 with SMTP id d9443c01a7336-29868010076mr64374825ad.25.1763174929715;
        Fri, 14 Nov 2025 18:48:49 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0c92sm68869525ad.69.2025.11.14.18.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 18:48:49 -0800 (PST)
Message-ID: <2dcd9e0d2fc573cc55bec7029eda3edac7b685b7.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Recognize special arithmetic shift
 in the verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	sunhao.th@gmail.com, kernel-team@fb.com
Date: Fri, 14 Nov 2025 18:48:46 -0800
In-Reply-To: <20251115022611.64898-2-alexei.starovoitov@gmail.com>
References: <20251115022611.64898-1-alexei.starovoitov@gmail.com>
	 <20251115022611.64898-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-14 at 18:26 -0800, Alexei Starovoitov wrote:

[...]

> 227: (85) call bpf_skb_store_bytes#9
> 228: (bc) w2 =3D w0
> 229: (c4) w2 s>>=3D 31   ; R2=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,=
smin32=3D-1,smax32=3D0,var_off=3D(0x0; 0xffffffff))
> 230: (54) w2 &=3D -134   ; R2=3Dscalar(smin=3D0,smax=3Dumax=3Dumax32=3D0x=
ffffff7a,smax32=3D0x7fffff7a,var_off=3D(0x0; 0xffffff7a))
>=20
> after insn 230 the register w2 can only be 0 or -134,
> but the verifier approximates it, since there is no way to
> represent two scalars in bpf_reg_state.
> After fallthough at insn 232 the w2 can only be -134,
> hence the branch at insn
> 239: (56) if w2 !=3D -136 goto pc+210
> should be always taken, and trapping insn 258 should never execute.
> LLVM generated correct code, but the verifier follows impossible
> path and rejects valid program. To fix this issue recognize this
> special LLVM optimization and fork the verifier state.
> So after insn 229: (c4) w2 s>>=3D 31
> the verifier has two states to explore:
> one with w2 =3D 0 and another with w2 =3D 0xffffffff
> which makes the verifier accept bpf_wiregard.c
>=20
> Note there are 20+ such patterns in bpf_wiregard.o compiled
> with -O1 and -O2, but they're rarely seen in other production
> bpf programs, so push_stack() approach is not a concern.
>=20
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


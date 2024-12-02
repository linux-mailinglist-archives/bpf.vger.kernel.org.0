Return-Path: <bpf+bounces-45962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 589BB9E0F0E
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 23:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9C4B235DC
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 22:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E07B1DF74A;
	Mon,  2 Dec 2024 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj10yNPL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4EF1DB940
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733179926; cv=none; b=s+QqG/n+p7cxXN6ieqqH4+poqS7CTn02uw/o+to8Bpx2CHeOTQT/8Y03nfVeFPxjmv8hY68tG9dnIbFMjpyYr7j1QWyg2P5j9YHvw+rkZ89Ny3EKCcHaSx5OAWIc719OjfoItZ85c4Klv94zi4EizOHjxyNzy71jfBdzRbVwT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733179926; c=relaxed/simple;
	bh=q6M+sJSjUa6xyo0WP/nEC8shcNUn10n3ve5JKK5p1tI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ev/mR/Q7oZX8VBA4KEA9oq7QkP0iusOtDQwSoJN50do5O85NRC78yqOpkFBNWlwMMRRHT7AFNvdJwxD46KAvsVeE1Tl2ArA1wN+StOETEyS09eZtbweMuI1oHt38OJPtBXF/K4UqfqpS3X/U+lJRIr8pKBvaTj556WJo++J619I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj10yNPL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215666ea06aso16976235ad.0
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 14:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733179923; x=1733784723; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q6M+sJSjUa6xyo0WP/nEC8shcNUn10n3ve5JKK5p1tI=;
        b=Wj10yNPLk2TOSHUEXm1vI7pU7rFCwel58W8FpdZ62Vw3AlTuX5eWedwOk72J733YEN
         piWx5WIq/EHvAOXDWqaXKZQNeJ4E+M1xNKhzYWUdMenu4zm/OOI1hLXMzY/tBkyXf0im
         8shk1meU2zWnHBokg6AtYYURb1plHERkgoshQGaqk9o9Fw7reEDclP09zHxuePxbPtbH
         LodkVNtvmUDhVLOwyQm5sXb/ayNbxzEm/aFVD5qvAkrD6tEiHpacbxblAC+tFMwKAxDo
         eQd+ZBkaFAJT8xzqYr8Sa0ehjACtcVuMslTL5jB1RF6NNGpeCD5wN84EQgHRCrN6JxYc
         6Lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733179923; x=1733784723;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q6M+sJSjUa6xyo0WP/nEC8shcNUn10n3ve5JKK5p1tI=;
        b=ELPLT71sisHftDBe8cRxeKrImRbLkI65FBtFOUWO0iktWXrEldqEm8Qi04q0d9t7bH
         G+asZ4HF0DZ9HjciXuqeIYLWDjkqkxebJktR17Ncsxrc5ThMRERQ6eMKJYgZNsJTN0/x
         wwVU1EIQiWJbx3PWl8aENABk9hbjQRCCYBZ0GM5z3ghLGNgXYwMai/DwICft7v8p1f2b
         kgmSoVJ2o+itwMUw5Kp6xU2rJPq7J9YwgtB8cnwqA/I/8JqRI17BJ1JC2p+m5+iyZVv0
         ow2GOSyMnB9kl/4XLt0DZ20eSvjQX5iPlOpAIHuS+QqZrdw68qb+CwBtbsb/pIW+cdlr
         FKJA==
X-Forwarded-Encrypted: i=1; AJvYcCUdZu1y5Lhi3Cld6pJfYoqe5Hj57EBriKIcEQyHJdzQwqb3wYjtS0JNZ+0Teb3va71s94M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA0eQ15CgmwWV64FK6d4d5XHIE/DSmfjW6hA2/IIVJ6joMPfQZ
	vjvC4RBIwZbWkZwTE8oQ4I975Y23NRSZjtfhidDFDouA+y0CX+xZ
X-Gm-Gg: ASbGncuc3tCGCvriskDJ4z2DA6HIuxXxL3j5iC1cj1W/hknwplbr6vwLRnC/mp3swKU
	SBSlBd2Xoa7KBZdvfKeVqR1NhSQTcr8S9ThuvR672oqbUetJOQNIg+QuEBIqv8Cg34bN7Eo1UKF
	1waKR0tyosWQo1yn2El6TImUUezIcbMJxxjRLnqvPTbXbDDaJwkyQraC7QbdNjj/2dzqw74vPrD
	9OnxhlXaBbySKg0RQBrOdjadv7kaWOZSbuOXgmzkuUZkKo=
X-Google-Smtp-Source: AGHT+IE8DngCOCczmALZNSxkQx+21nH20VsBekCF2kA0qRFlVl8ZToxY25h6zmpKcSHq9m2F8GRZng==
X-Received: by 2002:a17:903:182:b0:20c:6bff:fcb1 with SMTP id d9443c01a7336-215bd45d424mr2246495ad.1.1733179923570;
        Mon, 02 Dec 2024 14:52:03 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219cd615sm82373295ad.269.2024.12.02.14.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 14:52:02 -0800 (PST)
Message-ID: <52b1e568586efa503ae3e691c51a67167a5f054c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Don't mark STACK_INVALID as
 STACK_MISC in mark_stack_slot_misc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Tao Lyu <tao.lyu@epfl.ch>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Mathias
 Payer <mathias.payer@nebelwelt.net>, Meng Xu	 <meng.xu.cs@uwaterloo.ca>,
 Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Date: Mon, 02 Dec 2024 14:51:58 -0800
In-Reply-To: <20241202083814.1888784-2-memxor@gmail.com>
References: <20241202083814.1888784-1-memxor@gmail.com>
	 <20241202083814.1888784-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-02 at 00:38 -0800, Kumar Kartikeya Dwivedi wrote:
> Inside mark_stack_slot_misc, we should not upgrade STACK_INVALID to
> STACK_MISC when allow_ptr_leaks is false, since invalid contents
> shouldn't be read unless the program has the relevant capabilities.
> The relaxation only makes sense when env->allow_ptr_leaks is true.
>=20
> However, such conversion in privileged mode becomes unnecessary, as
> invalid slots can be read without being upgraded to STACK_MISC.
>=20
> Currently, the condition is inverted (i.e. checking for true instead of
> false), simply remove it to restore correct behavior.
>=20
> Fixes: eaf18febd6eb ("bpf: preserve STACK_ZERO slots on partial reg spill=
s")
> Reported-by: Tao Lyu <tao.lyu@epfl.ch>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]



Return-Path: <bpf+bounces-70144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C25FBB1A8F
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 22:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BCE3AE5AC
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 20:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1579A269CE5;
	Wed,  1 Oct 2025 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBMV/U4d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489291DE4E1
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759349089; cv=none; b=dvgyZt6MsWwYsWmN2MGurAVMzWpMDggOk2zZSeH7gme7Rucig8LJG9/yVRjyuJMzhI4WRG7dVqloygyAxNORCMYMVSNqZ5X3gvkCCurHZjfzdSnWO3urGoArNCo3mk3gVBBvTrun7YMw1meqz77bCfwktpnJq2KjD9vzCWuMLLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759349089; c=relaxed/simple;
	bh=OJw0F2GXBvdb3nZ+Eu1t7jgZFX+PuPQguxDxciMWSmQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VkvnbEVZFxtlyjfX5+OAaCJ4bKK9+Bk/tIzQjVhS/e8XJ/gr3+vkELqldhuQL97jJpr/ukXKNLkSEOloeVeLzVNA9tRtj6vuslr1iy7YbTRXqjhm5P2Do+b4VA327AsN+3+I2pBCTcDW3z+nKIXnWhRpo+PrlbfxpTkUyf6F6Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBMV/U4d; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b55197907d1so170119a12.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 13:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759349086; x=1759953886; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OJw0F2GXBvdb3nZ+Eu1t7jgZFX+PuPQguxDxciMWSmQ=;
        b=BBMV/U4dqQpZQPbRmplWNq6vUeCFArxlCpFnACT/xE3nhbpb4nNnGopp12JZ7JJrxr
         IQYeNk5+CDjm4EYrlGKaHSyEqJUAXyRZi8qUjasHIsG0uzKLg5vCtMwpA58QsQqfI5Ku
         oYTI8CcP1e0DLe6Cb8P0Kz0/7Ca9WXUkqnEe6OsI60zaFYCTlDC5nTaQP5WyE/gYXyjT
         GlXwOtiJ9GqjYM2BM5rqbn7sJxyx9jzv9OOrv6R4nvw9tmdZRREDVM857JII6bZ6N1Co
         oLDUjBVPcdp4j/Z+qEJKLKeEu5Z8E7XW2spWmyR3d2QXf9iNOGIaEW4T/JMjiy4XVb9O
         Z77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759349086; x=1759953886;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJw0F2GXBvdb3nZ+Eu1t7jgZFX+PuPQguxDxciMWSmQ=;
        b=YDaoCMRVFAIOP5vYH42eSznxdmX8QMHzzyXnA91KCdQ7Ow2nSO3rEGfnX7xC5A9+Gr
         vi0En+hN42gO1grOxJwy2j12gCwJbAXngL8IRDyyo3xE2nuH9On3nkfxgqrk54uMmCK2
         O59HSHQ2pNcuJz6NV4u/F8KXnDSRl2y7+gOqSr3iDKXOcMRGeauWkJI1guEYYKdvDHSD
         XBI6vjS0gEqsqCMcBzR52R9JCq9y1sCAzVwIwPNGbjXBc+90tLHM3EL6QnhS9XuY7Olg
         FqTsfJfXd4CqzXjpbRR1rbV2PGgilfKI4MCDJH9tadRffdF3nkTFOLQS802ayF1sWF3Z
         WjWA==
X-Forwarded-Encrypted: i=1; AJvYcCUjAFJl3rWKx3WKhRwl7GDXa/0T5RsOGrf5DQDKDLGhUxccpR/DHnlTOo4EABjhtNc6lHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJmrUnlF3r7dccTn8ZEVynPbFtpkfHbkTTeEB7UzUVsKOxMfKx
	+Ho6L+XPaUSAfMKPHvrb2tRFKOgblm3cJyOkcTRSMUEL/yLWZqOmH2V8
X-Gm-Gg: ASbGncvwgkOg/qZu2a/+Ns0+nL+uKGEXRrUv37ULr+x/4Qf1atoNd9T9lt87mx0KIfw
	uVHx5M4D/6JDfIkBeDysIuV7Cd17+Y5nFhPEBE40mIgMDtIISDaTUZW3leJNt+L0/1HlN/nrdZ6
	EsNrYWNBhnS4fOscB1TAlwcFVEEZfAePbitiJLCFS/EBEKbFLl/s8Kjt0/82IW3P9DNLHjogvgS
	1RLM/gVvCCDN5909zkfTkFx1Q3tPX8oDyz6uMb/0NH+M4EOX4oqj1BBhmMaxmncpQmoozjN3D6q
	4AsoFhMiWxDhoHv4SWIuOppukwpk2TTA86qewKmHtcxBG+935SZ9jMgvb5cJ82AC6Pnyuihm5Zi
	lHlXWG/4juWnHvR+2CNxBd2H0yY23o7iXVkGJf5OrgpU1ftladiT1+96OOXukKdXn+CQBKMJ4tK
	ECCshgig==
X-Google-Smtp-Source: AGHT+IH0FTPELNYPvfjIfXqJR7coVby8i+GcWnEv2Ctj6yHk9rlWF3OxVVq8a9L/u4xKSf2dxCpzbw==
X-Received: by 2002:a17:902:c950:b0:270:4aa8:2dcc with SMTP id d9443c01a7336-28e7f299af8mr58565495ad.19.1759349086543;
        Wed, 01 Oct 2025 13:04:46 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d11191bsm4390325ad.11.2025.10.01.13.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 13:04:46 -0700 (PDT)
Message-ID: <baee0d14a9d5bad0f015cde50c140f29b07515d4.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Cleanup unused func args in rqspinlock
 implementation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	memxor@gmail.com, rjsu26@gmail.com
Date: Wed, 01 Oct 2025 13:04:44 -0700
In-Reply-To: <20251001172702.122838-1-sidchintamaneni@gmail.com>
References: <20251001172702.122838-1-sidchintamaneni@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-01 at 17:27 +0000, Siddharth Chintamaneni wrote:
> cleanup unused function args in check_deadlock* functions.
>=20
> Fixes: 31158ad02ddb ("rqspinlock: Add deadlock detection and recovery")
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---

Surprisingly, the parameters are unused indeed (and I don't see
conditional compilation paths that use these parameters).

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


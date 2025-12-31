Return-Path: <bpf+bounces-77637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B11CEC7F5
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 20:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 902403013959
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA20B30ACE6;
	Wed, 31 Dec 2025 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOLc1aic"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6630AAC9
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767209389; cv=none; b=aS7bZXsDVtbdaLCGHdJpM1e0PjhiDflPDxpQjIIbyoTvqIBCx9OcEsCId0v/Up/nsbViQcx7ZVvvaUBpZ5XLOjdAeLxFNVQk6qEGPZz68rxqaHwmKNuxuMJBO97HEPLm1WrbrZkPopHEC9GkSR5cnsC6SaScUm+7M1GSNnnKSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767209389; c=relaxed/simple;
	bh=qb/0SpH2D8zivXXf1JnE0mY+Fj7U0eNDJProjPClRTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uVhke3n/ujYuvziFNIiEIev11DU7QCaPPNjPYEqiQaM/7s+YOgYUwK2cbJpqg6Bx7l/vTKHU4wYjLc93gI7o+TeAnNbpUSSZ82LaRacMi5XVLosUZ+AeArUXJNYMYztzqaiP0r8YrIHjZpPUtGDbv3pGVUVZNVCPmMiCm2EpAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOLc1aic; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso17590499b3a.2
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 11:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767209387; x=1767814187; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qb/0SpH2D8zivXXf1JnE0mY+Fj7U0eNDJProjPClRTk=;
        b=eOLc1aicBTnrAb0swz03Y/SxG85elRuoF5/ermtHh5WBTlAoS0vCJoAiD16rqWq7Fe
         D6WxIt+pQKMnhJ4S+pOBeKTHHYBUakwf5TxdAehQ6KLTL49zi/hhrkyAf19hfPbg9Y6C
         umHR+DIFdFdkyWRf9A+zt/m0k+WR6SrCz2fx1v7ePQeD2i2DQuC5SZF9fdZDNPXTvFsW
         YUlIcqH/9FvMSbnZVWvfwm2tY5C08ClNOTjIk+bPnZMb5VPjxo4ZDrKYEZNx4oFzKQ4w
         ZboEfjimJcn5smd7bKMVEZYW7cAVXycs4Uz1+MzRXeLb0B0lxDWaCMhCYw/G1rKZii52
         2FgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767209387; x=1767814187;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qb/0SpH2D8zivXXf1JnE0mY+Fj7U0eNDJProjPClRTk=;
        b=OIOpYCYPs0vCXsR9+hSfol5b3qMV1oHUJ09JKD+urysUhugQd+sQKl+d2Lm92zpVN3
         /8/irTeqzeMiX7XuRtNsJHcb4OvY7bWPBWis0yAYViuyx/hYatqoOpHOPesNIlEEriSI
         zVSXflhhk2Mi9DX86E8b0KMw0Zfn5aBZAjlvf3r0QrVFCgET5xWFIKCwtUKkET6mx1Eb
         HQO9zq7Wakzi2g5F3pcdfPwMZVg7kGnz/jvyJrTnMU09WB1K/xLaiGwMQUNrwDPgRo1U
         kwPmHE7k0lNFVNOUbNDIkQhxtzTGl++Je9S8OVO1m9tUwAfJyULSjIxRsW/ZyIVEg7dB
         ZuSg==
X-Forwarded-Encrypted: i=1; AJvYcCVetf242GBxDL/GgTH2tLWPhDIV+j35Tg9Yak4YSBga+/boyiCavZ6S1lw8zD5mAvf5LkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJN/nJYGY1AupUtBSe2aSHtJiZmj6vhBCqJOfHezYQlVa2zrNk
	Tk9Zp5Uvg7J4qP4GYBkBtmH2PICLU4zI3g/amPfKxu0XTMl/YB7chW4K
X-Gm-Gg: AY/fxX6FEe1AlLsBS5+fcCip6OsAmju4RyIQtECdHRARUKb2zvi0eFkhH4cHZkSKO32
	yVnhieSb4b0iLA44f6ASNiEQaEDG/5wj5mjdK2IyOeOyiloH1iAetMF2oZvPFM0iC00iqYwIK5g
	a9wpSYXB15w9k9EXtf/zrH4gV/Rs1jllp3glSpWvyeWPGKu/nt2l4XpEUVrk6e4RH4fgOXjCBSI
	hkpBf3hc+liYe97BMyg/T3m3r8b8g6JbJhVVUTLUHYpquQDH/iz0S+7/efGh8EMblGD1zh9reDi
	un/T437JOrC8ZZGCPuS1KkwFknrRojfc53b5agiYE7COV/6/XHUD2Ne9evg+XTpl1+DEJ3gq49G
	8+aHDVXYVouZBHgmLu/N3wxAxpKhwg4lOM6BtPCXPKFIDBSJ/qv/9S2qj9zNNS8Coyv0HwVWcG7
	0neXZa50l0
X-Google-Smtp-Source: AGHT+IHDsdbhzHcjZzT+ErzeDD7upR15SScJ8qqd2yNUBiLziO7Fzd1cj04FmiGkKeLhglPb1+IzJA==
X-Received: by 2002:a05:6a00:6985:b0:7ff:f8dc:5c91 with SMTP id d2e1a72fcca58-7fff8dc604emr23004169b3a.43.1767209387322;
        Wed, 31 Dec 2025 11:29:47 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b423d86sm35843048b3a.26.2025.12.31.11.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 11:29:47 -0800 (PST)
Message-ID: <138667689e511652194fd98ad0e20d71f7738234.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 6/9] selftests: bpf: fix
 test_kfunc_dynptr_param
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, 	kernel-team@meta.com
Date: Wed, 31 Dec 2025 11:29:44 -0800
In-Reply-To: <20251231171118.1174007-7-puranjay@kernel.org>
References: <20251231171118.1174007-1-puranjay@kernel.org>
	 <20251231171118.1174007-7-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-31 at 09:08 -0800, Puranjay Mohan wrote:
> As verifier now assumes that all kfuncs only takes trusted pointer
> arguments, passing 0 (NULL) to a kfunc that doesn't mark the argument as
> __nullable or __opt will be rejected with a failure message of: Possibly
> NULL pointer passed to trusted arg<n>
>=20
> Pass a non-null value to the kfunc to test the expected failure mode.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Unrelated to this patch-set:
what do you think about merging __nullable and __opt?

[...]


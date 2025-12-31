Return-Path: <bpf+bounces-77633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D077CEC7C4
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 20:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 101F63014BCB
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B613093CA;
	Wed, 31 Dec 2025 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKJfyz2W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2561DE4E1
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767208418; cv=none; b=btRwOHTKzYyXtzbwHSBxoRpl0sKK2oGWFvbax9hCyAX1iSulNI72t8aQBFb5pafsiqmiSm9ji9sNL1eqinI6Hgx5ArLVzBZ8PHaDTFrU5j90+b02Udb2Y5rMC4urW4cyoJG8b8JWuAwlKG8UKhFc+csh7iqFa1U0t6t1W0WOTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767208418; c=relaxed/simple;
	bh=4ijHkluiuBtQvaB7xi+uQVoybmzKABF7a9U3z1M54bE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=keaVKyEuxbqSaPfWDax7OUb0bWJXzNTCDGHxMyhVOIe6wuhQlqX0+0V29XSIrMhS6yXiLBUV1Lg7uTuw+rPRveOXkkfksqaNHGSslFQ65D74mEpFOnqWoAxGjkAxga+pxdEDD1N2LijPvTJdFzmJ/FLOlo1+qyh4M9duIphWlFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKJfyz2W; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0fe77d141so121195855ad.1
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 11:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767208416; x=1767813216; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ijHkluiuBtQvaB7xi+uQVoybmzKABF7a9U3z1M54bE=;
        b=XKJfyz2WOtmbIahzp0QXr6dHsHqHEYNkGvSFg/2/XywkhoXob3B/9m19rRZFVZsL+H
         r/yE9afgPi5wNp22C5WXI5Kn8vqDw3rWUgQxnWtuEHOm+2R8Gm1l8Pg3yzJcgxbEwxQZ
         9dwPXmzZU1LrClOmPGTsZQ0sJ1MDZaF8UwUI7mRyfk55T/9EIZJEQXJq6UTlzt0TUb9o
         efsA6+KimypQoOWGhgxpynuvWe2ftEzDOY+1CtkdrNvlysuo4/hRL11bbBU6tESTrzRT
         pDBmGfjob6WHjv45s9ImhNTtkiq2XnPyKSd4mXso7F/zrxiz8IvcmDppfTc+S+bt5U1S
         0TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767208416; x=1767813216;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ijHkluiuBtQvaB7xi+uQVoybmzKABF7a9U3z1M54bE=;
        b=E1q2s2RzgAg1BdM8HQPO54Sz/tDYvLvkaAEb9bNoX6xbIACzDFe3/3XMKpIhOBvmWm
         MCTX65IMmA56yXLJsAYnGR/fWog95qAwgejbNo89Qtrq/ek3UebEGvQNqqfceklg4lgP
         0MZIty9QhRpzs6/EIFga2/Ppcy5Xf4MjUehE9rTvzTEd/UlmrEtxt6P6XHpV955ogmbN
         5u6JhRPW5XSmj7sWvLswvO8AO5aeESAYdVpr8ZMNckJkhxPYfU7uXzaRMRdwjpwjObJG
         qNdobFQRcEq44epV7mnWtslQtAmDuhk0cgURx39RPwYPDEWzofqo8OQLCTbL0DielW15
         5+rQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7NakUmzWFz5vUjBYEtWtBw71APjycxBhx854bpuePEa/JMEJxoJRqopd0WpPxnRlcxOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLrwW3de11aCh5ILjrD6VkyKuTYQAwGwSLvoND/MhKD0lP7LYv
	EdSexoeikj5hjpFdOVCfDzIfegALJOKnNM9x5SJByjo63qYp/eeWDISu
X-Gm-Gg: AY/fxX4l9wdjPAHr0eRPg4N0ebzYcROxFfoa34KTqGMdbUMeHJE3k+uDoAOASKvZzeU
	i9Wwb763mQhoumuIIiJYYYM2WTrZowG+ND346VHw8+MfATXtuw94woR64SuMjSwFvGW3I2L31Dj
	noz+EBc36lsm+zi4H+7gdA77orF14QDwHwKHkNFDWgYXGToWKrB1SPP5BGGO873SqQesLd/nmV4
	bRm1+t9qpp+7wnUcc1XKkhtTI3b82d0mBB3QQOFxXQnsIBiSXOVXiJfLCAK4Gyl3Upkl4RvDZcY
	PL+h+6jP8ALbDF7SIHKJGBb29zwmwL0Aw2VxPR/tIihSgq4VHrjhuLCpF1X5RhQaXsQz7fRSi1u
	ApZOKF9l/1IcdqzcnjS6J+++xKIsTIi/Fw3YFxZPmPNUvX+AFr5cLLTby160UMjzS7n642oM8IO
	D12tiG6T1KtWYK8WxN4Mw=
X-Google-Smtp-Source: AGHT+IGxsiR9HCZGeJ7cGnwNBD8adWtPtim9Vu5gBV2YiWz1Cv0zIcQr9kBVodbp/LLOxz2ZkfuOSQ==
X-Received: by 2002:a17:903:2448:b0:2a0:e80e:b118 with SMTP id d9443c01a7336-2a2f2212781mr399172795ad.7.1767208415945;
        Wed, 31 Dec 2025 11:13:35 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d74bbbsm334621575ad.94.2025.12.31.11.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 11:13:35 -0800 (PST)
Message-ID: <3676de92150dcfc9ce2781f2e0219c59c4862f55.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/9] bpf: Remove redundant KF_TRUSTED_ARGS
 flag from all kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, 	kernel-team@meta.com
Date: Wed, 31 Dec 2025 11:13:33 -0800
In-Reply-To: <20251231171118.1174007-4-puranjay@kernel.org>
References: <20251231171118.1174007-1-puranjay@kernel.org>
	 <20251231171118.1174007-4-puranjay@kernel.org>
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
> Now that KF_TRUSTED_ARGS is the default for all kfuncs, remove the
> explicit KF_TRUSTED_ARGS flag from all kfunc definitions and remove the
> flag itself.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


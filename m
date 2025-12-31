Return-Path: <bpf+bounces-77643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1149ACEC81C
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 20:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC8F33015163
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890E030C374;
	Wed, 31 Dec 2025 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgwfYjW5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F8C30BF59
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767210545; cv=none; b=Ra54Jr5EMTWhUsxZiYFISbJaM0406r0JRUOe0mpOB/p1XwsPnHQqkon0ItEjNUMsvl2Gybc4fMRJ3sxZWZ3njVg8YBMWLcKwmj2aE1FD4i7zc6b2fSbSJbp8ptLdZugUcRlT/SG9n6XrCYhWjlSARC4aGUr9DehDZsZhi7F6SyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767210545; c=relaxed/simple;
	bh=Ka0k7GZ81aoy1xl5hSm7Vg7OiX6hCW+WNwH2YSdPbxQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ftTsUgHj2qMaoRp2ZuDov/glLQBReQVBmeQFX+VcGXs40dAu3bJHMJZ963lppQDGtGkh9f8Av503hDJcp69BRzs/QnhgF4vtQuPxNsTIXjr/5jP07qFoK/PTLDuCaJvBKC/ETzo4Xwd3Kafd4LJiU/KAN7eJplLm1AephZ5qZ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgwfYjW5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c27d14559so8671752a91.2
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 11:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767210543; x=1767815343; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ka0k7GZ81aoy1xl5hSm7Vg7OiX6hCW+WNwH2YSdPbxQ=;
        b=lgwfYjW5990goV+4kDD2nPmq6HJmCZAAgVvb7znuITyuxYamVBJf+KBlcbB0FCeMSd
         imOleS7u4eThqIE5ahIJEca1/XAJ+otUdwE56vBrsn5N9ajYFXzQKVegIW/Vcmd5UfEt
         gOsu1tC4NYM8eiU46ivGVCBJacCY9hHKCb/AcbjFA4uy/aAw5zXjzEqhy7e9eltHEoEc
         YUTGg3SsgUZYSw1hk4KrgSqfmGW0UWJSJ4zvyQAdmIeaSfJWZge0pjr6ExbQjUkasqoI
         Byn0tCBjRkm8wc5RyCogvlmYg5+H8B+7dWbq8qvdzytXmvKUUR2QHThGEsu4ClcOR91W
         QEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767210543; x=1767815343;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka0k7GZ81aoy1xl5hSm7Vg7OiX6hCW+WNwH2YSdPbxQ=;
        b=nvAKd8mVFFCHi/6tITJt+FHaL2m6oS+hJZ+pI8SpaGxITd3F+OrW4yC8B+5hD3AxsK
         vcgg7uoUkFA5jE+exqMKwc11TzkPpHlEpkkcvRHtwptxKMASChlbeNPPTJLujJfyeK04
         UCLqF03IkPaeJ4jidr7unqz/Xkp/gOasBs6B4yndX4szTzfsdV0vMu4YTT04fEzWA0A/
         nP/g5I5BMIFmWWTXpsGlQcnuygTYYoZqeLhAGb4ioRgF2PneHdOdJBv9aehkq4+HZDch
         ZG7M6OcQCMo4J9240LRu/X6QV3a33FazFCbXn1SNSkcE0VV4VRczDtkrOsti1BQdHDin
         e4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEmOTVes2k3PnAXsVTVf2xBTBS//NSyPz5nnMr3C4smbxpSFGqeFTQXKM5Mr1eZS8Fo78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/+gkG5tMcmqhK09anCxQBcGw/+qk5DEMLuyW3HJfrfCuzJWR
	9l+ItK4QCcH49sxhbsgEoVKMCsr6WWTRRAjVsI5TbIPdQV2/pi0TkpA6
X-Gm-Gg: AY/fxX6v3Hb8Ing9cnqPssJq+7/6jpjH1DyfAbuY2apU3jYjQ0JKO9w3tH79Tinpa+n
	snLmtLBGAfZCH4jQlBuWXNkqj4B0ufeJIFa2PgvbXBCP+JpJ8uQbbEyTeML8JTQ3H0y1AFW026b
	+RVopWzvYwcjlJO8M2JWCEqAKgEUwufq0gNVwBvCsZ1n55oqGG/Ya3Um5GHzPRm7yqnty+rD4/d
	JijkVF19deHO6YtPX+6osT0v41jJrEUQUqlD5G0+ueSU7XJKC2jAm1uPDriiAhFe9yupxnZiM5H
	pwxcRNwnRO+REvWI7XoUceJE0nZImBV4OGDIfev8ch6QTYOkPoXN+qm50r8XTGvuQk5FnQJ3KCv
	vnllGbZyrRu0IvIpUWqlh7yrDgr+l5hSYloKNVouFekYAt4O1tffOdd8cKzjWRKqcwCXTRIoWGw
	A9QmgnOPos
X-Google-Smtp-Source: AGHT+IEs6PHfCN1Juk6ZjhxVv4z35qFr+3UTypz92o37GQbpN05Xp3cJ3JQA/7XO4RuB0lAyKfjOYg==
X-Received: by 2002:a17:90b:37c3:b0:340:be4d:a718 with SMTP id 98e67ed59e1d1-34e92113213mr28576037a91.7.1767210543096;
        Wed, 31 Dec 2025 11:49:03 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e920c9a7csm33244389a91.0.2025.12.31.11.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 11:49:02 -0800 (PST)
Message-ID: <bab7a5c1d603839c109ed715503f108d1c2d164b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 8/9] bpf: xfrm: drop dead NULL check in
 bpf_xdp_get_xfrm_state()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, 	kernel-team@meta.com
Date: Wed, 31 Dec 2025 11:48:59 -0800
In-Reply-To: <20251231171118.1174007-9-puranjay@kernel.org>
References: <20251231171118.1174007-1-puranjay@kernel.org>
	 <20251231171118.1174007-9-puranjay@kernel.org>
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
> As KF_TRUSTED_ARGS is now considered the default for all kfuncs, the
> opts parameter in bpf_xdp_get_xfrm_state() can never be NULL. Verifier
> will detect this at load time and will not allow passing NULL to this
> function. This matches the documentation above the kfunc that says this
> parameter (opts) Cannot be NULL.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


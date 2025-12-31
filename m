Return-Path: <bpf+bounces-77639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C3ACEC810
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 20:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AB993009C11
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FAD30BF4F;
	Wed, 31 Dec 2025 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWTeigdm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5119C309DA1
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767210035; cv=none; b=qzNXpksO5NcXc89PFW1jCvTKCeP0YuFD483ssuDQv1VPVjv85whUK4G5vBSumr8Bblm5O67IL1jd8W1LdQMZXdo5YkM94WmdcePumownV7auYXIGhoWlrPqlgH8ultxxfJ18idk4CcuWWWWoEQuc81ussmdJ3+j2XpEpVYuQgN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767210035; c=relaxed/simple;
	bh=+C+Pr8OshEy+pltqwwbz/RogJNZ9Ns7GSSY1A2DH0TA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=phdTE49q4DuWzEh6GYU0cfIGym1g/uwHU8RW5sRzJKnEuA/J18Kd0LqTxEaobjeVwvyABQ2Ph3qbmSpUxgtJSfJ/iFdQEirqioELSBjXRrR48nLrnuJegHSFralFs4VkLeG56wzrZ209bqFR1qPhlpNxbHra3cR0KX/2m2epogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWTeigdm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a1388cdac3so102300455ad.0
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 11:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767210033; x=1767814833; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+C+Pr8OshEy+pltqwwbz/RogJNZ9Ns7GSSY1A2DH0TA=;
        b=OWTeigdmnfVhshViF8bkX+mACtgr/OyUr6v3B2+mBYFaPrqCxpHJYep38uvIFGWGLS
         XcB2Qv6/wCjwemGS+RhunKw+lSkmYRLWi1Z6K1IyDtCWVF8aGajDSnJOxtYfpvGOrYt9
         BawV0aAtWUTUQBM8M8HBm8YKyKxx5MbxOh2P9D/5dWlUoKKpxd42k9lBvH+OBv+vZfJF
         EGXOmaDvutSDRS3E0i0/QWNR0Aw9AITTC9uGGwwMN/IsY9Ea7Xs75sl0cCubzjfzN+FN
         7J7N4UXliydMedFOmp5zsm3ZastbDs4iBj1YC+WFmCrLdkX1z+0y4Ph5tDwXKRAm/n/9
         +U+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767210033; x=1767814833;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+C+Pr8OshEy+pltqwwbz/RogJNZ9Ns7GSSY1A2DH0TA=;
        b=Cye0yV7gQjdUGiszb8Bmi0QDuuyx93pQNCFEAD85EpCQO57XHVZ3Hb0gknYLJ74l/W
         UXfJc2ope+L2mnEVFcLu55q5x06T7Cvm4UgebZcUE8ilnUjxSGquB6dWJgzfGLidcM/3
         45QSvjLZ3bWa3cgSOaKDsF/E5SliTCq4u9VZpI3KYliWBd45nbIiiW0PyTFuwcOqP3LC
         gix46iagGDC1emrhS499PR9FcpI1lIXFdbEwVUu8rKYPOPPnP0kmtyq5W6o/xkCDDC0Q
         SlW2sWDOJkauYI0fr5PYfiKAYdwIhTyBDfov9Jz4dcAFgbNzBQ8lpoHWMhk4/wbB/XM4
         BrAg==
X-Forwarded-Encrypted: i=1; AJvYcCV5d9zmoA1ZRcyd7Q9Vyh8fLoeAy0kxXLYhiqbCrZ24/00sFguElzcy9FIsyhdbb7ng2Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuBQGtIxPRKmJ9gbWdBW1VwBv/AK5TaW0WCu0UtuPquaQ0TsPz
	gSPDCCkd2li88FC4wYaQQp9Mp75W8AHx6nmu1uiRhr7NmQySb86Dxreu
X-Gm-Gg: AY/fxX4RBCojp0+gktOEjy+jPSP+PqfsqDGWuGxEmF51SxlpLoYR3gjK/xJL2xpN81m
	tmyjjP7cDkVEfRrQtHGAns4wHfpxtlTd5WirX++jQTaj7FpqvlgkqJS7JJz2OVXUT/HKcskvksv
	B1ZTPa9xhvtO8im2ekCWGxiSv63gfx0s0EWdhqcfPudYZ2qrZndTiFdVJMSLdovnCrMzeqtPwPd
	zGHhwxsO4VExUF95InrOdA0dUg63eFMq2+TDAZclVvfh5l9pxkIbYwK/mlhjbU7wcf3ersjl4FO
	ilC3+71R3RjfE46afKgXYGTWjm2ieEyAzEF+AR6c8sTxp77J8ykCXDir9sIemPYV+4e94che9aq
	bbeOSeAifEDqBFyeaO2swGh+8ld1FYajbGgq9e4CQRPhEiSc2ImlO5HldreRc/KKT7nmedNO9wH
	LlUFaWZScY
X-Google-Smtp-Source: AGHT+IEp4COmJJjFmdw+7EE8O+FJoRNFYlgL8NRIzQu9hinsu9k6pRfP/zWDhUj82LxJvncphFPwkg==
X-Received: by 2002:a17:902:fc4f:b0:2a0:d59e:ff67 with SMTP id d9443c01a7336-2a2f2a355e3mr400812695ad.38.1767210033558;
        Wed, 31 Dec 2025 11:40:33 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4d895sm336167115ad.54.2025.12.31.11.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 11:40:33 -0800 (PST)
Message-ID: <3ad5a5495abcab4a39fd370af67ab29dd0355af7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 7/9] selftests: bpf: fix
 cgroup_hierarchical_stats
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, 	kernel-team@meta.com
Date: Wed, 31 Dec 2025 11:40:30 -0800
In-Reply-To: <20251231171118.1174007-8-puranjay@kernel.org>
References: <20251231171118.1174007-1-puranjay@kernel.org>
	 <20251231171118.1174007-8-puranjay@kernel.org>
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
> The cgroup_hierarchical_stats selftests uses an fentry program attached
> to cgroup_attach_task and then passes the received &dst_cgrp->self to
> the css_rstat_updated() kfunc. The verifier now assumes that all kfuncs
> only takes trusted pointer arguments, and pointers received by fentry
> are not marked trustes by default.
>=20
> Use a tp_btf program in place for fentry for this test, pointers
> received by tp_btf programs are marked trusted by the verifier.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Looking at the cgroup_attach_task() source code, the trace point is
executed before function exit and only if attachment is successful.
Which differs from 'fentry/' attachment.
However, prog_tests/cgroup_hierarchical_stats.c:attach_processes()
errors out and terminates the test, if attachment fails.
So this change should be fine.

[...]


Return-Path: <bpf+bounces-60744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCE2ADB95A
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 21:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3393B6B82
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 19:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CA928982A;
	Mon, 16 Jun 2025 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwfE4MpV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5153208;
	Mon, 16 Jun 2025 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101140; cv=none; b=oxAQzf/NS6h3PHSXSpfsYVuY1tnwaFh9p4xcVksq3md00sp9emd/97cEHXogkqzEFFMH5ONXEgkVH1GYfrCF0m07uzixTV/2CG+aFrwrRX5+/20CSne/nRzeZyWsZqZk4+1ME/PdlLhvKpLDfPpbW5M3DpAd4xp8T/+osHJRKpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101140; c=relaxed/simple;
	bh=TmiBOGB9WJPk09Gtr12N6wA5rUl/LqW+HBksPj41ibE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BFD4M64mFUjea2erMiBhfzxN+E0sTl6tOhEfl8zdT38Vns290WikA9QkHDh3+JoDCAA6ZXzwMxgyz4hK/tZqFDwHRLGS00HGwdyJIsIUy6C30SgED52tUeLNkRa1/HnzAo9yyy7Q0snItnX09kkvfYIfBq9LfUx2YFJ9rI2kzDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwfE4MpV; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fabb948e5aso52524366d6.1;
        Mon, 16 Jun 2025 12:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750101138; x=1750705938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmiBOGB9WJPk09Gtr12N6wA5rUl/LqW+HBksPj41ibE=;
        b=bwfE4MpVJ7qPzJrLOP4G1yKwT2PDhHvxrR0CIL6GgeRsaTlcL5Ef1X47N/K0QKACWx
         Qn40pGDUR/uze2YpQX6jk5aNbVgvc7D42+Bv2uwh+as6Vdd3bwI+jKu7KMYdBfCTP8Hq
         0ojrRsn7rUyEa183srPRcaDe8c9xETDWsBVGbqVljdSwNWA7fL1jIdyvDmoM2ajaIfS6
         UHsb0L0fUSjLbTo4oZvY/w1VfqHvNikes2IqP4nfsdLU0TqlnYRRZhSzA0gnX1jLpu2e
         3jMd+RxWE5nXqouvgonEt46OqlXrtv3wDKb9SLOGSWYPQgPt5naPB/oCtRBYkHYgLOyB
         ZxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750101138; x=1750705938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmiBOGB9WJPk09Gtr12N6wA5rUl/LqW+HBksPj41ibE=;
        b=BeSVrEp6tWvbzAZDwNtfjzG/690ZhHGgMeAPMA56NwO4CU04NxXFmczL8F4rA2lmyp
         qE0TsxcRVVUPMqzRkZOm6D5ZP1q9t8UC7My5p9vS7dfSI8t3v4U3Wvt1B/7T56syfW8Q
         HrcbKV0PmJJ/JNXa5hqfeSVKF0xtXrmrDMTAXSAO6fcsbEZWJya3VwP6mnOHUpwd8eSx
         Qw/Ih3bol4xUC9IWhx0nEo+LLrc/XbTwlEvdEdE6IG5CdUdn5HlJZkKSsACLOw/zLisU
         3w0E/G0YSR3LlDnPa/SximTtqgs2/zzedIz7lRuANy95N/+Zj1ZbOhf2Nc7QHSvx+fGl
         EOXA==
X-Forwarded-Encrypted: i=1; AJvYcCUCaCoDr/bkoWmnVYAfU+h2vF8G6aIKx7f3Ayb0fjKx1LtS+PL2Ew7TIq2cIEChrtmcqTwoWQztC6T8gTs=@vger.kernel.org, AJvYcCXNw0JC1Tu6Hr3iAt5Q8eT+72ifAJMHTowTMAi4SZKnWUpe3sr9gOD3Up15gsCpw4M+Za9n/OZY@vger.kernel.org
X-Gm-Message-State: AOJu0YwvMGbieHe3LCrtT/m74sErOMTfGMdh7ZbmWtPaAa8qPRNdV6of
	RQQzLdvqCHcQjjmVGQ5eb8duX4t2R2hHerPFqVOFJcXPSYQotDcN8JLR
X-Gm-Gg: ASbGncu6dEsuB0CtNf0oK6hbObMkZq1jA3qLNIPzQkcZ7maf3Zj10qR7XvNG1g4s57E
	oeRB2+6sIFBX+ARBa+6qZLWl6f1JCt9Zd9uJ+4vm+nk+cg3vF7u8DKSRBmER/yg/udcfeiAgDum
	/fZstqmiM+PZyO6m4xjCuzY6ZyFQx6XL1869S6F7vlUUCKOGxYQfyxFRDCBQKGDR9mzW7ZTLYzN
	23yeIjHgD6PKYc2DaYXlcq+uy2uL7biMHLV03bvLQnBH/RkNlpjzk0N2teevNLe262Dr9+z5eIe
	ru2Ci2YRYRbD/uqvpI13eyfmYJ+96xdiMz0Fe3Viy1qw4q6P0dLpAsFU6OL9evtxPVOSJ4VUsBn
	0bcmxS3Ls4YnVd9OF+AysSjGKlTgfHaLdVrWP6d7Bcg==
X-Google-Smtp-Source: AGHT+IEAYwwClB30T0oftCcaMqxfxEhEAICWJRaAromfaRxoULiVpzdPgJj+ZQ9n+/tJCNnixQas7g==
X-Received: by 2002:a05:6214:dc2:b0:6fa:cc39:67 with SMTP id 6a1803df08f44-6fb47759253mr197221056d6.22.1750101137821;
        Mon, 16 Jun 2025 12:12:17 -0700 (PDT)
Received: from localhost.localdomain (syn-184-074-055-142.biz.spectrum.com. [184.74.55.142])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6fb527a3efdsm18583566d6.44.2025.06.16.12.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 12:12:17 -0700 (PDT)
From: Robert Cross <quantumcross@gmail.com>
To: andrew@lunn.ch
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	pabeni@redhat.com,
	quantumcross@gmail.com
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: fix external smi for mv88e6176
Date: Mon, 16 Jun 2025 15:12:14 -0400
Message-Id: <20250616191214.2295467-1-quantumcross@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <ad17b701-f260-473f-b96f-0668ce052e75@lunn.ch>
References: <ad17b701-f260-473f-b96f-0668ce052e75@lunn.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The MV88E6390_G2_SMI_PHY_CMD_FUNC_EXTERNAL bit is reserved on the 6352
> family.

Indeed it is...

> You are not understanding what i'm saying. This family has a single
> MDIO bus controller. That controller is used by both the internal PHY
> devices, plus there are two pins on the chip for external PHYs.
>
> All the PHYs will appear on that one MDIO bus controller.

So you're saying that if I removed my hack that apparently just sets
this reserved bit, and I take my PHY on port 6 and remove it from
the mdio_ext { compatible = "marvell,mv88e6xxx-mdio-external"; } entry
and put it in my mdio { } node it will direct requests to address 6 to
the external phy via the MDC/MDIO_PHY pins just fine?

I'm guessing it will just automatically enable or disable the external
SMI pins depending on the state of port 5 which shares pins?

I'm also guessing that ports 0, 1, 2, 3, and 4 will map to the
internal PHYs (because there are 5) and then ports 5 and 6
automagically externally...

I shudder to think how by what forbidden voodoo my current device
tree actually works with this hack...

Thank you so much for your explanation. Hopefully I'll have a
real substantive patch in the future :)


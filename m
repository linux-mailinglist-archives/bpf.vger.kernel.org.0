Return-Path: <bpf+bounces-65568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E08B25630
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 00:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6AB884D9B
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADECB2BE7CF;
	Wed, 13 Aug 2025 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH9kWXfo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7BE3009DA;
	Wed, 13 Aug 2025 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122481; cv=none; b=fbhRPkPML65mOR727ObtvEOkTsfSnWpv6/BCXZe45BErfi2kpTyqUyhdw0BuNvSYlNI0/hCBx0a7QjURhu7+PrgSKYR8FNcCW6YXcNDZJ3gLlfU7GLhhBxP3ieYaaBlSQSH4UH96109y3azS48MyHWW8mDlhoWBwlbYCF/+H5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122481; c=relaxed/simple;
	bh=+RNVBYUT3Cy6QyeBFCfulw4vXP9Ozm/iZjOTfAKC7sc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IkvkjJfUg3zYaWhUp9KOQhP4+ypRZ1jf71wv/WPKEmc0dLr1ZJl4AaHwQzkROWsbeQv7fFAY/Zw4nS7qtFewgUmmUMr1m2VdSH40UTVECrAPJ96ISjzBZf5sbOcCH0sqKSufcTfs80wXHDyR9eLHCUc2Ufx3O1Esr9AAtx6zi0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH9kWXfo; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b47174c8e45so188396a12.2;
        Wed, 13 Aug 2025 15:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755122479; x=1755727279; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uM79KnE/bLlDkUDrlsdZqeLfTggcc3bAP9tn1uE+/64=;
        b=mH9kWXfos0ujvexZu4zrOWoaRb1QJR8YrXl5j5UzmVZSsNADSdnYGQJnxuv/c6oKVm
         aN1DS4Dr0l3qPWxQbRpGPKwH+j9iBHqh9y+8tUtmp9JitGqj0J525oZW9qsj0D8wf+Vq
         6MEQ8v0ipK2C0QRoFbhrfgnnvCyDiKz7yc5yTT8SrrDsDwqN8r4s9eag53LPh7HpC2br
         hwJ9FVunBVRq1AzhVXBNh1QY36E5YrROgzC5UBEF4e54sdRx66jIk22IrERDL6KiJWk0
         j9LsM1HAXe1dZip4fgqRvqXdWPXuEKPHswkgLr1v8N+8xjvI9CBIGt8XcrxuF/9mo+Sh
         VSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755122479; x=1755727279;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uM79KnE/bLlDkUDrlsdZqeLfTggcc3bAP9tn1uE+/64=;
        b=OOmYaNzn46Y7KA2RbMLPfLPX9xA7S3ExCvxnSTYe4HI8jZtLwhHKcqdJNos8V5ybXo
         EUdwkPOU03Qxtq6a+lSDvxF8dq7Gwv9pjfwEE4AR5jhFhWXbO2phlYt1gwuDRNHdx2JJ
         Sgy7n+KInR8GPyOO/1av4iKS/1c7iwxLi9ck8Om4FuT2XZ4PE22E6Zq5Im+7Fb9XNZ+b
         6CG13b7gM9fGeVbPRl4Lbp5rF761Odd+DUpibIvlT6Q5jv7FG78YVGZKREGcgUQ1QBDw
         pjW/gAUEcXSFObyhKndB2jyYubMLhyW4XVSv8rDmHwu0sO5k9FjNrEyoza+ghaBVfb5d
         ESHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTTs3lJyCo5UntiR/EyPtV+lu2Tggjeq+vsyTBRS2l8/ZCTxGxx0tbo7ZbYrC4NFuJfhEPtyn1XwtRvxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFev64aMDGaic5+uRtDOV3tksXQh3NKIZ6D6faum6zADS3U+kB
	M8MhyVTGuqF1mSj0HtnxFF3vaDOwZXyP7LuFcwGo6gG4eqcP7xpqQIpi
X-Gm-Gg: ASbGncu9+W1NRwA+kHPCvRq1Cogyx5IHDYPKgSJ3xOF/WofUVBqDZHzQsMulD5WxSYO
	ieRCFfsM4nXNQFSxR+svEGuG2SgArt/66lIIGFfOkdNaOjzwyLNw2SZIG9aVm8lu46PG28cdgaq
	r/oIe5EJDtOtbt4A8MF298z0XrIKRBisZ5bh+nj4EdCnfXXStoZMuTWq3gGw72tU2sv9TRO79aw
	JYdtGFGtDInMgFAVHwwts1PUJ6kMCu8v1i2AIaKJ1Z0V591PP1SD6J1L+ccjYa05RlDZIxJYQVF
	S8evvp/5Bv8kR2i2LGl3h1TwLhD0WEXCUlqIp0Mugtfec3REP4LmnZRlRZfOF/7qpV5gmZTvShf
	TjhXpnmtULOREWsvuKXfA+HAKguhB
X-Google-Smtp-Source: AGHT+IEuTjXPVp70dp1VEM27uMWxv+nCwSG51OsCmscT+tYMjoUHnFNuJ9itF6sNr6c770ywFQ511g==
X-Received: by 2002:a17:902:d2c1:b0:240:a430:91d with SMTP id d9443c01a7336-244584ed485mr9015785ad.10.1755122478775;
        Wed, 13 Aug 2025 15:01:18 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::e47? ([2620:10d:c090:600::1:f146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef66efsm333569565ad.32.2025.08.13.15.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:01:18 -0700 (PDT)
Message-ID: <32575e7b7d714aad8d79f851ad00b8241c8ce277.camel@gmail.com>
Subject: Re: [PATCH v2 0/2] bpf: fix reuse of DEVMAP
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yureka Lilian <yuka@yuka.dev>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 Aug 2025 15:01:16 -0700
In-Reply-To: <20250813200912.3523279-1-yuka@yuka.dev>
References: <20250813200912.3523279-1-yuka@yuka.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-13 at 22:09 +0200, Yureka Lilian wrote:
> This patch series includes the previous fix to libbpf for re-using DEVMAP
> maps, but modifies it to preserve compatibility with older kernels, thank=
s
> to the feedback given by Martin KaFai Lau.
>=20
> Additionally adds a basic selftest covering the re-use of DEVMAP maps, as
> requested by Eduard Zingerman.

Nit: could you please use tag `libbpf` instead of `bpf`?

>=20
> Yureka Lilian (2):
>   bpf: fix reuse of DEVMAP
>   bpf: add test for DEVMAP reuse
>=20
>  tools/lib/bpf/libbpf.c                        | 14 +++-
>  .../bpf/prog_tests/pinning_devmap_reuse.c     | 68 +++++++++++++++++++
>  .../selftests/bpf/progs/test_pinning_devmap.c | 20 ++++++
>  3 files changed, 101 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_devmap=
_reuse.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_pinning_devmap=
.c


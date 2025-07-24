Return-Path: <bpf+bounces-64266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D5FB10BCD
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 15:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BB7170AF6
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 13:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF31B2D9EC5;
	Thu, 24 Jul 2025 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4RVA5q+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A554A256C61
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364700; cv=none; b=cUhFNgJjyS9MhTe4bIF3QpJP9ZsFbT1ayTcYYi97jnuoAtck5hAIg9B9jHQpfs+rajeQp0q3GJi0wKFMQwtePpxoFQcn2IvXO9Fg3fyXB3sDNKUbGsQpk6bh+/7+NVO8WyzD4bSXWpPGJ3bmAyiFnvylUTKBPj7uGkueDQXi/dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364700; c=relaxed/simple;
	bh=OEw7mi5eq/LuOOK1i9iYt77cRFmYDG6YwGUeTC9YK0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9oPtrBFUCfAUfngjS32lh4qGDWTMLMeeOZQidQoWb+Km17FvHBudGOdBaUITjIFwGIQ6i65PgsOMZna3D6Dp906dIirO5jxZMwdNOqAyzNddkpEmkIv+WE4qYVJfarVON4zC99GFszxJWO896j/iK49zhX/ZXBzJOQHY5ofhKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4RVA5q+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ab112dea41so591294f8f.1
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 06:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753364697; x=1753969497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KREhYxOitx97HGZj32SqoFx4vscJTdQ63UQMMm1OgOw=;
        b=f4RVA5q+sg8qRCoq66W0bn87C+ejtwL9d/yd8zpT9hXzumE1IuYts9z3u6ZlxsIaJZ
         bqir2r+6qfFU36AuNlt8EiA+mD6j8vT51mnsi/kChRxcWaojWCAl+3nT4Qqz/+lHF+EX
         qfYATdGytY/8MKm/Jv4EB058HNeVqjkPRRyHeM5UCCOlAfiOKbjJ8ZmH4sL7l74OXSMO
         NulA2bUIYFKPw5/NMOJxxQrAS/JsloHLOxYre8zjgZQiJE6eEQAbwb3JpBuoGcJTWnyJ
         Gun12Stx2aAzX9AKLgGd24MpAHBAPKcMORCJv44kVxmfaDXHp9hbW6X/23LLduCtCbqy
         uwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753364697; x=1753969497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KREhYxOitx97HGZj32SqoFx4vscJTdQ63UQMMm1OgOw=;
        b=X52yoaovlX0I55Rf8zd/ZNeX8WD1asRuXqLWyoxSplUVQPdXGpUpnts0EpWhptcdGs
         n1V1hHZynr7+Uqx0gmficXwJ0WNT2fSG52CKO4Tmu6CITIpLcZHglOZ59szJ4ugwG/x4
         f/pbQBr+AzpY43b39V8+gmFNDlHAsteYWugW3rL/kfEPWh4/eRBT4O+A3mTKXUhSzf//
         f/jWtWQ+Ke6Gx/ek10bBqDdH4ud2RXWFc1R+adE49G1J8lT01dpUbyWrnHG25v1LcYnC
         85E+poGAMOwVO5NGlvrh6lXL4evpdjdWeOVE4gAFHAVB5fox75FxA8L8G/v/ZVVeqsV7
         taZA==
X-Gm-Message-State: AOJu0YziEuqqzekdG2cbOixEkIpO+vBFwm60O+DY76O5M2cpUn3iG8pG
	VS+0ZegPmxPCdMfXJcswqjLbTKWzYlBh21FQzr8puqm38+ADzTrwjXkNurcShOBF
X-Gm-Gg: ASbGncs7oUSV/YEUUMXH2XeSGp4WzzaTNbVS7ehcHvRivzxQdVe+Egt5Nx84J6P6hIj
	5PWgdTMAt8vOT5LAbMDxC6CdOS9RnH/a0uODjYk2rtK5J8qwdVDkAyNcojo1m02Yx8sNL8uFpQU
	DhSQl1RPgGod0bDYCBM6a019sJ4lVEplWBwBbdHejS4hGc98KGsCfdBJ1JRRf/f0d96+KfgKuz6
	QnCz8EDyv8IO/Iue3k9Q415ZTbAGVbhTPGldzN9DuD2oc6ep6ChUjd2byjeW5VLrCdvcQpdJp97
	0F/VY28ny3tc2/n9QH5dP4d+Z7dHFo/N9Mhf/o6U20+CLREoi/lTjGQFqlhMr0KwYfNRsc2rsK6
	mPuYToG+AW49obL+Z5PIeFOCi4DfX1uElYQfgZtWgE34Awoy0ekeOTBBbvphwargJ+AlVT80kra
	GRTC827SSx0KOaCAkACe14
X-Google-Smtp-Source: AGHT+IFMcU3PVF0pMbfhbH90egpy4Uk4EsXarI1/8GsOzuFOKCwAqEFlyeHfUi56/LR0ssnws2bh7A==
X-Received: by 2002:a05:6000:2087:b0:3a5:8a68:b815 with SMTP id ffacd0b85a97d-3b768f07996mr6509309f8f.46.1753364696756;
        Thu, 24 Jul 2025 06:44:56 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00667e58c39c19dc02.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:667e:58c3:9c19:dc02])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b7737ce62asm467454f8f.63.2025.07.24.06.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:44:56 -0700 (PDT)
Date: Thu, 24 Jul 2025 15:44:54 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Test invariants on JSLT
 crossing sign
Message-ID: <c1c843a647300feb510920c13d2d4d2003c56e0d.1753364265.git.paul.chaignon@gmail.com>
References: <cover.1753364265.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753364265.git.paul.chaignon@gmail.com>

The improvement of the u64/s64 range refinement fixed the invariant
violation that was happening on this test for BPF_JSLT when crossing the
sign boundary.

After this patch, we have one test remaining with a known invariant
violation. It's the same test as fixed here but for 32 bits ranges.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_bounds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index dd4e3e9f41d3..85e488b27756 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1066,7 +1066,7 @@ l0_%=:	r0 = 0;						\
 SEC("xdp")
 __description("bound check with JMP_JSLT for crossing 64-bit signed boundary")
 __success __retval(0)
-__flag(!BPF_F_TEST_REG_INVARIANTS) /* known invariants violation */
+__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void crossing_64_bit_signed_boundary_2(void)
 {
 	asm volatile ("					\
-- 
2.43.0



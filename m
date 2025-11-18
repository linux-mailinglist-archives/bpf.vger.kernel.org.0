Return-Path: <bpf+bounces-74920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B970C68041
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 08:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id DB7512A740
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 07:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227DC306491;
	Tue, 18 Nov 2025 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xxzC7TaB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D49305E2E
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451467; cv=none; b=c+A7893EZ3zyNM9VoHB/Y9P0AASeBGcwK8n6VU6fDtAYgA9Zbp71q1vy1/vjQRtrcyxq9axARJRQmVIuFeU5aDbv911F1FLrJBDvGHGeE91Nz84K37vH4FX7v8yB6erHJbH3JH1Q1P4HOIdTuEV1+p8jA8lioxBOqLe4EDc+0eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451467; c=relaxed/simple;
	bh=XxaPZ5TsJou+sUJHcpnw7uSgLwltBMKydeMLx9XylJ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sf1v9AT3GCBLLAC25kNdYGX9Wqdp8ngUs3P67diQ2fb6gu9EwrFh2FAa/qgIiPoAvffrBUPnQmkBtlz9RpgxOQ33WJaAPuFgiS4RA/+ELDSVTrD0EOOz4NdZBbkfmF703b9Dhl+Kt7Gc+4tDUHh0y6chAg8G8KXfH0HPC/DDIVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xxzC7TaB; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6407bd092b6so8431877a12.1
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 23:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763451464; x=1764056264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sKPv+eaKOdXoMPQ/TX2IhQ+KDTwgcoP3pPtyOGlfipU=;
        b=xxzC7TaBCQAuEqD/o/roRw78mjDItaZzEU9hIV16JY097+qOeePIKtNOWRw8sNvQse
         cMaE6Ngj2FiXjJBTyM1maGFWN/iSi0k/BJNVn8f8lUI0q95IwlaSTmkqe8jkSHwoajnC
         3tx3gvWweJwfydeZax0rz9U2LCwlAwYOTvoyeA8/zezFGh07IZceHf8Ir3DzqL5UdhNp
         r0k7eBUFajlpXgIqv4V3PoW1pNhQeX1Cb/21yxA4uAm+qMm6i7zdI9IfyXM4eIFCmfHa
         mhe9gmXF5JdmvrthkHE7fOmT4BQzpbyZkHyfDDyxN1vEzCSoaBLjrRFcuE6tSMV+sxLh
         U/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763451464; x=1764056264;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKPv+eaKOdXoMPQ/TX2IhQ+KDTwgcoP3pPtyOGlfipU=;
        b=GGpgT3FTJMZWLxEWkneF5SbvtSetd1jjF6+xaqig466V3oKLpb69pQJGuNVekjSIi6
         9QwJD8tZDH/1BmwM285vQxVOEvWBNe9nY8beE21f7TPxCsOdduqR3oBShqcK2OShGo+x
         ckD/6/0kHzlJp84Hvx+JnAp41hlhfY5Krl7i782LrrlmEJNxNxaJvzwv8+wkQQT3WhOI
         yMV09VisIrId5JC3iIDkBQ3TbnfDN7LexzgDfD9MWzgKl1QpyqYk0Z0eYNaXZq36LdoH
         ZCvM3Md5wSr2jflR8LmvzxT7vXNibDQEoEfkl0Esv76QPrOFv5QqYynLHazAjsH+gGXq
         xeXA==
X-Gm-Message-State: AOJu0YxbcMqxA4YyPypuex5CWTzDgcTuGO8kJj15FcxmRAJOCEy4HkZZ
	EKshAkMuUoUtIY5jEYANt/AkhBY4syH+Me9Q8jB6hdw4b0rBZ/1YfJlja3Vj2+RFW912OHpd5zg
	u2o5O2v+kNkA6bghY4rndETnplcbUapRhRcKmcwglML3i96pPXprP0sKwfjRKn4ckR22zp6EBWg
	3bnWOD/qyzaLw/H9MTZa6HvP/1TLZAFdPL1jW63H2GkP24dBddB6RHAxTCMoaum6GNvX0Hyg==
X-Google-Smtp-Source: AGHT+IFra2Fqc2juVFyztrDKoPqJAOgdllghtTOcIwdaqb22hbe5Rj0QmTIIP5lhZd24i/lOAVwtqs3fyAdpCzpYcHm6
X-Received: from edbin4.prod.google.com ([2002:a05:6402:2084:b0:641:3d42:99b6])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5c8:b0:63b:f22d:9254 with SMTP id 4fb4d7f45d1cf-64350e8a001mr12193090a12.23.1763451464230;
 Mon, 17 Nov 2025 23:37:44 -0800 (PST)
Date: Tue, 18 Nov 2025 07:37:34 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251118073734.4188710-1-mattbobrowski@google.com>
Subject: [PATCH bpf-next] selftests/bpf: use ASSERT_STRNEQ to factor in long
 slab cache names
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

subtest_kmem_cache_iter_check_slabinfo() fundamentally compares slab
cache names parsed out from /proc/slabinfo against those stored within
struct kmem_cache_result. The current problem is that the slab cache
name within struct kmem_cache_result is stored within a bounded
fixed-length array (sized to SLAB_NAME_MAX(32)), whereas the name
parsed out from /proc/slabinfo is not. Meaning, using ASSERT_STREQ()
can certainly lead to test failures, particularly when dealing with
slab cache names that are longer than SLAB_NAME_MAX(32)
bytes. Notably, kmem_cache_create() allows callers to create slab
caches with somewhat arbitrarily sized names via its __name identifier
argument, so exceeding the SLAB_NAME_MAX(32) limit that is in place
now can certainly happen.

Make subtest_kmem_cache_iter_check_slabinfo() more reliable by only
checking up to sizeof(struct kmem_cache_result.name) - 1 using
ASSERT_STRNEQ().

Fixes: a496d0cdc84d ("selftests/bpf: Add a test for kmem_cache_iter")
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
index 1de14b111931..6e35e13c2022 100644
--- a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
@@ -57,7 +57,8 @@ static void subtest_kmem_cache_iter_check_slabinfo(struct kmem_cache_iter *skel)
 		if (!ASSERT_OK(ret, "kmem_cache_lookup"))
 			break;
 
-		ASSERT_STREQ(r.name, name, "kmem_cache_name");
+		ASSERT_STRNEQ(r.name, name, sizeof(r.name) - 1,
+			      "kmem_cache_name");
 		ASSERT_EQ(r.obj_size, objsize, "kmem_cache_objsize");
 
 		seen++;
-- 
2.52.0.rc1.455.g30608eb744-goog



Return-Path: <bpf+bounces-54318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD94A67663
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC823B309C
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2D020E337;
	Tue, 18 Mar 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Qk48AvVZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D426120E01F
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308198; cv=none; b=hy/aOAbGqyvJiXMq7y7mw4IX0GAHLt6v0cUy3eQjSSRasnXhWPsi5vA/Hug+JEzN4kOj/WykMKcCOjUvxXinP4kAViy2oMzUUayUkcY3iKEgfwRIwEQXPMUq+e6flOO+MFRrZ8KycC086enrmaRzcv49w9b2a3UvmdXRPKw+jg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308198; c=relaxed/simple;
	bh=M+xV3znuGfxQR3up5Y4ipED7hVqA6sAzhs61jUjwbB0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dNVvmnsxywf9CzKQpQbCowzKgzZHf+NaKO9AS8uqbMdC4CY199g4Z0/l/Rd5CtqK5rjbSCcjxyUx0LMlzeFB6dx8F/65BpEGSna4dsswSfJ56hFzB6TIE+Cge5JmnxQZ0OehRl/5/3ts6N89Q8bUIGMqH4pu+Kzc/KCntyp8+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Qk48AvVZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39129fc51f8so5055558f8f.0
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 07:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742308195; x=1742912995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwK49mfIp+anRdvs//XfjS8X1GXzhpbEoKp5nQKv9I4=;
        b=Qk48AvVZ69Aq1d2WK+mE+JZP0gxBAUFMJT8WQUwS0c6iLl5A2EG2pXWRhaPBMJ06eR
         uU/sXKCjHMPc2xrOIFY075niuhM/hc8mB+q2xnaTwqMvJ1KZixIuvVNZTiUiRVOM9JDp
         9BpgSVfjvp69zj1Rpl2MAecN1QNjZR3rE3B8g6NKhUnP8yMISGqLD8FelRjt3ddTBHyV
         gG6SmPgj/0Gf876mySSZaylzCSvzqikw7H1oo7tiz07UgLLbBV7OfB9b/ElUYLQynUxG
         HqM6tNygxv77eFeEDDE5ARXCh1oU4BWV/4aka9RzZqn7mY0vLAIZ2TL8rcYg1N4WC6OL
         YsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308195; x=1742912995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwK49mfIp+anRdvs//XfjS8X1GXzhpbEoKp5nQKv9I4=;
        b=XhqAjR/gRZYiN4MTprMOvrO1LpS6MfacGALINO3wVM7rTjubkJg40sRO6an/wWyrIR
         mgvHqUrJSqMNs4T7/sYG/8SHjsSs7whA+dV3uJ3EpcT7O9RTHW2He7lIMlpOh2jTrgxr
         ApSBt/Xz3f1e7FgBZntzNSYGh2skJhA5VsblNeduAK/UBSBEl+E8TRV4pjMpP1/7XJMS
         YTJ1z19sR3OT6svZSyVZXMMLsFFvvEUpY3kb4rRJQlIAB1yp1s6dbmWBHPMFqQNHHtdI
         sddtd25/NHuFceEjx+2K7HznygqsHj3O2DWHsK53LNuMyFgWACPcVfoM5H7PuMGNXGX6
         yFvQ==
X-Gm-Message-State: AOJu0Yy2RU4fgcshFHI2TBt2W5TWl9ttC7uJFp1wNoCB5wIl9YTy9XTg
	ya29hgGR4rDdJpMoHMjVGLlTqmc3/E3Lu2L0BJeElFz+hYDRk8GSwPVB0yGsRyC1AMqgnHKIlek
	r
X-Gm-Gg: ASbGncsXJ+pZzLFAtXhm0PLrtrb41sfXk7KucFI+59S1qTjhQN4eeyfwjD7jVQfKNvO
	RrWRat/XwoA76GcWHFHvNP7fGM2ZHSUoT15JOxBOs+nliFKuVylNHi3JJ681dcmR3IMCFE3fhE1
	9ovj3NhQzVnAOrLf9LgkdOZKP25hZgzqPSoG+DJvvl26FJ+Cw4kyvgwvIsz6GXbHVzFAJPkLmnl
	OAi0fOcoMQvXWv3g0s17wtJPWLSi6c5xuZUHsWHRs08WFFqJx8FVgET7B/joVxF1Rq8rLuhtwVA
	5Slxg2bLWk9i+WQpil+C5jxJkjs4z1h2DQo2rxbKwdStBMN57FdYJv6mlQ==
X-Google-Smtp-Source: AGHT+IGSMZSSrrtU9EYE04nxy8JLa8dag6U81WGkj8W4n/jCC7NAzJzjuVSRXdH5+EDLfsaPXOHgfA==
X-Received: by 2002:a05:6000:178b:b0:394:ef93:9afc with SMTP id ffacd0b85a97d-3971d238075mr16157837f8f.18.1742308194952;
        Tue, 18 Mar 2025 07:29:54 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm18348071f8f.77.2025.03.18.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:29:54 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH bpf-next 09/14] selftests/bpf: add guard macros around likely/unlikely
Date: Tue, 18 Mar 2025 14:33:13 +0000
Message-Id: <20250318143318.656785-10-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318143318.656785-1-aspsk@isovalent.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add guard macros around likely/unlikely definitions such that, if defined
previously, the compilation doesn't break. (Those macros, actually,
will be defined in libbpf in a consequent commit.)

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/testing/selftests/bpf/bpf_arena_spin_lock.h | 5 +++++
 tools/testing/selftests/bpf/progs/iters.c         | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
index fb8dc0768999..d60d899dd9da 100644
--- a/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
@@ -95,8 +95,13 @@ struct arena_qnode {
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
+#ifndef likely
 #define likely(x) __builtin_expect(!!(x), 1)
+#endif
+
+#ifndef unlikely
 #define unlikely(x) __builtin_expect(!!(x), 0)
+#endif
 
 struct arena_qnode __arena qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
 
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 427b72954b87..1b9a908f2607 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -7,7 +7,9 @@
 #include "bpf_misc.h"
 #include "bpf_compiler.h"
 
+#ifndef unlikely
 #define unlikely(x)	__builtin_expect(!!(x), 0)
+#endif
 
 static volatile int zero = 0;
 
-- 
2.34.1



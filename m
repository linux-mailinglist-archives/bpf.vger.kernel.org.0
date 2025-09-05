Return-Path: <bpf+bounces-67528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AC3B44BEE
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 04:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7AD18855A0
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 02:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495E2225795;
	Fri,  5 Sep 2025 02:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y7cg+uXL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FB4223DEC
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 02:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040884; cv=none; b=PeDSnh0HJXTkVL4d+smyNur0uizBCdQDSNJwDgtAr3lq8FBR8MUz4XfBd7KHR/+i1hD3/Ouzh9dQqsiT5hi9jjVIcfZQ35ooU5NXPlhgGoIY82cg7L7RjLfnHDGKQilH2hrppeys2lJp9fsE0ihamG3AU4ObbtjR8fRer2m9POc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040884; c=relaxed/simple;
	bh=ROxDYlDbZdUxv6mle6mrNjV7kimAUJqp2gftch85SgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRq2t0mG+DhjCgUYad367wGzxQy8y5JmdMbF9BnvgRXq0wo2/L76mkZtX+4wk7dQ3TPPkGjctcVPT4izWsNY+1hVakwCu06b1mzi+nfrbJR12rxlOXAWg2DoMkVdyQyc7Q5xJs9amtzhFljmfygl2M87f2iLYKlph+QWXqzIWuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y7cg+uXL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so10667295e9.1
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 19:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757040881; x=1757645681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPgXy/JSV/thOQffLkJ+mMtDrYm8eOUlc8683wpwWUY=;
        b=Y7cg+uXLeSQhXai6GiAnFgwnkuHImA/7FQ1Li1bg91qW2/XVevS5snWXL9CsGeq2zU
         5yI3jgRmRrIJrFnKl4djerEXY/RWrdUqAxXIhO0kGZMCBqyFXpWLS2yLTrAJcvctsenB
         M4fZC/L1U67lcwNJMznn/HCvcb/j8I6bOoWdYagS6uWXpgUlKIi07NppgbHef6hZbM+n
         JT95cjcYfl1AhfUzBC7os3wgLofx5BynVyPXRq50fhc5c+mY7qc7/2ZEVzp2JGSza/6T
         s8bpr5wlE2T1va701HTBZnnI/zcr5i5ADPPERFtvJKYaQcYDVx2UTDv9kLBc5lw2eMXc
         SFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040881; x=1757645681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPgXy/JSV/thOQffLkJ+mMtDrYm8eOUlc8683wpwWUY=;
        b=ajFHOzuxhM1r9pk+/Dx0o/AvyhVQkTQuMJu5kyvMFQMPttw6nJD46+Cc5nYscYsDKG
         8CEK1OFbMBpGcXiR4l962zoy95qH0yRSC0MM1YrKE5HWTqLjjYkpV61t92WtYiwPzgSB
         +S0oaeVkQotv9MgdzRK8I+wMOwKDjQz0/hdG6bWTdeFDSoTbjdjD6G68yXlbv3nb2Pzb
         ojDp6jQnpnDwma3fD79XYHaiiSZMYano22pPgtmllulu2Lqa3TGFWuSk/B+sRMTAxvVZ
         LS3nmUEayEGuCLbYbEsbkn7vEmLy550JnKv3BbbRbuFNsbSWgiCTSmhOVGrEMMpXyEK3
         OsNw==
X-Forwarded-Encrypted: i=1; AJvYcCWhmbPMLROEnJdYDQgg5E9d5Ceox5YjWTFO993YUa+zQyLV2cQ6B+bn+sKPq7gSKXmHKBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz70yYcDQ8EmCirddSABAbhUUAMel/MC2jU73UnmcGW2XTgvHsF
	Cj0om6JG0OS/0gkssMGM+6eRNHeu1zRMHEK7qgkAkY0taxCW/Eq3WBOTkDOvrrbqLqI=
X-Gm-Gg: ASbGnctZqm/X+Bbf9S3567CQjg+t2YXYDLBJSoaTwSG8vKB1ROmMwfcxAiqOO968bIR
	V8eLf9TGwxnpkgxEQ01wngwqN2YCRrZ570PzHCqO5unjr/Jk5ouQ9oYK4HUTOwyT+YGTGDXyE5d
	GWEI5twOeWto1kFIiy8JY5oAmEaZ/qyTmvjmZ+CloeBeVIxCjMyHy+jucER2q9b1Ec8jwKQyNIY
	G21rwjNnw6HwZ7A0k6mTVcyStWHKveueHEobBTMm/J21LCOxJ+W7fXcgRCF7cSsL5uw6r7C4vIZ
	cp9o+DaI/1jvb5WgxKxv7Tte1Wl5Dbh3tKsT1dHcaONqw+AL/ml+vI+saiizxhCrofoIaTeaC5v
	yLK0YrQxjp2EIcTnvje0KCs/+lipADBEiS1CdKA==
X-Google-Smtp-Source: AGHT+IEOg5/gh0SzZXGK8iRIkbBd3Bbh7F26L+S9OdjDBKceU62A4KxoMCAcN4H0X+hecav625Lmmw==
X-Received: by 2002:a05:6000:25c7:b0:3c7:36f3:c358 with SMTP id ffacd0b85a97d-3d1dfb11164mr16205970f8f.32.1757040881025;
        Thu, 04 Sep 2025 19:54:41 -0700 (PDT)
Received: from F5.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b520b545a96sm457225a12.20.2025.09.04.19.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:54:40 -0700 (PDT)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: 
Cc: Hoyeon Lee <hoyeon.lee@suse.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf)),
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [RFC bpf-next 1/1] libbpf: add compile-time OOB warning to bpf_tail_call_static
Date: Fri,  5 Sep 2025 11:53:11 +0900
Message-ID: <20250905025314.245650-2-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905025314.245650-1-hoyeon.lee@suse.com>
References: <20250905025314.245650-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compile-time check to bpf_tail_call_static() to warn when a
constant slot(index) is >= map->max_entries. This uses a small
BPF_MAP_ENTRIES() macro together with Clang's diagnose_if attribute.

Clang front-end keeps the map type with a '(*max_entries)[N]' field,
so the expression

    sizeof(*(m)->max_entries) / sizeof(**(m)->max_entries)

is resolved to N entirely at compile time. This allows diagnose_if()
to emit a warning when a constant slot index is out of range.

Out-of-bounds tail call checkup is no-ops at runtime. Emitting a
compile-time warning can help developers detect mistakes earlier. The
check is currently limited to Clang (due to diagnose_if) and constant
indices, but should catch common errors.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 tools/lib/bpf/bpf_helpers.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 80c028540656..0d9551bb90c0 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -173,6 +173,26 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
 		     :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
 		     : "r0", "r1", "r2", "r3", "r4", "r5");
 }
+
+#if __has_attribute(diagnose_if)
+static __always_inline void __bpf_tail_call_warn(int oob)
+	__attribute__((diagnose_if(oob, "bpf_tail_call: slot >= max_entries", "warning")));
+
+#define BPF_MAP_ENTRIES(m) \
+	((__u32)(sizeof(*(m)->max_entries) / sizeof(**(m)->max_entries)))
+
+#ifndef bpf_tail_call_static
+#define bpf_tail_call_static(ctx, map, slot)				      \
+({									      \
+	/* wrapped to avoid double evaluation. */                             \
+	const __u32 __slot = (slot);                                          \
+	__bpf_tail_call_warn(__slot >= BPF_MAP_ENTRIES(map));                 \
+	/* Avoid re-expand & invoke original as (bpf_tail_call_static)(..) */ \
+	(bpf_tail_call_static)(ctx, map, __slot);                             \
+})
+#endif /* bpf_tail_call_static */
+#endif
+
 #endif
 #endif

--
2.51.0


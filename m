Return-Path: <bpf+bounces-68522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9CDB59BE1
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 17:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D10B2A4ED8
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 15:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FC0320A02;
	Tue, 16 Sep 2025 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiXh/eBZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E275A1A3172
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035916; cv=none; b=hHSAsCkihUZAYYqMv/VLOK7JalScZG1LfIdUmrc92GyxW8pYrbTh4FUABhe+j+L6CEIxXc5PERi/kk8riqjbVL+kKheJHHpVix3hr7xGSA4GR1WlgMqiIXTYRKbeALAeBKsd5RVvJxXUcSH3/2oEcdp5cq0XRhkVHNzVzWHCaXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035916; c=relaxed/simple;
	bh=DZaFIDOROwqGjvBTOyoiX1vrRlxygq9rUZt5qkKBD6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD4BZUVvhhz5WOAP0F92v/UfcZChTr7lKRsvK9/wLcXWRVJKj+wmO+Sy/Ov9ZrVPcDfYhdDbypGEI111BHhaLsBRmIx6vjn8HsbXMVrvV538ppIWxBvDSSYS/k9XvEM6Ged5GPnfy9JvUJaaZOqzn2axDBBlvDpEri1760pEURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiXh/eBZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso35149745e9.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758035913; x=1758640713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6wruokny0QuM+I6OAFE6sLgY/3Yxbp6GB8c7RMXDda4=;
        b=iiXh/eBZ+Rsh3Q/WyjeB/GXaTlIocXZfCxOJ+AfC/CxU7cusThZfusrOhudK35Y25U
         SEEdgk64CZT+Hf66t92XqzAiuyJEoWWLu3BNQsUe5oiqI5kmySp/YyAJE+Lt0Mil22LW
         zfOHl90Oc/s7XN1M8TToPHggZkCNtazhzMi6Ts8fs5/AYJqWbzFljtQAvUn6BlJrrchH
         itJV7xHhP1K7yVHuUvARbZabiPilFb4Y2mMWTn93nFaYTSWlNUaKEGKEVijJh/eNkr5f
         OuV6cV3wmlMDudaduHsIE2tkepGvfHnM7K2KGJBGmmCIVVOTPanPt6HQKYLwU/Ny9l/j
         JRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035913; x=1758640713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wruokny0QuM+I6OAFE6sLgY/3Yxbp6GB8c7RMXDda4=;
        b=REnvFLKl8sUv1Jozch2olS6JlBiso5LX8GLcoyNFVOvrCG7rSHB6O5ZrR92Jt+HXIu
         aTSSTM7Sf0/XhB3pFcO1M8pLrHwmuakF2A13R4hEuc59bbOQNSOmIU1h9SG6Vaggwybp
         ZrQrOJIxEvWs9ncjZe80AbSIA+BNAQi2EK2YBSx/hYXAn3Qc1AyJRKGNTj4+re14M9Pm
         F3s9tmcuaXpFyrgMNfKxmGldLH8l4hiFhAHYazkCb8Z26ok4IMqe9qbLzozoc8Jv3pbf
         Zy4mKKohaz7aFOC3PXqe1vUr9Vpn/GGaEqUFqZxf2pN4CSfpH2Pyehd3Mbmdl+Ntt3wP
         Rw7w==
X-Gm-Message-State: AOJu0YyoM5Qm8JhBaxZ0BKTalbWGjMPRLb0A6iR4inaK+fG0bB6kC639
	wzQKzM79gz2teKN04QbWxva13x7RWROatGCSSjXhmj65pb0frETiExUer6zfdARi
X-Gm-Gg: ASbGncvZMP6bOBpeBQ8vJNIvxZjJVH1VtJzOAwXqpTt46aktqlPuWZHr0a/7q4NajBX
	uzioynn/uxQ9HWgqgWwGINHX7MuoLkeg6mvTatqsBj8QB9v5qUAVxLwHPMj0GR/Q4f4raG/JH7A
	2oyQjGh3v//5k+l9sakdLPrh+BJsbju+v80X7PfWGgTN4YzTvbXO/7/tUJbkbIZoeJvkxzWGAUe
	lhtehLX3x9sg/paSL+fm3ki78a0yzQg0Qvod/qvTcJXTB0lEZjH/4Tf8NXX7KVwphK9ti8LOvZy
	rshMKHV3UAy7jdwW7+5BOdrPOGuevrrH4eZncilQDgidWOmlzQDcqTtjJ+kxGXlv8rUYew4Kfo+
	46O8nNj5qhgT9cn7NPIsH1alfRgXxQBa8PjYJNHtE6C65i8labR9No8jO//WyqYwRNBOqRF/+Ut
	xEjL3U3fMT2+Xit3B/zEwj
X-Google-Smtp-Source: AGHT+IFZEvKpxM1FGT+iThowNyGbsgwPaHFKbxFjUXXvoUTiYP9SELzbQab90AyRIHBg8kpPB1U4eQ==
X-Received: by 2002:a05:6000:1846:b0:3da:37de:a3c2 with SMTP id ffacd0b85a97d-3e765796575mr16556758f8f.24.1758035913069;
        Tue, 16 Sep 2025 08:18:33 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b660ca331402f663.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b660:ca33:1402:f663])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8237cfdddsm15745105f8f.60.2025.09.16.08.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:18:32 -0700 (PDT)
Date: Tue, 16 Sep 2025 17:18:30 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 2/3] selftests/bpf: Move macros to bpf_misc.h
Message-ID: <6d21ac4ab11cceab453fbac8ef8c42260a201a10.1758032885.git.paul.chaignon@gmail.com>
References: <f5310453da29debecc28fe487cd5638e0b9ae268.1758032885.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5310453da29debecc28fe487cd5638e0b9ae268.1758032885.git.paul.chaignon@gmail.com>

Move the sizeof_field and offsetofend macros from individual test files
to the common bpf_misc.h to avoid duplication.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h             | 4 ++++
 tools/testing/selftests/bpf/progs/test_cls_redirect.c    | 4 +---
 tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c | 5 +----
 tools/testing/selftests/bpf/progs/verifier_ctx.c         | 2 --
 tools/testing/selftests/bpf/progs/verifier_sock.c        | 4 ----
 5 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index c1cfd297aabf..749bf235dc07 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -156,6 +156,10 @@
 #define __imm_ptr(name) [name]"r"(&name)
 #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
 
+#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
+
 /* Magic constants used with __retval() */
 #define POINTER_VALUE	0xbadcafe
 #define TEST_DATA_LEN	64
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
index f344c6835e84..fa1848650d4b 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
@@ -22,6 +22,7 @@
 
 #include "bpf_compiler.h"
 #include "test_cls_redirect.h"
+#include "bpf_misc.h"
 
 #pragma GCC diagnostic ignored "-Waddress-of-packed-member"
 
@@ -31,9 +32,6 @@
 #define INLINING __always_inline
 #endif
 
-#define offsetofend(TYPE, MEMBER) \
-	(offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
-
 #define IP_OFFSET_MASK (0x1FFF)
 #define IP_MF (0x2000)
 
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c b/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
index 5f4e87ee949a..1ecdf4c54de4 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
@@ -14,10 +14,7 @@
 #include <bpf/bpf_endian.h>
 #define BPF_PROG_TEST_TCP_HDR_OPTIONS
 #include "test_tcp_hdr_options.h"
-
-#ifndef sizeof_field
-#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
-#endif
+#include "bpf_misc.h"
 
 __u8 test_kind = TCPOPT_EXP;
 __u16 test_magic = 0xeB9F;
diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
index 424463094760..b927906aa305 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -5,8 +5,6 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
-#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
-
 SEC("tc")
 __description("context stores via BPF_ATOMIC")
 __failure __msg("BPF_ATOMIC stores into R1 ctx is not allowed")
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index 0d5e56dffabb..bf88c644eb30 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -5,10 +5,6 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
-#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
-#define offsetofend(TYPE, MEMBER) \
-	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
-
 struct {
 	__uint(type, BPF_MAP_TYPE_REUSEPORT_SOCKARRAY);
 	__uint(max_entries, 1);
-- 
2.43.0



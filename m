Return-Path: <bpf+bounces-68644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C589EB800C8
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 16:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4807163F9A
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 08:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC62305E05;
	Wed, 17 Sep 2025 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF1uemmd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B8A2F9DA7
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096572; cv=none; b=ar6ERhCai1w/jHx4mGq7q8xRVZANtNryexzNt2g9zHCZiJZJzifK3SIG6K4ePUDzoDrRQagmiMw+riQ1n4VvoqMf5jZDLgbi462Qlz+NQh5/d567Clx3JX/9sd7ppPH+7Q63c+avt+fcb5LBjEwItbHsM+7+jb9XkIlB4XUd8bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096572; c=relaxed/simple;
	bh=788cLg2dTrkS6uNy1qGGfqcZMoCd3NtP4T48L4Pag5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyFVC928/73EEkT3B94AnfE4P7868s+nSB2N0jldFA4qjXXL28PI+u0XYPwXUvXRbzG7owza+oDutNW72v16+qM4qVxoTDyM41BVNk5BnM8DqhxUOM9IF3rW6olcOOnLne+dtwCHzJ1T1cUaMAl1YQLzXr5kMLGPBxyhTarQuiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF1uemmd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3eb3f05c35bso2280756f8f.1
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 01:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758096569; x=1758701369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6o/11cRspt1KyAL4gmJ+lrPSw19niBiQtQQK+Ne/So=;
        b=kF1uemmdhqlt/0Yf6nUztM9T2CUjlg9hPOGJRwuWqiCWqtba7F2nwIfBtsVQcQhHEQ
         QlnNsX68cWW5ORqSyu8NsJqukji4DLJEYluI2p4z3ZgBbqwCtYNYn/wf9ktHR+8+D0dF
         lgtxT+Nt/QxxXE6wS7G68rK/4d4vYtFHbbq/DyE4zlCAcK0+2h7BNsb+yAorSxqI4bj6
         r76vbR3Y6ZwbX2iDLS7dggMWgmodxxejRt11beRaJK1kY+knKx96fL625WhUZpRL1Zkw
         Crd/F1XWh6IH0NLkewuKImfO5V7GqLe+NfYd+MayojtBxyxKVR1NlW1DkNDxx4BknQLg
         YUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096569; x=1758701369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6o/11cRspt1KyAL4gmJ+lrPSw19niBiQtQQK+Ne/So=;
        b=t+8ZqbEC6TKWsKJPbIv6m20W5Wnzm08Jy7Ibdo1EnKAuicgRAAJQA+Kq12glxYfaK5
         9vsHcv9hY0RtuCKgaQcWP6M7mQ8ZOgkAJvpLnxVcJmQwGSd3sNGpLKw2K7NH1gN3eRza
         G2KV0hw3n6YvdKUR4J+nHgpbUPcXNRxIERWY5fg63pzmQF0k4auDi9J38mw6FgYNr6rZ
         FI70x7NGSDCzPR22FTGokGEeJAoMaFqkb9UNyKmMvqn1vuEzxe6GnGIyR0iAXZV/M1bq
         WAlEkEgbt9+Cz5Jc8mo/XBbrrtxX3DbpuhO1QB9mn2KAlBYsztWZ+vF6ihtDPhx/sn8Q
         l3kw==
X-Gm-Message-State: AOJu0YyWZMicLtQZpWLJIxWXmNR+OFObk+xAFdOCVUCkGvLN7RMl43iO
	CDjOYP6D7JXoQB8UpF4P5Q8NF++dgvubacHeBSdHCN9rYi9gB678WHXdnEMxbkwk
X-Gm-Gg: ASbGncuYItqkorsnUNS4XZAm5WL5Dsv/26DphvleNAfWx+Ut/2DoLoo8Nc9h3RJemXV
	p+0QzkJjCp3mi51RjrByJlLerhnknzIF8RW5TR2rDgtNgd1sH26J12IB95ucu4ueSgnSxBlP7ar
	X6Ig0YHHxWGAdt2MdizCDNWDf4ZOj4cxOQ/V3phdvq+n8v4J/xWAIbEk9dOnCFHoOmpBrpCtri/
	5gPdYWKm5ocpMHxwci776Jg5HQwBwSo2Powt8BUgMEb39olc5f4dBms/WBrQAW5rI+TdlYszrlK
	0NKBPfXfLiIxL6revpqSqdgIsrYib3eQoS2WyJKtL69ADtsv3Ow7Y+BF7s3Lbu+TQFe7FqcsaNg
	nmXjl4xRTTWvJXGWKCi0L6Tkua1bWpoL2otHn6+cn2+9FjIHqNmbVEwcgvKaaeE87uJiDYdUPDs
	kGt97xkahOLPJTPoXecDBq
X-Google-Smtp-Source: AGHT+IGtR0BqKZ5YATx5msFWoDEJnBt4qDTwfBh3ruzAE7JR6luKzt96YVnXeBCvfwLZa13kCoM6NQ==
X-Received: by 2002:a05:6000:290b:b0:3e9:d54:19ad with SMTP id ffacd0b85a97d-3ecdfa0b61cmr985979f8f.39.1758096568618;
        Wed, 17 Sep 2025 01:09:28 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f6fdfecb9884ca93.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f6fd:fecb:9884:ca93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e80da7f335sm18558865f8f.8.2025.09.17.01.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:09:28 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:09:26 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Move macros to bpf_misc.h
Message-ID: <97a3f3788bd3aec309100bc073a5c77130e371fd.1758094761.git.paul.chaignon@gmail.com>
References: <cover.1758094761.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758094761.git.paul.chaignon@gmail.com>

Move the sizeof_field and offsetofend macros from individual test files
to the common bpf_misc.h to avoid duplication.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h             | 4 ++++
 tools/testing/selftests/bpf/progs/test_cls_redirect.c    | 4 +---
 tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c | 5 +----
 tools/testing/selftests/bpf/progs/verifier_ctx.c         | 2 --
 tools/testing/selftests/bpf/progs/verifier_sock.c        | 4 ----
 5 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 7905396c9cc4..1004c4a64aaf 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -167,6 +167,10 @@
 #define __imm_ptr(name) [name]"r"(&name)
 #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
 
+#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
+
 /* Magic constants used with __retval() */
 #define POINTER_VALUE	0xbadcafe
 #define TEST_DATA_LEN	64
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
index 823169fb6e4c..26a53e54b8fa 100644
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



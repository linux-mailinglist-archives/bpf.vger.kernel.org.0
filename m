Return-Path: <bpf+bounces-51929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AEDA3BECF
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 13:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A42C3AD9E7
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 12:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3960D1EEA2A;
	Wed, 19 Feb 2025 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PenDdF8E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21BD1C8618
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969485; cv=none; b=PYrrjvI0Y8VGXvIl0jMUEVlOjdoPRBE6aJqPizD13sHFhBDijJW00GN2err1e8qqV3DjW4xm0vL6P1PycK6Wpci3Ezvxw6lBeF0gpF0QQp7H1BwOzYVbObAvZuH7Jbdnc8tGBoy8Mo0DxZaV4ZCv9MhdH3PhAAEM5yeVLmuo2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969485; c=relaxed/simple;
	bh=6XYTmAx68QTrXVxXKsM5RldpcP+9TiFM8xwlIz459IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9CJutDFaQyWzmDpY9x/8nzuMWO3Yk1xONTECBbBl2f76KGMVhKZ84zYr4A9WvZkVfC8W70AqYNEyoVhj9gcyfD8kRaNZ5McusLMonXO5t/vakfSkiWd28vrDhn+EMJmJzkxBlnSGSeTN+Mpk2rUIF3R+wXM6+Jh06grRu8aHmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PenDdF8E; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so875588866b.3
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 04:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969482; x=1740574282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOc4byIIUqJytQrq7jeUNbnhyJFKaMDPifxZAvikPxc=;
        b=PenDdF8ECVA6SVIGb4KDdr//XRjBuJc8NkKv520uO81NkAVNE7WCLhxx4JGFXqpT8Y
         Kh+BGpr9Vzzn7dtS9jfZgTdoUpNErIWzIusW/3Yn+SCQHitYhjC8J9pSYs1kHSvZlDyt
         LXNqunZSLI68CKC5OGBbpjvyT/CSRLAu22s1stkcEdlgz+pKbtQjszGRo9LIQwKDOwcw
         E5W7H56yylp4f0pPL+XaF9PfadojO+j2+uIBsaWgxAJoj2lMhCtY0bsOVwDJWhvjVh53
         ZBuvO7hK5cVHWQdYS7UN5iVBHEjBmebcu3CRkjBdePCcUsjG/o+0y5ob7DzTSnMpsVo/
         1ubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969482; x=1740574282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOc4byIIUqJytQrq7jeUNbnhyJFKaMDPifxZAvikPxc=;
        b=fK07ehMRq18IuGbJJQf1mn5t2Kg2Kpedlike+RRG3ZUDEK2epNl7vwAauAMpe2pXB7
         HOGyfghF41Vc83GzBVVjIe0grLEU7vGGBXzmnZnt+drayAykf1QwXlBeF8hvoVcb/XnA
         vPzI0jhxAN35blKVDg8W2p8vi4YPcwJc4pxefwGua3Uo3XehHcw2bLylMR0XShgkQTMr
         CIsAvDaF+rxogpykRzkwEnO4Pjgb/yaEoPxDGmml4+OgNkm3kUP2ZRxtqKJTfTu2rlnm
         ufotrTIdPZzzGGgdpNY2iEIC88YI6pPCv4/sCz2UYpVpGTr4Ye/MRsbjlYypgSUgu8FK
         g+PA==
X-Gm-Message-State: AOJu0Yyh1Xi3mEm6bb1+gWZSiYTid0psAow1u2W2O8cuujB3eVeNOWQj
	6mla8/4lfGj7/XnR+uzMbZjY+jC/Y/e1074/BPkAqB7drldXb7AMAzZmZXh36uM=
X-Gm-Gg: ASbGncvkkQ1kob2S5EZ+ZPA9Y/vtAAaRLv/VAKOv+kEAhSSo/gc1ncC9U53zG1bs4wa
	j8CY/nv6P9uPnhWIkma9x/55t9hGYxqOxHL+sZNcdUKxv8ljFZHjxTAsZ58EUmcWHhuVpH6OzsG
	Os6t9Bejl23RpfBPYNfDaP9aWL2qN3vEycjgMHEpp+eU/g+lLO64cknMNGqe/UwUdl43ncej7wl
	Q/JGAR7X2UOh0g4rW+vTYBrU2EMR+W3EajibALt1x4JkpOHoDDQz8n4xnaYYdaDPu3sYAfHrICC
	pA==
X-Google-Smtp-Source: AGHT+IGVGHb3nZph/XXE+vy2eUQ3Ofor54uSkLWzQG/E9rX5TqzAhLl54itbild/KYj7O0GwczC8aQ==
X-Received: by 2002:a17:906:794d:b0:ab6:949f:c52f with SMTP id a640c23a62f3a-abbcce423bbmr409878866b.28.1739969481632;
        Wed, 19 Feb 2025 04:51:21 -0800 (PST)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5323202dsm1258280266b.6.2025.02.19.04.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:20 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 2/2] selftests/bpf: Add selftest for bpf_dynptr_slice_rdwr r0 handling
Date: Wed, 19 Feb 2025 04:51:16 -0800
Message-ID: <20250219125117.1956939-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250219125117.1956939-1-memxor@gmail.com>
References: <20250219125117.1956939-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2062; h=from:subject; bh=6XYTmAx68QTrXVxXKsM5RldpcP+9TiFM8xwlIz459IU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBntdMy+PfiAFjZP4enxwlRIu8csG3Jmx1fSFheSwHx p5hIwnqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ7XTMgAKCRBM4MiGSL8Ryi4JD/ 9bC/7r8yjAuj9O0aZ3lVAl1ZjE8e1+9NgAZMxChFN4Obj84bSWy8eAEH6Kyx53bwFPUiyl186g/YFG lu+rD1PA09B1HghHxWmbznEYe+lrVr4q2fqlQvdYFAdaMCL6XtQgNzfHRdLe15bLnU/NlLKu0Sj9PA 4MZXAVEWZI0it14YS3TrR0JuzPMPClYqw+SIWBLj6q0+ULEm9x2YNtziebhXcKtDwpGX12OU+X+KMo PBMS6Qn3hySHXWaKqzGqpYnj0qIYW34PfTCV4Q/J4yEDBwXtjwkbUzuM3dsmJ+DATa1d14J3NgUD12 ZzI7VP2JeCTkjXwokpeQAP3b3AO3Kj/REwptxIn9b3WRUtppuysvFwCM7Tq8fayMFJmzr80oMr93oS mZGdkEFz/CZ5KQloQfACRnH5klb+UNKXG4ChioQR4hLQ8ihE4ILy5k3WJc4o8Axub3qZPWkaO4ZmZN 5qDgxmzzUvnLHqWwucSt60UHtWBO3Almrp3jd4wPn8mOMszw/tPeCk57FBEsUhlEXFLp6ER3AXSKWS ikBm9VZTy5kbAclC7oKXOIU1pU5kxJ5/k7kibkGaRBdtRDOBOB00Jktp/krxC2wd1c2w/QTNRu3W5g IdgC471+8twcF9352AABbMA3tCTbVZIwdgiZ3ejFItJf0H5mee8kR/02zsGg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that once we get the return value and write to a stack slot it
may potentially alias, we don't get confused about the state of the
stack. Without the fix in the previous patch, we will assume the load
from r8 into r0 before will always be from a map value, but in the case
where the returned value is the passed in buffer, we're writing to fp-8
and will overwrite the map value stored there.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index bd8f15229f5c..4584bf53c5f8 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1735,3 +1735,48 @@ int test_dynptr_reg_type(void *ctx)
 	global_call_bpf_dynptr((const struct bpf_dynptr *)current);
 	return 0;
 }
+
+SEC("?tc")
+__failure __msg("R8 invalid mem access 'scalar'") __log_level(2)
+int dynptr_slice_rdwr_overwrite(struct __sk_buff *ctx)
+{
+	asm volatile (
+		"r6 = %[array_map4] ll;			\
+		 r9 = r1;				\
+		 r1 = r6;				\
+		 r2 = r10;				\
+		 r2 += -8;				\
+		 call %[bpf_map_lookup_elem];		\
+		 if r0 == 0 goto rjmp1;			\
+		 *(u64 *)(r10 - 8) = r0;		\
+		 r8 = r0;				\
+		 r1 = r9;				\
+		 r2 = 0;				\
+		 r3 = r10;				\
+		 r3 += -24;				\
+		 call %[bpf_dynptr_from_skb];		\
+		 r1 = r10;				\
+		 r1 += -24;				\
+		 r2 = 0;				\
+		 r3 = r10;				\
+		 r3 += -8;				\
+		 r4 = 8;				\
+		 call %[bpf_dynptr_slice_rdwr];		\
+		 if r0 == 0 goto rjmp1;			\
+		 r1 = 0;				\
+		 *(u64 *)(r10 - 8) = r8;		\
+		 *(u64 *)(r0 + 0) = r1;			\
+		 r8 = *(u64 *)(r10 - 8);		\
+		 r0 = *(u64 *)(r8 + 0);			\
+	rjmp1:						\
+		 r0 = 0;				\
+		 "
+		:
+		: __imm(bpf_map_lookup_elem),
+		  __imm(bpf_dynptr_from_skb),
+		  __imm(bpf_dynptr_slice_rdwr),
+		  __imm_addr(array_map4)
+		: __clobber_all
+	);
+	return 0;
+}
-- 
2.43.5



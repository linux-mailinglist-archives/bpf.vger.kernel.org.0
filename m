Return-Path: <bpf+bounces-60925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A654ADEDDE
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89664400405
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135F02E7186;
	Wed, 18 Jun 2025 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+WFHiJI"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1C155A4E
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253577; cv=none; b=pA1GIHI8wl2xFVTB7rnggmsMFiUi7S+pTU+g/wfs8TzhSnzJ3oZHiPUJmogk/SSKlUOz4V6hdwc4ZPMp+oyj9YJwp17hX2DOkPjejnym//b1sikSWkNCF+aNy+QnuRUJ53M0R9PSdPcmuRgF3rNm1TgQiwbx9cNIvaH2ypCY43o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253577; c=relaxed/simple;
	bh=lj5oqKB4eprN+oVgSTPmnQnqceKhQ3YqrGm5L5WMgHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eb1vbgKQg9IIHRuCYvG+SVAQ74vn/dpFDh39TmzyBfVD4y/Dc8cRRaD7YinTuBhn8CDwfa9qWTKdwgTIPg3/eR90T1PxTY6PMYZFIe9+aAuwQA5Ee+P5fPaUXzKCEWj6w9F8I37Z9X+Xd6SDkNTskCND1lot07MrIfeZ+MtMLr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+WFHiJI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750253575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEp5Cx3RMVIDxdwG7lZYK1++kiwaDZn+5aaViPP0FK0=;
	b=B+WFHiJILwyvFTyl49qg1UOHMSpqDqYdFJcl4Ar3bcOlPI0atQbO9knZXtNMoV/Kv1qLjc
	1rnCcfsp+ykOOtviJa6VnOBTPIpb0a+xHT6JLeBCo3VVCxDXoDPWomLAa9S5HAq3LY6W3s
	2uHQjXc2CtG9j+wAPK7VZAhV2LXVZDw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-mdjeSHhEOzyV8mwaxTkRZg-1; Wed,
 18 Jun 2025 09:32:51 -0400
X-MC-Unique: mdjeSHhEOzyV8mwaxTkRZg-1
X-Mimecast-MFC-AGG-ID: mdjeSHhEOzyV8mwaxTkRZg_1750253569
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A20C319560B5;
	Wed, 18 Jun 2025 13:32:49 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.226.177])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F63419560A3;
	Wed, 18 Jun 2025 13:32:45 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v5 3/4] selftests/bpf: Allow macros in __retval
Date: Wed, 18 Jun 2025 15:32:21 +0200
Message-ID: <04a320f8a9405caee87c59807a4192e2b5e14bed.1750252029.git.vmalik@redhat.com>
In-Reply-To: <cover.1750252029.git.vmalik@redhat.com>
References: <cover.1750252029.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Allow macro expansion for values passed to the `__retval` and
`__retval_unpriv` attributes. This is especially useful for testing
programs which return various error codes.

With this change, the code for parsing special literals is made
redundant (as the literals are defined via macros) so drop it.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 11 ++++++-----
 tools/testing/selftests/bpf/test_loader.c    | 17 -----------------
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index a678463e972c..1758265f5905 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -83,9 +83,10 @@
  *                   expect return value to match passed parameter:
  *                   - a decimal number
  *                   - a hexadecimal number, when starts from 0x
- *                   - literal INT_MIN
- *                   - literal POINTER_VALUE (see definition below)
- *                   - literal TEST_DATA_LEN (see definition below)
+ *                   - a macro which expands to one of the above
+ *                   In addition, two special macros are defined:
+ *                   - POINTER_VALUE (see definition below)
+ *                   - TEST_DATA_LEN (see definition below)
  * __retval_unpriv   Same, but load program in unprivileged mode.
  *
  * __description     Text to be used instead of a program name for display
@@ -125,8 +126,8 @@
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
 #define __flag(flag)		__attribute__((btf_decl_tag("comment:test_prog_flags="#flag)))
-#define __retval(val)		__attribute__((btf_decl_tag("comment:test_retval="#val)))
-#define __retval_unpriv(val)	__attribute__((btf_decl_tag("comment:test_retval_unpriv="#val)))
+#define __retval(val)		__attribute__((btf_decl_tag("comment:test_retval="XSTR(val))))
+#define __retval_unpriv(val)	__attribute__((btf_decl_tag("comment:test_retval_unpriv="XSTR(val))))
 #define __auxiliary		__attribute__((btf_decl_tag("comment:test_auxiliary")))
 #define __auxiliary_unpriv	__attribute__((btf_decl_tag("comment:test_auxiliary_unpriv")))
 #define __btf_path(path)	__attribute__((btf_decl_tag("comment:test_btf_path=" path)))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 9551d8d5f8f9..28d2d366a8ae 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -318,23 +318,6 @@ static int parse_caps(const char *str, __u64 *val, const char *name)
 
 static int parse_retval(const char *str, int *val, const char *name)
 {
-	struct {
-		char *name;
-		int val;
-	} named_values[] = {
-		{ "INT_MIN"      , INT_MIN },
-		{ "POINTER_VALUE", POINTER_VALUE },
-		{ "TEST_DATA_LEN", TEST_DATA_LEN },
-	};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(named_values); ++i) {
-		if (strcmp(str, named_values[i].name) != 0)
-			continue;
-		*val = named_values[i].val;
-		return 0;
-	}
-
 	return parse_int(str, val, name);
 }
 
-- 
2.49.0



Return-Path: <bpf+bounces-61165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE70AE1A4E
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 13:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A751762F4
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328EC289E21;
	Fri, 20 Jun 2025 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMswgc2F"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1095728A1C5
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750420386; cv=none; b=JFGmj/1MWeUnuAJ/6JVnKZifzOWG6lHj3PH9N7DL4D9DmM2wdXFzdy90swV3PRK6Mx8DMtJvXFMPNeKGyn8UhBZ56XNyK2HO/tml3N1AqPpzxE/Km853ECLR2KdCgcSzLtnZBaAQXXSOMQrMyejwRIuYfWLG+yqgTfrucscIoPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750420386; c=relaxed/simple;
	bh=LlWiUKkekbp0T0mtBepZsiSBkaSbWICtYaIShlQMmUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmhSGyhgfFz7Ot6WQKq/jvZjGC7qTu/4a6OMXYthTVkVAb0lU7sRjYv+l3pb6EI46fD6LD/+MTd6uaaEYoYTbq9MJ8goSyDJNZgve4qv42Fh7LJUK2+5TrovWnP1EWapDyagr0lJ43vjmD4QYnLs9R7xPTTalR3w8vshephLyLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMswgc2F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750420384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tt5sZdH8JCfl5hB/PboqlimFe0U5SStWWoEoZsxBw6s=;
	b=YMswgc2F1rtxt1pcJnY+G/5cV9j6re3LFTSpSFgjWyLCF424C5sMt+uJCHInItnLqVeICj
	o++MkzToBhxzrnW2FwZ02Zti+KM5q1zW/1SqSTC4QXfjqkROqkuGvJDhX4zNFN3vO/M3bB
	RE9OvAEPn89QArnz4RVie/rOBo2/XyQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-e7jXN7uXMQmmZjrbjbg5Sg-1; Fri,
 20 Jun 2025 07:53:01 -0400
X-MC-Unique: e7jXN7uXMQmmZjrbjbg5Sg-1
X-Mimecast-MFC-AGG-ID: e7jXN7uXMQmmZjrbjbg5Sg_1750420380
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE4B61956089;
	Fri, 20 Jun 2025 11:52:59 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.44.34.11])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B611195609D;
	Fri, 20 Jun 2025 11:52:54 +0000 (UTC)
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
Subject: [PATCH bpf-next v6 3/4] selftests/bpf: Allow macros in __retval
Date: Fri, 20 Jun 2025 13:52:30 +0200
Message-ID: <dd801ad04d73082d98defe27a4af82e432b8feab.1750402154.git.vmalik@redhat.com>
In-Reply-To: <cover.1750402154.git.vmalik@redhat.com>
References: <cover.1750402154.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Allow macro expansion for values passed to the `__retval` and
`__retval_unpriv` attributes. This is especially useful for testing
programs which return various error codes.

With this change, the code for parsing special literals can be made
simpler, as the literals are defined via macros. The only exception is
INT_MIN which expands to (-INT_MAX -1), which is not single number and
cannot be parsed by strtol. So, we instead use a prefixed literal
_INT_MIN in __retval and handle it separately (assign the expected
return to INT_MIN). Also, strtol cannot handle the "ll" suffix so change
the value of POINTER_VALUE from 0xcafe4all to 0xbadcafe.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h  | 14 ++++++-----
 .../bpf/progs/verifier_div_overflow.c         |  4 ++--
 tools/testing/selftests/bpf/test_loader.c     | 23 +++++++------------
 3 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index a678463e972c..20dce508d8e0 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -83,9 +83,11 @@
  *                   expect return value to match passed parameter:
  *                   - a decimal number
  *                   - a hexadecimal number, when starts from 0x
- *                   - literal INT_MIN
- *                   - literal POINTER_VALUE (see definition below)
- *                   - literal TEST_DATA_LEN (see definition below)
+ *                   - a macro which expands to one of the above
+ *                   - literal _INT_MIN (expands to INT_MIN)
+ *                   In addition, two special macros are defined below:
+ *                   - POINTER_VALUE
+ *                   - TEST_DATA_LEN
  * __retval_unpriv   Same, but load program in unprivileged mode.
  *
  * __description     Text to be used instead of a program name for display
@@ -125,8 +127,8 @@
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
@@ -155,7 +157,7 @@
 #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
 
 /* Magic constants used with __retval() */
-#define POINTER_VALUE	0xcafe4all
+#define POINTER_VALUE	0xbadcafe
 #define TEST_DATA_LEN	64
 
 #ifndef __used
diff --git a/tools/testing/selftests/bpf/progs/verifier_div_overflow.c b/tools/testing/selftests/bpf/progs/verifier_div_overflow.c
index 458984da804c..34e0c012ee76 100644
--- a/tools/testing/selftests/bpf/progs/verifier_div_overflow.c
+++ b/tools/testing/selftests/bpf/progs/verifier_div_overflow.c
@@ -77,7 +77,7 @@ l0_%=:	exit;						\
 
 SEC("tc")
 __description("MOD32 overflow, check 1")
-__success __retval(INT_MIN)
+__success __retval(_INT_MIN)
 __naked void mod32_overflow_check_1(void)
 {
 	asm volatile ("					\
@@ -92,7 +92,7 @@ __naked void mod32_overflow_check_1(void)
 
 SEC("tc")
 __description("MOD32 overflow, check 2")
-__success __retval(INT_MIN)
+__success __retval(_INT_MIN)
 __naked void mod32_overflow_check_2(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 2c7e9729d5fe..d300326476f6 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -40,7 +40,7 @@
 #define TEST_TAG_LOAD_MODE_PFX "comment:load_mode="
 
 /* Warning: duplicated in bpf_misc.h */
-#define POINTER_VALUE	0xcafe4all
+#define POINTER_VALUE	0xbadcafe
 #define TEST_DATA_LEN	64
 
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
@@ -318,20 +318,13 @@ static int parse_caps(const char *str, __u64 *val, const char *name)
 
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
+	/* INT_MIN is defined as (-INT_MAX -1), i.e. it doesn't expand to a
+	 * single int and cannot be parsed with strtol, so we handle it
+	 * separately here. In addition, it expands to different expressions in
+	 * different compilers so we use a prefixed _INT_MIN instead.
+	 */
+	if (strcmp(str, "_INT_MIN") == 0) {
+		*val = INT_MIN;
 		return 0;
 	}
 
-- 
2.49.0



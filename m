Return-Path: <bpf+bounces-33024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF3C915EE9
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 08:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB591F2238E
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 06:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8919145FF8;
	Tue, 25 Jun 2024 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYRMVV3F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2192BCF6
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296961; cv=none; b=F97HJrwc0AEgNZhgRzoWIDlDgBojloJCaBTEZdsQb4Gxm1BLb7mD/WtdC5NNGPicEu86JHkegjk1OucYNiWxrM4PzcX2I6Jqu2quYpQRIesmHgm89aVvjVWT18DD0cV+VBWjw8+jPDf84yzrXnUn/Ox7nBetfTEVOvaW6+WpjKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296961; c=relaxed/simple;
	bh=Jfs2JRcJ6j/9WsK5ubGRkxDpeWQ+rygdKYQ8igFte9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TPnhVT9jx10Ph2IHN6bwmowu8FHHUCR+ywZImRfF3oNLV7gnGTCvzK6Xf3xy0yqnvVdxszq/twG4T5jyfda1HIOU+hgBqqhLFt/8ConhV0QR2VaJvEy4oV6wEye2JxD0R35Q1ZoIM6idHYWf+8T75cuM36okpK1kHJvPK6XCf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYRMVV3F; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a7253454b3fso86029266b.1
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 23:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719296958; x=1719901758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IhzvtxnwxPw4271b1gCpWFIWj+aKqebJIr/9+MigdzA=;
        b=eYRMVV3FuJQ/oXal5pQDVvHn2ZvvB9EN3bWHOFfxOlsegFT5AB17wOWwQmimR+4ig7
         +4NsbPx8xzZRCo4HbZIRGrsiW8/BWjfQjGhCdXGxvRJ3v5Kq6L3PiDksUNr0rI0AHITE
         JzU1Kb9kB2ou3nO6i5bHC7II3CcQMTlSyd+abk8r4Mlk6JgsKLUv5amGDxNl/y1dVevu
         v58JZMkRks9V6iseywSH4zSjp0xBA1Hc0kFx/sDAVB/gyHEgnlqcz7U7Ayu5v0KT/TeK
         muHy5I8Ai3z2QYkNxIr2gOC2CMEhl8oXiGrm6mFwM1HssJpWoDqOPpboLZCyX2zb1OW4
         xkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719296958; x=1719901758;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IhzvtxnwxPw4271b1gCpWFIWj+aKqebJIr/9+MigdzA=;
        b=TG4VI5q5niptXERUjJMdqAfX4KMenAHCGJagzY6XWDP0kDUSSb+S9K+nxPzNFAqls9
         pjRstNbAsJkznXHKqan2DjsccvtQulubbiroaye/SxKzbAL7IydgsrbYESmFiC5Wvzdo
         YQTKLZ3DKCAsX1QPc33WsCqbWadzvLeAPfXWmd0NcA6ZmYsLjm97YGGUa8d1amhVcBpH
         Xes7icxD8wn1p12TFBFbcI4x3gfk7FAoQCsKhlV9IZ7ntj8n5yJQVs9YXxnHTNmEZvhn
         1K2BHWD2c7pyRYrjgl6rnsJJQW4OblL/GlAgwyNsijSo6wYoQ28wFrWJJOH+be+/KSXE
         4TTA==
X-Gm-Message-State: AOJu0YxQAK8OQ6bH9Mv5J2aMh1eKw85nrZPKiiP9PwYR/yEJ9qDYBF6f
	2OMdU3PI5RFM9GYeTWI35vkRyVgogj181wCZvUyfYRO3zigTMjH1le38kH6EnMjfIpERKhv4nvC
	oyIaD+yx0IIorLwZkWEcxvNtn1tZfJkYJm2KuVAR0UdESppZ8KdAXeWKnJYepQxMPTue0Cx+uPG
	KfcKoqGm4TjRfPmWtW7IJzZscUC4WofP5O7E+EFWPTosR/3Z25XFpIe5fTNSYOqE+kVw==
X-Google-Smtp-Source: AGHT+IGxuF3gFRGSlozkGQ1lvMP8mXk+U8avwao/n00ZnS8zaAuaHROYwAinlMHYwForemr3tI9tH8ESRV/sMtHipD8O
X-Received: from mattbobrowski.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:c5c])
 (user=mattbobrowski job=sendgmr) by 2002:a17:906:5849:b0:a6f:bae8:f84d with
 SMTP id a640c23a62f3a-a7245c7217cmr620566b.8.1719296957811; Mon, 24 Jun 2024
 23:29:17 -0700 (PDT)
Date: Tue, 25 Jun 2024 06:28:57 +0000
In-Reply-To: <20240625062857.92760-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625062857.92760-1-mattbobrowski@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625062857.92760-2-mattbobrowski@google.com>
Subject: [PATCH v2 bpf 2/2] bpf: add new negative selftests to cover missing
 check_func_arg_reg_off() and reg->type check
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, 
	eddyz87@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Add new negative selftests which are intended to cover the
out-of-bounds memory access that could be performed on a
CONST_PTR_TO_DYNPTR within functions taking a ARG_PTR_TO_DYNPTR |
MEM_RDONLY as an argument, and acceptance of invalid register types
i.e. PTR_TO_BTF_ID within functions taking a ARG_PTR_TO_DYNPTR |
MEM_RDONLY.

Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 24 +++++++++++++++++++
 .../bpf/progs/test_kfunc_dynptr_param.c       |  2 +-
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 22 +++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 66a60bfb5867..ed4bba02c861 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1686,3 +1686,27 @@ int test_dynptr_skb_small_buff(struct __sk_buff *skb)
 
 	return !!data;
 }
+
+__noinline long global_call_bpf_dynptr(const struct bpf_dynptr *dynptr)
+{
+	long ret = 0;
+	/* Avoid leaving this global function empty to avoid having the compiler
+	 * optimize away the call to this global function.
+	 */
+	__sink(ret);
+	return ret;
+}
+
+SEC("?raw_tp")
+__failure __msg("arg#1 expected pointer to stack or const struct bpf_dynptr")
+int test_dynptr_reg_type(void *ctx)
+{
+	struct task_struct *current = NULL;
+	/* R1 should be holding a PTR_TO_BTF_ID, so this shouldn't be a
+	 * reg->type that can be passed to a function accepting a
+	 * ARG_PTR_TO_DYNPTR | MEM_RDONLY. process_dynptr_func() should catch
+	 * this.
+	 */
+	global_call_bpf_dynptr((const struct bpf_dynptr *)current);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
index 2dde8e3fe4c9..e68667aec6a6 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -45,7 +45,7 @@ int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size)
 }
 
 SEC("?lsm.s/bpf")
-__failure __msg("arg#0 expected pointer to stack or dynptr_ptr")
+__failure __msg("arg#1 expected pointer to stack or const struct bpf_dynptr")
 int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size)
 {
 	unsigned long val = 0;
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
index 11ab25c42c36..54de0389f878 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
@@ -221,3 +221,25 @@ int user_ringbuf_callback_reinit_dynptr_ringbuf(void *ctx)
 	bpf_user_ringbuf_drain(&user_ringbuf, try_reinit_dynptr_ringbuf, NULL, 0);
 	return 0;
 }
+
+__noinline long global_call_bpf_dynptr_data(struct bpf_dynptr *dynptr)
+{
+	bpf_dynptr_data(dynptr, 0xA, 0xA);
+	return 0;
+}
+
+static long callback_adjust_bpf_dynptr_reg_off(struct bpf_dynptr *dynptr,
+					       void *ctx)
+{
+	global_call_bpf_dynptr_data(dynptr += 1024);
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("dereference of modified dynptr_ptr ptr R1 off=16384 disallowed")
+int user_ringbuf_callback_const_ptr_to_dynptr_reg_off(void *ctx)
+{
+	bpf_user_ringbuf_drain(&user_ringbuf,
+			       callback_adjust_bpf_dynptr_reg_off, NULL, 0);
+	return 0;
+}
-- 
2.45.2.741.gdbec12cfda-goog



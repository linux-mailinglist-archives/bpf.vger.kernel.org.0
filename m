Return-Path: <bpf+bounces-29428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13938C1BF0
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 03:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2601F2271F
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 01:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B1313AA32;
	Fri, 10 May 2024 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfOhWBoL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465AE13AA53
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715303606; cv=none; b=E9iy/Oymn9B4hxRUB3ObaFDk5vwMQrit+evkbIE3gd2SNHWLPM6+1oHRbCdeIfvUhI+vBwUXqQ1waNDtp6xL58X1E5Mlqff5bTffHtAMiAOS4afZpT+wY45xpki1L456Zp74l5hSiEcG8x+fcLXgHmbg3PE0VynoYkttiEbo+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715303606; c=relaxed/simple;
	bh=T99aEuo7lB5fd7ns1ZsNRt0u99NUChuBc++AQ35NEN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BvZ+8M1shL3D+N7MloCtbBFuHpsQQE+3VjQuq+SLYzGDWI1/MZwvRloTLdxA8mJ3wv1frpPd3KSZE39K7GWYaFLxuoQbyA6Zf5BIIFT2CG0U6f5eG/iVXEdIWxI26lIN+pg0/gcRVFUTW9tQqDA936Wv1fsszf+1yxvcvBTnMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfOhWBoL; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f040769fd3so965831a34.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 18:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715303604; x=1715908404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cZSvfqk5wcnoVZE269hw105nH6/qA5LuJG4//0qzg8=;
        b=QfOhWBoLElOppsr3M2LIsYqJcr0TLkvf56kEVGYFD+Nti+5eNntE9uata+prbaCbcy
         Lih3/OIdP+qyTxK1E3nLO8xB393ErmYGMAFlzDUUQH+nCZ86gKtPiPNNpntskuBZ/78u
         a9FBlkTDU8Uf1kD/qpgp3ofXZMQAPGsmuKKl+/Pdzj3mmTzvMxVnu9DZtWsfN39PPvoA
         1ZuFxKUFE+0nMRi0yaDLSIY+0PzvYlsd8FMYdMx6PvXOLZXeG5e5qqoQm60lnmj1Kwnh
         Uqq3rmaknnPf+ncm4lnzGTjsmfpUJlfm9nXx0qif24uxa76aUAs3HOB28E/QPALWSk6G
         Fl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715303604; x=1715908404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cZSvfqk5wcnoVZE269hw105nH6/qA5LuJG4//0qzg8=;
        b=prQjAkSHOiaRTFZT5+OTVHd0XgqDq2ynupS8plVOSHDZv9OWQ3YvR/6X1P+3HX4TBG
         OuWZZ9OP8OqBcNWIP+Z+amK+uwnQEwjFAyQtFPm5ncGvznOor5eHJmqTwVWcpkRZzaQ+
         PUsmJmmGPF/aGWcwXssnCk0dOAOQXc3a5Y0nxrHu444GB+xmypdpmVLGs0svcYN+/Rzu
         UdduageyxQFzWM2nOOICiQZczSa2U4ShNvJPSCG52sW2nQJ6ukRP6hiWVv63J85ObwAi
         IMnipXFD5YBIHAFgXaQ8JYT3m+F61TqojZ7VjiqjQei9ciecMuJqqENCW9d2s/K1k2w8
         um7A==
X-Gm-Message-State: AOJu0YxmGZjlIH2ncPQOShEQfqAc0dZimZkVjbDygKnIe8+X7bTzi3Bk
	L6pU8S0k1NCsLi9+AdQZ9x3MM7jBDj+y9PcSspB4K9fCcALc4p/AOA4XAw==
X-Google-Smtp-Source: AGHT+IH8Yaj1t35h08RLcLTqNc1yIy7I1uKklObc6yYpn9bDZIkr3wGaZZ137t1fuVPqwJISsKhWYQ==
X-Received: by 2002:a9d:4d12:0:b0:6f0:3677:8b9e with SMTP id 46e09a7af769-6f0e92ce9b5mr1356965a34.37.1715303604266;
        Thu, 09 May 2024 18:13:24 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e01a8b23sm476874a34.6.2024.05.09.18.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 18:13:23 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v5 9/9] selftests/bpf: Test global bpf_list_head arrays.
Date: Thu,  9 May 2024 18:13:12 -0700
Message-Id: <20240510011312.1488046-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510011312.1488046-1-thinker.li@gmail.com>
References: <20240510011312.1488046-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure global arrays of bpf_list_heads and fields of bpf_list_heads in
nested struct types work correctly.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/prog_tests/linked_list.c    | 12 ++++++
 .../testing/selftests/bpf/progs/linked_list.c | 42 +++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 2fb89de63bd2..77d07e0a4a55 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -183,6 +183,18 @@ static void test_linked_list_success(int mode, bool leave_in_map)
 	if (!leave_in_map)
 		clear_fields(skel->maps.bss_A);
 
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop_nested), &opts);
+	ASSERT_OK(ret, "global_list_push_pop_nested");
+	ASSERT_OK(opts.retval, "global_list_push_pop_nested retval");
+	if (!leave_in_map)
+		clear_fields(skel->maps.bss_A);
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_array_push_pop), &opts);
+	ASSERT_OK(ret, "global_list_array_push_pop");
+	ASSERT_OK(opts.retval, "global_list_array_push_pop retval");
+	if (!leave_in_map)
+		clear_fields(skel->maps.bss_A);
+
 	if (mode == PUSH_POP)
 		goto end;
 
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
index 26205ca80679..f69bf3e30321 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -11,6 +11,22 @@
 
 #include "linked_list.h"
 
+struct head_nested_inner {
+	struct bpf_spin_lock lock;
+	struct bpf_list_head head __contains(foo, node2);
+};
+
+struct head_nested {
+	int dummy;
+	struct head_nested_inner inner;
+};
+
+private(C) struct bpf_spin_lock glock_c;
+private(C) struct bpf_list_head ghead_array[2] __contains(foo, node2);
+private(C) struct bpf_list_head ghead_array_one[1] __contains(foo, node2);
+
+private(D) struct head_nested ghead_nested;
+
 static __always_inline
 int list_push_pop(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool leave_in_map)
 {
@@ -309,6 +325,32 @@ int global_list_push_pop(void *ctx)
 	return test_list_push_pop(&glock, &ghead);
 }
 
+SEC("tc")
+int global_list_push_pop_nested(void *ctx)
+{
+	return test_list_push_pop(&ghead_nested.inner.lock, &ghead_nested.inner.head);
+}
+
+SEC("tc")
+int global_list_array_push_pop(void *ctx)
+{
+	int r;
+
+	r = test_list_push_pop(&glock_c, &ghead_array[0]);
+	if (r)
+		return r;
+
+	r = test_list_push_pop(&glock_c, &ghead_array[1]);
+	if (r)
+		return r;
+
+	/* Arrays with only one element is a special case, being treated
+	 * just like a bpf_list_head variable by the verifier, not an
+	 * array.
+	 */
+	return test_list_push_pop(&glock_c, &ghead_array_one[0]);
+}
+
 SEC("tc")
 int map_list_push_pop_multiple(void *ctx)
 {
-- 
2.34.1



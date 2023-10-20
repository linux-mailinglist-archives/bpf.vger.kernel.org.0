Return-Path: <bpf+bounces-12837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 040517D11CB
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 16:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AF41F2422C
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D521A27C;
	Fri, 20 Oct 2023 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6ZddTYb"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D118E37
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 14:48:44 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E4C106
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 07:48:43 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso143837366b.1
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697813321; x=1698418121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LMitdlL0PE5FK6dy5YsEIZGv6PZqNfSHEO3MRBhQ84k=;
        b=Y6ZddTYbhLbJd6D4nCUF2wzruIbxY/vpZ4sH68WG/w9JtXNUPIJi4ROlYZOJ9+S4YA
         E1qsGa6Eb3ehGdalSdTTrxTCoWJ4FTWscPlsvoFBgH1RhHWF1bBj540R4uNxhdtrIO5j
         JVNnwvnZfLGDcrjPtA/Cd+oWuzio1lKpKQ5hBLb6cPHhhGw8Dho74nr8OISivj1ndpFB
         JEE1CAqjGv64TTywD9QMA4isQd8PKvvFpC3UyvufEMr5GLG6Qa48Uek50pK3j8JQWCyV
         9toe6hnY6UPeXnDPYFdiP0c9J9/iJL+bBSgFXEOKpJ9V8YzIvGWIgl3ZAr0S/ZyPTGJn
         c+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697813321; x=1698418121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LMitdlL0PE5FK6dy5YsEIZGv6PZqNfSHEO3MRBhQ84k=;
        b=c5+BXWzVzbGADLOEVX+YhzJiVKwGFJtLuzGDjFyTnwZ2X48fpGCXNUan1qLizqDG/U
         avWeKq+8W1P/VlrqkN23MUQf2pWwoDm+HqMbHsNVWqsMUU87aTgFn/uzaq8X9i/Sf6YJ
         NGU9l6hJohei5q82TqwOoi3anUpgVfzPIhwCAZ3HVw0WmpwUdEAphTbFT7DLR24c8Ndo
         mIgczNDQRzmvj3KZXv/toraJofC45a/m6ZLDZf/6F0X2yRShTI8S8JP9W247BebaaP3p
         WumHywqulhhf7CpDNOR/esnt5uzL1B8tj6RdAuEPaq+V/Qodh8gyNuqIZ+K5xH5Hzb37
         7+FQ==
X-Gm-Message-State: AOJu0YzbyiC++fiMgYQAObVMozE2TtTygnrdOeSVEKepkuPfj++76M+a
	duGALs9yD6INLi1jnPR81D1bZtn8CGWqAWvJ
X-Google-Smtp-Source: AGHT+IE0GVg7C1XpE1q4TGu1iiFkAmPxZrFyqDMJv+V1TvS9CZcCMlhBm8jMbfYJGCasUIs9Jq/UEg==
X-Received: by 2002:a17:907:9623:b0:9ae:6da8:1819 with SMTP id gb35-20020a170907962300b009ae6da81819mr1432985ejc.48.1697813321349;
        Fri, 20 Oct 2023 07:48:41 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id kf14-20020a17090776ce00b0099bd7b26639sm1650555ejc.6.2023.10.20.07.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 07:48:40 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Make linked_list failure test more robust
Date: Fri, 20 Oct 2023 14:48:39 +0000
Message-Id: <20231020144839.2734006-1-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linked list failure test 'pop_front_off' and 'pop_back_off'
currently rely on matching exact instruction and register values.  The
purpose of the test is to ensure the offset is correctly incremented for
the returned pointers from list pop helpers, which can then be used with
container_of to obtain the real object. Hence, somehow obtaining the
information that the offset is 48 will work for us. Make the test more
robust by relying on verifier error string of bpf_spin_lock and remove
dependence on fragile instruction index or register number, which can be
affected by different clang versions used to build the selftests.

Fixes: 300f19dcdb99 ("selftests/bpf: Add BPF linked list API tests")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/linked_list.c | 10 ++--------
 tools/testing/selftests/bpf/progs/linked_list_fail.c |  4 +++-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 69dc31383b78..2fb89de63bd2 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -94,14 +94,8 @@ static struct {
 	{ "incorrect_head_var_off2", "variable ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
 	{ "incorrect_head_off1", "bpf_list_head not found at offset=25" },
 	{ "incorrect_head_off2", "bpf_list_head not found at offset=1" },
-	{ "pop_front_off",
-	  "15: (bf) r1 = r6                      ; R1_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=48,imm=0) "
-	  "R6_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=48,imm=0) refs=2,4\n"
-	  "16: (85) call bpf_this_cpu_ptr#154\nR1 type=ptr_or_null_ expected=percpu_ptr_" },
-	{ "pop_back_off",
-	  "15: (bf) r1 = r6                      ; R1_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=48,imm=0) "
-	  "R6_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=48,imm=0) refs=2,4\n"
-	  "16: (85) call bpf_this_cpu_ptr#154\nR1 type=ptr_or_null_ expected=percpu_ptr_" },
+	{ "pop_front_off", "off 48 doesn't point to 'struct bpf_spin_lock' that is at 40" },
+	{ "pop_back_off", "off 48 doesn't point to 'struct bpf_spin_lock' that is at 40" },
 };

 static void test_linked_list_fail_prog(const char *prog_name, const char *err_msg)
diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools/testing/selftests/bpf/progs/linked_list_fail.c
index f4c63daba229..6438982b928b 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
@@ -591,7 +591,9 @@ int pop_ptr_off(void *(*op)(void *head))
 	n = op(&p->head);
 	bpf_spin_unlock(&p->lock);

-	bpf_this_cpu_ptr(n);
+	if (!n)
+		return 0;
+	bpf_spin_lock((void *)n);
 	return 0;
 }

--
2.40.1



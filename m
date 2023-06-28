Return-Path: <bpf+bounces-3649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B58741069
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 13:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396531C20818
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264E7BE69;
	Wed, 28 Jun 2023 11:52:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F4DBE4B
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 11:52:11 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851D51BD4
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 04:52:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b80512a7f2so22335365ad.3
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 04:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953130; x=1690545130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MenM5RhfOSkTkIi9MjbCzp+y8rVjV2v6pS6jO1takAk=;
        b=Zz29Zuh+o2TjQ2Q1YNnJYg0twjdUiwst1HntdeLD8bhbO9RwRYF9FdYHJavvIoz6CT
         NEqdFCN/qzsWGrw1bvoWOxe7aDIjLrZ8Rosx2XCJJOfOHung/wYIEb0A6VZvxQ2YZHsY
         hK5iv8qdziTcoVaGOh0mvyZxYSIoT8+M8TZ1dRYxWUL0QUa/qLLk6FQASRSPFNKf1/tl
         Vl2WwmAhLyZEnU1kFnCs/LIRCWrRS5/Baxpze+MkApdePjR49zqURjDnq33NYqbY5a5E
         8GJyhs4B3C0jageQHxwXDfdJ/obFotiRRoruHh0AHnMFgRCxX/D9YiJjnWL7fWxR9QfK
         oJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953130; x=1690545130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MenM5RhfOSkTkIi9MjbCzp+y8rVjV2v6pS6jO1takAk=;
        b=kgLWzCfj19L0UdfsIR1PgZzLNKcg/Bzpml2nYQJYS1gr4rZx9Ofg1IAhjHbR2bfGck
         oxEdUhInun1vyXeG+pgtDfJTOYcFiW5IJbZYcq2FAQwGb2XBGGynIqymN3SAEngxfeWQ
         SUYS4fJTC4ywjQO+78aNFsDGKBIbIubhzDb7wQMTZMOMn+s9VC/cICz36tAPP0QCB4/N
         Tp55Y9Pf+KEDJ9bnJjn26STi14jbktknykKQVoKHBStLylxrOrwXqg3t2H45tBGa69zD
         oUIDgHoWsR1IajjXhIyC6vP874R+01IsqtA1fBhjnsZgTEMDh8QP59sVN77f5DOLLq4z
         m+hg==
X-Gm-Message-State: AC+VfDzOK9tXuJlfJeuK5ZCNGov1O30C52x4iJUKN4oczZ2fhJCfwehF
	pQj8QqEifZLQxt2M/a2Cecg=
X-Google-Smtp-Source: ACHHUZ7rH45Q98m1xv1Jy8odbxqS0mQvSK8nM59eQWQCyYL1jgCZtgIuKAS6n1iqv1VVVQ9VM55gSQ==
X-Received: by 2002:a17:902:a715:b0:1b8:1687:b53 with SMTP id w21-20020a170902a71500b001b816870b53mr4723872plq.26.1687953129968;
        Wed, 28 Jun 2023 04:52:09 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b79:5400:4ff:fe7d:3e26])
        by smtp.gmail.com with ESMTPSA id jf5-20020a170903268500b001b7eeffbdbfsm6607133plb.261.2023.06.28.04.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:52:09 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Fix an error around PTR_UNTRUSTED
Date: Wed, 28 Jun 2023 11:52:04 +0000
Message-Id: <20230628115205.248395-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230628115205.248395-1-laoar.shao@gmail.com>
References: <20230628115205.248395-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Per discussion with Alexei, the PTR_UNTRUSTED flag should not been
cleared when we start to walk a new struct, because the struct in
question may be a struct nested in a union. We should also check and set
this flag before we walk its each member, in case itself is a union.

Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/btf.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 29fe21099298..e0a493230727 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6133,7 +6133,6 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 	const char *tname, *mname, *tag_value;
 	u32 vlen, elem_id, mid;
 
-	*flag = 0;
 again:
 	tname = __btf_name_by_offset(btf, t->name_off);
 	if (!btf_type_is_struct(t)) {
@@ -6142,6 +6141,14 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 	}
 
 	vlen = btf_type_vlen(t);
+	if (BTF_INFO_KIND(t->info) == BTF_KIND_UNION && vlen != 1)
+		/*
+		 * walking unions yields untrusted pointers
+		 * with exception of __bpf_md_ptr and other
+		 * unions with a single member
+		 */
+		*flag |= PTR_UNTRUSTED;
+
 	if (off + size > t->size) {
 		/* If the last element is a variable size array, we may
 		 * need to relax the rule.
@@ -6302,15 +6309,6 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		 * of this field or inside of this struct
 		 */
 		if (btf_type_is_struct(mtype)) {
-			if (BTF_INFO_KIND(mtype->info) == BTF_KIND_UNION &&
-			    btf_type_vlen(mtype) != 1)
-				/*
-				 * walking unions yields untrusted pointers
-				 * with exception of __bpf_md_ptr and other
-				 * unions with a single member
-				 */
-				*flag |= PTR_UNTRUSTED;
-
 			/* our field must be inside that union or struct */
 			t = mtype;
 
@@ -6476,7 +6474,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *log,
 			  bool strict)
 {
 	const struct btf_type *type;
-	enum bpf_type_flag flag;
+	enum bpf_type_flag flag = 0;
 	int err;
 
 	/* Are we already done? */
-- 
2.39.3



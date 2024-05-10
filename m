Return-Path: <bpf+bounces-29529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565DE8C2A8E
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E891F236A0
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1580052F6F;
	Fri, 10 May 2024 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGqzDaqz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBEA5101A;
	Fri, 10 May 2024 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369063; cv=none; b=DU081i9VafDQ6pPKh2o5BirEKzQ9cwsyLMlyjxfXoih1PgFvyW+FLxlo/nJuPT37SD1Ll4bHz6mjaaT5ViFNPQ3A1HmQvcw7cBRrA+UQXTvJ5xVzVPekQMWbpOrg+Q9wopOGxSllxmkqGK4JpDfQ/m6xWcRAf8WD2UVeoNJ8PAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369063; c=relaxed/simple;
	bh=LeBqbzZw3U0iZrWXjjzjdcbkZuvBR+k7Yi2U/7a0FQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tLPXAddMMneW3Kg3flVEFqKHpvoNoshipOsEvyBURgVelRJPhjys5hadaXnlPHAXr2fYHSYcZUrinj8YNNk8R03wk5RYSQH56GNEjnyoc1pZQ7cbUWCzrzfJPeW+7OMmkx3oeVC0H9zLLvtbohG9o2LoANC7fC36ydK1/2erE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGqzDaqz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43dfcbc4893so7533351cf.2;
        Fri, 10 May 2024 12:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369061; x=1715973861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBGyuSo6Z3xNghSqlZ8Vpcr9iM+DD2u0q7FNLP4Iug4=;
        b=RGqzDaqzfki62ABdGBPI3eLANwr61/VG8Z8Nc5C1aPq3T9TVbJsXOeT9qktPE10g6f
         I0MLlyZaMvz7mQgLGJ6XIm9xv9G/uEFUfMcDcyL1PCu42VzotEd8G8eJv7CrJUSOmb1x
         TPwn/3rQ+e5jgsKDZlficQVF7e6cDOZiVpwpNm6+RisDMjlcZCFAwTmoXpXNkxOkXAJO
         t6qLg4ohHRSRks1M5l5TZPHyTGxz9u3nDwth4okYn5J+METk0Wmn4Myf1IJrXBJ2Wfq3
         bqfWfwgoiLljrzr8kdMv1xuKETAxdkaVppWNURLRWA8Y4LHkAYXNpaxX6ExVbNri8wQf
         F2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369061; x=1715973861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBGyuSo6Z3xNghSqlZ8Vpcr9iM+DD2u0q7FNLP4Iug4=;
        b=gCOvCZQUiGW+4Rix74hcnlPKWSkqg1BWs5H0pcjh3TR+g6MK8yikBsDDqpMrKtNkIi
         /JtI5m2c/aO/yvcfw3e3AJbKD37boaxmsDm+ac7hWeS19TQ597XzHjXy2SJn73KoHOk0
         Owxvwjs2FHE4PZJqKrGcQw195kytMoSzOdeuPDBd/8YY2iFANyLcsgXfWqZ6LdohL3RR
         GPgIKqv5wpY/Xwco1ZOhdCZ8x9a1MI8tqJxBejtynZSYzY/k9Kglu5+MTy7xfipyeV1i
         Ri0nrRK2wCpo+QX/RHHEs4GZHSe91ocI2XsARZkS9GT742KZKHEo314QCEEJuQPOGioo
         bZHQ==
X-Gm-Message-State: AOJu0YxQ+W0Sw+OwtT4Qmk9qp18O3R2cn/ErnHzUQ5o3uRJng8RO+USd
	BthpKTAGVT5llkzIjMdcL2eymYiq1rki7G4fYhpB9s/MhBc+BAWhk6rwBw==
X-Google-Smtp-Source: AGHT+IE0oa2Da+xPsupq02++/jgXnqa3Pf33AC8D1GF4Fk7EhmExrwo1QS4AXXqaZvrIyFsEF0KQ7A==
X-Received: by 2002:ac8:7fd3:0:b0:43a:db0c:e7f0 with SMTP id d75a77b69052e-43dfdb6e62fmr37471621cf.29.1715369061044;
        Fri, 10 May 2024 12:24:21 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:20 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 12/20] selftests/bpf: Modify linked_list tests to work with macro-ified removes
Date: Fri, 10 May 2024 19:24:04 +0000
Message-Id: <20240510192412.3297104-13-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510192412.3297104-1-amery.hung@bytedance.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since a hidden arguement is added to bpf list remove kfuncs, and
bpf_list_pop_back/front are macrofied, we modify selftests so that it can
be compiled.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/progs/linked_list_fail.c      | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools/testing/selftests/bpf/progs/linked_list_fail.c
index 5f8063ecc448..d260f80ea64d 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
@@ -49,8 +49,7 @@
 	int test##_missing_lock_##op(void *ctx)             \
 	{                                                   \
 		INIT;                                       \
-		void (*p)(void *) = (void *)&bpf_list_##op; \
-		p(hexpr);                                   \
+		bpf_list_##op(hexpr);                       \
 		return 0;                                   \
 	}
 
@@ -96,9 +95,8 @@ CHECK(inner_map, push_back, &iv->head, &f->node2);
 	int test##_incorrect_lock_##op(void *ctx)           \
 	{                                                   \
 		INIT;                                       \
-		void (*p)(void *) = (void *)&bpf_list_##op; \
 		bpf_spin_lock(lexpr);                       \
-		p(hexpr);                                   \
+		bpf_list_##op(hexpr);                       \
 		return 0;                                   \
 	}
 
@@ -576,7 +574,7 @@ int incorrect_head_off2(void *ctx)
 }
 
 static __always_inline
-int pop_ptr_off(void *(*op)(void *head))
+int pop_ptr_off(bool pop_front)
 {
 	struct {
 		struct bpf_list_head head __contains(foo, node2);
@@ -588,7 +586,10 @@ int pop_ptr_off(void *(*op)(void *head))
 	if (!p)
 		return 0;
 	bpf_spin_lock(&p->lock);
-	n = op(&p->head);
+	if (pop_front)
+		n = bpf_list_pop_front(&p->head);
+	else
+		n = bpf_list_pop_back(&p->head);
 	bpf_spin_unlock(&p->lock);
 
 	if (!n)
@@ -600,13 +601,13 @@ int pop_ptr_off(void *(*op)(void *head))
 SEC("?tc")
 int pop_front_off(void *ctx)
 {
-	return pop_ptr_off((void *)bpf_list_pop_front);
+	return pop_ptr_off(true);
 }
 
 SEC("?tc")
 int pop_back_off(void *ctx)
 {
-	return pop_ptr_off((void *)bpf_list_pop_back);
+	return pop_ptr_off(false);
 }
 
 SEC("?tc")
-- 
2.20.1



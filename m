Return-Path: <bpf+bounces-36743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A61894C7CD
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 02:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F2B1F23C2F
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 00:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A052BBE5E;
	Fri,  9 Aug 2024 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMJs5U76"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EDC79F5
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723164710; cv=none; b=SR6vznRxjbTLJ8/Sj4L98GH50aHtzHK0mbetYGEU6iI/kW7VLrBeImKRyed8rAuXlrDU/G4x5+Hh3p23xJSLIL3RNJAI4A0dozYvIiFGkIpYmTR/5KVmgcO9EGn1YnuUA73N3ZlV5VQ7BEmsafSpMxR5ZMBkGpXIwZpjCyhUINM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723164710; c=relaxed/simple;
	bh=M5Eo2vDfQ+2Pl4OGJh+k5AzK/n7vl/1e/IUpR4QMsXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QUZ5H8/s1141odt2ih9DNiAw7Vrj1+HBp5hM/JQ2Et9XukiAtSK/85+Gw6r6agHjgIW0vQOGsCEVIyfhcYiDtsNnWd/WJ+YOlNy4AkKB4c+4LYaUBw86KNAjPX5eX6GEub8XMJSyAGp9L9UGnyikfWB3Jm/iSY/2ZdCQVBrKtvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMJs5U76; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b796667348so13181716d6.0
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 17:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723164707; x=1723769507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWExKpUbRtRNFkWQNseA9PZIgXxrgTns6/2vb+pRNB4=;
        b=QMJs5U76plPg71uVFbf30oj8Wko/QnS6ljBOHS67EtrI07dlJLG59bFVK7YUqYrp4/
         gWGAT7oSmu/DkynFNDb4VWV4d7NaCZge9KiyWMIhXPfbF/JO8WcUl+Id95qB9GmUUnCk
         FIZo9Co0HP5RxoHXtX9YhR5UlB5x2sfzVNzXJSoV4tb7UmPBtHpzQpCBvwm3jTnSmcY5
         KOIXABKsVSI9ziczwkWhWtsV/A0lQzCRRrrsNGSfih1ofEuI+V/wiiacdPJaJ/msE/Sv
         S/8HgbSKGcq+X0K9vTkLJSjgGpl/HtrxBsI8FsGDLRCkOZt2DWeYCTeQfZOeyhkq7mrp
         X/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723164707; x=1723769507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWExKpUbRtRNFkWQNseA9PZIgXxrgTns6/2vb+pRNB4=;
        b=S0giMEZiAWhpedMEqcA4ay7dPrBjktcEeV++K+RAEUSfjZJR65WC28vRJPlvOdB7bs
         c4sUMgN/fmndbBNYs709LhEDsNsf7+gp2sfUCb+AOhN2dIYcvvb/IYgNiW+BZ2vRZGNC
         wdp8Eae14CeCEyyKPNLmuIEoEsf8wD8fhVkKP1bpkLPJZagodg1IIXYUPatY2gpGGacJ
         UiVwgJVUGOTx+7H8fDLR/06xprpyvkbsmuWFuLLcP63jjPvcdNKEtIJnzNSY2Z9G8cmm
         YCkYKKFKqNoe5/ihZoU3aswNor1rYBWubT+wJkbA6fxSce8IMzZjpAHrUUnSHT7PyMmp
         WgFg==
X-Gm-Message-State: AOJu0Yx23DoNPl5p+LDsdnRVADALzuLaq4WUIpkLZGYm4umbDh+L49A7
	g4OvGeBt6m8Q2cHQgEY7rgeD2uM0GgTro2CKIeLbgC5Zo+d75MncWjObpw==
X-Google-Smtp-Source: AGHT+IHiKiq04CdO4vdcNqMmxIpA1b0qWEUTrqgQsRNmYhMidFxy05lC56wnQqIAMpHtr1kIW9PTzA==
X-Received: by 2002:a05:6214:c2e:b0:6b5:2aa3:3a7f with SMTP id 6a1803df08f44-6bd6cb46a5amr64229166d6.20.1723164707397;
        Thu, 08 Aug 2024 17:51:47 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c797dbdsm71485826d6.52.2024.08.08.17.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 17:51:47 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	houtao@huaweicloud.com,
	sinquersw@gmail.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH v3 bpf-next 5/5] selftests/bpf: Test bpf_kptr_xchg stashing into local kptr
Date: Fri,  9 Aug 2024 00:51:31 +0000
Message-Id: <20240809005131.3916464-6-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240809005131.3916464-1-amery.hung@bytedance.com>
References: <20240809005131.3916464-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Marchevsky <davemarchevsky@fb.com>

Test stashing both referenced kptr and local kptr into local kptrs. Then,
test unstashing them.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/progs/local_kptr_stash.c    | 58 ++++++++++++++++++-
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
index 75043ffc5dad..ce7bf7790917 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
@@ -8,9 +8,13 @@
 #include "../bpf_experimental.h"
 #include "../bpf_testmod/bpf_testmod_kfunc.h"
 
+struct plain_local;
+
 struct node_data {
 	long key;
 	long data;
+	struct prog_test_ref_kfunc __kptr *stashed_in_kptr;
+	struct plain_local __kptr *stashed_in_local_kptr;
 	struct bpf_rb_node node;
 };
 
@@ -85,18 +89,52 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 
 static int create_and_stash(int idx, int val)
 {
+	struct prog_test_ref_kfunc *inner_kptr;
+	struct plain_local *inner_local_kptr;
 	struct map_value *mapval;
 	struct node_data *res;
+	unsigned long dummy;
 
 	mapval = bpf_map_lookup_elem(&some_nodes, &idx);
 	if (!mapval)
 		return 1;
 
+	dummy = 0;
+	inner_kptr = bpf_kfunc_call_test_acquire(&dummy);
+	if (!inner_kptr)
+		return 2;
+
+	inner_local_kptr = bpf_obj_new(typeof(*inner_local_kptr));
+	if (!inner_local_kptr) {
+		bpf_kfunc_call_test_release(inner_kptr);
+		return 3;
+	}
+
 	res = bpf_obj_new(typeof(*res));
-	if (!res)
-		return 1;
+	if (!res) {
+		bpf_kfunc_call_test_release(inner_kptr);
+		bpf_obj_drop(inner_local_kptr);
+		return 4;
+	}
 	res->key = val;
 
+	inner_kptr = bpf_kptr_xchg(&res->stashed_in_kptr, inner_kptr);
+	if (inner_kptr) {
+		/* Should never happen, we just obj_new'd res */
+		bpf_kfunc_call_test_release(inner_kptr);
+		bpf_obj_drop(inner_local_kptr);
+		bpf_obj_drop(res);
+		return 5;
+	}
+
+	inner_local_kptr = bpf_kptr_xchg(&res->stashed_in_local_kptr, inner_local_kptr);
+	if (inner_local_kptr) {
+		/* Should never happen, we just obj_new'd res */
+		bpf_obj_drop(inner_local_kptr);
+		bpf_obj_drop(res);
+		return 6;
+	}
+
 	res = bpf_kptr_xchg(&mapval->node, res);
 	if (res)
 		bpf_obj_drop(res);
@@ -169,6 +207,8 @@ long stash_local_with_root(void *ctx)
 SEC("tc")
 long unstash_rb_node(void *ctx)
 {
+	struct prog_test_ref_kfunc *inner_kptr = NULL;
+	struct plain_local *inner_local_kptr = NULL;
 	struct map_value *mapval;
 	struct node_data *res;
 	long retval;
@@ -180,6 +220,20 @@ long unstash_rb_node(void *ctx)
 
 	res = bpf_kptr_xchg(&mapval->node, NULL);
 	if (res) {
+		inner_kptr = bpf_kptr_xchg(&res->stashed_in_kptr, inner_kptr);
+		if (!inner_kptr) {
+			bpf_obj_drop(res);
+			return 1;
+		}
+		bpf_kfunc_call_test_release(inner_kptr);
+
+		inner_local_kptr = bpf_kptr_xchg(&res->stashed_in_local_kptr, inner_local_kptr);
+		if (!inner_local_kptr) {
+			bpf_obj_drop(res);
+			return 1;
+		}
+		bpf_obj_drop(inner_local_kptr);
+
 		retval = res->key;
 		bpf_obj_drop(res);
 		return retval;
-- 
2.20.1



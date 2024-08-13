Return-Path: <bpf+bounces-37109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A632950F21
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 23:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952451C20BB9
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 21:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463171AAE22;
	Tue, 13 Aug 2024 21:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PiDQZrcO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC41A76DD
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 21:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723584276; cv=none; b=EZiqyUx2H6vv+GkdpdyIl1solLs0hRPU1586+G2ka2anDwDE4gMJVCvq4dQwuKtodkW5PJ1yFM6weZ5Pv8Hg/mFakOms1HQavgNgNxSSFXI9Eh4yXCmCVwx+FrbAlPisYrNuHo7pf0q5SEpYZKP+D4lsO2lDiH+/euWhy6zQ9WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723584276; c=relaxed/simple;
	bh=l7cXzz1Fi3bJLPmo/erBU+6IMXHygyE9Oz7+u83z9tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMCMLa3Y1oKwtauUQZWRu+B6mAeoL+8IsiHWxzZZ+ytDduKL/ygrVnbaZCnnTDDmtgMp2bLnd6f7/JF6WPzGw7+i8GgFWmgWCK0p3bPKR0xcK0Y6Mj9jBlB6k+sS166JMOrr/jNj6iQ6HGghW1VIB80liIETAAUTOy5dMO5W4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PiDQZrcO; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso5261565276.0
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723584274; x=1724189074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0j/9W5NoTZNr/s7dgUSvKvFbmQwhYnbQ8NOOXdGYL0=;
        b=PiDQZrcOCq/c9842/0Mb4kfUrUYG73U152xsficWkkpce1x5r804vNp6rtkHObilPc
         /kBpHwfcc8WI4bHvDa7K6mFx+F4lG47Ml2OBYOkWa+TK+R+93nzKwPuubwOlhZG8Im1V
         yNk8pLIhJTaWslmgddoOjT9z0dkoizBfN7k5utBqnwSuPP4gU2beklI8L86bTbXxR/2Z
         VZ0hfqMWJpYYGegmc745vrlJkYtbZs0EcgxPKdXHux1FPoRZNm6qEVC4OlsxKgWFcOZv
         yIdaziGm7IR9HNZvN0Fdnr2GB0eq8HoAXBY05YcdrOBkGx0guUtPI5uDH7mUhhjSg7RD
         z2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723584274; x=1724189074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0j/9W5NoTZNr/s7dgUSvKvFbmQwhYnbQ8NOOXdGYL0=;
        b=J97msIn4OsUSqZCVT3Og47gtOPn5gaK0LeP702i7LMlj/d8e5RZOV4zKytGQNsRKVc
         /eI8HRlw8eLmeTlNk36v4AM24xtyDdzYv9Fu8miqftrK+W22ypMiyOlDfHXNiny2NBGI
         YOOipKQtFTJDVUsIwqWo9rzpxUztYvWGLMVtoRvKaRHSFUEcGa0QEK4/3Y3TU3PMZcCV
         GuleF6/Du1lhJFmZYyV5ZRMv0ihBG1rq+wzF14XlsGLdBwDc2R8KrwFBl+aZQ0KPXTEV
         1bZnNeJ9TQELpvEjlqlZ429fUCy3UfrGL5Fyhzi4QDINrxNDOPNlVTn+gdjziR6umlLF
         Gzcw==
X-Gm-Message-State: AOJu0YztKZ/xphJDSZWmCg6UE9yhMy6eRXChk3MiqkJCictiTbTZ4Gb6
	+qhoPj4ua0gFteg90/MrcooTP7Ib/u3DiCCjeeePT9gTgd3KSJPVnD6YuzpVMZNNZUoQJdS6af3
	RBCk=
X-Google-Smtp-Source: AGHT+IGfEhTfnqg1fyGB1/YFtby+56d7HbRJkeg0IJY7ajTxiQvvsK3UkvbjRYwk+Vd9aOVobUTp9g==
X-Received: by 2002:a05:6902:e10:b0:e0b:d7da:adf9 with SMTP id 3f1490d57ef6-e1155ab305cmr996249276.19.1723584274034;
        Tue, 13 Aug 2024 14:24:34 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.116])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf432fb61dsm21390786d6.52.2024.08.13.14.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 14:24:33 -0700 (PDT)
From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	houtao@huaweicloud.com,
	sinquersw@gmail.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Hou Tao <houtao1@huawei.com>,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH v4 bpf-next 5/5] selftests/bpf: Test bpf_kptr_xchg stashing into local kptr
Date: Tue, 13 Aug 2024 21:24:24 +0000
Message-Id: <20240813212424.2871455-6-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240813212424.2871455-1-amery.hung@bytedance.com>
References: <20240813212424.2871455-1-amery.hung@bytedance.com>
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
Acked-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/progs/local_kptr_stash.c    | 30 +++++++++++++++++--
 .../selftests/bpf/progs/task_kfunc_success.c  | 26 +++++++++++++++-
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
index 75043ffc5dad..b092a72b2c9d 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
@@ -8,9 +8,12 @@
 #include "../bpf_experimental.h"
 #include "../bpf_testmod/bpf_testmod_kfunc.h"
 
+struct plain_local;
+
 struct node_data {
 	long key;
 	long data;
+	struct plain_local __kptr * stashed_in_local_kptr;
 	struct bpf_rb_node node;
 };
 
@@ -85,6 +88,7 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 
 static int create_and_stash(int idx, int val)
 {
+	struct plain_local *inner_local_kptr;
 	struct map_value *mapval;
 	struct node_data *res;
 
@@ -92,11 +96,25 @@ static int create_and_stash(int idx, int val)
 	if (!mapval)
 		return 1;
 
+	inner_local_kptr = bpf_obj_new(typeof(*inner_local_kptr));
+	if (!inner_local_kptr)
+		return 2;
+
 	res = bpf_obj_new(typeof(*res));
-	if (!res)
-		return 1;
+	if (!res) {
+		bpf_obj_drop(inner_local_kptr);
+		return 3;
+	}
 	res->key = val;
 
+	inner_local_kptr = bpf_kptr_xchg(&res->stashed_in_local_kptr, inner_local_kptr);
+	if (inner_local_kptr) {
+		/* Should never happen, we just obj_new'd res */
+		bpf_obj_drop(inner_local_kptr);
+		bpf_obj_drop(res);
+		return 4;
+	}
+
 	res = bpf_kptr_xchg(&mapval->node, res);
 	if (res)
 		bpf_obj_drop(res);
@@ -169,6 +187,7 @@ long stash_local_with_root(void *ctx)
 SEC("tc")
 long unstash_rb_node(void *ctx)
 {
+	struct plain_local *inner_local_kptr = NULL;
 	struct map_value *mapval;
 	struct node_data *res;
 	long retval;
@@ -180,6 +199,13 @@ long unstash_rb_node(void *ctx)
 
 	res = bpf_kptr_xchg(&mapval->node, NULL);
 	if (res) {
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
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
index 70df695312dc..3138bb689b0b 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 
+#include "../bpf_experimental.h"
 #include "task_kfunc_common.h"
 
 char _license[] SEC("license") = "GPL";
@@ -143,7 +144,7 @@ SEC("tp_btf/task_newtask")
 int BPF_PROG(test_task_xchg_release, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *kptr;
-	struct __tasks_kfunc_map_value *v;
+	struct __tasks_kfunc_map_value *v, *local;
 	long status;
 
 	if (!is_test_kfunc_task())
@@ -167,6 +168,29 @@ int BPF_PROG(test_task_xchg_release, struct task_struct *task, u64 clone_flags)
 		return 0;
 	}
 
+	local = bpf_obj_new(typeof(*local));
+	if (!local) {
+		err = 4;
+		bpf_task_release(kptr);
+		return 0;
+	}
+
+	kptr = bpf_kptr_xchg(&local->task, kptr);
+	if (kptr) {
+		err = 5;
+		bpf_obj_drop(local);
+		bpf_task_release(kptr);
+		return 0;
+	}
+
+	kptr = bpf_kptr_xchg(&local->task, NULL);
+	if (!kptr) {
+		err = 6;
+		bpf_obj_drop(local);
+		return 0;
+	}
+
+	bpf_obj_drop(local);
 	bpf_task_release(kptr);
 
 	return 0;
-- 
2.20.1



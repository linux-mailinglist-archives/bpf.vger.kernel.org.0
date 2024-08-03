Return-Path: <bpf+bounces-36332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670B3946667
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 02:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213E1282934
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 00:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8CD2914;
	Sat,  3 Aug 2024 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCVemhxU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9D6A38
	for <bpf@vger.kernel.org>; Sat,  3 Aug 2024 00:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722643919; cv=none; b=rOp5sLtczVuT7O9EEjy3l2yvlbqYsTN190T2TT0NQXCKmDUAjXZKKhke6HUwKceyf21xrs0PGXrLjWQF4rBtEQsRdabdpqGINhBFRcNTO6boOWpzTPqmoTj15nVtS9dftAwODYeIA6T1SOA14qF2SFuZY4tM+qN4HhC1oPudnGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722643919; c=relaxed/simple;
	bh=MytIW0EfcJm0EY4fnT1r9NWRNtDkk7a+9lmCKlPpmpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mu07mnRZMzlnpFHalT/IQCIJQJPwqZGaZzIvFpPTXsaSB9QlUkCs/ZJNmo07ybVtZsttN0ZEJycN0vSBs3Dv7Q514KiLT8yAASmvtjewuHXjDjp+ugjjF8m4mpSeXVxJiCq8HdTqCyQbR4nNnM0RMLTly6JpEp74vZh3YFaSvNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCVemhxU; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d7a544e7so606078185a.3
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2024 17:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722643916; x=1723248716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/uGpvjs4w6ueVhZqp6hGmGif+6oj2nco4CtEHR1FOE=;
        b=mCVemhxUkBe2n843zEP4LnQ1VGkHQILyfFCABjx2hcdE4MFwI7zpKagRmAQP5zOoZO
         iRHzewgryiP0YaKG7VkALgU23LhRCcB8hwJ7JbzrhEtwfZfVWOeQgg/6xWU/3/5Ce69w
         kH8KxN0CgkX0BUl0s8GO21nrDDl1X2ZvknEPaDqF/Z5PBzwebnN5ti0//0T+37W4PExL
         KQ4u7hHkKLl6C6UTHqjKm8rjfwEL+1EQTYn24bZ85jpCzFiAP+J5JyqA2rfYmPmvwqcr
         z2JQpkzkiwCgji9aR6BiH/9De/eAcm4AQAgxrORGrSMQxhOrxkiiyPB9zPk5ivJ/zeFn
         Coig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722643916; x=1723248716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/uGpvjs4w6ueVhZqp6hGmGif+6oj2nco4CtEHR1FOE=;
        b=FOYa6wnAmBJiqvdDzzTCfVCEUHL6jaZoSb8K32eDUW3eZkWXl0HPVHUHO0KE/DSsYk
         58M/Tb3miMfBrKZ4LPtj3iKPbh+dPgmW5V9uLo1pQahUYGYYI2yjebqijWE0wnrYrixM
         ncPxz97rkMGClU4TuSc+xjgbcwtyeXNKvQ/zNZZcJrNh70LgKMIPDZTD5QzocHdCsPn5
         b3bHhgDsmzGB1IMzsFZHQYlWAAlVdGibm7AiGMBYGL6HQ5L+/6dMtTOBV/6ZeMMEFH3L
         9ovlbGEgOO+VACyC4rrD2r3wOd0onBBfTHe3klc9ynaJQfzAqlQHy7DcbVTbPdCAcilz
         9aCA==
X-Gm-Message-State: AOJu0YzosQkERBmNYcYihVLfJqQScbpgDpp1q7uUzMIqxwwgixzkQQsq
	mO7/HdL6xybJrg6IjeTe58gWF0MQcbgFPZjuOMlWJYAGsdXlJz6Ci6aKSA==
X-Google-Smtp-Source: AGHT+IGUHqNgTOEcAbmmjW61azOFBfqcnokipcpIwCLRPKRIfysgJ5IoWyhVBtsrMAw/s9FD+HeEaA==
X-Received: by 2002:a05:620a:2909:b0:7a1:dfe4:5708 with SMTP id af79cd13be357-7a34ef027c1mr599191785a.16.1722643916254;
        Fri, 02 Aug 2024 17:11:56 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6dce75sm129547485a.14.2024.08.02.17.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 17:11:55 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH v2 bpf-next 4/4] selftests/bpf: Test bpf_kptr_xchg stashing into local kptr
Date: Sat,  3 Aug 2024 00:11:45 +0000
Message-Id: <20240803001145.635887-5-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240803001145.635887-1-amery.hung@bytedance.com>
References: <20240803001145.635887-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Marchevsky <davemarchevsky@fb.com>

Test stashing a referenced kptr in to a local kptr.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/progs/local_kptr_stash.c    | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
index 75043ffc5dad..a0d784e8a05b 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
@@ -11,6 +11,7 @@
 struct node_data {
 	long key;
 	long data;
+	struct prog_test_ref_kfunc __kptr *stashed_in_node;
 	struct bpf_rb_node node;
 };
 
@@ -85,18 +86,35 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 
 static int create_and_stash(int idx, int val)
 {
+	struct prog_test_ref_kfunc *inner;
 	struct map_value *mapval;
 	struct node_data *res;
+	unsigned long dummy;
 
 	mapval = bpf_map_lookup_elem(&some_nodes, &idx);
 	if (!mapval)
 		return 1;
 
+	dummy = 0;
+	inner = bpf_kfunc_call_test_acquire(&dummy);
+	if (!inner)
+		return 2;
+
 	res = bpf_obj_new(typeof(*res));
-	if (!res)
-		return 1;
+	if (!res) {
+		bpf_kfunc_call_test_release(inner);
+		return 3;
+	}
 	res->key = val;
 
+	inner = bpf_kptr_xchg(&res->stashed_in_node, inner);
+	if (inner) {
+		/* Should never happen, we just obj_new'd res */
+		bpf_kfunc_call_test_release(inner);
+		bpf_obj_drop(res);
+		return 4;
+	}
+
 	res = bpf_kptr_xchg(&mapval->node, res);
 	if (res)
 		bpf_obj_drop(res);
-- 
2.20.1



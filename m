Return-Path: <bpf+bounces-38117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4B295FE2B
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 03:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9661C21C47
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 01:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE3146B5;
	Tue, 27 Aug 2024 01:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YeXq0nbz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088186FDC
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 01:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724721213; cv=none; b=B81FLVwMyGv7mF1qNRaCL9ruQ/MvPX05EKBb2J4X4RYtTZUrvtvTYCBl71k56h0UFUh9W4q4zA/DzkfnW2wJNDt9Jy1MVvDrKrHJsVwAI9SZKbIDXC5IBeN05033IE3+cHVMu9Cn4b+CyFNDNSr8hmEmGihIu696pbMf5onip1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724721213; c=relaxed/simple;
	bh=E3yLX28dCuFUVBDA7HOJLT/P/yGYxqis3UUoSP3sFiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EXsQEbfTxBT2QV21WG18VdFCKD2TTqtYXuLLOpQgwOwwfcqlzD+mAClHKnQWVK4GDQJqVuMUM6VzZlD4S7HpkrWpAkm189AvSuS37HHYP9ct1cpe3MdbqS/3C3YZ3kAtg5c9+Stu18R0tuLNYcrPLZAPzoOaBoTpjLZgkn+jV7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YeXq0nbz; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf42a563c8so24145406d6.1
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 18:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724721211; x=1725326011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NhJmAi0gr5W3/qOPCAAwwbwJk080vB+GSxW0WRNOi3s=;
        b=YeXq0nbz8d4o1YoJoLayfIvtBR/olBfpVyXV+5qNpXgexBckNEvd8KR/bjXzK0Dyer
         BhKjmRA+CqYJtGdEzU2M+Y+MAOHc0Nqnl7xtTeLF5jflNlj8OtTnDtl763cYw7bp/5xa
         /EDntCk9TpTTyPBp6ieeevK4sGbI9+FanQTKcT2Ta7If2fQ67rc/1jjsMRMNAqykB1Gx
         EQV92rUe7ghQuAAmcAWQ3wEkKCZij7eFWvkZ04yahl4zdRzhkPRXnxI9X3KBIwrKlxYl
         L7EHWlwVH1Z7BHIrQzphFxe6BrHUAWCPcCWpCcs0gbSh8KotH3oGayaMOx4wShZzGZd9
         ONAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724721211; x=1725326011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NhJmAi0gr5W3/qOPCAAwwbwJk080vB+GSxW0WRNOi3s=;
        b=sMXYbeRzbZ3lD0e1agWUxDNZwrGdYNXwHmBSxs5r81cIWwnGWoHpoPCBYYANEla+Al
         QELy7cHD9c1evoZNuEWQy4rIpyUWJdP1f1ML/YV5DmH4GyIL23fhxICt2JVFDqN/gaaL
         ihz5NBhBxhm4LI4Moed1111Yt1DbVGUETHENtiutrF+T6S3i1ZKe1FdMxBgo7cP9B/lO
         GP9n2vr3rV6i1oys1HZuP8S93cJZbJNjrpPZL5nC8nDjjkxdP2OMCqTMvvaCBHFJdzpd
         7ZEM8kk04qV4j6eG5+qy5SUm6ek8w8maQsOec64BI5fsuRQQUtOiTa+DdA1g5B+A+pax
         D8sg==
X-Gm-Message-State: AOJu0YziYuYzztM5HAf6gF0oH4fDF2VYwhyd8M2U0J0FYnlBORSO0XIR
	Cz4e/FIV2TCCfsUGDSa2wq4gU7KCZJPbJ4SpYwwUAkW8tqd7TOe6O6WlwZVnE0tAFoqIQFesuBk
	WpCY=
X-Google-Smtp-Source: AGHT+IFL1xizoxzYqlamHpc7wRHCJuhbDXBK0s/Q7KZDiPyh9Pmzsqt0EEf2vpI6YTAGQD/8WsP7Uw==
X-Received: by 2002:a05:6214:5a02:b0:6b7:b2fc:393b with SMTP id 6a1803df08f44-6c32b69fcf7mr14077116d6.20.1724721210845;
        Mon, 26 Aug 2024 18:13:30 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db0c26sm51903366d6.89.2024.08.26.18.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 18:13:30 -0700 (PDT)
From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	houtao@huaweicloud.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH bpf-next] selftests/bpf: Make sure stashed kptr in local kptr is freed recursively
Date: Tue, 27 Aug 2024 01:13:01 +0000
Message-Id: <20240827011301.608620-1-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dropping a local kptr, any kptr stashed into it is supposed to be
freed through bpf_obj_free_fields->__bpf_obj_drop_impl recursively. Add a
test to make sure it happens.

The test first stashes a referenced kptr to "struct task" into a local
kptr and gets the reference count of the task. Then, it drops the local
kptr and reads the reference count of the task again. Since
bpf_obj_free_fields and __bpf_obj_drop_impl will go through the local kptr
recursively during bpf_obj_drop, the dtor of the stashed task kptr should
eventually be called. The second reference count should be one less than
the first one.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/progs/task_kfunc_success.c  | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
index 3138bb689b0b..a55149015063 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -143,8 +143,9 @@ int BPF_PROG(test_task_acquire_leave_in_map, struct task_struct *task, u64 clone
 SEC("tp_btf/task_newtask")
 int BPF_PROG(test_task_xchg_release, struct task_struct *task, u64 clone_flags)
 {
-	struct task_struct *kptr;
+	struct task_struct *kptr, *acquired;
 	struct __tasks_kfunc_map_value *v, *local;
+	int refcnt, refcnt_after_drop;
 	long status;
 
 	if (!is_test_kfunc_task())
@@ -190,7 +191,34 @@ int BPF_PROG(test_task_xchg_release, struct task_struct *task, u64 clone_flags)
 		return 0;
 	}
 
+	/* Stash a copy into local kptr and check if it is released recursively */
+	acquired = bpf_task_acquire(kptr);
+	if (!acquired) {
+		err = 7;
+		bpf_obj_drop(local);
+		bpf_task_release(kptr);
+		return 0;
+	}
+	bpf_probe_read_kernel(&refcnt, sizeof(refcnt), &acquired->rcu_users);
+
+	acquired = bpf_kptr_xchg(&local->task, acquired);
+	if (acquired) {
+		err = 8;
+		bpf_obj_drop(local);
+		bpf_task_release(kptr);
+		bpf_task_release(acquired);
+		return 0;
+	}
+
 	bpf_obj_drop(local);
+
+	bpf_probe_read_kernel(&refcnt_after_drop, sizeof(refcnt_after_drop), &kptr->rcu_users);
+	if (refcnt != refcnt_after_drop + 1) {
+		err = 9;
+		bpf_task_release(kptr);
+		return 0;
+	}
+
 	bpf_task_release(kptr);
 
 	return 0;
-- 
2.20.1



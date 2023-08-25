Return-Path: <bpf+bounces-8648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6A6788D23
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025E01C20FFA
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD9B17746;
	Fri, 25 Aug 2023 16:20:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46BF2571
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:20:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E2E1991
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692980436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=0ZAYlH739l+imp77wdMvEIGsmJrTe5vS2BECbqXhogw=;
	b=RfY6ltcAEKFdbEpksNmwgzwleMPDrJ7CgZ82BlaeB8QMhpTx/BiZnLrkjQ0x/Eq8HZPFRX
	ghoFLmSBoIW4S7usc4jdTJwEuGzDhHZyMuPYnvKC3ndlug/tjZLRIKUlbguTQKedXYfRri
	v9nMTXMBOGqo4jZ/zr3brcPgKfNDUfM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-qNskW97aOzyi2U7dJEyALg-1; Fri, 25 Aug 2023 12:20:34 -0400
X-MC-Unique: qNskW97aOzyi2U7dJEyALg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F31485D060;
	Fri, 25 Aug 2023 16:20:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
	by smtp.corp.redhat.com (Postfix) with SMTP id 9ECA52026D68;
	Fri, 25 Aug 2023 16:20:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 25 Aug 2023 18:19:46 +0200 (CEST)
Date: Fri, 25 Aug 2023 18:19:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>, Yonghong Song <yhs@fb.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <kuifeng@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] bpf: task_group_seq_get_next: cleanup the usage of
 get/put_task_struct
Message-ID: <20230825161943.GA16865@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825161842.GA16750@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

get_pid_task() makes no sense, the code does put_task_struct() soon after.
Use find_task_by_pid_ns() instead of find_pid_ns + get_pid_task and kill
put_task_struct(), this allows to do get_task_struct() only once before
return.

While at it, kill the unnecessary "if (!pid)" check in the "if (!*tid)"
block, this matches the next usage of find_pid_ns() + get_pid_task() in
this function.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/task_iter.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 4d1125108014..1589ec3faded 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -42,9 +42,6 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
 	if (!*tid) {
 		/* The first time, the iterator calls this function. */
 		pid = find_pid_ns(common->pid, common->ns);
-		if (!pid)
-			return NULL;
-
 		task = get_pid_task(pid, PIDTYPE_TGID);
 		if (!task)
 			return NULL;
@@ -66,17 +63,12 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
 		return task;
 	}
 
-	pid = find_pid_ns(common->pid_visiting, common->ns);
-	if (!pid)
-		return NULL;
-
-	task = get_pid_task(pid, PIDTYPE_PID);
+	task = find_task_by_pid_ns(common->pid_visiting, common->ns);
 	if (!task)
 		return NULL;
 
 retry:
 	next_task = next_thread(task);
-	put_task_struct(task);
 
 	saved_tid = *tid;
 	*tid = __task_pid_nr_ns(next_task, PIDTYPE_PID, common->ns);
@@ -88,7 +80,6 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
 		return NULL;
 	}
 
-	get_task_struct(next_task);
 	common->pid_visiting = *tid;
 
 	if (skip_if_dup_files && task->files == task->group_leader->files) {
@@ -96,6 +87,7 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
 		goto retry;
 	}
 
+	get_task_struct(next_task);
 	return next_task;
 }
 
-- 
2.25.1.362.g51ebf55



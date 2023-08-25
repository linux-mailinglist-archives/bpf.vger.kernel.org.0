Return-Path: <bpf+bounces-8652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BAA788D28
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCED1C21028
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842A817ABF;
	Fri, 25 Aug 2023 16:20:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4AB17742
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:20:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F5B2128
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692980451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=YQBzsA/Z+wipgrDrsnQY+IF6MUsXkrkm4AfJgFKQYa8=;
	b=hJWLNDdGZIoFjOf+5T0bfyYMSWEBCG9LlxmxOuVj25eLnQFQHvkfNBCJgiRRj6MLJsfLdT
	VPVdkIqG0bxgWWXjSSMxkGIxcXYKNx/aYq6ri5Ftg40nSZQ5uYditnKgNw/63GQZszhsuV
	bbkUfWGd7ri5LKc+NhOO3pP/ssH3Yl8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-89Uwb9boOTuNfZZ-1GzX0A-1; Fri, 25 Aug 2023 12:20:49 -0400
X-MC-Unique: 89Uwb9boOTuNfZZ-1GzX0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7FBA811731;
	Fri, 25 Aug 2023 16:20:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
	by smtp.corp.redhat.com (Postfix) with SMTP id 75A642166B27;
	Fri, 25 Aug 2023 16:20:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 25 Aug 2023 18:20:02 +0200 (CEST)
Date: Fri, 25 Aug 2023 18:19:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>, Yonghong Song <yhs@fb.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <kuifeng@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] bpf: task_group_seq_get_next: use __next_thread() rather
 than next_thread()
Message-ID: <20230825161959.GA16893@redhat.com>
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
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Lockless use of next_thread() should be avoided, task_group_seq_get_next()
is the last user, it too can return the group leader twice if it races with
mt-thread exec which changes the group->leader's pid.

Change the main loop to use __next_thread(), kill "next_tid == common->pid"
check.

__next_thread() can't loop forever, so we can also change this code to retry
if next_tid == 0.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/bpf/task_iter.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 7473068ed313..8c847d91cdd9 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -68,15 +68,13 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
 		return NULL;
 
 retry:
-	task = next_thread(task);
+	task = __next_thread(task);
+	if (!task)
+		return NULL;
 
 	next_tid = __task_pid_nr_ns(task, PIDTYPE_PID, common->ns);
-	if (!next_tid || next_tid == common->pid) {
-		/* Run out of tasks of a process.  The tasks of a
-		 * thread_group are linked as circular linked list.
-		 */
-		return NULL;
-	}
+	if (!next_tid)
+		goto retry;
 
 	if (skip_if_dup_files && task->files == task->group_leader->files)
 		goto retry;
-- 
2.25.1.362.g51ebf55



Return-Path: <bpf+bounces-8651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E232788D27
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163AD281751
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46FC17AAA;
	Fri, 25 Aug 2023 16:20:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCB31775A
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:20:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74222128
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692980448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=DGZ49Q7hi6AstDObdejE3G09kyzhv7FaAvKHz09+bjg=;
	b=DUhO0LHBVVpcHhlDolqOU8ORocICYJIxQ8hIkKldawFcS/zzN3zxAuolLox9RFu7/JaDL4
	btFiGntNJ4EJXkjhvDWgLT5YNeT+msj7MrHbeEG4y1B8yFojfmgO0plp2B2y4vptKQAOMK
	lJjD0sqDwsbfsw1q1mtPdpYuUx2hEgE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-QVmpS7HjOWKaQKb9kBmnTg-1; Fri, 25 Aug 2023 12:20:46 -0400
X-MC-Unique: QVmpS7HjOWKaQKb9kBmnTg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 643FF811726;
	Fri, 25 Aug 2023 16:20:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
	by smtp.corp.redhat.com (Postfix) with SMTP id E4B672026D68;
	Fri, 25 Aug 2023 16:20:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 25 Aug 2023 18:19:58 +0200 (CEST)
Date: Fri, 25 Aug 2023 18:19:54 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>, Yonghong Song <yhs@fb.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <kuifeng@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] bpf: task_group_seq_get_next: simplify the "next tid"
 logic
Message-ID: <20230825161954.GA16886@redhat.com>
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

Kill saved_tid. It looks ugly to update *tid and then restore the
previous value if __task_pid_nr_ns() returns 0. Change this code
to update *tid and common->pid_visiting once before return.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/bpf/task_iter.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index f51f476ec679..7473068ed313 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -37,7 +37,7 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
 {
 	struct task_struct *task;
 	struct pid *pid;
-	u32 saved_tid;
+	u32 next_tid;
 
 	if (!*tid) {
 		/* The first time, the iterator calls this function. */
@@ -70,21 +70,18 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
 retry:
 	task = next_thread(task);
 
-	saved_tid = *tid;
-	*tid = __task_pid_nr_ns(task, PIDTYPE_PID, common->ns);
-	if (!*tid || *tid == common->pid) {
+	next_tid = __task_pid_nr_ns(task, PIDTYPE_PID, common->ns);
+	if (!next_tid || next_tid == common->pid) {
 		/* Run out of tasks of a process.  The tasks of a
 		 * thread_group are linked as circular linked list.
 		 */
-		*tid = saved_tid;
 		return NULL;
 	}
 
-	common->pid_visiting = *tid;
-
 	if (skip_if_dup_files && task->files == task->group_leader->files)
 		goto retry;
 
+	*tid = common->pid_visiting = next_tid;
 	get_task_struct(task);
 	return task;
 }
-- 
2.25.1.362.g51ebf55



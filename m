Return-Path: <bpf+bounces-9261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 414D7792417
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 17:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299DD1C20A48
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB6EDDA6;
	Tue,  5 Sep 2023 15:47:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48BA2571
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 15:47:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66DD194
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693928869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=kbHpZKosKm0C7zhU/OsIgTNX0r2M4ft/T+RvV9Bm49w=;
	b=XdkIjG5w3iCJeO+Nf7o9LALIDFzMSUtMobxtDlkUUVHdwdKIqS8p/z45jY9Cgc5rdHSGUW
	x5eBink5YOJMsRZee2/VXTi8IHCfgnB4k5eP6eizM2oY0rbW19iWI4cY7r2Uo/e2iInV8h
	NSD3jo1d5QLfmP/qZei3Ez9aRgPOsWs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-688-6CRKtLehOyC9SP4SFCxraw-1; Tue, 05 Sep 2023 11:47:46 -0400
X-MC-Unique: 6CRKtLehOyC9SP4SFCxraw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F7088A4360;
	Tue,  5 Sep 2023 15:47:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.87])
	by smtp.corp.redhat.com (Postfix) with SMTP id D7F466B5AA;
	Tue,  5 Sep 2023 15:47:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  5 Sep 2023 17:46:55 +0200 (CEST)
Date: Tue, 5 Sep 2023 17:46:54 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Kui-Feng Lee <sinquersw@gmail.com>, bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 4/5] bpf: task_group_seq_get_next: kill next_task
Message-ID: <20230905154654.GA24945@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905154612.GA24872@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It only adds the unnecessary confusion and compicates the "retry" code.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/task_iter.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 2264870ae3fc..f51f476ec679 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -35,7 +35,7 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
 						   u32 *tid,
 						   bool skip_if_dup_files)
 {
-	struct task_struct *task, *next_task;
+	struct task_struct *task;
 	struct pid *pid;
 	u32 saved_tid;
 
@@ -68,10 +68,10 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
 		return NULL;
 
 retry:
-	next_task = next_thread(task);
+	task = next_thread(task);
 
 	saved_tid = *tid;
-	*tid = __task_pid_nr_ns(next_task, PIDTYPE_PID, common->ns);
+	*tid = __task_pid_nr_ns(task, PIDTYPE_PID, common->ns);
 	if (!*tid || *tid == common->pid) {
 		/* Run out of tasks of a process.  The tasks of a
 		 * thread_group are linked as circular linked list.
@@ -82,13 +82,11 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
 
 	common->pid_visiting = *tid;
 
-	if (skip_if_dup_files && next_task->files == next_task->group_leader->files) {
-		task = next_task;
+	if (skip_if_dup_files && task->files == task->group_leader->files)
 		goto retry;
-	}
 
-	get_task_struct(next_task);
-	return next_task;
+	get_task_struct(task);
+	return task;
 }
 
 static struct task_struct *task_seq_get_next(struct bpf_iter_seq_task_common *common,
-- 
2.25.1.362.g51ebf55



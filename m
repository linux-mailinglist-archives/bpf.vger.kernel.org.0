Return-Path: <bpf+bounces-15061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F487EB4F1
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 17:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118F8281315
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B079F41212;
	Tue, 14 Nov 2023 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9xJJH+c"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D03FE38
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 16:33:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE45134
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 08:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699979627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=BkORamFmgjQm3rT3wXmKJVf5l2MYL+TWgwU+R0JxK1c=;
	b=O9xJJH+cmHlfqT7imG4tOUTDYcg16yAZc2RMofJvynu1mumE6/NYEyh1g3gXCbQ+VgmD9d
	U3wNJUEs8TJhSDiFp5NatW0alpEMY3tugI8n8wZUQhBbmby2AML8mDxofV/aq+xEkjCWVs
	YrbkSI3nT6LY9JdGEHUvZ7PEVtD0QqM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-yLGSOGLEP8ui6el_IihhxQ-1; Tue, 14 Nov 2023 11:33:41 -0500
X-MC-Unique: yLGSOGLEP8ui6el_IihhxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49EE5811E8F;
	Tue, 14 Nov 2023 16:33:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.253])
	by smtp.corp.redhat.com (Postfix) with SMTP id CA84B5028;
	Tue, 14 Nov 2023 16:33:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 14 Nov 2023 17:32:36 +0100 (CET)
Date: Tue, 14 Nov 2023 17:32:34 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <kuifeng@fb.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 1/3] bpf: task_group_seq_get_next: use __next_thread() rather
 than next_thread()
Message-ID: <20231114163234.GA890@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114163211.GA874@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Lockless use of next_thread() should be avoided, kernel/bpf/task_iter.c
is the last user and the usage is wrong.

task_group_seq_get_next() can return the group leader twice if it races
with mt-thread exec which changes the group->leader's pid.

Change the main loop to use __next_thread(), kill "next_tid == common->pid"
check.

__next_thread() can't loop forever, we can also change this code to retry
if next_tid == 0.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/bpf/task_iter.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 26082b97894d..51ae15e2b290 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -70,15 +70,13 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
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



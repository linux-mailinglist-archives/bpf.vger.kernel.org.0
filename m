Return-Path: <bpf+bounces-9260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF10792416
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 17:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43AC281294
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A33DDA1;
	Tue,  5 Sep 2023 15:47:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB02571
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 15:47:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEC9E6
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693928868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=bP7NmTK5RLD7afG73GjQRK28HOHwv3rS4joshzS268c=;
	b=S/7oqjW+03wxfxeA+noQKjlim2vmJExMPWwF3hlTRAZQDOAlBjSSjUyAE173pODWYRBlt0
	49gXABR4t0Fhw/BsmORX2OmnFnkkFPp+k1C0h+Bc1CwvmEaEK1cgF3e0StHy4ANj3IXddd
	5wqYFFRVOprI3ehNqh6t662Ebd77jL0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-uil9obWWNVeX7yqPwy0a-Q-1; Tue, 05 Sep 2023 11:47:45 -0400
X-MC-Unique: uil9obWWNVeX7yqPwy0a-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D59698030A9;
	Tue,  5 Sep 2023 15:47:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.87])
	by smtp.corp.redhat.com (Postfix) with SMTP id 9A79121EE565;
	Tue,  5 Sep 2023 15:47:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  5 Sep 2023 17:46:53 +0200 (CEST)
Date: Tue, 5 Sep 2023 17:46:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Kui-Feng Lee <sinquersw@gmail.com>, bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 3/5] bpf: task_group_seq_get_next: fix the
 skip_if_dup_files check
Message-ID: <20230905154651.GA24940@redhat.com>
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
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Unless I am notally confused it is wrong. We are going to return or
skip next_task so we need to check next_task-files, not task->files.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/task_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 1589ec3faded..2264870ae3fc 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -82,7 +82,7 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
 
 	common->pid_visiting = *tid;
 
-	if (skip_if_dup_files && task->files == task->group_leader->files) {
+	if (skip_if_dup_files && next_task->files == next_task->group_leader->files) {
 		task = next_task;
 		goto retry;
 	}
-- 
2.25.1.362.g51ebf55



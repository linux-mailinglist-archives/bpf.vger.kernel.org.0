Return-Path: <bpf+bounces-8645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05487788D18
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E64B2817B2
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4233317735;
	Fri, 25 Aug 2023 16:19:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B08C2571
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:19:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E85C19A0
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692980378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=uiJ7/zCtGwucjs2wTp8G7jQHFGUDEyW7zcPa/oNYiWc=;
	b=WXmHUC3m4L2mr1TfuoW1BbAipD2KjhrW6p0P02llA9or/C27kptZZv8COeRYxmKr/Tbnm3
	W54sfMPnEqMjYi8Hejeaa+wqMWaONJ+8lCroo+dtfad9HGotLx6Uqn7/rZYWsr/+aT181N
	g9HJ1Mz9e0VajdlXtkzxzXtNKQobN5Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-tqRQ3ruHMdKCN4LotaAvyQ-1; Fri, 25 Aug 2023 12:19:35 -0400
X-MC-Unique: tqRQ3ruHMdKCN4LotaAvyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22929185A78F;
	Fri, 25 Aug 2023 16:19:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
	by smtp.corp.redhat.com (Postfix) with SMTP id F24F62166B26;
	Fri, 25 Aug 2023 16:19:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 25 Aug 2023 18:18:47 +0200 (CEST)
Date: Fri, 25 Aug 2023 18:18:42 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>, Yonghong Song <yhs@fb.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <kuifeng@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] bpf: task_group_seq_get_next: use __next_thread()
Message-ID: <20230825161842.GA16750@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Compile tested, 1-5 need the review from bpf maintainers, quite possibly
I did some silly mistakes. I tried to cleanup this code because I could
not look at it, but it has other problems and imo should be rewritten.

6/6 obviously depends on

	[PATCH 1/2] introduce __next_thread(), fix next_tid() vs exec() race
	https://lore.kernel.org/all/20230824143142.GA31222@redhat.com/

which was not merged yet.

To simplify the review, this is the code after 6/6:

	static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_common *common,
							   u32 *tid,
							   bool skip_if_dup_files)
	{
		struct task_struct *task;
		struct pid *pid;
		u32 next_tid;

		if (!*tid) {
			/* The first time, the iterator calls this function. */
			pid = find_pid_ns(common->pid, common->ns);
			task = get_pid_task(pid, PIDTYPE_TGID);
			if (!task)
				return NULL;

			*tid = common->pid;
			common->pid_visiting = common->pid;

			return task;
		}

		/* If the control returns to user space and comes back to the
		 * kernel again, *tid and common->pid_visiting should be the
		 * same for task_seq_start() to pick up the correct task.
		 */
		if (*tid == common->pid_visiting) {
			pid = find_pid_ns(common->pid_visiting, common->ns);
			task = get_pid_task(pid, PIDTYPE_PID);

			return task;
		}

		task = find_task_by_pid_ns(common->pid_visiting, common->ns);
		if (!task)
			return NULL;

	retry:
		task = __next_thread(task);
		if (!task)
			return NULL;

		next_tid = __task_pid_nr_ns(task, PIDTYPE_PID, common->ns);
		if (!next_tid)
			goto retry;

		if (skip_if_dup_files && task->files == task->group_leader->files)
			goto retry;

		*tid = common->pid_visiting = next_tid;
		get_task_struct(task);
		return task;
	}

Oleg.



Return-Path: <bpf+bounces-15062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2E67EB4F2
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 17:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BB71F2556F
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EC9168D6;
	Tue, 14 Nov 2023 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6VouqA2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581B3FE54
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 16:33:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2199E132
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 08:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699979627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=2Mg3UCFMr1SH7PUf+Sl5YMeVrQDgFkP/RxqlBy+YY5Y=;
	b=G6VouqA2KyoyP5+loUFGnXSwgNhJ+XWoK9aBkpaxtQu5afl8OiQKhe6fCjEfX2aDOMkVWf
	iSVm36qxrlRqs91nlDUltIkzY3CaAhF2Hhkhw0A1OmAjRJv5K9Ntfy6wFfx6rQoeA7KFTJ
	vlj+pvMJS9J4ZxRGurQ45pyJcmUC7aA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-areqUpPuN-OXmCaWVP_OIg-1; Tue, 14 Nov 2023 11:33:45 -0500
X-MC-Unique: areqUpPuN-OXmCaWVP_OIg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24813811E93;
	Tue, 14 Nov 2023 16:33:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.253])
	by smtp.corp.redhat.com (Postfix) with SMTP id 46294493113;
	Tue, 14 Nov 2023 16:33:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 14 Nov 2023 17:32:39 +0100 (CET)
Date: Tue, 14 Nov 2023 17:32:37 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <kuifeng@fb.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 2/3] bpf: bpf_iter_task_next: use __next_thread() rather than
 next_thread()
Message-ID: <20231114163237.GA897@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Lockless use of next_thread() should be avoided, kernel/bpf/task_iter.c
is the last user and the usage is wrong.

bpf_iter_task_next() can loop forever, "kit->pos == kit->task" can never
happen if kit->pos execs. Change this code to use __next_thread().

With or without this change the usage of kit->pos/task and next_task()
doesn't look nice, see the next patch.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/bpf/task_iter.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 51ae15e2b290..d42e08d0d0b7 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -1015,12 +1015,11 @@ __bpf_kfunc struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it)
 	if (flags == BPF_TASK_ITER_ALL_PROCS)
 		goto get_next_task;
 
-	kit->pos = next_thread(kit->pos);
-	if (kit->pos == kit->task) {
-		if (flags == BPF_TASK_ITER_PROC_THREADS) {
-			kit->pos = NULL;
+	kit->pos = __next_thread(kit->pos);
+	if (!kit->pos) {
+		if (flags == BPF_TASK_ITER_PROC_THREADS)
 			return pos;
-		}
+		kit->pos = kit->task;
 	} else
 		return pos;
 
-- 
2.25.1.362.g51ebf55



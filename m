Return-Path: <bpf+bounces-6538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BDC76AA50
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 09:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B501C20DD3
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 07:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F821EA9D;
	Tue,  1 Aug 2023 07:52:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5F19BBC
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 07:52:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E21E49
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 00:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690876350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ax4LlHfccjWIodABz4vhBczrkSd8KaU8zWz4QNB3/fE=;
	b=T99AAVm3Y4+SPNpyu3HI2N97AKae2s95iaf5t24wm5cFKzSanWCRGvRMAuPuAARbb7gv9/
	npyM4N0Ix+84ezs4Mmok4/7ZYX4ukuKzVwZ5dSKsN+W2pMdwmeOQC1ITxiQFvNvhBbCVQq
	DvvcDBKu60VzxYdUEEPy/ECVRnQ78vs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-B0KY-4a2N9qD942SgaitXA-1; Tue, 01 Aug 2023 03:52:26 -0400
X-MC-Unique: B0KY-4a2N9qD942SgaitXA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD8DD280FECA;
	Tue,  1 Aug 2023 07:52:25 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.193.192])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EB091121325;
	Tue,  1 Aug 2023 07:52:24 +0000 (UTC)
From: Yauheni Kaliuta <ykaliuta@redhat.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	yonghong.song@linux.dev,
	Yauheni Kaliuta <ykaliuta@redhat.com>
Subject: [PATCH bpf-next v3] tracing: perf_call_bpf: use struct trace_entry in struct syscall_tp_t
Date: Tue,  1 Aug 2023 10:52:22 +0300
Message-ID: <20230801075222.7717-1-ykaliuta@redhat.com>
In-Reply-To: <20230728142740.483431-1-ykaliuta@redhat.com>
References: <20230728142740.483431-1-ykaliuta@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

bpf tracepoint program uses struct trace_event_raw_sys_enter as
argument where trace_entry is the first field. Use the same instead
of unsigned long long since if it's amended (for example by RT
patch) it accesses data with wrong offset.

Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>

---

v3:
- Fixed comment

v2:
- remove extra BUILD_BUG_ON
- add structure alignement

---
 kernel/trace/trace_syscalls.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 942ddbdace4a..de753403cdaf 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -555,12 +555,15 @@ static int perf_call_bpf_enter(struct trace_event_call *call, struct pt_regs *re
 			       struct syscall_trace_enter *rec)
 {
 	struct syscall_tp_t {
-		unsigned long long regs;
+		struct trace_entry ent;
 		unsigned long syscall_nr;
 		unsigned long args[SYSCALL_DEFINE_MAXARGS];
-	} param;
+	} __aligned(8) param;
 	int i;
 
+	BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));
+
+	/* bpf prog requires 'regs' to be the first member in the ctx (a.k.a. &param) */
 	*(struct pt_regs **)&param = regs;
 	param.syscall_nr = rec->nr;
 	for (i = 0; i < sys_data->nb_args; i++)
@@ -657,11 +660,12 @@ static int perf_call_bpf_exit(struct trace_event_call *call, struct pt_regs *reg
 			      struct syscall_trace_exit *rec)
 {
 	struct syscall_tp_t {
-		unsigned long long regs;
+		struct trace_entry ent;
 		unsigned long syscall_nr;
 		unsigned long ret;
-	} param;
+	} __aligned(8) param;
 
+	/* bpf prog requires 'regs' to be the first member in the ctx (a.k.a. &param) */
 	*(struct pt_regs **)&param = regs;
 	param.syscall_nr = rec->nr;
 	param.ret = rec->ret;
-- 
2.41.0



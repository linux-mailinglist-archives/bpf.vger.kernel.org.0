Return-Path: <bpf+bounces-6085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 187267656E5
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 17:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4528D2823D3
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370E517751;
	Thu, 27 Jul 2023 15:05:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0358210794
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 15:05:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB33430F4
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 08:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690470338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wcan3iVrHYYqIE9H2D+bHcKLyhQi2cTBlipiw/wRk0Q=;
	b=MMN8MbDEJDXJeAqdRLqxn/Xhe8iUQw0FKnnSTenUJWQDwaxgSD39safqnRRBKUyaWU3Pmv
	OBe7jwqpMp+GUXX9+s6iUtlv8GqvyJH29Mf395vtaBEDy+Mv0yHCCXziYP1dJd2pj+qyJq
	Y+Ps98mi45/VwDOShwBtv+0Opw91dQY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-MUmTQ0raPHiUz571Ns4Dcw-1; Thu, 27 Jul 2023 11:05:37 -0400
X-MC-Unique: MUmTQ0raPHiUz571Ns4Dcw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B6973C0C4AB;
	Thu, 27 Jul 2023 15:05:36 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.194.232])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BAF7840C2063;
	Thu, 27 Jul 2023 15:05:35 +0000 (UTC)
From: Yauheni Kaliuta <ykaliuta@redhat.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	Yauheni Kaliuta <ykaliuta@redhat.com>
Subject: [PATCH] tracing: perf_call_bpf: use struct trace_entry in struct syscall_tp_t
Date: Thu, 27 Jul 2023 18:05:34 +0300
Message-ID: <20230727150534.397532-1-ykaliuta@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

bpf tracepoint program uses struct trace_event_raw_sys_enter as
argument where trace_entry is the first field. Use the same instead
of unsigned long long since if it's amended (for example by RT
patch) it accesses data with wrong offset.

Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
---
 kernel/trace/trace_syscalls.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 942ddbdace4a..07f4fa395e99 100644
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
 	} param;
 	int i;
 
+	BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));
+
+	/* __bpf_prog_run() requires *regs as the first parameter */
 	*(struct pt_regs **)&param = regs;
 	param.syscall_nr = rec->nr;
 	for (i = 0; i < sys_data->nb_args; i++)
@@ -657,11 +660,14 @@ static int perf_call_bpf_exit(struct trace_event_call *call, struct pt_regs *reg
 			      struct syscall_trace_exit *rec)
 {
 	struct syscall_tp_t {
-		unsigned long long regs;
+		struct trace_entry ent;
 		unsigned long syscall_nr;
 		unsigned long ret;
 	} param;
 
+	BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));
+
+	/* __bpf_prog_run() requires *regs as the first parameter */
 	*(struct pt_regs **)&param = regs;
 	param.syscall_nr = rec->nr;
 	param.ret = rec->ret;
-- 
2.41.0



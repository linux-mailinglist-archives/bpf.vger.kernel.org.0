Return-Path: <bpf+bounces-13523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBF57DA41A
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 01:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1B42827C8
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 23:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DAC405FA;
	Fri, 27 Oct 2023 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628E38BDF
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 23:31:46 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2F8183
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 16:31:44 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RL85we006170
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 16:31:44 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tywry2e5y-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 16:31:44 -0700
Received: from twshared32169.15.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 16:31:40 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 773E33A7C8ED5; Fri, 27 Oct 2023 16:31:29 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>
CC: <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Francis Laniel
	<flaniel@linux.microsoft.com>,
        <stable@vger.kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>
Subject: [PATCH] tracing/kprobes: Fix symbol counting logic by looking at modules as well
Date: Fri, 27 Oct 2023 16:31:26 -0700
Message-ID: <20231027233126.2073148-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -SADqE3CpcMeH1mT33KutUgoHgkfSQmM
X-Proofpoint-GUID: -SADqE3CpcMeH1mT33KutUgoHgkfSQmM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_21,2023-10-27_01,2023-05-22_02

Recent changes to count number of matching symbols when creating
a kprobe event failed to take into account kernel modules. As such, it
breaks kprobes on kernel module symbols, by assuming there is no match.

Fix this my calling module_kallsyms_on_each_symbol() in addition to
kallsyms_on_each_match_symbol() to perform a proper counting.

Cc: Francis Laniel <flaniel@linux.microsoft.com>
Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func mat=
ches several symbols")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/trace_kprobe.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index effcaede4759..1efb27f35963 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -714,14 +714,30 @@ static int count_symbols(void *data, unsigned long =
unused)
 	return 0;
 }
=20
+struct sym_count_ctx {
+	unsigned int count;
+	const char *name;
+};
+
+static int count_mod_symbols(void *data, const char *name, unsigned long=
 unused)
+{
+	struct sym_count_ctx *ctx =3D data;
+
+	if (strcmp(name, ctx->name) =3D=3D 0)
+		ctx->count++;
+
+	return 0;
+}
+
 static unsigned int number_of_same_symbols(char *func_name)
 {
-	unsigned int count;
+	struct sym_count_ctx ctx =3D { .count =3D 0, .name =3D func_name };
+
+	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
=20
-	count =3D 0;
-	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
+	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
=20
-	return count;
+	return ctx.count;
 }
=20
 static int __trace_kprobe_create(int argc, const char *argv[])
--=20
2.34.1



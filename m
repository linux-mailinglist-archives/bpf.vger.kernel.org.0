Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28B42D37E1
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 05:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfJKD3Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Oct 2019 23:29:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46948 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726436AbfJKD3Y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Oct 2019 23:29:24 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x9B3TMuk004906
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2019 20:29:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=gkbIrNStcKgEaYvgzp6e0NnKcH1TOA45zbp1gaP5ksE=;
 b=kCtFHR4iNk3wK72t4EksrTgdZgVj4DOuEjCQpXu7F8Z8qNibBBFH+6pQ6UA/WvBpDnQd
 7uesm/9Hj/vomR0DEGIPJ99X93FJsumxNjGT1YfK59YCzrOwUFfpS//c/C5AMar4Mai5
 SLfx/5Znmn5TgF6+vHTmDQNasXWFM/0skDM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2vjekprsgs-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2019 20:29:23 -0700
Received: from 2401:db00:30:600c:face:0:1f:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 10 Oct 2019 20:29:07 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 8DB96861909; Thu, 10 Oct 2019 20:29:06 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <john.fastabend@gmail.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] libbpf: handle invalid typedef emitted by old GCC
Date:   Thu, 10 Oct 2019 20:29:01 -0700
Message-ID: <20191011032901.452042-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_01:2019-10-10,2019-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=8
 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910110029
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Old GCC versions are producing invalid typedef for __gnuc_va_list
pointing to void. Special-case this and emit valid:

typedef __builtin_va_list __gnuc_va_list;

Reported-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/btf_dump.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 87f27e2664c5..139812b46c7b 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -975,6 +975,17 @@ static void btf_dump_emit_typedef_def(struct btf_dump *d, __u32 id,
 {
 	const char *name = btf_dump_ident_name(d, id);
 
+	/*
+	 * Old GCC versions are emitting invalid typedef for __gnuc_va_list
+	 * pointing to VOID. This generates warnings from btf_dump() and
+	 * results in uncompilable header file, so we are fixing it up here
+	 * with valid typedef into __builtin_va_list.
+	 */
+	if (t->type == 0 && strcmp(name, "__gnuc_va_list") == 0) {
+		btf_dump_printf(d, "typedef __builtin_va_list __gnuc_va_list");
+		return;
+	}
+
 	btf_dump_printf(d, "typedef ");
 	btf_dump_emit_type_decl(d, t->type, name, lvl);
 }
-- 
2.17.1


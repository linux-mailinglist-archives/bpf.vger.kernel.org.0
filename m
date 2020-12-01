Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5AD2C93FA
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 01:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389149AbgLAAcf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 30 Nov 2020 19:32:35 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43208 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388044AbgLAAce (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Nov 2020 19:32:34 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B10TiAJ015180
        for <bpf@vger.kernel.org>; Mon, 30 Nov 2020 16:31:53 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 354c7qfm9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 30 Nov 2020 16:31:53 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 16:31:52 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id E02C52ECA5FC; Mon, 30 Nov 2020 16:31:44 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH v2 bpf-next 1/7] bpf: fix bpf_put_raw_tracepoint()'s use of __module_address()
Date:   Mon, 30 Nov 2020 16:31:31 -0800
Message-ID: <20201201003137.1692914-2-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201201003137.1692914-1-andrii@kernel.org>
References: <20201201003137.1692914-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_12:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=797
 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=8 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012010000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

__module_address() needs to be called with preemption disabled or with
module_mutex taken. preempt_disable() is enough for read-only uses, which is
what this fix does. Also, module_put() does internal check for NULL, so drop
it as well.

Fixes: a38d1107f937 ("bpf: support raw tracepoints in modules")
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/bpf_trace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d255bc9b2bfa..23a390aac524 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2060,10 +2060,12 @@ struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name)
 
 void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 {
-	struct module *mod = __module_address((unsigned long)btp);
+	struct module *mod;
 
-	if (mod)
-		module_put(mod);
+	preempt_disable();
+	mod = __module_address((unsigned long)btp);
+	module_put(mod);
+	preempt_enable();
 }
 
 static __always_inline
-- 
2.24.1


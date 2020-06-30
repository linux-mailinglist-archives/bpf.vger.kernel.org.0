Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F06920EE94
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 08:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgF3GeM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 02:34:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50106 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730002AbgF3GeM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Jun 2020 02:34:12 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U6StTP018750
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 23:34:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kRyshNtqpdYOMp9DHrkzg6Ozozw/ZB7f/leGOK7exq0=;
 b=IvXfTGQBTMAjmqIROl1jelKccu7UiNqXpK9lLbYezF8M3t8eajGGcxXFR1j4kWPXtlbB
 mzb1vUUCOXEvUcB5JUH4Nyhlk9aIXTpky4ESMn2cPqGEG+jEYU5cL3sObQ6UPIe36M2C
 ey/PUEnNbO9AWyOzj4Royqomc9vxprqVGZM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31xp398h3x-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 23:34:11 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 29 Jun 2020 23:34:07 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 32CA162E5214; Mon, 29 Jun 2020 23:28:55 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@chromium.org>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 bpf-next 3/4] bpf: allow %pB in bpf_seq_printf() and bpf_trace_printk()
Date:   Mon, 29 Jun 2020 23:28:45 -0700
Message-ID: <20200630062846.664389-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630062846.664389-1-songliubraving@fb.com>
References: <20200630062846.664389-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_01:2020-06-30,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 phishscore=0 cotscore=-2147483648 malwarescore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=8 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 mlxlogscore=999 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300048
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This makes it easy to dump stack trace in text.

Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/trace/bpf_trace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 977ba3b6f6c64..1d874d8e4384b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -376,7 +376,7 @@ static void bpf_trace_copy_string(char *buf, void *un=
safe_ptr, char fmt_ptype,
=20
 /*
  * Only limited trace_printk() conversion specifiers allowed:
- * %d %i %u %x %ld %li %lu %lx %lld %lli %llu %llx %p %pks %pus %s
+ * %d %i %u %x %ld %li %lu %lx %lld %lli %llu %llx %p %pB %pks %pus %s
  */
 BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	   u64, arg2, u64, arg3)
@@ -420,6 +420,11 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_s=
ize, u64, arg1,
 				goto fmt_str;
 			}
=20
+			if (fmt[i + 1] =3D=3D 'B') {
+				i++;
+				goto fmt_next;
+			}
+
 			/* disallow any further format extensions */
 			if (fmt[i + 1] !=3D 0 &&
 			    !isspace(fmt[i + 1]) &&
@@ -636,7 +641,8 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char=
 *, fmt, u32, fmt_size,
 		if (fmt[i] =3D=3D 'p') {
 			if (fmt[i + 1] =3D=3D 0 ||
 			    fmt[i + 1] =3D=3D 'K' ||
-			    fmt[i + 1] =3D=3D 'x') {
+			    fmt[i + 1] =3D=3D 'x' ||
+			    fmt[i + 1] =3D=3D 'B') {
 				/* just kernel pointers */
 				params[fmt_cnt] =3D args[fmt_cnt];
 				fmt_cnt++;
--=20
2.24.1


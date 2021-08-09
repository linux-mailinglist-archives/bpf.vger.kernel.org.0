Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCD33E3F82
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 08:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhHIGDo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 02:03:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24612 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233045AbhHIGDn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 02:03:43 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17960ikl012022
        for <bpf@vger.kernel.org>; Sun, 8 Aug 2021 23:03:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8O7EPMKwcEVKq8CKQP/N2pk1SHhV6DidSADlVJXFVfY=;
 b=e0BArxBXNpatndZlmUEtAlW9Lc7BUZPMh4marOfecoTcIbVxE1UctG2M62kT/E0Z2Mkj
 adPdoOOFlWsmD0hHuWty3CpPtFkBnsvPnvY0e4mTFGmhhhBKt06fuMGCMs06Sm/D+hr6
 Z2DGn/+IuCtWCDpG8pWa38h0QJk58tgrc68= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3a9npdf3ax-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 08 Aug 2021 23:03:23 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 8 Aug 2021 23:03:22 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 638125CD4D78; Sun,  8 Aug 2021 23:03:20 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf v2 2/2] bpf: add missing bpf_read_[un]lock_trace() for syscall program
Date:   Sun, 8 Aug 2021 23:03:20 -0700
Message-ID: <20210809060320.1176782-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809060310.1174777-1-yhs@fb.com>
References: <20210809060310.1174777-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: eMkWb8nECcthqd6ZG011a2Y9hQ_kCSlT
X-Proofpoint-ORIG-GUID: eMkWb8nECcthqd6ZG011a2Y9hQ_kCSlT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_01:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxlogscore=809
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 79a7f8bdb159d ("bpf: Introduce bpf_sys_bpf() helper and program ty=
pe.")
added support for syscall program, which is a sleepable program.
But the program run missed bpf_read_lock_trace()/bpf_read_unlock_trace(),
which is needed to ensure proper rcu callback invocations.
This patch added bpf_read_[un]lock_trace() properly.

Fixes: 79a7f8bdb159d ("bpf: Introduce bpf_sys_bpf() helper and program ty=
pe.")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 net/bpf/test_run.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 1cc75c811e24..caa16bf30fb5 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -7,6 +7,7 @@
 #include <linux/vmalloc.h>
 #include <linux/etherdevice.h>
 #include <linux/filter.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/sched/signal.h>
 #include <net/bpf_sk_storage.h>
 #include <net/sock.h>
@@ -951,7 +952,10 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 			goto out;
 		}
 	}
+
+	rcu_read_lock_trace();
 	retval =3D bpf_prog_run_pin_on_cpu(prog, ctx);
+	rcu_read_unlock_trace();
=20
 	if (copy_to_user(&uattr->test.retval, &retval, sizeof(u32))) {
 		err =3D -EFAULT;
--=20
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7541D3FF23E
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 19:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346580AbhIBRYA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 13:24:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42216 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346572AbhIBRYA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Sep 2021 13:24:00 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 182HMqgt015188
        for <bpf@vger.kernel.org>; Thu, 2 Sep 2021 10:23:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vq73fmlrgDVMhmoBTL2WYtHf8hO+h7XFK/jPCyEUk9s=;
 b=cnwjWWE0QLa4C8jnzKIgqT5xu8obsnygTdVYNymBgpjeLtMjwWmbcEnPn3DFkEuL8gSz
 juN7oqivJI1NY4+bs4SaaWxB1oYW7AOeq6N7QzdEW9OqcJY+tOpVxzqIcxEcHEJ1CbTu
 pve1KFMb7BMc0NCBWi25p7KywWAO5AUWvQg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3atdx7m4ws-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Sep 2021 10:23:01 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 2 Sep 2021 10:22:57 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id C3F075FE248D; Thu,  2 Sep 2021 10:20:01 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, <netdev@vger.kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v4 bpf-next 5/9] libbpf: use static const fmt string in __bpf_printk
Date:   Thu, 2 Sep 2021 10:19:25 -0700
Message-ID: <20210902171929.3922667-6-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210902171929.3922667-1-davemarchevsky@fb.com>
References: <20210902171929.3922667-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: -vwoaSruIXXZo9vDrBTS-NZ8uhIFxfrc
X-Proofpoint-ORIG-GUID: -vwoaSruIXXZo9vDrBTS-NZ8uhIFxfrc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_04:2021-09-02,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=937
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109020100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The __bpf_printk convenience macro was using a 'char' fmt string holder
as it predates support for globals in libbpf. Move to more efficient
'static const char', but provide a fallback to the old way via
BPF_NO_GLOBAL_DATA so users on old kernels can still use the macro.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/lib/bpf/bpf_helpers.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index a7e73be6dac4..7df7d9a23099 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -216,10 +216,16 @@ enum libbpf_tristate {
 		     ___param, sizeof(___param));		\
 })
=20
+#ifdef BPF_NO_GLOBAL_DATA
+#define BPF_PRINTK_FMT_MOD
+#else
+#define BPF_PRINTK_FMT_MOD static const
+#endif
+
 /* Helper macro to print out debug messages */
 #define __bpf_printk(fmt, ...)				\
 ({							\
-	char ____fmt[] =3D fmt;				\
+	BPF_PRINTK_FMT_MOD char ____fmt[] =3D fmt;	\
 	bpf_trace_printk(____fmt, sizeof(____fmt),	\
 			 ##__VA_ARGS__);		\
 })
--=20
2.30.2


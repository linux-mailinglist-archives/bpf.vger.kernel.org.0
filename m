Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47D93FA3D5
	for <lists+bpf@lfdr.de>; Sat, 28 Aug 2021 07:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhH1FV1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Aug 2021 01:21:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21500 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233117AbhH1FVX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 28 Aug 2021 01:21:23 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17S5EJhv027036
        for <bpf@vger.kernel.org>; Fri, 27 Aug 2021 22:20:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=npoIg0hH/PLsSOOKa3cr7jFeeSikgJuTg/witRzt/oE=;
 b=M3akIRCH7Ja6gdhaQDf/BNkFYvgOeIdk0JOalmsQhAlBkf06FLL86JoPIlcIaLNYP+tM
 DAPWKFGSrdrUh5TQCqA2E1R+NxYqg8GAaKptE1e2DrYomI1+FgjmSZtmET2K7TWH4e6Z
 nQlPhzv6hCeTPIkQQ16nLP/ZBEQ2ECeiifc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aq0vv4ru6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 27 Aug 2021 22:20:33 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 27 Aug 2021 22:20:31 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 4AD475BF0E41; Fri, 27 Aug 2021 22:20:25 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, <netdev@vger.kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v3 bpf-next 5/7] bpftool: only probe trace_vprintk feature in 'full' mode
Date:   Fri, 27 Aug 2021 22:20:04 -0700
Message-ID: <20210828052006.1313788-6-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210828052006.1313788-1-davemarchevsky@fb.com>
References: <20210828052006.1313788-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: c57A1hrBRPZn7ffV6IE70cIBaftXcrq9
X-Proofpoint-ORIG-GUID: c57A1hrBRPZn7ffV6IE70cIBaftXcrq9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-28_01:2021-08-27,2021-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 phishscore=0 mlxscore=0 spamscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108280031
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since commit 368cb0e7cdb5e ("bpftool: Make probes which emit dmesg
warnings optional"), some helpers aren't probed by bpftool unless
`full` arg is added to `bpftool feature probe`.

bpf_trace_vprintk can emit dmesg warnings when probed, so include it.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/bpf/bpftool/feature.c                 |  1 +
 tools/testing/selftests/bpf/test_bpftool.py | 22 +++++++++------------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 7f36385aa9e2..ade44577688e 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -624,6 +624,7 @@ probe_helpers_for_progtype(enum bpf_prog_type prog_ty=
pe, bool supported_type,
 		 */
 		switch (id) {
 		case BPF_FUNC_trace_printk:
+		case BPF_FUNC_trace_vprintk:
 		case BPF_FUNC_probe_write_user:
 			if (!full_mode)
 				continue;
diff --git a/tools/testing/selftests/bpf/test_bpftool.py b/tools/testing/=
selftests/bpf/test_bpftool.py
index 4fed2dc25c0a..1c2408ee1f5d 100644
--- a/tools/testing/selftests/bpf/test_bpftool.py
+++ b/tools/testing/selftests/bpf/test_bpftool.py
@@ -57,6 +57,11 @@ def default_iface(f):
         return f(*args, iface, **kwargs)
     return wrapper
=20
+DMESG_EMITTING_HELPERS =3D [
+        "bpf_probe_write_user",
+        "bpf_trace_printk",
+        "bpf_trace_vprintk",
+    ]
=20
 class TestBpftool(unittest.TestCase):
     @classmethod
@@ -67,10 +72,7 @@ class TestBpftool(unittest.TestCase):
=20
     @default_iface
     def test_feature_dev_json(self, iface):
-        unexpected_helpers =3D [
-            "bpf_probe_write_user",
-            "bpf_trace_printk",
-        ]
+        unexpected_helpers =3D DMESG_EMITTING_HELPERS
         expected_keys =3D [
             "syscall_config",
             "program_types",
@@ -94,10 +96,7 @@ class TestBpftool(unittest.TestCase):
             bpftool_json(["feature", "probe"]),
             bpftool_json(["feature"]),
         ]
-        unexpected_helpers =3D [
-            "bpf_probe_write_user",
-            "bpf_trace_printk",
-        ]
+        unexpected_helpers =3D DMESG_EMITTING_HELPERS
         expected_keys =3D [
             "syscall_config",
             "system_config",
@@ -121,10 +120,7 @@ class TestBpftool(unittest.TestCase):
             bpftool_json(["feature", "probe", "kernel", "full"]),
             bpftool_json(["feature", "probe", "full"]),
         ]
-        expected_helpers =3D [
-            "bpf_probe_write_user",
-            "bpf_trace_printk",
-        ]
+        expected_helpers =3D DMESG_EMITTING_HELPERS
=20
         for tc in test_cases:
             # Check if expected helpers are included at least once in an=
y
@@ -157,7 +153,7 @@ class TestBpftool(unittest.TestCase):
                 not_full_set.add(helper)
=20
         self.assertCountEqual(full_set - not_full_set,
-                                {"bpf_probe_write_user", "bpf_trace_prin=
tk"})
+                              set(DMESG_EMITTING_HELPERS))
         self.assertCountEqual(not_full_set - full_set, set())
=20
     def test_feature_macros(self):
--=20
2.30.2


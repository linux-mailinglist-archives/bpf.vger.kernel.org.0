Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052E243A6A7
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 00:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbhJYWgV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 18:36:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19136 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234062AbhJYWgR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 18:36:17 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PMGOX3032442
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:33:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=jJr/4bFptm4EtxMcaSxtaJp8UT8C+DrSPhikIZhImmQ=;
 b=WBtf8i2xDIo6LNZp7kzpoefg9Bk3Yzj7gzQPWVw3N2lsjYJLSoSa4oUl7CcmoqFfoNWH
 R44j/AcU7CGHG1RQ3gmEeWqcOCIbQFNl4nu0amaR9jGpHxj1a1YFrDFSdo2ffAyVrGEw
 cfIc9R1IqgEy19/rIO2OF6VBsiGhofdeme0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bx4e7gef1-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:33:54 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 25 Oct 2021 15:33:53 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 414BB5DB8D40; Mon, 25 Oct 2021 15:33:46 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, Yucong Sun <sunyucong@gmail.com>
Subject: [PATCH bpf-next 3/4] selftests/bpf: fix attach_probe in parallel mode
Date:   Mon, 25 Oct 2021 15:33:44 -0700
Message-ID: <20211025223345.2136168-4-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025223345.2136168-1-fallentree@fb.com>
References: <20211025223345.2136168-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: qwcA43GAWgPo1EiWdMk7rMXz5sbr1KfK
X-Proofpoint-ORIG-GUID: qwcA43GAWgPo1EiWdMk7rMXz5sbr1KfK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_07,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=399
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110250127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This patch makes attach_probe uses its own method as attach point,
avoiding conflict with other tests like bpf_cookie.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/attach_probe.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tool=
s/testing/selftests/bpf/prog_tests/attach_probe.c
index 6c511dcd1465..d0bd51eb23c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -5,6 +5,11 @@
 /* this is how USDT semaphore is actually defined, except volatile modif=
ier */
 volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribu=
te((section(".probes")));
=20
+/* attach point */
+static void method(void) {
+	return ;
+}
+
 void test_attach_probe(void)
 {
 	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
@@ -33,7 +38,7 @@ void test_attach_probe(void)
 	if (CHECK(base_addr < 0, "get_base_addr",
 		  "failed to find base addr: %zd", base_addr))
 		return;
-	uprobe_offset =3D get_uprobe_offset(&get_base_addr, base_addr);
+	uprobe_offset =3D get_uprobe_offset(&method, base_addr);
=20
 	ref_ctr_offset =3D get_rel_offset((uintptr_t)&uprobe_ref_ctr);
 	if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
@@ -98,7 +103,7 @@ void test_attach_probe(void)
 		goto cleanup;
=20
 	/* trigger & validate uprobe & uretprobe */
-	get_base_addr();
+	method();
=20
 	if (CHECK(skel->bss->uprobe_res !=3D 3, "check_uprobe_res",
 		  "wrong uprobe res: %d\n", skel->bss->uprobe_res))
--=20
2.30.2


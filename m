Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC6B127203
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 01:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfLTAGI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 19:06:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60074 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726952AbfLTAGI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Dec 2019 19:06:08 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBK065Dc027783
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 16:06:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=tgxsbb75xYTsX1XasmXEy3vduWeJK7gddMxmt+iVejI=;
 b=gplEJYxb/Nz5GAmIM44EWc/6v7wjwhtwTQ7zc3ip/TGEEfA7dn3B7/5/qHg3/2pMnyDe
 upxBpxwy8e+W94bxedijXAoAbF4OAulJmtfB3xXYu5ZCLxHMm6IjF664bZ6zEgt9EFwu
 IcdBLVmGOPX45emPY5sa41GqfjpCEDO9UB8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2wyqmcqvq9-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 16:06:06 -0800
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 19 Dec 2019 16:05:49 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 7F5EA3713995; Thu, 19 Dec 2019 16:05:48 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <andriin@fb.com>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] selftests/bpf: Preserve errno in test_progs CHECK macros
Date:   Thu, 19 Dec 2019 16:05:11 -0800
Message-ID: <20191220000511.1684853-1-rdna@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_08:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=643 suspectscore=1 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190176
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's follow-up for discussion [1]

CHECK and CHECK_FAIL macros in test_progs.h can affect errno in some
circumstances, e.g. if some code accidentally closes stdout. It makes
checking errno in patterns like this unreliable:

	if (CHECK(!bpf_prog_attach_xattr(...), "tag", "msg"))
		goto err;
	CHECK_FAIL(errno != ENOENT);

, since by CHECK_FAIL time errno could be affected not only by
bpf_prog_attach_xattr but by CHECK as well.

Fix it by saving and restoring errno in the macros. There is no "Fixes"
tag since no problems were discovered yet and it's rather precaution.

test_progs was run with this change and no difference was identified.

[1] https://lore.kernel.org/bpf/20191219210907.GD16266@rdna-mbp.dhcp.thefacebook.com/

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/testing/selftests/bpf/test_progs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 8477df835979..de1fdaa4e7b4 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -100,6 +100,7 @@ extern struct ipv6_packet pkt_v6;
 
 #define _CHECK(condition, tag, duration, format...) ({			\
 	int __ret = !!(condition);					\
+	int __save_errno = errno;					\
 	if (__ret) {							\
 		test__fail();						\
 		printf("%s:FAIL:%s ", __func__, tag);			\
@@ -108,15 +109,18 @@ extern struct ipv6_packet pkt_v6;
 		printf("%s:PASS:%s %d nsec\n",				\
 		       __func__, tag, duration);			\
 	}								\
+	errno = __save_errno;						\
 	__ret;								\
 })
 
 #define CHECK_FAIL(condition) ({					\
 	int __ret = !!(condition);					\
+	int __save_errno = errno;					\
 	if (__ret) {							\
 		test__fail();						\
 		printf("%s:FAIL:%d\n", __func__, __LINE__);		\
 	}								\
+	errno = __save_errno;						\
 	__ret;								\
 })
 
-- 
2.17.1


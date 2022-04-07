Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23724F895E
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 00:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiDGVqm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 17:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiDGVql (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 17:46:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B480E616D
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 14:44:39 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237KkrP3028403;
        Thu, 7 Apr 2022 21:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pu22nIht/rr+t5kBN4TZpdw6qTDKHqnKLhZNV7lj26E=;
 b=U44yOTciRNRP2Dv1g9oHG0lLquh3hV/ZJdXkutjK6VUJjk5HNuSuJZOK+uU98wyLqiFa
 NnaGpzAJ2mxnevpkZWv3WheZ58fUkliV5SenZglAtkBKz03iJOHNHUmhB414JXg8wTPs
 37/GXwkOrc97cCxYhLq5kzFK6Mmqh+jJhrmiUS6pV3d3rlkBVzwWCkzVOWyK7PBGC8Mh
 jQajQulGuEMs6Nynhs0P0D3LbmzhWhkl501UpnsiNmJ4wmYPToQ+Yq/MmVxGKOwfTiSy
 M8ZsbcPE3n9YjZWY27V2HOhpTHQsRopezhrvTpmlLPOVnyquUERRTos2nCB5BDJpulOh kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fa4jwmswg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 21:44:19 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 237LedLE013183;
        Thu, 7 Apr 2022 21:44:19 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fa4jwmsw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 21:44:18 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 237LbnUL022514;
        Thu, 7 Apr 2022 21:44:17 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3f6e490qca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 21:44:17 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 237LVtZC52363640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Apr 2022 21:31:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE58A4C044;
        Thu,  7 Apr 2022 21:44:13 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8143E4C046;
        Thu,  7 Apr 2022 21:44:13 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.171.82.41])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Apr 2022 21:44:13 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 1/3] libbpf: Minor style improvements in USDT code
Date:   Thu,  7 Apr 2022 23:44:09 +0200
Message-Id: <20220407214411.257260-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407214411.257260-1-iii@linux.ibm.com>
References: <20220407214411.257260-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8-Y7i7W5T7xnaFTVOqnkhvNnHfniRhtF
X-Proofpoint-ORIG-GUID: lfDQNTdHdULO7Y3dLHY-xjy1a8lOXOzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_05,2022-04-07_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix several typos and references to non-existing headers.
Also use __BYTE_ORDER__ instead of __BYTE_ORDER for consistency with
the rest of the bpf code - see commit 45f2bebc8079 ("libbpf: Fix
endianness detection in BPF_CORE_READ_BITFIELD_PROBED()") for
rationale).

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/usdt.bpf.h |  4 ++--
 tools/lib/bpf/usdt.c     | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 60237acf6b02..420d743734e1 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -166,7 +166,7 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 	case BPF_USDT_ARG_REG_DEREF:
 		/* Arg is in memory addressed by register, plus some offset
 		 * (e.g., "-4@-1204(%rbp)" in USDT arg spec). Register is
-		 * identified lik with BPF_USDT_ARG_REG case, and the offset
+		 * identified like with BPF_USDT_ARG_REG case, and the offset
 		 * is in arg_spec->val_off. We first fetch register contents
 		 * from pt_regs, then do another user-space probe read to
 		 * fetch argument value itself.
@@ -198,7 +198,7 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 /* Retrieve user-specified cookie value provided during attach as
  * bpf_usdt_opts.usdt_cookie. This serves the same purpose as BPF cookie
  * returned by bpf_get_attach_cookie(). Libbpf's support for USDT is itself
- * utilizaing BPF cookies internally, so user can't use BPF cookie directly
+ * utilizing BPF cookies internally, so user can't use BPF cookie directly
  * for USDT programs and has to use bpf_usdt_cookie() API instead.
  */
 static inline __noinline
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index c5acf2824fcc..99a7c614c7b1 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -108,7 +108,7 @@
  * code through spec map. This allows BPF applications to quickly fetch the
  * actual value at runtime using a simple BPF-side code.
  *
- * With basics out of the way, let's go over less immeditately obvious aspects
+ * With basics out of the way, let's go over less immediately obvious aspects
  * of supporting USDTs.
  *
  * First, there is no special USDT BPF program type. It is actually just
@@ -189,14 +189,14 @@
 #define USDT_NOTE_TYPE 3
 #define USDT_NOTE_NAME "stapsdt"
 
-/* should match exactly enum __bpf_usdt_arg_type from bpf_usdt.bpf.h */
+/* should match exactly enum __bpf_usdt_arg_type from usdt.bpf.h */
 enum usdt_arg_type {
 	USDT_ARG_CONST,
 	USDT_ARG_REG,
 	USDT_ARG_REG_DEREF,
 };
 
-/* should match exactly struct __bpf_usdt_arg_spec from bpf_usdt.bpf.h */
+/* should match exactly struct __bpf_usdt_arg_spec from usdt.bpf.h */
 struct usdt_arg_spec {
 	__u64 val_off;
 	enum usdt_arg_type arg_type;
@@ -328,9 +328,9 @@ static int sanity_check_usdt_elf(Elf *elf, const char *path)
 		return -EBADF;
 	}
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	endianness = ELFDATA2LSB;
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 	endianness = ELFDATA2MSB;
 #else
 # error "Unrecognized __BYTE_ORDER__"
@@ -843,7 +843,7 @@ static int bpf_link_usdt_detach(struct bpf_link *link)
 						   sizeof(*new_free_ids));
 		/* If we couldn't resize free_spec_ids, we'll just leak
 		 * a bunch of free IDs; this is very unlikely to happen and if
-		 * system is so exausted on memory, it's the least of user's
+		 * system is so exhausted on memory, it's the least of user's
 		 * concerns, probably.
 		 * So just do our best here to return those IDs to usdt_manager.
 		 */
-- 
2.35.1


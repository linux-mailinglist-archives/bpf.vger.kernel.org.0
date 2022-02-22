Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4877B4C013B
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 19:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiBVS0z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 13:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiBVS0x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 13:26:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6EBEB31C
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 10:26:27 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MI2q4h020847;
        Tue, 22 Feb 2022 18:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8Na+pwHKxSHP/I+5wsUzu+CPNkaFD9bCPJJys8IM5u0=;
 b=j5H4Ng7QRBpDO/YVcendpPd+rQSvMG9rmECYveRSu87GuBrDktbJyVURrnSthpgMRNVt
 uHQ9Fo3W4lIoh/tSApyr1qgOcYFHj1r41qraAHNC0iTPNFYwB+Yqu0u3sBij/G8aOtJ+
 V8bv/MEdFu3GhQB30nbp3fh6CgNF0+gbiC9PXQ0V9IfkBl2Szvs0H9qclJTiAZiXfJm5
 vURSINl2pNYDoamue4SEvbGoYDTaBvjGWKLPc75b50VCfHkloNknuY3Xu5ZeHC+/WPl7
 Yik/AG2uqaiqPTldPbx4l+omtJQaq2lSGkx8XnlS5Kv+mIZZM3kzkN04xiZLoTLj5Nds tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed0gj8gbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 18:26:11 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21MIJn7a003291;
        Tue, 22 Feb 2022 18:26:10 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed0gj8gat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 18:26:10 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MIPABB007458;
        Tue, 22 Feb 2022 18:26:08 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3ear693tgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 18:26:08 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MIQ37I57803022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 18:26:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FB244C04E;
        Tue, 22 Feb 2022 18:26:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A2354C046;
        Tue, 22 Feb 2022 18:26:03 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Feb 2022 18:26:03 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC bpf-next 2/3] bpf: Fix bpf_sk_lookup.remote_port on big-endian
Date:   Tue, 22 Feb 2022 19:25:58 +0100
Message-Id: <20220222182559.2865596-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222182559.2865596-1-iii@linux.ibm.com>
References: <20220222182559.2865596-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w96nR7VG0-KsVoxLMptKemRZrTkGJGlq
X-Proofpoint-GUID: vbbt771jMePlFPRRQd9sI_2nJz3tR2E3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_05,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On big-endian, the port is available in the second __u16, not the first
one. Therefore, provide a big-endian-specific definition that reflects
that. Also, define remote_port_compat in order to have nicer
architecture-agnostic code in the verifier and in tests.

Fixes: 9a69e2b385f4 ("bpf: Make remote_port field in struct bpf_sk_lookup 16-bit wide")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/uapi/linux/bpf.h       | 17 +++++++++++++++--
 net/core/filter.c              |  5 ++---
 tools/include/uapi/linux/bpf.h | 17 +++++++++++++++--
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index afe3d0d7f5f2..7b0e5efa58e0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/bpf_common.h>
+#include <asm/byteorder.h>
 
 /* Extended instruction set based on top of classic BPF */
 
@@ -6453,8 +6454,20 @@ struct bpf_sk_lookup {
 	__u32 protocol;		/* IP protocol (IPPROTO_TCP, IPPROTO_UDP) */
 	__u32 remote_ip4;	/* Network byte order */
 	__u32 remote_ip6[4];	/* Network byte order */
-	__be16 remote_port;	/* Network byte order */
-	__u16 :16;		/* Zero padding */
+	union {
+		struct {
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
+			__be16 remote_port;	/* Network byte order */
+			__u16 :16;		/* Zero padding */
+#elif defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
+			__u16 :16;		/* Zero padding */
+			__be16 remote_port;	/* Network byte order */
+#else
+#error unspecified endianness
+#endif
+		};
+		__u32 remote_port_compat;
+	};
 	__u32 local_ip4;	/* Network byte order */
 	__u32 local_ip6[4];	/* Network byte order */
 	__u32 local_port;	/* Host byte order */
diff --git a/net/core/filter.c b/net/core/filter.c
index 65869fd510e8..4b247d5aebe8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10856,8 +10856,7 @@ static bool sk_lookup_is_valid_access(int off, int size,
 	case bpf_ctx_range(struct bpf_sk_lookup, local_ip4):
 	case bpf_ctx_range_till(struct bpf_sk_lookup, remote_ip6[0], remote_ip6[3]):
 	case bpf_ctx_range_till(struct bpf_sk_lookup, local_ip6[0], local_ip6[3]):
-	case offsetof(struct bpf_sk_lookup, remote_port) ...
-	     offsetof(struct bpf_sk_lookup, local_ip4) - 1:
+	case bpf_ctx_range(struct bpf_sk_lookup, remote_port_compat):
 	case bpf_ctx_range(struct bpf_sk_lookup, local_port):
 	case bpf_ctx_range(struct bpf_sk_lookup, ingress_ifindex):
 		bpf_ctx_record_field_size(info, sizeof(__u32));
@@ -10938,7 +10937,7 @@ static u32 sk_lookup_convert_ctx_access(enum bpf_access_type type,
 #endif
 		break;
 	}
-	case offsetof(struct bpf_sk_lookup, remote_port):
+	case offsetof(struct bpf_sk_lookup, remote_port_compat):
 		*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
 				      bpf_target_off(struct bpf_sk_lookup_kern,
 						     sport, 2, target_size));
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index afe3d0d7f5f2..7b0e5efa58e0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/bpf_common.h>
+#include <asm/byteorder.h>
 
 /* Extended instruction set based on top of classic BPF */
 
@@ -6453,8 +6454,20 @@ struct bpf_sk_lookup {
 	__u32 protocol;		/* IP protocol (IPPROTO_TCP, IPPROTO_UDP) */
 	__u32 remote_ip4;	/* Network byte order */
 	__u32 remote_ip6[4];	/* Network byte order */
-	__be16 remote_port;	/* Network byte order */
-	__u16 :16;		/* Zero padding */
+	union {
+		struct {
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
+			__be16 remote_port;	/* Network byte order */
+			__u16 :16;		/* Zero padding */
+#elif defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
+			__u16 :16;		/* Zero padding */
+			__be16 remote_port;	/* Network byte order */
+#else
+#error unspecified endianness
+#endif
+		};
+		__u32 remote_port_compat;
+	};
 	__u32 local_ip4;	/* Network byte order */
 	__u32 local_ip6[4];	/* Network byte order */
 	__u32 local_port;	/* Host byte order */
-- 
2.34.1


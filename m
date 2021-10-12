Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B34429B7A
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 04:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhJLC1u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 22:27:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230330AbhJLC1u (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Oct 2021 22:27:50 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C1fw1s025492;
        Mon, 11 Oct 2021 22:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=x2KQzJhA10AcPNvYpnmodgQFjizHCTQf3PCDAxTy1WM=;
 b=ql5+4BWK6webJzD+505D++pfdZylhrFAc2ge7aHeeLGkPyXWepZ2BrUKf3KHMx5XSNfd
 tT7a/IVQ35Ki0a8uyz2x1tbmi6nuL4vuOOpJS6vKGWxYTiH6gOU+8qKp7N56LjUljZHg
 a9r7oUEallnNi02rdoxogvKuK8vHMCWgNZrpWHu5GLYadnXgdaS0DmzgvW6hj89jG4vs
 nlQ0qYAlI5EanpYuVCK7LPZy5nH/qFz9WVU705fMGJdQVi5aDWXSVOq5tmRQwqR5YLgS
 rQcjX8LZVpbz3bgTigQs/eu8nLGUmqrdwjNrP3+SqX9JCGMG8Ajf9vIF723NacTH2qOx 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn0x2gjxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 22:25:36 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19C29kRi005598;
        Mon, 11 Oct 2021 22:25:36 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn0x2gjwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 22:25:36 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19C2BKdt030494;
        Tue, 12 Oct 2021 02:25:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3bk2q9ucvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 02:25:33 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19C2PNV845547954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 02:25:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E24FBAE04D;
        Tue, 12 Oct 2021 02:25:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83A7EAE053;
        Tue, 12 Oct 2021 02:25:23 +0000 (GMT)
Received: from vm.lan (unknown [9.145.45.184])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Oct 2021 02:25:23 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH dwarves] dwarf_loader: Fix heap overflow when accessing variable specification
Date:   Tue, 12 Oct 2021 04:25:21 +0200
Message-Id: <20211012022521.399302-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yJ_qDGhtx0rtpdP5Yd7P3SJ_qBl-pmfP
X-Proofpoint-GUID: 9gZqsy3IhvsdQEOqb5FH_vOwE4lX-quG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-11_11,2021-10-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120006
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Variables can be allocated with or without specification, however,
tag__recode_dwarf_type() always tries accessing it, leading to heap
read overflows and subsequent logic bugs.

Fix by introducing a bit that tracks whether or not specification is
present.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 dwarf_loader.c | 15 ++++++++++-----
 dwarves.h      |  1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 48e1bf0..60bdca3 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -723,6 +723,7 @@ static struct variable *variable__new(Dwarf_Die *die, struct cu *cu, struct conf
 		var->external = dwarf_hasattr(die, DW_AT_external);
 		/* non-defining declaration of an object */
 		var->declaration = dwarf_hasattr(die, DW_AT_declaration);
+		var->has_specification = has_specification;
 		var->scope = VSCOPE_UNKNOWN;
 		INIT_LIST_HEAD(&var->annots);
 		var->ip.addr = 0;
@@ -2291,12 +2292,16 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 		goto find_type;
 	case DW_TAG_variable: {
 		struct variable *var = tag__variable(tag);
-		dwarf_off_ref specification = dwarf_tag__spec(dtag);
 
-		if (specification.off) {
-			dtype = dwarf_cu__find_tag_by_ref(cu->priv, &specification);
-			if (dtype)
-				var->spec = tag__variable(dtype->tag);
+		if (var->has_specification) {
+			dwarf_off_ref specification = dwarf_tag__spec(dtag);
+
+			if (specification.off) {
+				dtype = dwarf_cu__find_tag_by_ref(cu->priv,
+								  &specification);
+				if (dtype)
+					var->spec = tag__variable(dtype->tag);
+			}
 		}
 	}
 
diff --git a/dwarves.h b/dwarves.h
index 30d33fa..20608dd 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -691,6 +691,7 @@ struct variable {
 	const char	 *name;
 	uint8_t		 external:1;
 	uint8_t		 declaration:1;
+	uint8_t		 has_specification:1;
 	enum vscope	 scope;
 	struct location	 location;
 	struct hlist_node tool_hnode;
-- 
2.31.1


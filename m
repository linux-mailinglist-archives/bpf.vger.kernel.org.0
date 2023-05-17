Return-Path: <bpf+bounces-791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E812706DF9
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 18:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444311C20F95
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD6F18B1D;
	Wed, 17 May 2023 16:19:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D86111A1
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 16:19:42 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9167FD06C
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 09:19:13 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HE4xga029165;
	Wed, 17 May 2023 16:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=D5VQCrCVYMnoWCj5hpQbsUm2LYGoskTa9y26RR2o+FM=;
 b=HNQYwuVp/j575IiKO7OaBquLLkvU9DB2oXFhMlADdOJ4PlC2TmiujuVnMbuYMUpJsydu
 ZAvjko3vEQlExaPp58upBOlaPmkWdCz9LWQ50bVTTIIc9UvFyL5c0t8hXibMY7Y7qZvw
 //ir8uDG6kKPewUnGM5b3hcJSIO8qRnJxiHab7XjCPAF1dZguQQnSD7i48au5Ar937+p
 7PlakgjIxfgURuSV8/f0Nf9hNwbXYZ2UvaYbSd3aOzKDPJjL92wBASmSliRPy2x0cU+S
 NJfL0VGcfKFjkwUfcB22TGN+UtsDbc/qEmCYrjOaDH/gh1GkAQALKVVuSKQpxGY3pCOu Kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxfc0nwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 May 2023 16:17:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HFBnGu004297;
	Wed, 17 May 2023 16:17:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10bwyjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 May 2023 16:17:47 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34HGHdXB034295;
	Wed, 17 May 2023 16:17:47 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-213-201.vpn.oracle.com [10.175.213.201])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj10bwyb5-3;
	Wed, 17 May 2023 16:17:46 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, jolsa@kernel.org, yhs@fb.com,
        andrii@kernel.org
Cc: daniel@iogearbox.net, laoar.shao@gmail.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 2/6] dwarf_loader: store address in function low_pc if available
Date: Wed, 17 May 2023 17:16:44 +0100
Message-Id: <20230517161648.17582-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230517161648.17582-1-alan.maguire@oracle.com>
References: <20230517161648.17582-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170132
X-Proofpoint-GUID: _DQ8Vn_39I_DBb2sLMtQPNH_lZ8Cm_oG
X-Proofpoint-ORIG-GUID: _DQ8Vn_39I_DBb2sLMtQPNH_lZ8Cm_oG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

low_pc will be useful when we want to compare functions
by name and address.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarf_loader.c | 3 +++
 dwarves.h      | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index ccf3194..9271ac0 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1319,6 +1319,9 @@ static struct function *function__new(Dwarf_Die *die, struct cu *cu, struct conf
 				    attr_type(die, DW_AT_specification));
 		func->accessibility   = attr_numeric(die, DW_AT_accessibility);
 		func->virtuality      = attr_numeric(die, DW_AT_virtuality);
+		func->has_low_pc      = dwarf_hasattr(die, DW_AT_low_pc);
+		if (func->has_low_pc)
+			dwarf_lowpc(die, &func->low_pc);
 		INIT_LIST_HEAD(&func->vtable_node);
 		INIT_LIST_HEAD(&func->annots);
 		INIT_LIST_HEAD(&func->tool_node);
diff --git a/dwarves.h b/dwarves.h
index eb1a6df..9cf13dd 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -937,7 +937,9 @@ struct function {
 	uint8_t		 virtuality:2; /* DW_VIRTUALITY_{none,virtual,pure_virtual} */
 	uint8_t		 declaration:1;
 	uint8_t		 btf:1;
+	uint8_t		 has_low_pc:1;
 	int32_t		 vtable_entry;
+	uint64_t	 low_pc;
 	struct list_head vtable_node;
 	struct list_head annots;
 	/* fields used by tools */
-- 
2.31.1



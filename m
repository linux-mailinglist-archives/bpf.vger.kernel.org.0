Return-Path: <bpf+bounces-792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B41A706DFC
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 18:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CF228175C
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19531DDD9;
	Wed, 17 May 2023 16:19:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E16B111A1
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 16:19:58 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C34FD05D
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 09:19:35 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HE4nEs014834;
	Wed, 17 May 2023 16:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=S24qutHLaaJxCIglViLI7PbgR0IE8ZuL42+BcJhe9AM=;
 b=i9seVO8spReWS5pPQ5IUSsq8RUOtNvSRUvIe9zi0Blyenk/4km2RX+X20E5UiA2RmIRE
 CClIV7Kmt4SWD5cT5x5vez253Ox7k5P4a0REiblKjNtNdAweFjEcC8lXkkqyINmGJR2H
 Rn2qMnUlbY9o/QL2iIh2P5xKmK+85n1wBoRNuJ7/dMXfFhALuKyDvhGGK4vtL5kzyh3u
 /Fphk9iVuewvXkTsAROq3gSEzlK1k7NxIGl0gVTAwicUPApc/Vkkaz3Ca/SXMFbktDeL
 QHLxz2cArtk+v6JwXfwxIF9rjAtnnN4XTD5rM5AjCj/sy7cVvOQcpt77GRbcU8veICiv Mg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxps0kpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 May 2023 16:18:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HEtk69004238;
	Wed, 17 May 2023 16:18:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10bwyks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 May 2023 16:17:51 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34HGHdXD034295;
	Wed, 17 May 2023 16:17:50 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-213-201.vpn.oracle.com [10.175.213.201])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj10bwyb5-4;
	Wed, 17 May 2023 16:17:50 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, jolsa@kernel.org, yhs@fb.com,
        andrii@kernel.org
Cc: daniel@iogearbox.net, laoar.shao@gmail.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 3/6] dwarf_loader: transfer low_pc info from subtroutine to its abstract origin
Date: Wed, 17 May 2023 17:16:45 +0100
Message-Id: <20230517161648.17582-4-alan.maguire@oracle.com>
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
 engine=8.12.0-2304280000 definitions=main-2305170133
X-Proofpoint-GUID: Mx8w_wyiCQ4TJI_MRd_wSyaN9qx9bAlx
X-Proofpoint-ORIG-GUID: Mx8w_wyiCQ4TJI_MRd_wSyaN9qx9bAlx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

when recoding, often the subroutine DIE contains low_pc for a function
whereas the abstract origin it refers to does not; in such cases
copy the low_pc info into the abstract origin also.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarf_loader.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 9271ac0..ed94873 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2594,9 +2594,16 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 			dtype = dwarf_cu__find_tag_by_ref(cu->priv, &dtag->abstract_origin);
 			if (dtype == NULL)
 				dtype = dwarf_cu__find_tag_by_ref(cu->priv, &specification);
-			if (dtype != NULL)
-				fn->name = tag__function(dtype->tag)->name;
-			else {
+			if (dtype != NULL) {
+				struct function *ofn = tag__function(dtype->tag);
+
+				fn->name = ofn->name;
+				/* abstract origin may not have low_pc... */
+				if (fn->has_low_pc && !ofn->has_low_pc) {
+					ofn->has_low_pc = fn->has_low_pc;
+					ofn->low_pc = fn->low_pc;
+				}
+			} else {
 				fprintf(stderr,
 					"%s: couldn't find name for "
 					"function %#llx, abstract_origin=%#llx,"
-- 
2.31.1



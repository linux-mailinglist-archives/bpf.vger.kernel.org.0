Return-Path: <bpf+bounces-286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9F06FDE36
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 15:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EC52814A6
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 13:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1620512B77;
	Wed, 10 May 2023 13:03:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98152105
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 13:03:56 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83A5E4C
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 06:03:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A9JNxr008614;
	Wed, 10 May 2023 13:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=nOomCjTKET11otlBguF2sw3+CGWXQzWOEEborlgqHq0=;
 b=erOBnx5Uvt0hJRXuZlXhJQOKAMjCZ+2Pt1WGw5AJiACOEuyK6rZnxFLFuSrNyTVA7mWT
 U8BGmZoZBfvuGUtA+43awYDtER/ZNJI/G4Dn5mujenOs4FH0uSZlTXFOVJ/Owsj+A5gG
 SBdEcMD4Ie6TNlgS3PkFcy0Hh5R0go5qQumxdQmqMxxvxUM1/mY33wA90OJvRuzKiSan
 uMhXjWtx2zJ6bd1hGKLf8j40QoOXPrYT1xUMiaMr+VTx9aaP1UfNif8p7iaJxpRnZlMG
 X6dhg7Z+bBBjSL1Ypd+fiOBormexUhbTnysQ/ROeU4ClL+tuC1VzlbkZsqyj/9DlfHhQ kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7774g9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 May 2023 13:03:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34AC17gP021757;
	Wed, 10 May 2023 13:03:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8120e7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 May 2023 13:03:30 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34AD3T33000449;
	Wed, 10 May 2023 13:03:29 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-187-113.vpn.oracle.com [10.175.187.113])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qf8120duk-1;
	Wed, 10 May 2023 13:03:29 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org
Cc: jolsa@kernel.org, laoar.shao@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25
Date: Wed, 10 May 2023 14:02:41 +0100
Message-Id: <20230510130241.1696561-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100104
X-Proofpoint-GUID: _bEH5Z-tFfi9KJoq_YmMtgKqdYuSW-Vk
X-Proofpoint-ORIG-GUID: _bEH5Z-tFfi9KJoq_YmMtgKqdYuSW-Vk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

v1.25 of pahole supports filtering out functions with multiple inconsistent
function prototypes or optimized-out parameters from the BTF representation.
These present problems because there is no additional info in BTF saying which
inconsistent prototype matches which function instance to help guide attachment,
and functions with optimized-out parameters can lead to incorrect assumptions
about register contents.

So for now, filter out such functions while adding BTF representations for
functions that have "."-suffixes (foo.isra.0) but not optimized-out parameters.
This patch assumes that below linked changes land in pahole for v1.25.

Issues with pahole filtering being too aggressive in removing functions
appear to be resolved now, but CI and further testing will confirm.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/pahole-flags.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index 1f1f1d397c39..728d55190d97 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
 	# see PAHOLE_HAS_LANG_EXCLUDE
 	extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
 fi
+if [ "${pahole_ver}" -ge "125" ]; then
+	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
+fi
 
 echo ${extra_paholeopt}
-- 
2.31.1



Return-Path: <bpf+bounces-2739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0741B733750
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 19:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0D02817EE
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 17:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA031D2B7;
	Fri, 16 Jun 2023 17:18:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B6182D2
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:18:17 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8332D1FEC
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 10:18:16 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GCi1eU005887;
	Fri, 16 Jun 2023 17:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Wwkv+Kqw8/OXmGox5SyQllBP7KSjnv468H1H8hjs4Nk=;
 b=Sq0MHAXceKKzfj62HzajaQuVavjcv5rN0EOpZW8YGyXnIcfg7ZPFsgdhEuyS9tFoDPN/
 a6q60l7ooBSpBPrVokmX08uL2o2S135ET5fHL2QX4MD6pEhpJuMlgLdyQBxemOKaj2T0
 w88ToJFgaW08cNilKWc8w72nkDunHW2Nj9v2E8SzgtASAqF3Mnlnha9uYW7V3hXZeccg
 c/TjX5Wx8zrdyThTmwqjek5uXC954uctI3yWnr/64spPqxOcsL8q201EYtLwq0ieX1hv
 uN+1uIrBwoWN/3gfMKPHl+GRAPv3WDvMbArSeUCnEv8WvGdJG5AL2zM4LQefCna8Y0I6 PA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7dcrec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:17:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GG0HDu012477;
	Fri, 16 Jun 2023 17:17:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmertmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:17:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35GHGqPi007608;
	Fri, 16 Jun 2023 17:17:56 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-209-206.vpn.oracle.com [10.175.209.206])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r4fmert3d-7;
	Fri, 16 Jun 2023 17:17:56 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        quentin@isovalent.com, jolsa@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 6/9] btf: generate BTF kind layout for vmlinux/module BTF
Date: Fri, 16 Jun 2023 18:17:24 +0100
Message-Id: <20230616171728.530116-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230616171728.530116-1-alan.maguire@oracle.com>
References: <20230616171728.530116-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160155
X-Proofpoint-ORIG-GUID: 04TV9H26Cw_cR8mYPXPGzJ4duISDgeoc
X-Proofpoint-GUID: 04TV9H26Cw_cR8mYPXPGzJ4duISDgeoc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Generate BTF kind layout information, crcs for kernel and module BTF
if support is available in pahole.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/pahole-flags.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index 728d55190d97..cb304e0a4434 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -25,6 +25,13 @@ if [ "${pahole_ver}" -ge "124" ]; then
 fi
 if [ "${pahole_ver}" -ge "125" ]; then
 	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
+	pahole_help="$(${PAHOLE} --help)"
+	if [[ "$pahole_help" =~ "btf_gen_kind_layout" ]]; then
+		extra_paholeopt="${extra_paholeopt} --btf_gen_kind_layout"
+	fi
+	if [[ "$pahole_help" =~ "btf_gen_crc" ]]; then
+		extra_paholeopt="${extra_paholeopt} --btf_gen_crc"
+	fi
 fi
 
 echo ${extra_paholeopt}
-- 
2.39.3



Return-Path: <bpf+bounces-790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AE3706DF1
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 18:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7611C20FAC
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7413518B0F;
	Wed, 17 May 2023 16:19:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B69111A1
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 16:19:10 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA7D077
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 09:18:43 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HE4GQp002705;
	Wed, 17 May 2023 16:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=OzLZbYnQnORvB/XxFFPpzjD4jbXRtF3nDGfphYlzAao=;
 b=eGPQPtUIe2h11yaPrrC+tG7xd8335g3KvlezAqHv62E7czEAFrGYDDncSAqP51ZhI0o7
 ms4bKzJ2dhL6yQCL1Hfp6i/hQtwP4xiahedpxR4RThwIIaaEg45nxsKj0YlGeQEnyR5W
 ZnhuBlmgGi8iwF+3pfERnWxCVoW7hwQnVi1RYpRCaZeR09gWeWmiivNSdBVddhW3ijBu
 Qi+vlKefghrrRUgYbluaPtGPx2f+4QqFE5JGSF/OLO5ICfAEBnGDevSuCOIw55fTsoI5
 PRxXYm4H1u2b9O64uMz98fpxVvmF1NUg63oi3FS9eyJv+lFbI6fHSIV5kzf5Hr74n5ne Wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye5xs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 May 2023 16:17:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HFPodv004224;
	Wed, 17 May 2023 16:17:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10bwygs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 May 2023 16:17:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34HGHdX9034295;
	Wed, 17 May 2023 16:17:43 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-213-201.vpn.oracle.com [10.175.213.201])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj10bwyb5-2;
	Wed, 17 May 2023 16:17:43 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, jolsa@kernel.org, yhs@fb.com,
        andrii@kernel.org
Cc: daniel@iogearbox.net, laoar.shao@gmail.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 1/6] btf_encoder: record function address and if it is local
Date: Wed, 17 May 2023 17:16:43 +0100
Message-Id: <20230517161648.17582-2-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: tMrjzMNsXe9V5YbL4IBk2TZaPeEZkeAB
X-Proofpoint-GUID: tMrjzMNsXe9V5YbL4IBk2TZaPeEZkeAB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

this will help our encoding disambiguate functions.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 65f6e71..edf72e6 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -45,7 +45,9 @@ struct btf_encoder_state {
 struct elf_function {
 	const char	*name;
 	bool		 generated;
+	bool		local;
 	size_t		prefixlen;
+	uint64_t	addr;
 	struct function	*function;
 	struct btf_encoder_state state;
 };
@@ -1015,6 +1017,8 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
 		encoder->functions.entries[encoder->functions.cnt].prefixlen = suffix - name;
 	}
 	encoder->functions.entries[encoder->functions.cnt].generated = false;
+	encoder->functions.entries[encoder->functions.cnt].local = elf_sym__is_local_function(sym);
+	encoder->functions.entries[encoder->functions.cnt].addr = elf_sym__value(sym);
 	encoder->functions.entries[encoder->functions.cnt].function = NULL;
 	encoder->functions.entries[encoder->functions.cnt].state.got_proto = false;
 	encoder->functions.entries[encoder->functions.cnt].state.proto[0] = '\0';
-- 
2.31.1



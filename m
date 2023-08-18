Return-Path: <bpf+bounces-8093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 512A27810D6
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 18:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DAB1C21400
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42516138;
	Fri, 18 Aug 2023 16:47:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687A6612D
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 16:47:07 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359E63C2D
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 09:47:06 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IGHB0r014444;
	Fri, 18 Aug 2023 16:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bMYzy1l2B6MYPpdhP182Vyi2e9FMkpabAZn36pPSJYQ=;
 b=UfpbeQBH8wHlgAwWItTO548aItmNMTWasFxEmi1x29hg8aFk9XyIPEhEgTD78onZjgbM
 t9Tn+CZrtLGyFar1q/p/+oevGoP1bDzpnC3xZn39cdQMxA1HRhhE1caoOLUqxO/Xx1Ml
 ybCmCwavrmpvhQgcGmbwzKvtcrll7i3a9ydHaVb0OUXKJ1PC0Wt7p0xNHpSlQ/NMljRT
 p+b4djHclZ6qlyHWV/GwIjCIjbLU9lKcBapvOUZklrxOTOc2jid4uVTEnz/+jGbzUvOB
 wYxn0PyYoj1DXAQe/zNaIuDRt6ugR8uTBSxSt4hMDVPi3NZMBybTGgRu0IK6clVwjNH3 GQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjc1ggk5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:46:52 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37IFvoFm007839;
	Fri, 18 Aug 2023 16:46:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3senwm0cq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:46:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IGkmXF21365282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Aug 2023 16:46:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E1E520043;
	Fri, 18 Aug 2023 16:46:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 207B720040;
	Fri, 18 Aug 2023 16:46:47 +0000 (GMT)
Received: from Jinghaos-MacBook-Pro.watson.ibm.com (unknown [9.31.97.28])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Aug 2023 16:46:46 +0000 (GMT)
From: Jinghao Jia <jinghao@linux.ibm.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Jinghao Jia <jinghao@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH bpf 1/3] samples/bpf: Add -fsanitize=bounds to userspace programs
Date: Fri, 18 Aug 2023 12:46:41 -0400
Message-Id: <20230818164643.97782-2-jinghao@linux.ibm.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230818164643.97782-1-jinghao@linux.ibm.com>
References: <20230818164643.97782-1-jinghao@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cz1MKyNmC8a0pRBC7R_4winr09DqnXff
X-Proofpoint-GUID: cz1MKyNmC8a0pRBC7R_4winr09DqnXff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_20,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=832 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180152
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The sanitizer flag, which is supported by both clang and gcc, would make
it easier to debug array index out-of-bounds problems in these programs.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
---
 samples/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 595b98d825ce..340972ed1582 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -193,6 +193,7 @@ endif
 TPROGS_CFLAGS += -Wall -O2
 TPROGS_CFLAGS += -Wmissing-prototypes
 TPROGS_CFLAGS += -Wstrict-prototypes
+TPROGS_CFLAGS += -fsanitize=bounds
 
 TPROGS_CFLAGS += -I$(objtree)/usr/include
 TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
-- 
2.41.0



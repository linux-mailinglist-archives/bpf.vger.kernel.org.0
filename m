Return-Path: <bpf+bounces-8090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 579FE7810D1
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 18:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D571C213C0
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6352A566D;
	Fri, 18 Aug 2023 16:47:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0D626
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 16:47:05 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549BB4212
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 09:47:03 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IGemuY018060;
	Fri, 18 Aug 2023 16:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=xPa6TwbTqstmNLUbWCt9K/C1aIQUq3bVSxBWfuXm2bk=;
 b=IYE5V5q8WED4qRKHM8gY8MycEAyYU0XzT+4+7pf1SSaPqGDXT2AX27bpJT5kfU5mFxjB
 pWcHzZMhZs25WhtFvj3VoHppP1FyrLm+B1N40WluYuLbXkQWd0pE+hMr/KCmBw13x87b
 uG3XMmQbc2Nf2hOAJ0iW4EZpnKm02IfK3eyVcqbN/FyKPfn58oEZU2FmoxyL5H+fG40k
 BduI1I/KsJB/FX1BlhQvFIKMXrNuTvtijCOfcHWg6tPBRVJ68+5CDYhB1gets/du9oRS
 NhulC0efdI4lYTrqNs4o10FNmNwpadwOp9giIQrsYqU2G/V8bNolXx9HBSjGJXpKxiwI zw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjc6mgc4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:46:49 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37IFgEll002418;
	Fri, 18 Aug 2023 16:46:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendp0gmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:46:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IGkkdu31392476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Aug 2023 16:46:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E013C20043;
	Fri, 18 Aug 2023 16:46:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9B4920040;
	Fri, 18 Aug 2023 16:46:45 +0000 (GMT)
Received: from Jinghaos-MacBook-Pro.watson.ibm.com (unknown [9.31.97.28])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Aug 2023 16:46:45 +0000 (GMT)
From: Jinghao Jia <jinghao@linux.ibm.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Jinghao Jia <jinghao@linux.ibm.com>
Subject: [PATCH bpf 0/3] samples/bpf: syscall_tp_user: Refactor and fix array index out-of-bounds bug
Date: Fri, 18 Aug 2023 12:46:40 -0400
Message-Id: <20230818164643.97782-1-jinghao@linux.ibm.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MdqE8xdiTiGq4ZVBXLABA4M4AJu7j8Fz
X-Proofpoint-GUID: MdqE8xdiTiGq4ZVBXLABA4M4AJu7j8Fz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_20,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 suspectscore=0 mlxlogscore=441 malwarescore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180152
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are currently 6 BPF programs in syscall_tp_kern but the array to
hold the corresponding bpf_links in syscall_tp_user only has space for 4
programs, given the array size is hardcoded. This causes the sample
program to fail due to an out-of-bound access that corrupts other stack
variables:

  # ./syscall_tp
  prog #0: map ids 4 5
  verify map:4 val: 5
  map_lookup failed: Bad file descriptor

This patch series aims to solve this issue for now and for the future.
It first adds the -fsanitize=bounds flag to make similar bugs more
obvious at runtime. It then refactors syscall_tp_user to retrieve the
number of programs from the bpf_object and dynamically allocate the
array of bpf_links to avoid inconsistencies from hardcoding.

Jinghao Jia (3):
  samples/bpf: Add -fsanitize=bounds to userspace programs
  samples/bpf: syscall_tp_user: Rename num_progs into nr_tests
  samples/bpf: syscall_tp_user: Fix array out-of-bound access

 samples/bpf/Makefile          |  1 +
 samples/bpf/syscall_tp_user.c | 44 ++++++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 14 deletions(-)

-- 
2.41.0



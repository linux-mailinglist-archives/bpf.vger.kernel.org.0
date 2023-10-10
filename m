Return-Path: <bpf+bounces-11837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 374967C414D
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 22:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B910B2819C9
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 20:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19481315B1;
	Tue, 10 Oct 2023 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UwBCPwow"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05313225CF
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 20:35:32 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34D28E
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 13:35:31 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AKRVQ9022398;
	Tue, 10 Oct 2023 20:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Wv37tmo6TB2vunU6F6YVDQN53Oq5Mq8vnFGUl8ZqrKE=;
 b=UwBCPwowsZbpEIvFAXTXF56sfzMVV4SMMhJxAJg3bI07ZBpqeQ3pyBZc92HGnwDYWCZG
 ge/w9B7B45FMcKeIYwUI3ou6qgV5A7w65uo7gUyKfEN5/7Px/PmdpmYA14S394dQ0W/T
 theQnNxA5MGFam4raoDputGSpXAWXNtUdTFJ3fpd4dnYjHGgMRnj8M//w0oRG7CHOaI0
 vgE7RHBegz70Vq/lAVNirt3vHL1Bjkx9IF1nwCaYa/ib+vGghY32pmqoNmvWvLVrTRpr
 f8adw1KSVaSkxRfaAkU+E1vBTDAvvxoKoj1seUBQRR83UjQSq+nRU5BJoPy3xQQQ0wIm 3w== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tndnkreph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 20:35:18 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39AJuW2n000664;
	Tue, 10 Oct 2023 20:35:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkk5kjrs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 20:35:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39AKZEI220513518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Oct 2023 20:35:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E0E52004B;
	Tue, 10 Oct 2023 20:35:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B67820040;
	Tue, 10 Oct 2023 20:35:13 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.0.76])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Oct 2023 20:35:13 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, Song Liu <song@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf 0/2] s390/bpf: Fix backchain issues in the trampoline
Date: Tue, 10 Oct 2023 22:20:08 +0200
Message-ID: <20231010203512.385819-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 47NcBsDMppzMvs40cnuWFJVLrF0YNNDx
X-Proofpoint-GUID: 47NcBsDMppzMvs40cnuWFJVLrF0YNNDx
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_16,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=463 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 adultscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100159
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

Song reported that a patch he wrote was causing kernel panics on s390.
The disassembly printed by the kernel indicated that the stored
backchain was not a valid pointer; setting a watchpoint in GDB has
shown the culprit: the trampoline.

Currently it's implemented without regard for backchain: it clobbers
the caller's backchain and causes the issue reported by Song, and also
doesn't store its own, making it impossible to unwind past itself.

This series fixes both problems.

Best regards,
Ilya

[1] https://lore.kernel.org/bpf/20231004004350.533234-1-song@kernel.org/

Ilya Leoshkevich (2):
  s390/bpf: Fix clobbering the caller's backchain in the trampoline
  s390/bpf: Fix unwinding past the trampoline

 arch/s390/net/bpf_jit_comp.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

-- 
2.41.0



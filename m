Return-Path: <bpf+bounces-8947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3575478D193
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 03:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660CD1C20A94
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 01:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255D5111B;
	Wed, 30 Aug 2023 01:12:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED33010EE
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 01:12:03 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED93583
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 18:12:02 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U0a1dO029046;
	Wed, 30 Aug 2023 01:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bcvZJygyr01/7og6zyrbgcH7nGatryFdG9lnhhintjw=;
 b=Ip0e9V/db+dLRFa7SIyxQ/xPy0beSeALONCMwn+qIpQGEWglCE/mdMr41DjPDqgr/yEn
 w/iZzkLVcVlFM4RCJIS85zodpj7O4ee4OE59cYtIkQyXDlLYZnoN3gMfjXnUOP+iLJqr
 vh2VGyvlgMFP4hdSOVYqYuhlUgO5g2y4Oz4jbqFX0AgUofkvseGDVOZqyWnOhcz0C8nG
 wdjeJ/0kS9R2gG1JhOZPyQbK0m7+awkHua0mt8kFXbPLDHEo+LJOrgYuoCJ6VKmGu9a+
 mVMeiRtOuKB9ShOB1Jvg4GQDeA5JIhjlLxUMtCbhZ9hdN0oRftl7ZBEjyk9zPJzPtVvE NQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssu57rw5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 01:11:46 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37TNUTwi019258;
	Wed, 30 Aug 2023 01:11:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqxe1qen7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 01:11:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37U1Bg9t43450692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Aug 2023 01:11:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83B1C20043;
	Wed, 30 Aug 2023 01:11:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FD6120040;
	Wed, 30 Aug 2023 01:11:42 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.5.44])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Aug 2023 01:11:41 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 02/11] net: netfilter: Adjust timeouts of non-confirmed CTs in bpf_ct_insert_entry()
Date: Wed, 30 Aug 2023 03:07:43 +0200
Message-ID: <20230830011128.1415752-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830011128.1415752-1-iii@linux.ibm.com>
References: <20230830011128.1415752-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V6rtLsADEjdHDpk0JERCKw3Offmoed41
X-Proofpoint-ORIG-GUID: V6rtLsADEjdHDpk0JERCKw3Offmoed41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

bpf_nf testcase fails on s390x: bpf_skb_ct_lookup() cannot find the
entry that was added by bpf_ct_insert_entry() within the same BPF
function.

The reason is that this entry is deleted by nf_ct_gc_expired().

The CT timeout starts ticking after the CT confirmation; therefore
nf_conn.timeout is initially set to the timeout value, and
__nf_conntrack_confirm() sets it to the deadline value.
bpf_ct_insert_entry() sets IPS_CONFIRMED_BIT, but does not adjust the
timeout, making its value meaningless and causing false positives.

Fix the problem by making bpf_ct_insert_entry() adjust the timeout,
like __nf_conntrack_confirm().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 net/netfilter/nf_conntrack_bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index c7a6114091ae..b21799d468d2 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -381,6 +381,8 @@ __bpf_kfunc struct nf_conn *bpf_ct_insert_entry(struct nf_conn___init *nfct_i)
 	struct nf_conn *nfct = (struct nf_conn *)nfct_i;
 	int err;
 
+	if (!nf_ct_is_confirmed(nfct))
+		nfct->timeout += nfct_time_stamp;
 	nfct->status |= IPS_CONFIRMED;
 	err = nf_conntrack_hash_check_insert(nfct);
 	if (err < 0) {
-- 
2.41.0



Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1ED49533D
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 18:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiATRad (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 12:30:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45006 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229946AbiATRaA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 12:30:00 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20KHKiDw029600
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 09:29:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+uwt8erlza9mfrtHn/G6VyuVDE8Zr5xMraO6ecZ94Ss=;
 b=pcxmDR/7v2qdTdzOy+B9fhYncovJGBfwLog1MPf6SIMn2Z+Rwprs6hClouDvVTr6woYq
 5fFImzpV7LaEjzXaTQfeWP2v4yhtc5XYi4n+rgwWLq1iY5oxykXxPjwpwGKqVznR8EEn
 01ZVhuBwWIpqp3IlY48cX0xrwn/MnIjD7TA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dpysx433u-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 09:29:59 -0800
Received: from twshared22811.39.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 20 Jan 2022 09:29:57 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 7EE2A94F45C1; Thu, 20 Jan 2022 09:29:55 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <kennyyu@fb.com>
CC:     <alexei.starovoitov@gmail.com>, <andrii@kernel.org>,
        <ast@kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
        <phoenix1987@gmail.com>, <yhs@fb.com>
Subject: [PATCH v5 bpf-next 2/3] libbpf: Add "iter.s" section for sleepable bpf iterator programs
Date:   Thu, 20 Jan 2022 09:29:41 -0800
Message-ID: <20220120172942.246805-3-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120172942.246805-1-kennyyu@fb.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
 <20220120172942.246805-1-kennyyu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4uZWVYfKJ1zbAO9PUX-V2B1VDYRKoyPM
X-Proofpoint-GUID: 4uZWVYfKJ1zbAO9PUX-V2B1VDYRKoyPM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_06,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=798 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200090
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds a new bpf section "iter.s" to allow bpf iterator programs to
be sleepable.

Signed-off-by: Kenny Yu <kennyyu@fb.com>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fdb3536afa7d..9ec40835bce8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8599,6 +8599,7 @@ static const struct bpf_sec_def section_defs[] =3D =
{
 	SEC_DEF("lsm/",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s/",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, at=
tach_lsm),
 	SEC_DEF("iter/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter)=
,
+	SEC_DEF("iter.s/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEP=
ABLE, attach_iter),
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
 	SEC_DEF("xdp_devmap/",		XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
 	SEC_DEF("xdp_cpumap/",		XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
--=20
2.30.2


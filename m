Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70AA48E1BF
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 01:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbiANAtw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jan 2022 19:49:52 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10654 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238527AbiANAtw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Jan 2022 19:49:52 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20DN5pft007500
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 16:49:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+uwt8erlza9mfrtHn/G6VyuVDE8Zr5xMraO6ecZ94Ss=;
 b=TEGA7SwG+ifh6uoLVJyyydMeW3ef7HYVZDxrRx+bkPiVw0uWUJ432UE8YUfhJnYx270U
 tp1Cv9GRWErRayxtc7LTrr81s6z82P+HVuFI+Lj/hCnDIih4bVZUNwQdThBnoWxiiUmD
 H+Nz7jziyOZeN0Z7Vv2N6KMKOuSfY98x/2k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3djgfkwa39-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 16:49:52 -0800
Received: from twshared13833.42.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 16:49:30 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 0428A8FA32AD; Thu, 13 Jan 2022 16:49:17 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>
CC:     Kenny Yu <kennyyu@fb.com>
Subject: [PATCH v2 bpf-next 3/4] libbpf: Add "iter.s" section for sleepable bpf iterator programs
Date:   Thu, 13 Jan 2022 16:48:59 -0800
Message-ID: <20220114004900.3756025-4-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220114004900.3756025-1-kennyyu@fb.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
 <20220114004900.3756025-1-kennyyu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QPchBf86gjELoWUd-eBxtgfpJOIgVPil
X-Proofpoint-GUID: QPchBf86gjELoWUd-eBxtgfpJOIgVPil
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_10,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxlogscore=897
 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201140003
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


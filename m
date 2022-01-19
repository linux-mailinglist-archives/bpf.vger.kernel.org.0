Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE884494376
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 00:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344303AbiASXGz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 18:06:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15472 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344263AbiASXGt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Jan 2022 18:06:49 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JIs87L030844
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 15:06:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+uwt8erlza9mfrtHn/G6VyuVDE8Zr5xMraO6ecZ94Ss=;
 b=FWvqim8gKbm5iBZ1hEjhiP/0z3BIkkEVeTrbUCYUBQOvyNYF8TyJ8bZaJl0/rv7YLyMD
 go9b+057KolMz9iZdieJUWJROfy+ILXC1jdU8cDBIzVOiGxn5m6XUNr0Vh0mb2/A0bHT
 M/UNGChfMtKAaK7tJV5hgxVzns6PrmbT5Pc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dpafj6kd3-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 15:06:48 -0800
Received: from twshared10426.24.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 15:06:46 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 5DCCA945C583; Wed, 19 Jan 2022 14:59:38 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <kennyyu@fb.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>, <phoenix1987@gmail.com>,
        <alexei.starovoitov@gmail.com>
Subject: [PATCH v4 bpf-next 2/3] libbpf: Add "iter.s" section for sleepable bpf iterator programs
Date:   Wed, 19 Jan 2022 14:59:28 -0800
Message-ID: <20220119225929.2312908-3-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119225929.2312908-1-kennyyu@fb.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
 <20220119225929.2312908-1-kennyyu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gj6e2qQ2ORZkOuEFnENb2Kp8ZgedARsn
X-Proofpoint-GUID: gj6e2qQ2ORZkOuEFnENb2Kp8ZgedARsn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=801 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190122
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


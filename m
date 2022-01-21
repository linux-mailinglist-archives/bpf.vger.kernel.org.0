Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318CA49659F
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 20:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiAUTbZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 14:31:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33234 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232207AbiAUTbZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Jan 2022 14:31:25 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LG8bfU019662
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:31:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=TSbBKFKVG4yae2i0FF8tj3m9/N+Uxclv7Sy463OWTC4=;
 b=jhdmZJpFp7Ou563879VeDIL6AyqcpQXAEv5RCZf5fhFG787839/DQ54qxleIO8w4+Ai8
 xiXautWzjs6WzLhfDWS537IwvEwxqaW6ddmh8TPvrts8H+lCAKLY3dsi/domFll31/2y
 3kx2lY4lROhI3zk0gB4DkQKOzVMRMO+7ThA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dqhyvwcyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:31:24 -0800
Received: from twshared13036.24.prn2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 21 Jan 2022 11:31:23 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id F036195CDABB; Fri, 21 Jan 2022 11:31:19 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <kennyyu@fb.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>,
        <alexei.starovoitov@gmail.com>, <andrii.nakryiko@gmail.com>,
        <phoenix1987@gmail.com>
Subject: [PATCH v6 bpf-next 2/3] libbpf: Add "iter.s" section for sleepable bpf iterator programs
Date:   Fri, 21 Jan 2022 11:30:46 -0800
Message-ID: <20220121193047.3225019-3-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121193047.3225019-1-kennyyu@fb.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
 <20220121193047.3225019-1-kennyyu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1SIEaDZcpL7ZmprS0tBgVRbhAIwjUsMK
X-Proofpoint-GUID: 1SIEaDZcpL7ZmprS0tBgVRbhAIwjUsMK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_09,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=788 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201210127
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
index fc6d530e20db..ea7149606e67 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8607,6 +8607,7 @@ static const struct bpf_sec_def section_defs[] =3D =
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


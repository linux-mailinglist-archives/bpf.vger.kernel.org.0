Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F078494730
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 07:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiATGO4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 20 Jan 2022 01:14:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10822 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1358731AbiATGOg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 01:14:36 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20K5OViZ015976
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 22:14:36 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dq1jhg78g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 22:14:35 -0800
Received: from twshared2974.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 22:14:35 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5B763FBA1266; Wed, 19 Jan 2022 22:14:29 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/4] bpftool: use new API for attaching XDP program
Date:   Wed, 19 Jan 2022 22:14:20 -0800
Message-ID: <20220120061422.2710637-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120061422.2710637-1-andrii@kernel.org>
References: <20220120061422.2710637-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hpQLSeQvaJ6O4ccN1Q29mF0LPNNrhKeL
X-Proofpoint-GUID: hpQLSeQvaJ6O4ccN1Q29mF0LPNNrhKeL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_02,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=584
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200030
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch to new bpf_xdp_attach() API to avoid deprecation warnings.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 649053704bd7..526a332c48e6 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -551,7 +551,7 @@ static int do_attach_detach_xdp(int progfd, enum net_attach_type attach_type,
 	if (attach_type == NET_ATTACH_TYPE_XDP_OFFLOAD)
 		flags |= XDP_FLAGS_HW_MODE;
 
-	return bpf_set_link_xdp_fd(ifindex, progfd, flags);
+	return bpf_xdp_attach(ifindex, progfd, flags, NULL);
 }
 
 static int do_attach(int argc, char **argv)
-- 
2.30.2


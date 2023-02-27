Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2C06A4EE9
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 23:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjB0WuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 17:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjB0WuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 17:50:19 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9BA7D90
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 14:49:59 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RHYhKS011973
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 14:49:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=fEMqpTLEvEjiWJNW+6B5Wje5pRph/dljxs+tgoVt8Xg=;
 b=j33EZ6JKlJiSp6IdCv78QQPgMFnQeBqRELhznXcXFf77g3V7XziCYYRJ4lWtf3dShZhC
 qRw01oVGr/lCFL+bFaCixdTXfF4dxSEjgPyPYHxVSNyrRQ0hwvUFeZkDMb12d1Z/mieN
 nIg7kE3US+vY+33IM9BH1rxn2duvVUuHRfE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p109djssm-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 14:49:58 -0800
Received: from twshared1938.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 27 Feb 2023 14:49:57 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 2F64218FC69CF; Mon, 27 Feb 2023 14:49:43 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf] libbpf: Fix bpf_xdp_query() in old kernels
Date:   Mon, 27 Feb 2023 14:49:43 -0800
Message-ID: <20230227224943.1153459-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fISYOxlBzvI_RJCsweB3oG33z7cyClGp
X-Proofpoint-ORIG-GUID: fISYOxlBzvI_RJCsweB3oG33z7cyClGp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_17,2023-02-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 04d58f1b26a4("libbpf: add API to get XDP/XSK supported features")
added feature_flags to struct bpf_xdp_query_opts. If a user uses
bpf_xdp_query_opts with feature_flags member, the bpf_xdp_query()
will check whether 'netdev' family exists or not in the kernel.
If it does not exist, the bpf_xdp_query() will return -ENOENT.

But 'netdev' family does not exist in old kernels as it is
introduced in the same patch set as Commit 04d58f1b26a4.
So old kernel with newer libbpf won't work properly with
bpf_xdp_query() api call.

To fix this issue, if the return value of
libbpf_netlink_resolve_genl_family_id() is -ENOENT, bpf_xdp_query()
will just return 0, skipping the rest of xdp feature query.
This preserves backward compatibility.

Fixes: 04d58f1b26a4 ("libbpf: add API to get XDP/XSK supported features")
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/netlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 1653e7a8b0a1..4c1b3502f88d 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -468,8 +468,11 @@ int bpf_xdp_query(int ifindex, int xdp_flags, struct=
 bpf_xdp_query_opts *opts)
 		return 0;
=20
 	err =3D libbpf_netlink_resolve_genl_family_id("netdev", sizeof("netdev"=
), &id);
-	if (err < 0)
+	if (err < 0) {
+		if (err =3D=3D -ENOENT)
+			return 0;
 		return libbpf_err(err);
+	}
=20
 	memset(&req, 0, sizeof(req));
 	req.nh.nlmsg_len =3D NLMSG_LENGTH(GENL_HDRLEN);
--=20
2.30.2


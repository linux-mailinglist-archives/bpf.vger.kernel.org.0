Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3C163E92D
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 06:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiLAFFG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 00:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLAFEz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 00:04:55 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05731303C2
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 21:04:54 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B13PGDF021328
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 21:04:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=PEJ09p4OCWza+cKHBlaGXj7iNFruQZsVoGLB7WLButo=;
 b=S5xD66OYyxE/pDXp/jRZBdZ4/tmSkngiMjhngs1R1Ru/9b5IHPjLz1Y6rdecdw3EdK2z
 qQXRjwW96iF0yYZWjkBbko9Yd/tun6C3f56of6Yni8KXTaKmH/z4MwmwiBkEZ4QeXS7I
 OqECo4TgAJYrvLVmnp2XL25SYoYVVfeKVAs= 
Received: from maileast.thefacebook.com ([163.114.130.3])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m6mbe8h7t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 21:04:54 -0800
Received: from twshared2003.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 21:04:49 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 40C47130073F4; Wed, 30 Nov 2022 21:04:44 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Enable sleeptable support for cgrp local storage
Date:   Wed, 30 Nov 2022 21:04:44 -0800
Message-ID: <20221201050444.2785007-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4hbLSiR85G_oQlI0JsrM9inwYbiWWA8t
X-Proofpoint-GUID: 4hbLSiR85G_oQlI0JsrM9inwYbiWWA8t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_03,2022-11-30_02,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar to sk/inode/task local storage, enable sleepable support for
cgrp local storage.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d0ecc0b18b20..1170947c2d65 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14135,10 +14135,11 @@ static int check_map_prog_compatibility(struct =
bpf_verifier_env *env,
 		case BPF_MAP_TYPE_INODE_STORAGE:
 		case BPF_MAP_TYPE_SK_STORAGE:
 		case BPF_MAP_TYPE_TASK_STORAGE:
+		case BPF_MAP_TYPE_CGRP_STORAGE:
 			break;
 		default:
 			verbose(env,
-				"Sleepable programs can only use array, hash, and ringbuf maps\n");
+				"Sleepable programs can only use array, hash, ringbuf and local stor=
age maps\n");
 			return -EINVAL;
 		}
=20
--=20
2.30.2


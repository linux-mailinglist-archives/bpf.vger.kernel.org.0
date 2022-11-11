Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E6A625FEE
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 17:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiKKQ6J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 11:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiKKQ6H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 11:58:07 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF086A77D
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 08:58:06 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2ABFm6Cd002508
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 08:58:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NKQB4Ev1rEtTcyg271Lvtr5zhSjiWNaEOiL1osiMzvk=;
 b=g3/hnTwmNVcqgIYKqnXmoZXpuFOI37ijxq/9JsSbhR+fDBEy0MG4MMCcgXQy7j3ny7fG
 Mj9/aFw7QUmFB9GBJ7ccFxCOYc1gxODvwktn/mc9yuNt4VGuDdzUv3u8weFmzleBe4Xo
 ASstAkORd219R1P2seFXYTXB3HRt8kgnKcA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3ksbha58a1-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 08:58:05 -0800
Received: from twshared16963.27.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 08:58:03 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id A126511FF3EDB; Fri, 11 Nov 2022 08:58:00 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 5/7] bpf: Enable sleeptable support for cgrp local storage
Date:   Fri, 11 Nov 2022 08:58:00 -0800
Message-ID: <20221111165800.2527898-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111165734.2524596-1-yhs@fb.com>
References: <20221111165734.2524596-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: u3jVi39NgifeXmLr1xTOSlHtfxPS8DZE
X-Proofpoint-ORIG-GUID: u3jVi39NgifeXmLr1xTOSlHtfxPS8DZE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_08,2022-11-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With proper bpf_rcu_read_lock() support, sleepable support for cgrp local
storage can be enabled as typical use case task->cgroups->dfl_cgrp
can be protected with bpf_rcu_read_lock().

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2aa140dceb9a..92cd1cf64026 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12958,10 +12958,11 @@ static int check_map_prog_compatibility(struct =
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A7C620A81
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiKHHmC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiKHHlc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:41:32 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D188D19C32
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:41:26 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A86tk0n000888
        for <bpf@vger.kernel.org>; Mon, 7 Nov 2022 23:41:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=TCUibAe8jVtpiEb5lALNKMY5SdZeRe3QM7+aZeuOISo=;
 b=qiaItgF/JoWu2v8P5k+YCwGltpR327pJNaf3Gyvtd2UZxjozk4VGIKx/M/9Z8pEXzQQM
 aZ2Hg2MB7NsZ86A26C8k2GPnoBU7FjRaYKFlm1gEVhtjV+xLGuGKExHRNRlhazbWTtCV
 heq6ytBQKhbopjmR9kCgijm46laoRBydemI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kqj97g8s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:41:26 -0800
Received: from twshared6758.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 23:41:25 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 14CD111D23415; Mon,  7 Nov 2022 23:41:20 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 6/8] bpf: Enable sleeptable support for cgrp local storage
Date:   Mon, 7 Nov 2022 23:41:20 -0800
Message-ID: <20221108074120.265235-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108074047.261848-1-yhs@fb.com>
References: <20221108074047.261848-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: L1XwBSmTldihs45UNVSiL899Z4J2Nibp
X-Proofpoint-ORIG-GUID: L1XwBSmTldihs45UNVSiL899Z4J2Nibp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
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
index 85151f2a655a..5709eda21afd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12927,10 +12927,11 @@ static int check_map_prog_compatibility(struct =
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


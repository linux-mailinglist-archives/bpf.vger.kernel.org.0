Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F415D61778C
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 08:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKCHVm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 03:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiKCHVj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 03:21:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C4610EE
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 00:21:38 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2NVr1P022919
        for <bpf@vger.kernel.org>; Thu, 3 Nov 2022 00:21:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=7MZOOKe7yDIwEHfUzLNb3xnq1wXdmImbjhj1hcJAmZc=;
 b=Cw5JvVyYLct5T0WfN1Sc7T/LMNE8/C43GloYg+5fyQOsbxvPGPkG7jcwMMXaVrYuzeQb
 HrAUr9lBVLQu3qgwbp/ABcU5dbGPo7wOV0nLuJgf0dmP6afqQYikvbFB6cKYs/lEifX+
 8NIFakjAESJ9tSyQuQW83Vhs3cIhVeGLjQ4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kkj3bbm8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 00:21:37 -0700
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 00:21:36 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 1D06A1192D0C7; Thu,  3 Nov 2022 00:21:23 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 4/5] bpf: Enable sleeptable support for cgrp local storage
Date:   Thu, 3 Nov 2022 00:21:23 -0700
Message-ID: <20221103072123.2325032-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221103072102.2320490-1-yhs@fb.com>
References: <20221103072102.2320490-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MrkcQgNvBCCmH7jDnyomC1NvJ3EdUUdg
X-Proofpoint-GUID: MrkcQgNvBCCmH7jDnyomC1NvJ3EdUUdg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 3c5afd3bc216..47b897a28242 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12823,10 +12823,11 @@ static int check_map_prog_compatibility(struct =
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


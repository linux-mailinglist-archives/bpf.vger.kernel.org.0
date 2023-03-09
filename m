Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9726B2C8A
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 19:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCISCW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 13:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCISCV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 13:02:21 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53812FCBD6
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 10:02:20 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 329HRQ6o030448
        for <bpf@vger.kernel.org>; Thu, 9 Mar 2023 10:02:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vsbW0V7FSiW9ei6yvGJ/Q8hDOXu5kE6jasqxtuxytMU=;
 b=FfUTGC6zlHl0nnQ7U8tRAi96JXRrk/jVIeuL6+MDnSHR8+Utz8SOdrt+bHV0Be5ZPKfW
 twvKQl/KFdslrFJG67E5mv12FXbo6Bnu2MNN36C3gmXhcuNRUh/vC1rYdPv7upPixeBT
 O3fWcfiSdlnlJfuSHiJ5BvETwr4xTJcotZc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3p6ffungbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 10:02:18 -0800
Received: from twshared1938.08.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 9 Mar 2023 10:01:31 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 945DD18E84D2E; Thu,  9 Mar 2023 10:01:15 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 2/6] bpf: btf: Remove unused btf_field_info_type enum
Date:   Thu, 9 Mar 2023 10:01:07 -0800
Message-ID: <20230309180111.1618459-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309180111.1618459-1-davemarchevsky@fb.com>
References: <20230309180111.1618459-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: bJ7W8X3nnKqWfr59I98jVFLUNdgdo4pr
X-Proofpoint-ORIG-GUID: bJ7W8X3nnKqWfr59I98jVFLUNdgdo4pr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_09,2023-03-09_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This enum was added and used in commit aa3496accc41 ("bpf: Refactor kptr_=
off_tab
into btf_record"). Later refactoring in commit db559117828d ("bpf: Consol=
idate
spin_lock, timer management into btf_record") resulted in the enum
values no longer being used anywhere.

Let's remove them.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/btf.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 71758cd15b07..37779ceefd09 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3231,12 +3231,6 @@ static void btf_struct_log(struct btf_verifier_env=
 *env,
 	btf_verifier_log(env, "size=3D%u vlen=3D%u", t->size, btf_type_vlen(t))=
;
 }
=20
-enum btf_field_info_type {
-	BTF_FIELD_SPIN_LOCK,
-	BTF_FIELD_TIMER,
-	BTF_FIELD_KPTR,
-};
-
 enum {
 	BTF_FIELD_IGNORE =3D 0,
 	BTF_FIELD_FOUND  =3D 1,
--=20
2.34.1


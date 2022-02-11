Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D270F4B1F69
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 08:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347704AbiBKHjX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 02:39:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbiBKHjW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 02:39:22 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0210CB5
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 23:39:21 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ANrKut001235
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 23:39:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=f1pHNkdRvSOCcBG+PcG8CNa1hCbjwASO8Aak2fJTFZ8=;
 b=hxMsp+UQ8/97+6zLEYz6d0AYQfUxbEiUq/1hZXXnne53M79no+5Y7uGXNewXwBFYr8MK
 3Wb+vtMzmTlAdiqqchQJJFyB7/0r79rSS0QAxserxRIfaxBMxlIZZEHjPMBuTeBJnCOL
 jfdAx4nZPA/pH1PLw25PbC2AerxQzEetob8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e58mhutxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 23:39:21 -0800
Received: from twshared22811.39.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 23:39:20 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B5CF063DB632; Thu, 10 Feb 2022 23:39:13 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf 2/2] bpf: emit bpf_timer in vmlinux BTF
Date:   Thu, 10 Feb 2022 23:39:13 -0800
Message-ID: <20220211073913.3455777-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220211073903.3455193-1-yhs@fb.com>
References: <20220211073903.3455193-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _DQv8thaJQ4EVuh28GPdfxv0dqwBRbmM
X-Proofpoint-ORIG-GUID: _DQv8thaJQ4EVuh28GPdfxv0dqwBRbmM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_02,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxlogscore=710 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110043
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previously, the following code in check_and_init_map_value()
  *(struct bpf_timer *)(dst + map->timer_off) =3D
      (struct bpf_timer){};
can help generate bpf_timer definition in vmlinuxBTF.
But previous patch replaced the above code with memset
so bpf_timer definition disappears from vmlinuxBTF.
Let us emit the type explicitly so bpf program can continue
to use it from vmlinux.h.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/helpers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4e5969fde0b3..d7fc3c270a4c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -17,6 +17,7 @@
 #include <linux/proc_ns.h>
 #include <linux/security.h>
 #include <linux/btf_ids.h>
+#include <linux/btf.h>
=20
 #include "../../lib/kstrtox.h"
=20
@@ -1109,6 +1110,7 @@ static enum hrtimer_restart bpf_timer_cb(struct hrt=
imer *hrtimer)
 	void *key;
 	u32 idx;
=20
+	BTF_TYPE_EMIT(struct bpf_timer);
 	callback_fn =3D rcu_dereference_check(t->callback_fn, rcu_read_lock_bh_=
held());
 	if (!callback_fn)
 		goto out;
--=20
2.30.2


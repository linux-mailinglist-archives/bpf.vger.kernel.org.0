Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00ECB4B2E02
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 20:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiBKTuE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 14:50:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiBKTuD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 14:50:03 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465B82A1
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 11:50:01 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 21BEavvd004477
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 11:50:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xc8/ABxLpWjCoIgr8COqJYGYmTIUS1Hnj4DN76GKejA=;
 b=jAQWWwYCh7tDVads+rsfF0PCrih9Xb1j8EOWhk7H4XOirCXrrx2bbZZ4n53ov+nchRyq
 G5MLm1n3iB6eyxVtDPpYeBQ7wCrb6WtSfTbRyTq9dpucE+P7KCmoo2oJxCo/bYUEO07z
 uzyz5wH96OTbzQcBqOGI4dz876UdyUqcD/I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3e58p9fxvx-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 11:50:00 -0800
Received: from twshared7634.08.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 11:49:57 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 7ACFB6430121; Fri, 11 Feb 2022 11:49:48 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf v4 1/2] bpf: emit bpf_timer in vmlinux BTF
Date:   Fri, 11 Feb 2022 11:49:48 -0800
Message-ID: <20220211194948.3141529-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220211194943.3141324-1-yhs@fb.com>
References: <20220211194943.3141324-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ontAwIpXcgBY6vHuZ8bn1oKUuBjOfVHB
X-Proofpoint-ORIG-GUID: ontAwIpXcgBY6vHuZ8bn1oKUuBjOfVHB
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=586 malwarescore=0 impostorscore=0
 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110104
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

Currently the following code in check_and_init_map_value()
  *(struct bpf_timer *)(dst + map->timer_off) =3D
      (struct bpf_timer){};
can help generate bpf_timer definition in vmlinuxBTF.
But the code above may not zero the whole structure
due to anonymour members and that code will be replaced
by memset in the subsequent patch and
bpf_timer definition will disappear from vmlinuxBTF.
Let us emit the type explicitly so bpf program can continue
to use it from vmlinux.h.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/helpers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 01cfdf40c838..55c084251fab 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
  */
 #include <linux/bpf.h>
+#include <linux/btf.h>
 #include <linux/bpf-cgroup.h>
 #include <linux/rcupdate.h>
 #include <linux/random.h>
@@ -1075,6 +1076,7 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtim=
er *hrtimer)
 	void *key;
 	u32 idx;
=20
+	BTF_TYPE_EMIT(struct bpf_timer);
 	callback_fn =3D rcu_dereference_check(t->callback_fn, rcu_read_lock_bh_he=
ld());
 	if (!callback_fn)
 		goto out;
--=20
2.30.2


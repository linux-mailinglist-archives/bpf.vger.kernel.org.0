Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AA0589385
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 22:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbiHCUtd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 16:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbiHCUtb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 16:49:31 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1E45C97B
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 13:49:29 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273G6TM3019609
        for <bpf@vger.kernel.org>; Wed, 3 Aug 2022 13:49:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=jB+A92tTdd2e2Rofg78CH38HLFXpUmHdV5K7L7aTBkw=;
 b=h/8al6uytRvYG7gQPk3QHi6GwJ6+PkT9FXSa8bAmPASf18L1VtuRuvVp2Us4hGvTLytd
 kjQT7weeBUuic/7fUjj8w3fbBHzvwFpDvSlX491HtG216uNsYvDrN2B5Y72M2xZgbNq1
 1j4o9MbuVZTtO+JV2KA3lQNkPI8biRbHSc0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hqfeb646j-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 13:49:28 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 13:49:26 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id C765B7A3F78B; Wed,  3 Aug 2022 13:46:45 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v2 bpf-next 07/15] bpf: Initialize the bpf_run_ctx in bpf_iter_run_prog()
Date:   Wed, 3 Aug 2022 13:46:45 -0700
Message-ID: <20220803204645.3079236-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220803204601.3075863-1-kafai@fb.com>
References: <20220803204601.3075863-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7efyKlMyS9qd5st1mm32jr8JdrM8BqBJ
X-Proofpoint-GUID: 7efyKlMyS9qd5st1mm32jr8JdrM8BqBJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_06,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf-iter-prog for tcp and unix sk can do bpf_setsockopt()
which needs in_bpf() to decide if it is called by a bpf prog.
This patch initializes the bpf_run_ctx in bpf_iter_run_prog()
for the in_bpf() to use.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/bpf_iter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 7e8fd49406f6..5d3a982eb553 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -681,19 +681,24 @@ struct bpf_prog *bpf_iter_get_info(struct bpf_iter_=
meta *meta, bool in_stop)
=20
 int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
 {
+	struct bpf_run_ctx run_ctx, *old_run_ctx;
 	int ret;
=20
 	if (prog->aux->sleepable) {
 		rcu_read_lock_trace();
 		migrate_disable();
 		might_fault();
+		old_run_ctx =3D bpf_set_run_ctx(&run_ctx);
 		ret =3D bpf_prog_run(prog, ctx);
+		bpf_reset_run_ctx(old_run_ctx);
 		migrate_enable();
 		rcu_read_unlock_trace();
 	} else {
 		rcu_read_lock();
 		migrate_disable();
+		old_run_ctx =3D bpf_set_run_ctx(&run_ctx);
 		ret =3D bpf_prog_run(prog, ctx);
+		bpf_reset_run_ctx(old_run_ctx);
 		migrate_enable();
 		rcu_read_unlock();
 	}
--=20
2.30.2


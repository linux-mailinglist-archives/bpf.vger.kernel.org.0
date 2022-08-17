Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C1A5969A4
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 08:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbiHQGfB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 02:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiHQGfA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 02:35:00 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116A87757F
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:35:00 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H0RnlP001547
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:34:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LWvmoWcjp/8fgeoyXvqACqQ+iib8lQuxwzZSCPD/NKY=;
 b=il8v4ifWT1VD+5w4Zp2ugx59jzL8An8yzRtyhRbhlX9ogWK6txOVgBHRx0JsCnqVmCOu
 O75ekIQSAB65KHd1rjPM/196uXZnDkOMabz/4zG4Ov+xBRs60ucMAoTRHZNv7oTrfYWa
 jTHP0ttbzmyVjLSWY5WP4OVD7BcfIxwShZs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j0nt9h8g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:34:59 -0700
Received: from twshared20276.35.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 16 Aug 2022 23:34:59 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 075D5825DCD6; Tue, 16 Aug 2022 23:17:52 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 07/15] bpf: Initialize the bpf_run_ctx in bpf_iter_run_prog()
Date:   Tue, 16 Aug 2022 23:17:51 -0700
Message-ID: <20220817061751.4177657-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817061704.4174272-1-kafai@fb.com>
References: <20220817061704.4174272-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: y9JEMgj9ytTq0WxTwL2JdLvAuO7RJFyB
X-Proofpoint-ORIG-GUID: y9JEMgj9ytTq0WxTwL2JdLvAuO7RJFyB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_04,2022-08-16_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf-iter-prog for tcp and unix sk can do bpf_setsockopt()
which needs has_current_bpf_ctx() to decide if it is called by a
bpf prog.  This patch initializes the bpf_run_ctx in
bpf_iter_run_prog() for the has_current_bpf_ctx() to use.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/bpf_iter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 4b112aa8bba3..6476b2c03527 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -685,19 +685,24 @@ struct bpf_prog *bpf_iter_get_info(struct bpf_iter_=
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


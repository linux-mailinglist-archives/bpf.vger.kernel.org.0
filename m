Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8DD58F2CC
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 21:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiHJTLN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 15:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiHJTLM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 15:11:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C181C21271
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 12:11:11 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AGuaxR023115
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 12:11:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+bXiOIjkNlIltDmgPAljzsr7ZmN0E3YeaT4u7w/0M+c=;
 b=Euor6hK6oVKVOZBlzbouPbtZEUTimrZKcTpOEEZYVQj3gblAEj5l5JeUArqYclWiyw+c
 BvQpPiWVWzyGyAV63lO/pSg9ASz5u3Lhw2shp+cNAD236nHaRZuNW3UN3xtt3j48R9jh
 9Pg3OGuOwuQSKdfNg3oQREp9BfCSkdtrPB8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdbau289-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 12:11:11 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 12:11:08 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 98EEF7E75409; Wed, 10 Aug 2022 12:08:09 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 07/15] bpf: Initialize the bpf_run_ctx in bpf_iter_run_prog()
Date:   Wed, 10 Aug 2022 12:08:09 -0700
Message-ID: <20220810190809.2698442-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220810190724.2692127-1-kafai@fb.com>
References: <20220810190724.2692127-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XvxtznLx13w6JIDt-TcyuGdFHfuempf0
X-Proofpoint-GUID: XvxtznLx13w6JIDt-TcyuGdFHfuempf0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_12,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf-iter-prog for tcp and unix sk can do bpf_setsockopt()
which needs has_current_bpf_ctx() to decide if it is called by a
bpf prog.  This patch initializes the bpf_run_ctx in
bpf_iter_run_prog() for the has_current_bpf_ctx() to use.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h   | 2 +-
 kernel/bpf/bpf_iter.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0a600b2013cc..15ab980e9525 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1967,7 +1967,7 @@ static inline bool unprivileged_ebpf_enabled(void)
 }
=20
 /* Not all bpf prog type has the bpf_ctx.
- * Only trampoline and cgroup-bpf have it.
+ * Only trampoline, cgroup-bpf, and iter have it.
  * For the bpf prog type that has initialized the bpf_ctx,
  * this function can be used to decide if a kernel function
  * is called by a bpf program.
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


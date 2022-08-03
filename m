Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C20E58937C
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 22:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbiHCUtR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 16:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbiHCUtQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 16:49:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FE95C94E
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 13:49:15 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273FC40a025784
        for <bpf@vger.kernel.org>; Wed, 3 Aug 2022 13:49:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=VUZgVVhMIX53YGS4qTb5dAd/pH/+EGA3XiUK+r4AV0E=;
 b=THO264EIHWVa7OVh6ZwjNile+fWxqsXVbFxqufYHbxoR6fR/q1V96TGS7JDVdAt/kVp/
 hj0SRcsjHLekbDOgUwLWsVSimA8yMnitrSF1CQyoQr/+satd2u1108NSr+vnPEPQOjbU
 xV84Y2BfMm4te613aFTISjmcU60uTc+aXy0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hpy32mq6p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 13:49:14 -0700
Received: from twshared20276.35.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 13:49:14 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 3EED07A3F71E; Wed,  3 Aug 2022 13:46:14 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 02/15] bpf: net: Avoid sk_setsockopt() taking sk lock when called from bpf
Date:   Wed, 3 Aug 2022 13:46:14 -0700
Message-ID: <20220803204614.3077284-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220803204601.3075863-1-kafai@fb.com>
References: <20220803204601.3075863-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tiqDtsaw-dXLPc7BZzWpeqcZ888e2pGt
X-Proofpoint-GUID: tiqDtsaw-dXLPc7BZzWpeqcZ888e2pGt
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

Most of the code in bpf_setsockopt(SOL_SOCKET) are duplicated from
the sk_setsockopt().  The number of supported optnames are
increasing ever and so as the duplicated code.

One issue in reusing sk_setsockopt() is that the bpf prog
has already acquired the sk lock.  This patch adds a in_bpf()
to tell if the sk_setsockopt() is called from a bpf prog.
The bpf prog calling bpf_setsockopt() is either running in_task()
or in_serving_softirq().  Both cases have the current->bpf_ctx
initialized.  Thus, the in_bpf() only needs to test !!current->bpf_ctx.

This patch also adds sockopt_{lock,release}_sock() helpers
for sk_setsockopt() to use.  These helpers will test in_bpf()
before acquiring/releasing the lock.  They are in EXPORT_SYMBOL
for the ipv6 module to use in a latter patch.

Note on the change in sock_setbindtodevice().  sockopt_lock_sock()
is done in sock_setbindtodevice() instead of doing the lock_sock
in sock_bindtoindex(..., lock_sk =3D true).

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h |  8 ++++++++
 include/net/sock.h  |  3 +++
 net/core/sock.c     | 26 +++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 20c26aed7896..b905b1b34fe4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1966,6 +1966,10 @@ static inline bool unprivileged_ebpf_enabled(void)
 	return !sysctl_unprivileged_bpf_disabled;
 }
=20
+static inline bool in_bpf(void)
+{
+	return !!current->bpf_ctx;
+}
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 {
@@ -2175,6 +2179,10 @@ static inline bool unprivileged_ebpf_enabled(void)
 	return false;
 }
=20
+static inline bool in_bpf(void)
+{
+	return false;
+}
 #endif /* CONFIG_BPF_SYSCALL */
=20
 void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
diff --git a/include/net/sock.h b/include/net/sock.h
index a7273b289188..b2ff230860c6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1721,6 +1721,9 @@ static inline void unlock_sock_fast(struct sock *sk=
, bool slow)
 	}
 }
=20
+void sockopt_lock_sock(struct sock *sk);
+void sockopt_release_sock(struct sock *sk);
+
 /* Used by processes to "lock" a socket state, so that
  * interrupts and bottom half handlers won't change it
  * from under us. It essentially blocks any incoming
diff --git a/net/core/sock.c b/net/core/sock.c
index 20269c37ab3b..82759540ae2c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -703,7 +703,9 @@ static int sock_setbindtodevice(struct sock *sk, sock=
ptr_t optval, int optlen)
 			goto out;
 	}
=20
-	return sock_bindtoindex(sk, index, true);
+	sockopt_lock_sock(sk);
+	ret =3D sock_bindtoindex_locked(sk, index);
+	sockopt_release_sock(sk);
 out:
 #endif
=20
@@ -1036,6 +1038,24 @@ static int sock_reserve_memory(struct sock *sk, in=
t bytes)
 	return 0;
 }
=20
+void sockopt_lock_sock(struct sock *sk)
+{
+	if (in_bpf())
+		return;
+
+	lock_sock(sk);
+}
+EXPORT_SYMBOL(sockopt_lock_sock);
+
+void sockopt_release_sock(struct sock *sk)
+{
+	if (in_bpf())
+		return;
+
+	release_sock(sk);
+}
+EXPORT_SYMBOL(sockopt_release_sock);
+
 /*
  *	This is meant for all protocols to use and covers goings on
  *	at the socket level. Everything here is generic.
@@ -1067,7 +1087,7 @@ static int sk_setsockopt(struct sock *sk, int level=
, int optname,
=20
 	valbool =3D val ? 1 : 0;
=20
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
=20
 	switch (optname) {
 	case SO_DEBUG:
@@ -1496,7 +1516,7 @@ static int sk_setsockopt(struct sock *sk, int level=
, int optname,
 		ret =3D -ENOPROTOOPT;
 		break;
 	}
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return ret;
 }
=20
--=20
2.30.2


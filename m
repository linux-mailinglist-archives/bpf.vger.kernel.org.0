Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CDC5969C8
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 08:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiHQGrL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 02:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiHQGrK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 02:47:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B3D6554B
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:47:07 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H6kBbG016611
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:47:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wpSbf31KyvOXxKfB48qiXSTnhqjs5yy0+Iiyh4mJkMs=;
 b=ZYnzHAWWVM3A/KrbuF1DdIytNCaE7VZ3JzFeX0YeQ6ESNy5l3Y9/sz5DoEhFXTp3zS7u
 i7IFkBoGWXRshnsrcbfNE6lp/gQxWUtZ0oIjN3LOkW+QhhzXwKIO+Ive2nlVKnyIo+D6
 aulXoSli6g1b/YQ43WQyMvXiSu2+sEeW5bY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j0nt9h9rf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:47:07 -0700
Received: from twshared22413.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 16 Aug 2022 23:47:06 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 96746825DC1F; Tue, 16 Aug 2022 23:17:17 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 02/15] bpf: net: Avoid sk_setsockopt() taking sk lock when called from bpf
Date:   Tue, 16 Aug 2022 23:17:17 -0700
Message-ID: <20220817061717.4175589-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817061704.4174272-1-kafai@fb.com>
References: <20220817061704.4174272-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7IL0--S1irAM-jYlXw1q0x87vRyTScTE
X-Proofpoint-ORIG-GUID: 7IL0--S1irAM-jYlXw1q0x87vRyTScTE
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

Most of the code in bpf_setsockopt(SOL_SOCKET) are duplicated from
the sk_setsockopt().  The number of supported optnames are
increasing ever and so as the duplicated code.

One issue in reusing sk_setsockopt() is that the bpf prog
has already acquired the sk lock.  This patch adds a
has_current_bpf_ctx() to tell if the sk_setsockopt() is called from
a bpf prog.  The bpf prog calling bpf_setsockopt() is either running
in_task() or in_serving_softirq().  Both cases have the current->bpf_ctx
initialized.  Thus, the has_current_bpf_ctx() only needs to
test !!current->bpf_ctx.

This patch also adds sockopt_{lock,release}_sock() helpers
for sk_setsockopt() to use.  These helpers will test
has_current_bpf_ctx() before acquiring/releasing the lock.  They are
in EXPORT_SYMBOL for the ipv6 module to use in a latter patch.

Note on the change in sock_setbindtodevice().  sockopt_lock_sock()
is done in sock_setbindtodevice() instead of doing the lock_sock
in sock_bindtoindex(..., lock_sk =3D true).

Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h | 13 +++++++++++++
 include/net/sock.h  |  3 +++
 net/core/sock.c     | 30 +++++++++++++++++++++++++++---
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a627a02cf8ab..39bd36359c1e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1966,6 +1966,15 @@ static inline bool unprivileged_ebpf_enabled(void)
 	return !sysctl_unprivileged_bpf_disabled;
 }
=20
+/* Not all bpf prog type has the bpf_ctx.
+ * For the bpf prog type that has initialized the bpf_ctx,
+ * this function can be used to decide if a kernel function
+ * is called by a bpf program.
+ */
+static inline bool has_current_bpf_ctx(void)
+{
+	return !!current->bpf_ctx;
+}
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 {
@@ -2175,6 +2184,10 @@ static inline bool unprivileged_ebpf_enabled(void)
 	return false;
 }
=20
+static inline bool has_current_bpf_ctx(void)
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
index 20269c37ab3b..d3683228376f 100644
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
@@ -1036,6 +1038,28 @@ static int sock_reserve_memory(struct sock *sk, in=
t bytes)
 	return 0;
 }
=20
+void sockopt_lock_sock(struct sock *sk)
+{
+	/* When current->bpf_ctx is set, the setsockopt is called from
+	 * a bpf prog.  bpf has ensured the sk lock has been
+	 * acquired before calling setsockopt().
+	 */
+	if (has_current_bpf_ctx())
+		return;
+
+	lock_sock(sk);
+}
+EXPORT_SYMBOL(sockopt_lock_sock);
+
+void sockopt_release_sock(struct sock *sk)
+{
+	if (has_current_bpf_ctx())
+		return;
+
+	release_sock(sk);
+}
+EXPORT_SYMBOL(sockopt_release_sock);
+
 /*
  *	This is meant for all protocols to use and covers goings on
  *	at the socket level. Everything here is generic.
@@ -1067,7 +1091,7 @@ static int sk_setsockopt(struct sock *sk, int level=
, int optname,
=20
 	valbool =3D val ? 1 : 0;
=20
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
=20
 	switch (optname) {
 	case SO_DEBUG:
@@ -1496,7 +1520,7 @@ static int sk_setsockopt(struct sock *sk, int level=
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


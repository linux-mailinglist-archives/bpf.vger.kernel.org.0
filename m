Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D9A5AA467
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 02:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiIBAbE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 20:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiIBAa5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 20:30:57 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C39A698
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 17:30:54 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28208tHB011813
        for <bpf@vger.kernel.org>; Thu, 1 Sep 2022 17:30:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=I80Jy/0+2MnVEm3jx813TrRQe5C5KemTyOI9zOWk9rQ=;
 b=oU4SCb6cwtBd7Pcs81AeoaTQfRQG5O+nBLnQRklWa9nYCRkA7lw61sfBpqgAYNXUIqjj
 V1tzGcbl0PU2IvJqsIkQOssSLPIXGI7QKCGCHZGwjywKpjFU4PRlQglPARcjqTpwCbqo
 jdSSH/vvtvqY8QhFRiYDPQuKPIGK4bgJ5XI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ja8n3kvmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 17:30:53 -0700
Received: from twshared2273.16.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 17:30:52 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 3C2028C47A96; Thu,  1 Sep 2022 17:28:09 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v2 bpf-next 03/17] bpf: net: Avoid sk_getsockopt() taking sk lock when called from bpf
Date:   Thu, 1 Sep 2022 17:28:09 -0700
Message-ID: <20220902002809.2888981-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220902002750.2887415-1-kafai@fb.com>
References: <20220902002750.2887415-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SV3dfvLxvkRiYYHZ2XpYQrLB5Vsv8wbO
X-Proofpoint-ORIG-GUID: SV3dfvLxvkRiYYHZ2XpYQrLB5Vsv8wbO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

Similar to the earlier commit that changed sk_setsockopt() to
use sockopt_{lock,release}_sock() such that it can avoid taking
lock when called from bpf.  This patch also changes sk_getsockopt()
to use sockopt_{lock,release}_sock() such that a latter patch can
make bpf_getsockopt(SOL_SOCKET) to reuse sk_getsockopt().

Only sk_get_filter() requires this change and it is used by
the optname SO_GET_FILTER.

The '.getname' implementations in sock->ops->getname() is not
changed also since bpf does not always have the sk->sk_socket
pointer and cannot support SO_PEERNAME.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 0f6f86b9e487..8e7fc71160cd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10718,7 +10718,7 @@ int sk_get_filter(struct sock *sk, sockptr_t optv=
al, unsigned int len)
 	struct sk_filter *filter;
 	int ret =3D 0;
=20
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	filter =3D rcu_dereference_protected(sk->sk_filter,
 					   lockdep_sock_is_held(sk));
 	if (!filter)
@@ -10751,7 +10751,7 @@ int sk_get_filter(struct sock *sk, sockptr_t optv=
al, unsigned int len)
 	 */
 	ret =3D fprog->len;
 out:
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return ret;
 }
=20
--=20
2.30.2


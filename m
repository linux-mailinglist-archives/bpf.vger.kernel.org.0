Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8525AA476
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 02:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiIBAbG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 20:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiIBAbC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 20:31:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9AF7C33A
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 17:31:00 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28208ppN028426
        for <bpf@vger.kernel.org>; Thu, 1 Sep 2022 17:31:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=V4ZR3tJbaG+sxN1oqyIAQof3QYA52fXd/YYGOEYxcak=;
 b=QsxjoSEA8O2gbyjMGERIQoq0Zg1c/ZFE5XhlUpKNvKoXk5uHpAaHz6CWo3AEWh3KixMh
 7ujhAS+0CKQDqghqo7L8tgwChKh5ayOCEhh4z7qA/o1l1s4NPQUptN/CrbB71huePpKK
 ZqN5nyDv23TvVDvldlbLWm7q72p5JWhWht8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jaf2n0pht-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 17:31:00 -0700
Received: from twshared29104.24.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 17:30:54 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id D0AC18C47AC8; Thu,  1 Sep 2022 17:28:21 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 05/17] bpf: net: Avoid do_tcp_getsockopt() taking sk lock when called from bpf
Date:   Thu, 1 Sep 2022 17:28:21 -0700
Message-ID: <20220902002821.2889765-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220902002750.2887415-1-kafai@fb.com>
References: <20220902002750.2887415-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: e6aFT5gdbu0_occ9QZz5QQlmHHcGw3eE
X-Proofpoint-ORIG-GUID: e6aFT5gdbu0_occ9QZz5QQlmHHcGw3eE
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
lock when called from bpf.  This patch also changes do_tcp_getsockopt()
to use sockopt_{lock,release}_sock() such that a latter patch can
make bpf_getsockopt(SOL_TCP) to reuse do_tcp_getsockopt().

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 net/ipv4/tcp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 108c430a2a11..45c737ee95a1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4265,30 +4265,30 @@ static int do_tcp_getsockopt(struct sock *sk, int=
 level,
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
=20
-		lock_sock(sk);
+		sockopt_lock_sock(sk);
 		if (tp->saved_syn) {
 			if (len < tcp_saved_syn_len(tp->saved_syn)) {
 				len =3D tcp_saved_syn_len(tp->saved_syn);
 				if (copy_to_sockptr(optlen, &len, sizeof(int))) {
-					release_sock(sk);
+					sockopt_release_sock(sk);
 					return -EFAULT;
 				}
-				release_sock(sk);
+				sockopt_release_sock(sk);
 				return -EINVAL;
 			}
 			len =3D tcp_saved_syn_len(tp->saved_syn);
 			if (copy_to_sockptr(optlen, &len, sizeof(int))) {
-				release_sock(sk);
+				sockopt_release_sock(sk);
 				return -EFAULT;
 			}
 			if (copy_to_sockptr(optval, tp->saved_syn->data, len)) {
-				release_sock(sk);
+				sockopt_release_sock(sk);
 				return -EFAULT;
 			}
 			tcp_saved_syn_free(tp);
-			release_sock(sk);
+			sockopt_release_sock(sk);
 		} else {
-			release_sock(sk);
+			sockopt_release_sock(sk);
 			len =3D 0;
 			if (copy_to_sockptr(optlen, &len, sizeof(int)))
 				return -EFAULT;
@@ -4321,11 +4321,11 @@ static int do_tcp_getsockopt(struct sock *sk, int=
 level,
 			return -EINVAL;
 		if (zc.msg_flags &  ~(TCP_VALID_ZC_MSG_FLAGS))
 			return -EINVAL;
-		lock_sock(sk);
+		sockopt_lock_sock(sk);
 		err =3D tcp_zerocopy_receive(sk, &zc, &tss);
 		err =3D BPF_CGROUP_RUN_PROG_GETSOCKOPT_KERN(sk, level, optname,
 							  &zc, &len, err);
-		release_sock(sk);
+		sockopt_release_sock(sk);
 		if (len >=3D offsetofend(struct tcp_zerocopy_receive, msg_flags))
 			goto zerocopy_rcv_cmsg;
 		switch (len) {
--=20
2.30.2


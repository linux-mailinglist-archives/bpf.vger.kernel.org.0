Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D765A03F9
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiHXW3R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiHXW3L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:29:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289717F121
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:29:11 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OMHLk5007689
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:29:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8WnvrhyGubUw+ms0VDp7uHGPZjRp8qtQ+ouO4uEhdpY=;
 b=JDlspVNvLKjbAiz6A9P6x/Ym/ku2tSdjI8Yt1cTPL1afIbLYfotefSh384hFq+H2sSj+
 WkJJP27FLiRfxvFQPvzb+fr2pu0dhIKIRsd9Zly2XP48OmMpC3KK8sPC2V0Ep5nk6qiO
 8wsx03j5vL/8gXVP/5ZDGQXk02ZcZcGeExQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5bpsxhna-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:29:10 -0700
Received: from twshared32421.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 15:29:07 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 7E076871C940; Wed, 24 Aug 2022 15:26:33 -0700 (PDT)
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
Subject: [PATCH bpf-next 05/17] bpf: net: Avoid do_tcp_getsockopt() taking sk lock when called from bpf
Date:   Wed, 24 Aug 2022 15:26:33 -0700
Message-ID: <20220824222633.1919899-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220824222601.1916776-1-kafai@fb.com>
References: <20220824222601.1916776-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: X5ppiyXXtH6FM2-Kwr3bMTbakLwJ_cRX
X-Proofpoint-GUID: X5ppiyXXtH6FM2-Kwr3bMTbakLwJ_cRX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_14,2022-08-22_02,2022-06-22_01
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

Similar to the earlier commit that changed sk_setsockopt() to
use sockopt_{lock,release}_sock() such that it can avoid taking
lock when called from bpf.  This patch also changes do_tcp_getsockopt()
to use sockopt_{lock,release}_sock() such that a latter patch can
make bpf_getsockopt(SOL_TCP) to reuse do_tcp_getsockopt().

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/ipv4/tcp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7cd04f357873..ab8118225797 100644
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


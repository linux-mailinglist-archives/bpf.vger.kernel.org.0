Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8565A58F2D1
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 21:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbiHJTLU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 15:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiHJTLS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 15:11:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC6621838
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 12:11:17 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AGudhW023242
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 12:11:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=hBbc4voybpusoqVF5B6emsnTuWy9LwWZi7yWhqpliL0=;
 b=J1Z44Tuh6VP/wkUfFbKyHsH0T35lodep9TmVoMGYyG3Bdl7IhEoxZmvqQxs9yFrWRu7a
 I3xBJRSvQeMIwPYg8IbooASPRdKqunepJ7l32MUUsoaXML9kDYzVposka8hyCna8jSAh
 wKDDnIh0fr2/XbsLRt2qHPnYwgSir/LOmsk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdbau28j-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 12:11:17 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 12:11:12 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id F3FED7E755B7; Wed, 10 Aug 2022 12:08:55 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 14/15] bpf: Add a few optnames to bpf_setsockopt
Date:   Wed, 10 Aug 2022 12:08:55 -0700
Message-ID: <20220810190855.2703872-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220810190724.2692127-1-kafai@fb.com>
References: <20220810190724.2692127-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DrokToc8wqHWXVopdSNEF2Avsi1Jy_WA
X-Proofpoint-GUID: DrokToc8wqHWXVopdSNEF2Avsi1Jy_WA
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

This patch adds a few optnames for bpf_setsockopt:
SO_REUSEADDR, IPV6_AUTOFLOWLABEL, TCP_MAXSEG, TCP_NODELAY,
and TCP_THIN_LINEAR_TIMEOUTS.

Thanks to the previous patches of this set, all additions can reuse
the sk_setsockopt(), do_ipv6_setsockopt(), and do_tcp_setsockopt().
The only change here is to allow them in bpf_setsockopt.

The bpf prog has been able to read all members of a sk by
using PTR_TO_BTF_ID of a sk.  The optname additions here can also be
read by the same approach.  Meaning there is a way to read
the values back.

These optnames can also be added to bpf_getsockopt() later with
another patch set that makes the bpf_getsockopt() to reuse
the sock_getsockopt(), tcp_getsockopt(), and ip[v6]_getsockopt().
Thus, this patch does not add more duplicated code to
bpf_getsockopt() now.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/core/filter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index de6f90a2ec0d..52736c833a5f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5017,6 +5017,7 @@ static int sol_socket_setsockopt(struct sock *sk, i=
nt optname,
 				 char *optval, int optlen)
 {
 	switch (optname) {
+	case SO_REUSEADDR:
 	case SO_SNDBUF:
 	case SO_RCVBUF:
 	case SO_KEEPALIVE:
@@ -5102,11 +5103,14 @@ static int sol_tcp_setsockopt(struct sock *sk, in=
t optname,
 		return -EINVAL;
=20
 	switch (optname) {
+	case TCP_NODELAY:
+	case TCP_MAXSEG:
 	case TCP_KEEPIDLE:
 	case TCP_KEEPINTVL:
 	case TCP_KEEPCNT:
 	case TCP_SYNCNT:
 	case TCP_WINDOW_CLAMP:
+	case TCP_THIN_LINEAR_TIMEOUTS:
 	case TCP_USER_TIMEOUT:
 	case TCP_NOTSENT_LOWAT:
 	case TCP_SAVE_SYN:
@@ -5150,6 +5154,7 @@ static int sol_ipv6_setsockopt(struct sock *sk, int=
 optname,
=20
 	switch (optname) {
 	case IPV6_TCLASS:
+	case IPV6_AUTOFLOWLABEL:
 		if (optlen !=3D sizeof(int))
 			return -EINVAL;
 		break;
--=20
2.30.2


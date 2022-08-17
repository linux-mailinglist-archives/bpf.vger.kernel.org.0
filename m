Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5125969A3
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 08:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbiHQGfN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 02:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238715AbiHQGfN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 02:35:13 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E487757F
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:35:12 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27H0X21p028988
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:35:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=T73Kh4riqgtkXF0ouQn+38NEgIX47ntvMOV6xn6a1Mc=;
 b=ILTmugEwW5rWJdaljB9PVsSQuJfnZZn650Iup6GGA2nYAGkKsZTpBiM4l8H4znBb+ULf
 p/Aw8ee28VMkMHOo9onr5fgHxjoIeM5tqrR2qs1vbegO9ghqQBxMX6W4uBieTbWA7KdF
 PBzP4FsfE9GsE/dhGyzNz5OD9yln1Bm4Rqk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j0nvjh89t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:35:11 -0700
Received: from twshared22413.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 16 Aug 2022 23:35:10 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 93F03825DE1B; Tue, 16 Aug 2022 23:18:41 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 14/15] bpf: Add a few optnames to bpf_setsockopt
Date:   Tue, 16 Aug 2022 23:18:41 -0700
Message-ID: <20220817061841.4181642-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817061704.4174272-1-kafai@fb.com>
References: <20220817061704.4174272-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vHkSioyInTqJjdig72x45gQWRpdQ1JdA
X-Proofpoint-ORIG-GUID: vHkSioyInTqJjdig72x45gQWRpdQ1JdA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_04,2022-08-16_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/core/filter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 23282b8cf61e..1acfaffeaf32 100644
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
@@ -5093,11 +5094,14 @@ static int sol_tcp_setsockopt(struct sock *sk, in=
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
@@ -5141,6 +5145,7 @@ static int sol_ipv6_setsockopt(struct sock *sk, int=
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


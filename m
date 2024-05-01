Return-Path: <bpf+bounces-28321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3478E8B8637
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 09:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79BB8B2250D
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 07:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715394DA0F;
	Wed,  1 May 2024 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="C7TLWXbB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9024D9E3
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549449; cv=none; b=YzdWuSjb5GMLaWdHTjamlBE9aBWRfh0yJzu7Qj2SNjid1PCfY/flXwrFuC53GGWVmnzoZH2LiIB4JWS4VWXLHVPgzuUY9TkkMpGVVUv2ruvJMaDJlG0lXVYpHhPx+R/gD+YkF+UNkFhxjN6qskGp9awhVgRpWZw1a4tPkGyO6dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549449; c=relaxed/simple;
	bh=yF6aDhcCRNYsIcBxMHrLruhA1z49hZwQM+vDngtMYhI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pxFI2vgHeu9AV8V7SNfGLm11bUew8m9WkD0NvIrKlbtfmHYvaRP/HmwEjha354KDOIu//dwSp1Y20FWkT1MM+DiCHOu1a0rxBWoWLNqktlR8esA65uAN/OEt3mvnHUOQNWHHlv4LnE+yyrD0jRxykiORze2sEBrAcrF6/GVMh+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=C7TLWXbB; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44101IQl007553
	for <bpf@vger.kernel.org>; Wed, 1 May 2024 00:44:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=G33F6Pis8zC33bs/F7sb7zuJPv0n9cBfurXb7XPQOnk=;
 b=C7TLWXbBpzBY0gTlSbxjDsrv7ct0T/Nv/CIXvGHMbDjpjivJ1tSwhxTZ+JV5YOZFuaPP
 H0HGpA8JYxn0/HhuYlz8WHjF9FJA0W6HaK8IWIOc1Yjjez3eEIAN6pqMDf5brDstNQdg
 rFDzEgSQQ0yoP+iPzpz5oM1DgmtnX6TN/1nFi1/59cgL1Ib7DSZ41pvunLfEKJGQQhEb
 /sUFNZb9AhDCjx3WjyXCy/mB3vWeDSCnxL+iemMX1ia8N5DN6psOZ9ynrxvPM2krjGwH
 JnDrJOQiIjlfAkL1UHv+Yp5VhSQ8Bo59tva/KAaDMftizRV89UrdGC7tIa4HFY0ykSYy nA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3xtrupq54d-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 May 2024 00:44:06 -0700
Received: from twshared11717.35.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 07:44:02 +0000
Received: by devvm15954.vll0.facebook.com (Postfix, from userid 420730)
	id BC666CA32BA6; Wed,  1 May 2024 00:43:56 -0700 (PDT)
From: Miao Xu <miaxu@meta.com>
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>, Martin Lau
	<kafai@meta.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Miao Xu <miaxu@meta.com>
Subject: [PATCH net-next v2 1/3] Add new args for cong_control in tcp_congestion_ops
Date: Wed, 1 May 2024 00:43:36 -0700
Message-ID: <20240501074338.362361-1-miaxu@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OnxT3M9VqQ9koQKnklWphuiFOLvNUWbC
X-Proofpoint-GUID: OnxT3M9VqQ9koQKnklWphuiFOLvNUWbC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_06,2024-04-30_01,2023-05-22_02

This patch adds two new arguments for cong_control of struct
tcp_congestion_ops:
 - ack
 - flag
These two arguments are inherited from the caller tcp_cong_control in
tcp_intput.c. One use case of them is to update cwnd and pacing rate
inside cong_control based on the info they provide. For example, the
flag can be used to decide if it is the right time to raise or reduce a
sender's cwnd.

Reviewed-by: Eric Dumazet <edumazet@google.com>
--
Changes in v2:
* Split the v1 patch into 2 separate patches. In particular, spin out
bpf_tcp_ca.c as a separate patch because it is bpf specific.

Signed-off-by: Miao Xu <miaxu@meta.com>
---
 include/net/tcp.h     | 2 +-
 net/ipv4/bpf_tcp_ca.c | 3 ++-
 net/ipv4/tcp_bbr.c    | 2 +-
 net/ipv4/tcp_input.c  | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index fe98fb01879b..7294da8fb780 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1172,7 +1172,7 @@ struct tcp_congestion_ops {
 	/* call when packets are delivered to update cwnd and pacing rate,
 	 * after all the ca_state processing. (optional)
 	 */
-	void (*cong_control)(struct sock *sk, const struct rate_sample *rs);
+	void (*cong_control)(struct sock *sk, u32 ack, int flag, const struct r=
ate_sample *rs);
=20
=20
 	/* new value of cwnd after loss (required) */
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 7f518ea5f4ac..6bd7f8db189a 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -307,7 +307,8 @@ static u32 bpf_tcp_ca_min_tso_segs(struct sock *sk)
 	return 0;
 }
=20
-static void bpf_tcp_ca_cong_control(struct sock *sk, const struct rate_s=
ample *rs)
+static void bpf_tcp_ca_cong_control(struct sock *sk, u32 ack, int flag,
+				    const struct rate_sample *rs)
 {
 }
=20
diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index 7e52ab24e40a..760941e55153 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -1024,7 +1024,7 @@ static void bbr_update_model(struct sock *sk, const=
 struct rate_sample *rs)
 	bbr_update_gains(sk);
 }
=20
-__bpf_kfunc static void bbr_main(struct sock *sk, const struct rate_samp=
le *rs)
+__bpf_kfunc static void bbr_main(struct sock *sk, u32 ack, int flag, con=
st struct rate_sample *rs)
 {
 	struct bbr *bbr =3D inet_csk_ca(sk);
 	u32 bw;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 53e1150f706f..23ccfc7b1d3c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3541,7 +3541,7 @@ static void tcp_cong_control(struct sock *sk, u32 a=
ck, u32 acked_sacked,
 	const struct inet_connection_sock *icsk =3D inet_csk(sk);
=20
 	if (icsk->icsk_ca_ops->cong_control) {
-		icsk->icsk_ca_ops->cong_control(sk, rs);
+		icsk->icsk_ca_ops->cong_control(sk, ack, flag, rs);
 		return;
 	}
=20
--=20
2.43.0



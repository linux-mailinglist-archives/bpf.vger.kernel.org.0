Return-Path: <bpf+bounces-27726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731AF8B14C4
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03869286B0E
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 20:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF8F156F2C;
	Wed, 24 Apr 2024 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Mn15PWv4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B207156C79
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713991071; cv=none; b=MiDFHTJMZPDo04w0tZ+lTxo3Lcb6sToCr8BWjd9Glo92dN1wUcWMSKVLvTTXOvxNANIgA//oMdM+tDv6p6Ne7mE8DhwwejvbAhzE2xHKVNA7g4ORMBuKa+tN+ovYTpFBl6Q5EatzmoSNdFQH9k3MRmxY703oNhPdw7K9Qf6nNPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713991071; c=relaxed/simple;
	bh=Eaar1o6qWStq7g2C70s1orCG9FKn4AnoWIJHHRSPqNw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aYSIOM3CcOXutgtWNyS8h0tpj/PyreTW9pNbcrhV8FF8qlRyGOROT4PUEmhNWRJYlp0Y028MX9VQhqrFU1DO8rlcJzwSI5H7AqrJTRyRRrgGN8UjQBgpHPlK4X/CHWGonhh9RFrJ1VyTzch2aVe3yNPwiD5osO4wmCUeZbUJcrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Mn15PWv4; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OJpRSf000600
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 13:37:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=XTibnUZz+sBcamQII8TeL0LSlh99joVEVJjMbfnVinw=;
 b=Mn15PWv4+sAki2Jgk8m8F0WmgV/8Mw8MCc/VMqGe9FhaadDvr8RFpGUi24nIbguwE8ci
 Ml0bSUkMNRExsseaUWscI5Ft7IqBUwtpwQwBlOMKbQagM1Rc4a1THGp41DoTrsKMxI56
 uDTmugVdFgbvzd+AB3e35lr+YdTgaJDy1Jhykcc4j7K9T/YuNVfCsjWTWQji9U4EbTBB
 qD5Z25wDSLSfeT63qY5X3g8PekM+6ZMoTk4Hi90a+n0NQqRtyX8ntJ9UTm008p0BzBVw
 Jp2meZSEds60eALt/TttnTnAM7gcncRZPt1f9E92CojPzHQm93tYLkX3+WaLzWnZ6Nm8 Xw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3xpsq653tv-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 13:37:49 -0700
Received: from twshared24822.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 20:37:31 +0000
Received: by devvm15954.vll0.facebook.com (Postfix, from userid 420730)
	id 0BB9CC26A57F; Wed, 24 Apr 2024 13:37:22 -0700 (PDT)
From: Miao Xu <miaxu@meta.com>
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>, Martin Lau
	<kafai@meta.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Miao Xu <miaxu@meta.com>
Subject: [PATCH 1/2] [PATCH net-next,1/2] Add new args for cong_control in tcp_congestion_ops
Date: Wed, 24 Apr 2024 13:37:12 -0700
Message-ID: <20240424203713.4003974-1-miaxu@meta.com>
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
X-Proofpoint-ORIG-GUID: F8OPxnUzfFWUfe4PJtsuuVvM6v4gdv91
X-Proofpoint-GUID: F8OPxnUzfFWUfe4PJtsuuVvM6v4gdv91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_17,2024-04-24_01,2023-05-22_02

This patch adds two new arguments for cong_control of struct
tcp_congestion_ops:
 - ack
 - flag
These two arguments are inherited from the caller tcp_cong_control in
tcp_intput.c. One use case of them is to update cwnd and pacing rate
inside cong_control based on the info they provide. For example, the
flag can be used to decide if it is the right time to raise or reduce a
sender's cwnd.

Another change in this patch is to allow the write of tp->snd_cwnd_stamp
for a bpf tcp ca program. An use case of writing this field is to keep
track of the time whenever tp->snd_cwnd is raised or reduced inside the
cong_control callback.

Signed-off-by: Miao Xu <miaxu@meta.com>
---
 include/net/tcp.h     | 2 +-
 net/ipv4/bpf_tcp_ca.c | 6 +++++-
 net/ipv4/tcp_bbr.c    | 2 +-
 net/ipv4/tcp_input.c  | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index b935e1ae4caf..b37b8219060a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1167,7 +1167,7 @@ struct tcp_congestion_ops {
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
index 7f518ea5f4ac..18227757ec0c 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -107,6 +107,9 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_ve=
rifier_log *log,
 	case offsetof(struct tcp_sock, snd_cwnd_cnt):
 		end =3D offsetofend(struct tcp_sock, snd_cwnd_cnt);
 		break;
+	case offsetof(struct tcp_sock, snd_cwnd_stamp):
+		end =3D offsetofend(struct tcp_sock, snd_cwnd_stamp);
+		break;
 	case offsetof(struct tcp_sock, snd_ssthresh):
 		end =3D offsetofend(struct tcp_sock, snd_ssthresh);
 		break;
@@ -307,7 +310,8 @@ static u32 bpf_tcp_ca_min_tso_segs(struct sock *sk)
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
index 05dc2d05bc7c..c13d263dae06 100644
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
index 384fa5e2f065..661dca9e3895 100644
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



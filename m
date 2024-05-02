Return-Path: <bpf+bounces-28423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943B18B93DB
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 06:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75DF1C214AB
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 04:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FC31EA8F;
	Thu,  2 May 2024 04:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bUWY2uVT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC071B974
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 04:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714623839; cv=none; b=KWRX12bUc2fvFdjxcGecveR5d0w7bz4ufh2tbEXffTwPG/Z54Qby+haPSb8ca5ZzLHdG/LDYOM+imSdlQRt98Zh0gFr+7zSBGoVDQlYHVQAkf4XqMtykudqRlCT+B1xus/NS/zGAWZjmgWD5noizYFa97dEUhT7XHCI18N+t5TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714623839; c=relaxed/simple;
	bh=Z0WII5lUqq3PnSCvCLo1suIEAOcUVGhf1W9ZB94rRLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwAEXpwxif8XdRbbKoB5fv/LLL4zN1g75Q2Fo3VFJYoHDH9wpmqRnVAomUvosRi0xoNLHDDxaWPyLtVnKbMrYHBmZ1Z3FRB5lBgxCjJRagQKea4fEojJ5H5+u5i9mksfnDrfbWtAhLHKugLXAe3GLYFUbxzcL2jV8q43MLhEPzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bUWY2uVT; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 441L060Q025995
	for <bpf@vger.kernel.org>; Wed, 1 May 2024 21:23:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=J02JlNwBe+eBK6a8SEyyUE7aqAV4yt0ezY3h6QhmIR8=;
 b=bUWY2uVTvcayUprb/XZPHIAQ8G5JCqd30yFk3OA51+A9z1IKD5TDtCcTOWUA7We/dhj6
 15RwbJXpx8wDZ1HGJEhPsa5Qrtjy0ZkQUr7LgdJJgfYHgq7qRnWjdfMaAgIgiU/IQY7F
 bdsNakYqH9eOjHgx7tE/rTkGammU1zszOrT4dBCkQiCPIjJLrv0VGaea++h2nt4BqG6l
 zxwYqJwe+YnJjrGzlukkmcabgeVnhBnBbR0yYUlv7EmnHxrDpEMN8KOIt8y1pq1PxBRP
 327JF1ioYq5pE8ZH2s0IlHw1U0BcQemwKd5DrPWZsaSSGlh4T9PL6IPZDzqN5nM+lBSO kA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3xu2ymk05c-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 May 2024 21:23:56 -0700
Received: from twshared30219.42.prn1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 21:23:52 -0700
Received: by devvm15954.vll0.facebook.com (Postfix, from userid 420730)
	id 06515CB26230; Wed,  1 May 2024 21:23:41 -0700 (PDT)
From: Miao Xu <miaxu@meta.com>
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>, Martin Lau
	<kafai@meta.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Miao Xu <miaxu@meta.com>
Subject: [PATCH net-next v3 1/3] tcp: Add new args for cong_control in tcp_congestion_ops
Date: Wed, 1 May 2024 21:23:16 -0700
Message-ID: <20240502042318.801932-2-miaxu@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240502042318.801932-1-miaxu@meta.com>
References: <20240502042318.801932-1-miaxu@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TWuy4RnpSjx4_kZnjehVHVmqTxjhZ-kK
X-Proofpoint-GUID: TWuy4RnpSjx4_kZnjehVHVmqTxjhZ-kK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02

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
---
Changes in v3:
* Fixed the broken selftest

Changes in v2:
* Split the v1 patch into 2 separate patches. In particular, spin out
bpf_tcp_ca.c as a separate patch because it is bpf specific.

Signed-off-by: Miao Xu <miaxu@meta.com>
---
 include/net/tcp.h                                | 2 +-
 net/ipv4/bpf_tcp_ca.c                            | 3 ++-
 net/ipv4/tcp_bbr.c                               | 2 +-
 net/ipv4/tcp_input.c                             | 2 +-
 tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c | 6 +++---
 5 files changed, 8 insertions(+), 7 deletions(-)

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
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c b/tools/tes=
ting/selftests/bpf/progs/tcp_ca_kfunc.c
index fcfbfe0336b4..52b610357309 100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
@@ -5,7 +5,7 @@
 #include <bpf/bpf_tracing.h>
=20
 extern void bbr_init(struct sock *sk) __ksym;
-extern void bbr_main(struct sock *sk, const struct rate_sample *rs) __ks=
ym;
+extern void bbr_main(struct sock *sk, u32 ack, int flag, const struct ra=
te_sample *rs) __ksym;
 extern u32 bbr_sndbuf_expand(struct sock *sk) __ksym;
 extern u32 bbr_undo_cwnd(struct sock *sk) __ksym;
 extern void bbr_cwnd_event(struct sock *sk, enum tcp_ca_event event) __k=
sym;
@@ -42,9 +42,9 @@ void BPF_PROG(in_ack_event, struct sock *sk, u32 flags)
 }
=20
 SEC("struct_ops/cong_control")
-void BPF_PROG(cong_control, struct sock *sk, const struct rate_sample *r=
s)
+void BPF_PROG(cong_control, struct sock *sk, u32 ack, int flag, const st=
ruct rate_sample *rs)
 {
-	bbr_main(sk, rs);
+	bbr_main(sk, ack, flag, rs);
 }
=20
 SEC("struct_ops/cong_avoid")
--=20
2.43.0



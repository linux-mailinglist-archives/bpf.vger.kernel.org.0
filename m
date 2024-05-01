Return-Path: <bpf+bounces-28320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 024A38B8636
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 09:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B153C282186
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 07:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094E64DA04;
	Wed,  1 May 2024 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="D0BGyxAV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0372F4D11D
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549447; cv=none; b=HErLhVaW1Nlma46amMey0Zmq4yNpxmdgxrQDyxQ6HqSyNHF7+fMMM4LwczP6Wb5+Bv1wI4g0jvTFBcM6/+JtTx2qgsPdiVUDJ6X3QycwIcffUfe1Kga9SDQAQns6CH9oUOzrfG9+OvLmgF2Um39n7C8xhrazQxZTCxrTjqsCaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549447; c=relaxed/simple;
	bh=CpRN1RebEKCHQWKCypYm1QTsaXoJOa+MigklrXzfbyg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TP9C1S5vDCBeyYfTzZ+SvC7zlaKGj0xh5j7g9G46uZMRBKv/6QdwuGlM/3fr2Z8bornIFGz3Va/elvpdVYXK/D0CqdPYtMXtF6L69orMVA1CSiPi0zQikD0H1evoVZtfJLnDHXoU3Kv2Z1SA7LtaooC73AmXzeEI6nQEDA5cTnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=D0BGyxAV; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44101IQj007553
	for <bpf@vger.kernel.org>; Wed, 1 May 2024 00:44:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=nDwlXC3gWtRX4mJoN20pkRE42ghatCSQ/ZfmOl5M7oQ=;
 b=D0BGyxAVn4yKHMDvKxHbGSIlaIskcL9/TI58sG2IcWSbstS8GfCg0oDS1zRsGrKOeoqO
 fgIAuqnKmL7OcGcJ89gxs0FB0F6RkPrm+ona7vnMOED+6YbZd8+mvVmhKnlH5lDl0hNd
 alXTlo540dGdQZfnCZt9uKqC+ZivxR1Cc6G2H7AEWI+pejqKI7cJsWqQhUENJ/PNmyDY
 UqU9CzVXIHjchKGFqwnrrtd0tAnuY9erpCMAA1Mtlwghmi7F7Vv3kS12yEOMSYGqjsGg
 puO6IbnSImNrffKg7ZhwmPIPPCqpOjmN42yh6lNLbuwAJhbEne3Dtt5SXN6J8vJl3Lhm IQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3xtrupq54d-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 May 2024 00:44:05 -0700
Received: from twshared34373.14.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 07:44:02 +0000
Received: by devvm15954.vll0.facebook.com (Postfix, from userid 420730)
	id 6CDB2CA32BD4; Wed,  1 May 2024 00:44:01 -0700 (PDT)
From: Miao Xu <miaxu@meta.com>
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>, Martin Lau
	<kafai@meta.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Miao Xu <miaxu@meta.com>
Subject: [PATCH net-next v2 2/3] Allow to write tp->snd_cwnd_stamp in bpf_tcp_ca
Date: Wed, 1 May 2024 00:43:37 -0700
Message-ID: <20240501074338.362361-2-miaxu@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240501074338.362361-1-miaxu@meta.com>
References: <20240501074338.362361-1-miaxu@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sOx8p748pOq3j4OuhGI6iSjtRVT4n9p2
X-Proofpoint-GUID: sOx8p748pOq3j4OuhGI6iSjtRVT4n9p2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_06,2024-04-30_01,2023-05-22_02

This patch allows the write of tp->snd_cwnd_stamp in a bpf tcp
ca program. An use case of writing this field is to keep track
of the time whenever tp->snd_cwnd is raised or reduced inside
the `cong_control` callback.

Reviewed-by: Eric Dumazet <edumazet@google.com>
--
Changes in v2:
* None. It is a spinout from the original 1st patch.

Signed-off-by: Miao Xu <miaxu@meta.com>
---
 net/ipv4/bpf_tcp_ca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 6bd7f8db189a..18227757ec0c 100644
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
--=20
2.43.0



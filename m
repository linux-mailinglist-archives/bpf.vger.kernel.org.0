Return-Path: <bpf+bounces-28421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F3F8B93D8
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 06:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188411F2214A
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 04:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7971CD2D;
	Thu,  2 May 2024 04:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EMprmCPA"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860231CA82
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 04:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714623832; cv=none; b=UEXMzwQ9Bib4A3CUHTbbaNXi2CZhVu572g2dCiTO5C665aEiTuIWaw2lMXJEwBw/xVnRvUFMk8Y4caka3b4Wr/9ezTS338cFrzrYYbKx3zagZjrs6Jua1UbLaiPEmd/dtiivnGp6ot2W8gXRWpCynqdEDPAcNQuRsdp3MBDDmSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714623832; c=relaxed/simple;
	bh=mOFBz0Vwi79zWTBvD7c6ovgqZSa09WGBOELcyB6lWWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvzGvQug3NMQec8WKjChr21DO6yWO4YDMn9hwAZCGV6+fL/URAQVQWNGNuUYsdKm3ECG5sMaDYogPKky3k9LPUqFjm35nCOLyHNloOmmB9fevX2v0QzpGXMPnNJCNFfs6P0AENCiYHLLEs/9Wyx/sx1xQcJ7g/VdqTOBsJlNq+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EMprmCPA; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 441L060G025995
	for <bpf@vger.kernel.org>; Wed, 1 May 2024 21:23:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=FdW5u1MxBSQfGLg/7BMhH46+WtHnACBpEy9949+GeOc=;
 b=EMprmCPAF8ckU0nLGGnK/gweBIxWc5SlyeMi/ggZgLqJnSnhpRJ3bi1ouNsApx2pbt0e
 KmE0wbvFyZehsMYn6VhYVhhXUW5uZf0DbuGyDasXIbv0+hVUJ3zbDFXck9q05OXALHWV
 +ZFLB0DDeX4Q4JMFUX1jzRWOon+PVLkA5pVQrhkzdREFctbTezs0SCgvjbyZU1cx2jC6
 wyAQd/IAo/nfpygFyka6sgjJWZxmAOaIzZGYIFPJUqnFzvQTfhHX/I6xXxEYtcgMuDSr
 LZY/SfsTUPnt/qOD/cWXt/EkBuLc8132hRh/FR0Nts8kvfhm+LD1SUMgsyKyYeyfxEOd nw== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3xu2ymk05c-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 May 2024 21:23:49 -0700
Received: from twshared18280.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 21:23:45 -0700
Received: by devvm15954.vll0.facebook.com (Postfix, from userid 420730)
	id E8689CB26250; Wed,  1 May 2024 21:23:43 -0700 (PDT)
From: Miao Xu <miaxu@meta.com>
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>, Martin Lau
	<kafai@meta.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Miao Xu <miaxu@meta.com>
Subject: [PATCH net-next v3 2/3] bpf: tcp: Allow to write tp->snd_cwnd_stamp in bpf_tcp_ca
Date: Wed, 1 May 2024 21:23:17 -0700
Message-ID: <20240502042318.801932-3-miaxu@meta.com>
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
X-Proofpoint-ORIG-GUID: 9YlKpdXg1YnKMD1g6J39CaU9hawpmZoa
X-Proofpoint-GUID: 9YlKpdXg1YnKMD1g6J39CaU9hawpmZoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02

This patch allows the write of tp->snd_cwnd_stamp in a bpf tcp
ca program. An use case of writing this field is to keep track
of the time whenever tp->snd_cwnd is raised or reduced inside
the `cong_control` callback.

Reviewed-by: Eric Dumazet <edumazet@google.com>
---
Changes in v3:
* Updated the title.

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



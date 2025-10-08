Return-Path: <bpf+bounces-70611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 617F7BC6297
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C820A3A57D9
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDE82DC783;
	Wed,  8 Oct 2025 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NmRvRO6y"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACF22BF002
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944975; cv=none; b=KFIkNJmxHrspqJVJCdEo7hGmPpq4dRRFDNrCdg3MOC1NEqYS7j8yBjj6qHqlOq2S3QZRp9ac28mlsExT1UnHfUjHARQ7Z2TIvTVeGa0dWWr+Y4u8ucJLQ7MJ6t/ju48yQ1urXfp0X7sa//gyxSWT5ZtxpNsy9Kly2bH+HZCfkCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944975; c=relaxed/simple;
	bh=koysrC5/a1juJgOmrLfWqtZZSNZ8l/Gqt6Abqygx3dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqtJdmGJ8gEB0uy5KaiPBzGiDNWXub4vxFwmOVntLm5lLASNJgDH8h6zV7b+HRUGaaWaxhnCPAcRpBIqn3nz0wEZYDZuFzWwPG8U+fDLKKiwGx/I3BIezfuVqb0awJTBPqPRrY4PCy6Lp23etZYhThgY4QJMMq7EAO5WZlQmAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NmRvRO6y; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HEUFW032694;
	Wed, 8 Oct 2025 17:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=wNZXu
	NCKyXaSuzVbwPSzvyuUqgF8R5HZZY+IWGGe2xs=; b=NmRvRO6ymj+xho4uOCaZD
	cSKtb8oEAuOjPnKJKRW8yjw3uB/VEN189EVMLsxGrBFMxmcXZZqFTBrQypDquXzd
	pRku7OXUVzqjQt6TWKcjAGKlAwNHLrIvQnOcU3zV5kPzXp/Jj++I4KT4AHLDPuL7
	/+9hUWi9STlOOD8pLl2CcXvPnC0Y8sUdvuEwFaU9xue8X36XfP27E0xU7MJsmzAj
	43MpG+3tyJDOabmKdrhwNHpmcLwb3F9Ljz+QVyP/UqqfXKKt3nGeE7CupBWuMcZI
	GeXO39BAIrN5gP2EyDa1Jg1oR0oFKodOcgq5SIfJAb7kTjT1XC/2Q9xfYfwnKaFb
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6br1cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598HDrV5036952;
	Wed, 8 Oct 2025 17:35:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62rq3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:51 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 598HZFV8031138;
	Wed, 8 Oct 2025 17:35:50 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-90.vpn.oracle.com [10.154.53.90])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv62rpmb-14;
	Wed, 08 Oct 2025 17:35:50 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 13/15] libbpf: add API to load extra BTF
Date: Wed,  8 Oct 2025 18:35:09 +0100
Message-ID: <20251008173512.731801-14-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251008173512.731801-1-alan.maguire@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510080123
X-Authority-Analysis: v=2.4 cv=BLO+bVQG c=1 sm=1 tr=0 ts=68e6a0f9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=0nzwac6U1WC2CLVDLl4A:9 cc=ntf
 awl=host:13625
X-Proofpoint-ORIG-GUID: TgEcR260wZk4LSbKOQ5G51YyCyufjnsz
X-Proofpoint-GUID: TgEcR260wZk4LSbKOQ5G51YyCyufjnsz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX7x6NZ+TwfENE
 IARVi/nBnSfvXrt+TMIEwWyryZ//Xdmc2xXa8f5HrrymRCH1mRamqdi7yNGH4ylt0wxnPHkr3WY
 4n+JW7iwlwq/heCfy+kLN0+kU3y94PNUY3XObh8UveXaqC4ew5Pwjf98b/1KmnLLNU4NC/+Be74
 yZuURwcyqOOXu+1q0RTZ0tZWTAfGYzhUihjhCOQ39mv273AE0hFYjEPSlO0eFdhdUSucMCl6jQL
 dFnoIb7zE8e5bNK9RWA8upVa/G0Al0l4FjnCWT+MMuRZf5t0Qe11dKABsvZYMq34pKfxx67nP6P
 tJTJ4CNo4tcD3wQgRuNHrrvns+xeEoxXdzASkjVGTfCrjRHjHgzZUtoLD+xTi2n9LJjZtJ/WQ1T
 6i732sBJIwcAA4s4U8w1FNQ6VMbVkoEv6Ws3I9EjrlRRj60w3t8=

Add btf__load_btf_extra() function to load extra BTF relative to
base passed in.  Base can be vmlinux or module BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 8 ++++++++
 tools/lib/bpf/btf.h      | 1 +
 tools/lib/bpf/libbpf.map | 1 +
 3 files changed, 10 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 62d80e8e81bf..028fbb0e03be 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5783,6 +5783,14 @@ struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_bt
 	return btf__parse_split(path, vmlinux_btf);
 }
 
+struct btf *btf__load_btf_extra(const char *name, struct btf *base)
+{
+	char path[80];
+
+	snprintf(path, sizeof(path), "/sys/kernel/btf_extra/%s", name);
+	return btf__parse_split(path, base);
+}
+
 int btf_ext_visit_type_ids(struct btf_ext *btf_ext, type_id_visit_fn visit, void *ctx)
 {
 	const struct btf_ext_info *seg;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 082b010c0228..f8ec3a59fca0 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -138,6 +138,7 @@ LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf *base_b
 
 LIBBPF_API struct btf *btf__load_vmlinux_btf(void);
 LIBBPF_API struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_btf);
+LIBBPF_API struct btf *btf__load_btf_extra(const char *name, struct btf *base);
 
 LIBBPF_API struct btf *btf__load_from_kernel_by_id(__u32 id);
 LIBBPF_API struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 82a0d2ff1176..5f5cf9773205 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -456,4 +456,5 @@ LIBBPF_1.7.0 {
 		btf__add_loc_proto_param;
 		btf__add_locsec;
 		btf__add_locsec_loc;
+		btf__load_btf_extra;
 } LIBBPF_1.6.0;
-- 
2.39.3



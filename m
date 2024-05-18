Return-Path: <bpf+bounces-29982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FACB8C8EE4
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 02:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52601C20E22
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 00:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADC01A2C0A;
	Sat, 18 May 2024 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GQMa2GO6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931C161
	for <bpf@vger.kernel.org>; Sat, 18 May 2024 00:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715992221; cv=none; b=B4c6rwS/mMyyVyIZASbm49fQt1gX/MANABayBEGV2zixKLX1NY0FOpyVzSnJvzW3oTE8uQtl5lkD57pxyVPpNZIn+axUqcY7W7YbAPPxgYNgBMzdo2bKaYHsHAN1I0izB+KANsI1SSx7gNK2PGi+JHK634BSkz2c1tfd4hXz0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715992221; c=relaxed/simple;
	bh=R+t5eDT6OlX3s0V50wx16DQ3NKCxGDeesfI16J18Khk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhJSaaZaf0J9kLMg6hQ+/1rY5eYDmw8XDtJ7GARuxXbdcZd4tMpS802+UrmSSdFC/BAWYZ+MiQRG10kMprguLU32XGAa8gngFvnfE0IhNfb77oGeHO9X+9ush7SwoKxh2Y0LfmZ8OVKNKEKP2xt7mpYxN8p/1dr60QU2EdVT5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GQMa2GO6; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44HLeJQG000814
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 17:30:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=vtuucQ3ApEEh7t+z1rK+z0xIwbpF+2cv6NNtBH/Lj/U=;
 b=GQMa2GO6a1yrb8JxpYo98aB1nypC281eVSRpCqZ1alQo/O2wICLr6vG0QVgKbSB3h46s
 Jyhmc1Ymjrwj8MWig5sDni0xWyCXMVjFrsRKnb9iEcAJKWZjMV6gGORoHu+/KXLh+D93
 TXomGGZ2+J+TkcNr9dykjRbX8KRahuIGo38G+CtnVGa56ks6iNNWZRw6AXs3TlAyOHPL
 RMX6lTzpJcWALXrMH0KrcoS1U2S0JNSDFciQj/cPRD8rRpzji3K2cu2B0XEaRp7H5OE3
 ZAMiiQNBJiXCUgaY2AqVQlxIMmMIGpAvRHZqK+CZIJ3gnqC/6KWSnF02hQmqOTR/i0eu Hg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y61xswd5k-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 17:30:18 -0700
Received: from twshared19845.02.ash8.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 18 May 2024 00:30:15 +0000
Received: by devbig031.nha1.facebook.com (Postfix, from userid 398628)
	id 6028B1196E99; Fri, 17 May 2024 17:30:05 -0700 (PDT)
From: Raman Shukhau <ramasha@meta.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>
CC: Raman Shukhau <ramasha@meta.com>
Subject: [PATCH bpf-next 1/3] net: Fix for bpf_sysctl_set_new_value
Date: Fri, 17 May 2024 17:29:40 -0700
Message-ID: <20240518002942.3692677-2-ramasha@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518002942.3692677-1-ramasha@meta.com>
References: <20240518002942.3692677-1-ramasha@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DcYCd_K3y7gtHHGaTBrQKUP4t65ycFyT
X-Proofpoint-GUID: DcYCd_K3y7gtHHGaTBrQKUP4t65ycFyT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_11,2024-05-17_03,2023-05-22_02

Call to bpf_sysctl_set_new_value doesn't change final value
of the parameter, when called from cgroup/syscall bpf handler. No error
thrown in this case, new value is simply ignored and original value, sent
to sysctl, is set. Example (see test added to this change for BPF handler
logic):

sysctl -w net.ipv4.ip_local_reserved_ports =3D 11111
... cgroup/syscal handler call bpf_sysctl_set_new_value	and set 22222
sysctl net.ipv4.ip_local_reserved_ports
... returns 11111

Return value check is incorrect in __cgroup_bpf_run_filter_sysctl
specifically for the case when new value is set, as bpf_prog_run_array_cg
return 0 on success.

Signed-off-by: Raman Shukhau <ramasha@meta.com>
---
 kernel/bpf/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 8ba73042a239..bfc36e7ca6f6 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1739,7 +1739,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table=
_header *head,
=20
 	kfree(ctx.cur_val);
=20
-	if (ret =3D=3D 1 && ctx.new_updated) {
+	if (ret =3D=3D 0 && ctx.new_updated) {
 		kfree(*buf);
 		*buf =3D ctx.new_val;
 		*pcount =3D ctx.new_len;
--=20
2.43.0



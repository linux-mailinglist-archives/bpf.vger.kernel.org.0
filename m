Return-Path: <bpf+bounces-30021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8089B8C9A2E
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 11:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C5E1C20E71
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 09:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11C91CABB;
	Mon, 20 May 2024 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FIQ2gooN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57891BC4F
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196485; cv=none; b=uHGXZBsr07LUEckVawWtCNFNbPrPO4LsblVvW/XvVLerRTV8KuzIHZMA7HuoEIovta1FuzohOwjnUFEDfDKzWpo/3uiLvvbXhT+zgrD3E05neLEd8oMiJBHzN9IhCssTm8SBzYWkQd/ZLtPzITGtoFgLPPCgx7kflRP4QIqXsf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196485; c=relaxed/simple;
	bh=R+t5eDT6OlX3s0V50wx16DQ3NKCxGDeesfI16J18Khk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+H8grlBottUa5015ixLD9yG5EzS62iZjF+pYM/pBIfzoDiTlzL1iZjCe+y+ypZjAMeQfw7No3nmicBOGqeJdSiKKZFhypac7CLCRDUIOP3j+GaY3EUJEFypr4yxr36imkALAQ6ceW7m+zqPgxDpFiwEqMxrL/D/POuRgBfsYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FIQ2gooN; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44K5A3Vo014821
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 02:14:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=vtuucQ3ApEEh7t+z1rK+z0xIwbpF+2cv6NNtBH/Lj/U=;
 b=FIQ2gooN+rdyI7YemW/vWlXDS66Tk2g8HWDEuCas/oX5DQYYc8JBMEZvYfrenLb6oFVl
 NFRPUSfB/F7kkKqYlkZOou6ygi4Gy5N9aYASpWdRQ+TGfO6+nkBh3+u/QPLBlTvv9qZH
 D4MDKoRbwWNQDXHG35CKXv2JPuzu2D2bXmuHVHEmg2d8GPxfKWQwRswOy6r6MvzZYVRc
 4++NDFgn8fHN+y9bMJiZ1vImeFllGNWhw8E5tV5yDIrK+wOAnC+uQneNCxsDPv5144kb
 nEQDbXoIu1r7++iOqqXECpxGqYS7HYKey4OeL96RZCpsWxNTGlbs/J0V7jHndfySH0gp Ww== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y804d8rbb-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 02:14:43 -0700
Received: from twshared38934.02.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 20 May 2024 02:14:40 -0700
Received: by devbig031.nha1.facebook.com (Postfix, from userid 398628)
	id 0D2491349DBE; Mon, 20 May 2024 02:14:39 -0700 (PDT)
From: Raman Shukhau <ramasha@meta.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC: Raman Shukhau <ramasha@meta.com>
Subject: [PATCH v2 bpf-next 1/3] net: Fix for bpf_sysctl_set_new_value
Date: Mon, 20 May 2024 02:14:22 -0700
Message-ID: <20240520091424.2427762-2-ramasha@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240520091424.2427762-1-ramasha@meta.com>
References: <20240520091424.2427762-1-ramasha@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DOx8zJiG2Hk3rt5cqLGazJmck0dFL-UR
X-Proofpoint-ORIG-GUID: DOx8zJiG2Hk3rt5cqLGazJmck0dFL-UR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_04,2024-05-17_03,2023-05-22_02

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



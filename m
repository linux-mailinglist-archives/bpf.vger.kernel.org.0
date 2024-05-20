Return-Path: <bpf+bounces-30022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DC18C9A2F
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 11:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5473F1C20E5C
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 09:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2345C1BC4F;
	Mon, 20 May 2024 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="c3+WwBHx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CDA1BDC3
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196485; cv=none; b=C9/6GJJ4EYmXass4+KDm/dtlxm9lZznygZfkjJuUmD9pW7pcEb1YmCR/0RqSGB9/P55pLH6rLetMISn+408XQwNkbowCu9GUP272COBGiMlu4gzuFBox0CXKwEvUjBe9MA9e5vX/gcwHvw6hm2IYJ+KjBcD9IcZJfKWUv6Mpz/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196485; c=relaxed/simple;
	bh=lrWL79RThte4qel0gz4M4Tq+kmbIhbx0A4+OiG68zbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5+CLsjiL61qMvPcjTrELV9Cg7vg/IV0QzWnsA2UWgjndbftODwL4FG+mSsFheJZtUpkwBCHJW+zdwIVpTCIyVTYZZJOfWUrgxWn9sD8SIUVdwTGBWtETIIp+n8Dt8jc6Z0lTttGk0jSFTSJtAnpz4qaNxaKr+msDNvIcsgXN3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=c3+WwBHx; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44K5A3Vp014821
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 02:14:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=33HTu18De3TvEGiVutJxNjhhHd+G6R0/cMZ38cBJL4M=;
 b=c3+WwBHx0jVb1+vmE4Ww+QATWoh/CnFbCUt95ncnKDWkQVBYBWc8ph43YvHllnldk4RP
 2o0YShwdC80SCL4hB+AvlfS09a0S/JZ/9YxWffHqm9SzEVXR6KwvC+X5TSOp3Kk6PVTF
 BHdhOV3h5mxLYa1MYuM4Bu3E4vPVcGlyDT1xfctZZ9h9xWDWl7w6sGbjThgw6bHOFRHg
 43otdC798ssCfPcqw2B4/aKOvbtY5jxGJgxKzBqp8HopQxw27fzBcoah1KIkESWk+Obp
 5Qn3cRVc47/0BUXs47is9plALLnIbjJfPZwzmu7TURiAnT6FxfI4ra5F/nZ5Zgs463hq zg== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y804d8rbb-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 02:14:43 -0700
Received: from twshared38934.02.ash8.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 20 May 2024 02:14:40 -0700
Received: by devbig031.nha1.facebook.com (Postfix, from userid 398628)
	id 20B0F1349DC6; Mon, 20 May 2024 02:14:40 -0700 (PDT)
From: Raman Shukhau <ramasha@meta.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC: Raman Shukhau <ramasha@meta.com>
Subject: [PATCH v2 bpf-next 2/3] net: Improvement for bpf_sysctl_set_new_value
Date: Mon, 20 May 2024 02:14:23 -0700
Message-ID: <20240520091424.2427762-3-ramasha@meta.com>
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
X-Proofpoint-GUID: K3YybKGhzd6HvaL9wIIKMW4Z8q1vrWRp
X-Proofpoint-ORIG-GUID: K3YybKGhzd6HvaL9wIIKMW4Z8q1vrWRp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_04,2024-05-17_03,2023-05-22_02

When bpf_sysctl_set_new_value is called in cgroup/sysctl handler, updated
"new_len" is provided back to proc_sys_call_handler. But
proc_sys_call_handler	expects this value NOT to include \0 symbol, e.g.
if user do:

open("/proc/sys/net/ipv4/ip_local_reserved_ports", ...)
write(fd, "11111", sizeof("22222"))

or

echo -n "11111" > /proc/sys/net/ipv4/ip_local_reserved_ports

or

sysctl -w	net.ipv4.ip_local_reserved_ports=3D11111

proc_sys_call_handler receives count equal to `5`. if BPF handler code
doesn't account for that, new value will be rejected by
proc_sys_call_handler with EINVAL error.

To make behavior consistent for bpf_sysctl_set_new_value, this change
adjust `new_len` with `-1`, if `\0` passed as last character.
Alternatively, using `sizeof("11111") - 1` in BPF handler should work,
but it might not be obvious and spark confusion.

Signed-off-by: Raman Shukhau <ramasha@meta.com>
---
 kernel/bpf/cgroup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index bfc36e7ca6f6..23736aed1b53 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1742,7 +1742,10 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_tabl=
e_header *head,
 	if (ret =3D=3D 0 && ctx.new_updated) {
 		kfree(*buf);
 		*buf =3D ctx.new_val;
-		*pcount =3D ctx.new_len;
+		if (!(*buf)[ctx.new_len])
+			*pcount =3D ctx.new_len - 1;
+		else
+			*pcount =3D ctx.new_len;
 	} else {
 		kfree(ctx.new_val);
 	}
--=20
2.43.0



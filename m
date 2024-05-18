Return-Path: <bpf+bounces-29985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D42148C8EE7
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 02:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C7C1F21FD9
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 00:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3DE4C6C;
	Sat, 18 May 2024 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XmLaPLg1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABFC4A22
	for <bpf@vger.kernel.org>; Sat, 18 May 2024 00:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715992224; cv=none; b=XduFOyEZsTLyJw0/eaOoFmrDPPcAl0o0PyMyrp7CcVwr/uGmFTtfRqniwpwVk3S+JdeCFiq1JDMavrZK3izh67tAfixq73TY4ZVl+uDgC48VLzOhNY7qjTOt6Z+N6zsshE7Q81ZlT5xnIziwGRvcv2wZRbJxdPPLH3r02Ras84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715992224; c=relaxed/simple;
	bh=lrWL79RThte4qel0gz4M4Tq+kmbIhbx0A4+OiG68zbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H320+Fj4uQMYBOzC5lb+czNAnGmvlp7+4NF9U+qhy7nLyYmyNizd+504oOISyqOc6rbfglP+BGw6MW2hoTaKo+O80APR73FdNw5I7qL9q7TiDqYlf7VE2g41VIkPXyieYesTDSA+6z1DXMCFIwEfPNLMOgYJKQGurqQTsdbjf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=XmLaPLg1; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 44HMkakg031024
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 17:30:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=33HTu18De3TvEGiVutJxNjhhHd+G6R0/cMZ38cBJL4M=;
 b=XmLaPLg1/L437s1RljffNv7qYwkg3BQEkbVN9n4iL8GCf81Yg/APal/EsWP/8haZeKCE
 Z7Wyzw/QJIRR44nC3fJArFH/Zqe5peWEhYHpLVQUW3dSlKZlbpNp8z4z2QTF258m7jrN
 0yMNln40wFsqeZOXYeOvQ0XIXxiiv07AQuLryBlnkdS/6NO9RGX6Qrm8mpag1yL+KJgw
 kSOhD/GQUgH+WcUlnQDCPk76B5VwAVj0elJBWkUzEiPXYbrU+bI6IKZiYTu4cIJX+5t8
 8K991ib2VJO+ngjhTSB2XBtLigtlDyz1uaX4/gR7o/CZGtpd4KQ0GzzwrF0/ILkAxGZf aA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3y6gav8bre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 17:30:22 -0700
Received: from twshared53727.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 18 May 2024 00:30:19 +0000
Received: by devbig031.nha1.facebook.com (Postfix, from userid 398628)
	id 4E95B1196E9D; Fri, 17 May 2024 17:30:06 -0700 (PDT)
From: Raman Shukhau <ramasha@meta.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>
CC: Raman Shukhau <ramasha@meta.com>
Subject: [PATCH bpf-next 2/3] net: Improvement for bpf_sysctl_set_new_value
Date: Fri, 17 May 2024 17:29:41 -0700
Message-ID: <20240518002942.3692677-3-ramasha@meta.com>
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
X-Proofpoint-ORIG-GUID: kJDsrpkFuU1AQDmRYT6w9s0KOloR7XxF
X-Proofpoint-GUID: kJDsrpkFuU1AQDmRYT6w9s0KOloR7XxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_11,2024-05-17_03,2023-05-22_02

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



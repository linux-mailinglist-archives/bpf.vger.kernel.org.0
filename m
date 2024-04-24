Return-Path: <bpf+bounces-27696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A0D8B0EFD
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E20D2957BA
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDC515FD01;
	Wed, 24 Apr 2024 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pdm7qB+V"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95641422AF
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973750; cv=none; b=h1NZR+iUfqPK5Rq8oTZ/J57oGC9SynIKuen5oseXAlWp8iBUJm9Mz7/hKJO570L7iGjAmd6N0brgqB2k/snuADm89kBYBSGdVy97giXmwo0vHTza8jK8EDhST01J07zQ0KgPQhFAqJs17IU6jen9Vu7EJ8Js7WD2rRk5RUXIK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973750; c=relaxed/simple;
	bh=tnXTHe3xU4E7y/5Yhk4AbMHTlu41IBQUux2Fa7q+eb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uTLiOyUvdzS6SMALcwzFl8E+c2IMR61S3FCTQYLoyfqnFp/enb6kKLgkovV3DehtuHUu+un+EAOI2rlL76fkj+4kt/XcjETI0ZTf8frFhC/GMqpHi6kNJaBnZ37NKl2JqTSPJA//DcOHEuhWilZFzGxBIYasNESOOTNCPtutwK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pdm7qB+V; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OFmTnT010764;
	Wed, 24 Apr 2024 15:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=NbIzoDctJO5F58EQSIWbFu7MzKLE3C1mK+jaeDc3h5w=;
 b=Pdm7qB+VLhx5lRf0BNf0dXu6FOFr8xWv65319WJ0ZbjA0wUIkA7Y5ZiLgHKKK5HMwlRZ
 SQeo9M6GbN2xGQE7Jh/M1JKbtuZOkRKXduBDfhxdFLOwc78c1s/fdwnxyfnz28C/q7t9
 I07YuOxgAeIkIpLe++kcmF47ZqKNJjnWF9dlwrV1lRmTHUtOHtgHl1jdbDtXmz6hNMvL
 kGQECu/z2M1VZ8YvsDyiZAqjaY5EYgLMcMjR5CTy3Zu6DcgWq4rBqA7TLJZDCQACBNR2
 YHBORUigJA7tDFt/1xX9ask5A9KPCr3O/wSUSKy8NHtAwiPU3GeN0aDzCC1NtVMfRJJJ 4Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm68vh4s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:48:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OFHTri025242;
	Wed, 24 Apr 2024 15:48:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45fayq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:48:39 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OFmCoY008769;
	Wed, 24 Apr 2024 15:48:38 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-216-158.vpn.oracle.com [10.175.216.158])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xm45faxuq-6;
	Wed, 24 Apr 2024 15:48:38 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com,
        eddyz87@gmail.com, mykolal@fb.com, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 05/13] bpftool: support displaying raw split BTF using base BTF section as base
Date: Wed, 24 Apr 2024 16:47:58 +0100
Message-Id: <20240424154806.3417662-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240424154806.3417662-1-alan.maguire@oracle.com>
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_13,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240063
X-Proofpoint-GUID: ks4thJGurJkld7_9ZgyzpQSSui0luenO
X-Proofpoint-ORIG-GUID: ks4thJGurJkld7_9ZgyzpQSSui0luenO

If no base BTF can be found, fall back to checking for the .BTF.base
section and use it to display split BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/btf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..2e8bd2c9f0a3 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -631,6 +631,15 @@ static int do_dump(int argc, char **argv)
 			base = get_vmlinux_btf_from_sysfs();
 
 		btf = btf__parse_split(*argv, base ?: base_btf);
+		/* Finally check for presence of base BTF section */
+		if (!btf && !base && !base_btf) {
+			LIBBPF_OPTS(btf_parse_opts, optp);
+
+			optp.btf_sec = BTF_BASE_ELF_SEC;
+			base_btf = btf__parse_opts(*argv, &optp);
+			if (base_btf)
+				btf = btf__parse_split(*argv, base_btf);
+		}
 		if (!btf) {
 			err = -errno;
 			p_err("failed to load BTF from %s: %s",
-- 
2.31.1



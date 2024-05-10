Return-Path: <bpf+bounces-29452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 729C48C2226
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 12:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259672818ED
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E66779DD5;
	Fri, 10 May 2024 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J9gn4ME0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A522233B
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337110; cv=none; b=KpK1WH/ukJwEqzuwUcuLEDX2kkRbW46KAWat1wj1REbi9oBlw1gzFnnUgvClq8EJUhPJ2BA0q6Gou2B7KRqh0d02kN9f9gds2YBYkAlQ39be+kwGC44BAv9d5a65jGTSaINruXHzwBKYTlfRckbZzrKdsoY+jNEjh+66AIDeRcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337110; c=relaxed/simple;
	bh=n+0E3E5edjklp7dGzvm9IgDdc/nnGhrGYusc7hvVL74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qJ8kgqldAbFWUB9X9qZr0dzgwceQ/dum1FLZ9+mTu0wbtQFvognonNvlj3YmdEPUgjLuWZZcC/3bo/cvz2xvRN2Bjd23UO++E9GgZy7585mQjWOPxpWhoBUj+fPheDj683ihXcCns2frh1T7uRsa8bPHXMDT/VpQYwdiEstyaqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J9gn4ME0; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AASsrJ015469;
	Fri, 10 May 2024 10:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=0YNCbKpyb3opOuzUulyTslCsmRcngO1VBVACpcslM94=;
 b=J9gn4ME0nLFC+t7d4Yyhp3W/BAKw+hxrVyPIvHamaxA8EAlupvJZYCzlGcImAC9EsAUB
 uB+hF7WkkIwxLDvDggn6CRHdDGwHV6xeD7z3arMf3z6E7qi2KdmbPnDayeVwTVKbwCNc
 s4YoLj73SQYiw4c8u9C0TqYCuaokC9Vzhz0zMMyf7Y6/hvYvD9zWWP9Hl2oU743bJiDl
 yir9T6YBYrITWYY2q7ainR7ZEMd+/tp3cvQzEd6/K3mHAxJV9I7qzvynDS7TwxV63P6a
 hny+TZxWxR9cGoW/HVrX0yhVqGJhznMeQMxq+eCFxq2S4mWf2SJB7tXV5hyK5fN/2g00 gA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1a0j8pes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:31:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44AANoIa019720;
	Fri, 10 May 2024 10:31:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfpcmxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:31:26 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44AAV0hZ011786;
	Fri, 10 May 2024 10:31:25 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-161-199.vpn.oracle.com [10.175.161.199])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xysfpcm4p-5;
	Fri, 10 May 2024 10:31:25 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 04/11] bpftool: support displaying raw split BTF using base BTF section as base
Date: Fri, 10 May 2024 11:30:45 +0100
Message-Id: <20240510103052.850012-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240510103052.850012-1-alan.maguire@oracle.com>
References: <20240510103052.850012-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_07,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100074
X-Proofpoint-ORIG-GUID: wsMT7UfLGIKGujK34Co_sXOiohV_drhB
X-Proofpoint-GUID: wsMT7UfLGIKGujK34Co_sXOiohV_drhB

If no base BTF can be found, fall back to checking for the .BTF.base
section and use it to display split BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/btf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..0ca1f2417801 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -631,6 +631,14 @@ static int do_dump(int argc, char **argv)
 			base = get_vmlinux_btf_from_sysfs();
 
 		btf = btf__parse_split(*argv, base ?: base_btf);
+		/* Finally check for presence of base BTF section */
+		if (!btf && !base && !base_btf) {
+			LIBBPF_OPTS(btf_parse_opts, optp, .btf_sec = BTF_BASE_ELF_SEC);
+
+			base_btf = btf__parse_opts(*argv, &optp);
+			if (base_btf)
+				btf = btf__parse_split(*argv, base_btf);
+		}
 		if (!btf) {
 			err = -errno;
 			p_err("failed to load BTF from %s: %s",
-- 
2.31.1



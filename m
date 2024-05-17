Return-Path: <bpf+bounces-29937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2178C84BA
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 12:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C71285037
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61195374FB;
	Fri, 17 May 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G8zoWyrp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53DB364DA
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941443; cv=none; b=I7DU4JrlTzW7o3Eyst1gXI3cOnaqdOpcuj8DBGnlOPa9cqR2uugNHFBkVYr7IJOkp8mAjSKh0c1WlWghaFzHc23MGvQBR9nier94w1nJiIN0iVQ+e4YhHzQR/Jfe8ebXTRmw9+YYtNTM0e6wprRwacSlRXOjCgegfvVy1oOd6k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941443; c=relaxed/simple;
	bh=qcWPhLjDHY6CcpCjNU1MQZYsT6uLYlDoZuk3WyLhdhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oAlB+++8l2lWzy0jOy0/AOEzHnXMbKNUGkZcMalv02n5fbCn/6F2BlSFCBWyWhF2FmxnfgWCp8EG8JnBTtnSERNmItRiXgQKs9PHgoUJstKKGkUHy20pVkh1hoH1JNvONN2E7WCKO1Q/jGobZA2fHZwn/94OFXiKmv7Swk7e0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G8zoWyrp; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44H5Oudj007575;
	Fri, 17 May 2024 10:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=JJJz8ZRYZQlbtouiAH1SaVGrf5QMTghBmUWnxKuSwfQ=;
 b=G8zoWyrplyHTAZy61rHcEz8K2f5ja7zeqaX7H4dCJBGlcEF7jcd7nhU5CdVUFr98V9jw
 5h9ihoBkyL+GGkNXNqTUD2We4KiLjD7Vtpkc+tv9aCimBBkWNa5ORKhpwzzl6G8S0qgQ
 OsAyGp9gexwSJo8rhhGQWfmNfV/ZLfdo19xR28zgznnU/6aIHoq+gKWoItTBPdc+Xz51
 JPv86fyMQeQ8UweUT6/9aT5i2hL+eRk95C19sVXY3Ga2sbRAJrVzqTFwIFKnbIcvw/eR
 l0AclDKs3LbGkTios6Zn7WH/pSaLi7gFv7Gdu7xCuirrjr9xSo7eiRNSw8bnK7crVopV BA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3srryre1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 10:23:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44HA2YPP000531;
	Fri, 17 May 2024 10:23:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y4fsuqs39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 10:23:16 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44HAMqFg036134;
	Fri, 17 May 2024 10:23:15 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-196-17.vpn.oracle.com [10.175.196.17])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y4fsuqrr2-5;
	Fri, 17 May 2024 10:23:15 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Quentin Monnet <qmo@kernel.org>
Subject: [PATCH v4 bpf-next 04/11] bpftool: support displaying raw split BTF using base BTF section as base
Date: Fri, 17 May 2024 11:22:39 +0100
Message-Id: <20240517102246.4070184-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240517102246.4070184-1-alan.maguire@oracle.com>
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_03,2024-05-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405170082
X-Proofpoint-ORIG-GUID: QsZti-CaIHlxpPJkOJju6iWiJSpSV50C
X-Proofpoint-GUID: QsZti-CaIHlxpPJkOJju6iWiJSpSV50C

If no base BTF can be found, fall back to checking for the .BTF.base
section and use it to display split BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/btf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index af047dedde38..67be216023e8 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -756,6 +756,14 @@ static int do_dump(int argc, char **argv)
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



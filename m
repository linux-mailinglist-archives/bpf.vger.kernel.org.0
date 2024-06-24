Return-Path: <bpf+bounces-32936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05402915729
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 21:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FC61C21128
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 19:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929061A00F9;
	Mon, 24 Jun 2024 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ldf8yvPe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72519EEC7
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257392; cv=none; b=ADeL39xVByqexhoUoA7R8zDRPh+nJ9zDv/i4rwObv7pj2Fa9DlCPywD3n3KsD0bHllzHMZIpd3gajADhJFQWQ/CbM+VIT5LZzsxoWCIe4MlT4jcQGbiXK+Yo8dM9vIOUe/4TfHKcSAL7Xb/aNtslVzs7VDM8AYHncD5y968JHOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257392; c=relaxed/simple;
	bh=O4EP35jwf57p9qz5gFlKkOE9h7ZdNlX2M+JrRUSvEig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4Jo6+wRjPztRL2MByzC0vruyv2atc8i1wbevJ9UC4hyIfXndlgNpNREgNvw/sqp8BvtMGPHdEX2I9ZB3/YQDnoDZSXKERyFlAYSmh2/FqcZmwJKYaYNkEFrFBAtXmKp30Wuzs0cn31mGd9x2uylIwKrGpXVXjoUVklLVMalbEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ldf8yvPe; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OIZ69O004717;
	Mon, 24 Jun 2024 19:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=ugsGpnRJVLxq4i
	n7ojpIeRIimLARuvgmwEuVwb9l0LQ=; b=ldf8yvPeTmyjDdbkjY31YlCCHCLLB3
	4WXG6N4Hq79mN28vMxoXDJxoBLteRj8ID63yXz9vjm6jb+3CcmRWxmy2z/nvKqsm
	2XBYtzOIHnjzcyo8suW6Jm5ER9CNlM6p/012m6jimt1Sj+yFb3gSHw3lbIZd4Nbr
	c/1o87/uv3W7IN22K/nIAlRlpoF0/e7Vpv9hpYAkLaF8Yzb/PA9wVpmVs1Hdsa4A
	2bdUF2CmaiwP4CZbWJDRGmN1h9Ts9GsEEmWrP4h7m2KCQuAB+58Hk/Ocp2otwfr0
	On9AEN55+Wi1c9Lz/0GRfIWfnlXGodKwy0n/pzBitI+r6zV/CdnHMfdQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpnc5q70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 19:29:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45OIXJ5p017783;
	Mon, 24 Jun 2024 19:29:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn26gy87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 19:29:11 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45OJTAnW028651;
	Mon, 24 Jun 2024 19:29:10 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-193-239.vpn.oracle.com [10.175.193.239])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ywn26gy17-1;
	Mon, 24 Jun 2024 19:29:10 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org
Cc: acme@redhat.com, daniel@iogearbox.net, jolsa@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com,
        bentiss@kernel.org, tanggeliang@kylinos.cn, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next] libbpf: fix clang compilation error in btf_relocate.c
Date: Mon, 24 Jun 2024 20:29:03 +0100
Message-ID: <20240624192903.854261-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_16,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406240155
X-Proofpoint-GUID: -DHNLHxv5t9o-MgBjQ4Qdch7qYJ6xfCQ
X-Proofpoint-ORIG-GUID: -DHNLHxv5t9o-MgBjQ4Qdch7qYJ6xfCQ

When building with clang for ARCH=i386, the following errors are
observed:

  CC      kernel/bpf/btf_relocate.o
./tools/lib/bpf/btf_relocate.c:206:23: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
  206 |                 info[id].needs_size = true;
      |                                     ^ ~
./tools/lib/bpf/btf_relocate.c:256:25: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
  256 |                         base_info.needs_size = true;
      |                                              ^ ~
2 errors generated.

The problem is we use 1-bit, 31-bit bitfields in a signed int.
Changing to

	bool needs_size: 1;
	unsigned int size:31;

...resolves the error and pahole reports that 4 bytes are used
for the underlying representation:

$ pahole btf_name_info tools/lib/bpf/btf_relocate.o
struct btf_name_info {
	const char  *              name;                 /*     0     8 */
	unsigned int               needs_size:1;         /*     8: 0  4 */
	unsigned int               size:31;              /*     8: 1  4 */
	__u32                      id;                   /*    12     4 */

	/* size: 16, cachelines: 1, members: 4 */
	/* last cacheline: 16 bytes */
};

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf_relocate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
index 2281dbbafa11..66c6204c4064 100644
--- a/tools/lib/bpf/btf_relocate.c
+++ b/tools/lib/bpf/btf_relocate.c
@@ -58,8 +58,8 @@ struct btf_relocate {
 struct btf_name_info {
 	const char *name;
 	/* set when search requires a size match */
-	int needs_size:1,
-	    size:31;
+	bool needs_size: 1;
+	unsigned int size: 31;
 	__u32 id;
 };
 
-- 
2.31.1



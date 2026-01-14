Return-Path: <bpf+bounces-78953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C88D20DC4
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 19:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E67463039336
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78A43358B5;
	Wed, 14 Jan 2026 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZKhL2KnJ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF72C859
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415942; cv=none; b=bW/+YgGPi1L4sSKMeLPpeAdx38uh0tbGGI2oTfYyPW/ndXbDMZpXvsHpQZmHAxRepjke8kxgMlRhyYVpqGpOcRRSxm/hr53XBifpqK+oI92yTKV9XcM9EGeQmEOS66U8eJjjS0tFGI6F8cZrgfACVoXQLWc6JjMo63XBprC7sY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415942; c=relaxed/simple;
	bh=tm15l9ZXJMMEeWHbKlE1UI75IAMaaMYWn+esNMClrGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyOSfStkJz12ipk4W/CGcsPFZkgdf60TZlV9qUGFK8pO0IwKpd/loT4HM2oI2gxo7VSQRbwYMxFzTRvWlu1cpogxmKX3lAkqA7UpQgq7BZJrP6/6Sf2tx/dH4l6FXB1H8ltshW3ZxYWkp17I6OqKHUsy4eMK8TcciWehclAMY6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZKhL2KnJ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EHNN1l1098168;
	Wed, 14 Jan 2026 18:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=I61un
	Uxr3PderFa7ghqhoxY3zDVJ8mVLy765H8AsR2c=; b=ZKhL2KnJuwjCBCdmZWDmp
	ePr5KeWmmH90hQC9wJkMKUrLu4GCVXbfvX0d9kFmPq2pcKhRZ2prCl92YMmydAOZ
	qtGdxphsyvApeVZ8p6cQVObwig+uU6PYz5T3sxr600tY3E54xI71BlD6dpCMGm5M
	gRetqX4xRGb1Ev9GGYCAYMmwZaCGya8IYm2FoH5Fjs8v3hYFpyx4f61/XQ7A7ccV
	/jmCxbXctrLIzr3t1zaBPc1MN83xSjLf5CEVXp08FpC38TrzkK/w1ufgbWEScpLS
	0v6hLouvW580eoL2xHBInKijMd0ZOE5QY431jzfr3Om0tqhhP4IYMpu6nlwSmdf5
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkntb5s6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 18:38:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60EGoECs004570;
	Wed, 14 Jan 2026 18:38:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7acdju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 18:38:30 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60EIcNUH016071;
	Wed, 14 Jan 2026 18:38:30 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-147.vpn.oracle.com [10.154.50.147])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bkd7acd9y-3;
	Wed, 14 Jan 2026 18:38:29 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, yonghong.song@linux.dev
Cc: nilay@linux.ibm.com, ast@kernel.org, jolsa@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, bvanassche@acm.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Verify dedup for skipped modifiers
Date: Wed, 14 Jan 2026 18:38:08 +0000
Message-ID: <20260114183808.2946395-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260114183808.2946395-1-alan.maguire@oracle.com>
References: <20260114183808.2946395-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601140155
X-Proofpoint-GUID: tUhVOcnysQUeqiaijaJ2tEgdVk5Q9VPi
X-Proofpoint-ORIG-GUID: tUhVOcnysQUeqiaijaJ2tEgdVk5Q9VPi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE1NCBTYWx0ZWRfX3nXDZuMpiAEi
 Hm+rlgx83dm921veNXeLkViW7N0ckp+8UJgvl74DT5ttd1xFKhaztmpgvkOv9zczpEMlHb/5IhP
 phX2M68PgNqKeolgwxwzx9CwynjYiKrn7hbGfkvp4jzhYvpLXchv8fwdu+HNIfCp1FTCWC/U6En
 trLjViqJTj/WwkxGjqBqrONwLdh/3X0ZSZ5b8cFowhFjnFe63aWWUxl9+UVCtNXw+f9N9HMvXKj
 PP6uSYYcyQFV5U2ZDJ69pmcU9iFid49ehTBl429ZT1ruKAQYGkHUkYhzErDdqQJf0lO7B1aHMCw
 CcRU70fBNkpPydoSyS4hLt04tJfdQvPEtN5GiO5sHMCILcRu7Pbz7RdQwmwzI/ivBWWgvLzORea
 eH06ByWzBA0X5UlFpQYavgEyx/DxQecWcNYt3YvkwocUZ5lJNNH6BLXDEBx4qAOftgvyi4VItWD
 lQrgtxBLzMKYUiyzIsw==
X-Authority-Analysis: v=2.4 cv=fIc0HJae c=1 sm=1 tr=0 ts=6967e2a7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=GyULOOCZ9u9S_366nP0A:9

Ensure that dedup marks types as identical when modifiers are
skipped.  Do this for non-split BTF (where any struct can
be deduplicated) and split BTF (where we are forced to
deduplicate against the base BTF struct).  Use a mix of
modifiers in the base struct to ensure equivalence checks
work both when the canonical has and does not have modifiers.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../bpf/prog_tests/btf_dedup_split.c          | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
index 5bc15bb6b7ce..221efe712fa5 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
@@ -539,6 +539,77 @@ static void test_split_module(void)
 	btf__free(vmlinux_btf);
 }
 
+static void test_modifier(bool split)
+{
+	struct btf *btf1 = NULL, *btf2 = NULL;
+	int err;
+
+	btf1 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf1, "empty_main_btf"))
+		return;
+
+	btf__set_pointer_size(btf1, 8); /* enforce 64-bit arch */
+
+	btf__add_int(btf1, "int", 4, BTF_INT_SIGNED);   /* [1] int */
+	btf__add_volatile(btf1, 1);                     /* [2] volatile int */
+	btf__add_const(btf1, 2);			/* [3] const volatile int */
+	btf__add_struct(btf1, "s1", 8);                 /* [3] struct s1 { */
+	btf__add_field(btf1, "f1", 3, 0, 0);            /*      const volatile int f1; */
+	btf__add_field(btf1, "f2", 1, 0, 0);		/*	int f2; */
+							/* } */
+
+	if (split) {
+		btf2 = btf__new_empty_split(btf1);
+		if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
+			goto cleanup;
+	} else {
+		btf2 = btf1;
+	}
+
+	btf__add_struct(btf2, "s1", 8);                 /* [4] struct s1 { */
+	btf__add_field(btf2, "f1", 1, 0, 0);            /*      int f1; */
+	btf__add_field(btf2, "f2", 2, 0, 0);		/*	volatile int f2; */
+							/* } */
+	btf__add_struct(btf2, "s1", 8);                 /* [5] struct s1 { */
+	btf__add_field(btf2, "f1", 2, 0, 0);            /*      volatile int f1; */
+	btf__add_field(btf2, "f2", 3, 0, 0);		/*	const int f2; */
+							/* } */
+
+	VALIDATE_RAW_BTF(
+		btf2,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] VOLATILE '(anon)' type_id=1",
+		"[3] CONST '(anon)' type_id=2",
+		"[4] STRUCT 's1' size=8 vlen=2\n"
+		"\t'f1' type_id=3 bits_offset=0\n"
+		"\t'f2' type_id=1 bits_offset=0",
+		"[5] STRUCT 's1' size=8 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=2 bits_offset=0",
+		"[6] STRUCT 's1' size=8 vlen=2\n"
+		"\t'f1' type_id=2 bits_offset=0\n"
+		"\t'f2' type_id=3 bits_offset=0"
+	);
+
+	err = btf__dedup(btf2, NULL);
+	if (!ASSERT_OK(err, "btf_dedup"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		btf2,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] VOLATILE '(anon)' type_id=1",
+		"[3] CONST '(anon)' type_id=2",
+		"[4] STRUCT 's1' size=8 vlen=2\n"
+		"\t'f1' type_id=3 bits_offset=0\n"
+		"\t'f2' type_id=1 bits_offset=0"
+	);
+cleanup:
+	if (btf1 != btf2)
+		btf__free(btf2);
+	btf__free(btf1);
+}
+
 void test_btf_dedup_split()
 {
 	if (test__start_subtest("split_simple"))
@@ -551,4 +622,8 @@ void test_btf_dedup_split()
 		test_split_dup_struct_in_cu();
 	if (test__start_subtest("split_module"))
 		test_split_module();
+	if (test__start_subtest("modifier"))
+		test_modifier(false);
+	if (test__start_subtest("split_modifier"))
+		test_modifier(true);
 }
-- 
2.31.1



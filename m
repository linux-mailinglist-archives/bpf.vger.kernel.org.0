Return-Path: <bpf+bounces-50545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA03A296E9
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 18:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72EA16481B
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 17:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7921DC998;
	Wed,  5 Feb 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I9uOZTer"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9802AF507
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774886; cv=none; b=pH77tAegJviTmR3O1OFqvk+gUbO1myDU4Z2pDGhumNIpze1tyy46ywQ0bXOHeJpZ9K+kB7EU5Hanv5vnLxHSEq93pcWFsuJJBPwSU/ZaqryCypmdBavGgS2i1XPv1u/7+Z0QG8oic+t68wMcdUNjwMFuvWQPg6JScxlnKgcrgK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774886; c=relaxed/simple;
	bh=VQWEnSGMI57IQ1cuwhwvsYrMRPlhM3mBzZp++GRr7oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzBufAOtkrGBXPwru4DM0z2RQo1p7zm4erfEWK0goC0JJZ4HY3d16tVwt9GIEesl57Tx4bydjR9Snu+MXZ5l5RVlU6+Zi4qfU83/9ZxUmUJIXv57ia0DA2C7PmQleg5Z6KyYIUM7Vt28Hamy09BHLcZ6bGcJZPYSCtVgL3V3+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I9uOZTer; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Gfip3009552;
	Wed, 5 Feb 2025 17:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=2n8KYG1scOzWYcX4p2dBNysIC40FJ
	zK0Kpp2ctj1T9k=; b=I9uOZTerjGZNL2rd+x8eWs0uZAl3EkNse3aKernhfiEDJ
	TieehrMcfLC7p6mECBBg32YOqABOnPMNVj2nwuhcZAKRSnAvZ8N8D3aAIs984/pL
	fs4UL/vgmepzRCIwYflEuzmhh11OoKcLHZ4PW+Oo41hlEvRzvJoo1mX7LkZpxA4J
	k+NvA89GE7J5CuyF/O2f47y8suk2hSqUJ8JFDK16UOZG+Q5YLdM+h8OiqVFKx6iP
	diSKEI3+jnVH3Uwnrs6CeJcybjl+yFue4/umYumFc/2jgrKyadrDvkZB2CvXiXCL
	ANObDfoiUWSa3bCdxtUjyJZCDhfP+/Cg89yApaRjg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4tt76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 17:01:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515GOqLw027841;
	Wed, 5 Feb 2025 17:01:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dnwsm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 17:01:02 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 515H10V2013304;
	Wed, 5 Feb 2025 17:01:01 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-48-77.vpn.oracle.com [10.154.48.77])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44j8dnwsh1-1;
	Wed, 05 Feb 2025 17:01:01 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Colm Harrington <colm.harrington@oracle.com>
Subject: [PATCH v2 bpf] bpf/arena: fix softlockup in arena_map_free on 64k page kernel
Date: Wed,  5 Feb 2025 17:00:59 +0000
Message-ID: <20250205170059.427458-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050130
X-Proofpoint-GUID: 9BAve4wghOu_DoFwLgjFHh-aFFMatuPc
X-Proofpoint-ORIG-GUID: 9BAve4wghOu_DoFwLgjFHh-aFFMatuPc

On an aarch64 kernel with CONFIG_PAGE_SIZE_64KB=y (64k pages),
arena_htab tests cause a segmentation fault and soft lockup.

$ sudo ./test_progs -t arena_htab
Caught signal #11!
Stack trace:
./test_progs(crash_handler+0x1c)[0x7bd4d8]
linux-vdso.so.1(__kernel_rt_sigreturn+0x0)[0xffffb34a0968]
./test_progs[0x420f74]
./test_progs(htab_lookup_elem+0x3c)[0x421090]
./test_progs[0x421320]
./test_progs[0x421bb8]
./test_progs(test_arena_htab+0x40)[0x421c14]
./test_progs[0x7bda84]
./test_progs(main+0x65c)[0x7bf670]
/usr/lib64/libc.so.6(+0x2caa0)[0xffffb31ecaa0]
/usr/lib64/libc.so.6(__libc_start_main+0x98)[0xffffb31ecb78]
./test_progs(_start+0x30)[0x41b4f0]

Message from syslogd@bpfol9aarch64 at Feb  4 08:50:09 ...
 kernel:watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworker/u8:4:7589]

The same failure is not observed with 4k pages on aarch64.

Investigating further, it turns out arena_map_free() was calling
apply_to_existing_page_range() with the address returned by
bpf_arena_get_kern_vm_start().  If this address is not page-aligned -
as is the case for a 64k page kernel - we wind up calling apply_to_pte_range()
with that unaligned address.  The problem is apply_to_pte_range() implicitly
assumes that the addr passed in is page-aligned, specifically in this loop:

		do {
                        if (create || !pte_none(ptep_get(pte))) {
                                err = fn(pte++, addr, data);
                                if (err)
                                        break;
                        }
                } while (addr += PAGE_SIZE, addr != end);

If addr is _not_ page-aligned, it will never equal end exactly.

One solution is to round up GUARD_SZ to PAGE_SIZE << 1 so that the
division by 2 in bpf_arena_get_kern_vm_start() returns a page-aligned
value.  With that change in place, the test passes:

$ sudo ./test_progs -t arena_htab
Summary: 1/1 PASSED, 1 SKIPPED, 0 FAILED

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Reported-by: Colm Harrington <colm.harrington@oracle.com>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/arena.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 870aeb51d70a..095a9554e1de 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -39,7 +39,7 @@
  */
 
 /* number of bytes addressable by LDX/STX insn with 16-bit 'off' field */
-#define GUARD_SZ (1ull << sizeof_field(struct bpf_insn, off) * 8)
+#define GUARD_SZ round_up(1ull << sizeof_field(struct bpf_insn, off) * 8, PAGE_SIZE << 1)
 #define KERN_VM_SZ (SZ_4G + GUARD_SZ)
 
 struct bpf_arena {
-- 
2.43.5



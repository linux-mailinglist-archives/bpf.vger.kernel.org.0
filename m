Return-Path: <bpf+bounces-50388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A798A26E3D
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 10:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D5E3A20D6
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 09:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A36207A14;
	Tue,  4 Feb 2025 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H061pv89"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3BC205E26
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738661124; cv=none; b=CQ5gSsNqdJORot5yajMaUD3eYaL9AahsDcltlpAdvMr7S1ZoAagJOvaqzbVw++V0Y+ekFlQonNWqbgPHGmzKiV2koxDopUMV8syYkSzsQ9U31pF+MlKI9fYi3mhqI8Zk+KhckilW3Zsl0yXeeYBRTPR75MtEbq95J4KIQ75m/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738661124; c=relaxed/simple;
	bh=gt5qra6uYURoBM49GeoCeHQQ+0Y0TccwKw2Ges9W1pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCcz4zNV64wpheo4qhfW6GK7noRUsWeSZN6/LPjbvrbMKTcZSGJj9d8vbeQ8AM4CNUCCdII4KEWuCNGOJKUxnNWxoIUY7QONPeEFfKB1XmX1SgEIVMaLklNRKlzA9BN/4oaVn30r3O3CHvQ7npMMZkcbMfH6MXcXaIFhfPDAB5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H061pv89; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5148tqEf004052;
	Tue, 4 Feb 2025 09:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=KJVfwe6Hu8RiUSQ1kcGyX4xddSvsE
	QsgSHGlJRZeK08=; b=H061pv89cN0qWA1DbNkRE+zIIfvR42Vivsp9/i2syPb9w
	Undkk6Uanfe560xo2ITzOi5l+CdiFHfreoNtHt02ynyDs3a98KcqxJDHdHaRaE+g
	ZxeUZK3xnK7TY8SViV+skxLY/qj6GFAaKuc69QNA4AQHOqph2d4n2lYWKDqGj/ky
	yD0137uul62QdilhH3OY6pjpl5KgBem+tshCcrKjaMkux8xBDmFhUTibCuuzxb2K
	aj3CRryVx2w54mw7QwXgBMPA3+Fs8LOjiYVAp3/LjGsSlZJw2lFI7dKGsqO2WBje
	wMK1Cjn7NrlndJ3TG9QKFCAou3i9FtEuvJ1pkRdPw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfcgvgnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 09:25:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5148kvAb004707;
	Tue, 4 Feb 2025 09:24:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fnrgpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 09:24:58 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5149MlAH005579;
	Tue, 4 Feb 2025 09:24:58 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-201-234.vpn.oracle.com [10.175.201.234])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44j8fnrgnx-1;
	Tue, 04 Feb 2025 09:24:58 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Colm Harrington <colm.harrington@oracle.com>
Subject: [PATCH bpf] bpf/arena: fix softlockup in arena_map_free on 64k page kernel
Date: Tue,  4 Feb 2025 09:24:55 +0000
Message-ID: <20250204092455.3693003-1-alan.maguire@oracle.com>
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
 definitions=2025-02-04_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040075
X-Proofpoint-GUID: oyTJeb4mh1J9ix5T6gCwr9zkA0Plrlkn
X-Proofpoint-ORIG-GUID: oyTJeb4mh1J9ix5T6gCwr9zkA0Plrlkn

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

One solution is to round up the address returned by bpf_arena_get_kern_vm_start()
to a page-aligned value.  With that change in place the test passes:

$ sudo ./test_progs -t arena_htab
Summary: 1/1 PASSED, 1 SKIPPED, 0 FAILED

Reported-by: Colm Harrington <colm.harrington@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/arena.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 870aeb51d70a..07395c55833e 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -54,7 +54,7 @@ struct bpf_arena {
 
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
 {
-	return arena ? (u64) (long) arena->kern_vm->addr + GUARD_SZ / 2 : 0;
+	return arena ? (u64) round_up((long) arena->kern_vm->addr + GUARD_SZ / 2, PAGE_SIZE) : 0;
 }
 
 u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
-- 
2.43.5



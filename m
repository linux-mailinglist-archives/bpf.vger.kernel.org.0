Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E4E113917
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2019 02:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfLEBGK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Dec 2019 20:06:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45538 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728100AbfLEBGK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Dec 2019 20:06:10 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB513HvQ030467
        for <bpf@vger.kernel.org>; Wed, 4 Dec 2019 17:06:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=fRfwfnh6byYFbjITUiN/P/obs2lAOZd31RuEOZI3xWg=;
 b=byKdjDp0j0gnktRdSN2Xdtkb/u7sEf1YQFKz0zw1DX+FHowVSrVlohVL30Ot5HEBSX4h
 iZ1yDOIH0KocVVSWhJra6vYbsZxkX2Xk1NTW61KMrdh8S8V8WOHWOfxqG+bekkp3RD6C
 UBHj8dbV/w8YiSy3P/2p/RDgn+Q5mnMZK/M= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wp7rnvvf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2019 17:06:09 -0800
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 4 Dec 2019 17:06:08 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 753643702A5C; Wed,  4 Dec 2019 17:06:06 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 0/2] fix a verifier bug in check_attach_btf_id()
Date:   Wed, 4 Dec 2019 17:06:06 -0800
Message-ID: <20191205010606.177712-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_04:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxlogscore=318
 phishscore=0 suspectscore=13 priorityscore=1501 mlxscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912050001
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 5b92a28aae4d ("bpf: Support attaching tracing BPF program to
other BPF programs") added support to attach tracing bpf program to
other bpf programs. It had a bug when trying to get the address
of the jited image if the main program does not have any callees,
resulting in the following kernel segfault:
      ......
      [79162.619208] BUG: kernel NULL pointer dereference, address:
      0000000000000000
      ......
      [79162.634255] Call Trace:
      [79162.634974]  ? _cond_resched+0x15/0x30
      [79162.635686]  ? kmem_cache_alloc_trace+0x162/0x220
      [79162.636398]  ? selinux_bpf_prog_alloc+0x1f/0x60
      [79162.637111]  bpf_prog_load+0x3de/0x690
      [79162.637809]  __do_sys_bpf+0x105/0x1740
      [79162.638488]  do_syscall_64+0x5b/0x180
      [79162.639147]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Patch #1 fixed the problem with more explanation in the commit message.
Patch #2 added a selftest which will fail without this patch.

Yonghong Song (2):
  bpf: fix a bug to get subprog 0 jited image in check_attach_btf_id
  selftests/bpf: add a fexit/bpf2bpf test with target bpf prog no
    callees

 kernel/bpf/verifier.c                         |  5 +-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 70 ++++++++++++++-----
 .../bpf/progs/fexit_bpf2bpf_simple.c          | 26 +++++++
 .../selftests/bpf/progs/test_pkt_md_access.c  |  4 +-
 4 files changed, 85 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_bpf2bpf_simple.c

-- 
2.17.1


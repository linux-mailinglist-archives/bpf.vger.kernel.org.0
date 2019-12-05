Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C636113919
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2019 02:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfLEBGM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Dec 2019 20:06:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10776 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728100AbfLEBGL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Dec 2019 20:06:11 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xB514gue013977
        for <bpf@vger.kernel.org>; Wed, 4 Dec 2019 17:06:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=MbpOV849vcokxxNcfZHxJAmWCJ+pZ0ZbT1rH43r8VW0=;
 b=SBiWpqgGZs0KeUlXD63MnLIKGMhZcHWz+XcQsfCg2wWHLymOs7sCS4N1OxVqOBpNKPV3
 q/+h0buuz20iS28KgaT8/d2VO2RvAD+m3QqmPOISKYjmDF9Ix8Nr+TPlFML+fl1WK/ya
 MSYW2rff2JaA00Wk3y/d2X/Hd2n/nXiKkco= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2wp7q4msrv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2019 17:06:10 -0800
Received: from intmgw005.05.ash5.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 4 Dec 2019 17:06:08 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id A40003702AB2; Wed,  4 Dec 2019 17:06:06 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 1/2] bpf: fix a bug when getting subprog 0 jited image in check_attach_btf_id
Date:   Wed, 4 Dec 2019 17:06:06 -0800
Message-ID: <20191205010606.177774-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205010606.177712-1-yhs@fb.com>
References: <20191205010606.177712-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_04:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=13
 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=335
 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050001
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For jited bpf program, if the subprogram count is 1, i.e.,
there is no callees in the program, prog->aux->func will be NULL
and prog->bpf_func points to image address of the program.

If there is more than one subprogram, prog->aux->func is populated,
and subprogram 0 can be accessed through either prog->bpf_func or
prog->aux->func[0]. Other subprograms should be accessed through
prog->aux->func[subprog_id].

This patch fixed a bug in check_attach_btf_id(), where
prog->aux->func[subprog_id] is used to access any subprogram which
caused a segfault like below:
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
  ......

Fixes: 5b92a28aae4d ("bpf: Support attaching tracing BPF program to other BPF programs")
Reported-by: Eelco Chaudron <echaudro@redhat.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a0482e1c4a77..034ef81f935b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9636,7 +9636,10 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 				ret = -EINVAL;
 				goto out;
 			}
-			addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
+			if (subprog == 0)
+				addr = (long) tgt_prog->bpf_func;
+			else
+				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
 		} else {
 			addr = kallsyms_lookup_name(tname);
 			if (!addr) {
-- 
2.17.1


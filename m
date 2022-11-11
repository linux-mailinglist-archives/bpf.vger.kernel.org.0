Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A28625FF0
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 17:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiKKQ6Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 11:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiKKQ6Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 11:58:24 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3722B0
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 08:58:23 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABDIfge016375
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 08:58:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=gn/mpXdzqFUbDxT/p4jEJDcMoK7eHpCVUCOI+zk5JbM=;
 b=JiusaLD5nGG8Ij8cdr3M84O4LZ/OS+BfHH8luUjvQ25iIEISKUxYGvAyoQW0lZyQrfvM
 gWGpVxUHrUh5PWS4RIzXyEKzmd6NSlBZp9ywuRXCpD5mLIyg9zUwUxO0LMyAkvzTul7D
 rim2glXRBnhjH+iFLS69UznVfiwU9yML3FQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ks8pn6kgj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 08:58:22 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 08:58:21 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 6C51611FF3FFB; Fri, 11 Nov 2022 08:58:11 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 7/7] selftests/bpf: Add rcu_read_lock test to s390x/aarch64 deny lists
Date:   Fri, 11 Nov 2022 08:58:11 -0800
Message-ID: <20221111165811.2530740-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111165734.2524596-1-yhs@fb.com>
References: <20221111165734.2524596-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ZFpSamt3ShwKqAGCUAYDnPLxktzy6c2O
X-Proofpoint-ORIG-GUID: ZFpSamt3ShwKqAGCUAYDnPLxktzy6c2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_08,2022-11-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The new rcu_read_lock test failed on s390x with the following error messa=
ge:

  ...
  test_rcu_read_lock:PASS:join_cgroup /rcu_read_lock 0 nsec
  test_local_storage:PASS:skel_open 0 nsec
  libbpf: prog 'cgrp_succ': failed to find kernel BTF type ID of '__s390x=
_sys_getpgid': -3
  libbpf: prog 'cgrp_succ': failed to prepare load attributes: -3
  libbpf: prog 'cgrp_succ': failed to load: -3
  libbpf: failed to load object 'rcu_read_lock'
  libbpf: failed to load BPF skeleton 'rcu_read_lock': -3
  test_local_storage:FAIL:skel_load unexpected error: -3 (errno 3)
  ...

It failed on aarch64 with the following error message due to inadequate
trampoline support.

  ...
  test_rcu_read_lock:PASS:join_cgroup /rcu_read_lock 0 nsec
  test_local_storage:PASS:skel_open 0 nsec
  test_local_storage:PASS:skel_load 0 nsec
  libbpf: prog 'cgrp_succ': failed to attach: ERROR: strerror_r(-524)=3D2=
2
  libbpf: prog 'cgrp_succ': failed to auto-attach: -524
  test_local_storage:FAIL:skel_attach unexpected error: -524 (errno 524)
  ...

So add the test to s390x and aarch64 deny lists.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64 | 1 +
 tools/testing/selftests/bpf/DENYLIST.s390x   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing=
/selftests/bpf/DENYLIST.aarch64
index 09416d5d2e33..2ff8a40ed9dd 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -44,6 +44,7 @@ modify_return                                    # modi=
fy_return__attach failed
 module_attach                                    # skel_attach skeleton =
attach failed: -524
 mptcp/base                                       # run_test mptcp unexpe=
cted error: -524 (errno 524)
 netcnt                                           # packets unexpected pa=
ckets: actual 10001 !=3D expected 10000
+rcu_read_lock                                    # failed to attach: ERR=
OR: strerror_r(-524)=3D22
 recursion                                        # skel_attach unexpecte=
d error: -524 (errno 524)
 ringbuf                                          # skel_attach skeleton =
attachment failed: -1
 setget_sockopt                                   # attach_cgroup unexpec=
ted error: -524
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/s=
elftests/bpf/DENYLIST.s390x
index be4e3d47ea3e..dd5db40b5a09 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -41,6 +41,7 @@ module_attach                            # skel_attach =
skeleton attach failed: -
 mptcp
 netcnt                                   # failed to load BPF skeleton '=
netcnt_prog': -7                               (?)
 probe_user                               # check_kprobe_res wrong kprobe=
 res from probe read                           (?)
+rcu_read_lock                            # failed to find kernel BTF typ=
e ID of '__x64_sys_getpgid': -3                (?)
 recursion                                # skel_attach unexpected error:=
 -524                                          (trampoline)
 ringbuf                                  # skel_load skeleton load faile=
d                                              (?)
 select_reuseport                         # intermittently fails on new s=
390x setup
--=20
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D8B620A84
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiKHHmD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiKHHlj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:41:39 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBEFE51
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:41:37 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A86i4Wm014417
        for <bpf@vger.kernel.org>; Mon, 7 Nov 2022 23:41:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=F2A6plehrPUA6Hy5MqYis1yg9Ub+V3rmUI5gFYvjk+w=;
 b=nh7pooYyLvJMtHZIOuxPJ4MZxqijaTD6vcUVJlR5QTCezoPuo7f5qHee4chyMqsiuClA
 o+/XNsys+8p4BJHOkWOQlJdiuhD37amYD4vtKQOa5GT2ZbHkohO0PSboS3oBIlVhztLx
 Op4zOm+aV7GAnhCttu5+17F+2nODKLNuHy4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kqj3nga71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:41:36 -0800
Received: from twshared14438.02.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 23:41:35 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id D0D1F11D235CA; Mon,  7 Nov 2022 23:41:30 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 8/8] selftests/bpf: Add rcu_read_lock test to s390x deny list
Date:   Mon, 7 Nov 2022 23:41:30 -0800
Message-ID: <20221108074130.268541-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108074047.261848-1-yhs@fb.com>
References: <20221108074047.261848-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lFNenRUpj4jIee3p8yiZo3vm9lgkgjVi
X-Proofpoint-GUID: lFNenRUpj4jIee3p8yiZo3vm9lgkgjVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The new rcu_read_lock test will fail on s390x with the following error me=
ssage:

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

So add it to the s390x deny list.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x | 1 +
 1 file changed, 1 insertion(+)

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


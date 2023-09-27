Return-Path: <bpf+bounces-10919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 824097AFA28
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 07:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0A9F8281663
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 05:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1C314299;
	Wed, 27 Sep 2023 05:36:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115D61118
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 05:36:18 +0000 (UTC)
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1800126
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 22:36:17 -0700 (PDT)
Received: from pps.filterd (m0272704.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QLqMRw021154;
	Wed, 27 Sep 2023 04:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=campusrelays; bh=9DhFSmAQUNxDvi7BOtyqfKVpSssrdf9TI1GjvMVY/k0=;
 b=ioyXOkY+JAmmFB+MPt30KI/ztpNMw6ytc2GC71/0+fboz9ZLpPH0bwBMK5HfReDHp3ow
 NGtt9WP9sd68KIgaRQ/CDC5Ds+Ul4jRCh5axZXr/2z/XSiQDY2AgccKgIJV518Jwuzhc
 pkFOtZ1bRxgt8nRDbgBMbchKKb44bYNfcaHDGOoQiY2z1K3HxIEsgm1hi5l9C5bA5FUQ
 eF+nWnD+yQ9z9A3Ba/FToIZL0/J/DBgfpT5Ra/oEfzsOJsYRb5PZz3HSgXKzQeXQAQbP
 +kb515e6pO5bfk1bPtLGp8lB5lM3LNpfn6nB+09NH7wCeNwkgiFggwOYFSm+NCQj+tFi ww== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3tbf41veab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Sep 2023 04:50:34 +0000
Received: from m0272704.ppops.net (m0272704.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38R4oYT2016491;
	Wed, 27 Sep 2023 04:50:34 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 3tbf41vea5-1;
	Wed, 27 Sep 2023 04:50:34 +0000
From: ruowenq2@illinois.edu
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        jinghao7@illinois.edu, keescook@chromium.org,
        Ruowen Qin <ruowenq2@illinois.edu>
Subject: [PATCH bpf-next v3 0/1] samples/bpf: syscall_tp_user: Refactor and fix array index out-of-bounds bug
Date: Tue, 26 Sep 2023 23:50:29 -0500
Message-ID: <20230927045030.224548-1-ruowenq2@illinois.edu>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6t09lGJ-V7UXppUM_VTouwF_4ZdgTtT6
X-Proofpoint-ORIG-GUID: Mn0ea7Ty45aaQ7TelZCeB5CN4Pjn0yI-
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 mlxlogscore=411 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1011
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309270038
X-Spam-Score: 0
X-Spam-OrigSender: ruowenq2@illinois.edu
X-Spam-Bar: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ruowen Qin <ruowenq2@illinois.edu>

Thanks to Alexei, patch 2/3 and 3/3 from v2 have been upstreamed. v3
primarily addresses scenarios where the compiler lacks ubsan support.

There are currently 6 BPF programs in syscall_tp_kern but the array to
hold the corresponding bpf_links in syscall_tp_user only has space for 4
programs, given the array size is hardcoded. This causes the sample
program to fail due to an out-of-bound access that corrupts other stack
variables:

  # ./syscall_tp
  prog #0: map ids 4 5
  verify map:4 val: 5
  map_lookup failed: Bad file descriptor

This patch series aims to solve this issue for now and for the future.
It first adds the -fsanitize=bounds flag to make similar bugs more
obvious at runtime. It then refactors syscall_tp_user to retrieve the
number of programs from the bpf_object and dynamically allocate the
array of bpf_links to avoid inconsistencies from hardcoding.

Changelog:
---
v2 -> v3
v2: https://lore.kernel.org/all/20230917214220.637721-1-jinghao7@illinois.edu/

* Address feddback from Alexei
  * Make the makefile smarter to detect the presence of ubsan in the compiler.

v1 -> v2
v1: https://lore.kernel.org/all/20230818164643.97782-1-jinghao@linux.ibm.com/

* Address feedback from Daniel
  * Add missing NULL check for calloc return value.
  * Remove the extra operation that sets links pointer to NULL after free.

Ruowen Qin (1):
  samples/bpf: Add -fsanitize=bounds to userspace programs

 samples/bpf/Makefile | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.42.0



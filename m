Return-Path: <bpf+bounces-10237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4B17A3DFE
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 23:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1042812E0
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 21:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF86F4F2;
	Sun, 17 Sep 2023 21:43:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D86FC1
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 21:43:03 +0000 (UTC)
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE98A8
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 14:43:01 -0700 (PDT)
Received: from pps.filterd (m0166258.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38HIsOVs027226;
	Sun, 17 Sep 2023 21:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=campusrelays; bh=1IWqKjwfRa/weaMxYa2JVoWLAtlNBuIv1dk7P+2fp9U=;
 b=c4Pe76zAIhrcTYhQ5yFJ43aO7/En7m/9Ie1eEaCsMvFGIH6+vAeNoLzRIVEmh5LQkE+Y
 OYpZufZr3t4/9QnSxVPFwaPULCwBE7iOMbRUKdaAmsV6wzV6g7LE9hsmOD2o/FWnzYUf
 gOPVNayDuWda9xCti+GAGXjww50rrPDyJkHug9/9Vi/DJqdcCaWFr0CqoBVHH1hu9UnN
 WC1eQeWrL1R00nvtEKQr/avO8apuwdb44ApRP+AcYxlBVOHu5k9ORSoXAsDYxeHZQv7S
 XK3I9vnfXXMzOQBXzO2W6HbwHsHZoFzejl56coy962YfwbjKOrYhxCA8gLlyDidEzVSZ 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3t52qqrd27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Sep 2023 21:42:39 +0000
Received: from m0166258.ppops.net (m0166258.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38HLgcss002067;
	Sun, 17 Sep 2023 21:42:39 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 3t52qqrd22-1;
	Sun, 17 Sep 2023 21:42:38 +0000
From: Jinghao Jia <jinghao7@illinois.edu>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        jinghao@linux.ibm.com, Jinghao Jia <jinghao7@illinois.edu>
Subject: [PATCH bpf v2 0/3] samples/bpf: syscall_tp_user: Refactor and fix array index out-of-bounds bug
Date: Sun, 17 Sep 2023 16:42:17 -0500
Message-ID: <20230917214220.637721-1-jinghao7@illinois.edu>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: THMoYxNovzmttg0QWhQg33j1IfKppLOs
X-Proofpoint-GUID: uUHfDFo837SMI7UQqi9-D0jNWNNrj85-
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1011 impostorscore=0 phishscore=0
 mlxlogscore=386 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309170201
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
v1 -> v2
v1: https://lore.kernel.org/all/20230818164643.97782-1-jinghao@linux.ibm.com/

* Address feedback from Daniel
  * Add missing NULL check for calloc return value.
  * Remove the extra operation that sets links pointer to NULL after free.

Jinghao Jia (3):
  samples/bpf: Add -fsanitize=bounds to userspace programs
  samples/bpf: syscall_tp_user: Rename num_progs into nr_tests
  samples/bpf: syscall_tp_user: Fix array out-of-bound access

 samples/bpf/Makefile          |  1 +
 samples/bpf/syscall_tp_user.c | 45 ++++++++++++++++++++++++-----------
 2 files changed, 32 insertions(+), 14 deletions(-)

--
2.42.0



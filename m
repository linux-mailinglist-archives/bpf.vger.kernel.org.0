Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50BBF3BB49
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2019 19:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbfFJRrd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jun 2019 13:47:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59080 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387643AbfFJRrc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 10 Jun 2019 13:47:32 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5AHdc1P010110
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 10:47:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=UTxkqcRX6jSWq0gj7yLGtoNF37Wi8kZLdZlUEegLVJo=;
 b=SrJP6uYUN4bOmSbu8I3r8TnjXgFZqlY0zcsMJbvD0YSblGp+icvsQUvTrtR4+HPcllwP
 CLHKNBNoEijnBV4+3SnimLO6n4yJ3q83JsosX6sb1CtC3Mt8dL7/V1A0FmHe1Cfw8K86
 khvvLUdBNOAD+y6+Rr7NWRO5BjSMbMFHMfA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2t08pc6jmv-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 10:47:31 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 10 Jun 2019 10:46:58 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id E3BDD8617E5; Mon, 10 Jun 2019 10:46:56 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <kernel-team@fb.com>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] selftests/bpf: fix constness of source arg for bpf helpers
Date:   Mon, 10 Jun 2019 10:46:55 -0700
Message-ID: <20190610174655.2207879-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=709 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906100119
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix signature of bpf_probe_read and bpf_probe_write_user to mark source
pointer as const. This causes warnings during compilation for
applications relying on those helpers.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/bpf_helpers.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index e6d243b7cd74..1a5b1accf091 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -31,7 +31,7 @@ static int (*bpf_map_pop_elem)(void *map, void *value) =
 	(void *) BPF_FUNC_map_pop_elem;
 static int (*bpf_map_peek_elem)(void *map, void *value) =
 	(void *) BPF_FUNC_map_peek_elem;
-static int (*bpf_probe_read)(void *dst, int size, void *unsafe_ptr) =
+static int (*bpf_probe_read)(void *dst, int size, const void *unsafe_ptr) =
 	(void *) BPF_FUNC_probe_read;
 static unsigned long long (*bpf_ktime_get_ns)(void) =
 	(void *) BPF_FUNC_ktime_get_ns;
@@ -62,7 +62,7 @@ static int (*bpf_perf_event_output)(void *ctx, void *map,
 	(void *) BPF_FUNC_perf_event_output;
 static int (*bpf_get_stackid)(void *ctx, void *map, int flags) =
 	(void *) BPF_FUNC_get_stackid;
-static int (*bpf_probe_write_user)(void *dst, void *src, int size) =
+static int (*bpf_probe_write_user)(void *dst, const void *src, int size) =
 	(void *) BPF_FUNC_probe_write_user;
 static int (*bpf_current_task_under_cgroup)(void *map, int index) =
 	(void *) BPF_FUNC_current_task_under_cgroup;
-- 
2.17.1


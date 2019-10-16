Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD01D867A
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2019 05:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbfJPDaM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Oct 2019 23:30:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45796 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389282AbfJPDaM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Oct 2019 23:30:12 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G3TcQm005022
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2019 20:30:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=IH7b2i8Fk+8JFs48Kb/ipE7wiNAEK/byslsVGwvUQSk=;
 b=qYw2WlqbYrvulPbP3GBWMxDNo6lxa4BMAELF1NDkIX81ITGjxgKkNyXuMlFXPccCbltw
 u0x/Hzeyvn71CVJxUYtluhN0TGKe3mzPdJysQGtxCHAzT0Ar18NDZ2aRCeo7ljm2Ugkc
 Sm+O/Zo+jmZxRXIdNfGLitRv1jcDrzK7lV4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vmtajgjn3-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2019 20:30:10 -0700
Received: from 2401:db00:12:909f:face:0:3:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 15 Oct 2019 20:30:07 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 4D68D861998; Tue, 15 Oct 2019 20:30:04 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 6/6] selftests/bpf: move test_queue_stack_map.h into progs/ where it belongs
Date:   Tue, 15 Oct 2019 20:29:49 -0700
Message-ID: <20191016032949.1445888-7-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016032949.1445888-1-andriin@fb.com>
References: <20191016032949.1445888-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_01:2019-10-15,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 mlxlogscore=889 suspectscore=8 bulkscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910160030
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_queue_stack_map.h is used only from BPF programs. Thus it should be
part of progs/ subdir. An added benefit of moving it there is that new
TEST_RUNNER_DEFINE_RULES macro-rule will properly capture dependency on
this header for all BPF objects and trigger re-build, if it changes.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/Makefile                           | 3 ---
 tools/testing/selftests/bpf/{ => progs}/test_queue_stack_map.h | 0
 2 files changed, 3 deletions(-)
 rename tools/testing/selftests/bpf/{ => progs}/test_queue_stack_map.h (100%)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2c5349c651ef..ab7b51a38ec0 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -153,9 +153,6 @@ CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
 $(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline
 $(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS += -fno-inline
 
-$(OUTPUT)/test_queue_map.o: test_queue_stack_map.h
-$(OUTPUT)/test_stack_map.o: test_queue_stack_map.h
-
 $(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
 
 # Build BPF object using Clang
diff --git a/tools/testing/selftests/bpf/test_queue_stack_map.h b/tools/testing/selftests/bpf/progs/test_queue_stack_map.h
similarity index 100%
rename from tools/testing/selftests/bpf/test_queue_stack_map.h
rename to tools/testing/selftests/bpf/progs/test_queue_stack_map.h
-- 
2.17.1


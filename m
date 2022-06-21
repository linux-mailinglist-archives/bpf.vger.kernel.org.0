Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90759552B68
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 09:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346401AbiFUHBl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 03:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346388AbiFUHBl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 03:01:41 -0400
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430F01EAD8
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 00:01:39 -0700 (PDT)
Received: from SPMA-04.tubit.win.tu-berlin.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 3A295974829_2B16CD1B;
        Tue, 21 Jun 2022 07:01:37 +0000 (GMT)
Received: from mail.tu-berlin.de (mail.tu-berlin.de [141.23.12.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "exchange.tu-berlin.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by SPMA-04.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id CCB2596FB20_2B16CD0F;
        Tue, 21 Jun 2022 07:01:36 +0000 (GMT)
Received: from jt.fritz.box (89.12.46.118) by ex-05.svc.tu-berlin.de
 (10.150.18.9) with Microsoft SMTP Server id 15.2.986.22; Tue, 21 Jun 2022
 09:01:35 +0200
From:   =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        =?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>
Subject: [PATCH bpf-next] selftests/bpf: Fix rare segfault in sock_fields prog test
Date:   Tue, 21 Jun 2022 09:01:16 +0200
Message-ID: <20220621070116.307221-1-jthinz@mailbox.tu-berlin.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=campus.tu-berlin.de; h=from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding; s=dkim-tub; bh=dVbbLyYghPA/YfYwgDI+fWvUDlZTth8U5vXGVOpBL6E=; b=EgFaPVsaO7/03oXrkcYnvZRbUJErNkJjUjFtC9+g/Pv6FZfU972fjrzQV3A3Y9qY3eS3R9mTXT7xTJO2vHbXm5wR93YtYIxl3/zeQ3hDahKSGJe6kf242CLhbEUDP5xUN7hnsl5AYOyLo7hP5wGeHVPFbKRZjhuO4eoOUChwFS8=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_sock_fields__detach() got called with a null pointer here when one
of the CHECKs or ASSERTs up to the test_sock_fields__open_and_load()
call resulted in a jump to the "done" label.

A skeletons *__detach() is not safe to call with a null pointer, though.
This led to a segfault.

Go the easy route and only call test_sock_fields__destroy() which is
null-pointer safe and includes detaching.

Came across this while looking[1] to introduce the usage of
bpf_tcp_helpers.h (included in progs/test_sock_fields.c) together with
vmlinux.h.

[1] https://lore.kernel.org/bpf/629bc069dd807d7ac646f836e9dca28bbc1108e2.camel@mailbox.tu-berlin.de/

Fixes: 8f50f16ff39d ("selftests/bpf: Extend verifier and bpf_sock tests for dst_port loads")
Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
---
 tools/testing/selftests/bpf/prog_tests/sock_fields.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_fields.c b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
index 9d211b5c22c4..7d23166c77af 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
@@ -394,7 +394,6 @@ void serial_test_sock_fields(void)
 	test();
 
 done:
-	test_sock_fields__detach(skel);
 	test_sock_fields__destroy(skel);
 	if (child_cg_fd >= 0)
 		close(child_cg_fd);
-- 
2.30.2


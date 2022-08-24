Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD53459FFA0
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 18:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiHXQjN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 12:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiHXQjM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 12:39:12 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31579C506
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 09:39:11 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 04779240029
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 18:39:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1661359150; bh=P1RsBqCRRezVNBirWXboUlNd84CQGYFCPshH/9/Tfr0=;
        h=From:To:Subject:Date:From;
        b=U22UcYJVdUvnrF6XencXqqN9wTesFZo4E+4UmtJ14zzeH2xrvjRU2S42mw9oQFoMf
         3LMr05GYoolgu5QLgrGijq+4kojLUGdaeUymm0PRr8LG6M7p+vzPiAGZSiehLnOBxY
         E2KhlPI7qVx40DucCciHecbnqY4jvjIq0dSLYSkoV15nmt6QkieP4R41Qpf84kANG/
         bK3eJd+jpsMfevCxEFHJS5nKKANppqQQYM0Pms2VjKb6M9rZUsZ2ZVwtW8tcUCvtCi
         qqwDzvg+RPzli9mCwaoYiXxnFm8YUBbu3E19mxE8/n/emoTuqIPx9uKsL2rqN+mG4c
         B5HfAjfXjGJOQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MCWyP0WWHz9rxS;
        Wed, 24 Aug 2022 18:39:08 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: [PATCH bpf-next] selftests/bpf: Add cb_refs test to s390x deny list
Date:   Wed, 24 Aug 2022 16:39:06 +0000
Message-Id: <20220824163906.1186832-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The cb_refs BPF selftest is failing execution on s390x machines. This is
a newly added test that requires a feature not presently supported on
this architecture.
Denylist the test for this architecture.

Fixes: 3cf7e7d8685c ("selftests/bpf: Add tests for reference state fixes for callbacks")
Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/testing/selftests/bpf/DENYLIST.s390x | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index a708c3d..37bafcb 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -66,3 +66,4 @@ select_reuseport                         # intermittently fails on new s390x set
 xdp_synproxy                             # JIT does not support calling kernel function                                (kfunc)
 unpriv_bpf_disabled                      # fentry
 setget_sockopt                           # attach unexpected error: -524                                               (trampoline)
+cb_refs                                  # expected error message unexpected error: -524                               (trampoline)
-- 
2.30.2


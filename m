Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FFB57286F
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 23:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiGLVVf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 17:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiGLVVe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 17:21:34 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718B2BE0FB
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 14:21:33 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 24F6A240026
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 23:21:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1657660892; bh=xqQqHS88YPR91NCm+ghXPAvfH6r097v6TdeKSZ8kXUo=;
        h=From:To:Cc:Subject:Date:From;
        b=esQKLtmd5lvRaOa318WD2V/Dz1KBn6z9Fvr3L/4yBtSEyPGZoJPg+BWg2uY2ykodb
         3u3VVhWUSw+DkIpNNgJCJJIRfe9MfLqcQWvXGsIkfmr96x/SPHcfPXPXNjLzLI/Zpt
         GNxxnd69nVHiRO6I24qvoAsi49L5OEVRxTuhul7KnM8Huz+mAMjvzP6qD90YSQhxZ2
         ZvU4VbVFxIcmOT6upktj0YahT7J/rO2kvKji/vouzxHZz8/QNTykYcfv9AbDxBk+ZL
         B51x+XPH6F/2N4XzO3gBMAa8C6/tkJsw2djxTDqO4ZbmIW1f6X6tErgpGEQXSISiKI
         /iCR56PG9crww==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LjDG32WYtz6tm4;
        Tue, 12 Jul 2022 23:21:31 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     mykolal@fb.com
Subject: [PATCH bpf-next 2/3] selftests/bpf: Integrate vmtest configs
Date:   Tue, 12 Jul 2022 21:21:23 +0000
Message-Id: <20220712212124.3180314-3-deso@posteo.net>
In-Reply-To: <20220712212124.3180314-1-deso@posteo.net>
References: <20220712212124.3180314-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change integrates the configuration from the vmtest repository [0],
where it is currently used for testing kernel patches into the existing
configuration pulled in with an earlier patch. The result is a super set
of the configs from the two repositories.

[0]: https://github.com/kernel-patches/vmtest/tree/831ee8eb72ddb7e03babb8f7e050d52a451237aa/travis-ci/vmtest/configs

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest | 5 +++++
 .../selftests/bpf/configs/denylist/DENYLIST-latest.s390x     | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest b/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest
index 939de574..ddf8a0c5 100644
--- a/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest
+++ b/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest
@@ -4,3 +4,8 @@ stacktrace_build_id_nmi
 stacktrace_build_id
 task_fd_query_rawtp
 varlen
+btf_dump/btf_dump: syntax
+kprobe_multi_test/bench_attach
+core_reloc/enum64val
+core_reloc/size___diff_sz
+core_reloc/type_based___diff_sz
diff --git a/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest.s390x b/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest.s390x
index e33cab..36574b0 100644
--- a/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest.s390x
+++ b/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest.s390x
@@ -63,5 +63,6 @@ bpf_cookie                               # failed to open_and_load program: -524
 xdp_do_redirect                          # prog_run_max_size unexpected error: -22 (errno 22)
 send_signal                              # intermittently fails to receive signal
 select_reuseport                         # intermittently fails on new s390x setup
+tc_redirect/tc_redirect_dtime            # very flaky
 xdp_synproxy                             # JIT does not support calling kernel function                                (kfunc)
 unpriv_bpf_disabled                      # fentry
-- 
2.30.2


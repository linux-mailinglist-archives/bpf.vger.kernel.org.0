Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50809523B68
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 19:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244937AbiEKRXG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 13:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiEKRXF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 13:23:05 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601CF20F9EB
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 10:23:04 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 1C0B1240028
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 19:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652289781; bh=7MKF4PqYbIOot7FuP+SXbXr262RIWEOMW7XgQ92X4Lo=;
        h=From:To:Cc:Subject:Date:From;
        b=DmLQYvef7AJJNv4Zn6G/DE82WWQyW2Gi8dqg10zUFD83/4MO1hs7FRz4STUEkFmCY
         hOa2Jfo7WNl84BCTUXcbcfOZ8i6tnXc+deAI/E8xHLXBVrLLfr/waRs/74ctYJp3oG
         Ko+rjp5/gbKQw3r34d56kdCOtJFXEpQnc0FXnqD/wzMGrhk75jAwxYPhIcSKCF56oj
         mn1Q+GyAF3WKE9BRHF0MAq6v1acohfVbREuYCufNXGqbAqetKryBWOk8nL31Aq0Nkc
         hOg+jE8tb90FN8C+eeZnAtpKHsSDIuPtpI2SjJziLAo37t2AGKrmDYOJqcIJqyc8YA
         p/lH2bybej2DQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Kz1vS1hH7z9rxX;
        Wed, 11 May 2022 19:23:00 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
Subject: [PATCH bpf-next] Enable CONFIG_FPROBE for self tests
Date:   Wed, 11 May 2022 17:22:49 +0000
Message-Id: <20220511172249.4082510-1-deso@posteo.net>
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

Some of the BPF selftests are failing when running with a rather bare
bones configuration based on tools/testing/selftests/bpf/config.
Specifically, we see a bunch of failures due to errno 95:

  > test_attach_api:PASS:fentry_raw_skel_load 0 nsec
  > libbpf: prog 'test_kprobe_manual': failed to attach: Operation not supported
  > test_attach_api:FAIL:bpf_program__attach_kprobe_multi_opts unexpected error: -95
  > 79 /6     kprobe_multi_test/attach_api_syms:FAIL

The cause of these is that CONFIG_FPROBE is missing. With this change we
add this configuration value to the BPF selftests config.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 763db6..08c6e5a 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -53,3 +53,4 @@ CONFIG_NF_DEFRAG_IPV4=y
 CONFIG_NF_DEFRAG_IPV6=y
 CONFIG_NF_CONNTRACK=y
 CONFIG_USERFAULTFD=y
+CONFIG_FPROBE=y
-- 
2.30.2


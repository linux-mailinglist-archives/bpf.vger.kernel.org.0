Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A843558F36C
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 22:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiHJUHR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 16:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHJUHQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 16:07:16 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA4672865
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 13:07:14 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id EF813240027
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 22:07:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1660162033; bh=BOKS3+kSbDe2UcwRdsUrIsT0FjlcOAwra2IfQM6oVrY=;
        h=From:To:Subject:Date:From;
        b=HmMUfTPYL9YBtPz6ot+ud6U43gP6Hi/w4JU6hk3VJptgHCjRYLtoe0tBxMXGaW/sD
         r2UswTrtvDfrYF5USWOr7JQPFJ9pm1JAkCGSziDtRA1SiwhCgvnfwCamJe/teD1anc
         67aDkqcpxDGdffcSSGrPw3vQQog4KCVLkzJDPibXc2cLAJHyCa5v0Nuu4JefU3JKh4
         kQ/R2a5MPvH9CmK5PShYaYg0ihv0f8UMXyxkUjiwdf5sqnZpuiVn7HlKNg4R9Uh35y
         bIwatBKAjHDhjJXz/0aZlOvg4BLxGfmTjtx3dDknMWETJTuS5Jly6qBEQGSIRVHU+6
         uFI96Z+ZZc0Nw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4M31Dw1fknz9rxV;
        Wed, 10 Aug 2022 22:07:12 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: [PATCH bpf] selftests/bpf: Add lru_bug to s390x deny list
Date:   Wed, 10 Aug 2022 20:07:10 +0000
Message-Id: <20220810200710.1300299-1-deso@posteo.net>
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

The lru_bug BPF selftest is failing execution on s390x machines. The
failure is due to program attachment failing in turn, similar to a bunch
of other tests. Those other tests have already been deny-listed and with
this change we do the same for the lru_bug test, adding it to the
corresponding file.

Fixes: de7b9927105b ("selftests/bpf: Add test for prealloc_lru_pop bug")
Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/testing/selftests/bpf/DENYLIST.s390x | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index e33cab..db9810 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -65,3 +65,4 @@ send_signal                              # intermittently fails to receive signa
 select_reuseport                         # intermittently fails on new s390x setup
 xdp_synproxy                             # JIT does not support calling kernel function                                (kfunc)
 unpriv_bpf_disabled                      # fentry
+lru_bug                                  # prog 'printk': failed to auto-attach: -524
-- 
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC7669C233
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 21:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjBSUEn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Feb 2023 15:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjBSUEn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Feb 2023 15:04:43 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC25117141
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 12:04:39 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id eg19so5326772edb.0
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 12:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=snKErSjawhkPvNFVgcPh9aCQJJgyd9f3QyFQwwzyJN4=;
        b=NvNIt/3BjkBd9j6JeDYOqkk6TuOtQJP5kXChEAnEpu4IyvS3Eh0u7BkJ6JVG7jr7JI
         D6ebacJIPImnJON1zosd515nVhfC5WfEDC+jvKp3jyYSubRIGlc+8kWAffpa0sxnGkph
         6QKhulDj2+HY0yXM7Nw9EP08kaoFnNDVRO731bbcaDcouNm3OjyEs9wBCUXQRnp3vwAq
         Bwb7My3c2+PiirqG3ZXk93l5VvLftyg8jWm8u6GMVBJiznU8cJa9BTAt6/TBkPG+XiUn
         eWFj6eYdqi8jofk3glJ0/d+1OHlNNjQm41smPjOitW5yLtOot69pcZG7gz3uNXDhNRtM
         7Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snKErSjawhkPvNFVgcPh9aCQJJgyd9f3QyFQwwzyJN4=;
        b=FdOw3M4Up26KljH3IeyX0fxjYlQzQVSzqMh9RjJZ6VTT811bJJDdA5xxE0e8cP+gr3
         zEFXJwUfsZWyYrikychaiT8nQc80In0i5H3e50b9og6kJKhbPPr6VSHvvrjS71pvNDhv
         1+vaHCOkob10GuDl+oM/X0Vj1BDqpHRaekRPGaA/EXgTzCgTjMMoLvWjX5nim1IXHtaT
         Ce7SUVzuEDvCQg7rl/sAsWbAhAP/ibM+tv0m37mJ0XqBltq13KSZG/xq8BCW+fqE1oO2
         mJ19ml2anNtz79BW8bzXagt7Qpxg28csfwqf0DnyrpoWPIaDrujOKxE3MT2embxKa4/A
         Q3Zw==
X-Gm-Message-State: AO0yUKVbk0y9u+dxDHUkRWOsM4eiKPzzRm+9sR2P/85g5rX/ANwOpr/S
        Li4hApTRaBLHHi0emDOCLWbn6EtBeVjCBw==
X-Google-Smtp-Source: AK7set/j+BH1jt/YuEs1AAlVD2ou+JrdPwPZSN9ZRo71c8fRVrDIRxzEGUynM8X5BoDNaPjjn2+TXw==
X-Received: by 2002:a17:907:c202:b0:8ab:b03d:a34f with SMTP id ti2-20020a170907c20200b008abb03da34fmr4253033ejc.12.1676837078091;
        Sun, 19 Feb 2023 12:04:38 -0800 (PST)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090629cf00b008caaae1f1e1sm1124035eje.110.2023.02.19.12.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 12:04:37 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/2] bpf: Allow reads from uninit stack
Date:   Sun, 19 Feb 2023 22:04:25 +0200
Message-Id: <20230219200427.606541-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch-set modifies BPF verifier to accept programs that read from
uninitialized stack locations, but only if executed in privileged mode.
This provides significant verification performance gains: 30% to 70% less
processed states for big number of test programs.

The reason for performance gains comes from treating STACK_MISC and
STACK_INVALID as compatible, when cached state is compared to current state
in verifier.c:stacksafe().

The change should not affect safety, because any value read from STACK_MISC
location has full binary range (e.g. 0x00-0xff for byte-sized reads).

Details and measurements are provided in the description for the patch #1.

The change was suggested by Andrii Nakryiko, the initial patch was created
by Alexei Starovoitov. The discussion could be found at [1].

Changes v1 -> v2 (v1 available at [2]):
- Calls to helper functions now convert STACK_INVALID to STACK_MISC
  (suggested by Andrii);
- The test case progs/test_global_func10.c is updated to expect new
  error message. Before recent commit [3] exact content of error
  messages was not verified for this test.
- Replaced incorrect '//'-style comments in test case asm blocks by
  '/*...*/'-style comments in order to fix compilation issues;
- Changed the tag from "Suggested-By" to "Co-developed-by" for Alexei
  on patch #1, please let me know if this is appropriate use of the tag.

[1] https://lore.kernel.org/bpf/CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20230216183606.2483834-1-eddyz87@gmail.com/
[3] 95ebb376176c ("selftests/bpf: Convert test_global_funcs test to test_loader framework")

Eduard Zingerman (2):
  bpf: Allow reads from uninit stack
  selftests/bpf: Tests for uninitialized stack reads

 kernel/bpf/verifier.c                         |  11 +-
 .../selftests/bpf/prog_tests/uninit_stack.c   |   9 ++
 .../selftests/bpf/progs/test_global_func10.c  |   8 +-
 .../selftests/bpf/progs/uninit_stack.c        |  87 +++++++++++++++
 tools/testing/selftests/bpf/verifier/calls.c  |  13 ++-
 .../bpf/verifier/helper_access_var_len.c      | 104 ++++++++++++------
 .../testing/selftests/bpf/verifier/int_ptr.c  |   9 +-
 .../selftests/bpf/verifier/search_pruning.c   |  13 ++-
 tools/testing/selftests/bpf/verifier/sock.c   |  27 -----
 .../selftests/bpf/verifier/spill_fill.c       |   7 +-
 .../testing/selftests/bpf/verifier/var_off.c  |  52 ---------
 11 files changed, 204 insertions(+), 136 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uninit_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/uninit_stack.c

-- 
2.39.1


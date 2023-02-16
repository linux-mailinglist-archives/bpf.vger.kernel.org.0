Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15055699C61
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 19:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBPSg0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 13:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBPSgZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 13:36:25 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7040E34F46
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 10:36:21 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w3so6378286edc.2
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 10:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3wfBHcDg8apHfGBWi3RW8Ey3gWhN+NJJO1IL6WNnA68=;
        b=jqPEWZ5y3X/wH68PwNRlUBySCcnoA0tal+nIv1hJwM6JpZNsvEua0A9Vru0XHNg+7/
         viIrFLhz2CqcAuSvtCqnLMCLr4lMDU6r0lo6IEQRs61Zx1CyYuWC/bisxXiMucFGyjpg
         aRTgNKTSx1OTZh2pNdJDr6wQTkEq2bBwDbvIHuzulvg6aRa/UcDOoI4k2v9GqgjlqOa6
         ALCrRhTZHJO+jWhLACfBkMH2tonORcNFEclD9uv8dyCOvv5Jn6rQCIXLMjYQh+vdKZK+
         kl+y6iVpPESPbL82eitwHwXIHMzr3T2riKaVKxcKcs9YoTjJVGb/PJuz+GZp6TrJDWRU
         BnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wfBHcDg8apHfGBWi3RW8Ey3gWhN+NJJO1IL6WNnA68=;
        b=tc3WOTMoLg9BnuA2a+8k7QUq3XXCz0M2PbIRekbinunlVwc+eJCp55VvfJrKoLHO7/
         /GOftj3F12aRRcHECspUczYYQo8WuC5PM53tgzuPnX9wAY+LtACLLP2sxEZLOkR9TIH1
         A4A7ffxl33IbqDJRjbsEHr6hpdfYEkEGtv1GbbIhy0BBVl3hDAFG0RK2LQt8f+fSytRA
         o2TQGPdjao2lqgg1kcWNV4VnVj10iheEIpKPrVR6z7RjxIEoPNTPpaHXlvzbBJeoUdVT
         Q9BxRpOBC0KPLX99x5pcVHGwqyxFTZGACTIcEQf7JtCAq0ZcLtwaPOLxwXtk9G39FSUu
         RshA==
X-Gm-Message-State: AO0yUKVSiRbsT24w2poOfFkMjtckWxrWnlG0T0oDqknhI0BFavKrVw9k
        MGJlACVFO6lTaHAF3miAr9NtsimrQSg=
X-Google-Smtp-Source: AK7set81ES8/1teNJkHz/1QZlSuW3QqaigxteYrJFfMvG7foCQHYFjP6UXuqQbcp7ZhTa0gBP1k4xA==
X-Received: by 2002:aa7:d483:0:b0:4ad:5220:79f2 with SMTP id b3-20020aa7d483000000b004ad522079f2mr1867697edr.19.1676572579735;
        Thu, 16 Feb 2023 10:36:19 -0800 (PST)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v28-20020a50d09c000000b004accc54a9edsm1237854edd.93.2023.02.16.10.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:36:19 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next  0/2] Allow reads from uninit stack
Date:   Thu, 16 Feb 2023 20:36:04 +0200
Message-Id: <20230216183606.2483834-1-eddyz87@gmail.com>
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

[1] https://lore.kernel.org/bpf/CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com/

Eduard Zingerman (2):
  bpf: Allow reads from uninit stack
  selftests/bpf: Tests for uninitialized stack reads

 kernel/bpf/verifier.c                         |  10 ++
 .../selftests/bpf/prog_tests/uninit_stack.c   |   9 ++
 .../selftests/bpf/progs/test_global_func10.c  |   6 +-
 .../selftests/bpf/progs/uninit_stack.c        |  55 +++++++++
 tools/testing/selftests/bpf/verifier/calls.c  |  13 ++-
 .../bpf/verifier/helper_access_var_len.c      | 104 ++++++++++++------
 .../testing/selftests/bpf/verifier/int_ptr.c  |   9 +-
 .../selftests/bpf/verifier/search_pruning.c   |  13 ++-
 tools/testing/selftests/bpf/verifier/sock.c   |  27 -----
 .../selftests/bpf/verifier/spill_fill.c       |   7 +-
 .../testing/selftests/bpf/verifier/var_off.c  |  52 ---------
 11 files changed, 171 insertions(+), 134 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uninit_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/uninit_stack.c

-- 
2.39.1


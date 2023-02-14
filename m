Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40D76971B7
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 00:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBNXU7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 18:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjBNXU6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 18:20:58 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D69122003
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:20:57 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso239948wms.5
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yUjVtROyhJ5UlpJKVK5ldSRMnUp4kJoVEdT3QAAN4cA=;
        b=TCFaeuhbI4AyyZfnD3Wz3gBdOz2+gsOB1fQoDLK8ikn+K/S6V/O9tl40uvIji3MJSD
         rRRf460WwoC40vsQL+a5mX+T8svnNAz8UAlqjV8/1o6z+3RfjR4tJFqUppEhB3zv6LTf
         WsgXCiqFVb9cVefDviXJPxuWSHrXik5tA5+2/8MYf2029NDtyXsnWdg84oFG2NXO8AB7
         8nUJxcCYn5erZetArev6Cn4R+q8Ns0RcSqa9xsZ0yKP13E3MmLS/AH42QAPxli+JzVu3
         hhnNTJPiosHIPPMMFmKn5DQEkN3QAg2V+rIt73jYO0uRHoFB3GAHlUrctn4QAzRfLmKC
         8sBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUjVtROyhJ5UlpJKVK5ldSRMnUp4kJoVEdT3QAAN4cA=;
        b=At1KlbGpaIasxeLq2sal1iIYCK6gJX+FK48UI6JHkCY7/zVug7EpP37PYs+VX6HkzK
         izpTp59Zj7g9vRopv4Eeen8ao8+N5+Bd0wGrXowmAEEliyhk2FMdKlWebvUGTIfj1Kqr
         seA2xmvj9kaeoPKWrHqRevNjDPlq4jU4kQWqzvg3+e05O+ORgpXw7kG1J1HBCD8u7U0a
         GbL2R/TrT7XSzWaMqWefRzXl59LMat4sjp+8IQXRPG5ZOZcyvzpz9dbreUvAt42ElfPh
         I83aLVTI8STnGwj4mENYTBru9vZ85E+7hLSohDzyeok0bbDGG1tv0EXsK7R3Hcp8IM1v
         fBtw==
X-Gm-Message-State: AO0yUKXVJssyGn1Wsfr/f//I+9YGwj0A5TUgmxGerM5JqaAdnMUsThsE
        bJEBBy4CxD2MJozPhVJZ6g4hSLOlyfmWNg==
X-Google-Smtp-Source: AK7set+CGQI+m/QUhlGIBsje7+DU8uLtqsK2QslY+mSAgk5sM7Bmrzkr4BAFQ6PmlJj59aIMB5alUg==
X-Received: by 2002:a05:600c:90f:b0:3dc:573c:6601 with SMTP id m15-20020a05600c090f00b003dc573c6601mr392987wmp.36.1676416855303;
        Tue, 14 Feb 2023 15:20:55 -0800 (PST)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b003b47b80cec3sm168515wmb.42.2023.02.14.15.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:20:54 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com, jose.marchesi@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/4] Improvements for BPF_ST tracking by verifier 
Date:   Wed, 15 Feb 2023 01:20:26 +0200
Message-Id: <20230214232030.1502829-1-eddyz87@gmail.com>
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

This patch-set is a part of preparation work for -mcpu=v4 option for
BPF C compiler (discussed in [1]). Among other things -mcpu=v4 should
enable generation of BPF_ST instruction by the compiler.

- Patches #1,2 adjust verifier to track values of constants written to
  stack using BPF_ST. Currently these are tracked imprecisely, unlike
  the writes using BPF_STX, e.g.:

    fp[-8] = 42;   currently verifier assumes that fp[-8]=mmmmmmmm
                   after such instruction, where m stands for "misc",
                   just a note that something is written at fp[-8].

    r1 = 42;       verifier tracks r1=42 after this instruction.
    fp[-8] = r1;   verifier tracks fp[-8]=42 after this instruction.

  This patch makes both cases equivalent.

- Patches #3,4 adjust verifier.c:check_stack_write_fixed_off() to
  preserve STACK_ZERO marks when BPF_ST writes zero. Currently these
  are replaced by STACK_MISC, unlike zero writes using BPF_STX, e.g.:

    ... stack range [X,Y] is marked as STACK_ZERO ...
    r0 = ... variable offset pointer to stack with range [X,Y] ...
    
    fp[r0] = 0;    currently verifier marks range [X,Y] as
                   STACK_MISC for such instructions.

    r1 = 0;
    fp[r0] = r1;   verifier keeps STACK_ZERO marks for range [X,Y].

  This patch makes both cases equivalent.

Motivating example for patch #1 could be found at [3].

Previous version of the patch-set is here [2], the changes are:
- Explicit initialization of fake register parent link is removed from
  verifier.c:check_stack_write_fixed_off() as parent links are now
  correctly handled by verifier.c:save_register_state().
- Original patch #1 is split in patches #1 & #3.
- Missing test case added for patch #3
  verifier.c:check_stack_write_fixed_off() adjustment.
- Test cases are updated to use .prog_type = BPF_PROG_TYPE_SK_LOOKUP,
  which requires return value to be in the range [0,1] (original test
  cases assumed that such range is always required, which is not true).
- Original patch #3 with changes allowing BPF_ST writes to context is
  withheld for now, w/o compiler support for BPF_ST it requires some
  creative testing.
- Original patch #5 is removed from the patch-set. This patch
  contained adjustments to expected verifier error messages in some
  tests, necessary when C compiler generates BPF_ST instruction
  instead of BPF_STX (changes to expected instruction indices). These
  changes are not necessary yet.

[1] https://lore.kernel.org/bpf/01515302-c37d-2ee5-c950-2f556a4caad0@meta.com/
[2] https://lore.kernel.org/bpf/20221231163122.1360813-1-eddyz87@gmail.com/
[3] https://lore.kernel.org/bpf/f1e4282bf00aa21a72fc5906f8c3be1ae6c94a5e.camel@gmail.com/

Eduard Zingerman (4):
  bpf: track immediate values written to stack by BPF_ST instruction
  selftests/bpf: check if verifier tracks constants spilled by
    BPF_ST_MEM
  bpf: BPF_ST with variable offset should preserve STACK_ZERO marks
  selftests/bpf: check if BPF_ST with variable offset preserves
    STACK_ZERO

 kernel/bpf/verifier.c                         |  22 +++-
 .../bpf/verifier/bounds_mix_sign_unsign.c     | 110 ++++++++++--------
 .../selftests/bpf/verifier/bpf_st_mem.c       |  67 +++++++++++
 3 files changed, 150 insertions(+), 49 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/bpf_st_mem.c

-- 
2.39.1


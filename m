Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28906389C1
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 13:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiKYM33 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 07:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKYM32 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 07:29:28 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7B81DF0A;
        Fri, 25 Nov 2022 04:29:26 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id mv18so3619247pjb.0;
        Fri, 25 Nov 2022 04:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Id119FNrcIYOcK2wl9q4CLC2KosZ+id1TTQdMTAyNJM=;
        b=dA1fT78TyhtuWqwVk4Njfg5LAPAB9CG0GzGWhCPANkpxOKlwDVibchMRr3hgd20aMX
         xhY0+RKq2N9vazLgA2yWcI//p9xF+8uhAfCFk/ImKRNK3EImyTwp7FasytqQpeQ6CFsi
         LvZ5jumU8jkI/tu6BnIa0F/D7g6ZOX8iuw85EAs3rP7mi8tgulMKvrZZdPUJShtaSYvn
         ZWieMtSAmUVVRIuY9XPBr2vAWF1vgQZPKLTwrqX3xkzrrO/K1mvyN7Omqv7HgXfQQFHf
         7CYfhGF+ku1oZpe86Fk5u/2fsahgiwmHv7Za6zu7e/1h4S69arwauiAoAqfGPpS8XhlI
         7lJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Id119FNrcIYOcK2wl9q4CLC2KosZ+id1TTQdMTAyNJM=;
        b=czEHIOO9WW01X8Nog76t3l7PPAwcqPnWHKxl94PuZrkttaqrqTF6FEBp9hIvJ7urFs
         0twHnzx+r4ewIYNaXst9fHxFAJ/Gb+TBhEz8IkyhmeAZAHPUq9v4lT0gP6DRfTIO6s2M
         Av74C2RwBSHHIIsDkouq8lMk8vGVEK8gLM6xX68JPCqZNT2cu+V1+anf8Hmsm36MKWL9
         JYDeiHW9hwuFU/dJT6wmTyxgDuwfyrJP89oZ9DT4jFlWDg07WFg0ZotfOA+rDero3jaI
         LIiOP4SNTfdJ8UIKjwNMhiFZB+3gj9UFxAbX9whqn0BB3htbBL3Rjdhn2Xq8zJJfb62G
         DZcQ==
X-Gm-Message-State: ANoB5plD/Z6C73f5ebjcWXRkCXOl6EI7Cs0OpPL7EY5Rz7ytiU6Qa6P5
        LTrMMmW8bW+pLhZfa84unV5L4HBcIOka
X-Google-Smtp-Source: AA0mqf6C8fWDPypulL05gRBD+1ipTxMCjvLmII4/xdwJ02CxLGOQDAlG0Nj1fB9Fth1i85FD7RKgLg==
X-Received: by 2002:a17:902:8548:b0:188:6300:57ad with SMTP id d8-20020a170902854800b00188630057admr24619816plo.7.1669379365424;
        Fri, 25 Nov 2022 04:29:25 -0800 (PST)
Received: from localhost.localdomain ([144.214.0.6])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b0018912c37c8fsm117009pla.129.2022.11.25.04.29.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Nov 2022 04:29:24 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next v3 0/3] bpf: Add LDX/STX/ST sanitize in jited BPF progs
Date:   Fri, 25 Nov 2022 20:29:09 +0800
Message-Id: <20221125122912.54709-1-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
        URIBL_DBL_ABUSE_REDIR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The verifier sometimes makes mistakes[1][2] that may be exploited to
achieve arbitrary read/write. Currently, syzbot is continuously testing
bpf, and can find memory issues in bpf syscalls, but it can hardly find
mischecking/bugs in the verifier. We need runtime checks like KASAN in
BPF programs for this. This patch series implements address sanitize
in jited BPF progs for testing purpose, so that tools like syzbot can
find interesting bugs in the verifier automatically by, if possible,
generating and executing BPF programs that bypass the verifier but have
memory issues, then triggering this sanitizing.

The idea is to dispatch read/write addr of a BPF program to the kernel
functions that are instrumented by KASAN, to achieve indirect checking.
Indirect checking is adopted because this is much simple, instrument
direct checking like compilers makes the jit much more complex. The
main step is: back up all the scratch regs to extend BPF prog stack,
store addr to R1, and then insert the checking function before load
or store insns, during bpf_misc_fixup(). The stack size of BPF progs
is extended by 64 bytes in this mode, to backup R1~R5 to make sure
the checking funcs won't corrupt regs states. An extra Kconfig option
is used to enable this, so normal use case won't be impacted at all.

Also, not all ldx/stx/st are instrumented. Insns rewrote by other fixup
or conversion passes that use BPF_REG_AX are skipped, because that
conflicts with us; insns whose access addr is specified by R10 are also
skipped because they are trivial to verify.

Patch1 sanitizes st/stx insns, and Patch2 sanitizes ldx insns, Patch3 adds
selftests for instrumentation in each possible case, and all new/existing
selftests for the verifier can pass. Also, a BPF prog that also exploits
CVE-2022-23222 to achieve OOB read is provided[3], this can be perfertly
captured with this patch series.

[1] http://bit.do/CVE-2021-3490
[2] http://bit.do/CVE-2022-23222
[3] OOB-read: https://pastebin.com/raw/Ee1Cw492

v1 -> v2:
        remove changes to JIT completely, backup regs to extended stack.
v2 -> v3:
	fix missing-prototypes warning report by kernel test bot.
	simplify regs backing up and rewrite corresponding selftests.

Hao Sun (3):
  bpf: Sanitize STX/ST in jited BPF progs with KASAN
  bpf: Sanitize LDX in jited BPF progs with KASAN
  selftests/bpf: Add tests for LDX/STX/ST sanitize

 kernel/bpf/Kconfig                            |  13 +
 kernel/bpf/verifier.c                         | 173 ++++++++++
 .../selftests/bpf/verifier/sanitize_st_ldx.c  | 317 ++++++++++++++++++
 3 files changed, 503 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/sanitize_st_ldx.c


base-commit: 2b3e8f6f5b939ceeb2e097339bf78ebaaf11dfe9
-- 
2.38.1


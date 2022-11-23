Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF6B63614A
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 15:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiKWORI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 09:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbiKWORC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 09:17:02 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8651F2F666;
        Wed, 23 Nov 2022 06:17:01 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id y10so15571926plp.3;
        Wed, 23 Nov 2022 06:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPNZCVqx31mtDikztq211Dbc1pRPd5HGNTzUeaEK72c=;
        b=ZVfLJsgPk7f9+OMsyl4CDfSaqNupDovYHjPZt9cK2t+9yRTyjeGujKnY+1SNZLd6vd
         mfDGF5Ysq1pCHqynHh3YX+3tlllzedt/xWl+K/Gw90s+9CS0p01Letxj7s7OeCtdf7zO
         x0wHZhWdlk/7VnGN66CWmGs5cOnTRmIRaBnfhiXvgY6Ttfnr6Qh2RDBBrqYda1CSH0ST
         +R/nyEQlYKQH6KBs9UMSu5arf9NYoMvZ3vCkFgmn0PtXZMvumADk8iLJXfddjOZY7HmY
         CmxmaQc2jcgeBNt3VP1jsF38BFvIFUezQeKC5Qx1mWtKMl+yBiB19gVbblYAN0zbsmzK
         0a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPNZCVqx31mtDikztq211Dbc1pRPd5HGNTzUeaEK72c=;
        b=fbxaXf42jQS5xzmQtrF9H5hTul15uzcKr1HERXpS0dIDOM+Ao8c5GNW8uLpHEmZ6UQ
         Nqa54gcz6eARrGWgkp8cbvlzaLLTVDGuzmUqIfCmbL4nrtVqbMA1RHD806lPuh7uBb5y
         cXOUVB0HTTfBKIr370Go97WKkCt8S8+dM65Ao7s1BW+kfBDwlaaMAa34jkh0wSwDTfNM
         /vLOBOXsXeVv/jcZ5cED3j6dEqljfaE18VzgViUZBp6s1ZKlp1eHujjXp7lSakGCFXmA
         f4YfgVMzK8qugBotkNzfPElYnzvfxRQFmOjsdOjqxwDyGAAOFc/j8NpKEsGQsqcbImE2
         x0bA==
X-Gm-Message-State: ANoB5pnu9B/Ly3U+InVxaqNgU/MqArxM8emv7MN2aow4CMYCwUpEE3DI
        wN3GnGaUt0RgWBLaJd4+s8pS0R2VaDVf
X-Google-Smtp-Source: AA0mqf4IsTWBe2VHJ3OgzJnTZ+jvkuzsejO07XfkrWOxN5nonQZPLc88HslDkSGmK4xzMQq65jokYQ==
X-Received: by 2002:a17:902:e484:b0:189:3b9d:59bd with SMTP id i4-20020a170902e48400b001893b9d59bdmr5269161ple.81.1669213020727;
        Wed, 23 Nov 2022 06:17:00 -0800 (PST)
Received: from pc.localdomain ([166.111.83.15])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902e88400b001868ed86a95sm14371878plg.174.2022.11.23.06.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:17:00 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next 0/3] bpf: Add LDX/STX/ST sanitize in jited BPF progs
Date:   Wed, 23 Nov 2022 22:15:43 +0800
Message-Id: <20221123141546.238297-1-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.38.1
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
main step is: back up R0&R1 and store addr in R1, and then insert the
checking function before load/store insns, during bpf_misc_fixup(), and
finally in the jit stage, backup R1~R5 to make sure the checking funcs
won't corrupt regs states. An extra Kconfig option is used to enable
this, so normal use case won't be impacted at all.

Also, not all ldx/stx/st are instrumented. Insns rewrote by other fixup
or conversion passes that use BPF_REG_AX are skipped, because that
conflicts with us; insns whose access addr is specified by R10 are also
skipped because they are trivial to verify.

Patch1 sanitizes st/stx insns, and Patch2 sanitizes ldx insns, Patch3 adds
selftests for instrumentation in each possible case, and all new/existing
selftests for the verifier can pass. Also, a BPF prog that also exploits
CVE-2022-23222 to achieve OOB read is provided[3], this can be perfertly
captured with this patch series.

I haven't found a better way to back up the regs before executing the
checking functions, and have to store them on the stack. Comments and
advice are surely welcome.

[1] http://bit.do/CVE-2021-3490
[2] http://bit.do/CVE-2022-23222
[3] OOB-read: https://pastebin.com/raw/Ee1Cw492

Hao Sun (3):
  bpf: Sanitize STX/ST in jited BPF progs with KASAN
  bpf: Sanitize LDX in jited BPF progs with KASAN
  selftests/bpf: Add tests for LDX/STX/ST sanitize

 arch/x86/net/bpf_jit_comp.c                   |  34 ++
 include/linux/bpf.h                           |  14 +
 kernel/bpf/Kconfig                            |  14 +
 kernel/bpf/verifier.c                         | 190 +++++++++++
 .../selftests/bpf/verifier/sanitize_st_ldx.c  | 323 ++++++++++++++++++
 5 files changed, 575 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/sanitize_st_ldx.c


base-commit: 8a2162a9227dda936a21fe72014a9931a3853a7b
-- 
2.38.1


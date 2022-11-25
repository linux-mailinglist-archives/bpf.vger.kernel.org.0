Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376D3638409
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 07:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiKYGgm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 01:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKYGgl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 01:36:41 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EDA29C85;
        Thu, 24 Nov 2022 22:36:40 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id mv18so2943923pjb.0;
        Thu, 24 Nov 2022 22:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0jNoRczPr69BduEp5yCV56EU2uBRKbXXcjxnzSWVP7Q=;
        b=FGd6Iv+1qVlzIOPBXqK9vYTML2DuhBDOnaLW8ZmPiqPKugWuVSLzHqy4zsTww3F8rn
         XwksZrz6jArhqEgXrVEan/ZG6crYw5R1U3KUfmxGQrO1vFMvxyV7NbD/Fx0hjumQ+Jw1
         1xzhP/VUO/X1NMpt5/7+EzWf+mITAWjPJYFdUO9mYZFoAYOiwvI5sR4oqh+iqTyLHyYS
         5/AQVy4tmFL6BYFvjXq4WYKQKak7zbaw6G3sN/uPtF7pZds50i/0B2DkWaecQxTVucVD
         rN0wMCjAVUCTX7VwDS1U9IdQplGwZMt0CF7PNIcj3e9LyzNkmn9Gl+ncr1hgbdHi9tKb
         2iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jNoRczPr69BduEp5yCV56EU2uBRKbXXcjxnzSWVP7Q=;
        b=Yziv+S79qJ4ntXjh9rmS7PqusfybRJgveQr+mN8UI/IPZJnJze4GE1wLHa8ELZpOF2
         BgB9ERBd00eCLK3obr0uODGD0ooksaGoWp7YEofC6X3UU+RF8JBuXEFm3EF9QjiYusSj
         Na6frAMBjzcXMapj0xlKFV1PjN4Ubg4siSJkR6sP3CBdxdoUUqITok00FeqOcVf7pwr6
         yfZv56rnX0gWcL1qDfG21Wll8m4iKXquM+0xB/rck/EH+jXVFtqntp9HCrXXuh83Orms
         arGSeK0NJE+IDtBiqZI8jaE6zsqp1qRSrQmDtk1V3UcJ93Br0a+VGrWAXn3VeZbTiEF8
         SMsw==
X-Gm-Message-State: ANoB5pmzfA70B9wWS0kZLgj2vdsDI7km+IAQiu+bLRaQ5JPMXILGub+D
        hcTWv0sGH3j1L0Te1RSsJFB9i7V7vyYm
X-Google-Smtp-Source: AA0mqf5uNvpCqzfzviTdPmNGJiwk2xlFUOlg92hJuTPP3ACe+884WwinX98D2/cnXhJ7O+qpdTPktg==
X-Received: by 2002:a17:90a:df06:b0:212:d299:4758 with SMTP id gp6-20020a17090adf0600b00212d2994758mr44602169pjb.120.1669358199643;
        Thu, 24 Nov 2022 22:36:39 -0800 (PST)
Received: from pc.localdomain ([166.111.83.15])
        by smtp.gmail.com with ESMTPSA id nm18-20020a17090b19d200b001fd6066284dsm2214891pjb.6.2022.11.24.22.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 22:36:38 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next v2 0/3] bpf: Add LDX/STX/ST sanitize in jited BPF progs
Date:   Fri, 25 Nov 2022 14:36:27 +0800
Message-Id: <20221125063630.536657-1-sunhao.th@gmail.com>
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
checking function before load/store insns, during bpf_misc_fixup().
The stack size of BPF progs is extended by 64 bytes in this mode, to
backup R1~R5 to make sure the checking funcs won't corrupt regs states.
An extra Kconfig option is used to enable this, so normal use case
won't be impacted at all.

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

Hao Sun (3):
  bpf: Sanitize STX/ST in jited BPF progs with KASAN
  bpf: Sanitize LDX in jited BPF progs with KASAN
  selftests/bpf: Add tests for LDX/STX/ST sanitize

 kernel/bpf/Kconfig                            |  13 +
 kernel/bpf/verifier.c                         | 224 +++++++++++
 .../selftests/bpf/verifier/sanitize_st_ldx.c  | 362 ++++++++++++++++++
 3 files changed, 599 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/sanitize_st_ldx.c


base-commit: 2b3e8f6f5b939ceeb2e097339bf78ebaaf11dfe9
-- 
2.38.1


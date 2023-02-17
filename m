Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D26369A2FF
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 01:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjBQAmC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 19:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBQAmB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 19:42:01 -0500
Received: from out-143.mta1.migadu.com (out-143.mta1.migadu.com [95.215.58.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5037B5381A
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 16:41:58 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676594517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U4yHl9ElYv4hsxmnACxDjREG81Ji8UwANWSQPcHWxJQ=;
        b=S/nnnAZhzHQ0GThAKwpQhPSNinVMRNO5PTyywJvi9Fa+xaYfSZDd/XLuzHLZTdwfr3q9gj
        E01JiDldQY2gKQvtzKF+KjH8Q7GtVvpFlMapcSYZ5X8QMSKd7uj7LN9bNJEaWAs1jy4/86
        PB7RteXj+KZiJEu228JybXTR2ipA0AI=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     'Alexei Starovoitov ' <ast@kernel.org>,
        'Andrii Nakryiko ' <andrii@kernel.org>,
        'Daniel Borkmann ' <daniel@iogearbox.net>,
        netdev@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH bpf-next 0/4] bpf: A fix and a change to bpf_fib_lookup
Date:   Thu, 16 Feb 2023 16:41:46 -0800
Message-Id: <20230217004150.2980689-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This set fixes the bpf_fib_lookup such that it won't return
a NUD_FAILED neigh which may have invalid dmac. It also
adds a SKIP_NEIGH lookup flag to have bpf_fib_lookup skipping
the neigh lookup.

Please see individual patch for details.

Martin KaFai Lau (4):
  bpf: Disable bh in bpf_test_run for xdp and tc prog
  bpf: bpf_fib_lookup should not return neigh in NUD_FAILED state
  bpf: Add BPF_FIB_LOOKUP_SKIP_NEIGH for bpf_fib_lookup
  selftests/bpf: Add bpf_fib_lookup test

 include/uapi/linux/bpf.h                      |   1 +
 net/bpf/test_run.c                            |   2 +
 net/core/filter.c                             |  37 ++--
 tools/include/uapi/linux/bpf.h                |   1 +
 .../selftests/bpf/prog_tests/fib_lookup.c     | 187 ++++++++++++++++++
 .../testing/selftests/bpf/progs/fib_lookup.c  |  22 +++
 6 files changed, 238 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fib_lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/fib_lookup.c

-- 
2.30.2


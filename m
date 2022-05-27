Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E3453693B
	for <lists+bpf@lfdr.de>; Sat, 28 May 2022 01:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355194AbiE0Xwf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 May 2022 19:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244378AbiE0Xwc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 May 2022 19:52:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6BA66AD2
        for <bpf@vger.kernel.org>; Fri, 27 May 2022 16:52:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id br17so9019000lfb.2
        for <bpf@vger.kernel.org>; Fri, 27 May 2022 16:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qrz9UMrYVhQrCzNlRtkRnPptK2KZHSXhXvzBfmpV8MA=;
        b=fyRV49WtdFgNlc/Oo4c4DLbv//IBxsJoExii3/umZwE/SVZvjONocZ7mpsuLkf8Q56
         xOIR8g4VJWtDvrEfLq4XeheCioMU9wgFlbobm6qdXgNQKD6wJFvtKSNKXD+lUrHwfIds
         cjoA+k6iJC/7z/eO/sSECfcKicIc+FJezBnz7/WH7eJxF9LrbnycP+GxBCAMA4KZP8XN
         7W0lLqeQcYGHhpSjP+FVkuibLLk7NtG4j9BgK4MxHzIMyCKqd2+u50wNqM+hE2A0MYwT
         umLufO+k1J2AKtj0S8jXmFaMmRTcOhjeCsK6RCN++bJB3v5Qw2X0WtbiOQGaIoAf51hv
         y0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qrz9UMrYVhQrCzNlRtkRnPptK2KZHSXhXvzBfmpV8MA=;
        b=L4O+xULWy4dakl3Snrrl4zinlW1PszXJGpv89fx58hTc5KaT1/jBFFTfqqJGlf6ivH
         nLe45O/3cMUPaVE2Btqj9ZFAMfY/IFDthdOPTY0P15q8OUk9xtXQrYgO6q0yJSUYpp9y
         QIR6bWZWqJUR3iOwk4n9T5GEkfwbgwxtoDPmC02QZJO5xFLhtULc9Fp8UZ578DUcvmVH
         +jiccuqDDe5J48Bdwzfr1S2HBIOADmwjZvzYSIreN1CmNeiFDyl52KH1EJFQ47nhQuoR
         v9wXLj039GwAw1MAVgYdv3zyo2XV4nFAVvspwFuQc7IDrVBEJ9KQDuXZyZ11Tb7y5y/u
         JAUw==
X-Gm-Message-State: AOAM531+Cg+M1HMIzKZJxlsYv923cwDFY+jGVG8A/nYJK6etLP6ImzQE
        13bS2J5Yd08wTQDyNzptH1vHe3D1jcM=
X-Google-Smtp-Source: ABdhPJwFWkdQvmixnSgp4vSbANgMu+c9QCisaBr5D++dEqkxvYj5iNh8r0ILG9C6OLo+R6tYH/bQOA==
X-Received: by 2002:a05:6512:3b07:b0:478:c2b2:21a6 with SMTP id f7-20020a0565123b0700b00478c2b221a6mr3823578lfv.231.1653695548257;
        Fri, 27 May 2022 16:52:28 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id s28-20020a19771c000000b00477a287438csm1071017lfc.2.2022.05.27.16.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 16:52:27 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next 0/3] bpf_loop inlining
Date:   Sat, 28 May 2022 02:51:44 +0300
Message-Id: <cover.1653474626.git.eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Everyone,

This patch implements inlining of calls to bpf_loop helper function
when bpf_loop's callback is statically known. E.g. the rewrite does
the following transformation during BPF program processing:

  bpf_loop(10, foo, NULL, 0);

 ->

  for (int i = 0; i < 10; ++i)
    foo(i, NULL);

The transformation leads to measurable latency change for simple
loops. Measurements using `benchs/run_bench_bpf_loop.sh` inside QEMU /
KVM on i7-4710HQ CPU shows a drop in latency from 14 ns/op to 2 ns/op.

The change is split in three parts:

* Update to test_verifier.c to specify expected and unexpected
  instruction sequences. This allows to check BPF program rewrites
  applied by do_mix_fixups function.

* Update to test_verifier.c to specify BTF function infos and types
  per test case. This is necessary for tests that load sub-program
  addresses to a variable because of the checks applied by
  check_ld_imm function.

* The update to verifier.c that tracks state of the parameters for
  each bpf_loop call in a program and decides whether it could be
  replaced by a loop.

Additional details are available in the commit message for each patch.
Hope you find this useful.

Best regards,
Eduard Zingerman

Eduard Zingerman (3):
  selftests/bpf: specify expected instructions in test_verifier tests
  selftests/bpf: allow BTF specs and func infos in test_verifier tests
  bpf: Inline calls to bpf_loop when callback is known

 include/linux/bpf_verifier.h                  |  15 +
 kernel/bpf/bpf_iter.c                         |   9 +-
 kernel/bpf/verifier.c                         | 160 +++++++++-
 .../selftests/bpf/prog_tests/bpf_loop.c       |  21 ++
 tools/testing/selftests/bpf/prog_tests/btf.c  |   1 -
 tools/testing/selftests/bpf/progs/bpf_loop.c  |  38 +++
 tools/testing/selftests/bpf/test_btf.h        |   2 +
 tools/testing/selftests/bpf/test_verifier.c   | 290 +++++++++++++++++-
 .../selftests/bpf/verifier/bpf_loop_inline.c  |  49 +++
 9 files changed, 558 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/bpf_loop_inline.c

-- 
2.25.1


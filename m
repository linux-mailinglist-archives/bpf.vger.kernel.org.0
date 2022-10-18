Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8714602DAE
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 15:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiJRN7g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 09:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiJRN7d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 09:59:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAA1559F
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y1so14159176pfr.3
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=93F5nVlXJ4sXFam1alrGd8ZhVCARTQMnFYvwKWhEVRk=;
        b=G3cbhZ8rqfefBu7Y7pszr1/hFpLsgs55BXvQ564/Zcd/6ptIWaYGvp0EETP8rBij2r
         STsTH8XFTbfFY220vbSKcEMJ5vFcjRYKuEH1ZAJHktUPPnFKxehGaO8F7Vs3+omNcPAl
         IvZFeG3BmA3i6SF6cE+yxrkdgzmxgG+lN/HmFgl4OEGWYJfAk9Aixj5K49asdMO8sA1i
         Fp50LqroDD6keMamGrvKxjVJY28ITeZVC60imPcgLlgXL3F1N+BNZio+U8rRwvJKMt8h
         ajMHNlkG5wDGuDhnLZJ+ia/16vjpY/8u+gWU1syadwgqkILyTVjSNkGRUqI3WxGKING7
         EkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93F5nVlXJ4sXFam1alrGd8ZhVCARTQMnFYvwKWhEVRk=;
        b=dBUiQfs47f8tMRFI2/Bpyc7H4hYA0jQ3JfCXJs46fOn6so56L0xh+O0ASnnZFFsufD
         QxxIyoGyyGO2qZRcsIgxV5xjYvo7NQTvQUgms93OdvbK1evB81UkFSEvNjb7nDw6MfQv
         KNTUMEqpNQxQqTmYCrGYjKQGqzRsQnUJrnRbTQmY7gN7tIWGk3H7uwJBv6JI4jf+UbjY
         ojqi3xHyczzdv9LpjeskwhVVy8/ZXyDeo/835XdTbWG1P9yLqzukrmwT4rclZQnaNOZh
         gtclUEJ3zC1k55qGbm0jl41jf2wtXIZ8l8rhxD86G4D2uKE0/n7FmAsyafxRE4xSDrVq
         FUJw==
X-Gm-Message-State: ACrzQf03IH1nHbmImusB2voJaJv8U/eYjd2tJMk4wGf0oS3g2Os3Evaq
        NRvs7QGGeazlVXskX+HfBdLst5o0ToeYaQ==
X-Google-Smtp-Source: AMsMyM77jk676Dujlb5eHGKUVMCUmcWJbbUfjmDnJO4hMgAFIHTtiN00z6uhWY2xSfiGSeyLEUK0QQ==
X-Received: by 2002:a63:2a02:0:b0:42b:3b16:5759 with SMTP id q2-20020a632a02000000b0042b3b165759mr2722171pgq.564.1666101569797;
        Tue, 18 Oct 2022 06:59:29 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090a054900b0020adf65cebbsm11626896pjf.8.2022.10.18.06.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:59:29 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 00/13] Fixes for dynptr
Date:   Tue, 18 Oct 2022 19:29:07 +0530
Message-Id: <20221018135920.726360-1-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698; i=memxor@gmail.com; h=from:subject; bh=6tZRW//egpceGh91NGleIBMLrws8gxwZ2O5+vgoI3Kw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjTrEhz/KwZhQr29GXeKm9FQV4RCdah/f1PkF6kUpW G+WNVIKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY06xIQAKCRBM4MiGSL8RyoegD/ 9EwWrw5jXY3nDKf2APTOqdmurAZhVDLJLp82wpDvSkQ1u6OjoIDL1gxvO9pdBIsNRcZyyXTnXUOHnf lZavIy1Mc2NQEatqiDPftFha0s2eQz2FSF/Uioejm0KmYYckbW/28tHP+NaI79DOSv5Ij4fbouuvuh +Einsjx511cFP7wh2zfRH1pTJ/oqc4Q0FKqzJ3DTh6wLzwQmm2q54WHds3ZPBugoJVZu/h4L1jwg1N NPFJ6mshMs/K8axvOr4nKLPVlaiFgZSJiN1aEYVerVmF2HTmcfjiDLq0mA+goPu9T9ZJr8IdRAc5Q7 /EGQoPipD8aPqSXD4vIw0YzhKSaLfNBhWxx3Ew60dHuRKW+XOTowaYzR1VT9/oubjT+SH8TRa0Eqxh V3nsaUWYXDBFzuPsppYrRToa0wjkTnnRxCx+hVpPpbBw0K2Eeq/U0LobCi0hAqYk40KpOK49FrIxBU ptYksf2KiwWFNWvLQfMOSqSrl3bSd1S0oYuOqnFPc786X0AySJz7RBi67qmtHyEJ37vv1LSip2rW8m u3fyu12NKlx5mnuhS7unYvmDc3IgnGsSjUNPWSxlBYnl8X5O7kxR/SZ2ByuB9JWVV62fpOhckTbZsb vPRN5IyDGRMEUsIRalVKOQFm7EP88pAVb/rUiWNAtisB/LMqgxUZw7BnAgLw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set fixes multiple issues in the dynptr code discovered during code
review.

 - Missing dynptr stack slot liveness propagation
 - Missing checks for PTR_TO_STACK variable offset
 - Incomplete destruction of dynptr stack slots on writes
 - Modification of dynptr struct through callback argument
   with reg->type == PTR_TO_DYNPTR

These can be abused to perform arbitrary kernel memory reads/writes by
replacing dynptr contents.

The first three cases are now unreachable from unprivileged BPF since
the commit 8addbfc7b308 ("bpf: Gate dynptr API behind CAP_BPF") which
has been applied to released stable kernels v6.0.1 and v5.19.15.

The changes are fairly intrusive and non-trivial, in-depth review is
warranted, as they rework the code before making the fixes to it, but
for the better (IMO).

Please see the individual commit logs for the details.

Kumar Kartikeya Dwivedi (13):
  bpf: Refactor ARG_PTR_TO_DYNPTR checks into process_dynptr_func
  bpf: Rework process_dynptr_func
  bpf: Rename confusingly named RET_PTR_TO_ALLOC_MEM
  bpf: Rework check_func_arg_reg_off
  bpf: Fix state pruning for STACK_DYNPTR stack slots
  bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
  bpf: Fix partial dynptr stack slot reads/writes
  bpf: Use memmove for bpf_dynptr_{read,write}
  selftests/bpf: Add test for dynptr reinit in user_ringbuf callback
  selftests/bpf: Add dynptr pruning tests
  selftests/bpf: Add dynptr var_off tests
  selftests/bpf: Add dynptr partial slot overwrite tests
  selftests/bpf: Add dynptr helper tests

 include/linux/bpf.h                           |  10 +-
 include/linux/bpf_verifier.h                  |   8 +-
 include/uapi/linux/bpf.h                      |   8 +-
 kernel/bpf/btf.c                              |  22 +-
 kernel/bpf/helpers.c                          |  22 +-
 kernel/bpf/verifier.c                         | 574 ++++++++++++++----
 scripts/bpf_doc.py                            |   1 +
 tools/include/uapi/linux/bpf.h                |   8 +-
 .../testing/selftests/bpf/prog_tests/dynptr.c |   9 +-
 .../bpf/prog_tests/kfunc_dynptr_param.c       |   5 +-
 .../selftests/bpf/prog_tests/user_ringbuf.c   |  12 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |  35 ++
 .../selftests/bpf/progs/dynptr_success.c      |  20 +
 .../bpf/progs/test_kfunc_dynptr_param.c       |  12 -
 .../selftests/bpf/progs/user_ringbuf_fail.c   |  35 ++
 tools/testing/selftests/bpf/verifier/dynptr.c | 182 ++++++
 .../testing/selftests/bpf/verifier/ringbuf.c  |   2 +-
 17 files changed, 780 insertions(+), 185 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/dynptr.c

-- 
2.38.0


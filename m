Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FD25A2D7F
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 19:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343975AbiHZRaG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 13:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiHZRaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 13:30:05 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547B36C768
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 10:30:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z2so2947064edc.1
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 10:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=SBDXMLwkQPT9KYidJ/iNRRZl7Nh4ZCLPA4uu4ijHNBo=;
        b=Bo2URVR74Xp8eezXm4O+c7ulXk5HGrXJ5nJBhvHNd51tXunBwUvd/uzsOblkZkbAah
         ziM/ECWc1OR2weuzJ/SwZo/qe6RrXoO/J79Eh3jcw8GqpOVp5OvQOA750NIJ2L0kr3CE
         I6mlnj3+VmDhCA0TXshQA0p6qpBh06/ngxLMZrG4GZkBkVkhVKF4ITCLCxeMitO74mIG
         /edqU3cmLycjmH8bG/Mf/exXxi/gEH9gFIiP/+GPmBuGPSa2CzLBBEtCCA7Aue4/29dt
         F1QoNcJEM1v1cKqb/MiOuZk7essr81XFZP1FG6VTFd/TqY55QUjG9i2A+gXsnd6mKwmK
         0uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SBDXMLwkQPT9KYidJ/iNRRZl7Nh4ZCLPA4uu4ijHNBo=;
        b=iNIu/k6ktzKP5xH1OvDhU1Y0ERofOI/Eo0sOzNE89/aeI5Tbv76OOxd/76/dpfns24
         I28N/RBuCXb1cFfpmtACj6Gf0RaQWP/kq9iotq1q6GQO4M75GF5Ok5s80tWvHydGyQjc
         ojNMiPdsNH7n+Dj7Ltpo6lBdbShtcACh9gcvZtX9k9+91KrIdo1qIYSV8tliqq9kGDhO
         b9Gwowwl3FKJYxRX9vVvRgRrafy80TFSNo0vWI7u8eNYUNxs+V7tobZOnzhuZ++nXweZ
         uivCveLpDpX95FHt+voKYEw7dkdDQHB6Tqx82UGjxJApPrPrQi77y00MXQXWvPsn7U+o
         7OWw==
X-Gm-Message-State: ACgBeo2jUOecNtOKockdXnDu5L1yAvqbOwG16REhe2c0q8nLicV9LWYm
        uG44sxx18p1H3sX1vHQ8qOtolGzVmX421OL1
X-Google-Smtp-Source: AA6agR4m6Z0rOOb4+o8cnxaC8U8USZYhEeBgw0+0Vi0sZeylUmOVtogj9rVZIVY3raQoKf28ZaZWNQ==
X-Received: by 2002:a05:6402:510c:b0:43e:305c:a4d1 with SMTP id m12-20020a056402510c00b0043e305ca4d1mr7271297edd.35.1661535000623;
        Fri, 26 Aug 2022 10:30:00 -0700 (PDT)
Received: from badger.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906a40d00b0073d79d0c9c7sm1119896ejz.127.2022.08.26.10.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 10:30:00 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        john.fastabend@gmail.com
Cc:     Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/2] propagate nullness information for reg to reg comparisons
Date:   Fri, 26 Aug 2022 20:29:13 +0300
Message-Id: <20220826172915.1536914-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Changes since RFC:
 - newly added if block in `check_cond_jmp_op` is moved down to keep
   `make_ptr_not_null_reg` actions together;
 - tests rewritten to have a single `r0 = 0; exit;` block.

Original message follows:

Hi Everyone,

This patchset adds ability to propagates nullness information for
branches of register to register equality compare instructions. The
following rules are used:
 - suppose register A maybe null
 - suppose register B is not null
 - for JNE A, B, ... - A is not null in the false branch
 - for JEQ A, B, ... - A is not null in the true branch

E.g. for program like below:

  r6 = skb->sk;
  r7 = sk_fullsock(r6);
  r0 = sk_fullsock(r6);
  if (r0 == 0) return 0;    (a)
  if (r0 != r7) return 0;   (b)
  *r7->type;                (c)
  return 0;

It is safe to dereference r7 at point (c), because of (a) and (b).

The utility of this change came up while working on BPF CLang backend
issue [1]. Specifically, while debugging issue with selftest
`test_sk_lookup.c`. This test has the following structure:

    int access_ctx_sk(struct bpf_sk_lookup *ctx __CTX__)
    {
        struct bpf_sock *sk1 = NULL, *sk2 = NULL;
        ...
        sk1 = bpf_map_lookup_elem(&redir_map, &KEY_SERVER_A);
        if (!sk1)           // (a)
            goto out;
        ...
        if (ctx->sk != sk1) // (b)
            goto out;
        ...
        if (ctx->sk->family != AF_INET ||     // (c)
            ctx->sk->type != SOCK_STREAM ||
            ctx->sk->state != BPF_TCP_LISTEN)
            goto out;
            ...
    }

- at (a) `sk1` is checked to be not null;
- at (b) `ctx->sk` is verified to be equal to `sk1`;
- at (c) `ctx->sk` is accessed w/o nullness check.

Currently Global Value Numbering pass considers expressions `sk1` and
`ctx->sk` to be identical at point (c) and replaces `ctx->sk` with
`sk1` (not expressions themselves but corresponding SSA values).
Since `sk1` is known to be not null after (b) verifier allows
execution of the program.

However, such optimization is not guaranteed to happen. When it does
not happen verifier reports an error.

[1] https://reviews.llvm.org/D131633#3722231

Thanks,
Eduard

Eduard Zingerman (2):
  bpf: propagate nullness information for reg to reg comparisons
  selftests/bpf: check nullness propagation for reg to reg comparisons

 kernel/bpf/verifier.c                         |  41 ++++-
 .../bpf/verifier/jeq_infer_not_null.c         | 166 ++++++++++++++++++
 2 files changed, 205 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c

-- 
2.37.2


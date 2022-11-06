Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3D261E6AE
	for <lists+bpf@lfdr.de>; Sun,  6 Nov 2022 22:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiKFVuC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Nov 2022 16:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiKFVuB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Nov 2022 16:50:01 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D211D86
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 13:49:59 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h9so13817112wrt.0
        for <bpf@vger.kernel.org>; Sun, 06 Nov 2022 13:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/IKTC7aMJzgK7Cd7+5E3K+h4tSCZaljmZE660gxT3c=;
        b=HZKy/jy6Prp+xWAkGMMPko0KN9JNnbsCTu2wSmFr2ogr81y0uVF2twvu8wywCfBGKr
         VbpwT74OWh2IKtfqh8jTMtbRmH7J966qUvTDB4JGSs37rBa96vgKKUIWM3fZ+D/W9a3b
         2SiGreECGOP/oNHonUufJlW7xR1cKulml0mAV4kN+jjvQnuUOzhRpqhatC2d3YkNMDF8
         UtlINPyTl/pDdW1DCqhSRvkvd1OkHcVXd9EG07cAixAyEwVXaLF+7Pdnca8RU4p6Romx
         HM460CkS6GnSPfmswRlsFyRMgLTTancLH+1d3V9ttPQSYi049R9QX0ByzNttg9pKZLvH
         vAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/IKTC7aMJzgK7Cd7+5E3K+h4tSCZaljmZE660gxT3c=;
        b=5BOuqxX09Y5+O+FqYP3DE9QCsQSksub5lT7+gBMVoMJy8kuIy/mQ0rZpGZle4NpDbh
         NRXON+AIoEZ2uHwFNEzmQUMP3F/K5edMPZ7PDAo88lIymrYK2fVkhE4jKRF2qihY4iUD
         Jlf3YTuCRjD5Lel4MtMKRDASB6hYco14aaYhZkfh4PqERh5pomYNT04M5EiIg/Sf/GFc
         uXpFDRY2+HKqfSb+ESN6aeC8OplmHcW8ri/+sv6VFcReqSfW/2+Z3jvALPB6a6cr1v+Z
         Q8OSy6lmfwekLX3PD/lW8q+3dk6fcLXcYh44YQM3v2qR7X09LONwlsGTWI4SMesB2IL6
         loIQ==
X-Gm-Message-State: ACrzQf32Dayd/cHAx9B5SSeY2soMYoLsUlpQ0C3K2m64ZMshofyzQr4X
        thJCDFB3zKnPXsmt87QERz/SJ/BY8MoWJ4Mf
X-Google-Smtp-Source: AMsMyM7LXPp4mcz/bUv27Oc+C7Ao8nXbokG9PO7A20YY4dl6P50NX8wbbvrFl6H/zqTG6i5k1SgMXw==
X-Received: by 2002:adf:f9cf:0:b0:236:6a26:c055 with SMTP id w15-20020adff9cf000000b002366a26c055mr29558516wrr.195.1667771397893;
        Sun, 06 Nov 2022 13:49:57 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id v128-20020a1cac86000000b003a3170a7af9sm6345326wme.4.2022.11.06.13.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 13:49:57 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, shung-hsi.yu@suse.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/2] propagate nullness information for reg to reg comparisons
Date:   Sun,  6 Nov 2022 23:49:19 +0200
Message-Id: <20221106214921.117631-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Changelog:
v1 -> v2:
 - after investigation described in [2] as suggested by John, Daniel
   and Shung-Hsi, function `type_is_pointer` is removed, calls to this
   function are replaced by `__is_pointer_value(false, src_reg)`.
   
RFC -> v1:
 - newly added if block in `check_cond_jmp_op` is moved down to keep
   `make_ptr_not_null_reg` actions together;
 - tests rewritten to have a single `r0 = 0; exit;` block.

[1]   https://reviews.llvm.org/D131633#3722231
[2]   https://lore.kernel.org/bpf/bad8be826d088e0d180232628160bf932006de89.camel@gmail.com/
[v1]  https://lore.kernel.org/bpf/20220826172915.1536914-1-eddyz87@gmail.com/
[RFC] https://lore.kernel.org/bpf/20220822094312.175448-1-eddyz87@gmail.com/

Eduard Zingerman (2):
  bpf: propagate nullness information for reg to reg comparisons
  selftests/bpf: check nullness propagation for reg to reg comparisons

 kernel/bpf/verifier.c                         |  35 +++-
 .../bpf/verifier/jeq_infer_not_null.c         | 166 ++++++++++++++++++
 2 files changed, 199 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c

-- 
2.34.1


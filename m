Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12DC62AE9B
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 23:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbiKOWtk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 17:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiKOWtM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 17:49:12 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6511B2037D
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:49:11 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id kt23so39890188ejc.7
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s9wZepQ6z2xnxig9fx8CxJT/60cd7J9KzXeAajDZAZM=;
        b=D52TVmKJbeVXRQfEzYLfeqLd8RCG5mnRWiVZhrz+WSZpCLFghN0s/xE4XNmS+T6yiy
         9Ce2K1M3SkLYo55ADnHRupqc980yIlU5WAsyIaafl702uhz/NFGXX+pzu31uyvNNWe/2
         c1YEHF3Ceyhp2ElOIEhnD39ncDWGd7PqgG2P7LBWiYePP2ZxbyzMp+LsutqkAq7kMomQ
         5en5Riih1fh4qCSk9QPTd9ElZzk2FI0BDiB4Zu/QrHuEj/wJb7QctaejA6hBVkhTtzKx
         oG258mdpl5ri2KtZPPMi7HeubysUG9VVvb5p4LNUfAw7zXykxzA8NQrikxODvrVklQ91
         ks8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9wZepQ6z2xnxig9fx8CxJT/60cd7J9KzXeAajDZAZM=;
        b=6U5cee9xTn/YJV05+/511aX/rYFfFzyRe9n36J2s+eyr6YWIuaMNMLqN8k6/lE1rbA
         B1fSh+IKI5SjSBJ1nHCx9tMmFi/GJT276rIEgQ4sgfOPaWSnfCGtf1hiXb0Go7QcdUJS
         Ao92sm6JG67oeLIioL7v09FxBGfOh0ADmll6IvdbW99UCSVc8vBFX3yVpMlbAs7gAuPe
         lls3iHzdRdsoYwAPxUZiEwJQTtRZnLT0R9P3RBm/4VW4oQYZXqxT03e3DfQmeU//48Nn
         FVel82iXQEnbhe1+vE4TdLI3S3UeJlwFp4BoLcW1n2JKCtKvcQ6bfqykDleYLlwNc+9M
         q9Mg==
X-Gm-Message-State: ANoB5pn0PCKTUvu7x5E52Ma65OU7FhojHrqJ0+23JoLiw++Q8tmXoLqO
        k3S24miYFiVxY4lqviDBUCFw8pp20BPoo/mw
X-Google-Smtp-Source: AA0mqf44EwcX3Bsp0GlskEushdi0gV4hIIiT557xmLSYemj5xvYPv28gH5lz8RcqtnUVikZkmV4p1w==
X-Received: by 2002:a17:906:48d7:b0:78d:cdce:bc52 with SMTP id d23-20020a17090648d700b0078dcdcebc52mr15988119ejt.469.1668552549609;
        Tue, 15 Nov 2022 14:49:09 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id y22-20020a056402171600b0046776f98d0csm5461854edu.79.2022.11.15.14.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 14:49:09 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, shung-hsi.yu@suse.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 0/2] propagate nullness information for reg to reg comparisons
Date:   Wed, 16 Nov 2022 00:48:57 +0200
Message-Id: <20221115224859.2452988-1-eddyz87@gmail.com>
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
v2 -> v3:
 - verifier tests are updated with correct error message for
   unprivileged mode (pointer comparisons are forbidden in
   unprivileged mode).

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
[RFC] https://lore.kernel.org/bpf/20220822094312.175448-1-eddyz87@gmail.com/
[v1]  https://lore.kernel.org/bpf/20220826172915.1536914-1-eddyz87@gmail.com/
[v2]  https://lore.kernel.org/bpf/20221106214921.117631-1-eddyz87@gmail.com/

Eduard Zingerman (2):
  bpf: propagate nullness information for reg to reg comparisons
  selftests/bpf: check nullness propagation for reg to reg comparisons

 kernel/bpf/verifier.c                         |  35 +++-
 .../bpf/verifier/jeq_infer_not_null.c         | 174 ++++++++++++++++++
 2 files changed, 207 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c

-- 
2.34.1


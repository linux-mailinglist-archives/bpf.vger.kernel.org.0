Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A06159BD12
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 11:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiHVJoG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 05:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbiHVJoG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 05:44:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7B0E55
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 02:44:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so7438702wme.1
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 02:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Og5nWJon9I02lPhjFfQB1qc1/fZfM+Q6VR27gYhZwdo=;
        b=QAzd3mNhCH+ogQJ7MMte7k1JKCl5qA4fpW5JIflB0rDoGW8nMZyQO15nFI4cA4R4G+
         CrUTVVWNYWAfayH67JTgh0Ev+q1YPG2rKVK96wALZoGn8ve/qeoYIJHhbppWEJkBSUMz
         3Is2TtAosu7YpwAxOxDB6ivRObLt7KWLb6mQ4PMFNsY2Znw9gO7tPoFIPPAqWbM/Eovw
         Fd0pM8IIIf2AeOgZwfwDAhqdclBTiPpS3uqE9iJ/9v+2OzoJDHP/er3vNJBl4/piyY53
         AdLfWTfpJ497+OutpDsrpDbvk8KnjkY66urcT1qavcIXOByHRtRlT7EInnfY5NxKWhUx
         BasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Og5nWJon9I02lPhjFfQB1qc1/fZfM+Q6VR27gYhZwdo=;
        b=w4uMn0psJqTZxmP82nXAkh4awqRAjRBZVSojAIR0SjpE3B+ghhcOvkuGdBrNqJFVbc
         bxTDVNyAle9eJ9LZe66n7lNW/9HoW3qSQ3VYXotXZgi0/geNbEjFmBOxjhcGA6H879Cz
         7ppiuvD/EB7E7l94yoxWj7aQPUGggnLvnKrK9hUYVigpiHQOxmezrvlml/2tLee8mcSZ
         p3cjVuNvsvKCFb38lwjro+Z7g5gDOjjCJHyrGizIUnpt/6x4tIjV442pc8FQM+zSWJxB
         aVvWvSIhpdZ1x52nNsPTqX06dT4afPnJUpslWL8pDg7FE1tE+ikKzann1SfIZK2n89LT
         JULg==
X-Gm-Message-State: ACgBeo0pJ9ZnAXo26Ovzc6ckZEpDYsRqNAXyrIVWFcb+kZoIgtDLu/Sx
        EWJaz1IfODyVgunk9DnJKsi6o6fxN7WBy7Id
X-Google-Smtp-Source: AA6agR5YEiDr6MWCLMdaH7NpbmjGm6QV48fJWCg05WcuLxgYhLT+P7vr/bqXBNgsevK+8C8w2WHsYQ==
X-Received: by 2002:a05:600c:3b93:b0:3a6:c3b:37eb with SMTP id n19-20020a05600c3b9300b003a60c3b37ebmr11618167wms.185.1661161440328;
        Mon, 22 Aug 2022 02:44:00 -0700 (PDT)
Received: from badger.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c3b8300b003a54fffa809sm14841558wms.17.2022.08.22.02.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 02:43:59 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Cc:     Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next 0/2] propagate nullness information for reg to reg comparisons
Date:   Mon, 22 Aug 2022 12:43:10 +0300
Message-Id: <20220822094312.175448-1-eddyz87@gmail.com>
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

 kernel/bpf/verifier.c                         |  39 +++-
 .../bpf/verifier/jeq_infer_not_null.c         | 186 ++++++++++++++++++
 2 files changed, 224 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
-- 
2.37.1


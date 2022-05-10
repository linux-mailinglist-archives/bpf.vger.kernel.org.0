Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154E2522064
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 17:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345351AbiEJQCA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 12:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346907AbiEJQAq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 12:00:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCA0CEF
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 08:53:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ks9so27425962ejb.2
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPng3gQQU21gtXrDrIf72nGZCc3S4pS9ifNQl5/czIY=;
        b=VMZ5H2qgoHzrONqT5dOuNz4eSjo95SwRHvmMyoxug73Qs7V41Bn8QVRNKR8y7mFDTK
         o1z7PoirPgKelQGYp/qF3nmsHJG7n0AyLBXaRoIjCDzJreuQMqOG7Zje5Df0DgybbZud
         khxNfJRrCkXUIqAgXSZih9isupEiDp1nwLF3WKKNNOH0y7Yq/PxB3JLxx96fzs++kPkU
         cgsVkcljOD5kojupsqN51RYEfQffzA8+2UTNSjEmiN3OfsFp4AHf8deoUXV2RZdAZjLh
         sfBuw2z9mEOoNzP0XFc1c6gLxNCcGpekz7EXIq/g+UfClewoVrOlXZcGnM+ftZy+/3q/
         /20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPng3gQQU21gtXrDrIf72nGZCc3S4pS9ifNQl5/czIY=;
        b=Y1t2CvzwwwUvhH+I/rVLCdrQ73zI66ZsYhL1b/XoDSMR6d0zovhes0UJWwt/eadibk
         fiQo5uJFUfr5SSSJ/aAGQrTejniIij8LW4mSIB07bu2NltX0LJoDxnoRe3BiZCETWfB7
         vbm7NEeCd6AQPJTCoNHTKnKvZiNOiE1arkeAtYsxXhByio3/RW7xnrSi+UvlJvgmpnW+
         JZAbqQ0hrs/eOF0wfX+8Hfo4fvKMt8/YrJRJbrtYID7nJnPsQMau29Hk9b/7fq/c/pCB
         y+o6o82kSlgT1ikbi2YbMtbiFK4R7w9XR1vC0ImoFpTBVAn+6N7BkBBITL7OlSMqyrjU
         AQtQ==
X-Gm-Message-State: AOAM531NOpwD5vKt5U36FgxUvfFw6Q06GPfWIgzCDy+vyl94dm7bxdfo
        JgggzYQgmisA+VoUHOxBYWToKtr4QIHtfQ==
X-Google-Smtp-Source: ABdhPJyZhzvq6LliK4nVjiaAU9lrvvK9UFrWKE5j2tx5Gik9QFh66C7ZKHeaKYpDVJQEmyOq/rWM4w==
X-Received: by 2002:a17:907:9805:b0:6f4:fe0e:5547 with SMTP id ji5-20020a170907980500b006f4fe0e5547mr20242675ejc.426.1652198011275;
        Tue, 10 May 2022 08:53:31 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-011-044.094.222.pools.vodafone-ip.de. [94.222.11.44])
        by smtp.gmail.com with ESMTPSA id s30-20020a508d1e000000b0042617ba63b0sm7806088eds.58.2022.05.10.08.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:53:30 -0700 (PDT)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, songliubraving@fb.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v2 0/4] bpf: bpf link iterator
Date:   Tue, 10 May 2022 17:52:29 +0200
Message-Id: <20220510155233.9815-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.32.0
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

Bpf links seem to be one of the important structures for which no
iterator is provided. Such iterator could be useful in those cases when
generic 'task/file' is not suitable or better performance is needed.

The implementation is mostly copied from prog iterator. This time tests were
executed, although I still had to exclude test_bpf_nf (failed to find BTF info
for global/extern symbol 'bpf_skb_ct_lookup') -- since it's unrelated, I hope
it's a minor issue.

Per suggestion from the previous discussion, there is a new patch for
converting CHECK to corresponding ASSERT_* macro. Such replacement is done only
if the final result would be the same, e.g. CHECK with important-looking custom
formatting strings are still in place -- from what I understand ASSERT_*
doesn't allow to specify such format.

The third small patch fixes what looks like a copy-paste error in the condition
checking.

Dmitrii Dolgov (4):
  bpf: Add bpf_link iterator
  selftests/bpf: Fix result check for test_bpf_hash_map
  selftests/bpf: Use ASSERT_* instead of CHECK
  selftests/bpf: Add bpf link iter test

 include/linux/bpf.h                           |   1 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/link_iter.c                        | 107 +++++++
 kernel/bpf/syscall.c                          |  19 ++
 .../selftests/bpf/prog_tests/bpf_iter.c       | 261 +++++++-----------
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   7 +
 .../selftests/bpf/progs/bpf_iter_bpf_link.c   |  21 ++
 7 files changed, 261 insertions(+), 157 deletions(-)
 create mode 100644 kernel/bpf/link_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c

-- 
2.32.0


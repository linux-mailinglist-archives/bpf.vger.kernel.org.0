Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAF26E9FCE
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 01:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjDTXYd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 19:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjDTXYc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 19:24:32 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE51E49E3
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 16:24:30 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2a8b082d6feso9375641fa.2
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 16:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682033069; x=1684625069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oVEy4aCpefwDhGBvi5NFd2aViH7t98EyWuI++n0gfBE=;
        b=Uu/VIcxgBR7biY4bHZpGRACv/FvuPCCRgDSxvxVJWUrHst+LYTr4FBbVt079Ge14fd
         c3LXrHrScnlpT2t1eDGWV6+I9rPxtuZ1o8hCyzcgybYmQ5drVMGgArI8BCo+noIhTJrz
         eRYJiv9LHSHKACTM+7xvu4Va/eruyxqxI57zncQNjVncEhG6nnwAnNGcicV6zIgT9HRW
         Hlx1gUXtjUFDCquOPxiumhIBZsH4vaFW2SFKa6urFmQB+Y2qw8Pq/hq+a7h/F31Bvpod
         MUVtzoUpcaF+z9MbB5DzwemVDGvhAeohHWsrxrgFnCzlfte92ftOpbjutLyOiC2OGpM3
         GR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682033069; x=1684625069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVEy4aCpefwDhGBvi5NFd2aViH7t98EyWuI++n0gfBE=;
        b=OojmMaT2U/kwGqylh7Q/9cHDCV9sbj0A+esXaZgYDQZSQePuX4xmwXiJN6YvoS5wpY
         w4w0Fyz/YhFEGhyxfdIrKCOA0WpMu5hjgn8p4ehFv+sv2agNuW46x6q7+2F7VnIn6wCj
         r74goVPKirmr7igkddnyvudgyWBZn3dN86NHL4JfI6eOycypXBytu5G1kpqhYQViN3mP
         cD4hJBcki2WFbn+o+T5mM47jldg1LFm1K73Pf83RnLIbGGJGhD/d/HvSGyWJ43w1iaIp
         fov0FcJTRoKs1i8vuuFFD83W9V5FoeyF1E7NNa5gZPOMvQy9GzXLGzeUBmWKs2cBckgL
         4o9A==
X-Gm-Message-State: AAQBX9fhntxPZGX3xyAJz/yJbXqAmENJ7KcObwtgrHnQxxz2FSRLZ5D1
        pSCof1HTeh5jrz6+pcCHgMnOsmcU3Yk=
X-Google-Smtp-Source: AKy350ZDQsBCvfp3dAY9w5GLhrT2RbzEkUu/jhqsRjSpKB3rMkQ9tphHatmPPhnRWn+dwruI/HEfDg==
X-Received: by 2002:a2e:9f4b:0:b0:2a8:d018:c28d with SMTP id v11-20020a2e9f4b000000b002a8d018c28dmr135559ljk.2.1682033068539;
        Thu, 20 Apr 2023 16:24:28 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z2-20020ac25de2000000b004ec89c94f04sm360227lfq.155.2023.04.20.16.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 16:24:27 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/4] fix __retval() being always ignored
Date:   Fri, 21 Apr 2023 02:23:13 +0300
Message-Id: <20230420232317.2181776-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
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

Florian Westphal found a bug in test_loader.c processing of __retval tag.
Because of this bug the function test_loader.c:do_prog_test_run()
never executed and all __retval test tags were ignored. See [1].

Fix for this bug uncovers two additional bugs:
- During test_verifier tests migration to inline assembly (see [2])
  I missed the fact that some tests require maps to contain mock values;
- Some issue with a new refcounted_kptr test, which causes kernel to
  produce dead lock and refcount saturation warnings when subject to
  libbpf's bpf_test_run_opts().
  
This series fixes the bug in __retval() processing, and address the
issue with test maps not being populated. The issue in refcounted_kptr
is not addressed, __retval tags in those tests are commented out.

I found that the following tests depend on test maps being populated:
- progs/verifier_array_access.c
- verifier/value_ptr_arith.c (planned for migration to inline assembly)

Given the small amount of these tests I decided to opt for simple
non-generic solution (see patch #4).

[1] https://lore.kernel.org/bpf/f4c4aee644425842ee6aa8edf1da68f0a8260e7c.camel@gmail.com/T/
[2] https://lore.kernel.org/bpf/20230325025524.144043-1-eddyz87@gmail.com/

Eduard Zingerman (4):
  selftests/bpf: disable program test run for progs/refcounted_kptr.c
  selftests/bpf: fix __retval() being always ignored
  selftests/bpf: add pre bpf_prog_test_run_opts() callback for
    test_loader
  selftests/bpf: populate map_array_ro map for verifier_array_access
    test

 .../selftests/bpf/prog_tests/verifier.c       | 42 +++++++++++++++++--
 .../selftests/bpf/progs/refcounted_kptr.c     |  8 ++--
 tools/testing/selftests/bpf/test_loader.c     | 10 ++++-
 tools/testing/selftests/bpf/test_progs.h      |  9 ++++
 4 files changed, 61 insertions(+), 8 deletions(-)

-- 
2.40.0


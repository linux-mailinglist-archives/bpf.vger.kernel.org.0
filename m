Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988B73E425B
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 11:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhHIJTD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 05:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbhHIJTC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 05:19:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829B4C0613D3
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 02:18:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f13so23490040edq.13
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 02:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2iLuig7hnPNCo1xvz7ikUqKL/k0jIgrQqZ82ub8BSsk=;
        b=yl/Mgq89zx7j/2AGO2xts4EqdU330mRhor87v6Hso/45vs8r6S8vblCBMJ3aCD6Z3a
         zdHTEIzejOAc/7O57J2ZFq8DmnwEzOXd8N3jj1L46tx2veQKOVVbd5Zi6/pXypkyRJJt
         tV3NvWWEYzJhA5y2LwdQelQs1e2ST3kLG52BmmNXHAXINoEvlLclPf4HC4iTKVIaBy9N
         xbIXaOVNvz2VhLUNpW8DOfm7kZ7Eo5RGuW8I6kepiWVvhZitxI6rJRY/NkGpPUlE1Iqn
         x7EvqO2hYQyIsWOPPnswoVUg89LqFWWjRbiqZ1ygKbXXiNImWhTqGfxu3NHRQJpG1sFi
         rqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2iLuig7hnPNCo1xvz7ikUqKL/k0jIgrQqZ82ub8BSsk=;
        b=ujcZ7ocenBKWz6kC2E87JW/jSBmzbIcUbYtjuHpb62e5fKkBiC6Q0QSENGVNkcrrNa
         mN4iQhvgpeBEcbKqDZuXDk9+vvKuJVJggaDji3Z+lW7++LtusNXX1gMNzwm3CaplVqg7
         41VK0pPvbiAS9ZuoSKYenUnNJr+T7TEfYnaT9D/oOj87ZTOl99ZKjin/ZSCo3JTilHQt
         ljP08W0GTEmIZe97RNM6Hw/vQWrFFcMwe+G5iLCX2HMbDiqQ1C6se+bhtfgMnoF/8KJZ
         qJFBKNNauUUkaOy0u0RHhdTr0lXf7iPHeGur0wBFzK5BAcenntnumCQtZfrbm38jU4JW
         AFyg==
X-Gm-Message-State: AOAM530+lLviJjm7Qz0cjwPsZ2+toIdVuhuYt5NkjbMsXaF82F1jtvrK
        Pc8jS6czsu+mdRv/kaKodh03ZA==
X-Google-Smtp-Source: ABdhPJyM6417e1uu4vi72bVZQuJXJP3ufWjrrwlLo1pCORv6IE1WOQDbIjskMq7aJWKdroYX4pQ8Sw==
X-Received: by 2002:a05:6402:cb9:: with SMTP id cn25mr29185480edb.271.1628500721074;
        Mon, 09 Aug 2021 02:18:41 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id dg24sm1234250edb.6.2021.08.09.02.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 02:18:40 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v2 00/14] bpf/tests: Extend the eBPF test suite
Date:   Mon,  9 Aug 2021 11:18:15 +0200
Message-Id: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set extends the eBPF test suite in the test_bpf kernel module
to add more extensive tests of corner cases and new tests for operations
not previously covered.

Link: https://lore.kernel.org/bpf/20210728170502.351010-1-johan.almbladh@anyfinetworks.com/
Link: https://lore.kernel.org/bpf/20210726081738.1833704-1-johan.almbladh@anyfinetworks.com/

Changes since v1:
 * Fixed bad jump offset in JMP32 tests that would cause a test
   to pass in some cases when it should fail (1/14).
 * Added comment explaining the purpose of the register clobbering
   test case for ALU operations implemented with function calls (8/14).
 * Fixed bug in test case that would cause it to pass in some cases
   when it should fail (8/14).
 * Added comment explaining the branch conversion test (10/14).
 * Changed wording in commit message regarding 32-bit context
   argument, /should/will/ (11/14).
 * Removed unnecessary conditionals in tail call test setup (14/14).
 * Set offset to 0 when preparing tail call instructions (14/14).
 * Formatting fixes and cleanup in tail call suite (14/14).

Johan Almbladh (14):
  bpf/tests: Add BPF_JMP32 test cases
  bpf/tests: Add BPF_MOV tests for zero and sign extension
  bpf/tests: Fix typos in test case descriptions
  bpf/tests: Add more tests of ALU32 and ALU64 bitwise operations
  bpf/tests: Add more ALU32 tests for BPF_LSH/RSH/ARSH
  bpf/tests: Add more BPF_LSH/RSH/ARSH tests for ALU64
  bpf/tests: Add more ALU64 BPF_MUL tests
  bpf/tests: Add tests for ALU operations implemented with function
    calls
  bpf/tests: Add word-order tests for load/store of double words
  bpf/tests: Add branch conversion JIT test
  bpf/tests: Add test for 32-bit context pointer argument passing
  bpf/tests: Add tests for atomic operations
  bpf/tests: Add tests for BPF_CMPXCHG
  bpf/tests: Add tail call test suite

 lib/test_bpf.c | 2743 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 2484 insertions(+), 259 deletions(-)

-- 
2.25.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9B23FF379
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 20:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347158AbhIBSxi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 14:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhIBSxh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 14:53:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189F8C061575
        for <bpf@vger.kernel.org>; Thu,  2 Sep 2021 11:52:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g21so4406434edw.4
        for <bpf@vger.kernel.org>; Thu, 02 Sep 2021 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mnqC4aWmj3sHQroe9OPuIw4O7OLX5V8J9/9ogyRu/fw=;
        b=xN+tvj7RU2uH39R5uLynwY463NpQHxEPhE+mApQSpTp6LUXDmiBq7uQM6qbrSaI3fl
         tua8mf3jWiN/66fnHpCS3Pljr8/BCzx5ur20Vel1m8XOaoDRDaGupul62oVebfFaZu38
         QEmjCdyT0QAuOQV+/N2pju5YWzlVslplw8cewoscP4Pi3g/WJwpLODIjMsdEOAhg0Kx+
         AinDlKkGQUyRv8nljXilhzcaIA3fBoEmOhBs5p1rvJyG1Owq2A+D0v3qn3Bx0LUuwjTc
         N4tI+bGXxsa69cc4S7U07rBZtDh/3DQ9B1a5/uDN3cOdFxJPZfi3u23msU35NL5KdNfk
         pM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mnqC4aWmj3sHQroe9OPuIw4O7OLX5V8J9/9ogyRu/fw=;
        b=f4zpzNfLGQ2XpobrXIPSNjgT41hJ+4I+IMgE8Us1DA/zFtJvzS8wowioi5E3IDm5PY
         rZd4E6B/wi33IBKbRXmS3qA2R14wBlt7bivbmYd4mt/uvXBWcOIun1cx5cLHIw78kQRD
         5FPjzZY58M+4fuKiCynklNUj/6iISuZzNJIgdzRE3+HR+CNiJI7TyypftRWHa6nroeix
         CV2n3fTXWBdzKoSBhQNy87krcs5tv5fATZmzcU0TRTg3/tilm1AyrzaHHXn4Pm/1K9hO
         O6NnNtfohEm057XvUgRT1VtOvFp37tGdktsfIUZS4ORFrXOg92wDab3w+uSzyNSREeL3
         0f5g==
X-Gm-Message-State: AOAM532mZdkVQEh/wkaZ1+nIUN9qwpRTUIDmNgt/ORmlbHT9xSBDFll3
        xrigaWloxsxtD28uI38Rk8KbZg==
X-Google-Smtp-Source: ABdhPJzpgAWnYacfRbhe2bffwJWgdFnx0jr0m18sTklLL+TUAhbQEkZzos0HuDjaRwD4c6GKLB67+Q==
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr4935361edd.63.1630608757649;
        Thu, 02 Sep 2021 11:52:37 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id mb14sm1592235ejb.81.2021.09.02.11.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 11:52:37 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        iii@linux.ibm.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next 00/13] bpf/tests: Extend JIT test suite coverage
Date:   Thu,  2 Sep 2021 20:52:16 +0200
Message-Id: <20210902185229.1840281-1-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds a number of new tests to the test_bpf.ko test suite.
The tests are intended to verify the correctness of eBPF JITs.

In cases when it is feasible to test all possible values exhaustively, for
example every legal ALU shift value, so is done. In other cases, a pattern
of operand values that are likely to trigger different JIT code paths are
tested. For example, instructions with two 64-bit operands are tested with
every power-of-two value combination, with some small pertubations added.

Some tests might seem a bit artificial. However this patch set, as well
as my other recent additions to test suite, is essentially a bi-product of
my work implementing a JIT for 32-bit MIPS. The tests exercise mechanisms
and aspects that I encountered during JIT development, and that I found to
be non-trivial to implement correctly.

Johan

Johan Almbladh (13):
  bpf/tests: Allow different number of runs per test case
  bpf/tests: Reduce memory footprint of test suite
  bpf/tests: Add exhaustive tests of ALU shift values
  bpf/tests: Add exhaustive tests of ALU operand magnitudes
  bpf/tests: Add exhaustive tests of JMP operand magnitudes
  bpf/tests: Add staggered JMP and JMP32 tests
  bpf/tests: Add exhaustive test of LD_IMM64 immediate magnitudes
  bpf/tests: Add test case flag for verifier zero-extension
  bpf/tests: Add JMP tests with small offsets
  bpf/tests: Add JMP tests with degenerate conditional
  bpf/tests: Expand branch conversion JIT test
  bpf/tests: Add more BPF_END byte order conversion tests
  bpf/tests: Add tail call limit test with external function call

 lib/test_bpf.c | 3314 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 3272 insertions(+), 42 deletions(-)

-- 
2.25.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE4741BAC7
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 01:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243213AbhI1XLc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 19:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243148AbhI1XLb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 19:11:31 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A3EC06161C
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 16:09:51 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s11so644698pgr.11
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 16:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/6KqR1HyZHs/R3gjdGugqMMEZtEkHxmK50cLp03cmZc=;
        b=kRO6KOHPYlqrlE2PyqcrEImb73jrEqu7Tt2ZQLvLPj5LIDl6bZe8AhSBg+pEiC30E2
         ZqpLfFQoKgebHvSoK4O6w2XRWBQD51z/B5M2fUopuV8sjGFSYpFDqWg3VMWQDsGbG34C
         1utgs1CmB1i0kSnTGHGQCRZZ2QjoSGSN+M7f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/6KqR1HyZHs/R3gjdGugqMMEZtEkHxmK50cLp03cmZc=;
        b=7WrqYo4OTmhRE9RncYF9e/yL0JmzeuQC5vKUr+benN5j3CgegeORR0t+XPIvy0PN2T
         wz2a7HsRBxsfMJ1GJvZEj1MgGfeQG8jaoP6mp41Hv8zuMlVUd8ijAFnqKCeJT4hUDsKT
         EkM0i0Y3XNOmjfY5kYWbIiVt13rLjvQy7qs0IbqcwKPI6CDLkv90zMmb+Vsz9ajAv7TA
         RYgqR5x7yO36f3CUBjDkzepO+WDojry62Lqs6t5P1z8aIO7iflHuftS3/gIvLFeKcT7S
         D3OPUe0FiAExlcLa1FpyJvphmTPHbCjFUgTcVlBSF8Ijck+S6KqRiTzO3VLRGNvMfhK6
         ZVQg==
X-Gm-Message-State: AOAM530MCZ5J7Cai2pIZdxzlypHmFydPBFsmjh6BfC0O857DJ+kqlSMI
        vYSRLfmF9k6HRGcBEfazrhj1uw==
X-Google-Smtp-Source: ABdhPJzjOPXCus6KVQTOys3SwHLSXornHg81Jm/QOi9V2kIBq4MHlrR22KKBZHzNMRroNSc8R7dbWg==
X-Received: by 2002:a63:4506:: with SMTP id s6mr6965849pga.211.1632870590744;
        Tue, 28 Sep 2021 16:09:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id az15sm2918227pjb.42.2021.09.28.16.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:09:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpf: Build with -Wcast-function-type
Date:   Tue, 28 Sep 2021 16:09:44 -0700
Message-Id: <20210928230946.4062144-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; h=from:subject; bh=ruWBDY5ph5ypLUMFlAuaEw+/4pRmXpvNFEGWsS8ZW24=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhU6C5r16ay+0bVIuOnFm/IqmDsKJw4IWZdSfe93Zr TNSrAy6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYVOguQAKCRCJcvTf3G3AJl65D/ 9NDRawYFT0O5y1MYz0nxGo/IV9NHv4ciHCLzGjYxyMe2Uccqa6kfTu7VFPh6tVoKCrngtN8vvDzsfe xIOl/lUtINlaHhyWz9g1Y7SC2Da8Yob/xRz7GLNdgT8jZlYUwetxl/SkFO8ZV+PsL14AB9xlkMyHAr TxyjFi84+ZgXiSux8DUlASZcBmNEGaNbAg0dUjhV+9MNGsaXEf1gUnma8XtQ6LSQnhaTiKfTXujmtj aJffjvIpgUPs0CFc6uKaVa5MT2fuziz3SIIraEKZ4SN0aHRcd0iZYtqllm2QpDm5bLjjOtMqp/cRIr JjJGC8l1YQfriNmLj2grYaa5akAfcrpZyIsIAUW/NPWDS05HT888UifloXA6x8YZV95+rR6QyGP5K4 l7Co3b+WBVHIopAEIwcoKxG+Obmd03gfUOcEVcpkAnG/vf8mUPQhfaSQHYVLgC5VDtCH6qVN4/tfpT 4Qf9W+qdJAx81I1sU8CEsvuReEO+HPy4my16328VkFZPDzRt/ECvp/otBdYdBWdSW+LZl5n0s8kygX cDC7kVsJRAJyDg4Qyu5Ue6+uOOAdRD0tRaJJGLgrgJIban5LYRluQnq0ovXfry6vHRK61/9T+FPksF x1zmSmr1JKzvsM1qFlJ/Hq/KIQRhaKj8Vjny0HohI2AYvGQ4fhE7PNhu5hiA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

In order to keep ahead of cases in the kernel where Control Flow Integrity
(CFI) may trip over function call casts, enabling -Wcast-function-type
is helpful. To that end, replace BPF_CAST_CALL() as it triggers warnings
with this option and is now one of the last places in the kernel in need
of fixing.

Thanks,

-Kees

v2:
- rebase to bpf-next
- add acks
v1: https://lore.kernel.org/lkml/20210927182700.2980499-1-keescook@chromium.org

Kees Cook (2):
  bpf: Replace "want address" users of BPF_CAST_CALL with BPF_CALL_IMM
  bpf: Replace callers of BPF_CAST_CALL with proper function typedef

 include/linux/bpf.h    |  4 +++-
 include/linux/filter.h |  7 +++----
 kernel/bpf/arraymap.c  |  7 +++----
 kernel/bpf/hashtab.c   | 13 ++++++-------
 kernel/bpf/helpers.c   |  5 ++---
 kernel/bpf/verifier.c  | 26 +++++++++-----------------
 lib/test_bpf.c         |  2 +-
 7 files changed, 27 insertions(+), 37 deletions(-)

-- 
2.30.2


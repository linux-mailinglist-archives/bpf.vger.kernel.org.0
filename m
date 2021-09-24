Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E28416FAD
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 11:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245349AbhIXJ5v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 05:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245329AbhIXJ5u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Sep 2021 05:57:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32001C061756
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 02:56:17 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t8so25693987wrq.4
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 02:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8OaYmp305ehIjxObH1n+1np51IociiH7SmbrwDZZ6jA=;
        b=dSDIjyzW4fYRhjjOMblgat6lrCCmhpKHUCeM3zDLzkaSdrLNtDMp6ytkatKdlZlHJt
         Ql5ntcefbmCj7saQbYspqgTPKmM6wb93sVKlXqutPZZaBrjXRGJLq5kqWKdONXPUJYDB
         FRCZu8Ye2tz52fzovhANhn58kAG3zM3FIjCwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8OaYmp305ehIjxObH1n+1np51IociiH7SmbrwDZZ6jA=;
        b=BtINwkLePqY/Bbsm5U5KYQJL3rN5o3HUmdDdm2ppYvzGXcYWEIGF+XepO0CTkgnSua
         rdEHpBLt8Kf0Cpt+oo2Hq7AQPCeRtkQud7lkqyxBYFNYMJa9/G9RNg8Zepv80wr+18Yj
         UcO94v3p3kyy5PR+k/ibphKqlHBBas+Q9V9alT6AFcQo9ssFGMEDRziK8+4AmnMvCsTM
         5ibhnklVQ15EGmumRXlEI95Ihca71NxYSc/yL1dpICc39RG4H9hsBsCLnpfQmdbS0M4y
         V1XRu9bu9O6bUcVwLlVQGeh+FCkEUU7+xQI4k9Jja2zzzDo9tn1KyQSm/TU6skGUyviA
         XPtA==
X-Gm-Message-State: AOAM531hBL3WSo5MAPsofs7kqievUnf+4g6InJ/h5akgdrKIqbSH5l1I
        sXdGC9MRk8g1bUMPfUp+Z+6jhw==
X-Google-Smtp-Source: ABdhPJz3OYnepK5UMSKnkJNgitEVJ2cxRSxVD810n3eZaUJJbybqMB1g3SWKHgCq9eDnA5coFxXpKw==
X-Received: by 2002:a5d:4985:: with SMTP id r5mr10708455wrq.397.1632477375807;
        Fri, 24 Sep 2021 02:56:15 -0700 (PDT)
Received: from antares.. (1.8.8.f.e.b.b.b.5.6.9.e.c.8.5.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:58c:e965:bbbe:f881])
        by smtp.gmail.com with ESMTPSA id v20sm7871106wra.73.2021.09.24.02.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 02:56:15 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/4] Fix up bpf_jit_limit some more
Date:   Fri, 24 Sep 2021 10:55:38 +0100
Message-Id: <20210924095542.33697-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some more cleanups around bpf_jit_limit to make it readable via sysctl.

Things I'm not sure about:
* Is it OK to expose atomic_long_t bpf_jit_limit like this? The sysctl code
  isn't atomic, but maybe it's fine because it's read only.
* All of the JIT related sysctls are quite restrictive, you have to have
  CAP_SYS_ADMIN / CAP_BPF _and_ be root as well. This makes it problematic
  to scrape these to expose them as metrics. Can we relax this somewhat?

Lorenz

Lorenz Bauer (4):
  bpf: define bpf_jit_alloc_exec_limit for riscv JIT
  bpf: define bpf_jit_alloc_exec_limit for arm64 JIT
  bpf: prevent increasing bpf_jit_limit above max
  bpf: export bpf_jit_current

 arch/arm64/net/bpf_jit_comp.c | 5 +++++
 arch/riscv/net/bpf_jit_core.c | 5 +++++
 include/linux/filter.h        | 2 ++
 kernel/bpf/core.c             | 7 ++++---
 net/core/sysctl_net_core.c    | 9 ++++++++-
 5 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.30.2


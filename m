Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2554365B9
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 17:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhJUPSV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 11:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbhJUPSP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 11:18:15 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBDAC0613B9
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 08:15:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso31573wmd.3
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 08:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7m1Wk3lLuUTxXPaWg5aaAofsPODvH9dK4PSjVqp0T8Q=;
        b=v+/RR6sK6h0A3BAfp9+EAsoLcsj9Asy1xOUPdOn2tD4ssHxSDTQFcw94DUXja2iXWm
         9a/5Fphtf4bp391KQEeUEb58fkiWuCRzdLDUs65vbMxWjMYf6fLw1Fbur3oELmz/HLnC
         WIOT43tGE+wkSOwnpY3pZKahZEST1kvVp0KUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7m1Wk3lLuUTxXPaWg5aaAofsPODvH9dK4PSjVqp0T8Q=;
        b=vIzr/4LwWPsQIe3A5BUcbdWsG0qpmBRxP9VXpF99L1DwmSzrmOwEB1kminehMPO4fg
         PD82YQJcrXMsrUTui6NpL3x7NoRf8EMOG+/PQDiBV63PSi9kYAvWaSphk1GwEFjqfGec
         2UNeovsIa+AyXRZSURE2RFi0322J65GuMfTfCsGNLsmb4FAGhGnP2D23Y9a9lrr4o15v
         IG30XHAFZjNG4raIxzy2DOY6M1nQILvrsijZAghIjptFvfvehBySGcZDC5fYhLybJGRA
         nLwAm1pfUFaI1bFNFM2gfSLOHbkHFS+76Bf8wIK95kpd2xCdPitu17kVM+tQN58kWAnA
         +q+w==
X-Gm-Message-State: AOAM531xcaYWPq+QNF8TeWTc7HU2GsFg3KfBdwDXzPSpBVy2Cl9C938G
        XLJunAgblDCOZLGrgz3lYPUe7t2OiHM=
X-Google-Smtp-Source: ABdhPJwaAPH3llwbjh/cAbi0GYwtUt8sCw5ajvMT3h4TMAOjUB8W2KdxsKrw0C3LseN5K6mD0QvZ5A==
X-Received: by 2002:a05:600c:414c:: with SMTP id h12mr7365998wmm.66.1634829357512;
        Thu, 21 Oct 2021 08:15:57 -0700 (PDT)
Received: from altair.lan (7.2.6.0.8.8.2.4.4.c.c.f.b.1.5.4.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:451b:fcc4:4288:627])
        by smtp.googlemail.com with ESMTPSA id z1sm5098562wrt.94.2021.10.21.08.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:15:57 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/3] Support RENAME_EXCHANGE on bpffs
Date:   Thu, 21 Oct 2021 16:15:25 +0100
Message-Id: <20211021151528.116818-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for renameat2(RENAME_EXCHANGE) on bpffs. This is useful
for atomic upgrades of our sk_lookup control plane.

* Create a temporary directory on bpffs
* Migrate maps and pin them into temporary directory
* Load new sk_lookup BPF, attach it and pin the link into temp dir
* renameat2(temp dir, state dir, RENAME_EXCHANGE)
* rmdir temp dir

Due to the sk_lookup semantics this means we can never end up in a
situation where an upgrade breaks the existing control plane.

v2:
- Test exchanging a map and a directory (Alexei)
- Use ASSERT macros (Andrii)

Lorenz Bauer (3):
  libfs: support RENAME_EXCHANGE in simple_rename()
  selftests: bpf: convert test_bpffs to ASSERT macros
  selftests: bpf: test RENAME_EXCHANGE and RENAME_NOREPLACE on bpffs

 fs/libfs.c                                    |  6 +-
 .../selftests/bpf/prog_tests/test_bpffs.c     | 85 ++++++++++++++++---
 2 files changed, 79 insertions(+), 12 deletions(-)

-- 
2.32.0


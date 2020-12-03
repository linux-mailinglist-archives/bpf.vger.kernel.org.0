Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB952CCB57
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 01:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgLCA7C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 19:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgLCA7C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 19:59:02 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8836C0617A6
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 16:58:15 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 64so129574wra.11
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 16:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gdZHAgZSpf4diqBdz0OIIWe3lSqDjX8SVs307R6C/N0=;
        b=eqGd4ZhXn52gu0Jh1s9yGc2t8PW3is9XOJ5x9EjofVZKsTcEuPFXYE0nkMapCvjLAP
         XQqkuL/3P/Qp0s0qtrCcTWgW5RTexdsscKUEmi06jd6aKV8M4kwhDquipqk6Lo9czzx6
         Y/8pPCzTxi/vDLNOpyDtofgH2NcZ1mgsLSN9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gdZHAgZSpf4diqBdz0OIIWe3lSqDjX8SVs307R6C/N0=;
        b=fKmNte1Jg9itd0gwktlpU64Ch4M//sO584+drIeu2tdeCtYvaSCZWrHb6ucf/d1nPi
         gA0obumZ0WeGJ6pdTdDoX7RIEGqdM+FXHFGaYCdRiX1mbAYi/28fO95UUaZIeC9BUdqm
         +SJX3qcJ5IjwKqZKfn+vzh9zt1VeucELEbKTeBrDb3NVRaC2dwd1zLggqrB+CXJB4STF
         IXKLtbYPPOnagA1im9iRAQaQAbeSoX6tSeTNx5PZmEmza5LSNdhBPkKNzylRWrTZerMc
         rb8NPrqo3t8fXeBrnYWEyp4FaxdxupLo4BKkmxI9lpRVavwFxcN2fQt0ggVvSW5XCz/d
         fU2A==
X-Gm-Message-State: AOAM533XfsTJ7sS15uvT77z+I3rjHU+yp/9jeTODfn0aoHtB4UryXNmV
        5Y/c7Yf0zactiyd0rWwtV6/UAhQlEzH8u4Fm
X-Google-Smtp-Source: ABdhPJxaGi584n/O0g1GfVc50tbaNiAKUUd2lbnTaZfYyZbYqpprbddjhfzGt+P9MW9ez7RFDHzb6A==
X-Received: by 2002:adf:db8e:: with SMTP id u14mr717923wri.233.1606957094331;
        Wed, 02 Dec 2020 16:58:14 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id m4sm217960wmi.41.2020.12.02.16.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 16:58:13 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v3 0/4] Fixes for ima selftest
Date:   Thu,  3 Dec 2020 00:58:03 +0000
Message-Id: <20201203005807.486320-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

# v2 -> v3

* Added missing tags.
* Indentation fixes + some other fixes suggested by Andrii.
* Re-indent file to tabs.

# What?

* Fixes to work in busybox shell (tested on the one used by BPF CI).
* Ensure that securityfs is mounted before updating the ima policy
* Add missing config deps.


KP Singh (4):
  selftests/bpf: Update ima_setup.sh for busybox
  selftests/bpf: Ensure securityfs mount before writing ima policy
  selftests/bpf: Add config dependency on BLK_DEV_LOOP
  selftests/bpf: Indent ima_setup.sh with tabs.

 tools/testing/selftests/bpf/config       |   1 +
 tools/testing/selftests/bpf/ima_setup.sh | 107 +++++++++++++----------
 2 files changed, 64 insertions(+), 44 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog


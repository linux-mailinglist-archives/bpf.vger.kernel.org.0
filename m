Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D244236D7
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 06:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhJFEIn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 00:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhJFEIl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 00:08:41 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F497C061749
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 21:06:50 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id m21so1244855pgu.13
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 21:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V5erkMxWxirvwhW+xaAUgiYLl9XoVmreTb2rRNND8WU=;
        b=A3Jy70hqejnLC1ulutgoo4KZw/Kpm3TACdLBYcpnP7wEUdTrCOvj6lp8lNlfqFI27x
         GMtTeat5zT584WYagG2AiwDv/5fNhtdJewcx30HPtseKgtdJJlhp2za/z5jmz0ljER4h
         SWE40b7Pr/KAr5sJuxsvkqiB/bHlKEBovyKz+HLhXEIxxntQ+XUwbcORqh5L1tA7SRtX
         dFy9HfpDjVkLWUoDEoF7blm9CszGDfytZ4MXg+qtY/+5xkui7N+CFyy44UmLwyzvoohv
         ahlm4RSVZnu2XiIoJ3M9aAp5pnZ1X8o0RiO4FnhWqrzay8bcB89hDj3JjPkQlTUQYTC8
         sO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V5erkMxWxirvwhW+xaAUgiYLl9XoVmreTb2rRNND8WU=;
        b=xXh/L3KcJwU5hKwLhyQRcPQHWvzoU/208quMt0gcAG+peEK2gtQqMksv4OCSZX3dtK
         D1FxECQfVGSJrPgSHFXwcpY/kS37H7BmMWdnylL0xFN3HWUwkb4Mp6dR41wKroQCUJJd
         AptiH6Qmst+aUpM85mLaYuPD3kKY/zDs72SB/WnCEqBFS/iChwN9OSD+vDaMikE18BkT
         O48CQgzZN8qOLPS05SFTUS/bmgGbhmiZ7Tda6jbNXHnONvoD+w+RQzFgtQraVE/0Bdvk
         uolz5CSWVzjaAFxPwoovlubx/N1ZSWCkpNs7vRvqK36Fg75bYgosPugsC7nM3NNLz0C8
         bBzg==
X-Gm-Message-State: AOAM532HwZ9//K2y9e/+6yjybU7al8Om8UjqFGLaq4lPV4mcGtD9WbiN
        agq85zaJMwmDHKjPrJck3HFHjyAQILut0A==
X-Google-Smtp-Source: ABdhPJyrop5dpWpWwLPAMPiPDoj3JtzcX7Nws3fB/S9AehlpTK4X2+yNLPWIDu/dMHmLb4ryZCPAWA==
X-Received: by 2002:a63:e909:: with SMTP id i9mr18499581pgh.162.1633493209582;
        Tue, 05 Oct 2021 21:06:49 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id b21sm20846965pfv.96.2021.10.05.21.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 21:06:49 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 0/2] Add bpf_skc_to_unix_sock() helper
Date:   Wed,  6 Oct 2021 12:06:21 +0800
Message-Id: <20211006040623.401527-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds a new BPF helper bpf_skc_to_unix_sock().
The helper is used in tracing programs to cast a socket
pointer to a unix_sock pointer.

Hengqi Chen (2):
  bpf: Add bpf_skc_to_unix_sock() helper
  selftests/bpf: Test bpf_skc_to_unix_sock()

 include/linux/bpf.h                           |  1 +
 include/uapi/linux/bpf.h                      |  7 +++
 kernel/trace/bpf_trace.c                      |  2 +
 net/core/filter.c                             | 23 ++++++++
 scripts/bpf_doc.py                            | 12 +++--
 tools/include/uapi/linux/bpf.h                |  7 +++
 .../bpf/prog_tests/skc_to_unix_sock.c         | 54 +++++++++++++++++++
 .../bpf/progs/test_skc_to_unix_sock.c         | 28 ++++++++++
 8 files changed, 129 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c

--
2.25.1

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB907311BC8
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 07:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhBFG6Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 01:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBFG6Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 01:58:24 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD64C061756
        for <bpf@vger.kernel.org>; Fri,  5 Feb 2021 22:57:44 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o16so6143663pgg.5
        for <bpf@vger.kernel.org>; Fri, 05 Feb 2021 22:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Rthx5cSdzXNV82MWXuienNwiE2JFP/KPvntH7GZhQcM=;
        b=VQAOZ+15GRTGwbOiL6fkA57K/fMVC/SeQnHCS/U9lGqhjyOE9vAUkkmkPisAnZ/vhQ
         B4zndWQ0OIm0s5W7bzgWFh480NmdbN8W9qRzAxIZFi4vDq3AkuFi77R37m1Usq6QdK6S
         dtzwCmqSURto9FCXabnG0AKmtod+fJ4ZZ9+Dwzbk+IYx7Az5ODlofekASJxsU9u7V5sx
         /KQGyy+wuYoZ4SHCCJQRO4U7o8vARU4bnlMk9KdAA8F+tbxwyUoc1hEL/bHj3a0ww4ZE
         Y4QWqlBSqXCrrP/4mTmP8NxCZCFDo3un275ECZpGCwF/N932TkmazDc8VpUiJ/1Em4Cj
         SMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rthx5cSdzXNV82MWXuienNwiE2JFP/KPvntH7GZhQcM=;
        b=QK/q2eXaieeh/tN9gE+KeiZt0haYb8XHW2sVJpnb7rpy1SjSAgct3dVaOjY2MhR800
         9Q3PCX+YeKhZIfc4fNJhwpVa29wmWxbR5iV3kq17O2o/CMvjvlYFq+uX3hqXZLtJbB8q
         QPv4ykBhjB/ARqkcwy1JoporQQEU2HRwihLCBEcH4GifO+5vQVR9khs3uFPgmUmd4vF6
         SMP5mP5d/+AhLubKmZSI7xMyWVvbSYl8E0bZDGPOGbxaFXoufGDVJJDmExN4VgPYi+QW
         W1Faq3BN+IK3uviOvGm2L+rg0vvdpT8i48g9R5o4duyDUvBBA+QUHfjbEhmW0UMOjSYI
         RbZg==
X-Gm-Message-State: AOAM530nsJwIBazrjBTDuDYELPhTkPg4g0eMw5OBBsfor9/EJICvywni
        0XwkexWNxHFaBfFDN8vrFlLDLY/AyZM=
X-Google-Smtp-Source: ABdhPJwTPyhxnaz02hbGBTEUxKiU88lEA/u5pvZo+/84cJQybM4c/hc+5J0pmh69b6N4PLWC7cD87w==
X-Received: by 2002:a62:7755:0:b029:1cc:6b19:44a1 with SMTP id s82-20020a6277550000b02901cc6b1944a1mr7826410pfc.66.1612594663774;
        Fri, 05 Feb 2021 22:57:43 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id r9sm12065093pfq.8.2021.02.05.22.57.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 22:57:43 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 0/5] bpf: Misc improvements
Date:   Fri,  5 Feb 2021 22:57:36 -0800
Message-Id: <20210206065741.59188-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Several improvements
- optimize prog stats
- compute stats for sleepable progs
- prevent recursion fentry/fexit progs

Alexei Starovoitov (5):
  bpf: Optimize program stats
  bpf: Compute program stats for sleepable programs
  bpf: Add per-program recursion prevention mechanism
  selftest/bpf: Add recursion test
  bpf: Count the number of times recursion was prevented

 arch/x86/net/bpf_jit_comp.c                   | 46 +++++++++------
 include/linux/bpf.h                           | 16 ++---
 include/linux/filter.h                        | 12 +++-
 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/core.c                             | 16 +++--
 kernel/bpf/syscall.c                          | 16 +++--
 kernel/bpf/trampoline.c                       | 59 ++++++++++++++++---
 kernel/bpf/verifier.c                         |  2 +-
 tools/bpf/bpftool/prog.c                      |  5 ++
 tools/include/uapi/linux/bpf.h                |  1 +
 .../selftests/bpf/prog_tests/fexit_stress.c   |  2 +-
 .../selftests/bpf/prog_tests/recursion.c      | 33 +++++++++++
 .../bpf/prog_tests/trampoline_count.c         |  4 +-
 tools/testing/selftests/bpf/progs/recursion.c | 46 +++++++++++++++
 14 files changed, 205 insertions(+), 54 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursion.c
 create mode 100644 tools/testing/selftests/bpf/progs/recursion.c

-- 
2.24.1


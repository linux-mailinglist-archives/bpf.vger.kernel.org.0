Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2A7315DD1
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 04:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhBJDhS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 22:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBJDhR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 22:37:17 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1542C061574
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 19:36:37 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id j11so439843plt.11
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 19:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mP2MdVh1efk9gFw4f3QsEmRKZnHWWlQc9JGKk6iw+68=;
        b=DtkIQxc42unZQVNgi849ZITWkTVj3AsutPw1cfQUavf7ZYLaIo2oV9fsE79DBnaYxI
         r0UchmfNTdds3dWp/c9GTrUFO13a/lEZjkWBVyRwzesvHjxjeVFxeSeNTN1OKpqm/PcS
         Ht9n8IFzQOFSG75vEE4VGDxu89ezOCv47vkkjKK18qeT/pyny+cv3jhVoIHLZqroTFFO
         285Z/E8sv09Rd5DURwIIdgcl/zBxQKTct5uKihuwDWLJySmRGfmELnzHPUhAIezpsTGX
         oGy1KgZM5G7GNZoAJCypfLDzGHRx910zsmhWhOvC1GjH0ftZfbXDu74T1rEUv5JRmr2U
         b1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mP2MdVh1efk9gFw4f3QsEmRKZnHWWlQc9JGKk6iw+68=;
        b=QgkESONlcTgVtVtfIviDj478yiitdaku0Kq784l4SDo1ZzpGtsaYB4ppzkYo3rLRwD
         G+jE8klDVwXcZ4ul6sPJSGVkIgqq4lHsDKCI/AfwT8wFXA4pub2ZtWzAu00vQtSFbQ/f
         RpEqRmeXvB8Ql5c9YTKo1Fy0pRhPRrzayLpkCL1w/6n7g528GmrrqLUhiFUjrmzhOOtz
         rww793c59AhHd928QqyZr169rqrkVRZTavW/TYIQLJUoVeiEiSbVG7TAngmU6FmoD6gg
         ZLlXwOOj2isBkDMkwJ8v8+OLt39m1o8okjAjlwFgb7Ype/27BK/FGLFBUKKFl6jje1us
         b+3w==
X-Gm-Message-State: AOAM5327ydsox8UjrYn7qJZFhTWfv0ivesPh+lmtjUyQjoA56J2joCVJ
        rMCj7wXW3S/0ig4/fVB9Dqg=
X-Google-Smtp-Source: ABdhPJxbITJaq1k20dkXAkivWsosICjEINfxQ/OmJKILcHFVL6ed+PwgtuxeT73dYaIHwrXu4gArGg==
X-Received: by 2002:a17:90a:de8c:: with SMTP id n12mr1052889pjv.131.1612928197393;
        Tue, 09 Feb 2021 19:36:37 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id f7sm391099pjh.45.2021.02.09.19.36.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 19:36:36 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 0/9] bpf: Misc improvements
Date:   Tue,  9 Feb 2021 19:36:25 -0800
Message-Id: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

v4:
- split migrate_disable into separate patch

v3:
- address review comments
- improve recursion selftest

Several bpf improvements:
- optimize prog stats
- compute stats for sleepable progs
- prevent recursion fentry/fexit and sleepable progs
- allow map-in-map and per-cpu maps in sleepable progs

Alexei Starovoitov (9):
  bpf: Optimize program stats
  bpf: Run sleepable programs with migration disabled
  bpf: Compute program stats for sleepable programs
  bpf: Add per-program recursion prevention mechanism
  selftest/bpf: Add a recursion test
  bpf: Count the number of times recursion was prevented
  selftests/bpf: Improve recursion selftest
  bpf: Allows per-cpu maps and map-in-map in sleepable programs
  selftests/bpf: Add a test for map-in-map and per-cpu maps in sleepable
    progs

 arch/x86/net/bpf_jit_comp.c                   | 46 ++++++-----
 include/linux/bpf.h                           | 16 +---
 include/linux/filter.h                        | 16 +++-
 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/core.c                             | 16 +++-
 kernel/bpf/hashtab.c                          |  4 +-
 kernel/bpf/syscall.c                          | 16 ++--
 kernel/bpf/trampoline.c                       | 77 +++++++++++++++----
 kernel/bpf/verifier.c                         |  9 ++-
 tools/bpf/bpftool/prog.c                      |  4 +
 tools/include/uapi/linux/bpf.h                |  1 +
 .../selftests/bpf/prog_tests/fexit_stress.c   |  4 +-
 .../selftests/bpf/prog_tests/recursion.c      | 41 ++++++++++
 .../bpf/prog_tests/trampoline_count.c         |  4 +-
 tools/testing/selftests/bpf/progs/lsm.c       | 69 +++++++++++++++++
 tools/testing/selftests/bpf/progs/recursion.c | 46 +++++++++++
 16 files changed, 303 insertions(+), 67 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursion.c
 create mode 100644 tools/testing/selftests/bpf/progs/recursion.c

-- 
2.24.1


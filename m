Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B94A326787
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 20:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhBZTiV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 14:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhBZTiV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 14:38:21 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C4CC061574
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 11:37:40 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id p21so6805898pgl.12
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 11:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cgOjYdYZ1YAXdz3Zbi1CR+RpL83VJnpGEg8urwBUckM=;
        b=W3OOtnFa23qTBz/xVDv18MikcOHV36ns3a64rECb1Xh27s8ZRMEyPf1nEZE7P0D3xz
         sMgzUyF+MUr1zVashjHehyDq3cCa9DIVbPCZdQslGk5UPnlji2I/wD8HridVC105Vy5j
         oj49WFdj4AyK9NVJ8z6BiFcd7t4dg0Cw97BYSltaer3K40NFONQ+TGVn4Dt0q3a6Alaq
         EHDUHFOt7uY2ssKXb0TqhypdJfZsO0z4mnvSbyFtbSewYLy1yC0lnJn2q6I8Iq1REDij
         CH0ZmYn7v9rtdraujbQ2WXQaOYgNy50A9l9kdVrulqLqciFUwK93Ac5Pqdzt8+OnM+4s
         fR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cgOjYdYZ1YAXdz3Zbi1CR+RpL83VJnpGEg8urwBUckM=;
        b=TR78NUvFVwvUf215Z8IyoLs1Nslgbm3jV1O69DtUZcoiMS75AG2qSzt2+TLOHXCBs8
         jVf4mpUZPt7wQzblknpz2U+SztafEJI4GqLvLEaVgwaAJOb86AIT+gi1kAw/j/GrXq1B
         IVATr+RFQLCCwNtHaV85O+SwDVjqWlAv47AdRGuOisrXsAWE2iKoAjsdhqLFyhJaZYtn
         vy76s2OGX/kZwddLDULRwSltFgt6+2vU2xqBTLjoR33xSUa4DgKwo4VAeXybtM0EcE8g
         BPkvM3aYptqBwWiLgPrmZN8WPHAxg8PdpRFTSY+iDegnjy1od1b2FGnle38pssf9ZT9R
         2aUA==
X-Gm-Message-State: AOAM533/VJ7q2Vvvqvv8wfu4xmvY2anl17zvn/s73qOLSTxOwuTrPRmf
        x0F21Y6GTHjs9OlTNF667CQ=
X-Google-Smtp-Source: ABdhPJwrQ75mtYVmZ0BNYwhH6KDAq3kQoxUVX0NJWjdy1YADg/GxSItBo79AD4KCkAl1RFQkz1Xl9A==
X-Received: by 2002:a65:5c85:: with SMTP id a5mr4191384pgt.355.1614368260230;
        Fri, 26 Feb 2021 11:37:40 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id s62sm10880623pfb.148.2021.02.26.11.37.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2021 11:37:39 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, kuba@kernel.org, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: pull-request: bpf 2021-02-26
Date:   Fri, 26 Feb 2021 11:37:37 -0800
Message-Id: <20210226193737.57004-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David, hi Jakub,

The following pull-request contains BPF updates for your *net* tree.

We've added 8 non-merge commits during the last 3 day(s) which contain
a total of 10 files changed, 41 insertions(+), 13 deletions(-).

The main changes are:

1) Fix for bpf atomic insns with src_reg=r0, from Brendan.

2) Fix use after free due to bpf_prog_clone, from Cong.

3) Drop imprecise verifier log message, from Dmitrii.

4) Remove incorrect blank line in bpf helper description, from Hangbin.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Jesper Dangaard Brouer, Jiang Wang, Jiri Olsa, KP Singh, Martin KaFai 
Lau, William Tu

----------------------------------------------------------------

The following changes since commit 3a2eb515d1367c0f667b76089a6e727279c688b8:

  octeontx2-af: Fix an off by one in rvu_dbg_qsize_write() (2021-02-21 13:29:25 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to 557c223b643a35effec9654958d8edc62fd2603a:

  selftests/bpf: No need to drop the packet when there is no geneve opt (2021-02-24 21:28:30 +0100)

----------------------------------------------------------------
Brendan Jackman (1):
      bpf, x86: Fix BPF_FETCH atomic and/or/xor with r0 as src

Cong Wang (1):
      bpf: Clear percpu pointers in bpf_prog_clone_free()

Dan Carpenter (1):
      bpf: Fix a warning message in mark_ptr_not_null_reg()

Dmitrii Banshchikov (2):
      bpf: Drop imprecise log message
      selftests/bpf: Fix a compiler warning in global func test

Hangbin Liu (2):
      bpf: Remove blank line in bpf helper description comment
      selftests/bpf: No need to drop the packet when there is no geneve opt

Kun-Chuan Hsieh (1):
      tools/resolve_btfids: Fix build error with older host toolchains

 arch/x86/net/bpf_jit_comp.c                        | 10 +++++++---
 include/uapi/linux/bpf.h                           |  1 -
 kernel/bpf/btf.c                                   |  2 --
 kernel/bpf/core.c                                  |  2 ++
 kernel/bpf/verifier.c                              |  2 +-
 tools/bpf/resolve_btfids/main.c                    |  5 +++++
 tools/include/uapi/linux/bpf.h                     |  1 -
 .../selftests/bpf/progs/test_global_func11.c       |  2 +-
 .../testing/selftests/bpf/progs/test_tunnel_kern.c |  6 ++----
 tools/testing/selftests/bpf/verifier/atomic_and.c  | 23 ++++++++++++++++++++++
 10 files changed, 41 insertions(+), 13 deletions(-)

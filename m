Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970B561DFEE
	for <lists+bpf@lfdr.de>; Sun,  6 Nov 2022 02:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiKFBv5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Nov 2022 21:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKFBv4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Nov 2022 21:51:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3C9FD04
        for <bpf@vger.kernel.org>; Sat,  5 Nov 2022 18:51:55 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b185so7697442pfb.9
        for <bpf@vger.kernel.org>; Sat, 05 Nov 2022 18:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQkXJPbDm4bNMo+eIggXoZxS6jlQq5rzKkLHtcJerB8=;
        b=HG+Oti2O8dUlQnxXBNP47lEm46iw+lTobqwLceHBDcO6yqcTIlRPUmSvkTNnn3YJ88
         LR02rKi62U+5qsqkbse5OlLyl8BktTIwgm/BUsd8P6/qgLyIIr1mjCutHSesvYP+DJ6j
         J1FnqY1m0dJHoiMi+icam/DII+iYUIU2mgJ4orvZs+gdMM3Mnzyw1jEQflRqu7UU9Z3D
         ChTuHaW6i7ADW8z76I88qeTSoSKa7R7OsstQ2y8rfrMdu151fzulfw2iJEFlmwm3MtZ0
         fewjWDmqO9eAjlbBX/u9MseUd1DqF9emHteI8CuB9QIHm1al6c1D/kvFsRm8r8L2fOuZ
         m2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQkXJPbDm4bNMo+eIggXoZxS6jlQq5rzKkLHtcJerB8=;
        b=G71JnYL8qDKM1oFUIDASnikBKFwCkRbvlht5aoEjejL7/+RUPdeN4edVtTBI0ImUV0
         5ossgAoEiScxMClz1CIAdjr4ThWQY1iaFy9wA8/FDX/S1aqoAYTabOsr8BOqfZ5DQWlX
         M/4KAg6NzzIJ9hUWfo4Q7xrR//YWoGGK+aI7oeZI5MV8tck0VupsMe0O7GRmUWSRHPvC
         DbtzeI6zI4uZalegD2se8Px2GO4h2nEP3C4XvT7zlFrGLhKNVgn0tcnQE4Yk5WpXVoqQ
         Rc8PwcCLsRy7ZZUxB5bPH0GJEw8oZjwBoTbXBUGZ0dFrtfkv8GFlxREBSaAGh5baVYWJ
         CgzQ==
X-Gm-Message-State: ACrzQf1aheKkJ4er75Y9ghUpOIEkDNFnSUwlylGE5yIQA2nckFGmZ/dk
        FrkoPJukjyCs5SAE+HjvzqMhCpr8yw87rg==
X-Google-Smtp-Source: AMsMyM6+o2ZveyXSi6CYqOe/cJaJJnVUPtXIf5RDr3asJZKhSJeiO5/FSV0UN8sD3ptwv8Ajr63ybg==
X-Received: by 2002:a05:6a00:1781:b0:561:7f7f:dc38 with SMTP id s1-20020a056a00178100b005617f7fdc38mr43895828pfg.42.1667699514512;
        Sat, 05 Nov 2022 18:51:54 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id z5-20020a17090a398500b0020647f279fbsm3625247pjb.29.2022.11.05.18.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 18:51:54 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH RFC bpf-next v1 0/2] Fix deadlock with bpf_timer in fentry/fexit progs
Date:   Sun,  6 Nov 2022 07:21:50 +0530
Message-Id: <20221106015152.2556188-1-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=memxor@gmail.com; h=from:subject; bh=ZqRgScQGMHB+vW0m7VyMl/gszG4naIaamBQaW3lLX1Y=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZxJY5mIECOF6p4Defv1fnf/YpUL7FqD4Xk9g89cp XUJzmAmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2cSWAAKCRBM4MiGSL8RysFtEA CgrW+veBaD3SR2Yt5R7yqayAZJwNTqV7KRhSSR5m/IZgNo6LChBJuJKLbN1ir6vhkhFrI9EbwSwOGO SHDa8f2WXCDlKa/5dT4iFkd12HdezpRHaUnora6dXkntb43EgV27PM58YXi3itKRMvseA8z6Ga5M6P o/lzKZFzq26n9hQf4ripi5hO77XYMJj9x9hgF/Y8FlXO+ogILHhmAn0k/e4Y6GwWHEhjUtvduAZTsp f8fa1jHOrWsGdBa7JaNXzG3ahOlWh1rKKeG1WgA/Ld/T7ASzIZ+R1i0tFcYVKBDeq3hOSkUafWBrk+ 72rvnzBcrRsKgVCHScXPLoAjM25wRU2YPYzKjUoZpzDYWyF9T90T7wYtIT7oDF+3//5eokx/zOQ7uO PbU7jJKvyUa357KAmMwcy4Je8TBTjMP6dDUfScmYlUXs8uPoG7pyR+cjI6rzFrI2ClOT+SNNvuDqhZ koAcUHYchO3pttjfALG2qbfmi4Pl1fBHiCz70mkqS5H+3hJaVZqoZp09eFeKp5fp4HenuDGY4bdPrv l8U41CMqLib9007ILIUYiwU0zMH87rJOrG65xiNhOQJ465TNhs+voOOSBjWkRw/R9+Fx/fhw4F4cVS TPb64JCrpy42ScavNcHI+O0mtl6fHWo56rxlBieuuFcypELvroHsA+f7wsmg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, this is a fix for a deadlock condition I noticed (and verified by
constructing a test case, see patch #2) while looking at the code. There
might be alternative ways to solve this, like having percpu map ops
recursion counter, and detecting reentrancy based on that. I went for
the simpler option for now.

Previous discussions on a patch doing something similar for a different
issue here, but never added BPF_PROG_TYPE_TRACING to this list:

https://lore.kernel.org/bpf/CALOAHbBK1=ujbZp5n4t9zQf+DPZ3-a2ZDL0a3sfhVU6meJGqYw@mail.gmail.com
https://lore.kernel.org/bpf/CALOAHbAQ7AKNPrkawGKHarkB5CGkWXTC8P=+EJP3DAPNEf=Ayw@mail.gmail.com

Note that timer and timer_crash selftests are broken by this change, so
it has potential for wider breakage.

Kumar Kartikeya Dwivedi (2):
  bpf: Fix deadlock for bpf_timer's spinlock
  [EXAMPLE] selftests/bpf: Add timer deadlock example

 kernel/bpf/verifier.c                         | 10 ++--
 .../testing/selftests/bpf/prog_tests/timer.c  | 21 +++++---
 .../selftests/bpf/prog_tests/timer_crash.c    |  9 +++-
 .../selftests/bpf/prog_tests/timer_deadlock.c | 29 +++++++++++
 tools/testing/selftests/bpf/progs/timer.c     |  8 +--
 .../testing/selftests/bpf/progs/timer_crash.c |  4 +-
 .../selftests/bpf/progs/timer_deadlock.c      | 50 +++++++++++++++++++
 7 files changed, 113 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_deadlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_deadlock.c


base-commit: 25906092edb4bcf94cb669bd1ed03a0ef2f4120c
--
2.38.1


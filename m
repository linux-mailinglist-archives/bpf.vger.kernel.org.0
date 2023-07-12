Return-Path: <bpf+bounces-4877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD9175138F
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 00:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E738281A18
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 22:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E34AFBFB;
	Wed, 12 Jul 2023 22:30:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D6314F8C;
	Wed, 12 Jul 2023 22:30:51 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8641BF9;
	Wed, 12 Jul 2023 15:30:50 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b5d7e60015so26910a34.0;
        Wed, 12 Jul 2023 15:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689201049; x=1691793049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kiCtA/22/EFm5piD1C3kb16M+b7jXxq1GCQ/ove9Xq0=;
        b=E6Wp19MqbiLa2w7w8XBEoyRhEcfcSxvTvj2OkSTX3vp6LRYcYoZiMzggqAGNwlx5Iz
         QX0n4wA+Ke0Jt6PAMil195jlchqfWxTW/CZGRXZ3iHGaNjrJG1lfmEOSiQMujagfN8ft
         dkpA8+tObItaUlZAUFA/k35Cu5CRMRGIKFSrckM89xjNXopjLGMe836Bqu1ONCbcOD7Y
         Jyb0HD8IQ5xOixDntnw+21DCZaJrNjA32NyeKBQK4eP2dooEu1IHi9Home9BiWH1IOrx
         KWumjonVVr8FvJebrZ3EopygegOb5rMNJtTUXeHqf82x2djD0ZGhnqaMSqcmWB+zwp/M
         xyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689201049; x=1691793049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kiCtA/22/EFm5piD1C3kb16M+b7jXxq1GCQ/ove9Xq0=;
        b=ClZW0kAbrJ0SI37QjUrhhqqmvXVY4LgBXPdh1vdyYZDJsROOQhjCZjP7zdIRA7W1Wd
         JdHKaBDJLYl37HV39grgVDh/pCLCO6vCPqRLgm+y9Hj2I0aKfCf6QMdEIIyHtKjJ2N9t
         KrZdhvn9B4x1IqRUCx5TFiU7c1HSmd1zRXpKkTBTWzq263PjTpaiVL32e98UQpFEpk/2
         lIy266CwfXBflID7AkXeVCayAgdkPdOcZakhJQAtoR23vhjIk5QOEch+8Xt/n09jfPfp
         X9LLVAZ48b1X/63dwF8KR+I//0I+HLn8EQDfm+0I5D2YRqsHoYaK62SHHcm8uwQvhn+r
         cMPA==
X-Gm-Message-State: ABy/qLYTfE5h9/Mlgw/yECz78TdfwwtTxEz/wSx/fXr0MsIBwkl5tfci
	jHuMFk3wWJVMwtELxvhsJHw=
X-Google-Smtp-Source: APBJJlE/TrK+/bVBSaKKfwmTCH2roaa04EPD0bWHMKadQ45qsGluYb662stQWtWVrmHVvWnKupUpzw==
X-Received: by 2002:a05:6830:e05:b0:6b8:9705:5035 with SMTP id do5-20020a0568300e0500b006b897055035mr18929269otb.33.1689201049336;
        Wed, 12 Jul 2023 15:30:49 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:3399])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090a2acb00b00265b0268382sm4431105pjg.37.2023.07.12.15.30.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Jul 2023 15:30:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: pull-request: bpf 2023-07-12
Date: Wed, 12 Jul 2023 15:30:45 -0700
Message-Id: <20230712223045.40182-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 5 non-merge commits during the last 7 day(s) which contain
a total of 7 files changed, 93 insertions(+), 28 deletions(-).

The main changes are:

1) Fix max stack depth check for async callbacks, from Kumar.

2) Fix inconsistent JIT image generation, from Björn.

3) Use trusted arguments in XDP hints kfuncs, from Larysa.

4) Fix memory leak in cpu_map_update_elem, from Pu.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Hou Tao, Jesper Dangaard Brouer, Stanislav Fomichev

----------------------------------------------------------------

The following changes since commit 6843306689aff3aea608e4d2630b2a5a0137f827:

  Merge tag 'net-6.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-07-05 15:44:45 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 2e06c57d66d3f6c26faa5f5b479fb3add34ce85a:

  xdp: use trusted arguments in XDP hints kfuncs (2023-07-11 20:04:50 -0700)

----------------------------------------------------------------
for-netdev

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'Fix for check_max_stack_depth'

Björn Töpel (1):
      riscv, bpf: Fix inconsistent JIT image generation

Kumar Kartikeya Dwivedi (2):
      bpf: Fix max stack depth check for async callbacks
      selftests/bpf: Add selftest for check_stack_max_depth bug

Larysa Zaremba (1):
      xdp: use trusted arguments in XDP hints kfuncs

Pu Lehui (1):
      bpf: cpumap: Fix memory leak in cpu_map_update_elem

 arch/riscv/net/bpf_jit.h                           |  6 ++--
 arch/riscv/net/bpf_jit_core.c                      | 19 ++++++----
 kernel/bpf/cpumap.c                                | 40 +++++++++++++---------
 kernel/bpf/verifier.c                              |  5 +--
 net/core/xdp.c                                     |  2 +-
 .../selftests/bpf/prog_tests/async_stack_depth.c   |  9 +++++
 .../selftests/bpf/progs/async_stack_depth.c        | 40 ++++++++++++++++++++++
 7 files changed, 93 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/async_stack_depth.c
 create mode 100644 tools/testing/selftests/bpf/progs/async_stack_depth.c


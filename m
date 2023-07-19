Return-Path: <bpf+bounces-5351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07751759CA9
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 19:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E541C21031
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 17:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C5614269;
	Wed, 19 Jul 2023 17:45:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595AF1FB38;
	Wed, 19 Jul 2023 17:45:10 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C0E18D;
	Wed, 19 Jul 2023 10:45:09 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8ad8383faso56835795ad.0;
        Wed, 19 Jul 2023 10:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689788709; x=1692380709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkSQ+Te1cugB75r/mrWmRifad0onqOKRiVjVLsx0nKQ=;
        b=Hf5PZyWUpxtV4L8yhVyD4iKtB2S3zG2e9kSRwZCivGwoBJVANU+R5RMeGE7B7OxHSE
         JKzko8d6FE+e0WUqOTq3En0BB8a+45iu9kkyGvc79cAgVSPqpGRvY9CfxxDz+wp8BZRw
         IQIMAX1LYSyeJB+ioSp07B1R0TqPPXxtZWux+ASNfihohMoaJoljkEfxMqcMBfHrbBle
         MuDXXYkdKVDIEngE1T5YqoAshjW2N+Ro3A2yR9Ogd53vFnHksl6ynEIG0fLvuFwfcOPb
         oAOhR9ZwwoMjyHNa/4PKSbqtCqwjCHX4wrZf2g8ifY31LyrsK8/ESBrcrDjy8IcdA+4c
         jcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689788709; x=1692380709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkSQ+Te1cugB75r/mrWmRifad0onqOKRiVjVLsx0nKQ=;
        b=PwTZ0SPkUp462Cfw0fS8VpWmVqqRLLbSb65S8LBRHPs7BS22I8x9mTdgf3jcf07gTB
         vTzWO66qgZm/HxaesklsdYCz2pIUYKwwkruXKwcENx6e2qFLhpiuII4Nsc8OfLSIGCio
         PGuh1DCcGeCr0x0FaI/UYV390As73hSvNqgSIPLvJDTa0D8+ua6MccoK94WsY264Y8Bp
         5NtL8wHrGJgFWYu/Z3WPDU6ofWUZBlS0789HURTOqs6kY0akZWSj1sv8Jj7IBt/RfK7c
         UJLUoizwFkeqOXfMvzz2h2X9KE9LJGnvpBd8NVpsYTpSXzxf/eVko+X0VD70T0mOkG+y
         3VLQ==
X-Gm-Message-State: ABy/qLZQq1bNYZizilZOIazVcd7Ou19qQYePS7eziQAGeQ8d3Jgddl8b
	WV70e5d+76afW243HJgIgUI=
X-Google-Smtp-Source: APBJJlFxUdjOe7hocMweP3Q7Sqbddpj+pdSjiOL+r2nQRK8TY6UYQ+UKg5EMdUnTIAVjawFSo5I2dw==
X-Received: by 2002:a17:902:7085:b0:1b8:b318:8ae5 with SMTP id z5-20020a170902708500b001b8b3188ae5mr16661550plk.42.1689788708566;
        Wed, 19 Jul 2023 10:45:08 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:500::4:8907])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001b03cda6389sm4279814plf.10.2023.07.19.10.45.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Jul 2023 10:45:08 -0700 (PDT)
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
Subject: pull-request: bpf 2023-07-19
Date: Wed, 19 Jul 2023 10:45:02 -0700
Message-Id: <20230719174502.74023-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 4 non-merge commits during the last 1 day(s) which contain
a total of 3 files changed, 55 insertions(+), 10 deletions(-).

The main changes are:

1) Fix stack depth check in presence of async callbacks, from Kumar Kartikeya Dwivedi.

2) Fix BTI type used for freplace attached functions, from Alexander Duyck.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Xu Kuohai

----------------------------------------------------------------

The following changes since commit 8fcd7c7b3a38ab5e452f542fda8f7940e77e479a:

  octeontx2-pf: Dont allocate BPIDs for LBK interfaces (2023-07-18 14:51:45 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to a3f25d614bc73b45e8f02adc6769876dfd16ca84:

  bpf, arm64: Fix BTI type used for freplace attached functions (2023-07-18 15:28:19 -0700)

----------------------------------------------------------------
for-netdev

----------------------------------------------------------------
Alexander Duyck (1):
      bpf, arm64: Fix BTI type used for freplace attached functions

Alexei Starovoitov (1):
      Merge branch 'two-more-fixes-for-check_max_stack_depth'

Kumar Kartikeya Dwivedi (3):
      bpf: Fix subprog idx logic in check_max_stack_depth
      bpf: Repeat check_max_stack_depth for async callbacks
      selftests/bpf: Add more tests for check_max_stack_depth bug

 arch/arm64/net/bpf_jit_comp.c                      |  8 +++++-
 kernel/bpf/verifier.c                              | 32 +++++++++++++++++-----
 .../selftests/bpf/progs/async_stack_depth.c        | 25 +++++++++++++++--
 3 files changed, 55 insertions(+), 10 deletions(-)


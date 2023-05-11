Return-Path: <bpf+bounces-355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9506A6FF80A
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 19:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11521C20F95
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 17:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1EA6AB6;
	Thu, 11 May 2023 17:05:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66CEA53
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 17:05:09 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E8C2705
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:04:58 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-64380c45e84so9228587b3a.0
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683824698; x=1686416698;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W0xj8Y/CXbf9Yuz3VGB1GKTzqDlFR9pRd/qhdYwzxyw=;
        b=2ruFBQ1IVj3M3D08D+NXLqMxXY+08ASyw/Uezv/+m/63GkiFmplpW3XHnxo78iibGJ
         6Cs8Wtg5adkaf4ibxRvZEqPfYaU+DNHyxkjl2qorBopMO2OiPHTjARu/3C4xexu/MMIC
         UMADZxWcTw7H5GU2FPkA+Uq01pRCH+owslWJpYkVsXjYXlswXPduANgWxDY4mM30HOM/
         HzCHgUi2muRypjHKtpI79arNQuy4NsGOSY4S0sEb4YZTH3FrFyjwuAIpsOdVCGEizUjA
         M2GzCt4xVlbFF+y3Q1Gd0QWDHyTdZOp4rc7FMpBs44wWdKu19SWPPbDrRwxq9aawm45N
         BpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683824698; x=1686416698;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0xj8Y/CXbf9Yuz3VGB1GKTzqDlFR9pRd/qhdYwzxyw=;
        b=Nh+sohumkLgAzqj41sPoB1p167yagnJlGj79gX8irB+ABh7c1CJyklGPwMcmSvY4JV
         0Jzol+HYkv5cFK5D86brx09PU/GMGWK62IDrpzd3rY85lD5pb41AvpgUerFwt92pyn6M
         XAYpuLWozDi+j9VBgAhwu7T5gCJrzdVV1v83KljsOfvntBrHwTnYk6oMq3PJQmvqatxP
         gjn/BCwXEEkZK3O7+G6hnDqFgl1fngv7pVs5r0XnRvpeFLVaEUGj4K3DKBOa3P5N5nnG
         Blq6gLiyibUDSOcQhDMVp8mm9dSras2JKtUvPwJ/MsSZtL/pX9LuWqVciYdfeRdlo3Pt
         QvTQ==
X-Gm-Message-State: AC+VfDwuFFaEskbWCOZxHCoWKFPZZ+ByOXnf3soRJhVruBlIm8O1bitZ
	RLqB6bO5aLcXye7b4jncELcY9Rkpze0hyR00u+wkvKNV3P0h3D94EeUoewEWimodM/s2phi88yP
	SIKb+8DgT2OLPJYnHA4QZoW2iJA/FstPfMU/DD4mglg4eL7FUsg==
X-Google-Smtp-Source: ACHHUZ7mEsNUcGazwc50mPaSe+U1+rSv4etIFZ36keYIjLR0u3VuFS8rT5MFuAV4tKdoma35vHH/jvg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:be8:b0:643:5d6a:9c23 with SMTP id
 x40-20020a056a000be800b006435d6a9c23mr6080882pfu.4.1683824697753; Thu, 11 May
 2023 10:04:57 -0700 (PDT)
Date: Thu, 11 May 2023 10:04:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511170456.1759459-1-sdf@google.com>
Subject: [PATCH bpf-next v6 0/4] bpf: Don't EFAULT for {g,s}setsockopt with
 wrong optlen
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

optval larger than PAGE_SIZE leads to EFAULT if the BPF program
isn't careful enough. This is often overlooked and might break
completely unrelated socket options. Instead of EFAULT,
let's ignore BPF program buffer changes. See the first patch for
more info.

In addition, clearly document this corner case and reset optlen
in our selftests (in case somebody copy-pastes from them).

v6:
- no changes; resending due to screwing up v5 series with the unrelated
  patch

v5:
- goto in the selftest (Martin)
- set IP_TOS to zero to avoid endianness complications (Martin)

v4:
- ignore retval as well when optlen > PAGE_SIZE (Martin)

v3:
- don't hard-code PAGE_SIZE (Martin)
- reset orig_optlen in getsockopt when kernel part succeeds (Martin)

Stanislav Fomichev (4):
  bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen
  selftests/bpf: Update EFAULT {g,s}etsockopt selftests
  selftests/bpf: Correctly handle optlen > 4096
  bpf: Document EFAULT changes for sockopt

 Documentation/bpf/prog_cgroup_sockopt.rst     |  57 ++++++++-
 kernel/bpf/cgroup.c                           |  15 +++
 .../bpf/prog_tests/cgroup_getset_retval.c     |  20 ++++
 .../selftests/bpf/prog_tests/sockopt.c        |  99 +++++++++++++++-
 .../bpf/prog_tests/sockopt_inherit.c          |  59 +++-------
 .../selftests/bpf/prog_tests/sockopt_multi.c  | 108 +++++-------------
 .../bpf/prog_tests/sockopt_qos_to_cc.c        |   2 +
 .../progs/cgroup_getset_retval_getsockopt.c   |  13 +++
 .../progs/cgroup_getset_retval_setsockopt.c   |  17 +++
 .../selftests/bpf/progs/sockopt_inherit.c     |  18 ++-
 .../selftests/bpf/progs/sockopt_multi.c       |  26 ++++-
 .../selftests/bpf/progs/sockopt_qos_to_cc.c   |  10 +-
 .../testing/selftests/bpf/progs/sockopt_sk.c  |  25 ++--
 13 files changed, 330 insertions(+), 139 deletions(-)

-- 
2.40.1.521.gf1e218fcd8-goog



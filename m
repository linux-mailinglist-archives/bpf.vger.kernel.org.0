Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AEB6F0CCC
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 22:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjD0UEN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 16:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0UEM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 16:04:12 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A280030FC
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 13:04:11 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-247c0ee87aaso5186548a91.0
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 13:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682625851; x=1685217851;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yiyQnJT8xAERESugkKaVw6YWxdx1ItFdxkpRxA9aCPQ=;
        b=lNhTs1zsOhAbEzgSO/c9lXN1DfT63sv+ZR++XOuMMkwW78FklMqI1BUiTC2WfZyYTf
         cZDw19M45OwR31fY8M/WLu+c8bN09WgVGeGoxR1zfZZ7nePmrIz/eJ0jrvQoO+15MXi6
         1dQBDU5r5JFhOEVyx3n/S+Ens4eK/xR33oyh4LdJshOLV6CvwLtVtcx2k8e2c1nY7dtB
         6/i+iga9d3ztU2wUsd1kBZGx9rFHTSpabMxHdPpxkh6Awyu7/Gf81X4YrXd73lcotI1S
         Qjya/MJCaktLchOYZ2wjJAgaFh0XzYvdNUfskZi4c2y36wh/oJjhz8jdjNopRsi+nfav
         HJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682625851; x=1685217851;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yiyQnJT8xAERESugkKaVw6YWxdx1ItFdxkpRxA9aCPQ=;
        b=eCaDDH24He6ZEvf1l49644poFc1gP92zzq0CQ5AtW43mGSt9q4bngQLeCujt2b5nOw
         if6ersqXYvxpd5+6m03vmaJMJqnftaE9cnh/TAn8/vcMiPtNp55UDXzymZ9dK1Lmtfge
         NRFdm2TMWuo1c5EfOaz8LOFJYvTyvTrL2eK1WYu/gdLMfCNQjsIBKzcJKCSG7IL4dJPm
         G1nKYq51gDOeLeuxAIpzbcbT6f5onx5FPZoUskcTTnwF4GVB4Xh7XR0Cc2A16PonAxQK
         aQhPC6pcTTr39DtLGjzTciHfRLUOha7dGFR1KWzTb2RvPp+fwH7xoqA9FYxTASw4ErjJ
         8CRQ==
X-Gm-Message-State: AC+VfDwTpqXWBGVT6ZIE1J1Ke4X3MNu5lkenwEy2QCSSahNM0JVdG+zX
        K5wmRaCQw+3wn6TS+XDfcHZwfbzUIzlW4EZ+Nr/cow1dCPidn4U/pm72/mnUQvDzrV8EDZSi/gy
        E0y2+oxgrBiDxcHABLTtF+BQFg/KXRuliGGDAL7jdEsYADxG9ow==
X-Google-Smtp-Source: ACHHUZ4ok/gtVITncOOj+mITAf5IyEJ7eDwhB5PM2ySlI0plqLEr67VR8FKbcB534FKq+7VMx5H/UjE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:7388:b0:247:3048:58ef with SMTP id
 j8-20020a17090a738800b00247304858efmr810163pjg.6.1682625850978; Thu, 27 Apr
 2023 13:04:10 -0700 (PDT)
Date:   Thu, 27 Apr 2023 13:04:05 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427200409.1785263-1-sdf@google.com>
Subject: [PATCH bpf-next v2 0/4] bpf: Don't EFAULT for {g,s}setsockopt with
 wrong optlen
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

optval larger than PAGE_SIZE leads to EFAULT if the BPF program
isn't careful enough. This is often overlooked and might break
completely unrelated socket options. Instead of EFAULT,
let's ignore BPF program buffer changes. See the first patch for
more info.

In addition, clearly document this corner case and reset optlen
in our selftests (in case somebody copy-pastes from them).

Stanislav Fomichev (4):
  bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen
  selftests/bpf: Update EFAULT {g,s}etsockopt selftests
  selftests/bpf: Correctly handle optlen > 4096
  bpf: Document EFAULT changes for sockopt

 Documentation/bpf/prog_cgroup_sockopt.rst     | 57 ++++++++++++-
 kernel/bpf/cgroup.c                           | 12 +++
 .../selftests/bpf/prog_tests/sockopt.c        | 80 +++++++++++++++++--
 .../progs/cgroup_getset_retval_getsockopt.c   | 12 +++
 .../progs/cgroup_getset_retval_setsockopt.c   | 16 ++++
 .../selftests/bpf/progs/sockopt_inherit.c     | 16 +++-
 .../selftests/bpf/progs/sockopt_multi.c       | 24 +++++-
 .../selftests/bpf/progs/sockopt_qos_to_cc.c   |  8 +-
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 25 ++++--
 9 files changed, 230 insertions(+), 20 deletions(-)

-- 
2.40.1.495.gc816e09b53d-goog


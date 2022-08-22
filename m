Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F3959C92C
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 21:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbiHVTpW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 15:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbiHVTpT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 15:45:19 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED7C501AD
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 12:45:16 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id t10-20020a17090a4e4a00b001fab2c791dcso6560946pjl.5
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 12:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=8TJigjV2Fudx2ieRLr0FGk4JnHiVtGw8L/+IVSxRbXM=;
        b=KQnQxfXQVbsWbtPF5PHwLHRtJ4jVq0s96CPUG4kl+X6H7BLxBE+tK/t7+D24ywZgjX
         6dVP1mmHCQzjdl/MOK/8TVC7y0OkxLiWNOaf8pjRKK9ZNa+XgfDdvWXBxWN4yrm6l9ZD
         9luTQWjgRRVus5GDyFEouEeCktdBGiCVW1O2RDoZZV6PANJgNqb/aEONcQnvvfhYPk63
         ulNFc8Pb600+uDzK2XNzlVjGQUWMckQvNFGO6pkhQImhxQVItOoEVvBHvblsJH8Pj6u5
         aC2cJzSAcFH69Kbn1sg73SFVmJU3wVkCHyeqaSMvUC3OF1bwuIjTEDoDKwpb3+O8SK27
         o7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=8TJigjV2Fudx2ieRLr0FGk4JnHiVtGw8L/+IVSxRbXM=;
        b=UCDRAUZVV6No45ix/dSaHgdq+UXh2PO9NsuVbaLLKK7Cnjv6Hbo1Zd0DkgdzX+CU3G
         PPCaw8Vzmo55KXHPrdXHei6HUzeP1YG0i1NBHaPaqZUmMafQyFAqdB4fzA8RWohSdRHR
         Oe7ct1NnNowCLtKoecu5agBwM3Rd/uiHPfym7KmLsMlquS8fUogbQmiL80eijbnoEEMa
         BgptWN1wmuCv2cx1FO2zIX1AeEMMcFeKS7T0qbiYuUaEsIdlztW56z2dv96cQxD3P4jX
         e/scCyQXPsJyifFKjlEG+LCsOw25iCORt3k1o3821FtnqkG5z90BPN0EVqF1itZ0c91F
         /Jng==
X-Gm-Message-State: ACgBeo3vGkkb4gjQqTgnMEXxpR8tGxNDuOlWqmvYfETO9K8dsyPu2kDm
        YuXSXu831n6/a4l23GNs2uY548a6JnGWr5jQjhNDgMClF+BwxfJGN8J2aivfM0jNJBAYaNRzisq
        JsL2bXvg9m/VJtZi7BYTCK/XBoENAaGq2ubyaRSapeartOFaCHQ==
X-Google-Smtp-Source: AA6agR71ArMBUQhllfFYNBwNPw7WvwkmOSmWXuxPPVAt76F2Hfx4FNcy8X41X2A0ovjHnpctKdiu/MY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:6bc2:b0:16d:d2c2:7ff with SMTP id
 m2-20020a1709026bc200b0016dd2c207ffmr21677407plt.87.1661197514824; Mon, 22
 Aug 2022 12:45:14 -0700 (PDT)
Date:   Mon, 22 Aug 2022 12:45:08 -0700
Message-Id: <20220822194513.2655481-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v4 0/5] bpf: expose bpf_{g,s}et_retval to more cgroup hooks
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

Apparently, only a small subset of cgroup hooks actually falls
back to cgroup_base_func_proto. This leads to unexpected result
where not all cgroup helpers have bpf_{g,s}et_retval.

It's getting harder and harder to manage which helpers are exported
to which hooks. We now have the following call chains:

- cg_skb_func_proto
  - sk_filter_func_proto
    - bpf_sk_base_func_proto
      - bpf_base_func_proto

So by looking at cg_skb_func_proto it's pretty hard to understand
what's going on.

For cgroup helpers, I'm proposing we do the following instead:

  func_proto = cgroup_common_func_proto();
  if (func_proto) return func_proto;

  /* optional, if hook has 'current' */
  func_proto = cgroup_current_func_proto();
  if (func_proto) return func_proto;

  ...

  switch (func_id) {
  /* hook specific helpers */
  case BPF_FUNC_hook_specific_helper:
    return &xyz;
  default:
    /* always fall back to plain bpf_base_func_proto */
    bpf_base_func_proto(func_id);
  }

If this turns out more workable, we can follow up with converting
the rest to the same pattern.

v4:
- don't touch existing helper.c helpers (Martin)
- drop unneeded CONFIG_CGROUP_BPF in bpf_lsm_func_proto (Martin)

v3:
- expose strtol/strtoul everywhere (Martin)
- move helpers declarations from bpf.h to bpf-cgroup.h (Martin)
- revise bpf_{g,s}et_retval documentation (Martin)
- don't expose bpf_{g,s}et_retval to cg_skb hooks (Martin)

v2:
- move everything into kernel/bpf/cgroup.c instead (Martin)
- use cgroup_common_func_proto in lsm (Martin)

Stanislav Fomichev (5):
  bpf: Introduce cgroup_{common,current}_func_proto
  bpf: Use cgroup_{common,current}_func_proto in more hooks
  bpf: expose bpf_strtol and bpf_strtoul to all program types
  bpf: update bpf_{g,s}et_retval documentation
  selftests/bpf: Make sure bpf_{g,s}et_retval is exposed everywhere

 include/linux/bpf-cgroup.h                    |  17 ++
 include/uapi/linux/bpf.h                      |  22 ++-
 kernel/bpf/bpf_lsm.c                          |  17 +-
 kernel/bpf/cgroup.c                           | 162 +++++++++++++++---
 kernel/bpf/helpers.c                          |  40 +----
 net/core/filter.c                             |  80 ++++-----
 tools/include/uapi/linux/bpf.h                |  22 ++-
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../bpf/cgroup_getset_retval_hooks.h          |  25 +++
 .../bpf/prog_tests/cgroup_getset_retval.c     |  48 ++++++
 .../bpf/progs/cgroup_getset_retval_hooks.c    |  16 ++
 11 files changed, 326 insertions(+), 124 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c

-- 
2.37.1.595.g718a3a8f04-goog


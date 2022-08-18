Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2246B59912A
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 01:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiHRX1d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 19:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241562AbiHRX1c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 19:27:32 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652C4D7593
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 16:27:31 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id r13-20020a17090a454d00b001f04dfc6195so1685615pjm.2
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 16:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=9NL/MGm5AHq1wrzRe0O0SuxsMoLUiY6vUB/kSVtuDXQ=;
        b=gMyckusyqNV8cXVvgNCBl24tf6Fd9k6i756kvnQpSycCgpW6uggE/oZRZt4sXntJXL
         Uls32V7yxgCjrtWJ0xKanGRw2wYQZzHIVOwTZrSWR7CHRPti5eDNcR1cp9KiYWIXiuY2
         TwsvNdvhMRP+f2DAfbvVF+W586kGFjzv8bBnn5zfTk4+ZDDdr79KK0OrvAqV/dGGokWF
         +XAQTKT1Sl1SEbu+cR/dITi8uXPY1SieiUomnxxYOYYhsnlEczxckay/OURsMtWEirva
         IlT9eaH9caLlhe3liDplYTk2pcKZ+iP+6ip3A3jlq3VAip6q6MMDvd1XRg5ZWQdLNXEj
         VC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=9NL/MGm5AHq1wrzRe0O0SuxsMoLUiY6vUB/kSVtuDXQ=;
        b=GYmnOtfDoSJHmpEVyS8DiC/QFcTq1Gi6dkVoNzwMXwn8UUKDTl6PpaS6S+78lRdgOQ
         5EhZGOAEoVt3zzq7mvZ7Fngi1LN95S1JHX/rAZQYfA0TL/a3ZM2LtC9Xr//qXn60f811
         YZl80KLJVUFsBhWBnZRRbVYXOGjCi/A0Dt/v83VKHp/DUBnZ09e/Zj5UaBFh/blNsGt4
         yGToCmU0RwQfsi58C+3KkqVOHaeJa0f5mOQL7vsB0vZbLnsCsm9dyNIXMVSTB1Ag/gp0
         qsB/OOI/r4ADCfKys2DmUdl2xeIFPYAlnPUYnlWQWakvws/yHz6NKop/LiZalrOemqXs
         rl2Q==
X-Gm-Message-State: ACgBeo3hxkKC1b9axGV7feNxbq0g+lKtrbazYioY5EW8Wt9zoNmmG2ux
        LXKZRf77WY2WhK5NQl6PBnHAncycYT3nCDA8Ts2c/uNCxXViDwNiG0SKYpZ8lNeHjfYp56Gd8wq
        9yvvYLftLdPVW4ftuFLq7kWNrs+TcVb4+lmLAU3Da/0X9KLud+Q==
X-Google-Smtp-Source: AA6agR5s92Xgx+RScZX3QUYGuCIzPGuRsulr/092ujLQTQjcHZuvbn2GwwQZpiBanfRHewqX360KUiQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:244c:b0:171:59be:6762 with SMTP id
 l12-20020a170903244c00b0017159be6762mr4541514pls.20.1660865250817; Thu, 18
 Aug 2022 16:27:30 -0700 (PDT)
Date:   Thu, 18 Aug 2022 16:27:24 -0700
Message-Id: <20220818232729.2479330-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v3 0/5] bpf: expose bpf_{g,s}et_retval to more cgroup hooks
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
 include/uapi/linux/bpf.h                      |  22 +-
 kernel/bpf/bpf_lsm.c                          |  19 +-
 kernel/bpf/cgroup.c                           | 212 ++++++++++++++++--
 kernel/bpf/helpers.c                          |  82 +------
 net/core/filter.c                             |  92 +++-----
 tools/include/uapi/linux/bpf.h                |  22 +-
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../bpf/cgroup_getset_retval_hooks.h          |  25 +++
 .../bpf/prog_tests/cgroup_getset_retval.c     |  48 ++++
 .../bpf/progs/cgroup_getset_retval_hooks.c    |  16 ++
 11 files changed, 380 insertions(+), 176 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c

-- 
2.37.1.595.g718a3a8f04-goog


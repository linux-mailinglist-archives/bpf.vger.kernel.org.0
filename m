Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D464059EF14
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 00:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiHWW0d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 18:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiHWW0F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 18:26:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD697870B1
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:25:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-337ed9110c2so218808827b3.15
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=5WRSLTvObHHgctoS7nR/CY7t4Pa/oq1MK06tILNSd7E=;
        b=OcdkxkdodY0zXpoUJmcYOXAZPvPxa5Jcvtav8wOn9IWfNE6F3Hk+43rO+p4oQNURPv
         mHlrKRn5O2AFYT23hOK0cK74ZSEMnDguGhoZuVf4zRtQi4ToKG7tRhKtOUw+06D4i4nS
         9jM/pyskJ1dBETB8hdeYacCHOjP/NAGJXkAygbLhR+DtZ+eD4O5ejRZqJqrivLBAEnJV
         T8vO53h4KB2ECRjqtdFHxxRhNLKpXQS9kfXRYKE0JYdMq8Zr8UDYo+KxUO7WbS7cGarD
         GD+81WtAiUG2X16UBvHO7kmRYnMyUrufuPPw6Aemu9Zdc9pc72XfdUafZvkkEMls9V/1
         zQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=5WRSLTvObHHgctoS7nR/CY7t4Pa/oq1MK06tILNSd7E=;
        b=G+NkGJI2E8L3rmfR4vJEIFp0s8fDckR55OaWw7vwLF1CPuofX/JjA4OTWq4zkAyqkI
         IVsFcCWP+awmd0M4UDVmzx/2vhFXM8+oW1olH1i1MDOmvzh7ZBmE+Vz3zEx3DsgxtR6V
         e8sGoP7BNcP31H0SI+zko6VY1I4ZMZyK0JITT66mZwtpRJIrljSFtALZbg6Gg9HPUrEI
         zYx5CjJFCTaVwkaVqaSK0KHifD5ayVSReTJOmPq9moeSzUNIHQICKZAbbzpuxeP9jFh1
         pVhJLfBcVQIN6UlVFpnsie+8Vkg7YB+DKK5mjwZkEDrHz5NvSB/Llk+YJrKf8i5WDU79
         CcDQ==
X-Gm-Message-State: ACgBeo3Eurn/zcAofVGGuAwHFAp4rLm3himmHBhC+eTH8cDHEMvvq47S
        Bs3pCwoFJK4pscCIhhIDbHiS3DFU7CF8SKGIwZX09bMJMyWSWUMqNt+eXIvt07w/ybSbYrUDCss
        hMzNJORw2dRMG9NEtM5yM6SrSS2UDBE3J6zy7iIpzeQkY0IwcxA==
X-Google-Smtp-Source: AA6agR5hvB0C+qN9uEjrMWakrsB2+PdreVxeMbHO3Wc7kkPwLY/DeFGq+nYwTPAzSyK/glKqr1o1res=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:4e10:0:b0:335:682f:9f41 with SMTP id
 c16-20020a814e10000000b00335682f9f41mr28546649ywb.381.1661293557069; Tue, 23
 Aug 2022 15:25:57 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:25:50 -0700
Message-Id: <20220823222555.523590-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v5 0/5] bpf: expose bpf_{g,s}et_retval to more cgroup hooks
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

v5:
- remove net/cls_cgroup.h include from patch 1/5 (Martin)
- move endif changes from patch 1/5 to 3/5 (Martin)
- don't define __weak protos, the ones in core.c suffice (Martin)

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
 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |  22 ++-
 kernel/bpf/bpf_lsm.c                          |  17 +-
 kernel/bpf/cgroup.c                           | 157 +++++++++++++++---
 kernel/bpf/helpers.c                          |  40 +----
 net/core/filter.c                             |  80 ++++-----
 tools/include/uapi/linux/bpf.h                |  22 ++-
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../bpf/cgroup_getset_retval_hooks.h          |  25 +++
 .../bpf/prog_tests/cgroup_getset_retval.c     |  48 ++++++
 .../bpf/progs/cgroup_getset_retval_hooks.c    |  16 ++
 12 files changed, 322 insertions(+), 124 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c

-- 
2.37.1.595.g718a3a8f04-goog


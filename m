Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824385915BD
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 21:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbiHLTCr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Aug 2022 15:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbiHLTCq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 15:02:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B142E7
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 12:02:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-32e6a92567bso14268377b3.10
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 12:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=XPk6FdjwBbwDgBh6u2eyiKeyBm8WmUk2D4CDTXFC/Hg=;
        b=Blx2XPNRZIFWzQtdxmhfEz7sMu3s8b/7TTxuTkMrGZPR333Sv5luoI9UBXalTAlywv
         JO8KYA0kuLJuoZ6ZXXKICDRqRXAuLkjeIpOeeDWwu/lCM9mEgsCQeOL1023M1G82Dlrx
         FjPmaJ4wRc/Plw2SIiqghxoQ61AHDsdqL/PBx7HodntpwZWNyESKHc8RYboRwLEolp7n
         ezbdosYn+Hu9vVmu/Myjy6Vwnx/UDMA1qr1ashqYFrFyGZzKbr0QEN6rWmbaCGdrR/hq
         HwLxYeW1HNq7eGPJ6ozhYmsrVWPPov2/M3sDfgWr5z72Zg1mKmtmPpRjI2e3vNKC9moL
         HYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=XPk6FdjwBbwDgBh6u2eyiKeyBm8WmUk2D4CDTXFC/Hg=;
        b=6Jto3KXS76Wsy/KnrZ83XJAFikO8ENj+wuN9WoJZdadAieXIquF01MD3KADIr0bUFT
         amQzOM3aFXnDKs5zs7yumF/MYSWyydC4NHd41k7rI1fk+paqCmua6UCC7OWk7csVkKIj
         5kmgO0nFvdou/pHWsYZj1iCTGekK71RjoLVkQjhcy6mWeu7XGoQkf/vl+0G4HLx4s8p+
         NiFf5dKkc2z/tzCfb2G2Phee/e5FLxW831OEyNp/StGgPBD8WlfQxnc9K7KFAqWeHu9T
         s4U/h1cF6aoo4OO7eBZa3WSYGkr+FsqVMFsr04yD1BtrfkTxr7mLIRf3RIWMCNPTVh3Q
         wfHw==
X-Gm-Message-State: ACgBeo1iP/eQVItrc+j4Q9ThDJvFqi/rnERbJcaXn/tFS/mPYloWyuYU
        +N9dswUxXbIzb0Pa0XqMdgoxt/2kYG23gDZbAnLUEEYPHUjLyxyGMBQWrizwd1bq7aPSmMzBMLp
        rBHTBRxRhwHVCPHPReJbiEocUdSirE7EzWaSpqEEm/Mp6Q4I4sw==
X-Google-Smtp-Source: AA6agR6In1reqqirhKy5enLlZ9LFRsX4bLO8QI0Nmp8gSIO3knDIBjJm2Gz/euizwqUYGh0vT2Tz98E=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:50d4:0:b0:31f:5f85:566a with SMTP id
 e203-20020a8150d4000000b0031f5f85566amr5000445ywb.218.1660330962896; Fri, 12
 Aug 2022 12:02:42 -0700 (PDT)
Date:   Fri, 12 Aug 2022 12:02:38 -0700
Message-Id: <20220812190241.3544528-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next 0/3] bpf: expose bpf_{g,s}et_retval to more cgroup hooks
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

Stanislav Fomichev (3):
  bpf: introduce cgroup_{common,current}_func_proto
  bpf: use cgroup_{common,current}_func_proto in more hooks
  selftests/bpf: make sure bpf_{g,s}et_retval is exposed everywhere

 include/linux/bpf.h                           | 16 +++
 kernel/bpf/cgroup.c                           | 82 +++++++--------
 kernel/bpf/helpers.c                          | 99 ++++++++++++++++++-
 net/core/filter.c                             | 78 ++++++---------
 tools/testing/selftests/bpf/Makefile          |  1 +
 .../bpf/cgroup_getset_retval_hooks.h          | 25 +++++
 .../bpf/prog_tests/cgroup_getset_retval.c     | 48 +++++++++
 .../bpf/progs/cgroup_getset_retval_hooks.c    | 16 +++
 8 files changed, 270 insertions(+), 95 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c

-- 
2.37.1.595.g718a3a8f04-goog


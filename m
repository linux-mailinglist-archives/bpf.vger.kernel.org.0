Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E935B4EBC
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 14:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiIKMXj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 08:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiIKMXi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 08:23:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20DD326EC
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 05:23:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c2-20020a1c3502000000b003b2973dafb7so8945478wma.2
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 05:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=fCy47mpYYKDHLo1OcJJS150dw1blb6Ea83EXe2B2GfE=;
        b=JzBCj+L/guJFgHN1WgGxvb6u3i40foUvBXlq1OWewZhSUSv80rU6HqKcoIshYXPoyE
         e0uC4VGRzuHnp6ZY6S9yzhsA3olTJcnlaaDP/mMjxvlmaqzi+T+b/iqJ7wVeDEq6taQ6
         vLGVs8Bw+eKCgOApwc391ZAUrGgk+RgwiJN5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=fCy47mpYYKDHLo1OcJJS150dw1blb6Ea83EXe2B2GfE=;
        b=bei05qLrXa0QChgKOlNZO4qcWkPtjq53YBFgtoHWzbbOKmdItRv1ByR9PNZPzCzLhb
         /gpv1L4lc68mJkb6gmIyY1u7dUEcoh5X8fBNbye0LIGzlPy0wA+yOyjog6Y2vlqAk9fP
         K8YXWkKppFVfd3qGHzKzwJdOEh9EGubadhIARPyjosmUifQww661uqaksCXMHqygPQy8
         M89SCHe63ztdA8lT5ULILVVJO84feNmhTQMA+TKyhsjyRJOXFMo7w9zS7iiFRAcoVqqj
         QYl1BKC1fFlTKd8mTEaiMfg79StRpnvHpbFEqCr/M0iFBNRmbOeRWGsChVNMxiz5YmXq
         i/Fw==
X-Gm-Message-State: ACgBeo0zsduC3RNT3x0H7Y47GJgumfNnWBGT8yMIP/GWYuWQ6ZREohJU
        NMOoM4wnek1Sw9BqePjrhWGg/VjFBwMUQKh2/MkKH33Y9G3Bb/7sxVkp/WwEzoMpQLhDSdzBHQK
        taf4I4lrbXCBeEesnszzsakxluTeplRpYf6ZPTWdbuvwObjHLkumm0zHNW5VzmuUsn40wWW7Y/k
        A=
X-Google-Smtp-Source: AA6agR69cd013APA82KMxlpN3JiP7noDCEEy59kJsntHQXI7y/qZ10BpzPmf4xJCyWqrPjllBfR3hQ==
X-Received: by 2002:a05:600c:190b:b0:3a5:f8a3:7abe with SMTP id j11-20020a05600c190b00b003a5f8a37abemr10950900wmq.81.1662899015865;
        Sun, 11 Sep 2022 05:23:35 -0700 (PDT)
Received: from blondie.home ([141.226.162.95])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b003a4f08495b7sm6538346wmq.34.2022.09.11.05.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 05:23:35 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v7 bpf-next 0/4] bpf: Support setting variable-length tunnel options
Date:   Sun, 11 Sep 2022 15:23:24 +0300
Message-Id: <20220911122328.306188-1-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce 'skb_set_tunnel_opt_dynptr' to allow setting tunnel options of
dynamic length.

v2:
- Place test_tunnel's local route in a custom table, to ensure the IP
  isn't considered assigned to a device.
v3:
- Avoid 'inline' for the __bpf_skb_set_tunopt helper function
v4:
- change API to be based on bpf_dynptr,
  suggested by John Fastabend <john.fastabend@gmail.com>
v5:
- fix bpf_dynptr_get_data's incorrect usage of bpf_dynptr_kern's size
  spotted by Joanne Koong <joannelkoong@gmail.com>
v6:
- Simplify bpf_dynptr_get_data's interface and make it inline
  suggested by John Fastabend <john.fastabend@gmail.com>
- Simplify bpf_skb_set_tunnel_opt_dynptr's interface, removing the
  superfluous 'len' parameter
  suggested by Andrii Nakryiko <andrii.nakryiko@gmail.com>
- Fix missing retcodes in progs/test_tunnel_kern.c
  spotted by John Fastabend <john.fastabend@gmail.com>
v7:
- Fix undefined reference to `bpf_dynptr_get_size' when CONFIG_BPF_SYSCALL
  is unset,
Reported-by: kernel test robot <lkp@intel.com>

Shmulik Ladkani (4):
  bpf: Export 'bpf_dynptr_get_data, bpf_dynptr_get_size' helpers
  bpf: Support setting variable-length tunnel options
  selftests/bpf: Simplify test_tunnel setup for allowing non-local
    tunnel traffic
  selftests/bpf: Add geneve with bpf_skb_set_tunnel_opt_dynptr test-case
    to test_progs

 include/linux/bpf.h                           |  13 ++
 include/uapi/linux/bpf.h                      |  11 +
 kernel/bpf/helpers.c                          |   2 +-
 net/core/filter.c                             |  31 ++-
 tools/include/uapi/linux/bpf.h                |  11 +
 .../selftests/bpf/prog_tests/test_tunnel.c    | 131 +++++++++--
 .../selftests/bpf/progs/test_tunnel_kern.c    | 212 ++++++++++++------
 7 files changed, 325 insertions(+), 86 deletions(-)

-- 
2.37.3


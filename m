Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1006DADC1
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 15:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbjDGNjb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 09:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjDGNj1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 09:39:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0D1AD38
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 06:39:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e18so42331133wra.9
        for <bpf@vger.kernel.org>; Fri, 07 Apr 2023 06:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1680874761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pox4hvdMwzxEobjiq290toIe3b0t8usEe650+0u+Rkg=;
        b=ZELFjg9WHzt/arTjAjKKvyySu5ONgaSZ+0S3cyIQc2j4Qq/f0BLAAGclCrkCKlWlr2
         hSz0peJcWTM/CkU4HKAQTSt77ObxTa3d4Ab0+WHo6+/3HzIyzVupEcPMfvrD6EPPD0jh
         rWbtbQaOrSXfHdGkte1OpIX07IZGyQksPVW6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680874761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pox4hvdMwzxEobjiq290toIe3b0t8usEe650+0u+Rkg=;
        b=FQDkMM08rtJ7NQX6+MoC7eD4TEXeyWzXZDAsYSHvxZmobG/oS4GsKjhS25G3u3LMNc
         B0CZPm1XSaBR3wNFALNTQuDNV+AVGz4jUhDME1/Otee8eiUGQ9yJQZQ4e10KlG1/pMy2
         N0t8Y0dtoULEFrf7nTklvr4/HmYyGtz47q4uy9MrIeKvWilAgEvOeblbtnCgVdDC5paH
         CYUNnVBnxcMWvl1V91pBMrV7ESFfhI3KhsYao44aS040sO3/6MDxrBPcvmbc9ncsKUnw
         JIUsk1OV7IyjOkOfhQndQPWxjJ6HvFosuOlB8Mgpkdmzt8LSfz80waItmCFGP58VmmdJ
         eKNA==
X-Gm-Message-State: AAQBX9evDTpv5YZ2pH3M+qP1TX1XhuPh+Da79xCT8E9l6+TDZBYkinr/
        KTjWr7OuFROZy7RO1Fksa7OYFQ7LuKe23mvsZ3IZmZ7H
X-Google-Smtp-Source: AKy350a0UCYaceM9euTsVoBonxjejDxiif/4/UKk8+FVs5IYVRLNpkmJw3Y3EugOWrGkfhUApH8PBg==
X-Received: by 2002:a5d:494f:0:b0:2e4:e489:c679 with SMTP id r15-20020a5d494f000000b002e4e489c679mr1374917wrs.10.1680874761530;
        Fri, 07 Apr 2023 06:39:21 -0700 (PDT)
Received: from workstation.ehrig.io (p4fdbfbb0.dip0.t-ipconnect.de. [79.219.251.176])
        by smtp.gmail.com with ESMTPSA id m13-20020a056000180d00b002efac42ff35sm2380188wrh.37.2023.04.07.06.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:39:20 -0700 (PDT)
From:   Christian Ehrig <cehrig@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     cehrig@cloudflare.com, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        David Vernet <void@manifault.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Kaixi Fan <fankaixi.li@bytedance.com>,
        KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, netdev@vger.kernel.org,
        Paul Chaignon <paul@isovalent.com>, Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next v3 0/3] Add FOU support for externally controlled ipip devices
Date:   Fri,  7 Apr 2023 15:38:52 +0200
Message-Id: <cover.1680874078.git.cehrig@cloudflare.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds support for using FOU or GUE encapsulation with
an ipip device operating in collect-metadata mode and a set of kfuncs
for controlling encap parameters exposed to a BPF tc-hook.

BPF tc-hooks allow us to read tunnel metadata (like remote IP addresses)
in the ingress path of an externally controlled tunnel interface via
the bpf_skb_get_tunnel_{key,opt} bpf-helpers. Packets can then be
redirected to the same or a different externally controlled tunnel
interface by overwriting metadata via the bpf_skb_set_tunnel_{key,opt}
helpers and a call to bpf_redirect. This enables us to redirect packets
between tunnel interfaces - and potentially change the encapsulation
type - using only a single BPF program.

Today this approach works fine for a couple of tunnel combinations.
For example: redirecting packets between Geneve and GRE interfaces or
GRE and plain ipip interfaces. However, redirecting using FOU or GUE is
not supported today. The ip_tunnel module does not allow us to egress
packets using additional UDP encapsulation from an ipip device in
collect-metadata mode.

Patch 1 lifts this restriction by adding a struct ip_tunnel_encap to
the tunnel metadata. It can be filled by a new BPF kfunc introduced
in Patch 2 and evaluated by the ip_tunnel egress path. This will allow
us to use FOU and GUE encap with externally controlled ipip devices.

Patch 2 introduces two new BPF kfuncs: bpf_skb_{set,get}_fou_encap.
These helpers can be used to set and get UDP encap parameters from the
BPF tc-hook doing the packet redirect.

Patch 3 adds BPF tunnel selftests using the two kfuncs.

---
v3:
 - Integrate selftest into test_progs (Alexei)
v2:
 - Fixes for checkpatch.pl
 - Fixes for kernel test robot

Christian Ehrig (3):
  ipip,ip_tunnel,sit: Add FOU support for externally controlled ipip
    devices
  bpf,fou: Add bpf_skb_{set,get}_fou_encap kfuncs
  selftests/bpf: Test FOU kfuncs for externally controlled ipip devices

 include/net/fou.h                             |   2 +
 include/net/ip_tunnels.h                      |  28 ++--
 net/ipv4/Makefile                             |   2 +-
 net/ipv4/fou_bpf.c                            | 119 ++++++++++++++
 net/ipv4/fou_core.c                           |   5 +
 net/ipv4/ip_tunnel.c                          |  22 ++-
 net/ipv4/ipip.c                               |   1 +
 net/ipv6/sit.c                                |   2 +-
 .../selftests/bpf/prog_tests/test_tunnel.c    | 153 +++++++++++++++++-
 .../selftests/bpf/progs/test_tunnel_kern.c    | 117 ++++++++++++++
 10 files changed, 432 insertions(+), 19 deletions(-)
 create mode 100644 net/ipv4/fou_bpf.c

-- 
2.39.2


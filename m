Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6636C3975
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 19:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjCUSql (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 14:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCUSqa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 14:46:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4389F5651D
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:45:49 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o2so9606384plg.4
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679424348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ry0HKca0xdvBhNGOZmAmHVj5EjeKBoQg8ueUPsfqq58=;
        b=HVnqSBaP5shvsPkqzN9bc+hrGoFbP9o0y8W2lNXtxaNEXIJNr/2V37if5lO2fUE0d/
         iNtXzGn//4anelkY/CtuW/NwuOiWSmGoGj/GXGM95Y9Vy2bAzEqTq0t7r9VFt0BOen0D
         aKTFnI7qZiWxNBayj/BHismjsDl2/6N9wJLYm5jAQuh+sVcDzBtsmJPpaR5B0U6+uVxN
         GMZNjlHNMc9MRLrgBjwNBqprTTV4uPxq88EMG1WsOIdtF3U61TSu70HG5TaKXgNZ8buA
         cOIpEPpBo86sCoE15BDhQb6yfbRqeXXgj8RXdrncqkjUsNxwHfv3ABqV3+jPWUOducsy
         grzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ry0HKca0xdvBhNGOZmAmHVj5EjeKBoQg8ueUPsfqq58=;
        b=lNgOypMhqjWKVknNhA3e88pfr8ER3oMHTz2AyPPHAkcjhkiHAfG1ScP5p299nsx0zT
         mhsgI9pxq4Gz1UFL4rkaW0eaU5uwfFCb7MRqFL0GnjlhcdvDxyhSIh86y2LvVuRMbivl
         1CpxS0Oo9oSBDkI/77YYpPmHa8Lmm9bbt/O0C0T62spPqL0zgXjXuy8qQ5QJ2cMh7v6G
         p+Ks+OtIk4quW05oZzjEGJTxM3M+eY5koi6dVAdf1broeuuFdrMbnC1XhiAqUzO3oUw9
         bnk4pxjzf619cDQjMWYEAZ/FibFUIKthp72yi/IHDynQtfFQD4GcR7DSsDXkeKNgNuce
         Ugyw==
X-Gm-Message-State: AO0yUKXpchkU+latB5vVQx+JdCxi1Vama2esoVO+wlv5ODha5/OHnMTn
        FKj2sGZMkd0dWAUIh+EXa2c5w2Jr1ar/QnpP9Jc=
X-Google-Smtp-Source: AK7set/7k6L8/5lMju9Z2FaG/Qfhh02CdX0jfmyMPj4FwB9gGzXkt/2gmtWLzfVXctG20qW3A17ceQ==
X-Received: by 2002:a17:90b:1e42:b0:23d:39e0:13b with SMTP id pi2-20020a17090b1e4200b0023d39e0013bmr579629pjb.43.1679424347649;
        Tue, 21 Mar 2023 11:45:47 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c15500b0019cf747253csm9095878plj.87.2023.03.21.11.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:45:47 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH v3 bpf-next 0/5] bpf-next: Add socket destroy capability
Date:   Tue, 21 Mar 2023 18:45:36 +0000
Message-Id: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds the capability to destroy sockets in BPF. We plan to use
the capability in Cilium to force client sockets to reconnect when their
remote load-balancing backends are deleted. The other use case is
on-the-fly policy enforcement where existing socket connections prevented
by policies need to be terminated.

The use cases, and more details around
the selected approach was presented at LPC 2022 -
https://lpc.events/event/16/contributions/1358/.
RFC discussion -
https://lore.kernel.org/netdev/CABG=zsBEh-P4NXk23eBJw7eajB5YJeRS7oPXnTAzs=yob4EMoQ@mail.gmail.com/T/#u.
v2 patch series -
https://lore.kernel.org/bpf/20230223215311.926899-1-aditi.ghag@isovalent.com/T/#t

v3 highlights:
- Martin's review comments:
  - UDP iterator batching patch supports resume operation.
  - Removed "full_sock" check from the destroy kfunc.
  - Reset of metadata in case of rebatching.
- Extended selftests to cover cases for destroying listening sockets.
- Fixes for destroying listening TCP and UDP sockets.
- Stan's review:
  - Refactored selftests to use ASSERT_* in lieu of CHECK.
  - Free leaking afinfo in fini_udp.
- Restructured test cases per Andrii's comment.

Notes to the reviewers:

- There are two RFC commits for being able to destroy listening TCP and
  UDP sockets. The TCP commit isn't quite correct, as inet_unhash could
  be invoked from BPF context for cases other than iterator.
  The UDP commit seems reasonable based on my understanding of the code,
  but it may lead to unintended behavior when there are sockets
  listening on wildcard and specific address with a common port.
  I would appreciate insights into both the commits, as I'm not
  intimately familiar with some of the overall code path.

(Below notes are same as v2 patch series.)
- I hit a snag while writing the kfunc where verifier complained about the
  `sock_common` type passed from TCP iterator. With kfuncs, there don't
  seem to be any options available to pass BTF type hints to the verifier
  (equivalent of `ARG_PTR_TO_BTF_ID_SOCK_COMMON`, as was the case with the
  helper).  As a result, I changed the argument type of the sock_destory
  kfunc to `sock_common`.

- The `vmlinux.h` import in the selftest prog unexpectedly led to libbpf
  failing to load the program. As it turns out, the libbpf kfunc related
  code doesn't seem to handle BTF `FWD` type for structs. I've attached debug
  information about the issue in case the loader logic can accommodate such
  gotchas. Although the error in this case was specific to the test imports.

Aditi Ghag (5):
  bpf: Implement batching in UDP iterator
  bpf: Add bpf_sock_destroy kfunc
  [RFC] net: Skip taking lock in BPF context
  [RFC] udp: Fix destroying UDP listening sockets
  selftests/bpf: Add tests for bpf_sock_destroy

 include/net/udp.h                             |   1 +
 net/core/filter.c                             |  54 ++++
 net/ipv4/inet_hashtables.c                    |   9 +-
 net/ipv4/tcp.c                                |  16 +-
 net/ipv4/udp.c                                | 283 +++++++++++++++++-
 .../selftests/bpf/prog_tests/sock_destroy.c   | 190 ++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   | 151 ++++++++++
 7 files changed, 684 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c

-- 
2.34.1


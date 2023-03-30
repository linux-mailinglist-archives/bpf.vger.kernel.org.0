Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252AE6D0946
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 17:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjC3PTk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 11:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjC3PTj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 11:19:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B37BCC36
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 08:18:32 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso19944407pjb.3
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680189494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFKfcwfWFwx7skGE0Rxm6dEGji3nQu77Efov4tDzlv4=;
        b=JUltwBBqOol8AjZOiUbzaPfGl7C7ESTGcCayAdwyAzOw1zniUQQ9BwL6PezIvIiRuJ
         fMzwyar1UEZ7HxOJelAClH7Ba2JFll3AsKezGirW54w+xBZrBUHCE2R/wSFo4XjZS2VF
         sZulJ5PzCkbb6jFMYbHMz/W5mK1k/J/OXgTHYvpBhfi+csfFrH7Pt/kStL56/bGKPnwM
         9ft11JHvTo6l2IfufdXm1jZ7w0h1m7Ni+d9O50niimlTIDNf8N6oEGE4ZEgbsC5i6yk9
         /Y3bfiHpDQsH26WnyjfQGmrPS8ZyHOYPqISN/vNBRj8IIDJ3Pjcal2uAeow8iMfLU7PP
         i7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680189494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFKfcwfWFwx7skGE0Rxm6dEGji3nQu77Efov4tDzlv4=;
        b=Fea9tQy3+WqDFZQJC5abPp+vUHABhwxLCLATRdDLahnR1uCTm/4rBlWQDsf98jBGtR
         M2ogURWB6rmVfs/UBlXitOUssEFDqNvx/ucE2lCD3u5b65cpfgV7/RKiL46NLC1yUhRd
         HED/5QKOUKapVRTIo6fL/s3WlRC0i9EjwJ86b6nuKBgkwG92RhHln9IPjCmA3o059hRz
         4+HyLhoaar80kNFLz+KHiCBqe1lAKjfgMR93V0J789Vsaq9LKEA2J5l5xgwspYxeO0mz
         CwsN4CxeN3h17rSjqiE3g1GBnXlzkHW6ihag2OTbARG74gxWhAFGfCP/a+tzyucItl+C
         arxw==
X-Gm-Message-State: AO0yUKVDolFC9bkTUPDTol46jlF7r2jpFPhhSuZQu/9cII5s7BKnbxt/
        W9+kdDtzU0E0+GKvsVfg4mjVqlV9ubkuDs+4Zm0=
X-Google-Smtp-Source: AK7set/2FWBJ1KFe8vjVCdzLAEfvKj9KXJu0omab4TsnvIrX1ZifDTOZbkiTuBknpzeeMwP+adMuPQ==
X-Received: by 2002:a05:6a20:6597:b0:da:eebd:7f6c with SMTP id p23-20020a056a20659700b000daeebd7f6cmr19312813pzh.56.1680189493529;
        Thu, 30 Mar 2023 08:18:13 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id f17-20020a63de11000000b004fc1d91e695sm23401177pgg.79.2023.03.30.08.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:18:12 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH v5 bpf-next 0/7] bpf: Add socket destroy capability
Date:   Thu, 30 Mar 2023 15:17:51 +0000
Message-Id: <20230330151758.531170-1-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
the selected approach were presented at LPC 2022 -
https://lpc.events/event/16/contributions/1358/.
RFC discussion -
https://lore.kernel.org/netdev/CABG=zsBEh-P4NXk23eBJw7eajB5YJeRS7oPXnTAzs=yob4EMoQ@mail.gmail.com/T/#u.
v4 patch series -
https://lore.kernel.org/bpf/20230323200633.3175753-1-aditi.ghag@isovalent.com/T/#t

v5 highlights:
Address review comments:
Martin:
- Fixed bugs in the resume operation for UDP iterator.
- Added clean-up preparatory commits prior to the batching commit.
Stan:
- Programmatically retrieve and share server port in the selftests.
- Acquire slow sock lock in UDP iterator to be consistent with TCP.
- Addressed formatting nits.

(Below notes are same as v2 patch series that are still relevant. Refer to
earlier patch series for other notes.)
- I hit a snag while writing the kfunc where verifier complained about the
  `sock_common` type passed from TCP iterator. With kfuncs, there don't
  seem to be any options available to pass BTF type hints to the verifier
  (equivalent of `ARG_PTR_TO_BTF_ID_SOCK_COMMON`, as was the case with the
  helper).  As a result, I changed the argument type of the sock_destory
  kfunc to `sock_common`.

Aditi Ghag (7):
  bpf: tcp: Avoid taking fast sock lock in iterator
  udp: seq_file: Remove bpf_seq_afinfo from udp_iter_state
  udp: seq_file: Helper function to match socket attributes
  bpf: udp: Implement batching for sockets iterator
  bpf: Add bpf_sock_destroy kfunc
  selftests/bpf: Add helper to get port using getsockname
  selftests/bpf: Test bpf_sock_destroy

 include/net/udp.h                             |   1 -
 net/core/filter.c                             |  54 ++++
 net/ipv4/tcp.c                                |  10 +-
 net/ipv4/tcp_ipv4.c                           |   5 +-
 net/ipv4/udp.c                                | 286 +++++++++++++++---
 tools/testing/selftests/bpf/network_helpers.c |  14 +
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/sock_destroy.c   | 203 +++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   | 147 +++++++++
 9 files changed, 676 insertions(+), 45 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c

-- 
2.34.1


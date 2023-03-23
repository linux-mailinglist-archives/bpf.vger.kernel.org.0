Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6696C7185
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 21:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCWUGy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 16:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWUGx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 16:06:53 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3E222DEA
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 13:06:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id iw3so23343789plb.6
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 13:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679602011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jsRjdfUTmaQMNuXglX2q56ZRLu+a1FK4t5k0vSLZDo8=;
        b=WJGX8kkpJxfH0psNr+2A2i1mAIo23NG/iEE9f4wVF4s16iY7wWmId3xxasWhuvWka4
         O1CosRVIuBOcNHNe/h9z+Im0BoY+jZz9cBxznTL6bx7dTMX7mSRjJYrq80LIGMlswVSO
         wgkFUyDhXgYmHzdOE+3MaCT4K5VtgCbBJDK9/vcAvohgVBkaZ3VIUCcrHGXQ/6CX2ixA
         I/2/fPVdyl6RiY2++jqc9p+azov50V5ac4RVnleVvhElCiK/jQwxZv7yV/XVy6t9LKTP
         8I27gWos5DuXUo/bNFT7r1ATpm9SeuiTB1kYwfMCVSzNP4Sw5YwJW0tTaJqPGzVuo0er
         Nkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679602011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsRjdfUTmaQMNuXglX2q56ZRLu+a1FK4t5k0vSLZDo8=;
        b=SveyQcZzTxtGtnRg2hLO/8bwQuba0PC5/Clm0sl9EwzyNTulct8iboajuvxhJr2Fkg
         aF/LpgFCYe52siegUoO+l3tc9HJWTwyxAuFzbCZ/gWU1dJJPGl9MMgRVbpTNTmKb6/cI
         UhAyz7dgUg1xeEwU10sprpEl6RiPZA+XU/QBAqHM4a+3jdChF+Vh7bh9Z2ePBy/BHwTp
         X1U5KsqOxR0jxJNuLIRT1HX2niQw+vLkzkbTpPOGq/1nIi9Bp0+W1uc710lTCxeo3t7c
         L2/e4r6xNOkYHwPPVpGCS0sP4NOERzaSDQhYMjsiXGs5h5ANMzzTCkTw02WmnB0DuKzM
         /PEg==
X-Gm-Message-State: AAQBX9dINWdGDzbV7VW3dZ95QG3nh2TrTla+YwxOLw+BwjkUjjfBnW6I
        CptleYvaUdklKC/TyH8hvZ/wUPjnAiEzC6NC4XA=
X-Google-Smtp-Source: AKy350Z9138h1yRuH1DDxoGWmECKkDLsl//zJ2+DvjLjr1H96u3TdNEwtwP/qRbKxRZTunzFv8j4NQ==
X-Received: by 2002:a17:902:dac1:b0:1a1:f95a:24f2 with SMTP id q1-20020a170902dac100b001a1f95a24f2mr161801plx.19.1679602011000;
        Thu, 23 Mar 2023 13:06:51 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id j12-20020a17090276cc00b0019aaab3f9d7sm12701698plt.113.2023.03.23.13.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 13:06:50 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH v4 bpf-next 0/5] bpf-nex: Add socket destroy capability
Date:   Thu, 23 Mar 2023 20:06:29 +0000
Message-Id: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
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
the selected approach was presented at LPC 2022 -
https://lpc.events/event/16/contributions/1358/.
RFC discussion -
https://lore.kernel.org/netdev/CABG=zsBEh-P4NXk23eBJw7eajB5YJeRS7oPXnTAzs=yob4EMoQ@mail.gmail.com/T/#u.
v2 patch series -
https://lore.kernel.org/bpf/20230223215311.926899-1-aditi.ghag@isovalent.com/T/#t

v4 highlights:
- Updated locking in BPF TCP iterator.
- Adapted *-server selftests similar to the client selftests per the
  discussions.
- Addressed Stan's comment to revert skipping spin locks in tcp_abort.
- Dropped the fix to unhash UDP sockets during abort.
- Moved the iterator resume related changes to the right commit. 

(Below notes are same as last patch series.)
- I hit a snag while writing the kfunc where verifier complained about the
  `sock_common` type passed from TCP iterator. With kfuncs, there don't
  seem to be any options available to pass BTF type hints to the verifier
  (equivalent of `ARG_PTR_TO_BTF_ID_SOCK_COMMON`, as was the case with the
  helper).  As a result, I changed the argument type of the sock_destory
  kfunc to `sock_common`.


Aditi Ghag (4):
  bpf: Implement batching in UDP iterator
  bpf: Add bpf_sock_destroy kfunc
  bpf,tcp: Avoid taking fast sock lock in iterator
  selftests/bpf: Add tests for bpf_sock_destroy

 include/net/udp.h                             |   1 +
 net/core/filter.c                             |  54 ++++
 net/ipv4/tcp.c                                |  10 +-
 net/ipv4/tcp_ipv4.c                           |   5 +-
 net/ipv4/udp.c                                | 261 +++++++++++++++++-
 .../selftests/bpf/prog_tests/sock_destroy.c   | 195 +++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   | 151 ++++++++++
 7 files changed, 660 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c

-- 
2.34.1


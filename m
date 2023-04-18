Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D3E6E6825
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 17:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjDRPcD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 11:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjDRPcC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 11:32:02 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680BFDB
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 08:31:59 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51fe0a4afdcso374323a12.2
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681831918; x=1684423918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIDzXyyEhVv1BciPOJpSNrxXXkTgd4yNJmqlw3RoVqc=;
        b=VxiQlltgkhn+6gVeM29oIc/mC5ITN1g3yIG0+U7SHxPyFF5pxLEj0JNe0eA8XlS/Qk
         YNwCqmsynO8PwZmLY77sb5zpsa+CPagQ5rukMrBn3BTdCq0azNpTCRCqR0UdXKzXkvet
         u1+6UYYca2cJSI6+f/PQzxNpnhMhYPWlk6TBIqYAB6+9vlDCpMbi1wlUquOvfAu9sYiy
         SAyNmH754m7skTHXU2kd4awqx97O5O9tWiFFIpWcUl2WJQkPKaAhOhiAyW5QFPdrEkbY
         pVU+VCFvmkjhGHOnF1RSCH+V133ic7I86myMUtHEYbt3x8IL9RbblxaBA1sR/vrQqT7U
         KH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681831918; x=1684423918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIDzXyyEhVv1BciPOJpSNrxXXkTgd4yNJmqlw3RoVqc=;
        b=U+CiL8Kf+VKzRAVktYDFAGL2qLD/x4HNLlAE6hma3MwfYj7qDWc7jI5tqGjTQf09pE
         1WxlGGWqu2fpdZrVwBUexYBkMmageGS+6AjaonTccyzO3Px/wXit6viTiL++eomSBP+v
         pUkn0ebF2oV9J6Pf4XjliZ6zf3KIA0BhAHQnyOeKEpoIPUqRBJraWwjcEsha5QE9tj1e
         IL8hAGqB0Ds3UW5mxH2/VBa+OUO8CWAfyxpE/CP22a1teH0DcVwygf3I21/UJqeJz050
         1nnfRpvYP/QrrdlNZKn/SAOIi5mOh5fxh5jeNjp5R5YFugkUmiu7W+UOBe4Mj7y15qGV
         5Mbg==
X-Gm-Message-State: AAQBX9fnhBo2FfCgTMYtknWE2Uu4jQc1KCpFJcNL3CRR5ji5toegzSOJ
        G/S6kDpdowO8F9Xl1uVVwSCi6/hcY3H6CTwLYbs=
X-Google-Smtp-Source: AKy350Yx1/EvaupRMVp6nN+79CPAmjNmeY2ENt3m0wnmWxNRsraL8Sn7D7uay4avty+hOdLhxhufNw==
X-Received: by 2002:a17:902:fa4e:b0:1a6:d8a3:3346 with SMTP id lb14-20020a170902fa4e00b001a6d8a33346mr2208831plb.31.1681831918433;
        Tue, 18 Apr 2023 08:31:58 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id ba4-20020a170902720400b001a647709864sm9769630plb.155.2023.04.18.08.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:31:57 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH v6 bpf-next 0/7] bpf: Add socket destroy capability
Date:   Tue, 18 Apr 2023 15:31:41 +0000
Message-Id: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
v5 patch series -
https://lore.kernel.org/bpf/20230330151758.531170-1-aditi.ghag@isovalent.com/

v6 highlights:
Address review comments:
Martin:
- Simplified UDP batching iterator logic.
- Run tests in a separate netns.
Stan:
- Make destroy handler checks opt-in.
- Extended network helper to get socket port for v4.
kernel test robot:
- Updated seq_sk_match and seq_file_family with the necessary ifdefs.

(Below notes are same as v5 patch series that are still relevant. Refer to
earlier patch series for other notes.)
- I hit a snag while writing the kfunc where verifier complained about the
  `sock_common` type passed from TCP iterator. With kfuncs, there don't
  seem to be any options available to pass BTF type hints to the verifier
  (equivalent of `ARG_PTR_TO_BTF_ID_SOCK_COMMON`, as was the case with the
  helper).  As a result, I changed the argument type of the sock_destory
  kfunc to `sock_common`.
- Martin's patch restricts the helper to only BPF iterators -
  https://lore.kernel.org/bpf/20230404060959.2259448-1-martin.lau@linux.dev/.
  Applied, and tested the patch locally.


Aditi Ghag (7):
  bpf: tcp: Avoid taking fast sock lock in iterator
  udp: seq_file: Remove bpf_seq_afinfo from udp_iter_state
  udp: seq_file: Helper function to match socket attributes
  bpf: udp: Implement batching for sockets iterator
  bpf: Add bpf_sock_destroy kfunc
  selftests/bpf: Add helper to get port using getsockname
  selftests/bpf: Test bpf_sock_destroy

 include/net/udp.h                             |   1 -
 net/core/filter.c                             |  57 ++++
 net/ipv4/tcp.c                                |  10 +-
 net/ipv4/tcp_ipv4.c                           |   5 +-
 net/ipv4/udp.c                                | 269 +++++++++++++++---
 tools/testing/selftests/bpf/network_helpers.c |  28 ++
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/sock_destroy.c   | 217 ++++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   | 147 ++++++++++
 9 files changed, 690 insertions(+), 45 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c

-- 
2.34.1


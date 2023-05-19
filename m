Return-Path: <bpf+bounces-974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5158570A2E9
	for <lists+bpf@lfdr.de>; Sat, 20 May 2023 00:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9017E281BF6
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 22:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1541FBD;
	Fri, 19 May 2023 22:52:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402F710E2
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 22:52:06 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1FA118
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ae3ed1b0d6so27647615ad.3
        for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684536722; x=1687128722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u8zenqCjdKaKcVVfhG1/cpSpN0VlDESzPf3tPoflfhs=;
        b=K60tZGP64A69YWOORqP5fON1ByE1yrfBTM9RKvkQz46y7Eqr/99hUBJxji8QCqCYBv
         rVpR07dQ53g/6G40DH4iFhGx9H8tVzbDsBs3qs2QbKwCHxO+SXprHJyX13u0v/5iUEer
         XoZwK2EaCKUwiVyBCE8pa8Er52RLxjG/nVpw7U+btLZ5IrLBonGfkOCFdQ7RUAZib2Cx
         xTnh99u//g2p7SyX890y0BXHVB3maKSY0zm18NIbuMF2TVHQIEtCdUFfsfWc6xdrFBzK
         54rg2xvLKVbIzZrRQU81wOkKitKoM4txr5X828DlfkQckWBQZA89xBPi8qr+9gvshOa3
         xjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684536722; x=1687128722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8zenqCjdKaKcVVfhG1/cpSpN0VlDESzPf3tPoflfhs=;
        b=WoSpy7FkS8eQ5WFJYAASH2tmWEgF0g7MCAzt6POfZIbIFqWbz+uqssUJ7GFox/HMX1
         8MplmwlhrkbhWZMJKLrZm828HROjJWl2JfSHCz7OZjbIRI216tDM+Ed/a2GybYaGD0Cs
         r3wxfKdg6zePa6uDqJqV8J+OM745DNQOS93fEqThW9dl5pin/LHBybLjcydM1mC60JdB
         Pv9M6PkFok+KEm1UPeOcjHcSSPxCkMesOg/lPiNgmuEN11qg85grAWxogHALiqUKWzAI
         HuPOv68MWx6iAhZ7aWBJFbHIz4uJETWE74fraJ31JthvoI8eMrnq3tsmxJsg1sRChNd0
         o8SA==
X-Gm-Message-State: AC+VfDxYdyaytMHa3MCQFtkdY+LoC2BZSkTEHaBrNML8iw6k7RS+p0/T
	9+eoQT63shSx3d3y1wBlj2t9fkjagt5XMvPZuAk=
X-Google-Smtp-Source: ACHHUZ62EzC24zNRoWPZovphClBMP9n1Qy2CyNjnU4tr6Th8TOsiLeWKtUh9Up4KhWGnP6ch0w1Gtw==
X-Received: by 2002:a17:902:ab14:b0:1ae:50cc:45b with SMTP id ik20-20020a170902ab1400b001ae50cc045bmr4054003plb.36.1684536722609;
        Fri, 19 May 2023 15:52:02 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c08400b001a6ed2d0ef8sm117880pld.273.2023.05.19.15.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 15:52:02 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com
Subject: [PATCH v9 bpf-next 0/9] bpf: Add socket destroy capability
Date: Fri, 19 May 2023 22:51:48 +0000
Message-Id: <20230519225157.760788-1-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch set adds the capability to destroy sockets in BPF. We plan to
use the capability in Cilium to force client sockets to reconnect when
their remote load-balancing backends are deleted. The other use case is
on-the-fly policy enforcement where existing socket connections
prevented by policies need to be terminated.

The use cases, and more details around
the selected approach were presented at LPC 2022 -
https://lpc.events/event/16/contributions/1358/.
RFC discussion -
https://lore.kernel.org/netdev/CABG=zsBEh-P4NXk23eBJw7eajB5YJeRS7oPXnTAzs=yob4EMoQ@mail.gmail.com/T/#u.
v8 patch series -
https://lore.kernel.org/bpf/20230517175359.527917-1-aditi.ghag@isovalent.com/

v9 highlights:
Address review comments:
Martin:
- Rearranged the kfunc filter patch, and added the missing break
  statement.
- Squashed the extended selftest/bpf patch.
Yonghong:
- Revised commit message for patch 1.

(Below notes are same as v8 patch series that are still relevant. Refer to
earlier patch series versions for other notes.)
- I hit a snag while writing the kfunc where verifier complained about the
  `sock_common` type passed from TCP iterator. With kfuncs, there don't
  seem to be any options available to pass BTF type hints to the verifier
  (equivalent of `ARG_PTR_TO_BTF_ID_SOCK_COMMON`, as was the case with the
  helper).  As a result, I changed the argument type of the sock_destory
  kfunc to `sock_common`.


Aditi Ghag (9):
  bpf: tcp: Avoid taking fast sock lock in iterator
  udp: seq_file: Helper function to match socket attributes
  bpf: udp: Encapsulate logic to get udp table
  udp: seq_file: Remove bpf_seq_afinfo from udp_iter_state
  bpf: udp: Implement batching for sockets iterator
  bpf: Add kfunc filter function to 'struct btf_kfunc_id_set'
  bpf: Add bpf_sock_destroy kfunc
  selftests/bpf: Add helper to get port using getsockname
  selftests/bpf: Test bpf_sock_destroy

 include/linux/btf.h                           |  18 +-
 include/net/udp.h                             |   1 -
 kernel/bpf/btf.c                              |  61 +++-
 kernel/bpf/verifier.c                         |   7 +-
 net/core/filter.c                             |  63 ++++
 net/ipv4/tcp.c                                |   9 +-
 net/ipv4/tcp_ipv4.c                           |   7 +-
 net/ipv4/udp.c                                | 291 +++++++++++++++---
 tools/testing/selftests/bpf/network_helpers.c |  23 ++
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/sock_destroy.c   | 221 +++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   | 145 +++++++++
 .../bpf/progs/sock_destroy_prog_fail.c        |  22 ++
 13 files changed, 791 insertions(+), 78 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c

-- 
2.34.1



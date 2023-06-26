Return-Path: <bpf+bounces-3454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B9073E2D7
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 17:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EDA1C20A90
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32392BA39;
	Mon, 26 Jun 2023 15:09:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4B6AD5D
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 15:09:16 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD75ED3
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 08:09:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-313e1c27476so1811743f8f.1
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687792152; x=1690384152;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZOVpA71i/AmTOr0v+BW3r06CAsw8oH2AC2V9/+6+As=;
        b=GdsYVkur6vkSIf0v6Fb43unznX4XRRgVC0nO8m3/Wvzo43eywYYD8cZIE10xszPHYD
         qtL+X/ISsd3Nbz35oFyQxCqeKX8UiDW3l2JYhjuGxmEtE7QYDkJNOA5G52xZ6ovYdyxJ
         T4PNAA9bWvRyX1HUH+rYROW+GZ5SJ3ZaceXUxz4EcRCbNOq7/0HMoVIccaopzDgsS6ZT
         qUqFPFXp7cdwD/5KUM1U3Wa9d0hqaWF4EwNWUnTaPWFOOS3yW7eFl0to57i7wRWlpd0z
         gRu0/k26VreSnSLNRdz5smGVftdT87VaSVGsTU3loSxOK+rSn7V8oUbYSOcZKf3DH+aM
         bjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687792152; x=1690384152;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZOVpA71i/AmTOr0v+BW3r06CAsw8oH2AC2V9/+6+As=;
        b=TrxTTpawGQuYvI0miWSmuJV8+0shQPr8c9qCPcGFAPfXKxZuWV7xJe7RNqc8vkknh8
         NhloSxnaj7D9yw1FvpVrZAFIYknUSHdqHZScaEQgeo57QxMTfTriHr5uc4qO/hee3aUo
         ChP6ekAoXvA6ezXrTfzlPFZ8TX7jg2+OsqeTSNutDm5jCLsn5shdJgpXVMeNKY27ziEs
         NI2PRo+hkY/4uPgZqBa58OErcjQyw8denVYfKizH4s8jMPTzYSfp1PkH98clXEsnB+qI
         V5M1VK/fBPBo+x5q1SO2gFN8wMkL4pcdST/SbmU8qTEhtRUbk2ZQ+lQN8MM9WTAEokZ0
         +BPg==
X-Gm-Message-State: AC+VfDzByNAMhIMkioFBRruCh7nBdXRgWsgsCeY11RzShyBORkSpXkAD
	nJiWOM4D3ssIcTw3OJkYEwCpQQ==
X-Google-Smtp-Source: ACHHUZ7RHNZDCoPo174rAheI28qWcIkZjyKzfraeQtsbeiQnL7uXSNAtSOPnpXuirEpaYXMI0vMHeA==
X-Received: by 2002:a5d:61c9:0:b0:313:f5ea:44f7 with SMTP id q9-20020a5d61c9000000b00313f5ea44f7mr1418213wrv.35.1687792152332;
        Mon, 26 Jun 2023 08:09:12 -0700 (PDT)
Received: from [192.168.1.193] (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id v1-20020adfe281000000b00311299df211sm7668710wri.77.2023.06.26.08.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:09:12 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH bpf-next v3 0/7] Add SO_REUSEPORT support for TC
 bpf_sk_assign
Date: Mon, 26 Jun 2023 16:08:57 +0100
Message-Id: <20230613-so-reuseport-v3-0-907b4cbb7b99@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAmqmWQC/22OwQ6CMBBEf4Xs2TXQKgRP/ofh0NZFmmjbdGuDI
 fy7hZMHj5M3kzcLMEVLDJdqgUjZsvWuBHmowEzKPQjtvWQQtZB120hkj5HeTMHHhNQLcxZt00k
 iKBOtmFBH5cy0jX67Gw6RRjvvthvoMKKjOcFQyGQ5+fjZb2Sx8//GLLBG3Zm2V/JUzPJq2Wf1J
 JeOxr9gWNf1C0IJORzVAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Joe Stringer <joe@wand.net.nz>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>, 
 Joe Stringer <joe@cilium.io>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We want to replace iptables TPROXY with a BPF program at TC ingress.
To make this work in all cases we need to assign a SO_REUSEPORT socket
to an skb, which is currently prohibited. This series adds support for
such sockets to bpf_sk_assing.

I did some refactoring to cut down on the amount of duplicate code. The
key to this is to use INDIRECT_CALL in the reuseport helpers. To show
that this approach is not just beneficial to TC sk_assign I removed
duplicate code for bpf_sk_lookup as well.

Changes from v1:
- Correct commit abbrev length (Kuniyuki)
- Reduce duplication (Kuniyuki)
- Add checks on sk_state (Martin)
- Split exporting inet[6]_lookup_reuseport into separate patch (Eric)

Joint work with Daniel Borkmann.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
Changes in v3:
- Fix warning re udp_ehashfn and udp6_ehashfn (Simon)
- Return higher scoring connected UDP reuseport sockets (Kuniyuki)
- Fix ipv6 module builds
- Link to v2: https://lore.kernel.org/r/20230613-so-reuseport-v2-0-b7c69a342613@isovalent.com

---
Daniel Borkmann (1):
      selftests/bpf: Test that SO_REUSEPORT can be used with sk_assign helper

Lorenz Bauer (6):
      udp: re-score reuseport groups when connected sockets are present
      net: export inet_lookup_reuseport and inet6_lookup_reuseport
      net: document inet[6]_lookup_reuseport sk_state requirements
      net: remove duplicate reuseport_lookup functions
      net: remove duplicate sk_lookup helpers
      bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign

 include/net/inet6_hashtables.h                     |  84 ++++++++-
 include/net/inet_hashtables.h                      |  77 +++++++-
 include/net/sock.h                                 |   7 +-
 include/net/udp.h                                  |   8 +
 include/uapi/linux/bpf.h                           |   3 -
 net/core/filter.c                                  |   2 -
 net/ipv4/inet_hashtables.c                         |  70 +++++---
 net/ipv4/udp.c                                     |  88 ++++-----
 net/ipv6/inet6_hashtables.c                        |  73 +++++---
 net/ipv6/udp.c                                     |  98 ++++------
 tools/include/uapi/linux/bpf.h                     |   3 -
 tools/testing/selftests/bpf/network_helpers.c      |   3 +
 .../selftests/bpf/prog_tests/assign_reuse.c        | 197 +++++++++++++++++++++
 .../selftests/bpf/progs/test_assign_reuse.c        | 142 +++++++++++++++
 14 files changed, 676 insertions(+), 179 deletions(-)
---
base-commit: 970308a7b544fa1c7ee98a2721faba3765be8dd8
change-id: 20230613-so-reuseport-e92c526173ee

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>



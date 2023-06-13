Return-Path: <bpf+bounces-2492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540EA72DF1B
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 12:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3AE28152C
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 10:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3593C0AC;
	Tue, 13 Jun 2023 10:15:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1132D26D
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 10:15:03 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2AC188
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 03:15:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so5265564f8f.1
        for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 03:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1686651298; x=1689243298;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E2rY2E6D+8oZww/s6pZwAJAnOm0HX7caGb8hYSApwkk=;
        b=N2eh1qFFzWhwKedcB6rJTdohEMIovo8r4HL1dbMAK7fCafO8iorJVG7M/yIW0+4wKn
         0iXMYd/OYFcWPYfnfRVxLTpMjKMUvMwWqaiG7ccSgIIgRdQzEXThxKvnq8VIUIOWg6MG
         ObadDouxom16RacsAMbDim3lGMidBi/l++OdNp7KyEqq7+uUC6rqJDfBJmynCbQYycBj
         72GiSWho1X55JR8MKrKy1X+eB76x7cp5m0AodJm4fJgqXAOOBCMKEIe/pVvuBZl75/78
         PqRPPMo/1MIb3nRxQNP0SrCLfKQho3DjhGvNQlCMHBh0SzqotRHMpMKa3kEYopk+5ow5
         7gQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686651298; x=1689243298;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2rY2E6D+8oZww/s6pZwAJAnOm0HX7caGb8hYSApwkk=;
        b=QmsVv0uUGT0b5og/uPN6JvMh3BvSHG8M2hp4FrH1Mxz8MhCivFcQ6T2HM7lnTf3QH+
         HDk3oCdRXX/rfkSbo6OvBGWPoocdBS+yjmESzH76t/CxsiVeuS3bJRzNqt2F2nHjsiCW
         1EBK+Z8P2k1jMTJIwgr4pCej+y4Fb33kmWMdsVpGPrZtks8b8h1SmV3mPsZaVrcHwtGO
         Y70e7ksUgiDTvJnzccqGlKs9tatFX9aHojEe4YZ8weXgwUE578gaT+wnZ6Z+vr3re89Y
         WkbOSdcUEsqJsyvZpgxQshhVs7z5Mzgi6E1vpcqxk3AM2Wnr5EvT8CbzMaVBLPOkbUMP
         9cxw==
X-Gm-Message-State: AC+VfDzGP7PlgSmAvo/WwdXb8waT4VGgC/SoSJfj4NfAqTt0K6YcLbuA
	pGLEGFotPaU88uaFrAATGTnTiA==
X-Google-Smtp-Source: ACHHUZ65N13abVrzLfeul76h7ocBpY5DJ46OtoJAPzwn6WdPIiMQgBL1EoYrygCdkLhCxe52FmASyg==
X-Received: by 2002:a05:6000:1951:b0:30e:5428:c322 with SMTP id e17-20020a056000195100b0030e5428c322mr6153431wry.44.1686651298384;
        Tue, 13 Jun 2023 03:14:58 -0700 (PDT)
Received: from [192.168.133.193] ([5.148.46.226])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6e8f000000b0030e6096afb6sm15075020wrz.12.2023.06.13.03.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:14:57 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH bpf-next v2 0/6] Add SO_REUSEPORT support for TC
 bpf_sk_assign
Date: Tue, 13 Jun 2023 11:14:55 +0100
Message-Id: <20230613-so-reuseport-v2-0-b7c69a342613@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ9BiGQC/02NQQrCMBBFr1Jm7UCbYEWvIi6S+Gtnk4SZKoXSu
 5u6cvl4//E3MqjA6NZtpPiISckN3KmjNIf8AsuzMbne+X4cPFthxdtQiy6Mq0tnNw4XD1BLYjB
 w1JDTfET/20NXxSTr7+1OsU6csS702Pcvt0gtuYcAAAA=
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
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We want to replace iptables TPROXY with a BPF program at TC ingress.
To make this work in all cases we need to assign a SO_REUSEPORT socket
to an skb, which is currently prohibited. This series adds support for
such sockets to bpf_sk_assing. See patch 5 for details.

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
Daniel Borkmann (1):
      selftests/bpf: Test that SO_REUSEPORT can be used with sk_assign helper

Lorenz Bauer (5):
      net: export inet_lookup_reuseport and inet6_lookup_reuseport
      net: document inet[6]_lookup_reuseport sk_state requirements
      net: remove duplicate reuseport_lookup functions
      net: remove duplicate sk_lookup helpers
      bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign

 include/net/inet6_hashtables.h                     |  84 ++++++++-
 include/net/inet_hashtables.h                      |  77 +++++++-
 include/net/sock.h                                 |   7 +-
 include/uapi/linux/bpf.h                           |   3 -
 net/core/filter.c                                  |   2 -
 net/ipv4/inet_hashtables.c                         |  69 +++++---
 net/ipv4/udp.c                                     |  73 +++-----
 net/ipv6/inet6_hashtables.c                        |  71 +++++---
 net/ipv6/udp.c                                     |  85 +++------
 tools/include/uapi/linux/bpf.h                     |   3 -
 tools/testing/selftests/bpf/network_helpers.c      |   3 +
 .../selftests/bpf/prog_tests/assign_reuse.c        | 197 +++++++++++++++++++++
 .../selftests/bpf/progs/test_assign_reuse.c        | 142 +++++++++++++++
 13 files changed, 637 insertions(+), 179 deletions(-)
---
base-commit: 25085b4e9251c77758964a8e8651338972353642
change-id: 20230613-so-reuseport-e92c526173ee

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>



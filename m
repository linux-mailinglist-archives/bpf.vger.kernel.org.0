Return-Path: <bpf+bounces-7866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F85E77D897
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 04:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704151C20EDE
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 02:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592C63FDC;
	Wed, 16 Aug 2023 02:54:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697D3D7B
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 02:54:09 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AF12132
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 19:54:07 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6471e071996so14107856d6.0
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 19:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692154446; x=1692759246;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jAVBy2MkmXmlDNRy4QvEu431ZhbMb0FhFH3eSVe50I=;
        b=s1C2tL1gwzB9t1W8VGjfLV8zpPSqNILfvoZd7kA5FZ9giVSw/PctFcXKSiDXYkoGUj
         1J3ikEOfXp+jpODaD5f7mpP0/lMAq0LmLyxnAz/lDqn5zuop//mbNmqaNG3n4CR7nOzd
         3MJOvbDoMyc0pVW5eUOZfakv4t579QuSvvZRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692154446; x=1692759246;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jAVBy2MkmXmlDNRy4QvEu431ZhbMb0FhFH3eSVe50I=;
        b=CzdHIvtjcqg6cPfKECw+64jq4pOD4f2w/KLOmF/t9rJPBQiBg8wkrXZmFehAc8g7sh
         4lZDI54U0ANPfUsyZhIv0RB3UzSKqs7iAUZ/0NIsqhGPc3G8XmiN47JxGC6STkhtTNT4
         pr2M9D9N93hTPzKft9H+pZfXxe8D361B/bCo71iSTt8IxpeRejgIcaze1t02MpEtdMFu
         J8eVWdYWxYvzm/WK8PlMk96kiACa4cr29p+eVj4dfDr83I2n0/kwzc+nsWPk6HlhJzkP
         DIYsQ0/DhRbNHCN5uYE8tFdBoZG44Atq9CGiqYSxz75UrAX8AMo3/wUv3mI2RHaemwgq
         1mdg==
X-Gm-Message-State: AOJu0YzhMPKayBBIh7olsLi+2RdhnVsmlfeAJ5qN6OB+lSD1uEcmZqVQ
	Gpp0LYLJ7F9h8J/O94BCPG+FXndoz385tQSPKLtEUQ==
X-Google-Smtp-Source: AGHT+IFUyON3WYFx3pyMbAY54IPL8txV66k0Ez5DFT6rOchV7FfvRatH9VayV7nsUi0glnx5sw9aFA==
X-Received: by 2002:a0c:c444:0:b0:626:3a5a:f8dc with SMTP id t4-20020a0cc444000000b006263a5af8dcmr517063qvi.57.1692154446180;
        Tue, 15 Aug 2023 19:54:06 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id c21-20020ae9e215000000b00765a9f53af0sm4136929qkc.128.2023.08.15.19.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 19:54:05 -0700 (PDT)
Date: Tue, 15 Aug 2023 19:54:03 -0700
From: Yan Zhai <yan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Yan Zhai <yan@cloudflare.com>, Thomas Graf <tgraf@suug.ch>,
	Jordan Griege <jgriege@cloudflare.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v5 bpf 0/4] lwt: fix return values of BPF ops
Message-ID: <cover.1692153515.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

lwt xmit hook does not expect positive return values in function
ip_finish_output2 and ip6_finish_output. However, BPF programs can
directly return positive statuses such like NET_XMIT_DROP, NET_RX_DROP,
and etc to the caller. Such return values would make the kernel continue
processing already freed skbs and eventually panic.

This set fixes the return values from BPF ops to unexpected continue
processing, and checks strictly on the correct continue condition for
future proof. In addition, add missing selftests for BPF_REDIRECT
and BPF_REROUTE cases for BPF-CI.

v4: https://lore.kernel.org/bpf/ZMD1sFTW8SFiex+x@debian.debian/T/ 
v3: https://lore.kernel.org/bpf/cover.1690255889.git.yan@cloudflare.com/ 
v2: https://lore.kernel.org/netdev/ZLdY6JkWRccunvu0@debian.debian/ 
v1: https://lore.kernel.org/bpf/ZLbYdpWC8zt9EJtq@debian.debian/ 

changes since v4:
 * fixed same error on BPF_REROUTE path
 * re-implemented selftests under BPF-CI requirement

changes since v3:
 * minor change in commit message and changelogs
 * tested by Jakub Sitnicki

changes since v2:
 * subject name changed
 * also covered redirect to ingress case
 * added selftests

changes since v1:
 * minor code style changes

Yan Zhai (4):
  lwt: fix return values of BPF ops
  lwt: check LWTUNNEL_XMIT_CONTINUE strictly
  selftests/bpf: add lwt_xmit tests for BPF_REDIRECT
  selftests/bpf: add lwt_xmit tests for BPF_REROUTE

 include/net/lwtunnel.h                        |   5 +-
 net/core/lwt_bpf.c                            |   7 +-
 net/ipv4/ip_output.c                          |   2 +-
 net/ipv6/ip6_output.c                         |   2 +-
 .../selftests/bpf/prog_tests/lwt_helpers.h    | 139 ++++++++
 .../selftests/bpf/prog_tests/lwt_redirect.c   | 319 ++++++++++++++++++
 .../selftests/bpf/prog_tests/lwt_reroute.c    | 256 ++++++++++++++
 .../selftests/bpf/progs/test_lwt_redirect.c   |  58 ++++
 .../selftests/bpf/progs/test_lwt_reroute.c    |  36 ++
 9 files changed, 817 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_redirect.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_reroute.c

-- 
2.30.2



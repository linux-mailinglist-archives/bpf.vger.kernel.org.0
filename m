Return-Path: <bpf+bounces-2996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB1C737FA4
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 12:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CAE2815E5
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 10:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1CAC8EF;
	Wed, 21 Jun 2023 10:42:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3963C07;
	Wed, 21 Jun 2023 10:42:25 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC70D2738;
	Wed, 21 Jun 2023 03:42:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-311099fac92so6696009f8f.0;
        Wed, 21 Jun 2023 03:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687344139; x=1689936139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DrD/lUU3IQ11JYudrpdgYie5SOp4+hQya2EcQ53MHIk=;
        b=FeMxMRzaebEjEgf+O/k1JyL3IZ5Q/5rWqCu8T2NKvmTxG8teD0Dg9hUai5S/8pp9gj
         b2okxptVR1Xup11Z2bJGWafH7pPUNuU2FI2kqKpxyp06XNdtQi3hKgAONxBqh2bveCZi
         SKsnYrW5SuK5lez7b+GJ14/K6gRfoifaw0JkKiaNR5xJsNT2k4/M4yHxlu4oydBbW1/x
         cBy3ZVKfLmYNBOmvMaPOU42BsJktpcFH2/y35yY7BzW+UbH4B9W3qJQEDkAd8Bjso2Z6
         cXWsiDbxzF/uJFyXW+7nQWy0eMoTpVzDm2apqk0QHsjnilcD7ms5dBN/yANQCgbJaOTb
         Uo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687344139; x=1689936139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrD/lUU3IQ11JYudrpdgYie5SOp4+hQya2EcQ53MHIk=;
        b=HIsMWkUsPqQ6wUV1c8D8VbLMNqgXcI4xSxLN4JsLg1kjT4Es9JUJXk4PtYS4g97Wpl
         s5765Uze5hrG2vz/J34rqWHj3VAPxEHjA54N3ml5BBnES25VX5dOXZjvsK9XPAO69cJK
         1/mcSdih7JCtU4601Uhk+UDdqamVTuzFU+QYH4pqUEt2hdPchAtYKtK4KTfSDjPXk35z
         ucFSpw/P5w/QiWff6X6/WI/nlm02e61cxRs/tKnFrZRfdKLMPGX4UzYzZcvJmCa1yorD
         Osaj8kaLf7NKBhBD6hCSZxjfRlkXm+D5qpx25Esw5Rzd4xPOsN321mFgZMvpH5PGzgVv
         iy8Q==
X-Gm-Message-State: AC+VfDywRNjyeE/Si/2noggB2MjiOXxF9fKLI2RxuV+i0RJ/CJouSFfV
	pPhDt2xHuIA/4b38pifhN74=
X-Google-Smtp-Source: ACHHUZ5JCOq/nlems0wVhIwa5fpvvrZ2xa4Zr3lWc++QduJGsZ6WH8u/FXANWNazUGEtOY845NkhSw==
X-Received: by 2002:adf:e449:0:b0:30f:c56c:b5a6 with SMTP id t9-20020adfe449000000b0030fc56cb5a6mr13972546wrm.4.1687344138905;
        Wed, 21 Jun 2023 03:42:18 -0700 (PDT)
Received: from gsever-Latitude-7400.corp.proofpoint.com ([46.120.112.153])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5711000000b003062b2c5255sm4121378wrv.40.2023.06.21.03.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:42:18 -0700 (PDT)
From: Gilad Sever <gilad9366@gmail.com>
To: dsahern@kernel.org,
	martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	hawk@kernel.org,
	joe@wand.net.nz
Cc: eyal.birger@gmail.com,
	shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Gilad Sever <gilad9366@gmail.com>
Subject: [PATCH bpf,v6 0/4] Socket lookup BPF API from tc/xdp ingress does not respect VRF bindings.
Date: Wed, 21 Jun 2023 13:42:07 +0300
Message-Id: <20230621104211.301902-1-gilad9366@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When calling socket lookup from L2 (tc, xdp), VRF boundaries aren't
respected. This patchset fixes this by regarding the incoming device's
VRF attachment when performing the socket lookups from tc/xdp.

The first two patches are coding changes which factor out the tc helper's
logic which was shared with cg/sk_skb (which operate correctly).

This refactoring is needed in order to avoid affecting the cgroup/sk_skb
flows as there does not seem to be a strict criteria for discerning which
flow the helper is called from based on the net device or packet
information.

The third patch contains the actual bugfix.

The fourth patch adds bpf tests for these lookup functions.
---
v6: - Remove redundant IS_ENABLED as suggested by Daniel Borkmann
    - Declare net_device variable and use it as suggested by Daniel Borkmann

v5: Use reverse xmas tree indentation

v4: - Move dev_sdif() to include/linux/netdevice.h as suggested by Stanislav Fomichev
    - Remove SYS and SYS_NOFAIL duplicate definitions

v3: - Rename bpf_l2_sdif() to dev_sdif() as suggested by Stanislav Fomichev
    - Added xdp tests as suggested by Daniel Borkmann
    - Use start_server() to avoid duplicate code as suggested by Stanislav Fomichev

v2: Fixed uninitialized var in test patch (4).

Gilad Sever (4):
  bpf: factor out socket lookup functions for the TC hookpoint.
  bpf: Call __bpf_sk_lookup()/__bpf_skc_lookup() directly via TC
    hookpoint
  bpf: fix bpf socket lookup from tc/xdp to respect socket VRF bindings
  selftests/bpf: Add vrf_socket_lookup tests

 include/linux/netdevice.h                     |   9 +
 net/core/filter.c                             | 141 ++++++--
 .../bpf/prog_tests/vrf_socket_lookup.c        | 312 ++++++++++++++++++
 .../selftests/bpf/progs/vrf_socket_lookup.c   |  88 +++++
 4 files changed, 526 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/vrf_socket_lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/vrf_socket_lookup.c

-- 
2.34.1



Return-Path: <bpf+bounces-7420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4801777044
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 08:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091AF1C2144F
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 06:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C321C17;
	Thu, 10 Aug 2023 06:25:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C91113
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 06:25:16 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27071E3
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 23:25:15 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RLxhc4YrCz1L9XL;
	Thu, 10 Aug 2023 14:24:00 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 14:25:11 +0800
From: Ziyang Xuan <william.xuanziyang@huawei.com>
To: <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <andrii@kernel.org>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH bpf-next 0/2] bpf: Update h_proto of ethhdr when the outer protocol changed
Date: Thu, 10 Aug 2023 14:25:00 +0800
Message-ID: <cover.1691639830.git.william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When use bpf_skb_adjust_room() to encapsulate or decapsulate packet,
and outer protocol changed, we can update h_proto of ethhdr directly.

$./test_tc_tunnel.sh
ipip
encap 192.168.1.1 to 192.168.1.2, type ipip, mac none len 100
test basic connectivity
0
test bpf encap without decap (expect failure)
Ncat: TIMEOUT.
1
test bpf encap with tunnel device decap
0
test bpf encap with bpf decap
0
OK
ipip6
encap 192.168.1.1 to 192.168.1.2, type ipip6, mac none len 100
test basic connectivity
0
test bpf encap without decap (expect failure)
Ncat: TIMEOUT.
1
test bpf encap with tunnel device decap
0
test bpf encap with bpf decap
0
OK
ip6ip6
encap fd::1 to fd::2, type ip6tnl, mac none len 100
test basic connectivity
0
test bpf encap without decap (expect failure)
Ncat: TIMEOUT.
1
test bpf encap with tunnel device decap
0
test bpf encap with bpf decap
0
OK
sit
encap fd::1 to fd::2, type sit, mac none len 100
test basic connectivity
0
test bpf encap without decap (expect failure)
Ncat: TIMEOUT.
1
test bpf encap with tunnel device decap
0
test bpf encap with bpf decap
0
OK
...
OK. All tests passed

Ziyang Xuan (2):
  bpf: Update h_proto of ethhdr when the outer protocol changed
  selftests/bpf: Remove unnecessary codes for updating h_proto of ethhdr

 net/core/filter.c                             | 20 +++++++++++++------
 .../selftests/bpf/progs/test_tc_tunnel.c      | 18 -----------------
 2 files changed, 14 insertions(+), 24 deletions(-)

-- 
2.25.1



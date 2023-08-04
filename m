Return-Path: <bpf+bounces-6952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C68E76FAE5
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 09:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3971C21772
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 07:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B08E8471;
	Fri,  4 Aug 2023 07:16:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5536A6ADF;
	Fri,  4 Aug 2023 07:16:37 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E623588;
	Fri,  4 Aug 2023 00:16:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RHH7w4vTMz4f3jMm;
	Fri,  4 Aug 2023 15:16:28 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP2 (Coremail) with SMTP id Syh0CgAHF+jMpcxkm1vaPQ--.64994S2;
	Fri, 04 Aug 2023 15:16:29 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>
Subject: [PATCH bpf v3 0/4] bug fixes for sockmap
Date: Fri,  4 Aug 2023 03:37:36 -0400
Message-Id: <20230804073740.194770-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHF+jMpcxkm1vaPQ--.64994S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyfJryDtr1rZrWfGF4Uurg_yoWftFg_uw
	4UKr95Xr1xXFnxGFWruFs3JFWkKFZ7Jr1rAFZ8t347Gw1xZw18WFsYkFyrJa4UWay0qryx
	KFn5W3y0qr13XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xu Kuohai <xukuohai@huawei.com>

bug fixes and a new test case for sockmap.

v3:
fix bpf ci failure

v2: https://lore.kernel.org/bpf/20230803064838.108784-1-xukuohai@huaweicloud.com
add a test case

v1:
https://lore.kernel.org/bpf/20230728105649.3978774-1-xukuohai@huaweicloud.com
https://lore.kernel.org/bpf/20230728105717.3978849-1-xukuohai@huaweicloud.com

Xu Kuohai (4):
  bpf, sockmap: Fix map type error in sock_map_del_link
  bpf, sockmap: Fix bug that strp_done cannot be called
  selftests/bpf: fix a CI failure caused by vsock sockmap test
  selftests/bpf: Add sockmap test for redirecting partial skb data

 include/linux/skmsg.h                         |  1 +
 net/core/skmsg.c                              | 10 ++-
 net/core/sock_map.c                           | 10 +--
 .../selftests/bpf/prog_tests/sockmap_listen.c | 74 ++++++++++++++++++-
 .../selftests/bpf/progs/test_sockmap_listen.c | 14 ++++
 5 files changed, 101 insertions(+), 8 deletions(-)

-- 
2.30.2



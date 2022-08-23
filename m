Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8168459E89F
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 19:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245654AbiHWRHd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345002AbiHWRGP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 13:06:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AB2152C5F
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 06:35:09 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MBqrn0wwlzlWRV;
        Tue, 23 Aug 2022 21:31:53 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 23 Aug
 2022 21:35:05 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
        <edumazet@google.com>, <davem@davemloft.net>,
        <yoshfuji@linux-ipv6.org>, <dsahern@kernel.org>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <andrii@kernel.org>, <mykolal@fb.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
        <song@kernel.org>, <yhs@fb.com>, <kpsingh@kernel.org>,
        <sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
        <shuah@kernel.org>, <bpf@vger.kernel.org>
CC:     <liujian56@huawei.com>
Subject: [PATCH bpf-next v2 0/2] If the sock is dead, do not access sock's sk_wq in sk_stream_wait_memory
Date:   Tue, 23 Aug 2022 21:37:53 +0800
Message-ID: <20220823133755.314697-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If the sock is dead, do not access sock's sk_wq in sk_stream_wait_memory

v1->v2:
  As Jakub's suggested, check sock's DEAD flag before accessing
  the wait queue.

Liu Jian (2):
  net: If the sock is dead, do not access sock's sk_wq in
    sk_stream_wait_memory
  selftests/bpf: Add wait send memory test for sockmap redirect

 net/core/stream.c                          |  3 +-
 tools/testing/selftests/bpf/test_sockmap.c | 42 ++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

-- 
2.17.1


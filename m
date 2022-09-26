Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED66C5E9883
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 06:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiIZEvp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 00:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiIZEvo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 00:51:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45B02654B
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 21:51:42 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MbVdV5Q7fzpVTS;
        Mon, 26 Sep 2022 12:48:46 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 12:51:39 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <shuah@kernel.org>, <delyank@fb.com>, <zhudi2@huawei.com>,
        <jakub@cloudflare.com>, <kuba@kernel.org>, <kuifeng@fb.com>,
        <deso@posteo.net>, <zhuyifei@google.com>, <hengqi.chen@gmail.com>
CC:     <bpf@vger.kernel.org>
Subject: [bpf-next 00/11] bpf/selftests: convert some tests to ASSERT_* macros
Date:   Mon, 26 Sep 2022 13:12:00 +0800
Message-ID: <1664169131-32405-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert some tests to use the preferred ASSERT_* macros instead of the
deprecated CHECK().

Wang Yufen (11):
  bpf/selftests: convert sockmap_basic test to ASSERT_* macros
  bpf/selftests: convert sockmap_ktls test to ASSERT_* macros
  bpf/selftests: convert sockopt test to ASSERT_* macros
  bpf/selftests: convert sockopt_inherit test to ASSERT_* macros
  bpf/selftests: convert sockopt_multi test to ASSERT_* macros
  bpf/selftests: convert sockopt_sk test to ASSERT_* macros
  bpf/selftests: convert tcp_estats test to ASSERT_* macros
  bpf/selftests: convert tcp_hdr_options test to ASSERT_* macros
  bpf/selftests: convert tcp_rtt test to ASSERT_* macros
  bpf/selftests: convert tcpbpf_user test to ASSERT_* macros
  bpf/selftests: convert udp_limit test to ASSERT_* macros

 .../selftests/bpf/prog_tests/sockmap_basic.c       | 87 ++++++++--------------
 .../selftests/bpf/prog_tests/sockmap_ktls.c        | 39 +++-------
 tools/testing/selftests/bpf/prog_tests/sockopt.c   |  4 +-
 .../selftests/bpf/prog_tests/sockopt_inherit.c     | 30 ++++----
 .../selftests/bpf/prog_tests/sockopt_multi.c       | 10 +--
 .../testing/selftests/bpf/prog_tests/sockopt_sk.c  |  2 +-
 .../testing/selftests/bpf/prog_tests/tcp_estats.c  |  4 +-
 .../selftests/bpf/prog_tests/tcp_hdr_options.c     | 80 +++++++-------------
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c   | 13 ++--
 .../testing/selftests/bpf/prog_tests/tcpbpf_user.c | 32 +++-----
 tools/testing/selftests/bpf/prog_tests/udp_limit.c | 18 ++---
 11 files changed, 117 insertions(+), 202 deletions(-)

-- 
1.8.3.1


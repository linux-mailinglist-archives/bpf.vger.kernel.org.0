Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D972958B43A
	for <lists+bpf@lfdr.de>; Sat,  6 Aug 2022 09:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiHFHk2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Aug 2022 03:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiHFHk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Aug 2022 03:40:26 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC691B7F3
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 00:40:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M0DQf4QvkzlBKW
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 15:20:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHeVydFu5iXIYHAA--.28679S4;
        Sat, 06 Aug 2022 15:22:06 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, houtao1@huawei.com
Subject: [PATCH bpf 0/9] fixes for bpf map iterator
Date:   Sat,  6 Aug 2022 15:40:10 +0800
Message-Id: <20220806074019.2756957-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHeVydFu5iXIYHAA--.28679S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWrGr47Ww1UGw17tw1xuFg_yoW8AFy8pr
        WfXFy5Kr4xAF4xZrnrZa12kFyrA3yrXa4jqFs5Jr1Ykw1DZa45WrWIkF13uFy3WFn8JryS
        y3y09r95Ca4xZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UdxhLUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Hi,

The patchset constitues three fixes for bpf map iterator:

(1) patch 1~4: fix user-after-free during reading map iterator fd
It is possible when both the corresponding link fd and map fd are
closed bfore reading the iterator fd. I had squashed these four patches
into one, but it was not friendly for stable backport, so I break these
fixes into 4 single patches in the end. Patch 7 is its testing patch.

(2) patch 5: fix invalidity check for values in sk local storage map
Patch 8 adds two tests for it.

(3) patch 6: reject sleepable program for non-resched map iterator
Patch 9 add a test for it.

Please check the individual patches for more details. And comments are
always welcome.

Regards,
Tao

Hou Tao (9):
  bpf: Acquire map uref in .init_seq_private for array map iterator
  bpf: Acquire map uref in .init_seq_private for hash map iterator
  bpf: Acquire map uref in .init_seq_private for sock local storage map
    iterator
  bpf: Acquire map uref in .init_seq_private for sock{map,hash} iterator
  bpf: Check the validity of max_rdwr_access for sk storage map iterator
  bpf: Only allow sleepable program for resched-able iterator
  selftests/bpf: Add tests for reading a dangling map iter fd
  selftests/bpf: Add write tests for sk storage map iterator
  selftests/bpf: Ensure sleepable program is rejected by hash map iter

 kernel/bpf/arraymap.c                         |   7 ++
 kernel/bpf/bpf_iter.c                         |  11 +-
 kernel/bpf/hashtab.c                          |   2 +
 net/core/bpf_sk_storage.c                     |  12 +-
 net/core/sock_map.c                           |  20 ++-
 .../selftests/bpf/prog_tests/bpf_iter.c       | 114 +++++++++++++++++-
 .../bpf/progs/bpf_iter_bpf_hash_map.c         |   9 ++
 .../bpf/progs/bpf_iter_bpf_sk_storage_map.c   |  20 ++-
 8 files changed, 189 insertions(+), 6 deletions(-)

-- 
2.29.2


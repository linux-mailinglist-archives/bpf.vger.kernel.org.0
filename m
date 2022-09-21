Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA11A5BF689
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 08:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiIUGmm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 02:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiIUGmj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 02:42:39 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F8480F4C
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 23:42:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MXTLq6kdVzKKyQ
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 14:40:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXNVsipjY1ynBA--.6480S4;
        Wed, 21 Sep 2022 14:42:31 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: [PATCH bpf-next v2 0/2] Fix resource leaks in test_maps
Date:   Wed, 21 Sep 2022 15:00:33 +0800
Message-Id: <20220921070035.2016413-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXNVsipjY1ynBA--.6480S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKrWkGFWUZw4DuryfJw4Dtwb_yoWkJrcE9F
        W8KrykCw43Aa45G3Z2yF1UGrWDt342vr9FvrZrK3srWr15ZF1rXF4kCryrXa4Yqrs5Zr9I
        vF4kZFWjvw17WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Hi,

It is just a tiny patch set aims to fix the resource leaks in test_maps
after test case succeeds or is skipped. And these leaks are spotted by
using address sanitizer and checking the content of /proc/$pid/fd.

Please see indiviual patch for more details.

Change Log:
v2:
 * Add the missing header file unistd.h for close() (From kernel-patches/bpf)
   The reason Why I miss that is that -Werror is removed from Makefile
   when enabling clang address sanitizer.

v1:
 * https://lore.kernel.org/bpf/20220921025855.115463-1-houtao@huaweicloud.com/T/

Hou Tao (2):
  selftests/bpf: Destroy the skeleton when CONFIG_PREEMPT is off
  selftests/bpf: Free the allocated resources after test case succeeds

 .../bpf/map_tests/array_map_batch_ops.c       |  2 ++
 .../bpf/map_tests/htab_map_batch_ops.c        |  2 ++
 .../bpf/map_tests/lpm_trie_map_batch_ops.c    |  2 ++
 .../bpf/map_tests/task_storage_map.c          |  1 +
 tools/testing/selftests/bpf/test_maps.c       | 24 ++++++++++++-------
 5 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.29.2


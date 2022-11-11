Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB6E625362
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 07:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiKKGIq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 01:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiKKGIn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 01:08:43 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48F625C4D
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 22:08:40 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N7pDL585Yz4f3m6W
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 14:08:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDH69ji5m1jjmBXAQ--.18964S4;
        Fri, 11 Nov 2022 14:08:36 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Subject: [PATCH bpf v2 0/3] Pin iterator link when opening iterator
Date:   Fri, 11 Nov 2022 14:34:14 +0800
Message-Id: <20221111063417.1603111-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDH69ji5m1jjmBXAQ--.18964S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww45GF18WFW3XFWDAw47urg_yoW8GFykpF
        Z3Gw45Kr1fArW7Ww42k3y2ga4Fya1rGw4UGrn7Jry3CFn8JFyIgrWxKr45CFy5GF9rXrsx
        ZF1Fka1rW3WUArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Hi,

The patchset tries to fix the potential use-after-free problem in cgroup
iterator. The problem is similar with the UAF problem fixed in map
iterator, however to prevent such UAF problem from happening again for
bpf iterator, just pinning iterator link when opening iterator, so after
doing the necessary reference acquisitions in .attach_target() there will
be unnecessary to pin iteration target again in .init_seq_private() for
each iterator type. Also adding a selftests to demonstrate the UAF
problem when iterating a dead cgroup.

Comments are always welcome.

Change Log:
v2:
 * Patch 1: Pinning iterator link when opening iterator, instead of
   acquiring the reference of start cgroup in cgroup_iter_seq_init().
 * Patch 2 & 3: Address comments from Yonghong Song and add Acked-by tag

v1: https://lore.kernel.org/bpf/20221107074222.1323017-1-houtao@huaweicloud.com/T/#t

Hou Tao (3):
  bpf: Pin iterator link when opening iterator
  selftests/bpf: Add cgroup helper remove_cgroup()
  selftests/bpf: Add test for cgroup iterator on a dead cgroup

 kernel/bpf/bpf_iter.c                         | 21 +++--
 tools/testing/selftests/bpf/cgroup_helpers.c  | 19 +++++
 tools/testing/selftests/bpf/cgroup_helpers.h  |  1 +
 .../selftests/bpf/prog_tests/cgroup_iter.c    | 76 +++++++++++++++++++
 4 files changed, 110 insertions(+), 7 deletions(-)

-- 
2.29.2


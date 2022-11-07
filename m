Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B062661EB93
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 08:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiKGHSS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 02:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiKGHR5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 02:17:57 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD8615738
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 23:16:44 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N5Mwj45r3z4f3mVw
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:16:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgC329jWsGhjUEl6AA--.47516S4;
        Mon, 07 Nov 2022 15:16:40 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Tejun Heo <tj@kernel.org>, houtao1@huawei.com
Subject: [PATCH bpf 0/3] Pin the start cgroup for cgroup iterator
Date:   Mon,  7 Nov 2022 15:42:19 +0800
Message-Id: <20221107074222.1323017-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC329jWsGhjUEl6AA--.47516S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4fZF1Dur48XF1xur4kJFb_yoWkJrc_Za
        y5J34DtFWxCFn8tFyvgF9YyFW093yfGr1FyF15Xr9Fkr1UXF1kXF4kJryxZry8Za45Ja47
        Jrsay3yxAF17XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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
iterator and the fixes is also similar: pinning the iterated resource
in .init_seq_private() and unpinning in .fini_seq_private(). Also adding
a test to demonstrate the problem.

Not sure whether or not it will be helpful to add some comments for
.init_seq_private() to state that the implementation of
.init_seq_private() should not depend on iterator link to guarantee
the liveness of iterated object. Comments are always welcome.

Hou Tao (3):
  bpf: Pin the start cgroup in cgroup_iter_seq_init()
  selftests/bpf: Add cgroup helper remove_cgroup()
  selftests/bpf: Add test for cgroup iterator on a dead cgroup

 kernel/bpf/cgroup_iter.c                      | 14 ++++
 tools/testing/selftests/bpf/cgroup_helpers.c  | 19 +++++
 tools/testing/selftests/bpf/cgroup_helpers.h  |  1 +
 .../selftests/bpf/prog_tests/cgroup_iter.c    | 78 +++++++++++++++++++
 4 files changed, 112 insertions(+)

-- 
2.29.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA35643C45
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 05:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiLFEaC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 23:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiLFE35 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 23:29:57 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62836262A
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 20:29:54 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NR6rr0TwYz4f3p0n
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 12:29:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDXSNY7xY5jzaDzBg--.51441S4;
        Tue, 06 Dec 2022 12:29:49 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Subject: [PATCH bpf-next 0/2] Misc optimizations for bpf mem allocator
Date:   Tue,  6 Dec 2022 12:29:44 +0800
Message-Id: <20221206042946.686847-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXSNY7xY5jzaDzBg--.51441S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4Uury7GFyrZr1kCryDWrg_yoW8uw1kpF
        4fGa15Xr95Wry3Kws3Awn7GrZ8Aa95Wr17GFsaq3s5Zrn8JF109a1vyw4rZFy5Jr97Ka4a
        vr1q9F9xu34rZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The patchset is just misc optimizations for bpf mem allocator. Patch 1
fixes the OOM problem found during running hash-table update benchmark
from qp-trie patchset [0]. The benchmark will add htab elements in
batch and then delete elements in batch, so freed objects will stack on
free_by_rcu and wait for the expiration of RCU grace period. There can
be tens of thousands of freed objects and these objects are not
available for new allocation, so adding htab element will continue to do
new allocation.

For the benchmark commmand: "./bench -w3 -d10 -a htab-update -p 16",
even the maximum entries of htab is 16384, key_size is 255 and
value_size is 4, the peak memory usage will reach 14GB or more.
Increasing rcupdate.rcu_task_enqueue_lim will decrease the peak memory to
860MB, but it is still too many. Although the above case is contrived,
it is better to fix it and the fixing is simple: just reusing the freed
objects in free_by_rcu during allocation. After the fix, the peak memory
usage will decrease to 26MB. Beside above case, the memory blow-up
problem is also possible when allocation and freeing are done on total
different CPUs. I'm trying to fix the blow-up problem by using a global
per-cpu work to free these objects in free_by_rcu timely, but it doesn't
work very well and I am still digging into it.

Patch 2 is a left-over patch from rcu_trace_implies_rcu_gp() patchset
[1]. After disscussing with Paul [2], I think it is also safe to skip
rcu_barrier() when rcu_trace_implies_rcu_gp() returns true.

Comments are always welcome.

[0]: https://lore.kernel.org/bpf/20220924133620.4147153-13-houtao@huaweicloud.com/
[1]: https://lore.kernel.org/bpf/20221014113946.965131-1-houtao@huaweicloud.com/
[2]: https://lore.kernel.org/bpf/20221021185002.GP5600@paulmck-ThinkPad-P17-Gen-1/

Hou Tao (2):
  bpf: Reuse freed element in free_by_rcu during allocation
  bpf: Skip rcu_barrier() if rcu_trace_implies_rcu_gp() is true

 kernel/bpf/memalloc.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

-- 
2.29.2


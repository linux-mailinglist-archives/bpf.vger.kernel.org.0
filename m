Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A82647B29
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 02:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLIBJ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 20:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLIBJ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 20:09:57 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909E580A0E;
        Thu,  8 Dec 2022 17:09:56 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NStGk60Tnz4f3kpL;
        Fri,  9 Dec 2022 09:09:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgB3m9jdipJjIEibBw--.55652S4;
        Fri, 09 Dec 2022 09:09:51 +0800 (CST)
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
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [PATCH bpf-next v2 0/2] Misc optimizations for bpf mem allocator
Date:   Fri,  9 Dec 2022 09:09:45 +0800
Message-Id: <20221209010947.3130477-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3m9jdipJjIEibBw--.55652S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4Uury7GFyrZr1kCryDWrg_yoW8KFyDpF
        4fGa15Xrn5WrnxKrs3Gw1xGrZ8Aa95Gr17GFsaq3s5Zrn8JF109F4vvw45ZFy5Jr93Ka4Y
        vr1j9F9xu34Fva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
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

Change Log:
v2:
  * Patch 1: repharse the commit message (Suggested by Yonghong & Alexei)
  * Add Acked-by for both patch 1 and 2

v1: https://lore.kernel.org/bpf/20221206042946.686847-1-houtao@huaweicloud.com

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


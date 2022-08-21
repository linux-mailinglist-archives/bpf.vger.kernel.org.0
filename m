Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7993759B161
	for <lists+bpf@lfdr.de>; Sun, 21 Aug 2022 05:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiHUDOX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Aug 2022 23:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiHUDOV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Aug 2022 23:14:21 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF95101F5
        for <bpf@vger.kernel.org>; Sat, 20 Aug 2022 20:14:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4M9LCK3rNwz6T4t5
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 11:12:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAH8r0DowFjsgGLAg--.45130S4;
        Sun, 21 Aug 2022 11:14:13 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>
Cc:     Hao Sun <sunhao.th@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: [PATCH 0/3] fixes for concurrent htab updates
Date:   Sun, 21 Aug 2022 11:32:20 +0800
Message-Id: <20220821033223.2598791-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAH8r0DowFjsgGLAg--.45130S4
X-Coremail-Antispam: 1UD129KBjvJXoW7urW8JryrCw1fCr47ur1Utrb_yoW8CrW3pF
        4fWa1akrsFqr92va1Syr10vFyYqw1rKr4Ikr9xu3y0vay5GF1xurn2vF4S9F1Ykr9IgrWf
        Xr4jqF1kC34UZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
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

The patchset aims to fix the issues found during investigating the
syzkaller problem reported in [0]. It seems that the normally concurrent
updates in the same hash-table are disallowed as shown in patch 1.

Patch 1 uses preempt_disable() to fix the problem to !PREEMPT_RT case.

Patch 2 introduces an extra bpf_map_busy bit in task_struct to
detect the re-entrancy of htab_lock_bucket() and allow concurrent map
updates due to preemption in PREEMPT_RT case. It is coarse-grained
compared with map_locked in !PREEMPT_RT case, because if two different
maps are manipulated the re-entrancy is still be rejected. But
considering Alexei is working on "BPF specific memory allocator" [1],
and the !htab_use_raw_lock() case can be removed after the patchset is
landed, so I think may be it is fine and hope to get some more feedback
about the proposed fix in patch 2.

Patch 3 just fixes the out-of-bound memory read problem reported in [0].
Once patch 1 & patch 2 are merged, htab_lock_bucket() will always
succeed for userspace process, but it is better to handle it gracefully.

Selftests will be added after getting more feedback about the patchset
and comments are always welcome.

Regards,
Tao

[0]: https://lore.kernel.org/bpf/CACkBjsbuxaR6cv0kXJoVnBfL9ZJXjjoUcMpw_Ogc313jSrg14A@mail.gmail.com/
[1]: https://lore.kernel.org/bpf/20220819214232.18784-1-alexei.starovoitov@gmail.com/

Hou Tao (3):
  bpf: Disable preemption when increasing per-cpu map_locked
  bpf: Allow normally concurrent map updates for !htab_use_raw_lock()
    case
  bpf: Propagate error from htab_lock_bucket() to userspace

 include/linux/sched.h |  3 +++
 kernel/bpf/hashtab.c  | 59 ++++++++++++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 18 deletions(-)

-- 
2.29.2


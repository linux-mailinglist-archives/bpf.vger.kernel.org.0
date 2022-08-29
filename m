Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996F35A4106
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 04:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiH2CTI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 22:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiH2CTH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 22:19:07 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63953C17A
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 19:19:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MGDbn4qw6z6S2rG
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 10:17:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnenMTIgxjzJZKAA--.51878S4;
        Mon, 29 Aug 2022 10:19:01 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hao Sun <sunhao.th@gmail.com>, Hao Luo <haoluo@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: [PATCH bpf-next v3 0/3] fixes for concurrent htab updates
Date:   Mon, 29 Aug 2022 10:37:06 +0800
Message-Id: <20220829023709.1958204-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenMTIgxjzJZKAA--.51878S4
X-Coremail-Antispam: 1UD129KBjvJXoW7urW8JryxWr4DCFW5Ww15urg_yoW8tF1rpa
        yxW3W5Kw1xtrnFqw47tw1j9FWFya1rGr4jkrn3W3y5Z3yUKFyxZr4I9r4rZrs5KrZ3Wryf
        Ar4xtFs5Za18ZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
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
syzkaller problem reported in [0]. It seems that the concurrent updates
to the same hash-table bucket may fail as shown in patch 1.

Patch 1 uses preempt_disable() to fix the problem for
htab_use_raw_lock() case. For !htab_use_raw_lock() case, the problem is
left to "BPF specific memory allocator" patchset [1] in which
!htab_use_raw_lock() will be removed.

Patch 2 fixes the out-of-bound memory read problem reported in [0]. The
problem has the root cause as patch 1 and it is fixed by handling -EBUSY
from htab_lock_bucket() correctly.

Patch 3 add two cases for hash-table update: one for the reentrancy of
bpf_map_update_elem(), and another one for concurrent updates of the
same hash-table bucket.

Comments are always welcome.

Regards,
Tao

[0]: https://lore.kernel.org/bpf/CACkBjsbuxaR6cv0kXJoVnBfL9ZJXjjoUcMpw_Ogc313jSrg14A@mail.gmail.com/
[1]: https://lore.kernel.org/bpf/20220819214232.18784-1-alexei.starovoitov@gmail.com/

Change Log:

v3:
 * patch 1: update commit message and add Fixes tag
 * patch 2: add Fixes tag
 * patch 3: elaborate the description of test cases

v2: https://lore.kernel.org/bpf/bd60ef93-1c6a-2db2-557d-b09b92ad22bd@huaweicloud.com/
 * Note the fix is for CONFIG_PREEMPT case in commit message and add
   Reviewed-by tag for patch 1
 * Drop patch "bpf: Allow normally concurrent map updates for !htab_use_raw_lock() case"
 * Add two test cases for htab updates

v1: https://lore.kernel.org/bpf/20220821033223.2598791-1-houtao@huaweicloud.com/

Hou Tao (3):
  bpf: Disable preemption when increasing per-cpu map_locked
  bpf: Propagate error from htab_lock_bucket() to userspace
  selftests/bpf: add test cases for htab update

 kernel/bpf/hashtab.c                          |  30 ++++-
 .../selftests/bpf/prog_tests/htab_update.c    | 126 ++++++++++++++++++
 .../testing/selftests/bpf/progs/htab_update.c |  29 ++++
 3 files changed, 178 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_update.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_update.c

-- 
2.29.2


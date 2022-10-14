Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222AA5FED06
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 13:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJNLOT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 07:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJNLOS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 07:14:18 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412B9EB764;
        Fri, 14 Oct 2022 04:14:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MpkHd2VJ0zl98S;
        Fri, 14 Oct 2022 19:12:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgBnZ8lyREljUWYIAQ--.52658S4;
        Fri, 14 Oct 2022 19:14:10 +0800 (CST)
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
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Delyan Kratunov <delyank@fb.com>, rcu@vger.kernel.org
Subject: [PATCH bpf-next v2 0/4] Remove unnecessary RCU grace period chaining
Date:   Fri, 14 Oct 2022 19:39:42 +0800
Message-Id: <20221014113946.965131-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnZ8lyREljUWYIAQ--.52658S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW8WFy3XFWxGw15Ar1xGrg_yoW8tr43pF
        W8KFn8Cr1DZr4Skas3Ar47G3y5J395G347XF93A34Fyrs8AryDur12y3W5WF13K393Ja4a
        vFn8tFnxG3WUZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWwZcUUUUU=
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

Now bpf uses RCU grace period chaining to wait for the completion of
access from both sleepable and non-sleepable bpf program: calling
call_rcu_tasks_trace() firstly to wait for a RCU-tasks-trace grace
period, then in its callback calls call_rcu() or kfree_rcu() to wait for
a normal RCU grace period.

According to the implementation of RCU Tasks Trace, it inovkes
->postscan_func() to wait for one RCU-tasks-trace grace period and
rcu_tasks_trace_postscan() inovkes synchronize_rcu() to wait for one
normal RCU grace period in turn, so one RCU-tasks-trace grace period
will imply one normal RCU grace period. To codify the implication,
introduces rcu_trace_implies_rcu_gp() in patch #1. And using it in patch
#2~#4 to remove unnecessary call_rcu() or kfree_rcu() in bpf subsystem.
Other two uses of call_rcu_tasks_trace() are unchanged: for
__bpf_prog_put_rcu() there is no gp chain and for
__bpf_tramp_image_put_rcu_tasks() it chains RCU tasks trace GP and RCU
tasks GP.

An alternative way to remove these unnecessary RCU grace period
chainings is using the RCU polling API to check whether or not a normal
RCU grace period has passed (e.g. get_state_synchronize_rcu()). But it
needs an unsigned long space for each free element or each call, and
it is not affordable for local storage element, so as for now always
rcu_trace_implies_rcu_gp().

Comments are always welcome.

Change Log:

v2:
 * codify the implication of RCU Tasks Trace grace period instead of
   assuming for it

v1: https://lore.kernel.org/bpf/20221011071128.3470622-1-houtao@huaweicloud.com

Hou Tao (3):
  bpf: Use rcu_trace_implies_rcu_gp() in bpf memory allocator
  bpf: Use rcu_trace_implies_rcu_gp() in local storage map
  bpf: Use rcu_trace_implies_rcu_gp() for program array freeing

Paul E. McKenney (1):
  rcu-tasks: Provide rcu_trace_implies_rcu_gp()

 include/linux/rcupdate.h       | 12 ++++++++++++
 kernel/bpf/bpf_local_storage.c | 13 +++++++++++--
 kernel/bpf/core.c              |  8 +++++++-
 kernel/bpf/memalloc.c          | 15 ++++++++++-----
 kernel/rcu/tasks.h             |  2 ++
 5 files changed, 42 insertions(+), 8 deletions(-)

-- 
2.29.2


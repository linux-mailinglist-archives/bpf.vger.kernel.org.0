Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2125FAD02
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 08:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJKGpv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 02:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiJKGpu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 02:45:50 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D277547;
        Mon, 10 Oct 2022 23:45:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MmmSp5D4wzKFQP;
        Tue, 11 Oct 2022 14:43:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD39sgQEUVj3FxfAA--.20636S4;
        Tue, 11 Oct 2022 14:45:38 +0800 (CST)
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
        "Paul E . McKenney" <paulmck@kernel.org>,
        Delyan Kratunov <delyank@fb.com>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [PATCH bpf-next 0/3] Remove unnecessary RCU grace period chaining
Date:   Tue, 11 Oct 2022 15:11:25 +0800
Message-Id: <20221011071128.3470622-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD39sgQEUVj3FxfAA--.20636S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW8WFy3XFWxGw15Ar1xGrg_yoW8Jw4rpF
        W8tFn8GFn5Ar4Sk3ZxZr4xGryUJws3G34xXFyFk34fA398AryDCr12qa45uF13K3ykAa42
        vrn8Jw15G3Wqva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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
will imply one normal RCU grace period. And it also means there is no
need to do call_rcu() or kfree_rcu() again in the callback of
call_rcu_tasks_trace() in these grace period chains, so just remove the
unnecessary call_rcu() or kfree_rcu() calls.

Comments are always welcome.

Hou Tao (3):
  bpf: Free elements after one RCU-tasks-trace grace period
  bpf: Free local storage memory after one RCU-tasks-trace grace period
  bpf: Free trace program array after one RCU-tasks-trace grace period

 kernel/bpf/bpf_local_storage.c | 10 ++++++++--
 kernel/bpf/core.c              |  5 ++++-
 kernel/bpf/memalloc.c          | 17 ++++++-----------
 3 files changed, 18 insertions(+), 14 deletions(-)

-- 
2.29.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283F05A8DE2
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 08:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiIAGBk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 02:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIAGBi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 02:01:38 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C626E2C50
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 23:01:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MJ9P32CVnz6S5fH
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 13:59:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHGXO5ShBjaMHaAA--.4132S4;
        Thu, 01 Sep 2022 14:01:31 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Subject: [PATCH bpf-next v2 0/4] Use this_cpu_xxx for preemption-safety
Date:   Thu,  1 Sep 2022 14:19:34 +0800
Message-Id: <20220901061938.3789460-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHGXO5ShBjaMHaAA--.4132S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyUGFWfJr4xKFyftr1xAFb_yoW8uw15pa
        yxt345Kr1kK3Z3AwsrJwsrZryFywn5Xw42krs5AFnaya18tryfXr1xKr15ZF9xuryFqr1f
        Z39YgFs5C348ZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The patchset aims to make the update of per-cpu prog->active and per-cpu
bpf_task_storage_busy being preemption-safe. The problem is on same
architectures (e.g. arm64), __this_cpu_{inc|dec|inc_return} are neither
preemption-safe nor IRQ-safe, so under fully preemptible kernel the
concurrent updates on these per-cpu variables may be interleaved and the
final values of these variables may be not zero.

Patch 1 & 2 use the preemption-safe per-cpu helpers to manipulate
prog->active and bpf_task_storage_busy. Patch 3 & 4 add a test case in
map_tests to show the concurrent updates on the per-cpu
bpf_task_storage_busy by using __this_cpu_{inc|dec} are not atomic.

Comments are always welcome.

Regards,
Tao

Change Log:
v2:
* Patch 1: update commit message to indicate the problem is only
  possible for fully preemptible kernel
* Patch 2: a new patch which fixes the problem for prog->active
* Patch 3 & 4: move it to test_maps and make it depend on CONFIG_PREEMPT
 
v1: https://lore.kernel.org/bpf/20220829142752.330094-1-houtao@huaweicloud.com/

Hou Tao (4):
  bpf: Use this_cpu_{inc|dec|inc_return} for bpf_task_storage_busy
  bpf: Use this_cpu_{inc_return|dec} for prog->active
  selftests/bpf: Move sys_pidfd_open() into task_local_storage_helpers.h
  selftests/bpf: Test concurrent updates on bpf_task_storage_busy

 kernel/bpf/bpf_local_storage.c                |   4 +-
 kernel/bpf/bpf_task_storage.c                 |   8 +-
 kernel/bpf/trampoline.c                       |   8 +-
 .../bpf/map_tests/task_storage_map.c          | 122 ++++++++++++++++++
 .../selftests/bpf/prog_tests/test_bprm_opts.c |  10 +-
 .../bpf/prog_tests/test_local_storage.c       |  10 +-
 .../bpf/progs/read_bpf_task_storage_busy.c    |  39 ++++++
 .../bpf/task_local_storage_helpers.h          |  18 +++
 8 files changed, 191 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/map_tests/task_storage_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c
 create mode 100644 tools/testing/selftests/bpf/task_local_storage_helpers.h

-- 
2.29.2


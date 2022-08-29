Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EA35A4ED3
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 16:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiH2OJv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 10:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiH2OJu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 10:09:50 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0B2E6F
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 07:09:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MGXMn0nDHzKFjm
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 22:08:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXOmyAxjiPRgAA--.56898S4;
        Mon, 29 Aug 2022 22:09:44 +0800 (CST)
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
Subject: [PATCH bpf-next 0/3] make bpf_task_storage_busy being preemption-safe
Date:   Mon, 29 Aug 2022 22:27:49 +0800
Message-Id: <20220829142752.330094-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXOmyAxjiPRgAA--.56898S4
X-Coremail-Antispam: 1UD129KBjvJXoWrZrW7KF4fZr45Ww15Zr4fZrb_yoW8Jry8pr
        Wxtr1Yyr1kK3Z3ZwsxJrs7ZrWrJ34kXw47KFs5tF9ayr4ktryrXr1xKr18uF9xCryFqr1f
        Zas0gFs5Ww4UZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
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

The patchset aims to make the update of bpf_task_storage_busy being
preemption-safe. The problem is on same architectures (e.g. arm64),
__this_cpu_{inc|dec|inc_return} are neither preemption-safe nor
IRQ-safe, so the concurrent lookups or updates on the same task local
storage and the same CPU may make bpf_task_storage_busy be imbalanced,
and bpf_task_storage_trylock() on specific cpu will always fail.

Patch 1 fixes the problem by using preemption/IRQ-safe per-cpu helpers.
And patch 2 & patch 3 add a test case for the problem. Comments are
always welcome.

Regards,
Tao

Hou Tao (3):
  bpf: Use this_cpu_{inc|dec|inc_return} for bpf_task_storage_busy
  selftests/bpf: Move sys_pidfd_open() into test_progs.h
  selftests/bpf: Test concurrent updates on bpf_task_storage_busy

 kernel/bpf/bpf_local_storage.c                |  4 +-
 kernel/bpf/bpf_task_storage.c                 |  8 +-
 .../bpf/prog_tests/task_local_storage.c       | 91 +++++++++++++++++++
 .../selftests/bpf/prog_tests/test_bprm_opts.c |  9 --
 .../bpf/prog_tests/test_local_storage.c       |  9 --
 tools/testing/selftests/bpf/test_progs.h      |  9 ++
 6 files changed, 106 insertions(+), 24 deletions(-)

-- 
2.29.2


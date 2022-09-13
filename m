Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850335B77C6
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 19:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiIMRXq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 13:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbiIMRXK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 13:23:10 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3145F99250;
        Tue, 13 Sep 2022 09:10:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MRpLD0B7jzl56c;
        Wed, 14 Sep 2022 00:08:52 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgBHB4dxqyBjcEAeAw--.28569S2;
        Wed, 14 Sep 2022 00:10:26 +0800 (CST)
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
Date:   Tue, 13 Sep 2022 12:27:28 -0400
Message-Id: <20220913162732.163631-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBHB4dxqyBjcEAeAw--.28569S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW7JFWkKryUGFW8tryfXrb_yoW8XFy7pa
        9rurn8Gr4UCFsakFyfu3Z7ury3Jw4kJry5Xa47A34Fkrn09FyUGr1SvrnxGw47JrZrJ3y2
        gFyY9rWYgF1UXa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
        x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
        CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds ftrace direct call for arm64, which is required to attach
bpf trampoline to fentry.

Although there is no agreement on how to support ftrace direct call on arm64,
no patch has been posted except the one I posted in [1], so this series
continues the work of [1] with the addition of long jump support. Now ftrace
direct call works regardless of the distance between the callsite and custom
trampoline.

[1] https://lore.kernel.org/bpf/20220518131638.3401509-2-xukuohai@huawei.com/

v2:
- Fix compile and runtime errors caused by ftrace_rec_arch_init

v1: https://lore.kernel.org/bpf/20220913063146.74750-1-xukuohai@huaweicloud.com/

Xu Kuohai (4):
  ftrace: Allow users to disable ftrace direct call
  arm64: ftrace: Support long jump for ftrace direct call
  arm64: ftrace: Add ftrace direct call support
  ftrace: Fix dead loop caused by direct call in ftrace selftest

 arch/arm64/Kconfig                |   2 +
 arch/arm64/Makefile               |   4 +
 arch/arm64/include/asm/ftrace.h   |  35 ++++--
 arch/arm64/include/asm/patching.h |   2 +
 arch/arm64/include/asm/ptrace.h   |   6 +-
 arch/arm64/kernel/asm-offsets.c   |   1 +
 arch/arm64/kernel/entry-ftrace.S  |  39 ++++--
 arch/arm64/kernel/ftrace.c        | 198 ++++++++++++++++++++++++++++--
 arch/arm64/kernel/patching.c      |  14 +++
 arch/arm64/net/bpf_jit_comp.c     |   4 +
 include/linux/ftrace.h            |   2 +
 kernel/trace/Kconfig              |   7 +-
 kernel/trace/ftrace.c             |   9 +-
 kernel/trace/trace_selftest.c     |   2 +
 14 files changed, 296 insertions(+), 29 deletions(-)

-- 
2.30.2


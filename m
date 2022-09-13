Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24D55B67D8
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 08:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiIMGYO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 02:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiIMGYM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 02:24:12 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FB795BC;
        Mon, 12 Sep 2022 23:24:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MRYKL6d9bzKFS0;
        Tue, 13 Sep 2022 14:22:14 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgCHSYkDIiBjT3sKAw--.4735S2;
        Tue, 13 Sep 2022 14:24:04 +0800 (CST)
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
Subject: [PATCH bpf-next 0/4] Add ftrace direct call for arm64
Date:   Tue, 13 Sep 2022 02:31:42 -0400
Message-Id: <20220913063146.74750-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHSYkDIiBjT3sKAw--.4735S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyDGF1fXrW8uw4fWrykKrg_yoW8GrWfpa
        9rurnxGr4UCFsakFyfu3Z3ury3Jw4kJry5Ja47A34Fkrn09FyUWrnayrnrCw4UJr9rJ3y2
        qFyYvrWrKF4UXa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

This series adds ftrace direct call for arm64, which is required to attach
bpf trampoline to fentry.

Although there is no agreement on how to support ftrace direct call on arm64,
no patch has been posted except the one I posted in [1], so this series
continues the work of [1] with the addition of long jump support. Now ftrace
direct call works regardless of the distance between the callsite and custom
trampoline.

[1] https://lore.kernel.org/bpf/20220518131638.3401509-2-xukuohai@huawei.com/

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
 kernel/trace/Kconfig              |   7 +-
 kernel/trace/ftrace.c             |  10 +-
 kernel/trace/trace_selftest.c     |   2 +
 13 files changed, 295 insertions(+), 29 deletions(-)

-- 
2.30.2


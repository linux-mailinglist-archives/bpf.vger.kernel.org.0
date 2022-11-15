Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CCB62A0CF
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 18:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiKOR5e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 12:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiKOR5d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 12:57:33 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38C82F387;
        Tue, 15 Nov 2022 09:57:30 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NBYcj3pJpz9xs6N;
        Wed, 16 Nov 2022 01:50:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCHcW7o0nNj73dpAA--.16599S2;
        Tue, 15 Nov 2022 18:57:07 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 0/4] security: Ensure LSMs return expected values
Date:   Tue, 15 Nov 2022 18:56:48 +0100
Message-Id: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHcW7o0nNj73dpAA--.16599S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW5WrW3JFWxWw18Jr45Awb_yoW5Ary3pF
        sayFyYyr4qka47urs3Aan7ZayrC395GrWjkF98Jw1vv3Z5Cr1Yyr45Kw1YqFyxCrW0kr1r
        tr1av398u34DZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
        F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
        kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
        xVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
        UI43ZEXa7IU0bAw3UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBF1jj4V5ZAABs8
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

LSMs should follow the conventions stated in include/linux/lsm_hooks.h for
return values, as these conventions are followed by callers of the LSM
infrastructure for error handling.

The ability of an LSM to return arbitrary values could cause big troubles.
For LSMs aiming at being upstreamed, this event is unlikely, as each LSM is
carefully reviewed and it won't be accepted if it does not meet the return
value conventions. However, the recent introduction of BPF LSM allows
security modules (not part of the kernel) to inject arbitrary values,
without BPF LSM verifying them.

The initial idea was to fix BPF LSM itself. However, due to technical
difficulties to determine the precise interval of return values from a
static code analysis of eBPF programs, the new approach was to put the
fix in the LSM infrastructure, so that all LSMs can benefit from this work
as well.

The biggest problem of allowing arbitrary return values is when an LSM
returns a positive value, instead of a negative value, as it could be
converted to a pointer. Since such pointer escapes the IS_ERR() check, its
use later in the code can cause unpredictable consequences (e.g. invalid
memory access).

Another problem is returning zero when an LSM is supposed to have done some
operations. For example, the inode_init_security hook expects that their
implementations return zero only if they set the fields of the new xattr to
be added to the new inode. Otherwise, other kernel subsystems might
encounter unexpected conditions leading to a crash (e.g.
evm_protected_xattr_common() getting NULL as argument). This problem is
addressed separately in another patch set.

Finally, there are LSM hooks which are supposed to return just 1 as
positive value, or non-negative values. Also in these cases, although it
seems less critical, it is safer to return to callers of the LSM
infrastructure more precisely what they expect.

Patches 1 and 2 ensure that the documentation of LSM return values is
complete and accurate. Then, patch 3 introduces four flags (LSM_RET_NEG,
LSM_RET_ZERO, LSM_RET_ONE, LSM_RET_GT_ONE), one for each interval of
interest (< 0, = 0, = 1, > 1), and sets the correct flags for each LSM
hook. Finally, patch 4 verifies for each return value from LSMs that it is
an expected one.

Roberto Sassu (4):
  lsm: Clarify documentation of vm_enough_memory hook
  lsm: Add missing return values doc in lsm_hooks.h and fix formatting
  lsm: Redefine LSM_HOOK() macro to add return value flags as argument
  security: Enforce limitations on return values from LSMs

 include/linux/bpf_lsm.h       |   2 +-
 include/linux/lsm_hook_defs.h | 779 ++++++++++++++++++++--------------
 include/linux/lsm_hooks.h     | 136 ++++--
 kernel/bpf/bpf_lsm.c          |   5 +-
 security/bpf/hooks.c          |   2 +-
 security/security.c           |  38 +-
 6 files changed, 589 insertions(+), 373 deletions(-)

-- 
2.25.1


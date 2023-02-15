Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C795169779D
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 08:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjBOHxR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 02:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjBOHxQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 02:53:16 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B2E13D6C
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 23:53:15 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PGr0j4PVyz4f3l79
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 15:53:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgCX_7Jjj+xjJrigDg--.18949S4;
        Wed, 15 Feb 2023 15:53:09 +0800 (CST)
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
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        houtao1@huawei.com
Subject: [PATCH bpf-next 0/2] Use __GFP_ZERO in bpf memory allocator
Date:   Wed, 15 Feb 2023 16:21:30 +0800
Message-Id: <20230215082132.3856544-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX_7Jjj+xjJrigDg--.18949S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4UXFW8trWfWF1DuryDWrg_yoW8Wry3pa
        95G343WryUtFnxJrn3Aw429FWrCan5CF4UCF1agr15Zw1rXrn7Jr1Igr45XFy5ArWrWFn3
        ZrnFgrn3u3W0vrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Hi,

The patchset tries to fix the hard-up problem found when checking how htab
handles element reuse in bpf memory allocator. The immediate reuse of
freed elements will reinitialize special fields (e.g., bpf_spin_lock) in
htab map value and it may corrupt lookup procedure with BFP_F_LOCK flag
which acquires bpf-spin-lock during value copying, and lead to hard-lock
as shown in patch #2. Patch #1 fixes it by using __GFP_ZERO when allocating
the object from slab and the behavior is similar with the preallocated
hash-table case. Please see individual patches for more details. And comments
are always welcome.

Regards,

Change Log:
v1:
  * Use __GFP_ZERO instead of ctor to avoid retpoline overhead (from Alexei)
  * Add comments for check_and_init_map_value() (from Alexei)
  * split __GFP_ZERO patches out of the original patchset to unblock
    the development work of others.

RFC: https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.com


Hou Tao (2):
  bpf: Zeroing allocated object from slab in bpf memory allocator
  selftests/bpf: Add test case for element reuse in htab map

 include/linux/bpf.h                           |   7 ++
 kernel/bpf/hashtab.c                          |   4 +-
 kernel/bpf/memalloc.c                         |   2 +-
 .../selftests/bpf/prog_tests/htab_reuse.c     | 101 ++++++++++++++++++
 .../testing/selftests/bpf/progs/htab_reuse.c  |  19 ++++
 5 files changed, 130 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_reuse.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_reuse.c

-- 
2.29.2


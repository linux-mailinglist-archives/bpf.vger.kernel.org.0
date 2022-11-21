Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37129631A02
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 08:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiKUHJL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 02:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKUHJJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 02:09:09 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2284175BC
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 23:09:06 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NFz5S5MFHz4f3jZ5
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 15:09:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgC329gLJHtjFJKWAw--.51545S4;
        Mon, 21 Nov 2022 15:09:01 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Subject: [PATCH bpf-next v3 0/3] bpf: Pin the start cgroup for cgroup iterator
Date:   Mon, 21 Nov 2022 15:34:37 +0800
Message-Id: <20221121073440.1828292-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC329gLJHtjFJKWAw--.51545S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww45GF18Ww45WrWUWr17Jrb_yoW8Aw4fpF
        n5Ww45Kw1fCF42qw47K342ga4Fkan5Gw47Xr1fX3sxCa17JFyIgrWIkr45CFn8JFZxXrnx
        AF1FkFs5u3WUArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Hi,

The patchset tries to fix the potential use-after-free problem in cgroup
iterator. The problem is similar with the UAF problem fixed in map
iterator and the fix is also similar: pinning the iterated resource in
.init_seq_private() and unpinning it in .fini_seq_private(). An
alternative fix is pinning iterator link when opening iterator fd, but
it will make iterator link still being visible after the close of
iterator link fd and the behavior is different with other link types, so
just fixing the bug alone by pinning the start cgroup when creating
cgroup iterator. Also adding a selftests to demonstrate the UAF problem
when iterating a dead cgroup.

Comments are always welcome.

Change Log:
v3:
 * Target bpf-next instead of bpf
 * Patch 1: Use the solution proposed in v1, because pinning iterator
   link will make it behaving different with other link types.
 * Patch 3: Add Acked-by from Hao Luo

v2: https://lore.kernel.org/bpf/20221111063417.1603111-1-houtao@huaweicloud.com/
 * Patch 1: Pinning iterator link when opening iterator, instead of
   acquiring the reference of start cgroup in cgroup_iter_seq_init().
 * Patch 2 & 3: Address comments from Yonghong Song and add Acked-by tag

v1: https://lore.kernel.org/bpf/20221107074222.1323017-1-houtao@huaweicloud.com/

Hou Tao (3):
  bpf: Pin the start cgroup in cgroup_iter_seq_init()
  selftests/bpf: Add cgroup helper remove_cgroup()
  selftests/bpf: Add test for cgroup iterator on a dead cgroup

 kernel/bpf/cgroup_iter.c                      | 14 ++++
 tools/testing/selftests/bpf/cgroup_helpers.c  | 19 +++++
 tools/testing/selftests/bpf/cgroup_helpers.h  |  1 +
 .../selftests/bpf/prog_tests/cgroup_iter.c    | 76 +++++++++++++++++++
 4 files changed, 110 insertions(+)

-- 
2.29.2


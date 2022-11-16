Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11DF62B397
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 07:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiKPG6T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 01:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiKPG6S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 01:58:18 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A229BB1EE
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 22:58:16 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NBv5G3zx3z4f3m7b
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 14:58:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDH69gBinRjrfhyAg--.6637S4;
        Wed, 16 Nov 2022 14:58:11 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        David Vernet <void@manifault.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Subject: [PATCH bpf v2 0/4] libbpf: Fixes for ring buffer
Date:   Wed, 16 Nov 2022 15:23:47 +0800
Message-Id: <20221116072351.1168938-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDH69gBinRjrfhyAg--.6637S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4DWFy7JrykXw47ZF4DCFg_yoWkZFg_C3
        yktFW5G3W7XF4kKFyIyrZxtrykGaykGr18XayDtF47ur1UCFyFyw1furykJFyY9FW0vr1k
        WrnxZrZ3Aw1agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
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

The patch set tries to fix the problems found when testing ringbuf by
using 4KB and 2GB size. Patch 1 fixes the probe of ring buffer map on
host with 64KB page (e.g., an ARM64 host). Patch 2 & 3 fix the overflow
of length when mmaping 2GB kernel ringbuf or user ringbuf on libbpf.
Patch 4 just reject the reservation with invalid size.

Please see individual patch for details. And comments are always
welcome.

Change Log:
v2:
 * patch 1: use page size instead of adjust_ringbuf_sz(4096) as main_entries (suggested by Stanislav)
 * patch 2 & 3: use "mmap_sz" instead of "ro_size/wr_size" as name of mmap length (From Andrii)
v1: https://lore.kernel.org/bpf/20221111092642.2333724-1-houtao@huaweicloud.com
 
Hou Tao (4):
  libbpf: Use page size as max_entries when probing ring buffer map
  libbpf: Handle size overflow for ringbuf mmap
  libbpf: Handle size overflow for user ringbuf mmap
  libbpf: Check the validity of size in user_ring_buffer__reserve()

 tools/lib/bpf/libbpf_probes.c |  2 +-
 tools/lib/bpf/ringbuf.c       | 26 ++++++++++++++++++++++----
 2 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.29.2


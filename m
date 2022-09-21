Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353F35BF3AD
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 04:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiIUCoN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 22:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiIUCoM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 22:44:12 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A6F7D1F0;
        Tue, 20 Sep 2022 19:44:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MXN3k3NWWzKLKs;
        Wed, 21 Sep 2022 10:42:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP1 (Coremail) with SMTP id cCh0CgD3xCh3eipjRFhmBA--.50399S2;
        Wed, 21 Sep 2022 10:44:09 +0800 (CST)
From:   Pu Lehui <pulehui@huaweicloud.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf v5 0/3] Fix wrong cgroup attach flags being assigned to effective progs
Date:   Wed, 21 Sep 2022 10:46:01 +0000
Message-Id: <20220921104604.2340580-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgD3xCh3eipjRFhmBA--.50399S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW7KrWktFy3Aw43Xr45Awb_yoW5GF4kpF
        WkZ3W5Jwn8Wr93JrWSk34jga4rtw48Aw1jy3ZrXr48uFyxtryqyrWIk3yFkr17XFsrKw4x
        Zw15ZF98G3y5taDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
        kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3
        JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
        UvcSsGvfC2KfnxnUUI43ZEXa7sRiPl1DUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Pu Lehui <pulehui@huawei.com>

When root-cgroup attach multi progs and sub-cgroup attach a
override prog, bpftool will display incorrectly for the attach
flags of the sub-cgroup’s effective progs:

$ bpftool cgroup tree /sys/fs/cgroup effective
CgroupPath
ID       AttachType      AttachFlags     Name
/sys/fs/cgroup
6        cgroup_sysctl   multi           sysctl_tcp_mem
13       cgroup_sysctl   multi           sysctl_tcp_mem
/sys/fs/cgroup/cg1
20       cgroup_sysctl   override        sysctl_tcp_mem
6        cgroup_sysctl   override        sysctl_tcp_mem <- wrong
13       cgroup_sysctl   override        sysctl_tcp_mem <- wrong
/sys/fs/cgroup/cg1/cg2
20       cgroup_sysctl                   sysctl_tcp_mem
6        cgroup_sysctl                   sysctl_tcp_mem
13       cgroup_sysctl                   sysctl_tcp_mem

For cg1, obviously, the attach flags of prog6 and prog13 can not be
OVERRIDE. And for query with EFFECTIVE flags, exporting attach flags
does not make sense. So let's remove the AttachFlags field and the
associated logic. After these patches, the above effective cgroup
tree will show as bellow:

# bpftool cgroup tree /sys/fs/cgroup effective
CgroupPath
ID       AttachType      Name
/sys/fs/cgroup
6        cgroup_sysctl   sysctl_tcp_mem
13       cgroup_sysctl   sysctl_tcp_mem
/sys/fs/cgroup/cg1
20       cgroup_sysctl   sysctl_tcp_mem
6        cgroup_sysctl   sysctl_tcp_mem
13       cgroup_sysctl   sysctl_tcp_mem
/sys/fs/cgroup/cg1/cg2
20       cgroup_sysctl   sysctl_tcp_mem
6        cgroup_sysctl   sysctl_tcp_mem
13       cgroup_sysctl   sysctl_tcp_mem

v5:
- Adapt selftests for effective query uapi change.

v4:
https://lore.kernel.org/bpf/20220920154233.1494352-1-pulehui@huaweicloud.com
- Reject prog_attach_flags array when effective query. (Martin)
- Target to bpf tree. (Martin)

v3:
https://lore.kernel.org/bpf/20220914161742.3180731-1-pulehui@huaweicloud.com
- Don't show attach flags when effective query. (John, sdf, Martin)

v2:
https://lore.kernel.org/bpf/20220908145304.3436139-1-pulehui@huaweicloud.com
- Limit prog_cnt to avoid overflow. (John)
- Add more detail message.

v1:
https://lore.kernel.org/bpf/20220820120234.2121044-1-pulehui@huawei.com

Pu Lehui (3):
  bpf, cgroup: Reject prog_attach_flags array when effective query
  bpftool: Fix wrong cgroup attach flags being assigned to effective
    progs
  selftests/bpf: Adapt cgroup effective query uapi change

 include/uapi/linux/bpf.h                      |  7 ++-
 kernel/bpf/cgroup.c                           | 28 ++++++----
 tools/bpf/bpftool/cgroup.c                    | 54 +++++++++++++++++--
 tools/include/uapi/linux/bpf.h                |  7 ++-
 .../selftests/bpf/prog_tests/cgroup_link.c    | 11 ++--
 5 files changed, 81 insertions(+), 26 deletions(-)

-- 
2.25.1


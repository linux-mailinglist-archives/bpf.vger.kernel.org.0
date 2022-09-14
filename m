Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329A35B82C3
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 10:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiINIQS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Sep 2022 04:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiINIQA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Sep 2022 04:16:00 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B4652E78;
        Wed, 14 Sep 2022 01:15:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MSClv6dWkzKPsg;
        Wed, 14 Sep 2022 16:14:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP2 (Coremail) with SMTP id Syh0CgB3yXK6jSFjj9FPAw--.59270S2;
        Wed, 14 Sep 2022 16:15:55 +0800 (CST)
From:   Pu Lehui <pulehui@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next v3 0/2] Fix wrong cgroup attach flags being assigned to effective progs
Date:   Wed, 14 Sep 2022 16:17:40 +0000
Message-Id: <20220914161742.3180731-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgB3yXK6jSFjj9FPAw--.59270S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWkWF1xKw1DGFy3JFW5Wrg_yoW8ur17pF
        95A3W3twn8ur93JrWSya4jga4rKr48Aw12y3ZrXr48Zr1xtryqyry2y3y0yry7XFZrGw4x
        ZF15AFy5Gw45taDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
        tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
        0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
        80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v
        6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjxUIf-PUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
does not make sense, we can remove this logic. After these patches,
the above situation will show as bellow:

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

v3:
- Don't show attach flags when effective query. (John, sdf, martin)

v2:
https://lore.kernel.org/bpf/20220908145304.3436139-1-pulehui@huaweicloud.com
- Limit prog_cnt to avoid overflow. (John)
- Add more detail message.

v1:
https://lore.kernel.org/bpf/20220820120234.2121044-1-pulehui@huawei.com

Pu Lehui (2):
  bpf, cgroup: Don't populate prog_attach_flags array when effective
    query
  bpftool: Fix wrong cgroup attach flags being assigned to effective
    progs

 kernel/bpf/cgroup.c        | 23 +++++++++-------
 tools/bpf/bpftool/cgroup.c | 54 +++++++++++++++++++++++---------------
 2 files changed, 46 insertions(+), 31 deletions(-)

-- 
2.25.1


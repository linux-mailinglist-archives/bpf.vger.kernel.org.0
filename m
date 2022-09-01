Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087AE5A8E49
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 08:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiIAGdZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 02:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiIAGdY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 02:33:24 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C068A5C78
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 23:33:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MJB5j4fgJzKQ5D
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 14:31:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgBH53AtUhBjxrnbAA--.33718S4;
        Thu, 01 Sep 2022 14:33:19 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
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
Subject: [PATCH bpf-next] bpf: Only add BTF IDs for socket security hooks when CONFIG_SECURITY_NETWORK is on
Date:   Thu,  1 Sep 2022 14:51:26 +0800
Message-Id: <20220901065126.3856297-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH53AtUhBjxrnbAA--.33718S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tF45Wr4fZFy3Jw17XFWfuFg_yoW8Cryfpr
        4xCFWjk39Yyw43Ka1UtFs5ur13twsYganFkr1Ut3W2vFW8XF1rX34Iyr4DKFW3Wr9rtrs3
        KFWa9w1Fvw17ua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
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

When CONFIG_SECURITY_NETWORK is disabled, there will be build warnings
from resolve_btfids:

  WARN: resolve_btfids: unresolved symbol bpf_lsm_socket_socketpair
  ......
  WARN: resolve_btfids: unresolved symbol bpf_lsm_inet_conn_established

Fixing it by wrapping these BTF ID definitions by CONFIG_SECURITY_NETWORK.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/bpf_lsm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index fa71d58b7ded..832a0e48a2a1 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -41,17 +41,21 @@ BTF_SET_END(bpf_lsm_hooks)
  */
 BTF_SET_START(bpf_lsm_current_hooks)
 /* operate on freshly allocated sk without any cgroup association */
+#ifdef CONFIG_SECURITY_NETWORK
 BTF_ID(func, bpf_lsm_sk_alloc_security)
 BTF_ID(func, bpf_lsm_sk_free_security)
+#endif
 BTF_SET_END(bpf_lsm_current_hooks)
 
 /* List of LSM hooks that trigger while the socket is properly locked.
  */
 BTF_SET_START(bpf_lsm_locked_sockopt_hooks)
+#ifdef CONFIG_SECURITY_NETWORK
 BTF_ID(func, bpf_lsm_socket_sock_rcv_skb)
 BTF_ID(func, bpf_lsm_sock_graft)
 BTF_ID(func, bpf_lsm_inet_csk_clone)
 BTF_ID(func, bpf_lsm_inet_conn_established)
+#endif
 BTF_SET_END(bpf_lsm_locked_sockopt_hooks)
 
 /* List of LSM hooks that trigger while the socket is _not_ locked,
@@ -59,8 +63,10 @@ BTF_SET_END(bpf_lsm_locked_sockopt_hooks)
  * in the early init phase.
  */
 BTF_SET_START(bpf_lsm_unlocked_sockopt_hooks)
+#ifdef CONFIG_SECURITY_NETWORK
 BTF_ID(func, bpf_lsm_socket_post_create)
 BTF_ID(func, bpf_lsm_socket_socketpair)
+#endif
 BTF_SET_END(bpf_lsm_unlocked_sockopt_hooks)
 
 #ifdef CONFIG_CGROUP_BPF
-- 
2.29.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB11741005
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 13:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjF1L1F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 07:27:05 -0400
Received: from dggsgout12.his.huawei.com ([45.249.212.56]:11137 "EHLO
        dggsgout12.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjF1L1D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jun 2023 07:27:03 -0400
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QrfS23XxKz4f3tDC;
        Wed, 28 Jun 2023 19:26:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgBn0LP_GJxk+A_oMg--.17043S5;
        Wed, 28 Jun 2023 19:27:00 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [PATCH bpf-next v7 1/2] selftests/bpf: Add min() and max() macros in bpf_util.h
Date:   Wed, 28 Jun 2023 19:59:09 +0800
Message-Id: <20230628115910.3817966-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230628115910.3817966-1-houtao@huaweicloud.com>
References: <20230628115910.3817966-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn0LP_GJxk+A_oMg--.17043S5
X-Coremail-Antispam: 1UD129KBjvdXoWrZr1xur48JryDJF4fAFW7CFg_yoW3uFcEgr
        WFyr97AFWkAFyqvF1UCFyruFWxGayrWrW2yr15KFy3CFnF9a1rJF4v9ry5ZF9aga98Gay3
        tFsYyrW3tr45KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
        8IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
        021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F
        4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
        oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
        C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
        6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
        AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn9N3UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

max() will be used by the following htab-mem benchmark patch.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/bpf_util.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
index 10587a29b967..e87e9f8c13a7 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -59,4 +59,11 @@ static inline void bpf_strlcpy(char *dst, const char *src, size_t sz)
 	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
 #endif
 
+#ifndef min
+#define min(x, y) ((x) < (y) ? (x) : (y))
+#endif
+#ifndef max
+#define max(x, y) ((x) < (y) ? (y) : (x))
+#endif
+
 #endif /* __BPF_UTIL__ */
-- 
2.29.2


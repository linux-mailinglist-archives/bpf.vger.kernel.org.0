Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE90B6DA98B
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 09:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjDGHst (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 03:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjDGHsr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 03:48:47 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F585B83
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 00:48:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pt9V14TJzz4f3tps
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 15:48:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbDYyi9kCcuPGw--.24781S4;
        Fri, 07 Apr 2023 15:48:42 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, bpf@vger.kernel.org
Subject: [PATCH bpf-next] bpftool: set program type only if it differs from the desired one
Date:   Fri,  7 Apr 2023 08:14:26 +0000
Message-Id: <20230407081427.2621590-1-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbDYyi9kCcuPGw--.24781S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uF45Gw13GF1UZrWxJr1DJrb_yoW8GF45pa
        yDX34UKry8Wry5A348A3yrXrW5KFs2gryUJrW8Xr1Y9F1kXrZYvFyfKF4jyr1Yg343ta4F
        va1YkryrXw18ZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5zhl50pqjm3046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=KHOP_HELO_FCRDNS,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

After commit d6e6286a12e7 ("libbpf: disassociate section handler on explicit
bpf_program__set_type() call"), bpf_program__set_type() will force cleanup
the program's SEC() definition, this commit fixed the test helper but missed
the bpftool, which leads to bpftool prog autoattach broken as follows:

  $ bpftool prog load spi-xfer-r1v1.o /sys/fs/bpf/test autoattach
  Program spi_xfer_r1v1 does not support autoattach, falling back to pinning

This patch fix bpftool to set program type only if it differs.

Fixes: d6e6286a12e7 ("libbpf: disassociate section handler on explicit bpf_program__set_type() call")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 tools/bpf/bpftool/prog.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index afbe3ec342c8..9b377db08597 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1681,7 +1681,8 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		}
 
 		bpf_program__set_ifindex(pos, ifindex);
-		bpf_program__set_type(pos, prog_type);
+		if (bpf_program__type(pos) != prog_type)
+			bpf_program__set_type(pos, prog_type);
 		bpf_program__set_expected_attach_type(pos, expected_attach_type);
 	}
 
-- 
2.34.1


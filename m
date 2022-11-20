Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1AC6312EB
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 08:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiKTH6G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 02:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKTH6F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 02:58:05 -0500
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8D120F66;
        Sat, 19 Nov 2022 23:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1668931078;
        bh=d4ahvWb2gNc1rhQu8JuZV0eJfYfDExPnefQFcNGCdWU=;
        h=From:To:Cc:Subject:Date;
        b=IdNo8jui8le2HIQ8NVTqmg0n8xhxY3Rrrb2D3u9EWgkMAx2fdst1LHI1w5VhxryCA
         o4y6CQS5jhDyiwWltbLEzJd9iUvSEvBnJtApYs2gbZs3cv7I73k6P0LmFEgiTVs3ZK
         1UZ0xAAVpkMygeqCKpDCx5tQZOLOl4bzAoTeRnBc=
Received: from rtoax.. ([111.199.191.46])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id E759BAC1; Sun, 20 Nov 2022 15:57:53 +0800
X-QQ-mid: xmsmtpt1668931073tm5can0j3
Message-ID: <tencent_7F84D04F96EBE594CAD5EBD12815A2B00106@qq.com>
X-QQ-XMAILINFO: OC704IrkdJt6FR5h+jFcRqcFPR/JwCe/gbhfN7SRnUcsP5N5wTBJQteuPOWcKR
         8/RlE/HbME4+xyU5b4L88i1o+V4EoLyTQz3+ft0vAMVnTn2HpOLMfYK1sjvmb3RIeu/R/X8fxpUZ
         ycyc07CLGHztvASlhieB/4dPOlJ5xakRKNhF2kbrl0eckBzC5XIyyylp00a1ADcQBcJ3JA1giY1c
         AQtJ0KDU9GAqDRw+Fr92Q3s5b+BNqVgHDgr1lGD/HLWIj/iqXfIzfc4SSiZIxwVRbkjXR5KDBYIl
         g+jjxJnjXh0QnH4Ep+BtSkWo96mnT8ycMd5uE34w76Q8N8St+ZnFUZ2DYjbnFpSmIv+47t4E+dKX
         XJqleWm98zMaD8GhFLADnJmlujjyfd1DxiZaCdladj/DRqPVCaX5+8Q9HQq5InZonXOhQIBnwg57
         GDbFQ8dujLo6yZ7AIuIVzfuYVaID0EJts5biy+IUJLTb54bgMfQvBlvM8xV7HWP7bdywDCo3/WVL
         awGaUAeo1d9XOCOq3VNBhouJSTX6zSaSwubQnvh8SU6UfHMM0clGAZb/r2bTqa+lK9cPBjef8ffw
         RuptJidGmdRjRG7xS/45Lio+ingV4BYEtPWyameAXQuLnceTSAepU0KC0nY3exZm0F9baLv0B46b
         TEvNDHUK1zzo1lBcltGIAtm1Hn71lJLOFoodZl03/LAshbZSUGdwoE9qry05ed3tCeLPYVt9fEiS
         /7UJ+k4nxT7IzxA/E5kyLtKFlcZlmt/06EbTUds0H0PNsJ6MeTaqVvVZmXpeURoVql0yR3YCV3cm
         IZMFvQ0NY50wk/JVEs4iLtGyuwbv9tqbERWRlLXlE8sD2OrgGKpQv7AvIZ4He257awWW7KOLFFCg
         R73sW/4Uhk6WQ7L7u3HhRy4dB+oMTciqQNDY1WtzVvPijGKIzqY0goA/YLrgn0fntDvK0L4+5YgV
         xigPDs2444iHvuc5oL9HQKH0aPOdVKvdvypOAkgRO/8kIZapmfGw==
From:   Rong Tao <rtoax@foxmail.com>
To:     ast@kernel.org
Cc:     Rong Tao <rongtao@cestc.cn>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)), linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] docs/bpf: Update btf test programe code
Date:   Sun, 20 Nov 2022 15:57:51 +0800
X-OQ-MSGID: <20221120075751.24603-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

commit c64779e24e88("selftests/bpf: Merge most of test_btf into
test_progs") rename selftests/bpf btf test from 'test_btf.c' to
'prog_tests/btf.c'.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 Documentation/bpf/btf.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index cf8722f96090..59ccd9bad1e0 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -1062,4 +1062,5 @@ format.::
 7. Testing
 ==========
 
-Kernel bpf selftest `test_btf.c` provides extensive set of BTF-related tests.
+Kernel bpf selftest `prog_tests/btf.c` provides extensive set of BTF-related
+tests.
-- 
2.38.1


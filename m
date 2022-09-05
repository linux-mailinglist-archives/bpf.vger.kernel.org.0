Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D08B5ACE47
	for <lists+bpf@lfdr.de>; Mon,  5 Sep 2022 10:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbiIEIjD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 5 Sep 2022 04:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbiIEIiy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Sep 2022 04:38:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348B926ED;
        Mon,  5 Sep 2022 01:38:53 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MLhhV6737zrS8d;
        Mon,  5 Sep 2022 16:36:58 +0800 (CST)
Received: from dggpeml100010.china.huawei.com (7.185.36.14) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 16:38:51 +0800
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml100010.china.huawei.com (7.185.36.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 16:38:51 +0800
Received: from dggpeml500010.china.huawei.com ([7.185.36.155]) by
 dggpeml500010.china.huawei.com ([7.185.36.155]) with mapi id 15.01.2375.024;
 Mon, 5 Sep 2022 16:38:51 +0800
From:   "Liuxin(EulerOS)" <liuxin350@huawei.com>
To:     "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "854182924@qq.com" <854182924@qq.com>
CC:     "Yanan (Euler)" <yanan@huawei.com>,
        "Wuchangye (EulerOS)" <wuchangye@huawei.com>,
        Xiesongyang <xiesongyang@huawei.com>,
        "zhudi (E)" <zhudi2@huawei.com>,
        "kongweibin (A)" <kongweibin2@huawei.com>
Subject: [PATCH] libbpf: Clean up legacy bpf maps declaration in bpf_helpers
Thread-Topic: [PATCH] libbpf: Clean up legacy bpf maps declaration in
 bpf_helpers
Thread-Index: AdjBAj9xCLJDkVITTHKlRdMiRgqMGg==
Date:   Mon, 5 Sep 2022 08:38:50 +0000
Message-ID: <6d349d1047f44001b926f80ad5416245@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.136.113.250]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Legacy bpf maps declaration were no longer supported in Libbpf 1.0,
so it was time to remove the definition of bpf_map_def in
bpf_helpers.h.

LINK:[1] https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0

Signed-off-by: Liu Xin<liuxin350@huawei.com>
---
tools/lib/bpf/bpf_helpers.h | 12 ------------
1 file changed, 12 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 867b73483..9cad13e7f 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -167,18 +167,6 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
}
#endif

-/*
- * Helper structure used by eBPF C program
- * to describe BPF map attributes to libbpf loader
- */
-struct bpf_map_def {
-       unsigned int type;
-       unsigned int key_size;
-       unsigned int value_size;
-       unsigned int max_entries;
-       unsigned int map_flags;
-} __attribute__((deprecated("use BTF-defined maps in .maps section")));
-
enum libbpf_pin_type {
        LIBBPF_PIN_NONE,
        /* PIN_BY_NAME: pin maps by name (in /sys/fs/bpf by default) */
--
2.33.0

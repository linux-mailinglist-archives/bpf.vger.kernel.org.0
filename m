Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F1141B137
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 15:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbhI1NzU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 09:55:20 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:26950 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241009AbhI1NzT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 09:55:19 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HJgpn1JBtzbmq3;
        Tue, 28 Sep 2021 21:49:21 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 21:53:37 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 21:53:37 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Alexei Starovoitov <ast@kernel.org>
CC:     Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH bpf-next v3 1/3] bpf: support writable context for bare tracepoint
Date:   Tue, 28 Sep 2021 22:07:32 +0800
Message-ID: <20210928140734.1274261-2-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928140734.1274261-1-houtao1@huawei.com>
References: <20210928140734.1274261-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 9df1c28bb752 ("bpf: add writable context for raw tracepoints")
supports writable context for tracepoint, but it misses the support
for bare tracepoint which has no associated trace event.

Bare tracepoint is defined by DECLARE_TRACE(), so adding a corresponding
DECLARE_TRACE_WRITABLE() macro to generate a definition in __bpf_raw_tp_map
section for bare tracepoint in a similar way to DEFINE_TRACE_WRITABLE().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/trace/bpf_probe.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index a23be89119aa..a8e97f84b652 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -93,8 +93,7 @@ __section("__bpf_raw_tp_map") = {					\
 
 #define FIRST(x, ...) x
 
-#undef DEFINE_EVENT_WRITABLE
-#define DEFINE_EVENT_WRITABLE(template, call, proto, args, size)	\
+#define __CHECK_WRITABLE_BUF_SIZE(call, proto, args, size)		\
 static inline void bpf_test_buffer_##call(void)				\
 {									\
 	/* BUILD_BUG_ON() is ignored if the code is completely eliminated, but \
@@ -103,8 +102,12 @@ static inline void bpf_test_buffer_##call(void)				\
 	 */								\
 	FIRST(proto);							\
 	(void)BUILD_BUG_ON_ZERO(size != sizeof(*FIRST(args)));		\
-}									\
-__DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), size)
+}
+
+#undef DEFINE_EVENT_WRITABLE
+#define DEFINE_EVENT_WRITABLE(template, call, proto, args, size) \
+	__CHECK_WRITABLE_BUF_SIZE(call, PARAMS(proto), PARAMS(args), size) \
+	__DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), size)
 
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, call, proto, args)			\
@@ -119,9 +122,17 @@ __DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), size)
 	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))		\
 	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), 0)
 
+#undef DECLARE_TRACE_WRITABLE
+#define DECLARE_TRACE_WRITABLE(call, proto, args, size) \
+	__CHECK_WRITABLE_BUF_SIZE(call, PARAMS(proto), PARAMS(args), size) \
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args)) \
+	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), size)
+
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
+#undef DECLARE_TRACE_WRITABLE
 #undef DEFINE_EVENT_WRITABLE
+#undef __CHECK_WRITABLE_BUF_SIZE
 #undef __DEFINE_EVENT
 #undef FIRST
 
-- 
2.29.2


Return-Path: <bpf+bounces-9388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA16E796EC5
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 04:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8506128159B
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 02:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE69A47;
	Thu,  7 Sep 2023 02:02:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF3A29
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 02:02:49 +0000 (UTC)
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2BF122;
	Wed,  6 Sep 2023 19:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1694052165;
	bh=Lhf4n1nBq4VAEDet52XCaOndkj8vQcHGv7waBa1OZl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tIPaffZk2zXloZAMGcsG8P8Fc1If7O4/vMlMwJS9MCIs0Be0WQ8R7+c+UeUFlSZWk
	 OlkKFKiSiZ+W3mKMQ9THMSVxezOxXFi3AdkZf5yrGXm3RF4akv4Wb2w4nnFshXtMtX
	 8g5h/X+aXUvBnReQrZu1MaiQ8YRni9o93sB9xpmY=
Received: from RT-NUC.. ([39.156.73.12])
	by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
	id EEB27808; Thu, 07 Sep 2023 09:59:43 +0800
X-QQ-mid: xmsmtpt1694052001t6cwiynfr
Message-ID: <tencent_5D0A837E219E2CFDCB0495DAD7D5D1204407@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9GVejZOqymyOCfTJKiLGmBPL7+7quQyquwS3OB2Gq/OewjNcZQa
	 R3UmyCZo5Q1bz9iL/9q5RpvMvv/uWpt0ZY4mNaaQEQlqJ1plAMs4Y8okMUK1FFfRqp9rgx5lhcOQ
	 k1N7nMMXe6ZG7OZKFmSRKsaE24N8BGGkoTmMfVrMYfwjCOfTfyCn8tSgzKca7MR4palCrkZk+L8h
	 5azCXhUrb28MpbEcbt86qGaIZJtWgP7R1AymBcVyVaJOgSRq0RgAdIyNcxB/fry2nEiv7qfxjRUN
	 kzFfxTR6Rj+N7j8bsoC31krlbyUpmK3YBbyulMOF8Oy20H6/o658+DWsE+vySGOa++4OGyhyVRRx
	 6YBPAbYu+3sz+7ceWTCTN8C4Sen3vjcwoJfRHRhXAfHXGNP4eJAOtU+LQaxrcwZkBag9c3Pv4NyG
	 O4DjGMgBg2UUzN6WsGNJnhwo9b3Q4vURldACPNGHIQ3CiMTpTuTr2l6lsh+NFhu6ZXZ72TAojscq
	 L+9gJkTE/5QCpuwsfDfhYtB9jcbtOhXy4ms43Ll76rSo+ZYsIghKEUijqpllCUaYXHrm3s7GnFnD
	 vpfyGA+mlRe8n7Q4xKHw4qe01LKUbBDxX8nh0N34VwFhFannpTTneQ9tLuS2Mq33q63jz3gBin6q
	 b8Bz4SPvBtfsgZnkX3jSibCJ7FMR4JQFUi8gqFSXSnZR6iOd5xlxPvS8lca86br+fZHd9PjJedO1
	 bHgCyKlugrYH+Y4hpIor4soYylEJPksG833jeAfNV7Vw5qycDsqCcPNaqVwdkkSs7vhNTI0t231d
	 7+/we2ZLeX7QlfmzbsdlbcUZ13ZtKzMa5GvLFXnNFDZtVyk97ve6ZfB2c+MnXI/fELPJJmAADVCK
	 mtuNlioTc29T4+MnwbMrgiARcOURhupGt2BNumJXBqcuTkdm3/wLwz2Zv23Z+QZ0HZ1on0xYG0oe
	 L58wBOAYye2i1rJgmYRUnL9khIWydDgS6a/kkpjo3a2g0M9c/yEjC1aXuF/zQZUb65yOQmENs=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Rong Tao <rtoax@foxmail.com>
To: olsajiri@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net
Cc: Rong Tao <rongtao@cestc.cn>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE)
Subject: [PATCH bpf-next v12 2/2] selftests/bpf: trace_helpers.c: Add a global ksyms initialization mutex
Date: Thu,  7 Sep 2023 09:59:14 +0800
X-OQ-MSGID: <f1088b90f525d4a0a46d77c2e5bfcc3854015714.1694051654.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694051654.git.rongtao@cestc.cn>
References: <cover.1694051654.git.rongtao@cestc.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Rong Tao <rongtao@cestc.cn>

As Jirka said [0], we just need to make sure that global ksyms
initialization won't race.

[0] https://lore.kernel.org/lkml/ZPCbAs3ItjRd8XVh@krava/

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/trace_helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index dc4efaf538ae..4faa898ff7fc 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <poll.h>
+#include <pthread.h>
 #include <unistd.h>
 #include <linux/perf_event.h>
 #include <sys/mman.h>
@@ -26,6 +27,7 @@ struct ksyms {
 };
 
 static struct ksyms *ksyms;
+static pthread_mutex_t ksyms_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 static int ksyms__add_symbol(struct ksyms *ksyms, const char *name,
 			     unsigned long addr)
@@ -109,8 +111,10 @@ struct ksyms *load_kallsyms_local(void)
 
 int load_kallsyms(void)
 {
+	pthread_mutex_lock(&ksyms_mutex);
 	if (!ksyms)
 		ksyms = load_kallsyms_local();
+	pthread_mutex_unlock(&ksyms_mutex);
 	return ksyms ? 0 : 1;
 }
 
-- 
2.41.0



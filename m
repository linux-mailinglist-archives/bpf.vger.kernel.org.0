Return-Path: <bpf+bounces-19316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC71E829575
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 09:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E27B1B24D6D
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 08:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9F939AEF;
	Wed, 10 Jan 2024 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M73ETF37"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCDE3B185
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704877065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XsFJ64qhgo8dpCR3ZN8nHJuU62Q+ROyJhHepqFzOWSQ=;
	b=M73ETF37hSzFoY4AQb1GG2sT4Ag2nrJLQoJ4oyNkSjppMoGJUYrt/vkCvcfTvvT0k+tbYh
	r5Vp6Be4kdUFVh2kfjdjme1Kbw6/p6TeLZV3m61qaUBxNvKkb4tocdLV9I8LV1nPZ+8+gC
	W60Kws+uMtQsf0T/7Zq8Cbth7DR1xS8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-Rwth6r8GNb-AXO8Dgvsk6A-1; Wed,
 10 Jan 2024 03:57:42 -0500
X-MC-Unique: Rwth6r8GNb-AXO8Dgvsk6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 185543C0F185;
	Wed, 10 Jan 2024 08:57:42 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.45.226.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0A26BC15E6A;
	Wed, 10 Jan 2024 08:57:39 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	jolsa@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v2] selftests/bpf: fix potential premature unload in bpf_testmod
Date: Wed, 10 Jan 2024 09:57:37 +0100
Message-ID: <20240110085737.8895-1-asavkov@redhat.com>
In-Reply-To: <82f55c0e-0ec8-4fe1-8d8c-b1de07558ad9@linux.dev>
References: <82f55c0e-0ec8-4fe1-8d8c-b1de07558ad9@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

It is possible for bpf_kfunc_call_test_release() to be called from
bpf_map_free_deferred() when bpf_testmod is already unloaded and
perf_test_stuct.cnt which it tries to decrease is no longer in memory.
This patch tries to fix the issue by waiting for all references to be
dropped in bpf_testmod_exit().

The issue can be triggered by running 'test_progs -t map_kptr' in 6.5,
but is obscured in 6.6 by d119357d07435 ("rcu-tasks: Treat only
synchronous grace periods urgently").

Fixes: 65eb006d85a2a ("bpf: Move kernel test kfuncs to bpf_testmod")
Signed-off-by: Artem Savkov <asavkov@redhat.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 91907b321f913..e7c9e1c7fde04 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2020 Facebook */
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/delay.h>
 #include <linux/error-injection.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -544,6 +545,14 @@ static int bpf_testmod_init(void)
 
 static void bpf_testmod_exit(void)
 {
+        /* Need to wait for all references to be dropped because
+         * bpf_kfunc_call_test_release() which currently resides in kernel can
+         * be called after bpf_testmod is unloaded. Once release function is
+         * moved into the module this wait can be removed.
+         */
+	while (refcount_read(&prog_test_struct.cnt) > 1)
+		msleep(20);
+
 	return sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
 }
 
-- 
2.43.0



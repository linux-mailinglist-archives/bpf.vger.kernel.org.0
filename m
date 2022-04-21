Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C890E50A1A5
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 16:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388981AbiDUOLH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 10:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388957AbiDUOK5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 10:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DE4D3A5D4
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 07:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650550084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhQ9CmyPF6vnvDSxasy9mn+1Qi+yvX+VfFcFuFqUaJQ=;
        b=CN5i4ujebb+jc2cutrkCeGYQb0NBZvLx69v2UCWw058emU/jLPfDlpfh6GDNv+4cQvaI9k
        Sl126Ytn0iBkFE142cNS1U5xB8Qmpjt2U7Jbk5Nm43+PI8Mfo/EvJMOC/OYr+NaChbBCGd
        8vxT68j6pG52Ya1vLqipd3Sqtv9aRBk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-9jcwQ8XSNcimZGOYl45g0g-1; Thu, 21 Apr 2022 10:07:59 -0400
X-MC-Unique: 9jcwQ8XSNcimZGOYl45g0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56DBB85A5BE;
        Thu, 21 Apr 2022 14:07:57 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.194.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4150440EC002;
        Thu, 21 Apr 2022 14:07:55 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [RFC bpf-next v4 5/7] HID: initial BPF new way implementation
Date:   Thu, 21 Apr 2022 16:07:38 +0200
Message-Id: <20220421140740.459558-6-benjamin.tissoires@redhat.com>
In-Reply-To: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Declare an entry point that can use fmod_ret BPF programs, and
also an API to access and change the incoming data.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new-ish in v4:
- far from complete, but gives an overview of what we can do now.
---
 drivers/hid/hid-core.c  | 115 ++++++++++++++++++++++++++++++++++++++++
 include/linux/hid_bpf.h |  29 ++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 include/linux/hid_bpf.h

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index db925794fbe6..ff4e1b47d2fb 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -32,6 +32,9 @@
 #include <linux/hiddev.h>
 #include <linux/hid-debug.h>
 #include <linux/hidraw.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/hid_bpf.h>
 
 #include "hid-ids.h"
 
@@ -2008,6 +2011,99 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 }
 EXPORT_SYMBOL_GPL(hid_report_raw_event);
 
+struct hid_bpf_ctx_kern {
+	struct hid_device *hdev;
+	struct hid_bpf_ctx ctx;
+	u8 *data;
+	size_t size;
+};
+
+__weak int hid_bpf_device_event(struct hid_bpf_ctx *ctx, s64 type)
+{
+	return 0;
+}
+ALLOW_ERROR_INJECTION(hid_bpf_device_event, NS_ERRNO);
+
+noinline __u8 *
+hid_bpf_kfunc_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const size_t __sz)
+{
+	struct hid_bpf_ctx_kern *ctx_kern;
+
+	if (!ctx)
+		return NULL;
+
+	ctx_kern = container_of(ctx, struct hid_bpf_ctx_kern, ctx);
+
+	return ctx_kern->data;
+}
+
+noinline void
+hid_bpf_kfunc_data_release(__u8 *data)
+{
+}
+
+noinline int
+hid_bpf_kfunc_hw_request(struct hid_bpf_ctx *ctx)
+{
+	if (!ctx)
+		return -EINVAL;
+
+	pr_err("%s test ctx->bus: %04x %s:%d", __func__, ctx->bus, __FILE__, __LINE__);
+
+	return 0;
+}
+
+/*
+ * The following set contains all functions we agree BPF programs
+ * can use.
+ */
+BTF_SET_START(hid_bpf_kfunc_ids)
+BTF_ID(func, hid_bpf_kfunc_get_data)
+BTF_ID(func, hid_bpf_kfunc_data_release)
+BTF_ID(func, hid_bpf_kfunc_hw_request)
+BTF_SET_END(hid_bpf_kfunc_ids)
+
+/*
+ * The following set contains all functions to provide a kernel
+ * resource to the BPF program.
+ * We need to add a counterpart release function.
+ */
+BTF_SET_START(hid_bpf_kfunc_acquire_ids)
+BTF_ID(func, hid_bpf_kfunc_get_data)
+BTF_SET_END(hid_bpf_kfunc_acquire_ids)
+
+/*
+ * The following set is the release counterpart of the previous
+ * function set.
+ */
+BTF_SET_START(hid_bpf_kfunc_release_ids)
+BTF_ID(func, hid_bpf_kfunc_data_release)
+BTF_SET_END(hid_bpf_kfunc_release_ids)
+
+/*
+ * The following set tells which functions are sleepable.
+ */
+BTF_SET_START(hid_bpf_kfunc_sleepable_ids)
+BTF_ID(func, hid_bpf_kfunc_hw_request)
+BTF_SET_END(hid_bpf_kfunc_sleepable_ids)
+
+static const struct btf_kfunc_id_set hid_bpf_kfunc_set = {
+	.owner         = THIS_MODULE,
+	.check_set     = &hid_bpf_kfunc_ids,
+	.acquire_set   = &hid_bpf_kfunc_acquire_ids,
+	.release_set   = &hid_bpf_kfunc_release_ids,
+	.ret_null_set  = &hid_bpf_kfunc_acquire_ids, /* duplicated to force BPF programs to
+						      * check the validity of the returned pointer
+						      * in acquire function
+						      */
+	.sleepable_set = &hid_bpf_kfunc_sleepable_ids,
+};
+
+static int __init hid_bpf_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &hid_bpf_kfunc_set);
+}
+
 /**
  * hid_input_report - report data from lower layer (usb, bt...)
  *
@@ -2025,6 +2121,17 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, u32 size, int i
 	struct hid_driver *hdrv;
 	struct hid_report *report;
 	int ret = 0;
+	struct hid_bpf_ctx_kern ctx_kern = {
+		.hdev = hid,
+		.ctx = {
+			.bus = hid->bus,
+			.group = hid->group,
+			.vendor = hid->vendor,
+			.product = hid->product,
+		},
+		.data = data,
+		.size = size,
+	};
 
 	if (!hid)
 		return -ENODEV;
@@ -2039,6 +2146,10 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, u32 size, int i
 	report_enum = hid->report_enum + type;
 	hdrv = hid->driver;
 
+	ret = hid_bpf_device_event(&ctx_kern.ctx, type);
+	if (ret)
+		goto unlock;
+
 	if (!size) {
 		dbg_hid("empty report\n");
 		ret = -1;
@@ -2914,6 +3025,10 @@ static int __init hid_init(void)
 
 	hid_debug_init();
 
+	ret = hid_bpf_init();
+	if (ret)
+		pr_err("%s error in bpf_init: %d %s:%d", __func__, ret, __FILE__, __LINE__);
+
 	return 0;
 err_bus:
 	bus_unregister(&hid_bus_type);
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
new file mode 100644
index 000000000000..100909b27cd8
--- /dev/null
+++ b/include/linux/hid_bpf.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+
+#ifndef __HID_BPF_H
+#define __HID_BPF_H
+
+/*
+ * The following is the HID BPF API.
+ *
+ * It should be treated as UAPI, so extra care is required
+ * when making change to this file.
+ */
+
+struct hid_bpf_ctx {
+	__u16 bus;							/* BUS ID */
+	__u16 group;							/* Report group */
+	__u32 vendor;							/* Vendor ID */
+	__u32 product;							/* Product ID */
+	__u32 version;							/* HID version */
+};
+
+/* Following functions are tracepoints that BPF programs can attach to */
+int hid_bpf_device_event(struct hid_bpf_ctx *ctx, __s64 type);
+
+/* Following functions are kfunc that we export to BPF programs */
+__u8 *hid_bpf_kfunc_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const size_t __sz);
+void hid_bpf_kfunc_data_release(__u8 *data);
+int hid_bpf_kfunc_hw_request(struct hid_bpf_ctx *ctx);
+
+#endif /* __HID_BPF_H */
-- 
2.35.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821CC64477C
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 16:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiLFPHF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 10:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiLFPG2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 10:06:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BBA36C41
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 06:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670338789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7HAe1+QIbLkOhg0A9ITflkE14lK9YXc6vwi8hBrPFjg=;
        b=GF7HOAzEjVwosMRGnY5TmyyewAEK8MrRf/Knwm1Uh++JZ7SjJx1mDc0lMuhM7HQw9NbQv4
        nnTSkd/UtY7Kz1J3eV8lB8JyY+TmIn0a/+PdJWwy031fFh0E2xDNvKZreiak0oWColn3Y0
        Ox/XaCBL+F8JvOsJQmzKd4WV6dUo2ig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-TbdcHy17MgCxmm4yC13WkA-1; Tue, 06 Dec 2022 09:59:47 -0500
X-MC-Unique: TbdcHy17MgCxmm4yC13WkA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5882B101A528;
        Tue,  6 Dec 2022 14:59:46 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.193.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B14F14A9254;
        Tue,  6 Dec 2022 14:59:44 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH HID for-next v3 2/5] HID: bpf: do not rely on ALLOW_ERROR_INJECTION
Date:   Tue,  6 Dec 2022 15:59:33 +0100
Message-Id: <20221206145936.922196-3-benjamin.tissoires@redhat.com>
In-Reply-To: <20221206145936.922196-1-benjamin.tissoires@redhat.com>
References: <20221206145936.922196-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that we have  aproper non debug API to declare which function is
fmodret, we can rely on it.

Link: https://lore.kernel.org/all/20221121104403.1545f9b5@gandalf.local.home/
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v3

changes in v2:
- new, split from https://lore.kernel.org/all/c9912b24-f611-29b8-28e1-5e8be0d5ad41@redhat.com/
  and use the new API
---
 drivers/hid/bpf/hid_bpf_dispatch.c  | 20 ++++++++++++++++++--
 drivers/hid/bpf/hid_bpf_jmp_table.c |  1 -
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index c3920c7964dc..58e608ebf0fa 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -44,7 +44,6 @@ __weak noinline int hid_bpf_device_event(struct hid_bpf_ctx *ctx)
 {
 	return 0;
 }
-ALLOW_ERROR_INJECTION(hid_bpf_device_event, ERRNO);
 
 u8 *
 dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type, u8 *data,
@@ -105,7 +104,6 @@ __weak noinline int hid_bpf_rdesc_fixup(struct hid_bpf_ctx *ctx)
 {
 	return 0;
 }
-ALLOW_ERROR_INJECTION(hid_bpf_rdesc_fixup, ERRNO);
 
 u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size)
 {
@@ -429,6 +427,18 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 	return ret;
 }
 
+/* our HID-BPF entrypoints */
+BTF_SET8_START(hid_bpf_fmodret_ids)
+BTF_ID_FLAGS(func, hid_bpf_device_event)
+BTF_ID_FLAGS(func, hid_bpf_rdesc_fixup)
+BTF_ID_FLAGS(func, __hid_bpf_tail_call)
+BTF_SET8_END(hid_bpf_fmodret_ids)
+
+static const struct btf_kfunc_id_set hid_bpf_fmodret_set = {
+	.owner = THIS_MODULE,
+	.set   = &hid_bpf_fmodret_ids,
+};
+
 /* for syscall HID-BPF */
 BTF_SET8_START(hid_bpf_syscall_kfunc_ids)
 BTF_ID_FLAGS(func, hid_bpf_attach_prog)
@@ -495,6 +505,12 @@ static int __init hid_bpf_init(void)
 	 * will not be available, so nobody will be able to use the functionality.
 	 */
 
+	err = register_btf_fmodret_id_set(&hid_bpf_fmodret_set);
+	if (err) {
+		pr_warn("error while registering fmodret entrypoints: %d", err);
+		return 0;
+	}
+
 	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &hid_bpf_kfunc_set);
 	if (err) {
 		pr_warn("error while setting HID BPF tracing kfuncs: %d", err);
diff --git a/drivers/hid/bpf/hid_bpf_jmp_table.c b/drivers/hid/bpf/hid_bpf_jmp_table.c
index 579a6c06906e..207972b028d9 100644
--- a/drivers/hid/bpf/hid_bpf_jmp_table.c
+++ b/drivers/hid/bpf/hid_bpf_jmp_table.c
@@ -103,7 +103,6 @@ __weak noinline int __hid_bpf_tail_call(struct hid_bpf_ctx *ctx)
 {
 	return 0;
 }
-ALLOW_ERROR_INJECTION(__hid_bpf_tail_call, ERRNO);
 
 int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type type,
 		     struct hid_bpf_ctx_kern *ctx_kern)
-- 
2.38.1


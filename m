Return-Path: <bpf+bounces-65943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF593B2B5F2
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B463C19641D2
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5B71F4C8B;
	Tue, 19 Aug 2025 01:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Su87yQgB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B806F1DB122
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 01:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566789; cv=none; b=TO2RkdVnBXVJAaSTn50RS2Zvc4o7Ms+ZFh07hteO+jEUdxqRUDUuOjn/PKuya3ooTBRZwGaKAUCfv0anYhZu2eclfiGB41ebyS+OVm0ZBhesBVW4otpy0T/HWgvFCGs7mlEd+IaC7MrVuZL/6rd2cNxE3tLlCt7JlB6T28IdtGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566789; c=relaxed/simple;
	bh=NsvVM0R2/5r7ABv8U/8kW2HD4s864XnmGoQAzDv6iF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+myDT0dBmAqrKK+IF6BwLJdrP9+4XD/u7QjwJfHwpvv5y1OcssE/e+00nQzrXDWWZvts4ET9MgXqFwL6aB+xGiCkU9nfb4+NxOzs02UUHR/kQjgelPl8kn8Pt8STCDWKHyzXhgQg8bj1IbMr9BK+tIh5jxxgpPXn862jAYioWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Su87yQgB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755566786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOJBp2QWnzK9EKW6T/qN+hvnXPfTgVIaJ3WNWYhz+oI=;
	b=Su87yQgBUhKhvVh8LzxwLa6JT2AQoO+ikuqe9kMAcQTHpZ8sXEite33iBM7l1AJM5gD2UU
	0L2d4rdrOTRwj6tGBQ2TpyNJGchihTCJVwd0s0uQ9H0fUryfF3hgTFLBDnTYxJuFZEPMBT
	pctVCaf+aHaKhnWr4atJCwQzmimI9IM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-iqVEMLXUNsK7xtSYgwJL3A-1; Mon,
 18 Aug 2025 21:26:25 -0400
X-MC-Unique: iqVEMLXUNsK7xtSYgwJL3A-1
X-Mimecast-MFC-AGG-ID: iqVEMLXUNsK7xtSYgwJL3A_1755566782
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E7C61882800;
	Tue, 19 Aug 2025 01:26:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D70401800296;
	Tue, 19 Aug 2025 01:26:10 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: [PATCHv5 06/12] kexec: Integrate with the introduced bpf kfuncs
Date: Tue, 19 Aug 2025 09:24:22 +0800
Message-ID: <20250819012428.6217-7-piliu@redhat.com>
In-Reply-To: <20250819012428.6217-1-piliu@redhat.com>
References: <20250819012428.6217-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This patch does two things:
First, register as a listener on bpf_copy_to_kernel()
Second, in order that the hooked bpf-prog can call the sleepable kfuncs,
bpf_handle_pefile and bpf_post_handle_pefile are marked as
KF_SLEEPABLE.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: bpf@vger.kernel.org
To: kexec@lists.infradead.org
---
 kernel/kexec_pe_image.c | 67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
index b0cf9942e68d2..f8debcde6b516 100644
--- a/kernel/kexec_pe_image.c
+++ b/kernel/kexec_pe_image.c
@@ -38,6 +38,51 @@ static struct kexec_res parsed_resource[3] = {
 	{ KEXEC_RES_CMDLINE_NAME, },
 };
 
+/*
+ * @name should be one of : kernel, initrd, cmdline
+ */
+static int bpf_kexec_carrier(const char *name, struct mem_range_result *r)
+{
+	struct kexec_res *res;
+	int i;
+
+	if (!r || !name)
+		return -EINVAL;
+
+	for (i = 0; i < 3; i++) {
+		if (!strcmp(parsed_resource[i].name, name))
+			break;
+	}
+	if (i >= 3)
+		return -EINVAL;
+
+	res = &parsed_resource[i];
+	/*
+	 * Replace the intermediate resource generated by the previous step.
+	 */
+	if (!!res->r)
+		mem_range_result_put(res->r);
+	mem_range_result_get(r);
+	res->r = r;
+	return 0;
+}
+
+static struct carrier_listener kexec_res_listener[3] = {
+	{ .name = KEXEC_RES_KERNEL_NAME,
+	  .alloc_type = 1,
+	  .handler = bpf_kexec_carrier,
+	},
+	{ .name = KEXEC_RES_INITRD_NAME,
+	  .alloc_type = 1,
+	  .handler = bpf_kexec_carrier,
+	},
+	{ .name = KEXEC_RES_CMDLINE_NAME,
+	  /* kmalloc-ed */
+	  .alloc_type = 0,
+	  .handler = bpf_kexec_carrier,
+	},
+};
+
 static bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz);
 
 static bool is_valid_pe(const char *kernel_buf, unsigned long kernel_len)
@@ -159,6 +204,22 @@ __attribute__((used, optimize("O0"))) void bpf_post_handle_pefile(struct kexec_c
 	dummy += 2;
 }
 
+BTF_KFUNCS_START(kexec_modify_return_ids)
+BTF_ID_FLAGS(func, bpf_handle_pefile, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_post_handle_pefile, KF_SLEEPABLE)
+BTF_KFUNCS_END(kexec_modify_return_ids)
+
+static const struct btf_kfunc_id_set kexec_modify_return_set = {
+	.owner = THIS_MODULE,
+	.set = &kexec_modify_return_ids,
+};
+
+static int __init kexec_bpf_prog_run_init(void)
+{
+	return register_btf_fmodret_id_set(&kexec_modify_return_set);
+}
+late_initcall(kexec_bpf_prog_run_init);
+
 /*
  * PE file may be nested and should be unfold one by one.
  * Query 'kernel', 'initrd', 'cmdline' in cur_phase, as they are inputs for the
@@ -213,6 +274,9 @@ static void *pe_image_load(struct kimage *image,
 	cmdline_start = cmdline;
 	cmdline_sz = cmdline_len;
 
+	for (int i = 0; i < ARRAY_SIZE(kexec_res_listener); i++)
+		register_carrier_listener(&kexec_res_listener[i]);
+
 	while (is_valid_format(linux_start, linux_sz) &&
 	       pe_has_bpf_section(linux_start, linux_sz)) {
 		struct kexec_context context;
@@ -250,6 +314,9 @@ static void *pe_image_load(struct kimage *image,
 		disarm_bpf_prog();
 	}
 
+	for (int i = 0; i < ARRAY_SIZE(kexec_res_listener); i++)
+		unregister_carrier_listener(kexec_res_listener[i].name);
+
 	/*
 	 * image's kernel_buf, initrd_buf, cmdline_buf are set. Now they should
 	 * be updated to the new content.
-- 
2.49.0



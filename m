Return-Path: <bpf+bounces-63985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B8AB0CF88
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 04:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4C01AA0274
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 02:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B1E1DDC33;
	Tue, 22 Jul 2025 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFOtwieT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A952F1C07C3
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 02:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753149909; cv=none; b=MboBVOv0Axdj69o4c46SGFI32P6bKa10Zqcj8sDfKmgBsjYUJH3DA/l5D0DOQxye13PQ8tQccJsxCRrbDYYuIq8lwvsYd76ZrSNPhzOGppM9c143KWItWOPxvTiBIr+Kj5tN2cVeiN3a1ts/ccFBXy19vADZjUGwB6j4N2FnRmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753149909; c=relaxed/simple;
	bh=NsvVM0R2/5r7ABv8U/8kW2HD4s864XnmGoQAzDv6iF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rk/dH+HlKFQWsTvK7GYACtg+CXSjIkb5mlXR4F8+xGksb1d0WRI74EOlyR3NVgEvXpG+u6OuJ5ensVTKyuQiYxVEdKucHP4YXMEFQzM3JIooosVGDZQga9UgX6okxslPL6aKaSnk4t4Dt1A+5035/sLUP5HsmX6ManSrdUN25oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EFOtwieT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753149906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOJBp2QWnzK9EKW6T/qN+hvnXPfTgVIaJ3WNWYhz+oI=;
	b=EFOtwieT5hKLRFD6y7UvkFec911UZgJ2RCZxjGgH23z+uGHv7nx0DKzrtQ9vn48VDzCFwf
	MMsTrn5CIaJmJnyOOC0jnv0vlUQLs3i03FSmxEex11GTB+TJyxmuVm2qr9PAkhmsunDckX
	qTNPMVQRUP8Xm5GeVTcEUQPtNFaPwPU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-fMUAI4CcN9O1DtmOqdALDA-1; Mon,
 21 Jul 2025 22:05:03 -0400
X-MC-Unique: fMUAI4CcN9O1DtmOqdALDA-1
X-Mimecast-MFC-AGG-ID: fMUAI4CcN9O1DtmOqdALDA_1753149901
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A3551800286;
	Tue, 22 Jul 2025 02:05:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.104])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA43518003FC;
	Tue, 22 Jul 2025 02:04:50 +0000 (UTC)
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
	bpf@vger.kernel.org
Subject: [PATCHv4 06/12] kexec: Integrate with the introduced bpf kfuncs
Date: Tue, 22 Jul 2025 10:03:13 +0800
Message-ID: <20250722020319.5837-7-piliu@redhat.com>
In-Reply-To: <20250722020319.5837-1-piliu@redhat.com>
References: <20250722020319.5837-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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



Return-Path: <bpf+bounces-59267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F3BAC7717
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 06:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0484E5712
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 04:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0518D250C18;
	Thu, 29 May 2025 04:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OO+35ft0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A306EEAA
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 04:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748492401; cv=none; b=pGUOsLSGUFFfEBVjP+qF3gHlyjLvKFFsExmMQV7+FCSWr+5r6w3jmiXNl2S1jk8fT+DA7gHUnCpJKwAoDqKzyHpbfJXx/HACXiNTDESeEnCkLQ9CxgogS3QzE9lk3tAwGGqoaSLHXFSXdRV+JcP9wJ12BZfOFGp/O7+IDc5QDik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748492401; c=relaxed/simple;
	bh=DQ/X56Gx8ZNCfOpzzXdpZKIgOkIL7xsCIQHufdEjG6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hh5lBoU8nRKsY3a+bREVRHpmnOhCTGCs9q/5iFg4IPfMXMA1cYBHFS5DFv40ywxAPJYgbQkXd4OzNoDArnUQw8J/eaUnPdHokVPKDY+Kqv+7luQ2Ep67/cJkkysQojYtgkuJ1hyzA3dd2r1dr9v4+VpywtZVjhLdHfUOFZ9zLzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OO+35ft0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748492398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/ykuzUNlnG+gXezyEE+wMJKp6YscsHmpoCNBbPLXnA=;
	b=OO+35ft0cv/jzECWm+m4QP6HwrDvNIOBZQJipytSvdMhd451oTFoG9uTTxRygY0lBO7TVL
	mt8g+5MJ1BYBVLPFjNWeuDoOH7Vyu+xWJizgMa/xIP3y1k7z9lB5kD/nOiVAGhSwEU3FG+
	QgaUdm7019kDGUfHEhy1H/WV3huS+jE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-lo6DfNe-OdGdbVJDIpPbfQ-1; Thu,
 29 May 2025 00:19:53 -0400
X-MC-Unique: lo6DfNe-OdGdbVJDIpPbfQ-1
X-Mimecast-MFC-AGG-ID: lo6DfNe-OdGdbVJDIpPbfQ_1748492391
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E10FE1800366;
	Thu, 29 May 2025 04:19:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77DB0180047F;
	Thu, 29 May 2025 04:19:40 +0000 (UTC)
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
Subject: [PATCHv3 6/9] kexec: Integrate with the introduced bpf kfuncs
Date: Thu, 29 May 2025 12:17:41 +0800
Message-ID: <20250529041744.16458-7-piliu@redhat.com>
In-Reply-To: <20250529041744.16458-1-piliu@redhat.com>
References: <20250529041744.16458-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

First, register as a listener on bpf_copy_to_kernel() Second, in order
that the hooked bpf-prog can call the sleepable kfuncs,
bpf_handle_pefile and bpf_post_handle_pefile should also be marked as
KF_SLEEPABLE to allow that behavior.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: bpf@vger.kernel.org
To: kexec@lists.infradead.org
---
 kernel/kexec_pe_image.c | 59 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
index 3097efccb8502..e49d6db3c329d 100644
--- a/kernel/kexec_pe_image.c
+++ b/kernel/kexec_pe_image.c
@@ -52,6 +52,43 @@ static struct parsed_phase *alloc_new_phase(void)
 	return phase;
 }
 
+/*
+ * @name should be one of : kernel, initrd, cmdline
+ */
+static int bpf_kexec_carrier(const char *name, struct mem_range_result *r)
+{
+	struct kexec_res *res;
+
+	if (!r || !name)
+		return -EINVAL;
+
+	res = kzalloc(sizeof(struct kexec_res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+	res->name = kstrdup(name, GFP_KERNEL);
+	kref_get(&r->ref);
+	res->r = r;
+
+	INIT_LIST_HEAD(&res->node);
+	list_add_tail(&res->node, &cur_phase->res_head);
+	return 0;
+}
+
+static struct carrier_listener kexec_res_listener[3] = {
+	{ .name = "kernel",
+	  .kmalloc = false,
+	  .handler = bpf_kexec_carrier,
+	},
+	{ .name = "initrd",
+	  .kmalloc = false,
+	  .handler = bpf_kexec_carrier,
+	},
+	{ .name = "cmdline",
+	  .kmalloc = true,
+	  .handler = bpf_kexec_carrier,
+	},
+};
+
 static bool is_valid_pe(const char *kernel_buf, unsigned long kernel_len)
 {
 	struct mz_hdr *mz;
@@ -161,6 +198,22 @@ __attribute__((used, optimize("O0"))) void bpf_post_handle_pefile(struct kexec_c
 {
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
@@ -212,6 +265,9 @@ static void *pe_image_load(struct kimage *image,
 	cmdline_start = cmdline;
 	cmdline_sz = cmdline_len;
 
+	for (int i = 0; i < ARRAY_SIZE(kexec_res_listener); i++)
+		register_carrier_listener(&kexec_res_listener[i]);
+
 	while (is_valid_format(linux_start, linux_sz) &&
 	       pe_has_bpf_section(linux_start, linux_sz)) {
 		struct kexec_context context;
@@ -252,6 +308,9 @@ static void *pe_image_load(struct kimage *image,
 		disarm_bpf_prog();
 	}
 
+	for (int i = 0; i < ARRAY_SIZE(kexec_res_listener); i++)
+		unregister_carrier_listener(kexec_res_listener[i].name);
+
 	/* the rear of parsed phase contains the result */
 	list_for_each_entry_reverse(phase, &phase_head, head) {
 		if (initrd != NULL && cmdline != NULL && parsed_kernel != NULL)
-- 
2.49.0



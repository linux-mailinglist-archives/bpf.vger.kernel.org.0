Return-Path: <bpf+bounces-28239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252638B6EA7
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 11:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D66280D2C
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F98412AAED;
	Tue, 30 Apr 2024 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZtZXFxT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB781128370
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469905; cv=none; b=VfOEEVrCX/CE9p5WpaSgRUSnqDl51r3NYwfXqUP3g2GjP6amFBGKIEEsUuDw/uKxEvNeZoNL+4HAFYhYPOI4NJ9l6rm2TGuKmLrO5JEjxX3ib2iSXRRXKdeyWdwaB8KK7zGIlk5clrzyLFplbu/5g+rT+CMerdU0wyS7wqdKQl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469905; c=relaxed/simple;
	bh=nOwnymDJq1dHHRbUL+464A99TZWaYGjZh5IvCue8Srw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GV7uGPmRfsrsKK6tPzidRq1bjVM/ryExDzM3anXd58wwW5AuaystYpYOWW4+LLYldmEa7VFo8qmCEw2xhlzkhLfXST9qxfjVwCn8RqFmcAMK3iui4K36lEn77LR8TwaJcNPBWzklqJpkI46PBn9z7y0dSbXB5l68ka79SRy9cmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZtZXFxT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714469902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wX35GDW+sMUBt18qYtx7x7qRfqug/N6zIuVCnVosiPo=;
	b=BZtZXFxT3+8YQpdYwrj7hKZkybGNhoF+V29vC/jgd18Q1WOlaTpHB2yZEkEEuMoeq8+BDB
	JY9SbLee5jmtvWlmS80I6JDVJXQsy5jHR24AiOlKZEc80hAKGto+xyAEJT7n+uEGv2rGUO
	KqoM87t6N1x0307EtktE3YMVH6pAtYw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-KaLt0qvrPHODrDMGjHSSrg-1; Tue, 30 Apr 2024 05:38:19 -0400
X-MC-Unique: KaLt0qvrPHODrDMGjHSSrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E64889A7E4;
	Tue, 30 Apr 2024 09:38:18 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.226.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EC2A22166B31;
	Tue, 30 Apr 2024 09:38:14 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v2 1/2] libbpf: support "module:function" syntax for tracing programs
Date: Tue, 30 Apr 2024 11:38:06 +0200
Message-ID: <9085a8cb9a552de98e554deb22ff7e977d025440.1714469650.git.vmalik@redhat.com>
In-Reply-To: <cover.1714469650.git.vmalik@redhat.com>
References: <cover.1714469650.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

In some situations, it is useful to explicitly specify a kernel module
to search for a tracing program target (e.g. when a function of the same
name exists in multiple modules or in vmlinux).

This patch enables that by allowing the "module:function" syntax for the
find_kernel_btf_id function. Thanks to this, the syntax can be used both
from a SEC macro (i.e. `SEC(fentry/module:function)`) and via the
bpf_program__set_attach_target API call.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/lib/bpf/libbpf.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 898d5d34ecea..88adc989dbe9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9859,16 +9859,28 @@ static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 			      enum bpf_attach_type attach_type,
 			      int *btf_obj_fd, int *btf_type_id)
 {
-	int ret, i;
+	int ret, i, mod_len;
+	const char *fn_name, *mod_name = NULL;
 
-	ret = find_attach_btf_id(obj->btf_vmlinux, attach_name, attach_type);
-	if (ret > 0) {
-		*btf_obj_fd = 0; /* vmlinux BTF */
-		*btf_type_id = ret;
-		return 0;
+	fn_name = strchr(attach_name, ':');
+	if (fn_name) {
+		mod_name = attach_name;
+		mod_len = fn_name - mod_name;
+		fn_name++;
+	}
+
+	if (!mod_name || strncmp(mod_name, "vmlinux", mod_len) == 0) {
+		ret = find_attach_btf_id(obj->btf_vmlinux,
+					 mod_name ? fn_name : attach_name,
+					 attach_type);
+		if (ret > 0) {
+			*btf_obj_fd = 0; /* vmlinux BTF */
+			*btf_type_id = ret;
+			return 0;
+		}
+		if (ret != -ENOENT)
+			return ret;
 	}
-	if (ret != -ENOENT)
-		return ret;
 
 	ret = load_module_btfs(obj);
 	if (ret)
@@ -9877,7 +9889,12 @@ static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 	for (i = 0; i < obj->btf_module_cnt; i++) {
 		const struct module_btf *mod = &obj->btf_modules[i];
 
-		ret = find_attach_btf_id(mod->btf, attach_name, attach_type);
+		if (mod_name && strncmp(mod->name, mod_name, mod_len) != 0)
+			continue;
+
+		ret = find_attach_btf_id(mod->btf,
+					 mod_name ? fn_name : attach_name,
+					 attach_type);
 		if (ret > 0) {
 			*btf_obj_fd = mod->fd;
 			*btf_type_id = ret;
-- 
2.44.0



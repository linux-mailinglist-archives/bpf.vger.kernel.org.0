Return-Path: <bpf+bounces-27924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C414E8B3703
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 14:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F2B1C21EAE
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3711145358;
	Fri, 26 Apr 2024 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7Pz0EaH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E723D144D15
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133867; cv=none; b=neocuQjongtGFi/pJPAV2vzF0xJiY/B19BjlTgaDlEXJZ0k+XvX6QrkmP0PmFEjPkWUBt5PkFPdazITa7ZYCiEsCo6aCTHLeM9xUs63s9TVHBPGLS5b5olJf9ZS1qWDq7PCWarylXn5jacO+jw7wL1iVgEK1Gw5sEjLCc+te5UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133867; c=relaxed/simple;
	bh=4tdJcUmx2S+eDbAKk2wLEKXhLhypVcEmTomI/S8kmYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ml+2aeBRwMeHBC/g79A+DkFgm6OthGUa1whOAAKumJN97GUEmxKL2Sgl/kgWdW41U/5d+FY7QXYoYAlq292REkA6LrM9jClQv4TX3SB6LgKSFdH7KZ1mK+japQ/MJevNTrFGspNEuW6V+hGLwmpBFwR9QUQuiwHIl20h07panc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7Pz0EaH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714133864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcxr1dB3yvWEw+J2StOEQHXJNmRMXCWMQ9zCEwyTufY=;
	b=X7Pz0EaHtTMUtq7jzL85qLMsl7R1TNnFCDZn4kTA7gDqER+1l7qrH7954NC4G3yEK9dgxp
	XwSf/u+r9snhmV71jwoztLvZ4w9xrzHLyYNb+Ny7lOS8JVIwFllISj95Gr4AJ1XlmAhIS1
	0wOifccEkYHHKfJHhBy4UPlpOL+2v+U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-luzwoXz0PLefJsOPVwBz_Q-1; Fri, 26 Apr 2024 08:17:38 -0400
X-MC-Unique: luzwoXz0PLefJsOPVwBz_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5D13811009;
	Fri, 26 Apr 2024 12:17:37 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.95])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C90A110FCEE0;
	Fri, 26 Apr 2024 12:17:34 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next 1/2] libbpf: support "module:function" syntax for tracing programs
Date: Fri, 26 Apr 2024 14:17:26 +0200
Message-ID: <239e6c07800fa0c6c7540589e6ba0a49ba419237.1714133551.git.vmalik@redhat.com>
In-Reply-To: <cover.1714133551.git.vmalik@redhat.com>
References: <cover.1714133551.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

In some situations, it is useful to explicitly specify a kernel module
to search for a tracing program target (e.g. when a function of the same
name exists in multiple modules or in vmlinux).

This patch enables that by allowing the "module:function" syntax for the
find_kernel_btf_id function. Thanks to this, the syntax can be used both
from a SEC macro (i.e. `SEC(fentry/module:function)`) and via the
bpf_program__set_attach_target API call.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/lib/bpf/libbpf.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 97eb6e5dd7c8..5a136876cd1c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9858,16 +9858,28 @@ static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 			      enum bpf_attach_type attach_type,
 			      int *btf_obj_fd, int *btf_type_id)
 {
-	int ret, i;
+	int ret, i, mod_len;
+	const char *fun_name, *mod_name = NULL;
 
-	ret = find_attach_btf_id(obj->btf_vmlinux, attach_name, attach_type);
-	if (ret > 0) {
-		*btf_obj_fd = 0; /* vmlinux BTF */
-		*btf_type_id = ret;
-		return 0;
+	fun_name = strchr(attach_name, ':');
+	if (fun_name) {
+		mod_name = attach_name;
+		mod_len = fun_name - mod_name;
+		fun_name++;
+	}
+
+	if (!mod_name || strncmp(mod_name, "vmlinux", mod_len) == 0) {
+		ret = find_attach_btf_id(obj->btf_vmlinux,
+					 mod_name ? fun_name : attach_name,
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
@@ -9876,7 +9888,10 @@ static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 	for (i = 0; i < obj->btf_module_cnt; i++) {
 		const struct module_btf *mod = &obj->btf_modules[i];
 
-		ret = find_attach_btf_id(mod->btf, attach_name, attach_type);
+		if (mod_name && strncmp(mod->name, mod_name, mod_len))
+			continue;
+
+		ret = find_attach_btf_id(mod->btf, mod_name ? fun_name : attach_name, attach_type);
 		if (ret > 0) {
 			*btf_obj_fd = mod->fd;
 			*btf_type_id = ret;
-- 
2.44.0



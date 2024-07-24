Return-Path: <bpf+bounces-35467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C3593AB96
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 05:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE16A1F23A71
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 03:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E901C693;
	Wed, 24 Jul 2024 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMZVR1v7"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDAB4A00
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 03:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721791667; cv=none; b=pqTy2oeWbtUcjMfcXSlf50tFEFAOkijKPDMmLficRR2Q4/WWQn7jdkTFRIuUynbCX+i6cMrfmjRvPoFbwowKHiU1YIytoQKEzm2QmEkOSIUFykO0I/iilzyjPH8eQauGH4BAp0Cz5EpTEvJoKmOFn/JtXaJSLYpajpFFbuUtkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721791667; c=relaxed/simple;
	bh=crXYds6wpDm/hyu1vOknD2XPXY3/Jw3VqcmiAf10rv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S2DnD8c1GNWDrxlQjXomMpOqbRrGGgUalJKYh4LUnBmvCe5OxZ8l7MLI6Ki+8Oh+7WwE3ZjBp0StMgvCHkGofv3+wIQU/yaGgUJqUT3QJ2wwtsMcGV3y56bx8CZUt/dLGdosUgd3yP8xKL3ybZpnXIYGXCNJ5+27wVnqJKja5uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMZVR1v7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721791664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tFij088DM6iiLJlnan+A9BDrbaGZ4ZYeXIdI+vJUSLo=;
	b=GMZVR1v7Qk0EemECoQnBpExru1TXarWpBV6sqm9TwW8IVxqZ5hgWGMMRgfFXWZlQZAXjlV
	udfKg0GKCEI5zm6mISffTvql0m8aU2LQkJJNBc8PFYeldlpGSO/COJxgrj17vGFCsFFkGx
	O69b2c5E546gyTKCxqJcz243h2aOsaU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-hkZmRYhsM6WAk_GbDku6CA-1; Tue,
 23 Jul 2024 23:19:47 -0400
X-MC-Unique: hkZmRYhsM6WAk_GbDku6CA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0A2C1955D4C;
	Wed, 24 Jul 2024 03:19:44 +0000 (UTC)
Received: from localhost (unknown [10.72.116.80])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D0191955E80;
	Wed, 24 Jul 2024 03:19:42 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	andrii@kernel.org,
	drosen@google.com,
	kuifeng@meta.com
Cc: sinquersw@gmail.com,
	thinker.li@gmail.com,
	Ming Lei <ming.lei@redhat.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] bpf: export btf_find_by_name_kind and bpf_base_func_proto
Date: Wed, 24 Jul 2024 11:19:30 +0800
Message-ID: <20240724031930.2606568-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Export btf_find_by_name_kind and bpf_base_func_proto, so that kernel
module can use them.

Almost all existed struct_ops users(hid, sched_ext, ...) need the two APIs.

Without this change, hid-bpf can't be built as module.

Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/bpf/btf.c     | 1 +
 kernel/bpf/helpers.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d5019c4454d6..fdc4c0c1829d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -567,6 +567,7 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 
 	return -ENOENT;
 }
+EXPORT_SYMBOL_GPL(btf_find_by_name_kind);
 
 s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
 {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5f0adae8293..18d1a76f96d2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2033,6 +2033,7 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return NULL;
 	}
 }
+EXPORT_SYMBOL_GPL(bpf_base_func_proto);
 
 void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock)
-- 
2.45.2



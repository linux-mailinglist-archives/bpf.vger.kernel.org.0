Return-Path: <bpf+bounces-35727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAFB93D39A
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 15:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DEA285DC2
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79294176AB4;
	Fri, 26 Jul 2024 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LD1uYAlq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAD723A8
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998818; cv=none; b=pJutNsBrpL981z4LR7KiBIZIPfxny7UzFpYF+1nrNAHHUrDaO7VyM+bnu3pUfVQpmyiix/q7LT2Zb2Yw8e1QLUdoEx0b6/RIAzzX82kMY2Gj/8fgoBvqYkENFHER8ztlMCHWmyrg20L3cuYTD0shBqPKAAko0KD+l/1qN6bIZuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998818; c=relaxed/simple;
	bh=LvyYEPFfq+hRcvW96jSR5fVG8Ec+6CTLTVbt7JvfyDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVkh8IE/ukil43WZ2RP5/ASYJF32K22sz7DuHxuHRh/ey/BjL2D88RPkYmhsT0221LhEVnVozhozBGZpXWghBWdZ9Wm3QNoCPSXFZjIxRMmAXYsKTNTOJCDxi7nusAdHFFFw8laUW0PCRyFnFy8qmppf7hj/w9mJi2CqSHsU70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LD1uYAlq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721998815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2wuJlOIr32r/hxz1lj6xC3Nqb0OL5a47eJ1Q4q/6ipY=;
	b=LD1uYAlqYpeBPxOEiRRoC1Rx42/CreRXKM25badcZb0kjL2PMNVKpd/GTkUDF6Ujleh7+X
	JNbFM6XdVWweLRUSoR0eQjHsNZmiZSsobkhH7kUkYr2Y/EUfikXXzdZG7bZE/C8a1e9laE
	V1vnMr3hsv0+jTSY4zbFm9wKtkpRF6U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-2cIuk6sBPR-wwqZkZ4iPcg-1; Fri,
 26 Jul 2024 09:00:09 -0400
X-MC-Unique: 2cIuk6sBPR-wwqZkZ4iPcg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C48C41955F77;
	Fri, 26 Jul 2024 13:00:07 +0000 (UTC)
Received: from localhost (unknown [10.72.116.86])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 405141955F40;
	Fri, 26 Jul 2024 13:00:05 +0000 (UTC)
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
	Yonghong Song <yonghong.song@linux.dev>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Subject: [PATCH V2 bpf-next] bpf: export btf_find_by_name_kind and bpf_base_func_proto
Date: Fri, 26 Jul 2024 20:59:58 +0800
Message-ID: <20240726125958.2853508-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Almost all existed struct_ops users(hid, sched_ext, ...) need the two APIs.

In-tree hid-bpf code(drivers/hid/bpf/hid_bpf_struct_ops.c) can't be built
as module because the two APIs aren't exported.

Export btf_find_by_name_kind and bpf_base_func_proto, so that any kernel
module can use them given bpf community is supporting to register
struct_ops in module, see the patchset "Registrating struct_ops types from
modules"[1], which is merged to v6.9.

Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- add more details in commit log (Yonghong)
	- add 'bpf-next' in patch title (Yonghong)

 kernel/bpf/btf.c     | 1 +
 kernel/bpf/helpers.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 520f49f422fe..519c6e5a57d5 100644
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
2.42.0



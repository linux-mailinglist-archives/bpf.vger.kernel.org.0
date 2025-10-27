Return-Path: <bpf+bounces-72388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDA9C11F63
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 00:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8763919C0837
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AE632F755;
	Mon, 27 Oct 2025 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ku2hs8Yy"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA132E15B
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607074; cv=none; b=qmipcjOZjiiCkCzNIfejtrX4GhhPJDpjaFZUZwhHC3dznhHmg4pdcPe8R8ukk1l3n6iNsARP+JxfYsLt/kfo0/fMVohxlc9cvRB1gQLvetmujIXKIJCr6n+OMPcWPY3pwx66sKz7DHZMD348rWGt0yY3QBHYJCYQcvR3LFLbe1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607074; c=relaxed/simple;
	bh=LZ8xqIko04bi57HdEFeTW/ZOAwpKTvHz5QAb/lseWiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWwkVKGM9KC5xjL9wIhvVWyhDoRN8hApxNvsRa8l04Y3ismzkrCrJdEGhpbylQ6ftG+6rC9g3ldckqgFyM5s0AGem2YVb3f8pnQxIyA3IC3iLBOUVOUM8QNqNTtx+hLgsBDP0HtgVFl7wEAG5pPuz0QP4cpG/08W672JdeFlUP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ku2hs8Yy; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKYk3X446OvKPFK1dbaJLt6hxCv7gj7lfZhXfighlFU=;
	b=ku2hs8Yy7UvEemaXTfBXG4klDsCAebaAkVDabecACSyHzK1FlAZNchUjP2R9kWCRuWzeh3
	T3K0YConVo0LzU3EJ2u5NQdqk331R4Y1lpBjCenBmLbDLwG6y+8Xctm/5qrxAe9u/FQ1Mw
	yNRExSxjfmVtfHkr2tIxuzgjMiNhz5I=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 03/23] bpf: mark struct oom_control's memcg field as TRUSTED_OR_NULL
Date: Mon, 27 Oct 2025 16:17:06 -0700
Message-ID: <20251027231727.472628-4-roman.gushchin@linux.dev>
In-Reply-To: <20251027231727.472628-1-roman.gushchin@linux.dev>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Struct oom_control is used to describe the OOM context.
It's memcg field defines the scope of OOM: it's NULL for global
OOMs and a valid memcg pointer for memcg-scoped OOMs.
Teach bpf verifier to recognize it as trusted or NULL pointer.
It will provide the bpf OOM handler a trusted memcg pointer,
which for example is required for iterating the memcg's subtree.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 542e23fb19c7..811275419be3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7104,6 +7104,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
 	struct file *vm_file;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct oom_control) {
+	struct mem_cgroup *memcg;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -7146,6 +7150,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct oom_control));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");
-- 
2.51.0



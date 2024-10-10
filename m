Return-Path: <bpf+bounces-41666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 447D59995BB
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 01:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742DF1C22AA6
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 23:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F229E1E885C;
	Thu, 10 Oct 2024 23:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpjMyrxb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F61E883B;
	Thu, 10 Oct 2024 23:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728602709; cv=none; b=pVLlCmiUcMdokKuytCRzwysJ+E0nYcl1VGu14JJEk3ZobTmP4OjUdK/QRVvccW1RL376XMzS8+/3Wax2/zFos3eLl7fOw+i62IySTMUVVBrptk5HbyNtWpG/g87eQfhmqPHw1xMTPowEjtCqdGQGGkCHFr1VE5cK8WzIuggwXDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728602709; c=relaxed/simple;
	bh=oQNc8mViY1+Zpg9pTngTgTZBRAhT3aWMoYlhdEdPulk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6J36p/hXw5vUSJGHCfkQsOIFBkHqQbhQd4lYVzq66+Cszg+RvxPKYI6RMhB6HdBPQgMStj85vJm4QfZTE0jxIBwngL+fxb2Bhru2AV3yZiw9a5n687so4RznYbHIhuU8c8IUZiE2tQ7PDQxM+PEFW6fRZqpXsQQ8ZFpqGGhjvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpjMyrxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8B8C4CECC;
	Thu, 10 Oct 2024 23:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728602709;
	bh=oQNc8mViY1+Zpg9pTngTgTZBRAhT3aWMoYlhdEdPulk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpjMyrxbIkU8p8Pos+uewoY7l6slYSFawh+sAhm4DKth60xZfVibOZUz7Q6yJfaS9
	 3BieWcZ1AB31oU4P2cdt6jVckI/XGUIuNal+JYlW6EC5bjS5GyD2crZULXYCqB2AvS
	 pAP9K0fAZg0LENhrccEFmhwVCDT33GDgLUwbdYYl90qz//WMQXC6O6DBYyBtfdZ4ob
	 AfzoKOLuZH8Wi8V4Aejb9+FIDypglbDiCktzmpuiuVcWORss5rG7yW1GO2Si5l022x
	 tNa6F5diiFsS75Ryvb3II3cIsRUVM9gOgqJNWNvqiIreIfJMsGK78mMda+iZFqGik2
	 LR0aLVQRbFOEA==
From: Namhyung Kim <namhyung@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v5 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
Date: Thu, 10 Oct 2024 16:25:04 -0700
Message-ID: <20241010232505.1339892-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241010232505.1339892-1-namhyung@kernel.org>
References: <20241010232505.1339892-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_get_kmem_cache() is to get a slab cache information from a
virtual address like virt_to_cache().  If the address is a pointer
to a slab object, it'd return a valid kmem_cache pointer, otherwise
NULL is returned.

It doesn't grab a reference count of the kmem_cache so the caller is
responsible to manage the access.  The returned point is marked as
PTR_UNTRUSTED.  And the kfunc has KF_RCU_PROTECTED as the slab object
might be protected by RCU.

The intended use case for now is to symbolize locks in slab objects
from the lock contention tracepoints.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)
Acked-by: Vlastimil Babka <vbabka@suse.cz> #mm/slab
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/bpf/helpers.c  |  1 +
 kernel/bpf/verifier.c |  5 +++++
 mm/slab_common.c      | 19 +++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4053f279ed4cc7ab..7bfef9378ab21267 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3090,6 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RCU_PROTECTED)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cfc62e0776bff2c8..f514247ba8ba8a57 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11259,6 +11259,7 @@ enum special_kfunc_type {
 	KF_bpf_preempt_enable,
 	KF_bpf_iter_css_task_new,
 	KF_bpf_session_cookie,
+	KF_bpf_get_kmem_cache,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11324,6 +11325,7 @@ BTF_ID(func, bpf_session_cookie)
 #else
 BTF_ID_UNUSED
 #endif
+BTF_ID(func, bpf_get_kmem_cache)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -12834,6 +12836,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].type = PTR_TO_BTF_ID;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
 
+			if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache])
+				regs[BPF_REG_0].type |= PTR_UNTRUSTED;
+
 			if (is_iter_next_kfunc(&meta)) {
 				struct bpf_reg_state *cur_iter;
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 7443244656150325..5484e1cd812f698e 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1322,6 +1322,25 @@ size_t ksize(const void *objp)
 }
 EXPORT_SYMBOL(ksize);
 
+#ifdef CONFIG_BPF_SYSCALL
+#include <linux/btf.h>
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
+{
+	struct slab *slab;
+
+	if (!virt_addr_valid(addr))
+		return NULL;
+
+	slab = virt_to_slab((void *)(long)addr);
+	return slab ? slab->slab_cache : NULL;
+}
+
+__bpf_kfunc_end_defs();
+#endif /* CONFIG_BPF_SYSCALL */
+
 /* Tracepoints definitions. */
 EXPORT_TRACEPOINT_SYMBOL(kmalloc);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
-- 
2.47.0.rc1.288.g06298d1525-goog



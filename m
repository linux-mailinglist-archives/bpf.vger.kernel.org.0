Return-Path: <bpf+bounces-42277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E6F9A1C96
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 10:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF401C2627B
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 08:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B021D6DB3;
	Thu, 17 Oct 2024 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7efwpBA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11C17DFEF;
	Thu, 17 Oct 2024 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152366; cv=none; b=ayy/nYKOX+O7D/+/9xG0Q3ydLnvYp9WV7HnWi3m2CGnd6InId3zWGq9jlAIHRHbNQO7iF1Lv8tZQWp45Er4VyeIRREPomD5DhdDgqp9D43VCFfeItoxmL8m/UuouTN6vR1xtUJP7bDJpB2yykJuh86q1q+7XALtBC5UndEMKwpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152366; c=relaxed/simple;
	bh=xhFeg8d3ZWTLiCtqZ3vBuXhl5x01QSY54MvjjIElYqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWMnhnTifL8m1DYoLwnoGlAY8S1VRcpmyqeXboRlP9wigtXmt5POO9/LQq8SBRIVFADjeePvedLb0xhIu9alSVPCBdV0PwASx/VJ9GGLt7PsnIQd0ysACrXeZLwTr8GlP+UN6v8hJiF0zkOkME6V4Wte3KxSGcy0okGWO+L5faY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7efwpBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9B8C4CEC3;
	Thu, 17 Oct 2024 08:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729152365;
	bh=xhFeg8d3ZWTLiCtqZ3vBuXhl5x01QSY54MvjjIElYqk=;
	h=From:To:Cc:Subject:Date:From;
	b=K7efwpBAPFGbHuhzunUc2QaAoYXQGvgJ0Z4GkctsmDARFen9LFPnov4tOVlsL6ajn
	 MtuBCbLOr705HX4kPXojoTFNYCmqyUJT3cw4vFplqwBkkjUfQosAWmp/xO3VD0Ayby
	 Nys6vuOCh5t7WOYofWupYigpR6FTnYZILFI7c0ndK+NtB+b+k7NBvhLniC/rdQ/2dh
	 P9jlEzaK3mO2wPV6ioY6EO4S9W/Vyz7tJ+/CZ2uvTcmStDfck+WCcO9DA60ZgpMeHL
	 c8OVaEOWifVvOh8F00/dqILMx00M3QektgYxY5yGXqFZK9R82GHrh9cG5n3qluMTaQ
	 miQ6c5PJmvWug==
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
	Kees Cook <kees@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Add open coded version of kmem_cache iterator
Date: Thu, 17 Oct 2024 01:06:03 -0700
Message-ID: <20241017080604.541872-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new open coded iterator for kmem_cache which can be called from a
BPF program like below.  It doesn't take any argument and traverses all
kmem_cache entries.

  struct kmem_cache *pos;

  bpf_for_each(kmem_cache, pos) {
      ...
  }

As it needs to grab slab_mutex, it should be called from sleepable BPF
programs only.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/bpf/helpers.c         |  3 ++
 kernel/bpf/kmem_cache_iter.c | 87 ++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 073e6f04f4d765ff..d1dfa4f335577914 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3111,6 +3111,9 @@ BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_kmem_cache)
+BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/kmem_cache_iter.c b/kernel/bpf/kmem_cache_iter.c
index ebc101d7da51b57c..31ddaf452b20a458 100644
--- a/kernel/bpf/kmem_cache_iter.c
+++ b/kernel/bpf/kmem_cache_iter.c
@@ -145,6 +145,93 @@ static const struct bpf_iter_seq_info kmem_cache_iter_seq_info = {
 	.seq_ops		= &kmem_cache_iter_seq_ops,
 };
 
+/* open-coded version */
+struct bpf_iter_kmem_cache {
+	__u64 __opaque[1];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_kmem_cache_kern {
+	struct kmem_cache *pos;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it)
+{
+	struct bpf_iter_kmem_cache_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
+	BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));
+
+	kit->pos = NULL;
+	return 0;
+}
+
+__bpf_kfunc struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_cache *it)
+{
+	struct bpf_iter_kmem_cache_kern *kit = (void *)it;
+	struct kmem_cache *prev = kit->pos;
+	struct kmem_cache *next;
+	bool destroy = false;
+
+	mutex_lock(&slab_mutex);
+
+	if (list_empty(&slab_caches)) {
+		mutex_unlock(&slab_mutex);
+		return NULL;
+	}
+
+	if (prev == NULL)
+		next = list_first_entry(&slab_caches, struct kmem_cache, list);
+	else if (list_last_entry(&slab_caches, struct kmem_cache, list) == prev)
+		next = NULL;
+	else
+		next = list_next_entry(prev, list);
+
+	/* boot_caches have negative refcount, don't touch them */
+	if (next && next->refcount > 0)
+		next->refcount++;
+
+	/* Skip kmem_cache_destroy() for active entries */
+	if (prev && prev->refcount > 1)
+		prev->refcount--;
+	else if (prev && prev->refcount == 1)
+		destroy = true;
+
+	mutex_unlock(&slab_mutex);
+
+	if (destroy)
+		kmem_cache_destroy(prev);
+
+	kit->pos = next;
+	return next;
+}
+
+__bpf_kfunc void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it)
+{
+	struct bpf_iter_kmem_cache_kern *kit = (void *)it;
+	struct kmem_cache *s = kit->pos;
+	bool destroy = false;
+
+	if (s == NULL)
+		return;
+
+	mutex_lock(&slab_mutex);
+
+	/* Skip kmem_cache_destroy() for active entries */
+	if (s->refcount > 1)
+		s->refcount--;
+	else if (s->refcount == 1)
+		destroy = true;
+
+	mutex_unlock(&slab_mutex);
+
+	if (destroy)
+		kmem_cache_destroy(s);
+}
+
+__bpf_kfunc_end_defs();
+
 static void bpf_iter_kmem_cache_show_fdinfo(const struct bpf_iter_aux_info *aux,
 					    struct seq_file *seq)
 {
-- 
2.47.0.rc1.288.g06298d1525-goog



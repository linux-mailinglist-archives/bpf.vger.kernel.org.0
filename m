Return-Path: <bpf+bounces-78551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD93D128C3
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 13:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA74130DC036
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 12:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268EA352C46;
	Mon, 12 Jan 2026 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wdQt9Vij"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835573570B3;
	Mon, 12 Jan 2026 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220798; cv=none; b=nRT75hh0LO94c7UEkk5oBMEXdFbMjXWJ9L9FXdE8xiEHqFHljMgEkIfaSjjjxnwnkAMJuXeWnf/fBqhj4cIvx6U2prenWSfGZ88rz8cjtQW4m6mS9QgG4S0MREE1NVtY1bYVvoH2bzEuhRk4NtIF07DA0q8ZxM48Ws6tn0wfTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220798; c=relaxed/simple;
	bh=bJduv67R8boTvchJnhDRVhbO0931p+1qMN9oGW0x0jI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=WxwGTIJAZ2aH7ia3Q6dILjcNOyrhUwvIVlqC18yECBInZ0P33crNfqsvM3S6Cy1guWUEMb5M4iJzZVsoaWFiKoQz7xG14r2x3SJVU2xrQIYRHsvrq7GRYJb61/HbfcuAWUngA1qVAKMA0cepGji+3X4weuX1MVBgDRFCK9RcQ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wdQt9Vij; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1768220782; bh=iXpwqy6VwqcV3q3i6hcRU0Z8M8cvJu+M3xrp2JLPKsc=;
	h=From:To:Cc:Subject:Date;
	b=wdQt9Vijea7Nfu8s8y/y1+89gSuXsD/tesgS+60VU8P26qblBSR8wNLhHJFWhlzqc
	 shQfGw7uoBXlp+cXcRd8xjTOW/mkZaPHZJaUdu8ipYVRAK1CmSxQZwkEuwqLrbWKSS
	 ESQkGsl6ltxVEcOrqTjnWESokHkIXwnoRQNMUCCo=
Received: from localhost.localdomain ([101.227.46.167])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 6472729B; Mon, 12 Jan 2026 20:25:07 +0800
X-QQ-mid: xmsmtpt1768220707td22v9c75
Message-ID: <tencent_0074C23A28B59EA264C502FA3C9EF6622A0A@qq.com>
X-QQ-XMAILINFO: N7NMbzIEsXzdQJHTCPMY3YDK1DcXc2WClLdzl+I96wVzZhAklQnUzGt0g283sj
	 4ODxwcPyL0VU3/GeLm2iUXSQj2oNPAaZgLOSe8xO1wNXGrsBySikoXa/41ahX02tvliYVe0eCWAM
	 TPVPEYzwXyAz54txBus+WIUWzUNzb65fJjqiVeO0s7+ezBKidm5qk7BjZCV2IS4Yta/aVnx0FGF3
	 kkaMKmLgUdJP8O8oqIbD0OSCLQl2m5qui9C/8HHbRdrwO/NEAVUeC26jPr2U8ZWsNosDc1SyWW7a
	 k7bSfu/nCBJkc9u/b0C+oYY2GyJUskqdJu50AxHO9y+b7yfsTP0dV/XMGPyEl0fMNkHktIYBH6rC
	 d/b/TbFSxvfirxky8oxHW7fxpqbhtZPOUp5rGhCNyUPgPHu0PhNtTiAOiSNjtZAPXQHLOQFpPA6f
	 5VliqMIH9mRqXW2V7Wf76/L4x9OqP98DloFWSZwSITo9Jdnu5ckppSrGrjb8lhunoQccbNyMeiJw
	 /c95UbYfZKjdKiAqYQojctcCb04BdczmVqrCQJtOvOmGTuwcL/t2X8uF8KA8R2g9eAhUf+hZJOCl
	 r6zGccYh+nEd2On6qKhyOoNvp7vlPhd+FcEZj0WLN+xK615Z6FYIOHQRGEn1Uxlj21mtEQWBwNg7
	 Geki/uRJWYTBSPqfOWlp9AlgGKOCbUDzV++NNAYIrupt9vSMK/UbeF+k3A1l3G9hZbmoGEasF+66
	 HDrjFIQnTV6KZF1xH/tlbv3A8/zyMFmpJzA0HZjucXPLp3Zvb24FyRKhaS3ZqZPjkiAjUGxQnq4h
	 aA9IHtPgFJtBpD7r+E4Uscp/4LDaJ0UygDvsrm/EyvgsvN36pVOmONpdjz1ocZ9Ya1v0twOdCkZz
	 p9Z6TdvVr02miEzBRIcmEPi3+QTLvd+HPrKP4ieDQvN4KCvSz+ewGkPS+TapvbHwCz/u5pjz8VLf
	 iIdz0USivOfcn5eDvl35ZARxL7XgjC7njU0HLH2uAGD2VK6TCpPsdCDG2QQIrTQDkg3ITOW2/b3t
	 aj9ESK0+Mg4wiCJ/hg8tplbXKIBVFP/YWvUbXo5f9VzeY93fwydX1Zszh9CrMF9BBTH5TIIIRJXA
	 b0xNJ/
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: wujing <realwujing@qq.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wujing <realwujing@qq.com>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: [PATCH] bpf/verifier: implement slab cache for verifier state list
Date: Mon, 12 Jan 2026 20:24:47 +0800
X-OQ-MSGID: <20260112122447.1098683-1-realwujing@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF verifier's state exploration logic in is_state_visited()
frequently allocates and deallocates 'struct bpf_verifier_state_list'
nodes to track explored states and prune the search space.

Currently, these allocations use generic kzalloc(), which can lead to
unnecessary memory fragmentation and performance overhead when
verifying high-complexity BPF programs with thousands of potential
states.

This patch introduces a dedicated slab cache, 'bpf_verifier_state_list',
to manage these allocations more efficiently. This provides better
allocation speed, reduced fragmentation, and improved cache locality
during the verification process.

Summary of changes:
- Define global 'bpf_verifier_state_list_cachep'.
- Initialize the cache via late_initcall() in bpf_verifier_init().
- Use kmem_cache_zalloc() in is_state_visited() to allocate new states.
- Replace kfree() with kmem_cache_free() in maybe_free_verifier_state(),
  is_state_visited() error paths, and free_states().

Signed-off-by: wujing <realwujing@qq.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/bpf/verifier.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f0ca69f888fa..681e35fa5a0f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -52,6 +52,7 @@ enum bpf_features {
 
 struct bpf_mem_alloc bpf_global_percpu_ma;
 static bool bpf_global_percpu_ma_set;
+static struct kmem_cache *bpf_verifier_state_list_cachep;
 
 /* bpf_check() is a static code analyzer that walks eBPF program
  * instruction by instruction and updates register/stack state.
@@ -1718,7 +1719,7 @@ static void maybe_free_verifier_state(struct bpf_verifier_env *env,
 		return;
 	list_del(&sl->node);
 	free_verifier_state(&sl->state, false);
-	kfree(sl);
+	kmem_cache_free(bpf_verifier_state_list_cachep, sl);
 	env->free_list_size--;
 }
 
@@ -20023,7 +20024,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	 * When looping the sl->state.branches will be > 0 and this state
 	 * will not be considered for equivalence until branches == 0.
 	 */
-	new_sl = kzalloc(sizeof(struct bpf_verifier_state_list), GFP_KERNEL_ACCOUNT);
+	new_sl = kmem_cache_zalloc(bpf_verifier_state_list_cachep, GFP_KERNEL_ACCOUNT);
 	if (!new_sl)
 		return -ENOMEM;
 	env->total_states++;
@@ -20041,7 +20042,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	err = copy_verifier_state(new, cur);
 	if (err) {
 		free_verifier_state(new, false);
-		kfree(new_sl);
+		kmem_cache_free(bpf_verifier_state_list_cachep, new_sl);
 		return err;
 	}
 	new->insn_idx = insn_idx;
@@ -20051,7 +20052,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	err = maybe_enter_scc(env, new);
 	if (err) {
 		free_verifier_state(new, false);
-		kfree(new_sl);
+		kmem_cache_free(bpf_verifier_state_list_cachep, new_sl);
 		return err;
 	}
 
@@ -23711,7 +23712,7 @@ static void free_states(struct bpf_verifier_env *env)
 	list_for_each_safe(pos, tmp, &env->free_list) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
 		free_verifier_state(&sl->state, false);
-		kfree(sl);
+		kmem_cache_free(bpf_verifier_state_list_cachep, sl);
 	}
 	INIT_LIST_HEAD(&env->free_list);
 
@@ -23734,7 +23735,7 @@ static void free_states(struct bpf_verifier_env *env)
 		list_for_each_safe(pos, tmp, head) {
 			sl = container_of(pos, struct bpf_verifier_state_list, node);
 			free_verifier_state(&sl->state, false);
-			kfree(sl);
+			kmem_cache_free(bpf_verifier_state_list_cachep, sl);
 		}
 		INIT_LIST_HEAD(&env->explored_states[i]);
 	}
@@ -25396,3 +25397,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	kvfree(env);
 	return ret;
 }
+
+static int __init bpf_verifier_init(void)
+{
+	bpf_verifier_state_list_cachep = kmem_cache_create("bpf_verifier_state_list",
+							   sizeof(struct bpf_verifier_state_list),
+							   0, SLAB_PANIC, NULL);
+	return 0;
+}
+late_initcall(bpf_verifier_init);
-- 
2.43.0



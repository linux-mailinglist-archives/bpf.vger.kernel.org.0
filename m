Return-Path: <bpf+bounces-78523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BD2D10C41
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 07:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCB9C30C2B45
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 06:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BDF31AAA2;
	Mon, 12 Jan 2026 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="njl9no/1"
X-Original-To: bpf@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192D3101BD;
	Mon, 12 Jan 2026 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200703; cv=none; b=M6B4M1ooafwXycGip+9jB6wKgG+m1enIUYT1yo7LhCoh9WbSYBxo/yPPlri0CX6FqL4qXejl+ENve4PVcB+ovbLQF/Ab/86PaC8hVNlCpTvCC3nrQW6T/BrJosD9+p7f5KWD0Iw1hmRUyanPMM9mc16KNncK1u+Mge+WUIu664g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200703; c=relaxed/simple;
	bh=quJvE8vwHYpHVBavlYKLXNnhs4IOSsGtUMCeys7CZnE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Lt9nvXZzooURnTGNiwGH3W72lWkyOA/UXEci0ZIZpJJyYLtaApgSc70LAPhy+7P0F+85Divzw6BuIlWGxsaxb/Hcm/bcyz8wvST8bQQiReBgj4bLXLycATAg9n6t/e5NC3oyV+umpX6+iCRa2BqQZOf74877HuoyLkm4ZSPjfQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=njl9no/1; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1768200693; bh=Qa6tB27g4TuNvXPUs8YdrNgF61XPByBVroSOodFWU0A=;
	h=From:To:Cc:Subject:Date;
	b=njl9no/1aj2JlbX4oPu9+hzj18RLS8Sy0tae3cHNNO5oj32BnqDeL34mOTzI7EhFs
	 PRlIhQ7sSDFpDr0SF5rk9M4HJMmrucIZAEOIuogGyDfFpSuzUOJBneAVPak7QHyh6S
	 tEVqQHIglC/Jglpv0smd8r8fo10/3j4MbXq9+cTQ=
Received: from localhost.localdomain ([101.227.46.167])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id C8F278E1; Mon, 12 Jan 2026 14:50:15 +0800
X-QQ-mid: xmsmtpt1768200615tlg886l4c
Message-ID: <tencent_B4B492A164C782F98C9C2E607E74B638FC0A@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAVnYhePoI1LQs7l55OAEmSe3roA+0jNNeRUynkl2oQrlDHJLL/3
	 6SZFBhrueazgJ05Z0DFPHPyPzBZJzZzweNyLf1ma3hurBhzCYKHqdRd4dw7jil2FbIeVHLPmFIT5
	 Erk6rNH0c2ny3CkeCri2IKIhyYMpVHBvSqsu6ULGwaL8KWfQQAEKMUMKXsmbSuT5GnycDDeHXBsi
	 FK750W25u2ch+P0mXbxLTqOTvzUX5aXsbQ8iLBF4zcRenWYFG2btiK3t7DkYwt0AS4iWnErwU72/
	 ZfNsAFa60t2o8WaUqpC1qfigkpVprKI00so5hbteDXX/O8cKgJ0AJUnSPhRPg+LqRMO38uEV8eBa
	 zfCXiq6BDgXmoNosa0+XMn8N4uyxJuIL9H2Ypgo6Cym8TO82Cf3sDRHVw7PwparAUUl36N0mkbzo
	 kQFyxd1sSYRD4xlTEwE1TmuW1S8KCWnouJYMHh+iz2Ik55ERp0IWN8prwE47M7WMUz8AA+cXKX4q
	 Aip+kWGwP3mZHa45zUBYEKyBu3u733aU/I35sc7XX4hqUelu8XwsVKLHXSHh4bmya2kUckV89cF5
	 lxcwGFEzh/BVp6YpepGsKA3sM30AdQlM+0LS5tO28jt6EiGcGVuHRuzUgBpKNNynUW4/L3XXxPCO
	 pSXHEDGDbO07Tt1LBAMepIOH+IVwpZ1qeD5vDkPPMoBWZ0bC5IOBx6bRKO72AKRzGKuNe/2vn52/
	 bSawyAIzw1E3qi2+uCWa2uNKRGy6FhF84ibf+UxZOW555oUNY6h/co3WGKx8OJuxhi5GAZFVtSTT
	 qMyZONxTdEucQFIMEGLdVOJ+rXUtIJcmeg8OGK2fNqFmJJPhQ3sjO1VwvItf8T4LxnSQsVRFu/Np
	 NBGT4jbwfsWjGA1IijUAbn0UXzAp0Tc2xfqbid8oN7r82TwpJZes+JYhb4mEdWUIfva+dSxQvfGs
	 X9YVq77zuHgsw7w8ORztDtWrjvQ9NojFF0xWvDuPDZkoE+MIJypY89J+6wDqZHGXGGgk++emRk1p
	 sb8J2NUdgAieBXUkbJXDOEJKSHD96AyPQfsjVPIdKAH/BH1Ay2eqmfNv0yMhw=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: wujing <realwujing@qq.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wujing <realwujing@qq.com>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: [PATCH] bpf/verifier: implement slab cache for verifier state list
Date: Mon, 12 Jan 2026 14:49:53 +0800
X-OQ-MSGID: <20260112064953.933973-1-realwujing@qq.com>
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
 kernel/bpf/verifier.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 169845710c7e..5c1be0cae4c2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -46,6 +46,7 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
 
 struct bpf_mem_alloc bpf_global_percpu_ma;
 static bool bpf_global_percpu_ma_set;
+static struct kmem_cache *bpf_verifier_state_list_cachep;
 
 /* bpf_check() is a static code analyzer that walks eBPF program
  * instruction by instruction and updates register/stack state.
@@ -1711,7 +1712,7 @@ static void maybe_free_verifier_state(struct bpf_verifier_env *env,
 			loop_entry_sl->state.used_as_loop_entry--;
 		list_del(&sl->node);
 		free_verifier_state(&sl->state, false);
-		kfree(sl);
+		kmem_cache_free(bpf_verifier_state_list_cachep, sl);
 		env->free_list_size--;
 		sl = loop_entry_sl;
 	}
@@ -19282,7 +19283,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	 * When looping the sl->state.branches will be > 0 and this state
 	 * will not be considered for equivalence until branches == 0.
 	 */
-	new_sl = kzalloc(sizeof(struct bpf_verifier_state_list), GFP_KERNEL);
+	new_sl = kmem_cache_zalloc(bpf_verifier_state_list_cachep, GFP_KERNEL);
 	if (!new_sl)
 		return -ENOMEM;
 	env->total_states++;
@@ -19300,7 +19301,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	err = copy_verifier_state(new, cur);
 	if (err) {
 		free_verifier_state(new, false);
-		kfree(new_sl);
+		kmem_cache_free(bpf_verifier_state_list_cachep, new_sl);
 		return err;
 	}
 	new->insn_idx = insn_idx;
@@ -22666,7 +22667,7 @@ static void free_states(struct bpf_verifier_env *env)
 	list_for_each_safe(pos, tmp, &env->free_list) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
 		free_verifier_state(&sl->state, false);
-		kfree(sl);
+		kmem_cache_free(bpf_verifier_state_list_cachep, sl);
 	}
 	INIT_LIST_HEAD(&env->free_list);
 
@@ -22679,7 +22680,7 @@ static void free_states(struct bpf_verifier_env *env)
 		list_for_each_safe(pos, tmp, head) {
 			sl = container_of(pos, struct bpf_verifier_state_list, node);
 			free_verifier_state(&sl->state, false);
-			kfree(sl);
+			kmem_cache_free(bpf_verifier_state_list_cachep, sl);
 		}
 		INIT_LIST_HEAD(&env->explored_states[i]);
 	}
@@ -24199,3 +24200,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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



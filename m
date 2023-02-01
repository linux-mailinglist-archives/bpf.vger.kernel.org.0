Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC7686BDB
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 17:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjBAQfi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 11:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjBAQfh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 11:35:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A7879F27
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 08:35:26 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg26so7276999wmb.0
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 08:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+Q37Omt/MAOZB85dyYH0VxCAqGyfL1V0CNFe50alWw=;
        b=PwWcZyLy+Z19hGnMU/rvK3uCeqYMJcoOHacKNeZ2E5eLBXT6GqsH1Mt31hw0qtXIxl
         aWTFapycW8vcGH3EpuYLmCKLHN5VfiMVOtmfowc1hqteDstL5qRq9q7/8c1pJFIGvahS
         gvTvMiculTkSVln7xHYS3kSRkQyOfyWWvdZI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+Q37Omt/MAOZB85dyYH0VxCAqGyfL1V0CNFe50alWw=;
        b=FCH5wnkIhMOq4o88lhkTMnzNxwSIfHv90Tx1b3ZaYpYbZJwdgwlenw7ErI/M3beOR9
         m9Pre3axHn00Ljtxkv1VcW+akpi8Gc6EGxiIFgfh2T8TQQ35ZTiU0bbycO8ehD3jYycT
         jEyWth4gdje/FXSxErGdzhc089Psq/FmFE6j3zipPMXCJJ/PuJg/NQeW9oEri1DYRVZp
         k3oREVSfW6l4FDAhkfcVIKaUIXehWWPobGNWh1EhsaTS20Ii0AjudD2gsHyMObXpVyZU
         w8qCtfhRJsPqoPJGXlykBoRROjziilqB3cNt5zhBmdlqJNN6XJFdLV6GjCfVP1y+jXqh
         GBrQ==
X-Gm-Message-State: AO0yUKUoziSp1U0FJs+OJyfTz2Y08Ak23gMtC8kcbbx3jjEkezidxHkk
        1v12ioFN9r2Yrl7AI4gKcGx5rQ==
X-Google-Smtp-Source: AK7set9awnPFkuzEz1Qn8JL87YeR7SuUxoCuq0lSCj5ljB3NM5/2b/wlbhBsLnwXxTbEcLRQcu8xnw==
X-Received: by 2002:a7b:c85a:0:b0:3d2:392e:905f with SMTP id c26-20020a7bc85a000000b003d2392e905fmr2646774wml.24.1675269325301;
        Wed, 01 Feb 2023 08:35:25 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4399:89a1:4a86:9630])
        by smtp.gmail.com with ESMTPSA id r38-20020a05600c322600b003dd7edcc960sm2058522wmp.45.2023.02.01.08.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:35:24 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH 2/8] ftrace: Remove the legacy _ftrace_direct API
Date:   Wed,  1 Feb 2023 17:34:14 +0100
Message-Id: <20230201163420.1579014-3-revest@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230201163420.1579014-1-revest@chromium.org>
References: <20230201163420.1579014-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This API relies on a single global ops, used for all direct calls
registered with it. However, to implement arm64 direct calls, we need
each ops to point to a single direct call trampoline.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/ftrace.h |  32 ----
 kernel/trace/ftrace.c  | 393 -----------------------------------------
 2 files changed, 425 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 366c730beaa3..2d7c85e47c2d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -397,14 +397,6 @@ struct ftrace_func_entry {
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 extern int ftrace_direct_func_count;
-int register_ftrace_direct(unsigned long ip, unsigned long addr);
-int unregister_ftrace_direct(unsigned long ip, unsigned long addr);
-int modify_ftrace_direct(unsigned long ip, unsigned long old_addr, unsigned long new_addr);
-struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr);
-int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
-				struct dyn_ftrace *rec,
-				unsigned long old_addr,
-				unsigned long new_addr);
 unsigned long ftrace_find_rec_direct(unsigned long ip);
 int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
 int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
@@ -414,30 +406,6 @@ int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr
 #else
 struct ftrace_ops;
 # define ftrace_direct_func_count 0
-static inline int register_ftrace_direct(unsigned long ip, unsigned long addr)
-{
-	return -ENOTSUPP;
-}
-static inline int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
-{
-	return -ENOTSUPP;
-}
-static inline int modify_ftrace_direct(unsigned long ip,
-				       unsigned long old_addr, unsigned long new_addr)
-{
-	return -ENOTSUPP;
-}
-static inline struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr)
-{
-	return NULL;
-}
-static inline int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
-					      struct dyn_ftrace *rec,
-					      unsigned long old_addr,
-					      unsigned long new_addr)
-{
-	return -ENODEV;
-}
 static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
 {
 	return 0;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e634b80f49d1..5efe201428fa 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2585,20 +2585,6 @@ static void call_direct_funcs(unsigned long ip, unsigned long pip,
 
 	arch_ftrace_set_direct_caller(fregs, addr);
 }
-
-struct ftrace_ops direct_ops = {
-	.func		= call_direct_funcs,
-	.flags		= FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS
-			  | FTRACE_OPS_FL_PERMANENT,
-	/*
-	 * By declaring the main trampoline as this trampoline
-	 * it will never have one allocated for it. Allocated
-	 * trampolines should not call direct functions.
-	 * The direct_ops should only be called by the builtin
-	 * ftrace_regs_caller trampoline.
-	 */
-	.trampoline	= FTRACE_REGS_ADDR,
-};
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
@@ -5295,387 +5281,8 @@ struct ftrace_direct_func {
 
 static LIST_HEAD(ftrace_direct_funcs);
 
-/**
- * ftrace_find_direct_func - test an address if it is a registered direct caller
- * @addr: The address of a registered direct caller
- *
- * This searches to see if a ftrace direct caller has been registered
- * at a specific address, and if so, it returns a descriptor for it.
- *
- * This can be used by architecture code to see if an address is
- * a direct caller (trampoline) attached to a fentry/mcount location.
- * This is useful for the function_graph tracer, as it may need to
- * do adjustments if it traced a location that also has a direct
- * trampoline attached to it.
- */
-struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr)
-{
-	struct ftrace_direct_func *entry;
-	bool found = false;
-
-	/* May be called by fgraph trampoline (protected by rcu tasks) */
-	list_for_each_entry_rcu(entry, &ftrace_direct_funcs, next) {
-		if (entry->addr == addr) {
-			found = true;
-			break;
-		}
-	}
-	if (found)
-		return entry;
-
-	return NULL;
-}
-
-static struct ftrace_direct_func *ftrace_alloc_direct_func(unsigned long addr)
-{
-	struct ftrace_direct_func *direct;
-
-	direct = kmalloc(sizeof(*direct), GFP_KERNEL);
-	if (!direct)
-		return NULL;
-	direct->addr = addr;
-	direct->count = 0;
-	list_add_rcu(&direct->next, &ftrace_direct_funcs);
-	ftrace_direct_func_count++;
-	return direct;
-}
-
 static int register_ftrace_function_nolock(struct ftrace_ops *ops);
 
-/**
- * register_ftrace_direct - Call a custom trampoline directly
- * @ip: The address of the nop at the beginning of a function
- * @addr: The address of the trampoline to call at @ip
- *
- * This is used to connect a direct call from the nop location (@ip)
- * at the start of ftrace traced functions. The location that it calls
- * (@addr) must be able to handle a direct call, and save the parameters
- * of the function being traced, and restore them (or inject new ones
- * if needed), before returning.
- *
- * Returns:
- *  0 on success
- *  -EBUSY - Another direct function is already attached (there can be only one)
- *  -ENODEV - @ip does not point to a ftrace nop location (or not supported)
- *  -ENOMEM - There was an allocation failure.
- */
-int register_ftrace_direct(unsigned long ip, unsigned long addr)
-{
-	struct ftrace_direct_func *direct;
-	struct ftrace_func_entry *entry;
-	struct ftrace_hash *free_hash = NULL;
-	struct dyn_ftrace *rec;
-	int ret = -ENODEV;
-
-	mutex_lock(&direct_mutex);
-
-	ip = ftrace_location(ip);
-	if (!ip)
-		goto out_unlock;
-
-	/* See if there's a direct function at @ip already */
-	ret = -EBUSY;
-	if (ftrace_find_rec_direct(ip))
-		goto out_unlock;
-
-	ret = -ENODEV;
-	rec = lookup_rec(ip, ip);
-	if (!rec)
-		goto out_unlock;
-
-	/*
-	 * Check if the rec says it has a direct call but we didn't
-	 * find one earlier?
-	 */
-	if (WARN_ON(rec->flags & FTRACE_FL_DIRECT))
-		goto out_unlock;
-
-	/* Make sure the ip points to the exact record */
-	if (ip != rec->ip) {
-		ip = rec->ip;
-		/* Need to check this ip for a direct. */
-		if (ftrace_find_rec_direct(ip))
-			goto out_unlock;
-	}
-
-	ret = -ENOMEM;
-	direct = ftrace_find_direct_func(addr);
-	if (!direct) {
-		direct = ftrace_alloc_direct_func(addr);
-		if (!direct)
-			goto out_unlock;
-	}
-
-	entry = ftrace_add_rec_direct(ip, addr, &free_hash);
-	if (!entry)
-		goto out_unlock;
-
-	ret = ftrace_set_filter_ip(&direct_ops, ip, 0, 0);
-
-	if (!ret && !(direct_ops.flags & FTRACE_OPS_FL_ENABLED)) {
-		ret = register_ftrace_function_nolock(&direct_ops);
-		if (ret)
-			ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
-	}
-
-	if (ret) {
-		remove_hash_entry(direct_functions, entry);
-		kfree(entry);
-		if (!direct->count) {
-			list_del_rcu(&direct->next);
-			synchronize_rcu_tasks();
-			kfree(direct);
-			if (free_hash)
-				free_ftrace_hash(free_hash);
-			free_hash = NULL;
-			ftrace_direct_func_count--;
-		}
-	} else {
-		direct->count++;
-	}
- out_unlock:
-	mutex_unlock(&direct_mutex);
-
-	if (free_hash) {
-		synchronize_rcu_tasks();
-		free_ftrace_hash(free_hash);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(register_ftrace_direct);
-
-static struct ftrace_func_entry *find_direct_entry(unsigned long *ip,
-						   struct dyn_ftrace **recp)
-{
-	struct ftrace_func_entry *entry;
-	struct dyn_ftrace *rec;
-
-	rec = lookup_rec(*ip, *ip);
-	if (!rec)
-		return NULL;
-
-	entry = __ftrace_lookup_ip(direct_functions, rec->ip);
-	if (!entry) {
-		WARN_ON(rec->flags & FTRACE_FL_DIRECT);
-		return NULL;
-	}
-
-	WARN_ON(!(rec->flags & FTRACE_FL_DIRECT));
-
-	/* Passed in ip just needs to be on the call site */
-	*ip = rec->ip;
-
-	if (recp)
-		*recp = rec;
-
-	return entry;
-}
-
-int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
-{
-	struct ftrace_direct_func *direct;
-	struct ftrace_func_entry *entry;
-	struct ftrace_hash *hash;
-	int ret = -ENODEV;
-
-	mutex_lock(&direct_mutex);
-
-	ip = ftrace_location(ip);
-	if (!ip)
-		goto out_unlock;
-
-	entry = find_direct_entry(&ip, NULL);
-	if (!entry)
-		goto out_unlock;
-
-	hash = direct_ops.func_hash->filter_hash;
-	if (hash->count == 1)
-		unregister_ftrace_function(&direct_ops);
-
-	ret = ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
-
-	WARN_ON(ret);
-
-	remove_hash_entry(direct_functions, entry);
-
-	direct = ftrace_find_direct_func(addr);
-	if (!WARN_ON(!direct)) {
-		/* This is the good path (see the ! before WARN) */
-		direct->count--;
-		WARN_ON(direct->count < 0);
-		if (!direct->count) {
-			list_del_rcu(&direct->next);
-			synchronize_rcu_tasks();
-			kfree(direct);
-			kfree(entry);
-			ftrace_direct_func_count--;
-		}
-	}
- out_unlock:
-	mutex_unlock(&direct_mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(unregister_ftrace_direct);
-
-static struct ftrace_ops stub_ops = {
-	.func		= ftrace_stub,
-};
-
-/**
- * ftrace_modify_direct_caller - modify ftrace nop directly
- * @entry: The ftrace hash entry of the direct helper for @rec
- * @rec: The record representing the function site to patch
- * @old_addr: The location that the site at @rec->ip currently calls
- * @new_addr: The location that the site at @rec->ip should call
- *
- * An architecture may overwrite this function to optimize the
- * changing of the direct callback on an ftrace nop location.
- * This is called with the ftrace_lock mutex held, and no other
- * ftrace callbacks are on the associated record (@rec). Thus,
- * it is safe to modify the ftrace record, where it should be
- * currently calling @old_addr directly, to call @new_addr.
- *
- * This is called with direct_mutex locked.
- *
- * Safety checks should be made to make sure that the code at
- * @rec->ip is currently calling @old_addr. And this must
- * also update entry->direct to @new_addr.
- */
-int __weak ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
-				       struct dyn_ftrace *rec,
-				       unsigned long old_addr,
-				       unsigned long new_addr)
-{
-	unsigned long ip = rec->ip;
-	int ret;
-
-	lockdep_assert_held(&direct_mutex);
-
-	/*
-	 * The ftrace_lock was used to determine if the record
-	 * had more than one registered user to it. If it did,
-	 * we needed to prevent that from changing to do the quick
-	 * switch. But if it did not (only a direct caller was attached)
-	 * then this function is called. But this function can deal
-	 * with attached callers to the rec that we care about, and
-	 * since this function uses standard ftrace calls that take
-	 * the ftrace_lock mutex, we need to release it.
-	 */
-	mutex_unlock(&ftrace_lock);
-
-	/*
-	 * By setting a stub function at the same address, we force
-	 * the code to call the iterator and the direct_ops helper.
-	 * This means that @ip does not call the direct call, and
-	 * we can simply modify it.
-	 */
-	ret = ftrace_set_filter_ip(&stub_ops, ip, 0, 0);
-	if (ret)
-		goto out_lock;
-
-	ret = register_ftrace_function_nolock(&stub_ops);
-	if (ret) {
-		ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
-		goto out_lock;
-	}
-
-	entry->direct = new_addr;
-
-	/*
-	 * By removing the stub, we put back the direct call, calling
-	 * the @new_addr.
-	 */
-	unregister_ftrace_function(&stub_ops);
-	ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
-
- out_lock:
-	mutex_lock(&ftrace_lock);
-
-	return ret;
-}
-
-/**
- * modify_ftrace_direct - Modify an existing direct call to call something else
- * @ip: The instruction pointer to modify
- * @old_addr: The address that the current @ip calls directly
- * @new_addr: The address that the @ip should call
- *
- * This modifies a ftrace direct caller at an instruction pointer without
- * having to disable it first. The direct call will switch over to the
- * @new_addr without missing anything.
- *
- * Returns: zero on success. Non zero on error, which includes:
- *  -ENODEV : the @ip given has no direct caller attached
- *  -EINVAL : the @old_addr does not match the current direct caller
- */
-int modify_ftrace_direct(unsigned long ip,
-			 unsigned long old_addr, unsigned long new_addr)
-{
-	struct ftrace_direct_func *direct, *new_direct = NULL;
-	struct ftrace_func_entry *entry;
-	struct dyn_ftrace *rec;
-	int ret = -ENODEV;
-
-	mutex_lock(&direct_mutex);
-
-	mutex_lock(&ftrace_lock);
-
-	ip = ftrace_location(ip);
-	if (!ip)
-		goto out_unlock;
-
-	entry = find_direct_entry(&ip, &rec);
-	if (!entry)
-		goto out_unlock;
-
-	ret = -EINVAL;
-	if (entry->direct != old_addr)
-		goto out_unlock;
-
-	direct = ftrace_find_direct_func(old_addr);
-	if (WARN_ON(!direct))
-		goto out_unlock;
-	if (direct->count > 1) {
-		ret = -ENOMEM;
-		new_direct = ftrace_alloc_direct_func(new_addr);
-		if (!new_direct)
-			goto out_unlock;
-		direct->count--;
-		new_direct->count++;
-	} else {
-		direct->addr = new_addr;
-	}
-
-	/*
-	 * If there's no other ftrace callback on the rec->ip location,
-	 * then it can be changed directly by the architecture.
-	 * If there is another caller, then we just need to change the
-	 * direct caller helper to point to @new_addr.
-	 */
-	if (ftrace_rec_count(rec) == 1) {
-		ret = ftrace_modify_direct_caller(entry, rec, old_addr, new_addr);
-	} else {
-		entry->direct = new_addr;
-		ret = 0;
-	}
-
-	if (unlikely(ret && new_direct)) {
-		direct->count++;
-		list_del_rcu(&new_direct->next);
-		synchronize_rcu_tasks();
-		kfree(new_direct);
-		ftrace_direct_func_count--;
-	}
-
- out_unlock:
-	mutex_unlock(&ftrace_lock);
-	mutex_unlock(&direct_mutex);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(modify_ftrace_direct);
-
 #define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
 
 static int check_direct_multi(struct ftrace_ops *ops)
-- 
2.39.1.519.gcb327c4b5f-goog


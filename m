Return-Path: <bpf+bounces-34640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0AF92F85F
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 11:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C10B1C20EF3
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 09:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99732148300;
	Fri, 12 Jul 2024 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKHKztw7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C482217BB6;
	Fri, 12 Jul 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777899; cv=none; b=Sx7devkQGPzy6phs06heN1F0TP18N6nax3hiJlh7A63p2dcEY0CybEXIz+2k0FGhEXWLJpqA84GRybXAnUXM1vBeRFzRi+9ypvuTY3RxEvzcaMKqJgXhNtbLNGRMim2+0wl19kcwiyQZv82NU8Fu54tGex5Y0EIg935/YsVZy6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777899; c=relaxed/simple;
	bh=umERRsSd8g5DPFaJVrz5gLIFEmGnXj6vwXWkh9WYxkM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Naz/F0pjzzsns2KGArI/TzybFvIX8Wo1kn6aNlB/QhtcNLAqIgEWazrgRiM0RLwlBaEVwb7Ad+Klvs3UC3rdg3LMj2r35UFZKdiYFvyQSuO7toKzzz3QC4epVtsWjmh8LugAtefprm9Ss/pryDuVxsJcV6jaC8GLChf7XFIbQ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKHKztw7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70b0d0a7a56so1652806b3a.0;
        Fri, 12 Jul 2024 02:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720777897; x=1721382697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wPGPH46k7o5HbMYuCRNoYeBltJb7ZUI77U0SMjuuHjU=;
        b=SKHKztw7CMXiF9C6JBSJKE9AbwswjARvRw1Zy5wPYzoQ/WrXUcvTwxIoZzrq802P4C
         pgYU+igwVy7aYGH1Lt9gQdVLu6yCgkxx6GB+ugWe5BSXTEztl8ITmCBfoYQMjBel9qcv
         2RLVaq90YgoL8MbhygnB/uXqJ8Mx9Z22lPB7lw6Bx7TId42DcVR3eDrM1lzUY45w66qX
         xIzSU+uG1WMNhZvhyCRam5KBVj2iYJzPUq2Zr+GDHzqvUpRxcAUrOlOMVY3Gp8p4Emyw
         f2a2SKEC7kgd/w2MAEM6MxVXti4Qw+XrdTQJGvg3EERo04IRuehNES3QmQpWw62AxqEd
         +nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720777897; x=1721382697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPGPH46k7o5HbMYuCRNoYeBltJb7ZUI77U0SMjuuHjU=;
        b=H7j83e5A1j7p+j2gkJJVKlmIR7XffNDBclyRo8//IxxaV2ggZQftRcht9sHo0ym+96
         Dj62a8pP5Dd9rojVQUDUaW7zesKbwrn/yFny9GwXGvVx3cp7PLszT9lhMszkGEfJzmy2
         RqfhfZC5FCpbqpGrkK3GEjDyfCul9ZcCD+trOIdBRXJGl15xaBq6hawkmEQndwlexUjX
         wfOshBmOtx839mNDoaoRWGQ3vQtvHvd6xxXVWm55kR2qHUFf9FIOZrn2K9/oQELzxLCN
         No2+WLwEIPOhmZmSGK114Rl/8BtpfjAVnWGSvWeyGMffcqHCUJHpP00TflFZbWRhv4Zb
         mHrg==
X-Forwarded-Encrypted: i=1; AJvYcCUAh09B6gP1x6SvBtalItwwMaLHXtCwI8DvpDPQtIJbac3Cln5JKctglyYthNskIyWFR8H+m0DOyB7xpHJykQU+l0HZkVI13/J0oBQZM73qGaLWx4FRw+BMVQoM
X-Gm-Message-State: AOJu0Yyep1dJMyDid4tyMU085Tm5RUlDIDo1alTxIqmz6+txfydQFL1d
	GFysR4yKIL9koD/7MyHljcmeDO+0CHI8Z2pJKGSbJOT6+F0QDvWe
X-Google-Smtp-Source: AGHT+IEKqr80F3MwHPFCjT17Ot3ryWgBXRjDoksla2S8v9hjO8fMmSVDt563bpooMOkGaM97GAjiHQ==
X-Received: by 2002:a05:6a21:7885:b0:1c0:f5fa:db10 with SMTP id adf61e73a8af0-1c297d368c5mr13785343637.0.1720777896870;
        Fri, 12 Jul 2024 02:51:36 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a292a4sm63379165ad.66.2024.07.12.02.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 02:51:36 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ap420073@gmail.com,
	ilias.apalodimas@linaro.org,
	jonathan.lemon@gmail.com
Subject: [PATCH net] xdp: fix invalid wait context of page_pool_destroy()
Date: Fri, 12 Jul 2024 09:51:16 +0000
Message-Id: <20240712095116.3801586-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the driver uses a page pool, it creates a page pool with
page_pool_create().
The reference count of page pool is 1 as default.
A page pool will be destroyed only when a reference count reaches 0.
page_pool_destroy() is used to destroy page pool, it decreases a
reference count.
When a page pool is destroyed, ->disconnect() is called, which is
mem_allocator_disconnect().
This function internally acquires mutex_lock().

If the driver uses XDP, it registers a memory model with
xdp_rxq_info_reg_mem_model().
The xdp_rxq_info_reg_mem_model() internally increases a page pool
reference count if a memory model is a page pool.
Now the reference count is 2.

To destroy a page pool, the driver should call both page_pool_destroy()
and xdp_unreg_mem_model().
The xdp_unreg_mem_model() internally calls page_pool_destroy().
Only page_pool_destroy() decreases a reference count.

If a driver calls page_pool_destroy() then xdp_unreg_mem_model(), we
will face an invalid wait context warning.
Because xdp_unreg_mem_model() calls page_pool_destroy() with
rcu_read_lock().
The page_pool_destroy() internally acquires mutex_lock().

Splat looks like:
=============================
[ BUG: Invalid wait context ]
6.10.0-rc6+ #4 Tainted: G W
-----------------------------
ethtool/1806 is trying to lock:
ffffffff90387b90 (mem_id_lock){+.+.}-{4:4}, at: mem_allocator_disconnect+0x73/0x150
other info that might help us debug this:
context-{5:5}
3 locks held by ethtool/1806:
stack backtrace:
CPU: 0 PID: 1806 Comm: ethtool Tainted: G W 6.10.0-rc6+ #4 f916f41f172891c800f2fed
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/2021
Call Trace:
<TASK>
dump_stack_lvl+0x7e/0xc0
__lock_acquire+0x1681/0x4de0
? _printk+0x64/0xe0
? __pfx_mark_lock.part.0+0x10/0x10
? __pfx___lock_acquire+0x10/0x10
lock_acquire+0x1b3/0x580
? mem_allocator_disconnect+0x73/0x150
? __wake_up_klogd.part.0+0x16/0xc0
? __pfx_lock_acquire+0x10/0x10
? dump_stack_lvl+0x91/0xc0
__mutex_lock+0x15c/0x1690
? mem_allocator_disconnect+0x73/0x150
? __pfx_prb_read_valid+0x10/0x10
? mem_allocator_disconnect+0x73/0x150
? __pfx_llist_add_batch+0x10/0x10
? console_unlock+0x193/0x1b0
? lockdep_hardirqs_on+0xbe/0x140
? __pfx___mutex_lock+0x10/0x10
? tick_nohz_tick_stopped+0x16/0x90
? __irq_work_queue_local+0x1e5/0x330
? irq_work_queue+0x39/0x50
? __wake_up_klogd.part.0+0x79/0xc0
? mem_allocator_disconnect+0x73/0x150
mem_allocator_disconnect+0x73/0x150
? __pfx_mem_allocator_disconnect+0x10/0x10
? mark_held_locks+0xa5/0xf0
? rcu_is_watching+0x11/0xb0
page_pool_release+0x36e/0x6d0
page_pool_destroy+0xd7/0x440
xdp_unreg_mem_model+0x1a7/0x2a0
? __pfx_xdp_unreg_mem_model+0x10/0x10
? kfree+0x125/0x370
? bnxt_free_ring.isra.0+0x2eb/0x500
? bnxt_free_mem+0x5ac/0x2500
xdp_rxq_info_unreg+0x4a/0xd0
bnxt_free_mem+0x1356/0x2500
bnxt_close_nic+0xf0/0x3b0
? __pfx_bnxt_close_nic+0x10/0x10
? ethnl_parse_bit+0x2c6/0x6d0
? __pfx___nla_validate_parse+0x10/0x10
? __pfx_ethnl_parse_bit+0x10/0x10
bnxt_set_features+0x2a8/0x3e0
__netdev_update_features+0x4dc/0x1370
? ethnl_parse_bitset+0x4ff/0x750
? __pfx_ethnl_parse_bitset+0x10/0x10
? __pfx___netdev_update_features+0x10/0x10
? mark_held_locks+0xa5/0xf0
? _raw_spin_unlock_irqrestore+0x42/0x70
? __pm_runtime_resume+0x7d/0x110
ethnl_set_features+0x32d/0xa20

To fix this problem, it uses rhashtable_lookup_fast() instead of
rhashtable_lookup() with rcu_read_lock().
Using xa without rcu_read_lock() here is safe.
xa is freed by __xdp_mem_allocator_rcu_free() and this is called by
call_rcu() of mem_xa_remove().
The mem_xa_remove() is called by page_pool_destroy() if a reference
count reaches 0.
The xa is already protected by the reference count mechanism well in the
control plane.
So removing rcu_read_lock() for page_pool_destroy() is safe.

Fixes: c3f812cea0d7 ("page_pool: do not release pool until inflight == 0.")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

Tested this patch with device memory TCP, which is not yet merged into the 
net and net-next branch.

 net/core/xdp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 022c12059cf2..bcc5551c6424 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -127,10 +127,8 @@ void xdp_unreg_mem_model(struct xdp_mem_info *mem)
 		return;
 
 	if (type == MEM_TYPE_PAGE_POOL) {
-		rcu_read_lock();
-		xa = rhashtable_lookup(mem_id_ht, &id, mem_id_rht_params);
+		xa = rhashtable_lookup_fast(mem_id_ht, &id, mem_id_rht_params);
 		page_pool_destroy(xa->page_pool);
-		rcu_read_unlock();
 	}
 }
 EXPORT_SYMBOL_GPL(xdp_unreg_mem_model);
-- 
2.34.1



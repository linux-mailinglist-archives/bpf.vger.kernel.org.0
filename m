Return-Path: <bpf+bounces-51225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2872FA3216E
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 09:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5571887192
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC2A2054FC;
	Wed, 12 Feb 2025 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dvqkm4aW"
X-Original-To: bpf@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C61E492D;
	Wed, 12 Feb 2025 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350175; cv=none; b=P6ISRd5XrrWiJc/yvu7xXdJ6J5bwHZ/RbRhIrHPf7mSaye6m/MFPnDxD69yTA0Gl9dWyJq/F9uzITZS56ZXEPfdUd4g+oHk9NyAkJJ9rcgQW9Di0nJQk6MI/0PqRQPzIHLn5cF5P+hgotbB0QW4zaMH2oWT9dBZxEHpfX1iXmCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350175; c=relaxed/simple;
	bh=eKB5FUy2/4etCNNftQt6fJKYOsgB0EKwlpmrXvIqxM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RaQOjv6RKXMSG2yW8jt56XHw+11nppUrr3Zv28pxEx2lvzzNjypEHV993JxHE6xtnYkY5jZAUTr9dkWv8Eqp35/4zAUfqV4U+tklCiHssXnGeXRyVtVwf+aFhp7wTTAC5X6IyENwBQI0Hl7w+904t41q3UvWTRC09PmvC8Reo68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dvqkm4aW; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ApursoI+BOhKUdBUZKDlyt1NvQ/f3g0e587NGBf3xgY=; b=dvqkm4aWWhl2ISqKc6bKGutFSy
	DVQvi7uHh3lZx/nD3QY0b5Yddvs4y594kG3W+Zbx3fF9eEheQC2kqHlh02FRKujYx6KzEH5fozjor
	FbBHiJPxMH+5oKq8Fq+ElHLsB0tH0AZgF+YT4V+wGT1tHBYKMA0dOJbEKGVObckYl2zIAEuFlr34Q
	Qo/VX2sjmXKzyKgWbB7xdqgzXjuz9+8PEWVjS9Bo5zrU44IyNEQ07QiD6NWVH90xjq3sDUSciKQG8
	pCAPehucpUw933POQKhOQC3jhE+h0BBUHgspkuAjACxMf67BfCPX5bKeN/L8egtnXczf+WKYUz0LC
	eGjAqXQA==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ti8QT-0089iO-Tl; Wed, 12 Feb 2025 09:49:04 +0100
From: Changwoo Min <changwoo@igalia.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: tj@kernel.org,
	arighi@nvidia.com,
	kernel-dev@igalia.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH bpf-next] bpf: Add a retry after refilling the free list when unit_alloc() fails
Date: Wed, 12 Feb 2025 17:48:51 +0900
Message-ID: <20250212084851.150169-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there is no entry in the free list (c->free_llist), unit_alloc()
fails even when there is available memory in the system, causing allocation
failure in various BPF calls -- such as bpf_mem_alloc() and
bpf_cpumask_create().

Such allocation failure can happen, especially when a BPF program tries many
allocations -- more than a delta between high and low watermarks -- in an
IRQ-disabled context.

To address the problem, when there is no free entry, refill one entry on the
free list (alloc_bulk) and then retry the allocation procedure on the free
list. Note that since some callers of unit_alloc() do not allow to block
(e.g., bpf_cpumask_create), allocate the additional free entry in an atomic
manner (atomic = true in alloc_bulk).

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/bpf/memalloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 889374722d0a..22fe9cfb2b56 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -784,6 +784,7 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
 	struct llist_node *llnode = NULL;
 	unsigned long flags;
 	int cnt = 0;
+	bool retry = false;
 
 	/* Disable irqs to prevent the following race for majority of prog types:
 	 * prog_A
@@ -795,6 +796,7 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
 	 * Use per-cpu 'active' counter to order free_list access between
 	 * unit_alloc/unit_free/bpf_mem_refill.
 	 */
+retry_alloc:
 	local_irq_save(flags);
 	if (local_inc_return(&c->active) == 1) {
 		llnode = __llist_del_first(&c->free_llist);
@@ -815,6 +817,13 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
 	 */
 	local_irq_restore(flags);
 
+	if (unlikely(!llnode && !retry)) {
+		int cpu = smp_processor_id();
+		alloc_bulk(c, 1, cpu_to_node(cpu), true);
+		retry = true;
+		goto retry_alloc;
+	}
+
 	return llnode;
 }
 
-- 
2.48.1



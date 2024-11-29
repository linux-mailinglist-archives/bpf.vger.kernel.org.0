Return-Path: <bpf+bounces-45865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CD19DC171
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 10:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD76283B99
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 09:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDBB176ABA;
	Fri, 29 Nov 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="CuwP0BZr"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4366214F135;
	Fri, 29 Nov 2024 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732872376; cv=none; b=N70XCe+x/EzL46OyVzrFywmpYJKMeo9OT39XCaEZDNANSuQwsxIvHm3dDHtSwnlF/vxY/8wijB3sCKkO+0NnF7UZyhmlUL0/gZEce469+mGwYE90b5IcsH1yFVLycJtypNEUE2mpWaJtfTb/EfWgAZzbaCclllMoHl6tf8vL34Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732872376; c=relaxed/simple;
	bh=+yuShxEOVmN7TG8kJ2CNcYyFkUOoWKElgUyirL+GhfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V0n3DRlxXprwCbN89z6FHi3NrH1npHMaAy9oEoUoZBaOhrDuvuc7K3WhK2LjytmEgtAGygOqUIBqYg+rlwEHc5K/spDMNFqe4Tcj4q3DemeHcUEnGut2PP2JKt9PwZVq3vmNZ7nNeQUM2nirrALQPHGTOmHSpeR/NwVMqJjabpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=CuwP0BZr; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6GuQz
	Xe2jI5FYysiuhEkePfzpCup693XR+LvZVdGDjY=; b=CuwP0BZrXmIf9pAo0TQzL
	EFR57vNAZfVv3+R3jYsCybXavQxjQSjIRG/bIddT2CTK5fJMwD9iC82S9eyZATT+
	zI8D99/haFuqTf5Iz57OcckkIkVZ+lx22rvdePfvkV6A1eFveO23I+lt0ir+e+xI
	1IzLUqKJJFk/NY6kllCbEU=
Received: from localhost.localdomain (unknown [111.204.182.99])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3vwjshElng6j+Bw--.51373S2;
	Fri, 29 Nov 2024 17:10:06 +0800 (CST)
From: Honglei Wang <jameshongleiwang@126.com>
To: tj@kernel.org,
	void@manifault.com
Cc: nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	haoluo@google.com,
	brho@google.com,
	joshdon@google.com,
	vishalc@linux.ibm.com,
	hongyan.xia2@arm.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	jameshongleiwang@126.com
Subject: [PATCH] sched_ext: Add __weak to fix the build errors
Date: Fri, 29 Nov 2024 17:10:03 +0800
Message-Id: <20241129091003.87716-1-jameshongleiwang@126.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vwjshElng6j+Bw--.51373S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw18tF18Cr1UKryfXry3twb_yoW8CF4rpa
	1rua4DCF4xJwsruryqya109ry3Wws5W3W7GrW8J34SkrWqqw1Utr1Yvr9FkFZxW3yqkwnI
	9F1I93y3tr48Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zib18dUUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbiJAmmrWdJgU82bwAAsf

commit 5cbb302880f5 ("sched_ext: Rename
scx_bpf_dispatch[_vtime]_from_dsq*() -> scx_bpf_dsq_move[_vtime]*()")
introduced several new functions which caused compilation errors when
compiled with clang.

Let's fix this by adding __weak markers.

Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
---
 tools/sched_ext/include/scx/common.bpf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 2f36b7b6418d..625f5b046776 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -40,9 +40,9 @@ void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_fl
 void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
-bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym;
-void scx_bpf_dsq_move_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym;
-void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym;
+bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
+void scx_bpf_dsq_move_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
+void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
 bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 u32 scx_bpf_reenqueue_local(void) __ksym;
-- 
2.45.2



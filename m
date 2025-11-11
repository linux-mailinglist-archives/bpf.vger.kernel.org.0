Return-Path: <bpf+bounces-74114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4FFC49E29
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 01:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8083ABB1B
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 00:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC6A24676B;
	Tue, 11 Nov 2025 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="v17SCKU7"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE2334D38D;
	Tue, 11 Nov 2025 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821471; cv=none; b=NEEr7hAznofbIpZtQY27jWhZPM43iQK9/yTopuVv3Mejvkidvrzgcpgfgec/tzd0N/KhIMGXYF+kxQwbZx8FSvxXcTOAMYLcKcTShTy+YbBUoMl3vVGM9BDV+f4OCpgEy4kijCdkLHRH6upLZ9dmLHv1wc3lRpb4iOZxfHRf75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821471; c=relaxed/simple;
	bh=CXUca8YX0lqu5nzun2xmmizNpx8K/emG0bVPAISOubw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ua/yabWCBqnLLJBTfz9Rm/kLMm4v71ovsRJNzqT+91U1557ecSbP6qdQhOCZsPYh3TiLbRCgNm3nASAaq4SiQzts0hVqe2SrrBbF3uNZPaPvj1+P+wlcY/v5X6jQI76gMuKlUtsM11YK7YNzr5AJ8jktBjNh3X1sscnTS72YAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=v17SCKU7; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d570g0Z3vz9t7M;
	Tue, 11 Nov 2025 01:37:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1762821459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuZRMwi3IQuVG4xNekc3Mlt/5lCSesgrsdugH2WI734=;
	b=v17SCKU7lI2YxrvALwwN5vaDSCmgNUkQ8omYw6b2hWo/KGwT1T43RNMQXAAAQ3U+qm7+pv
	m9xjAria+e9+ctG8aOLpp0/1kpXze/ENKP+cB0IUiTQg51vnbRX4Uyx4c4hMI3VVrZvLjq
	kpiYRW0Kuzq00YOJQaPCS5nORTfqphVscfysXSJtScnDU986waoeP/bDVxo7llLcULM13b
	xnJg0kFqbvSL7ocazO5yGkaCMWJIm4d77ZyiYSzvdu5m7IGR3eIzrJkISXIlM5zErgWmaa
	IPb0NM7Y+GA0aB1bR0R38el4WdPQX5qrKQ5LWgoVHv5A+1agvET3gGw5S6aKZA==
From: Brahmajit Das <listout@listout.xyz>
To: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	contact@arnaud-lcm.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf-next v2] bpf: Clamp trace length in __bpf_get_stack to fix OOB write
Date: Tue, 11 Nov 2025 06:07:21 +0530
Message-ID: <20251111003721.7629-1-listout@listout.xyz>
In-Reply-To: <691231dc.a70a0220.22f260.0101.GAE@google.com>
References: <691231dc.a70a0220.22f260.0101.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a stack-out-of-bounds write in __bpf_get_stack()
triggered via bpf_get_stack() when capturing a kernel stack trace.

After the recent refactor that introduced stack_map_calculate_max_depth(),
the code in stack_map_get_build_id_offset() (and related helpers) stopped
clamping the number of trace entries (`trace_nr`) to the number of elements
that fit into the stack map value (`num_elem`).

As a result, if the captured stack contained more frames than the map value
can hold, the subsequent memcpy() would write past the end of the buffer,
triggering a KASAN report like:

    BUG: KASAN: stack-out-of-bounds in __bpf_get_stack+0x...
    Write of size N at addr ... by task syz-executor...

Restore the missing clamp by limiting `trace_nr` to `num_elem` before
computing the copy length. This mirrors the pre-refactor logic and ensures
we never copy more bytes than the destination buffer can hold.

No functional change intended beyond reintroducing the missing bound check.

Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
Changes in v2:
- Use max_depth instead of num_elem logic, this logic is similar to what
we are already using __bpf_get_stackid

Changes in v1:
- RFC patch that restores the number of trace entries by setting
trace_nr to trace_nr or num_elem based on whichever is the smallest.
Link: https://lore.kernel.org/all/20251110211640.963-1-listout@listout.xyz/
---
 kernel/bpf/stackmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 2365541c81dd..f9081de43689 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -480,6 +480,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	trace_nr = trace->nr - skip;
+	trace_nr = min_t(u32, trace_nr, max_depth - skip);
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;
-- 
2.51.2



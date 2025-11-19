Return-Path: <bpf+bounces-75112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C16C715BE
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 23:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id EBBB131914
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 22:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5069F335BDB;
	Wed, 19 Nov 2025 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="mJmOyflN"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4A2C178E;
	Wed, 19 Nov 2025 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592172; cv=none; b=JQZNnMRi8a6TeuxFjFdA+KKPk8t+wHyf60sh0c0MW9NbtU61oNegn8pt4k56u8G3yQ5pTPNEmIhJf7blnvpyxtpkxWii9c2N+cIKGCJ0j+iH8NL/LL75/Re+/gRUvWBC4281Z3SmsCkcP2490GMeOdH2xTcp8MEZPvBqq2poez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592172; c=relaxed/simple;
	bh=WL0PXhXU9WzA14alwt1F7pd1ySSZ0ovhU3GxmPY01xU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZOco4V/Sempa+kwlqbkppoarznoGqURYCbohfEmxP+F9AWpK7kE7vUmU3s7wRSZQI36eezov2ETTht7yT4eBV4iTbQkjePKqRkxBln47VnhZw0l3cZwXF1z5U5obl2fX6jwjLV3eYo7mz6Znnc0d7YjKZSUl8kOlZKZTIdPkXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=mJmOyflN; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsy-006kwn-JE; Wed, 19 Nov 2025 23:42:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=9HRmK+hbwURnGQuKYeIXbIO2jWPVVl5U3dF50i9W/9w=; b=mJmOyflNz4dWxZBUr5CLXi9xsa
	ydk558tWK0Ta32NGSHQdEft+yG/07JG0lWYF5dC4xQcNxG6aE3YSXXBr0B2akA+lbRf3+exZ9ciKf
	T2XY/zj9UphkAnFOCsGUWXe3qY9EDj601OAb6N2B5UZt/PFAySrQ4LdPTcPMZhktu1/N09O+gOJSY
	oqozgGS9mVGOT/tuvbVRH+lec4Fgagb7TKt2yg0fQF2zuiu3hmYTWc6t2oBUjIkekTJJPX4/lH3vD
	eZYBG9IbtLYU8LdvKH71/O3zSAeRDjGEZOKfexDF2XtQ8U4UErCU5XPSpEKSHEfyzDqIQ/DgQPAEZ
	nkfmpJdw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsx-0000DV-W4; Wed, 19 Nov 2025 23:42:48 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsl-00Fos6-8x; Wed, 19 Nov 2025 23:42:35 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 35/44] bpf: use min() instead of min_t()
Date: Wed, 19 Nov 2025 22:41:31 +0000
Message-Id: <20251119224140.8616-36-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
and so cannot discard significant bits.

In this case the 'unsigned long' value is small enough that the result
is ok.

Detected by an extra check added to min_t().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4f87c16d915a..ee3152df767c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1515,7 +1515,7 @@ BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
 	if (!buf || (size % br_entry_size != 0))
 		return -EINVAL;
 
-	to_copy = min_t(u32, br_stack->nr * br_entry_size, size);
+	to_copy = min(br_stack->nr * br_entry_size, size);
 	memcpy(buf, br_stack->entries, to_copy);
 
 	return to_copy;
-- 
2.39.5



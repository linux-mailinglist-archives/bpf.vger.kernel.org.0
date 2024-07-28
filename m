Return-Path: <bpf+bounces-35828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7D493E4E8
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 13:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906B11C21354
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 11:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93449383A2;
	Sun, 28 Jul 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SX85RfXO"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C42C6BB
	for <bpf@vger.kernel.org>; Sun, 28 Jul 2024 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722167233; cv=none; b=nq1/sAVeyUmX8EigrOO/jTh4LztRMIn3Fo8jzj7/93eF8mYrb+bsuJrpllnle+PXgm80L0iwfW+YGdK2SLKEhOJ+ufuyRLifNXkyEsGmN0LouA/kY2sraZ6uvThpj18DA1xINFudJ7MK7fmSbsVKQGSEJP8THnzbHr+V6GHvQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722167233; c=relaxed/simple;
	bh=rdMsLSEspA4h3ulLL37p0ctGTEw0UOIGWz9Kib4a/bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPRwft1oQK+QFQHk8NaEFd7w0kMgm52Ke6S+xwh9h4J4RG0t4WwHfdX2w8tNUxHbja5QooTBV6loRFwtDd56AIkEnTsVEXzVkVAgkS+fAC3lxqWAuYH1a7DzF3U1qOHLisyxHjKifCeFchiOSHP18XAQOklwfv7J4XMU65Ae6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SX85RfXO; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722167229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLC4AKrs0ZqQxBl5WdJtDwjEOAWavsdS4R5r3gEFLgg=;
	b=SX85RfXOSlOGKo+KHstXO/3XK0r78rVlKsVO/FZr5SFmw4YWH4iVLxDs6hhdQncz1sT9Pm
	0e853phwXKsKuZMyEqBSHsD3COGguIWlSBdOVQcUWpPMdiL10ihvWM956Y9/opOV/9mmgI
	e2/bUr+cd5/DEBMfaRd+f6O7b/482XI=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	toke@redhat.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	wutengda@huaweicloud.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 1/2] bpf: Fix updating attached freplace prog to prog_array map
Date: Sun, 28 Jul 2024 19:46:11 +0800
Message-ID: <20240728114612.48486-2-leon.hwang@linux.dev>
In-Reply-To: <20240728114612.48486-1-leon.hwang@linux.dev>
References: <20240728114612.48486-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The commit f7866c358733 ("bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT")
fixed a NULL pointer dereference panic, but didn't fix the issue that
fails to update attached freplace prog to prog_array map.

Since commit 1c123c567fb1 ("bpf: Resolve fext program type when checking map compatibility"),
freplace prog and its target prog are able to tail call each other.

And the commit 3aac1ead5eb6 ("bpf: Move prog->aux->linked_prog and trampoline into bpf_link on attach")
sets prog->aux->dst_prog as NULL after attaching freplace prog to its
target prog.

Then, as for following example:

tailcall_freplace.c:

// SPDX-License-Identifier: GPL-2.0

\#include <linux/bpf.h>
\#include <bpf/bpf_helpers.h>

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

int count = 0;

SEC("freplace")
int entry_freplace(struct __sk_buff *skb)
{
	count++;
	bpf_tail_call_static(skb, &jmp_table, 0);
	return count;
}

char __license[] SEC("license") = "GPL";

tc_bpf2bpf.c:

// SPDX-License-Identifier: GPL-2.0

\#include <linux/bpf.h>
\#include <bpf/bpf_helpers.h>
\#include "bpf_misc.h"

__noinline
int subprog(struct __sk_buff *skb)
{
	int ret = 1;

	__sink(ret);
	return ret;
}

SEC("tc")
int entry_tc(struct __sk_buff *skb)
{
	return subprog(skb);
}

char __license[] SEC("license") = "GPL";

And entry_freplace's target is the entry_tc's subprog.

After loading entry_freplace, the jmp_table's owner type is
BPF_PROG_TYPE_SCHED_CLS.

Next, after attaching entry_freplace to entry_tc's subprog, its prog->aux->
dst_prog is NULL.

Next, while updating entry_freplace to jmp_table, bpf_prog_map_compatible()
returns false because resolve_prog_type() returns BPF_PROG_TYPE_EXT instead
of BPF_PROG_TYPE_SCHED_CLS.

With this patch, resolve_prog_type() returns BPF_PROG_TYPE_SCHED_CLS to
support updating the attached entry_freplace to jmp_table.

Fixes: f7866c358733 ("bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT")
Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf_verifier.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5cea15c81b8a8..bfd093ac333f2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -874,8 +874,8 @@ static inline u32 type_flag(u32 type)
 /* only use after check_attach_btf_id() */
 static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
 {
-	return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->dst_prog) ?
-		prog->aux->dst_prog->type : prog->type;
+	return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->saved_dst_prog_type) ?
+		prog->aux->saved_dst_prog_type : prog->type;
 }
 
 static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
-- 
2.44.0



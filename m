Return-Path: <bpf+bounces-74334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B278EC54B51
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 23:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B423A77A7
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 22:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E62526CE04;
	Wed, 12 Nov 2025 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="scZ7fIIA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F70335CBB2;
	Wed, 12 Nov 2025 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762986134; cv=none; b=dk3WF3HmGw/871SKYyYS3QXMAUS6sHfLQIJgrDpIs0us7eaj8NVj0r05mk9aSTJAi9m0wym6h0lcxy8AmeRPA5jFDkJRrgtwA23SjAks28Ey9YkAl+LMeG6nlnkzGKxJi32g3S+FjD+tFV+/14SBedsSfAKyEbB55EWiy5Yrw/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762986134; c=relaxed/simple;
	bh=Xnq1zlhUzQlq4w7pNhD9+285Oip5KNSnZLZFH1CTK7A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Exs3JmWVEHsgtdahoJHTkY+HW/0ToqIhIxty2vepBJqQTWMyfp2MBV3sw2laUH5nagGj7DvLwHJxSmFVjv6aA3PDlR9e6huaj3P1vr3iKNyQiK6VoxVTkdOt+i3uBk0P4BjJqV2KtmtmLvwp+fvPHF3FYB810dBxiGf7eMDz3O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=scZ7fIIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D1FC4CEF1;
	Wed, 12 Nov 2025 22:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762986134;
	bh=Xnq1zlhUzQlq4w7pNhD9+285Oip5KNSnZLZFH1CTK7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=scZ7fIIAjmpG3n3F9Q5lLUk8HbQXHeXjOTMhm7EB1qihhQhQZ2psy2l53qUs1yeeC
	 HmsQQGjCw9+09migWcXEzPLTShaS2/ATeGIkPJFwZSUpg6VbeZhvlYhb9lD0wbSDE7
	 G5c1uJGoMLmLbPNsWkAs5qP8EX7OvZJ5nxzjk9rQ=
Date: Wed, 12 Nov 2025 14:22:13 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 0/4] make vmalloc gfp flags usage more apparent
Message-Id: <20251112142213.bc01a3abe37de98f9d40e392@linux-foundation.org>
In-Reply-To: <20251112185834.32487-1-vishal.moola@gmail.com>
References: <20251112185834.32487-1-vishal.moola@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 10:58:29 -0800 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:

> v2:
>   - Add __GFP_HARDWALL[3] for bpf and drm users.
>   - cc BPF mailing list

v1->v2 diff:

--- a/mm/vmalloc.c~b
+++ a/mm/vmalloc.c
@@ -3922,10 +3922,12 @@ fail:
 /*
  * See __vmalloc_node_range() for a clear list of supported vmalloc flags.
  * This gfp lists all flags currently passed through vmalloc. Currently,
- * __GFP_ZERO is used by BFP and __GFP_NORETRY is used by percpu.
+ * __GFP_ZERO is used by BPF and __GFP_NORETRY is used by percpu. Both drm
+ * and BPF also use GFP_USER, which is GFP_KERNEL | __GFP_HARDWALL.
  */
 #define GFP_VMALLOC_SUPPORTED (GFP_KERNEL | GFP_ATOMIC | GFP_NOWAIT |\
-				__GFP_NOFAIL |  __GFP_ZERO | __GFP_NORETRY)
+				__GFP_NOFAIL |  __GFP_ZERO | __GFP_NORETRY |\
+				__GFP_HARDWALL)
 
 static gfp_t vmalloc_fix_flags(gfp_t flags)
 {
_



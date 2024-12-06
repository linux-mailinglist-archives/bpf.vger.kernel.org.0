Return-Path: <bpf+bounces-46313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690A19E7822
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49EE11678D3
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862331D54F2;
	Fri,  6 Dec 2024 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8lx7xbP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BF3198837;
	Fri,  6 Dec 2024 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510082; cv=none; b=dGhuvK6PHai6dhsYdl2qRkwn7Dg4cuLaDe9k4cwiqRZNE2pEbBH8vwzh4hOGrrVB9qtSUbxLT3gKqZc2FIy2///dEVgOE04K7YX5IgJ5K0o+bKQI6Z7NsWTXAyZ5WchnNqXpUYcArSF+HHlsEmSXqEAgr7l2E4V7p8K589KZxoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510082; c=relaxed/simple;
	bh=RdAsnLVIig3dm1jYfbZcIv11UEGNzQia7i4gxWQKQfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldE4CW2zmculxenlofLrCAc4SpoOgIBYHgfazIRASPJi8F9uNcjTQPwSTeEw2snzqoqmV7LJqZ6+9itRI/Bb8HGaCJKyo/4f6eivc0qUToGv8HdtrPe4CfNiqZEsYVmI33sA0YxDJWYdgrE8QR5/wXDXjRDde8fJW21XHdYyKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8lx7xbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60500C4CED1;
	Fri,  6 Dec 2024 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733510081;
	bh=RdAsnLVIig3dm1jYfbZcIv11UEGNzQia7i4gxWQKQfU=;
	h=From:To:Cc:Subject:Date:From;
	b=J8lx7xbPeATj2Sp7CbgiJscBm5nDmqv+ag494JFHmOKsNVPGbb0IhzD9M7ZMhzS6i
	 sZfJBLz9ekLA4+F1iuoQbWrNBuVaJbUAl/8E9GmzIvmijImseDoRORJ55QaT3NEFwE
	 keXTQ8mDJHeDSvmUPGsUcn2k8we7G/JEyacEIi4cwlBBsNdJD8jil7HFf0Drpoz9c2
	 8bdAtmlphb56m5jILlnfdBwPUbQboGwo5wT6caI4MtaQdsvpAQVYAF3YBwJ9iQIhAh
	 uLT1v4p20pGw3xdcI8+b4vO9o4S0I6Sixr/CLKop4FCYqMMGBJP/uz4cUJXN3QBKDr
	 0VuCjgJlkzPFw==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Cc: oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	liaochang1@huawei.com,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH perf/core] uprobes: guard against kmemdup() failing in dup_return_instance()
Date: Fri,  6 Dec 2024 10:34:36 -0800
Message-ID: <20241206183436.968068-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kmemdup() failed to alloc memory, don't proceed with extra_consumers
copy.

Fixes: e62f2d492728 ("uprobes: Simplify session consumer tracking")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 1af950208c2b..1f75a2f91206 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2048,6 +2048,8 @@ static struct return_instance *dup_return_instance(struct return_instance *old)
 	struct return_instance *ri;
 
 	ri = kmemdup(old, sizeof(*ri), GFP_KERNEL);
+	if (!ri)
+		return NULL;
 
 	if (unlikely(old->cons_cnt > 1)) {
 		ri->extra_consumers = kmemdup(old->extra_consumers,
-- 
2.43.5



Return-Path: <bpf+bounces-72407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B35A0C1205C
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 00:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A43074FD2C1
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933813385B1;
	Mon, 27 Oct 2025 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lkPPVpm+"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBBC32D45C
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607394; cv=none; b=N5ZY1ycaDKctok6+HepNPX311OFDZYFe5Se9wUQ12jYMqQpqZWX7VitsJLmwmpv0ATwCIJZtJx8N4XF5YxfdshUNlJqWzq+9ZrTk0XthNt2lelFJVyGDIaya7y4c64fc8Hq/2l/+uw+jdsYQY0vtWO4ejYiJmb3XdFvbxDr3iak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607394; c=relaxed/simple;
	bh=wOCFX8r5G02Dfku/wnLFGKp0E+hC+ktd0o6Cyu/UNEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKLtNpAGULph4Ll4fzgfIHV+egcNAiRI96odevyCnJtzMLJhzbvA2CT9ZQ9HNUoYKFfXzI4tyFTjWdg37u6pr9iRYGv42SlgWkE2TRRjJFDcbz+eyt6TkYnhtLyJN8faWBLL4DBgK7gFEo+Q7VP/WSzAOA/ItBRqD346RIi68NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lkPPVpm+; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2kGxV06HfpxcpPiUPTzmwiOkPAgJASkvhN4/4SyEC0=;
	b=lkPPVpm+fnPC+unyLNVdYESh1AWhGBETU6J5rz5lYfNm22BM8j6bPfNZmg02w4elxICR0n
	S7H1oC2dJuR60zhzC0B9AEfHrBwhnVD0n10MQRTRVy7hXbK3vwU8LhRtK3YjmIdbu9Udvc
	NT6/mKoIvYG4SIBTftkywZcMHKcY83Q=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 22/23] bpf: selftests: add config for psi
Date: Mon, 27 Oct 2025 16:22:05 -0700
Message-ID: <20251027232206.473085-12-roman.gushchin@linux.dev>
In-Reply-To: <20251027232206.473085-1-roman.gushchin@linux.dev>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: JP Kobryn <inwardvessel@gmail.com>

Include CONFIG_PSI to allow dependent tests to build.

Suggested-by: Song Liu <song@kernel.org>
Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 70b28c1e653e..178c840c844b 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -110,6 +110,7 @@ CONFIG_IP6_NF_IPTABLES=y
 CONFIG_IP6_NF_FILTER=y
 CONFIG_NF_NAT=y
 CONFIG_PACKET=y
+CONFIG_PSI=y
 CONFIG_RC_CORE=y
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
-- 
2.51.0



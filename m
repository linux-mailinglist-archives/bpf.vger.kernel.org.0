Return-Path: <bpf+bounces-40301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10563985C16
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 14:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BC4BB28B79
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9BE1CC151;
	Wed, 25 Sep 2024 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyXYLrSC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC621CBEB9;
	Wed, 25 Sep 2024 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265213; cv=none; b=nd/Koof7l0c+ciOAsI71qeYMVbHP6w9Q8lHqtotD8k1/bN4feVDRTn7WW0RCSsaSkOkIc6SN5TSRdWfnruumHc/kyle5WSGvjV3VeWnzH4jZrGh2Ev7StNf73EMUIGPg00v1iz6mRiVuIFzcoWAbaunnjsQv0/pNy6kDS0xdt+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265213; c=relaxed/simple;
	bh=PXYsEtrSdXpaRURxZQhAtlJjznCOG6BAByR7SGjYabo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCiWzM82qduy6aq7itCBTOmupvjZnb9vladgBhJgDil5Bb2imQ8U0gm7xirje+8UTLg3BWdUiK/wn52bjhyPuBVTxjuzuZxXDtiauOj4u+OFMLb6xFULn7BbaHTByOmO8S1pOxJuFp5LzLYCWBQhw2vngXfq4K2tQ7mMWBsH6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyXYLrSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5876C4CEC7;
	Wed, 25 Sep 2024 11:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265212;
	bh=PXYsEtrSdXpaRURxZQhAtlJjznCOG6BAByR7SGjYabo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XyXYLrSC/4i8Xwb93Pv/Qb5F3She+4quoJZjqyKT4zT+w9/FoFchFAiSKDidV+Fj7
	 XYB26Aeo3SmkzL8DK+UmxbgVKOhXN0re7J3uQMKk1m8OXrNsUB7qnya4Mi1LTepx/S
	 nKM/f7VAAZ0Brs7zUiHIBEjmdWfRe0P6N9nsH+cZo/aA9bLlt0M26egn9vNVXbQ1vj
	 9MWbhvyFkXYVUGTQq0JxomL23sv0wSEhYyX+nR1B6ctZhCPEvcxOH59lGZCjDE5Yul
	 gtJSvdlMcB4Z3DFdlW8RoT+16kd9KHarRfz1A/QryjvXoJQUVbGT7LIfSDkN61WMzj
	 TimP31ATn5JOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 243/244] bpftool: Fix undefined behavior in qsort(NULL, 0, ...)
Date: Wed, 25 Sep 2024 07:27:44 -0400
Message-ID: <20240925113641.1297102-243-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit f04e2ad394e2755d0bb2d858ecb5598718bf00d5 ]

When netfilter has no entry to display, qsort is called with
qsort(NULL, 0, ...). This results in undefined behavior, as UBSan
reports:

net.c:827:2: runtime error: null pointer passed as argument 1, which is declared to never be null

Although the C standard does not explicitly state whether calling qsort
with a NULL pointer when the size is 0 constitutes undefined behavior,
Section 7.1.4 of the C standard (Use of library functions) mentions:

"Each of the following statements applies unless explicitly stated
otherwise in the detailed descriptions that follow: If an argument to a
function has an invalid value (such as a value outside the domain of
the function, or a pointer outside the address space of the program, or
a null pointer, or a pointer to non-modifiable storage when the
corresponding parameter is not const-qualified) or a type (after
promotion) not expected by a function with variable number of
arguments, the behavior is undefined."

To avoid this, add an early return when nf_link_info is NULL to prevent
calling qsort with a NULL pointer.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
Link: https://lore.kernel.org/bpf/20240910150207.3179306-1-visitorckw@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index ad2ea6cf2db11..0f2106218e1f0 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -824,6 +824,9 @@ static void show_link_netfilter(void)
 		nf_link_count++;
 	}
 
+	if (!nf_link_info)
+		return;
+
 	qsort(nf_link_info, nf_link_count, sizeof(*nf_link_info), netfilter_link_compar);
 
 	for (id = 0; id < nf_link_count; id++) {
-- 
2.43.0



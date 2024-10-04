Return-Path: <bpf+bounces-40979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F268990AEC
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120FD1F2138C
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 18:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9501E32A0;
	Fri,  4 Oct 2024 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhpcrzUH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4F21E284A;
	Fri,  4 Oct 2024 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065918; cv=none; b=aGi5vUjpQwjgrYQn7SC6jImE+O9levynBb79S9jIo3kmo6hRPhRW2ZfF+06kRtY3rgIL9sbWJ60tigvmrsZpGIP2AQqX5hLjEC/gsb3enya9oofY28m5qSltzkKzpm041Cc6zxXG51jZRrbkjlGzQrAHvtTwGU/jgcOidPf5rY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065918; c=relaxed/simple;
	bh=2my7iZVJrU4CA6w35Blro+3kSQHI5GlKSS8Rl/NZ5/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0N6GKOX4x3EP9cqKHvVc42Hy27xV+qTX9c9M5lT3uIUC0xDHAhjgBa9xivKRXQppNfK60Va4Q7zPzpIG+UknT0eq7yiF6dMXmMUSl5UWew0kicGzKwuii2bl1BhP7xt/UHdhowU+17uBV3tOssbjuXWeif0v7cSz3eFywk+l24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhpcrzUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475D8C4CECD;
	Fri,  4 Oct 2024 18:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065918;
	bh=2my7iZVJrU4CA6w35Blro+3kSQHI5GlKSS8Rl/NZ5/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DhpcrzUHnbBOoS87hlywje7n9dTNz0ZNgDIoJ6n6G1qhetCN/Gj7gFbAZNzHpgiTd
	 LK+Hg/vxo4OoKBy9Gwqd5b1EZGRTQpU5yB7aQyUyCVDM+HOU4sHfaKXJuy6qpK39T5
	 j5ccNAnC3TvWlQpifnBI4dda1TASOdLQW1Wlq0md/R+ITdwF0FIWEQ6YFfqyRo/w6E
	 jkftCbYTEn7Q5iVBDHT9lZNm/bWf7MxOZdp2JrkehJXg7L6UDKppte+CD7MZ3hy/7U
	 Hp0BV42atxfiy37RfPN1kvNXLqtzibfEgitMcr8CBrfY0b0qL87Wm4tTw5zR3gtsRM
	 wLHLTs1yIDu1g==
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
Subject: [PATCH AUTOSEL 6.11 05/76] bpftool: Fix undefined behavior in qsort(NULL, 0, ...)
Date: Fri,  4 Oct 2024 14:16:22 -0400
Message-ID: <20241004181828.3669209-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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
index 968714b4c3d45..0ad684e810f34 100644
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



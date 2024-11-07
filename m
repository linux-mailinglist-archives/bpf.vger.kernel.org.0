Return-Path: <bpf+bounces-44220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 019BF9C0159
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 10:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75801F2263D
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE691E2301;
	Thu,  7 Nov 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NG0+rY7x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA6519CC36;
	Thu,  7 Nov 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972624; cv=none; b=C9TBCSyOL+Umme3CelKAREV8unzqOKuu+moNJyjFmx4sEMie8hR5XoI5EXyMyFkGk7KJI2sRsiNBRIC5ZZflV7c2AvgHHv0HogIyDrC10tIWpKOBzTEqVj5B4b2w6fpstX07auJScqomIlHoF+cVc4xC0KabW+7WSfZc8+4lYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972624; c=relaxed/simple;
	bh=ngreB8o5d/lKyYDTQKG+r6Xb9D1nYwPflrpF7bGapdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CfRVXLQW4+1yoY4WPRkT8GeD3QizdAW8f435ShPN+iLQ4a6PPcKyEVZUqcqeqXbt2p3A98xH9JEnuhkM3Hoj03VI/MTuf5DTTI2ceOLz9xdC9K8n5EMEM0JWS7dPcz0OnYYHEuP6G395Ed/ljxrKMElwoImH1x3E/PxVYycjnl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NG0+rY7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F5EC4CECC;
	Thu,  7 Nov 2024 09:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730972624;
	bh=ngreB8o5d/lKyYDTQKG+r6Xb9D1nYwPflrpF7bGapdA=;
	h=From:To:Cc:Subject:Date:From;
	b=NG0+rY7xw4JJysKl3zjYy7UVaamzDTHTHQISPxsnsN4FA6Vnbn9Cep9xXStYY1XYa
	 aL91euuPNHmNrOIfYl6zEhvM/FoXR8hvj0AZyOAQ8vSag2AoQ9OfUSM6zClhVAZ0gz
	 A6UOx4gn97cjHso1HwhRc3EwqFIDq+ge49Ws0w0QZuKE9rrmVxA3DZzomNflKT8Y9+
	 0B/zVIO1EAzdBO8jCJdvXSWMu6n24v2Zt1cpjYwPjZ/2/pcqEH++MWXcIAthq6ZlPz
	 hyFx5h1jzHOIrD6g17qw3c3kY0l985KB2yfIFpC9+r42VOLlWNaUL3uyt18T+ErR1P
	 uKjsW9FDvTfeQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Young <sean@mess.org>
Subject: [PATCHv2 bpf-next] selftests/bpf: Fix uprobe consumer test (again)
Date: Thu,  7 Nov 2024 10:43:37 +0100
Message-ID: <20241107094337.3848210-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new uprobe changes bring bit some new behaviour that we need
to reflect in the consumer test.

The idea being that uretprobe under test either stayed from before to
after (uret_stays + test_bit) or uretprobe instance survived and we
have uretprobe active in after (uret_survives + test_bit).

uret_survives just states that uretprobe survives if there are *any*
uretprobes both before and after (overlapping or not, doesn't matter)
and uprobe was attached before.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_multi_test.c   | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 619b31cd24a1..616441fdd7f2 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -869,15 +869,17 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 			fmt = "prog 0/1: uprobe";
 		} else {
 			/*
-			 * to trigger uretprobe consumer, the uretprobe needs to be installed,
-			 * which means one of the 'return' uprobes was alive when probe was hit:
-			 *
-			 *   idxs: 2/3 uprobe return in 'installed' mask
+			 * To trigger uretprobe consumer, the uretprobe under test either stayed from
+			 * before to after (uret_stays + test_bit) or uretprobe instance survived and
+			 * we have uretprobe active in after (uret_survives + test_bit)
 			 */
-			unsigned long had_uretprobes  = before & 0b1100; /* is uretprobe installed */
 
-			if (had_uretprobes && test_bit(idx, after))
+			bool uret_stays = before & after & 0b1100;
+			bool uret_survives = (before & 0b1100) && (after & 0b1100) && (before & 0b0011);
+
+			if ((uret_stays || uret_survives) && test_bit(idx, after))
 				val++;
+
 			fmt = "idx 2/3: uretprobe";
 		}
 
-- 
2.47.0



Return-Path: <bpf+bounces-44179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE279BF965
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 23:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8031C21327
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 22:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BC720CCFA;
	Wed,  6 Nov 2024 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le2zWAkj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCA520C493;
	Wed,  6 Nov 2024 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730932832; cv=none; b=pCrDf/CFGRZaszVKWXfzhYrQUN6DNVh9q+Ar4Wy2dDUVNcZOPP0pGEQ1fvd38C+DBnB0wVRp0gwpknaPa/4abiJB+pHulU6w6W//v87oY3S+0ezV+IjKsA9Ml3P1BO2OJZCFxeJI+sTaI9mn9MPtHLoZJAKUaP3P6zfcHqoGZrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730932832; c=relaxed/simple;
	bh=21udNx/M9w2pruaMuHrnxKYz6D3+pTy5p84fVG7+hnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SEUBTBM43VMJh4Z4XNDfd1lKYEP7e/HrLBIqQSSt7Eur5XZEcq5CzBucFhCzCx5o43HezeF64MUIB78TrNlS6af5E3zfRDP6RiTJ96rOFQ1nprJiViueZj83wbNJfPBfss0TCShwI/kqJvt/4IP7c/Rfbav7XuVg3sY6lHO49kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le2zWAkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDC2C4CEC6;
	Wed,  6 Nov 2024 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730932831;
	bh=21udNx/M9w2pruaMuHrnxKYz6D3+pTy5p84fVG7+hnM=;
	h=From:To:Cc:Subject:Date:From;
	b=Le2zWAkjwnxSTNlxELNE/S2Y/fVIwErr/27yl0lCNLwFTmASaqps25CfthIFNF7hq
	 3IMisaq3EevONAa7lBAnBPU+NQGsoXob1vlTAGgIoFygZM0PxFMOU+guOlNEuYXknG
	 TzFVq7EMpnKOa5TW+lAAMCSnMkQX4Hdw/3VniUK5JfYPkRztj6Wykj01DarhnaBOn4
	 K6S9OexJMKisKX8yBFCsqdCyqwsXbJQ9cVFTrU0C92BwBFnsWo8wqw0Rp7aZ9Z5H2i
	 tyNf9H/1qdmdyhZeLmhUpH8Qkvz97nA0vnkz+XeZg8yJ/8DZ3e4EmJALIu8Mpe22cV
	 JN05jyJym6M6A==
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
Subject: [PATCH bpf-next] selftests/bpf: Fix uprobe consumer test (again)
Date: Wed,  6 Nov 2024 23:40:25 +0100
Message-ID: <20241106224025.3708580-1-jolsa@kernel.org>
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

There's special case when we have one of the existing uretprobes removed
and at the same time we're adding the other uretprobe. In this case we get
hit on the new uretprobe consumer only if there was already another uprobe
existing so the uprobe object stayed valid for uprobe return instance.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_multi_test.c    | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 619b31cd24a1..545b91385749 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -873,10 +873,21 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 			 * which means one of the 'return' uprobes was alive when probe was hit:
 			 *
 			 *   idxs: 2/3 uprobe return in 'installed' mask
+			 *
+			 * There's special case when we have one of the existing uretprobes removed
+			 * and at the same time we're adding the other uretprobe. In this case we get
+			 * hit on the new uretprobe consumer only if there was already another uprobe
+			 * existing so the uprobe object stayed valid for uprobe return instance.
 			 */
 			unsigned long had_uretprobes  = before & 0b1100; /* is uretprobe installed */
+			unsigned long b = before >> 2, a = after >> 2;
+			bool hit = true;
+
+			/* Match for following a/b cases: 01/10 10/01 */
+			if ((a ^ b) == 0b11)
+				hit = before & 0b11;
 
-			if (had_uretprobes && test_bit(idx, after))
+			if (hit && had_uretprobes && test_bit(idx, after))
 				val++;
 			fmt = "idx 2/3: uretprobe";
 		}
-- 
2.47.0



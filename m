Return-Path: <bpf+bounces-13940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D951A7DF039
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 11:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153701C20E97
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 10:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC30613A;
	Thu,  2 Nov 2023 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp/SNoSV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A06614A9D;
	Thu,  2 Nov 2023 10:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3ABAC433C9;
	Thu,  2 Nov 2023 10:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698921343;
	bh=1nnK+BgW97TZtPhAGFwIN2pVL9Lwel3zDlxOeK1GZE0=;
	h=From:To:Cc:Subject:Date:From;
	b=hp/SNoSVOXUm2gBmEt7NCjTtCofg8ToWbsBifF9Kd3r4tUtWuioL9hwqtS+CbRTM5
	 +44EtvxUoltEK16bErmJlLfv13KoegLIHu+lWMDkJ05A1Z6Mplzq2NQR4UT28EmkuJ
	 3MN01IJD4ycpIjkpqCnSteIwuhTNqZRYX3zkWFu2xIXocS9tou+zuQi6NhDqUBujgM
	 vebm2NL3NQbQJHibw5K1q8LchYPPPfc7KHfsBd98HyiU2YPYViZozcW3OR0nZilgu7
	 rXFs7ypd5omEGDhwVRfZkmXb8+llmhTOMLF/3CaanKJUmmk7P9voV0An2U9BjbsVk2
	 05su5Veo2NFGg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Larysa Zaremba <larysa.zaremba@intel.com>
Subject: [PATCH bpf] selftests/bpf: Fix broken build where char is unsigned
Date: Thu,  2 Nov 2023 11:35:37 +0100
Message-Id: <20231102103537.247336-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

There are architectures where char is not signed. If so, the following
error is triggered:

  | xdp_hw_metadata.c:435:42: error: result of comparison of constant -1 \
  |   with expression of type 'char' is always true \
  |   [-Werror,-Wtautological-constant-out-of-range-compare]
  |   435 |         while ((opt = getopt(argc, argv, "mh")) != -1) {
  |       |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~~
  | 1 error generated.

Correct by changing the char to int.

Fixes: bb6a88885fde ("selftests/bpf: Add options and frags to xdp_hw_metadata")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 17c0f92ff160..c3ba40d0b9de 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -430,7 +430,7 @@ static void print_usage(void)
 
 static void read_args(int argc, char *argv[])
 {
-	char opt;
+	int opt;
 
 	while ((opt = getopt(argc, argv, "mh")) != -1) {
 		switch (opt) {

base-commit: cb3c6a58be50c65014296aa3455cae0fa1e82eac
-- 
2.40.1



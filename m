Return-Path: <bpf+bounces-43914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E0C9BBC6E
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3C71F23238
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B831CACC0;
	Mon,  4 Nov 2024 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCT/aAQQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFECE1CF96;
	Mon,  4 Nov 2024 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742797; cv=none; b=KoTk8IpuJNx1FTnxTv0iGzwixiqd/zQaXEDe149AmrXqPEqYUB04rgfFAf9/midwBuwvuI1MIUA+yXmVl/C1eUK8lkDTuEJ8Q4OS/VuW0G0bisjNhyO01n8TrvxEBhMifEiDfqxStOLS4ffdPq2v4lK4Rqd3AEvPiWcFAlKHAEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742797; c=relaxed/simple;
	bh=ZDiG8zX1fgcovcm8UjN+AmQPvesoI2ZbNOk88XOFpJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9DAZGvwyV16Sqrlp9Lxv06fDti79rHpzRNRn5oOJG9GU868eu2kqJz79itLH3BfyMhLRVB9egq2NhWF8P0fNNvnGQvnuZPte5YC2x9X7xD+IpbcnMW+9J6b/SCRmrk3RjlmQ1kHxfEoTV6SHWf8mPUJFlnU4lTp8iaBr7Vqr90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCT/aAQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422B7C4CECE;
	Mon,  4 Nov 2024 17:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730742797;
	bh=ZDiG8zX1fgcovcm8UjN+AmQPvesoI2ZbNOk88XOFpJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GCT/aAQQEmOiE2CO2EdcO0mROEbV/PfAf5s5dFqoJrvi8TiRxqzEg5keAyPOWOFk1
	 Uys/qnVri2Ogrf8M8+SC4ewpKvGR2yUpM/bijT4NVgYRqY5U6iP8y+JoY9zq89DIhJ
	 nQTfVzz/LUQyI+5+BXl0on2TvUx8+cKWMRufZx+WEqPhP8miRBpf16hoHi98eaMRZq
	 fHkKMin7SPACRskgM094/CkCiRzbpEIAZtj39hN0En/kIwGT8dqbT6O4i0pJ1kQP1p
	 0Z1FS0XLCI7+ahD6hGtDPHvS0sfVvC6JRbMWHZJ7tYisZ57b/QHe3aB+mHmn8h2kRu
	 VUkjaRDhftlMQ==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH stable 6.1 ] lib/buildid: Fix build ID parsing logic
Date: Mon,  4 Nov 2024 18:52:54 +0100
Message-ID: <20241104175256.2327164-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104175256.2327164-1-jolsa@kernel.org>
References: <20241104175256.2327164-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parse_build_id_buf does not account Elf32_Nhdr header size
when getting the build id data pointer and returns wrong build
id data as result.

This is problem only for stable trees that merged 84887f4c1c3a
fix, the upstream build id code was refactored and returns proper
build id.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Fixes: 84887f4c1c3a ("lib/buildid: harden build ID parsing logic")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 lib/buildid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index e41fb0ee405f..cc5da016b235 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -40,7 +40,7 @@ static int parse_build_id_buf(unsigned char *build_id,
 		    name_sz == note_name_sz &&
 		    memcmp(nhdr + 1, note_name, note_name_sz) == 0 &&
 		    desc_sz > 0 && desc_sz <= BUILD_ID_SIZE_MAX) {
-			data = note_start + note_off + ALIGN(note_name_sz, 4);
+			data = note_start + note_off + sizeof(Elf32_Nhdr) + ALIGN(note_name_sz, 4);
 			memcpy(build_id, data, desc_sz);
 			memset(build_id + desc_sz, 0, BUILD_ID_SIZE_MAX - desc_sz);
 			if (size)
-- 
2.47.0



Return-Path: <bpf+bounces-43915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A0B9BBC70
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9D81F232DF
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE861C9B68;
	Mon,  4 Nov 2024 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUmky7hq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C9D179958;
	Mon,  4 Nov 2024 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742807; cv=none; b=SGwbQXP5IXbt9yws60mUPQQc8REjvwklvewfrcElYpW71ebtprA60819g796CK8LR/QOOWHnpCeN8XbefvAzZcoAp0HEkjTcv0LBrrkxURbxgXbp76wkcUIXo8FRGSTULuXithalnLdrWl3PJqA4XqjVFlWbr7gjCr4ROnhW/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742807; c=relaxed/simple;
	bh=USMl+gyvVfXOJl57dIb2qfB12CdfO/ipuXx2tt1LWDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkMjA3euBDx26m2Q5tbRd34Dbw/qytbHubf52y0/D2CLcQmjV0Hqn0KBC6HF4+/WY4HK0iTh+ubzwfKWvFFGqGj0QdHxx54X090jZxWDO0g5cKxnPNltaMTf710XvtC9vQpSaNSacL8QyAoXQ86e3ntqhP8MNrYfSpXd/utS9hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUmky7hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC9BC4CECE;
	Mon,  4 Nov 2024 17:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730742806;
	bh=USMl+gyvVfXOJl57dIb2qfB12CdfO/ipuXx2tt1LWDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LUmky7hqMhbZXJMKqFLlBDY/gwo6eEbH2UspG/00nI+3/nAHyWZsIMg1E4cOHhlW5
	 apt4s5Zz3UVecr47q5NQxdiLYHDgx2xtWchz7MyFn2C9ZksH2hdnx9U/mRmFb/kyun
	 HAAtNjzrYR0ebgAgV8XrlQUnrEJOd9LGVOykPa6TxRSh7XiGeMu5Ac1EXIBh2eOmhh
	 LpLHgtInRgBqKS2tiGVWD2Ts1/VmQDqYSkpFbbpRipKDx4IQti2zCT1J4PPNeroDAw
	 Ox04FN5ZHxayLuUPPUv/EQ8jF4vUktsuRXDaDUCdw9dhKkOhN2VCHuIvmTnFZHZZpU
	 JsYbRYbVEZwSg==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH stable 6.6 ] lib/buildid: Fix build ID parsing logic
Date: Mon,  4 Nov 2024 18:52:55 +0100
Message-ID: <20241104175256.2327164-4-jolsa@kernel.org>
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

This is problem only for stable trees that merged c83a80d8b84f
fix, the upstream build id code was refactored and returns proper
build id.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Fixes: c83a80d8b84f ("lib/buildid: harden build ID parsing logic")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 lib/buildid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index d3bc3d0528d5..9fc46366597e 100644
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



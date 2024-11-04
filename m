Return-Path: <bpf+bounces-43917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DCE9BBC74
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BE81C21462
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BB21CACDC;
	Mon,  4 Nov 2024 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTaMl1BE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D81C9ED1;
	Mon,  4 Nov 2024 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742815; cv=none; b=j43R6IndmT8qUJA1ultuWND/ZK0VrQ/Xm0pez6uPqi0Y3ETMBg9psdGMcAJ4BHo+EKI5iTenNvjbbcTK+l+7G4L+MntsrR7bs9rvMLXGKr1qZwYLloG8thvK9D8PccizdzpvtTkcv75SBnrpHjyQqFBmJYbd6zAz57ioMpv+jWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742815; c=relaxed/simple;
	bh=mw2rwn+q9uVitr1d19uhuql+QGixsSd1sWtFZO10diA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4itwXVL2mPA497zWPU9O35UVBW2Ced57+LkbPs/Cz0W54bvk1bvge8/wSc1kx8aPLcOfwxfgIEFjzr3kNdcNY0B06n631DkZWKrZ9ZC+khUiJo3oqxUN5mVU28BKR37deLN2+dlLrK2dj0WKRrU7lRLi0ItoTgPZI6PmWzxCNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTaMl1BE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E560C4CED1;
	Mon,  4 Nov 2024 17:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730742814;
	bh=mw2rwn+q9uVitr1d19uhuql+QGixsSd1sWtFZO10diA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sTaMl1BEX5DNIgIRuweImV+fd+oxS2EZR/kuMtfMEdpyszA1mGHYUV9Lmu5u5ORUG
	 g36kTbX1Sndk1TRN5vYDj1Ti6gXL66wTQljbWoaWdFtsJcTHHI3mILDp+wdkr0wTBj
	 nsW+ObUaI4Dja6sGNSZA4X+khq+xRpCvFtFdhDOoQbYrZFtg39068Gi0Di1yV+NX4y
	 mfvR8BCjOgOe2lhkWhaWW8Jjga/q17AAkofvBFNGgyzAXdtDN7y0ORYPJJyHaBSqZu
	 6gdSU5At5Jlhokvc3xy/znE2pzYMxJGwCgFPqB0FYigj+1dypyUX4zahBc2qZ4p3+V
	 tm8pdsK2+PXDg==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH stable 6.11] lib/buildid: Fix build ID parsing logic
Date: Mon,  4 Nov 2024 18:52:56 +0100
Message-ID: <20241104175256.2327164-5-jolsa@kernel.org>
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

This is problem only for stable trees that merged 768d731b8a0d
fix, the upstream build id code was refactored and returns proper
build id.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Fixes: 768d731b8a0d ("lib/buildid: harden build ID parsing logic")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 lib/buildid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 26007cc99a38..aee749f2647d 100644
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



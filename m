Return-Path: <bpf+bounces-77699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB7BCEF217
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 19:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09A66302BBBA
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 18:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3D92FF169;
	Fri,  2 Jan 2026 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD6fq8mA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646E82FE07D
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376878; cv=none; b=IZmSuRtawr2TzOAOjKa0AvurKAWF5pPr/6tm4ONqfFPE6u1AiFw0XtObFmGy+BeD5PGyYVxUgsuSzXq3E2LXm7tW0OkmfT+I1v+mqVNssxXR/O9XMETRMiazJM2Parhxsr+q/x6ryqYSSxKbo3QlI2LaSkkXFscfBXBqn2AO2MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376878; c=relaxed/simple;
	bh=89tz0U5H89bPp4dnyA7VSVa8i1GhwhryOvKNrhvp/3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgArDJq7qnyZHW/eTudX+9c5AmZwaGFWsTRixYSgpxlU6qndvRGu70yDFu161ijKAmmlgkNr4hjqwRlSuhaMOj+XzUPVYfkEXA4JF6AonjPJZlcCuz32n0nlLFbvRGxUwtMVhkI8JB0WyAT7QQpkWAbaM3EvBEzKiL9EsiTdvKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eD6fq8mA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B7FC19423;
	Fri,  2 Jan 2026 18:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767376877;
	bh=89tz0U5H89bPp4dnyA7VSVa8i1GhwhryOvKNrhvp/3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eD6fq8mAM2Rbkl3yhe3bDJ6bPE/SH34SifTXNehE7UaSEGsnU5t7VFGsIRXUnn218
	 r2d020uy7RBX7G65WM+8OI5iVLZ+1ijLDpUcIpwwCkVILKBp6j19Yw4eNjYt1snh9U
	 K92cwZh/zfuzVpK6m3HYu66rmu0ZQ3dM2LDguIoaZGT0wJa8hdV4aMaypMHQQgDHGE
	 Q0CUZc3ngMKzRvcaL/IsBUwAHcSU4eNIfSMlncUZ9jcWk+jHiC77F6UbCTCnIX5/Y3
	 pKrFqUgoQnVzN0kx5CxagOaKbzei4cv/oa9Y/qsigqtR3rNY3IQiNhwIwVXt64M1rn
	 IFAaUcMPuK62A==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"Emil Tsalapatis" <emil@etsalapatis.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 06/10] selftests: bpf: Update kfunc_param_nullable test for new error message
Date: Fri,  2 Jan 2026 10:00:32 -0800
Message-ID: <20260102180038.2708325-7-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102180038.2708325-1-puranjay@kernel.org>
References: <20260102180038.2708325-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With trusted args now being the default, the NULL pointer check runs
before type-specific validation. Update test3 to expect the new error
message "Possibly NULL pointer passed to trusted arg0" instead of the
old dynptr-specific error message.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c b/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
index 0ad1bf1ede8d..967081bbcfe1 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
@@ -29,7 +29,7 @@ int kfunc_dynptr_nullable_test2(struct __sk_buff *skb)
 }
 
 SEC("tc")
-__failure __msg("expected pointer to stack or const struct bpf_dynptr")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
 int kfunc_dynptr_nullable_test3(struct __sk_buff *skb)
 {
 	struct bpf_dynptr data;
-- 
2.47.3



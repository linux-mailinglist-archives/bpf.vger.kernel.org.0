Return-Path: <bpf+bounces-77701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C891ACEF21D
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 19:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39D29303C12E
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 18:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CCA30102C;
	Fri,  2 Jan 2026 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SK41j+Xr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80CC3016E9
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376885; cv=none; b=DNmIUxOwYGEoAlCdfvfZ9Pm12G2S3MJ7m8re7F1ZfBsrWWyJr2CRC3mWfQXI3jIbkIpQ+lNfqtTq0LQsmONjHTVB0/X/TUiUqlVwQak7Oa516JdcA7/92cChWnmL6bQeMbrmVM03Y7zegUIwIzhcaJjykpEsT4pLRyjPglyeqN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376885; c=relaxed/simple;
	bh=Wc1IlG0wdf21IP+2GGjryyEp+JEv1L24zURRuAc8HdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OT7RqN+ZhyGvSIGCxVpb4pS8Tr4EdyZFRbcsvNfb0YrsUGWx6lpRB8UrADFC9gds9899xPRwkHCcA7Hmbi319bzQl9qM/sqTq0lh1+ALgo8mUTzfVgc8bhhzWs+pH2j8dnGC8ymQBtpd4br2uOGx7HYGnIEF+qLj9xwp2LBJoas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SK41j+Xr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5385DC116D0;
	Fri,  2 Jan 2026 18:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767376885;
	bh=Wc1IlG0wdf21IP+2GGjryyEp+JEv1L24zURRuAc8HdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SK41j+Xr5m+5cv7sdW4MaowSP3rkAWq5/NbCpk2CBSp/3wricWlA829IHLj4m6MRi
	 FMSyEXCt6Db+Y3wxyBCkU4CwofyM1SYq59Ram6icxhpQLD/MW1moxIAfYYd44Y24Ld
	 ZDGhSVOWmUWZ5MMCjCzG6sHmJleEMy1S3vi1O/U4MkRrx9vzubrah6YJ3714nkiPIO
	 YP3XXfLftaWMjIHIfRrQDIfWv/EDpLUlXJulIImWtxyQTrTfrL+TM95Du1k5TbEr1l
	 c00adHyQ2BU/m/EO5s2w9Jx6uYarGiUnfckWuNzcj9OLe9TNYIYYgP1XF0rB6iSIjd
	 dBNoLxnViuxrw==
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
Subject: [PATCH bpf-next v3 08/10] selftests: bpf: fix test_kfunc_dynptr_param
Date: Fri,  2 Jan 2026 10:00:34 -0800
Message-ID: <20260102180038.2708325-9-puranjay@kernel.org>
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

As verifier now assumes that all kfuncs only takes trusted pointer
arguments, passing 0 (NULL) to a kfunc that doesn't mark the argument as
__nullable or __opt will be rejected with a failure message of: Possibly
NULL pointer passed to trusted arg<n>

Pass a non-null value to the kfunc to test the expected failure mode.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
index 061befb004c2..d249113ed657 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -48,10 +48,9 @@ SEC("?lsm.s/bpf")
 __failure __msg("arg#0 expected pointer to stack or const struct bpf_dynptr")
 int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
-	unsigned long val = 0;
+	static struct bpf_dynptr val;
 
-	return bpf_verify_pkcs7_signature((struct bpf_dynptr *)val,
-					  (struct bpf_dynptr *)val, NULL);
+	return bpf_verify_pkcs7_signature(&val, &val, NULL);
 }
 
 SEC("lsm.s/bpf")
-- 
2.47.3



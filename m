Return-Path: <bpf+bounces-29862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F068C7A99
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 18:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DF06B22EE5
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 16:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7EF6FD3;
	Thu, 16 May 2024 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PnMpaVKI"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4685AEAE6
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877808; cv=none; b=t9hCA6HzZNKpzRirZp2UzCkLkDHu6u6w7cWvkBlixTi7qlUovkvwQIqz9dDvuYjPAnUBYGTV759YaNhZs+5hhVcMttpBnbhtejAUAYaXpmZ4n+5h0IgNLnFWwfpKBoGvsW7xxtFB3afJMQSw9eE9rZdf76qz5sTa+e/E12n74x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877808; c=relaxed/simple;
	bh=a4fohLTsiS7QiUjizLYiioTJssHvA9BGImTbZiUypDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tsil7jry4I0qLjkEplVt7PbuZDbRGuA43zaa3nYHdjWgOg9fVSe7L3pL949HY7F/3nfrUZ3wk3rl7BSZDeF4nTygsk5ds2lDUPc6VQhfcQbckMr41N2lKPA8SvLrF8EmPRnDCFnJcQ82CPcdZ1CanUO1EBHMRT3z0zDjv90ukeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PnMpaVKI; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715877803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZKs8Dr6JWsVvdJcOJVoVZC78C1tk/TyOT9xJpGjCCoA=;
	b=PnMpaVKIncAj5xSC4hy5AwuRg6jhXPRMvCqH0t0ZndjfHajjucRSu+0ClijBvmH5fc515S
	B+0owt+ZQ6yHZX4DKrXLatDtBYN6iNjEO0IvXpjxQNfjW8Amkb6TAyl5Kq7TWPvbBFwN+E
	yZIEeawj4EOhp8h6/4tTfQihzBgmMYI=
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@meta.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf] selftests/bpf: Adjust btf_dump test to reflect recent change in file_operations
Date: Thu, 16 May 2024 09:43:10 -0700
Message-ID: <20240516164310.2481460-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The btf_dump test fails:

test_btf_dump_struct_data:FAIL:file_operations unexpected file_operations: actual '(struct file_operations){
	.owner = (struct module *)0xffffffffffffffff,
	.fop_flags = (fop_flags_t)4294967295,
	.llseek = (loff_t (*)(struct f' != expected '(struct file_operations){
	.owner = (struct module *)0xffffffffffffffff,
	.llseek = (loff_t (*)(struct file *, loff_t, int))0xffffffffffffffff,'

The "fop_flags" is a recent addition to the struct file_operations in
commit 210a03c9d51a ("fs: claw back a few FMODE_* bits")

This patch changes the test_btf_dump_struct_data() to reflect
this change.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index e9ea38aa8248..09a8e6f9b379 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -653,7 +653,7 @@ static void test_btf_dump_struct_data(struct btf *btf, struct btf_dump *d,
 		cmpstr =
 "(struct file_operations){\n"
 "	.owner = (struct module *)0xffffffffffffffff,\n"
-"	.llseek = (loff_t (*)(struct file *, loff_t, int))0xffffffffffffffff,";
+"	.fop_flags = (fop_flags_t)4294967295,";
 
 		ASSERT_STRNEQ(str, cmpstr, strlen(cmpstr), "file_operations");
 	}
-- 
2.43.0



Return-Path: <bpf+bounces-64605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E13CB14BB9
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 11:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFCB3A4735
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 09:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98E72877DA;
	Tue, 29 Jul 2025 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="KKllHRoi"
X-Original-To: bpf@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DFD233721;
	Tue, 29 Jul 2025 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782913; cv=none; b=cL311em7AcB0GRhMulRruuiUao2BLF2qrkRJAtRylmcfiJ3FcalfzaD6lUCMlB2MJnf8omsRnMN7lC0br8sWveQvb8WsuJ0/jM3AIt9fTXfPM3fWmPne88tfHFRiY8JWnrLxYoJxsccozt17Wgsb6op1/biLZ7Brd3rHFEjEGHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782913; c=relaxed/simple;
	bh=ypFGUj5D/RsIpLfcUVF5nL2pTzMlEatJ2G6fAB11pWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNmFOQHhVv7ehhSXSAEBUPsHlOU/IeCHWC/PmfVubFTvo3LyfPEgqaDO/wrearRzoMHgKGhGnskdnxV+0JiKxdLQjKQdqdB710mY4edZnoHYYwBlvXgmrTX8Lwn/WJ3Axek6ACxjyAJEt6gk5Bi6lOFJNW+9q9c0KXy0GTqA9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=KKllHRoi; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id AD5F77D32D;
	Tue, 29 Jul 2025 11:46:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1753782402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u5aVN9MeNmddLzpEpIfgyH5J5qgbEfCV/49SBvFIR9U=;
	b=KKllHRoinqo7q60Jzfk9bRa00AFi4vG77BDbJLngZ0QukZpJG/0224fPd35r6UdkFJHD5H
	DZReOMvxJ6G40t50M1tS5cGH4XDSXATHsZLE1N4Sj7+ERU2q7nfsRACNAQlJ45VwKzstYN
	nIkdZEgGaehH8D6PnBlE1jSAzzFnYo0=
From: Achill Gilgenast <fossdd@pwned.life>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Viktor Malik <vmalik@redhat.com>,
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Achill Gilgenast <fossdd@pwned.life>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH] libbpf: avoid possible use of uninitialized mod_len
Date: Tue, 29 Jul 2025 11:45:53 +0200
Message-ID: <20250729094611.2065713-1-fossdd@pwned.life>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

If not fn_name, mod_len does never get initialized which fails now with
gcc15 on Alpine Linux edge:

	libbpf.c: In function 'find_kernel_btf_id.constprop':
	libbpf.c:10100:33: error: 'mod_len' may be used uninitialized [-Werror=maybe-uninitialized]
	10100 |                 if (mod_name && strncmp(mod->name, mod_name, mod_len) != 0)
	      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	libbpf.c:10070:21: note: 'mod_len' was declared here
	10070 |         int ret, i, mod_len;
	      |                     ^~~~~~~

Fixes: 8f8a024272f3 ("libbpf: support "module: Function" syntax for tracing programs")
Signed-off-by: Achill Gilgenast <fossdd@pwned.life>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e067cb5776bd..fb4d92c5c339 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10086,27 +10086,27 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int t
 	btf__free(btf);
 	if (err <= 0) {
 		pr_warn("%s is not found in prog's BTF\n", name);
 		goto out;
 	}
 out:
 	return err;
 }
 
 static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 			      enum bpf_attach_type attach_type,
 			      int *btf_obj_fd, int *btf_type_id)
 {
-	int ret, i, mod_len;
+	int ret, i, mod_len = 0;
 	const char *fn_name, *mod_name = NULL;
 
 	fn_name = strchr(attach_name, ':');
 	if (fn_name) {
 		mod_name = attach_name;
 		mod_len = fn_name - mod_name;
 		fn_name++;
 	}
 
 	if (!mod_name || strncmp(mod_name, "vmlinux", mod_len) == 0) {
 		ret = find_attach_btf_id(obj->btf_vmlinux,
 					 mod_name ? fn_name : attach_name,
 					 attach_type);
-- 
2.50.1



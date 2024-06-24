Return-Path: <bpf+bounces-32881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D555D9145E2
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 11:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F946286B9B
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 09:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C935F7FBA4;
	Mon, 24 Jun 2024 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQxztiih"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C367FD
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220152; cv=none; b=hC2j3/r1hEfK268H9S/a8CRXhH2iq1AKC+tD0gG+nEir4slDXfa2njdi6rnvDib7vz/jltQUr56FfZvIY8Xe/5jo/T81NkSfnUQ/7bSCzkHdPKotzLvAqsr5VCpd/gKB/yDEyDusn7OH/SsqWciaGk2CFZwrUMdZ7Z039jTsO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220152; c=relaxed/simple;
	bh=5glECG6cUq2jG5RY4bp8R0O56qr9ZsfH5H417VloVIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3Mi3f9PjE8SYniYED9J0JvETV9HcF6FCztdLlvNqHPqpuJwgqB0MHchSJUbvuxXxIDoK88CFPqqPmWTYYXEzzpjQEZd9rx9Z4JV38Gjd8DZExU6PFBJxdEVQvvozxSIfU40L8Cbwu0X4tU84WWxzeSWDVqJeTfKV8x3L8oMFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQxztiih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A89C2BBFC;
	Mon, 24 Jun 2024 09:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719220151;
	bh=5glECG6cUq2jG5RY4bp8R0O56qr9ZsfH5H417VloVIU=;
	h=From:To:Cc:Subject:Date:From;
	b=UQxztiihtpkmpKvwkmCPEPy6zcEistk85ooI2EFCb5oKPRFkgwW8KTgBM6frnjVt3
	 2lT5An6O5YZZst37/9x+5ngZbbz3xRzvisIbTQHrv/gztcc/kE+DYoc5utse94Mpdn
	 D76dOen7QRfqi0ynzCJGRUyMe5AWGL9Pf1oRzNQPQQ+soUnHOYtCgH2Yamj+06ln7b
	 t3Evqb0GQrdBjcCkQp4Kc+zJLkilQijEEHbKIDzpx/KDHwOk3G9pQ0n7WPsDFhNoZU
	 uTpumOekAQz/QrkC9oErmu+NuchXRSqU/6i8kcqYUOn9xvR8YvhkzySDYtwwRvZmhI
	 GJAVwmdSUu5Zg==
From: Antoine Tenart <atenart@kernel.org>
To: andrii@kernel.org,
	eddyz87@gmail.com
Cc: Antoine Tenart <atenart@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH bpf] libbpf: skip base btf sanity checks
Date: Mon, 24 Jun 2024 11:09:07 +0200
Message-ID: <20240624090908.171231-1-atenart@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When upgrading to libbpf 1.3 we noticed a big performance hit while
loading programs using CORE on non base-BTF symbols. This was tracked
down to the new BTF sanity check logic. The issue is the base BTF
definitions are checked first for the base BTF and then again for every
module BTF.

Loading 5 dummy programs (using libbpf-rs) that are using CORE on a
non-base BTF symbol on my system:
- Before this fix: 3s.
- With this fix: 0.1s.

Fix this by only checking the types starting at the BTF start id. This
should ensure the base BTF is still checked as expected but only once
(btf->start_id == 1 when creating the base BTF), and then only
additional types are checked for each module BTF.

Fixes: 3903802bb99a ("libbpf: Add basic BTF sanity validation")
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 2d0840ef599a..142060bbce0a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -598,7 +598,7 @@ static int btf_sanity_check(const struct btf *btf)
 	__u32 i, n = btf__type_cnt(btf);
 	int err;
 
-	for (i = 1; i < n; i++) {
+	for (i = btf->start_id; i < n; i++) {
 		t = btf_type_by_id(btf, i);
 		err = btf_validate_type(btf, t, i);
 		if (err)
-- 
2.45.2



Return-Path: <bpf+bounces-59923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3EFAD0906
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 22:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82851189F0A2
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 20:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B643204090;
	Fri,  6 Jun 2025 20:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjT/tHjo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A77FD;
	Fri,  6 Jun 2025 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749241298; cv=none; b=t8jg8ezQ8LqoW1bF1tYG5q6nI0vSDU0d5yBpwuQkTBDiQK4wJJtXNVnNZl4UiipN2NIyt/bydGcuQhnLsRJDYV8QigoGQx0DVTp0w422RWMsBD58KGU4ZAepJgebh01XvHSvVmmVw6wC1AuWnKh7sQW/GxKwkptAvZnzSLlvh4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749241298; c=relaxed/simple;
	bh=ahJRMWwcBdAxwTD2ldS7LWIg/E8oQ+YShdv050FkVo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EaFsu0xQ3T5MeuKvt9CSdcuq1GJQhU7BUAiquYVyDdr9EFptP/kiJ5hOVENmGVwWQdB4L2Sy1x2LOyn7Lwo4stZ3jnbBk9Owo7iOM11A/QUhinzbRQXIklZqty32oQquS7FpKXXW89SP2bWWl0yf+q9gnlYycve3eqBw5Zosfyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjT/tHjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24485C4CEEB;
	Fri,  6 Jun 2025 20:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749241298;
	bh=ahJRMWwcBdAxwTD2ldS7LWIg/E8oQ+YShdv050FkVo0=;
	h=From:To:Cc:Subject:Date:From;
	b=PjT/tHjozJXzGY/BBqL7+pezJh6VjheovaUzOltOia2WzjPd6scIgnmY79ESG1plc
	 DBONh5jEquIpdtoWjeUzjO8BrjXe3Pwi3PfgtFrKkWq29oUGWgugqRkdo7ie948AvQ
	 Tp2TPSpzj22Mr83G3SlBMCkgi6PS72VT6oxDSZsuDkGQ5kIi7DgKDOmHoNcyWXa/bw
	 JXf8B4z/q6l9vw2xde8HKAoyAk0lvDiG8EZcC3yaQWSyhJvCgHfbaClrG3hzlqwT1G
	 m+o/aCKA0w3dPaJTSFkpXwDXfiKG0pUlRqGT567nN61HNHPHviuq7L5xPAEG+qbQt4
	 5BfAznuyK2RXA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH bpf] libbpf: handle unsupported mmap-based /sys/kernel/btf/vmlinux correctly
Date: Fri,  6 Jun 2025 13:21:34 -0700
Message-ID: <20250606202134.2738910-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libbpf_err_ptr() helpers are meant to return NULL and set errno, if
there is an error. But btf_parse_raw_mmap() is meant to be used
internally and is expected to return ERR_PTR() values. Because of this
mismatch, when libbpf tries to mmap /sys/kernel/btf/vmlinux, we don't
detect the error correctly with IS_ERR() check, and never fallback to
old non-mmap-based way of loading vmlinux BTF.

Fix this by using proper ERR_PTR() returns internally.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Fixes: 3c0421c93ce4 ("libbpf: Use mmap to parse vmlinux BTF from sysfs")
Cc: Lorenz Bauer <lmb@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index f1d495dc66bb..37682908cb0f 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1384,12 +1384,12 @@ static struct btf *btf_parse_raw_mmap(const char *path, struct btf *base_btf)
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
-		return libbpf_err_ptr(-errno);
+		return ERR_PTR(-errno);
 
 	if (fstat(fd, &st) < 0) {
 		err = -errno;
 		close(fd);
-		return libbpf_err_ptr(err);
+		return ERR_PTR(err);
 	}
 
 	data = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -1397,7 +1397,7 @@ static struct btf *btf_parse_raw_mmap(const char *path, struct btf *base_btf)
 	close(fd);
 
 	if (data == MAP_FAILED)
-		return libbpf_err_ptr(err);
+		return ERR_PTR(err);
 
 	btf = btf_new(data, st.st_size, base_btf, true);
 	if (IS_ERR(btf))
-- 
2.47.1



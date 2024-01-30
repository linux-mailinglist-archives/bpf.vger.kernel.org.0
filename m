Return-Path: <bpf+bounces-20766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F3D842CFB
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 20:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B005128BA82
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 19:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C475E7B3EF;
	Tue, 30 Jan 2024 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iU0mSVNP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470D226AFC
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643415; cv=none; b=JVZ8uEmGfbvjtv0JcJa930HH+us8VOPaZ1f1YuNUBH0DI0cH0rKovgwuEVUzfiApXFyTy3b0ollYoyhUml9B5hQdiaeEfldRiqhAMrW41ISSuKmYUp49Wsy0MlBgmpWfCXa5LKtjFV9r4dsuIOefFO5uNNcWamH6lQJFqbB+XyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643415; c=relaxed/simple;
	bh=/TXspryycRW6ksCtZaVIvJZ2cUyLl+AkwzznymSIHYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HzrFj4+DWB25HmWsc4eq9fYFC8iCaC/+bzWIfBnW1n4d2C7WlzX1yo2XAssuoSKpz7RPE6RF7EvhX6i664ziuXU7CgdztLkmxNqEYKuDKQuSCdK7CBEx62aeeRQlfm1aVwpmKhi/W3XIYuWyxcka/Q1hPIIphZD7zFO8O4tZCis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iU0mSVNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E0DC433C7;
	Tue, 30 Jan 2024 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706643414;
	bh=/TXspryycRW6ksCtZaVIvJZ2cUyLl+AkwzznymSIHYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iU0mSVNP9YsTfcqchaMOG16Lf821Umo6vpL1ypzFKIgZunKHGZQVbgV1LVCN4aEk0
	 N6y03Dqx8DESaUPb5MhdCXRV5kMpX4DpesSCEqeJY/orniHcXHV9Wj2FVw9hJ//zT/
	 W5BRaAan+HCEBl9OyOXg0wxOPgud/gxLN1vpqC8KNhy0w3OoURWMqZdU0tDCcAs43C
	 Y8c5cDWLJwSyB9oTSguLMXifnmgYF+vPwSk4KwBcT6NRrjKQolnawgMhhaVbbq1HSZ
	 IQIZ5oMCxEFu8V2ll0+6F0/Vcj08VdknkIIM2w+iaCb+9i2291Jq3diTwnQsBbKGKE
	 CUxYp9xXz5JVA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/5] libbpf: call memfd_create() syscall directly
Date: Tue, 30 Jan 2024 11:36:45 -0800
Message-Id: <20240130193649.3753476-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130193649.3753476-1-andrii@kernel.org>
References: <20240130193649.3753476-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some versions of Android do not implement memfd_create() wrapper in
their libc implementation, leading to build failures ([0]). On the other
hand, memfd_create() is available as a syscall on quite old kernels
(3.17+, while bpf() syscall itself is available since 3.18+), so it is
ok to assume that syscall availability and call into it with syscall()
helper to avoid Android-specific workarounds.

Validated in libbpf-bootstrap's CI ([1]).

  [0] https://github.com/libbpf/libbpf-bootstrap/actions/runs/7701003207/job/20986080319#step:5:83
  [1] https://github.com/libbpf/libbpf-bootstrap/actions/runs/7715988887/job/21031767212?pr=253

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index db65ea59a05a..b21fda6b9b85 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1525,11 +1525,20 @@ static Elf64_Sym *find_elf_var_sym(const struct bpf_object *obj, const char *nam
 	return ERR_PTR(-ENOENT);
 }
 
+/* Some versions of Android don't provide memfd_create() in their libc
+ * implementation, so avoid complications and just go straight to Linux
+ * syscall.
+ */
+static int sys_memfd_create(const char *name, unsigned flags)
+{
+	return syscall(__NR_memfd_create, name, flags);
+}
+
 static int create_placeholder_fd(void)
 {
 	int fd;
 
-	fd = ensure_good_fd(memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC));
+	fd = ensure_good_fd(sys_memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC));
 	if (fd < 0)
 		return -errno;
 	return fd;
-- 
2.34.1



Return-Path: <bpf+bounces-45698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0752F9DA595
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 11:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95044164106
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 10:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52563195FD1;
	Wed, 27 Nov 2024 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoGE+gOZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD2433C8;
	Wed, 27 Nov 2024 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732702682; cv=none; b=E+gHwWXcNrZwOQQAwC4saE37TyMmZ/ufXhLjbk+7ZRwmAQj5tSns+FTPGiu1JFNBdSEymgYoSXnXYuwobGQx7v1HjSZLgSYAdUlBE8fe5qSjjKfIItLEZ4BEbd5WnbrCV8uGQETKMWaY/U+LoB06PMQIHumrc/vGng3Re5sIwcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732702682; c=relaxed/simple;
	bh=D3cgGvnrdPxZeZ3kksJOk9iv4alQOS4qpqxciK9Y+b0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gHm4JdowueYI3GD1E5o5XogpaVtzFHYIHfC1ud2ruBTQH7R+CL6QnI7rPJBJC3CnUOBxn1zOCB5sS5/ivhutFS0/BNMKp6gtA/KBWkEr931yclzNVdJZCloK8rqFGk2ptwm3e4BrkP+7GwRrPo4s4jU4y58ihv7lQ2IvGHFBbus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoGE+gOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6599EC4CECC;
	Wed, 27 Nov 2024 10:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732702682;
	bh=D3cgGvnrdPxZeZ3kksJOk9iv4alQOS4qpqxciK9Y+b0=;
	h=From:To:Cc:Subject:Date:From;
	b=VoGE+gOZqDu7IiKN5xke6GUIgqivy6zpdKiN189F0MFZ7/u3udStYsgUHM2oIW9cl
	 sfa8gYh7MlCVl7k0ZP6wWAFbk2BqH6T+mxumBMqoNDZGoDXDJ5Mi5mff1rZ8Zn7D0T
	 vRlWn/TTw4PEq0KHVmtVedfKAJCyA5/hv/O20yYJjEtiHvzRzZ0QNaHAT07BBq2Elc
	 gCjX7r8T0B6eGiQSI28ljBgajzPNFoCEHqguW3fxjamwo5hWXIs3aNk/1VghxMJTOZ
	 bjHMzb6OJAUvGD6MxtT3ZSTuEgxL6NLUhUj7e7qZfWzFSQdNrm60nNiuaXbi5oFkl/
	 XoxYqLf9PaovA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Quentin Monnet <qmo@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Abdurachmanov <davidlt@rivosinc.com>,
	"Namhyung Kim" <namhyung@kernel.org>
Subject: [PATCH bpf v2] tools: Override makefile ARCH variable if defined, but empty
Date: Wed, 27 Nov 2024 11:17:46 +0100
Message-ID: <20241127101748.165693-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

There are a number of tools (bpftool, selftests), that require a
"bootstrap" build. Here, a bootstrap build is a build host variant of
a target. E.g., assume that you're performing a bpftool cross-build on
x86 to riscv, a bootstrap build would then be an x86 variant of
bpftool. The typical way to perform the host build variant, is to pass
"ARCH=" in a sub-make. However, if a variable has been set with a
command argument, then ordinary assignments in the makefile are
ignored.

This side-effect results in that ARCH, and variables depending on ARCH
are not set.

Workaround by overriding ARCH to the host arch, if ARCH is empty.

Fixes: 8859b0da5aac ("tools/bpftool: Fix cross-build")
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
v2: Proper tree tag "bpf".
    Collected *-by tags.

Andrii,

Apologies for missing out the tree tag in the patch. Here's a respin,
and thanks for routing it via the BPF tree.


Björn

---
 tools/scripts/Makefile.arch | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
index f6a50f06dfc4..eabfe9f411d9 100644
--- a/tools/scripts/Makefile.arch
+++ b/tools/scripts/Makefile.arch
@@ -7,8 +7,8 @@ HOSTARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
                                   -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
                                   -e s/riscv.*/riscv/ -e s/loongarch.*/loongarch/)
 
-ifndef ARCH
-ARCH := $(HOSTARCH)
+ifeq ($(strip $(ARCH)),)
+override ARCH := $(HOSTARCH)
 endif
 
 SRCARCH := $(ARCH)

base-commit: 3448ad23b34e43a2526bd0f9e1221e8de876adec
-- 
2.45.2



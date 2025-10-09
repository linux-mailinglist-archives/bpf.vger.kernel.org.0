Return-Path: <bpf+bounces-70671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82220BC9F0D
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 18:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E19A4FC47C
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 16:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1002EC544;
	Thu,  9 Oct 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxpBxa9Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC964218845;
	Thu,  9 Oct 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025482; cv=none; b=B8MJz+IWtFgXBIJdgg+zMbI2mHjJ52C6j+UbNlmgybZvBM3Y5eh3VCDip5hmXU6SjzOxjF94qYgw9p70UR5jNL/+leFHLRnkSmd7AHPOEKLKgXIwsR/Bn7hGmCKbDBA0ABA88RiyEmtZfnDpqIwgaiZET8184YXYOPfY/XHpEEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025482; c=relaxed/simple;
	bh=Dd09TMeE0odjNhZQXTrUjLsAdVPtE8LV3CsOhiT9TqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOFHWj5fIztGKaDIbc+Q9dEODSOUrpMi0LxaZ783RiUVS5C8JC+PHC2uzZ70K5JAXyUIkfPfDNZp1FLwDxPYDV/EKr2wpBWwG3uhAeSad5UJP1MHnocRo6pqVBd6c98uxd5VggzcmGvSXPjzPe6ficLIwVKVFNg5qX9vEL9LYj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxpBxa9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9AAC4CEF7;
	Thu,  9 Oct 2025 15:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025482;
	bh=Dd09TMeE0odjNhZQXTrUjLsAdVPtE8LV3CsOhiT9TqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxpBxa9QBokEsRDlFiKJki4J+wi9kCa+PAMc1iXsc8+vPObCdQA4tF7RGwMV2O165
	 YuT38e9Ces8dNQmGE86E6H9a10jw+XpTjZRR2ylTIfwCxTtsfUOHlZSKRJ/qvTyldv
	 9ePp5AXa3LgF27COacIIuQ2v87JgGd7vPDiaKroBhv4VKqsBUTsGDDx/4cMJdc/ikc
	 9sSCzVyScvK7EuPJclp892duoIWnP4VFRkHzwdL2SKGD9kUWo3FLtnZAhW1+oeWsT3
	 PqpopyHhPn6OpXSzSAZe5RD9WBFnMV8ZkyQYLqQjfOJ9/3fzAyi4sQB0PWNpz6vhgl
	 br7gfCKgf54sA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Tom Stellard <tstellar@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.17-6.1] bpftool: Fix -Wuninitialized-const-pointer warnings with clang >= 21
Date: Thu,  9 Oct 2025 11:54:33 -0400
Message-ID: <20251009155752.773732-7-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tom Stellard <tstellar@redhat.com>

[ Upstream commit 5612ea8b554375d45c14cbb0f8ea93ec5d172891 ]

This fixes the build with -Werror -Wall.

btf_dumper.c:71:31: error: variable 'finfo' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
   71 |         info.func_info = ptr_to_u64(&finfo);
      |                                      ^~~~~

prog.c:2294:31: error: variable 'func_info' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
 2294 |         info.func_info = ptr_to_u64(&func_info);
      |

v2:
  - Initialize instead of using memset.

Signed-off-by: Tom Stellard <tstellar@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Quentin Monnet <qmo@kernel.org>
Link: https://lore.kernel.org/bpf/20250917183847.318163-1-tstellar@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

**Rationale**
- Fixes a real build failure with modern toolchains: clang ≥ 21 warns
  about passing the address of an uninitialized object to a function
  taking a const pointer; with `-Werror -Wall` this breaks bpftool
  builds.
- Change is minimal, localized, and non-functional: it only zero-
  initializes two local `struct bpf_func_info` instances so the address
  isn’t of an uninitialized object.
- Consistent with existing code in the same tool: other bpftool paths
  already initialize `bpf_func_info` similarly, so this aligns style and
  avoids surprises.

**Code References**
- In `tools/bpf/bpftool/btf_dumper.c:41`, `struct bpf_func_info finfo;`
  is currently uninitialized but its address is passed to `ptr_to_u64()`
  at `tools/bpf/bpftool/btf_dumper.c:71`, which triggers clang’s
  `-Wuninitialized-const-pointer`. The patch changes the declaration to
  `struct bpf_func_info finfo = {};`, preventing the warning.
- In `tools/bpf/bpftool/prog.c:2265`, `struct bpf_func_info func_info;`
  is uninitialized, and its address is passed to `ptr_to_u64()` at
  `tools/bpf/bpftool/prog.c:2294`. The patch changes the declaration to
  `struct bpf_func_info func_info = {};`, removing the warning.
- `ptr_to_u64()` is declared as taking a `const void *`
  (`tools/bpf/bpftool/main.h:25`), which is why clang applies the const-
  pointer uninitialized check when the address of an uninitialized
  object is passed.
- A precedent in the same codebase already initializes the same type:
  `tools/bpf/bpftool/common.c:416` uses `struct bpf_func_info finfo =
  {};`, demonstrating this is the established and safe pattern.

**Why It’s Safe**
- The variables are used strictly as output buffers for
  `bpf_prog_get_info_by_fd()`:
  - `btf_dumper.c`: Only after `info.nr_func_info` is non-zero and the
    second `bpf_prog_get_info_by_fd()` succeeds do we read
    `finfo.type_id` (`tools/bpf/bpftool/btf_dumper.c:80`). On error
    paths we don’t read `finfo`.
  - `prog.c`: We check `info.nr_func_info != 0` before issuing the
    second `bpf_prog_get_info_by_fd()`, and only on success read
    `func_info.type_id` (`tools/bpf/bpftool/prog.c:2308`).
- Zero-initialization does not change runtime semantics; the kernel
  overwrites these structures on success, and on failure paths they
  aren’t consumed.

**Stable Backport Criteria**
- Important bugfix: restores bpftool buildability with clang ≥ 21 under
  `-Werror -Wall`.
- Small and contained: two initializations; no ABI or behavioral
  changes.
- No architectural changes; no risk to core kernel subsystems (user-
  space tools only).
- Low regression risk; aligns with existing initialization pattern
  already present elsewhere in bpftool.

Given the above, this commit is an excellent candidate for stable
backport to keep tools building with current compilers and to maintain
consistency within bpftool.

 tools/bpf/bpftool/btf_dumper.c | 2 +-
 tools/bpf/bpftool/prog.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 4e896d8a2416e..ff12628593aec 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -38,7 +38,7 @@ static int dump_prog_id_as_func_ptr(const struct btf_dumper *d,
 	__u32 info_len = sizeof(info);
 	const char *prog_name = NULL;
 	struct btf *prog_btf = NULL;
-	struct bpf_func_info finfo;
+	struct bpf_func_info finfo = {};
 	__u32 finfo_rec_size;
 	char prog_str[1024];
 	int err;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 9722d841abc05..a89629a9932b5 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2262,7 +2262,7 @@ static void profile_print_readings(void)
 
 static char *profile_target_name(int tgt_fd)
 {
-	struct bpf_func_info func_info;
+	struct bpf_func_info func_info = {};
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
 	const struct btf_type *t;
-- 
2.51.0



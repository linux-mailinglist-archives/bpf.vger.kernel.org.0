Return-Path: <bpf+bounces-36784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E906B94D569
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 19:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273F91C212B1
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 17:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595484EB5E;
	Fri,  9 Aug 2024 17:27:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B565818AF9;
	Fri,  9 Aug 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224428; cv=none; b=bW+y2kO00UfxVHj8XiF8tfGRG9ceh1caIZDH+uquxb6PTweC+FscaKtxi+ZOCxay5wp83CFvMELpJrTq1yz5lsRdViXVsM+jpq0xdIoWnN6kANS/0hjPDP5iaajZSdRYqB/sAUTp2VsuWnmR2RDcOSt9z9+mh+JOe8tZElQB/jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224428; c=relaxed/simple;
	bh=UEMJSCPC06mX95wMv+b6VRAuDY2cK9dt0+DdZbnB0Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MY++RP3u0EOp6IkOr6N+1dq7oV1agBLtCCZOTRf/09IlIWoO8TrSip6zCS0YzhW2p04Z/JuZM+QCys7b8DOTe1vLF88D1TY1A1qNSiCNjFJ8YFeRp6pyCeutgdtGzcJeu3y4BjKpf0eouSfkogd8Kefq46kdRfF21qrMHAQLsRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Andrew Pinski <quic_apinski@quicinc.com>,
	=?UTF-8?q?Kacper=20S=C5=82omi=C5=84ski?= <kacper.slominski72@gmail.com>,
	=?UTF-8?q?Arsen=20Arsenovi=C4=87?= <arsen@gentoo.org>,
	Sam James <sam@gentoo.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2] libbpf: workaround -Wmaybe-uninitialized false positive
Date: Fri,  9 Aug 2024 18:26:41 +0100
Message-ID: <8f5c3b173e4cb216322ae19ade2766940c6fbebb.1723224401.git.sam@gentoo.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In `elf_close`, we get this with GCC 15 -O3 (at least):
```
In function ‘elf_close’,
    inlined from ‘elf_close’ at elf.c:53:6,
    inlined from ‘elf_find_func_offset_from_file’ at elf.c:384:2:
elf.c:57:9: warning: ‘elf_fd.elf’ may be used uninitialized [-Wmaybe-uninitialized]
   57 |         elf_end(elf_fd->elf);
      |         ^~~~~~~~~~~~~~~~~~~~
elf.c: In function ‘elf_find_func_offset_from_file’:
elf.c:377:23: note: ‘elf_fd.elf’ was declared here
  377 |         struct elf_fd elf_fd;
      |                       ^~~~~~
In function ‘elf_close’,
    inlined from ‘elf_close’ at elf.c:53:6,
    inlined from ‘elf_find_func_offset_from_file’ at elf.c:384:2:
elf.c:58:9: warning: ‘elf_fd.fd’ may be used uninitialized [-Wmaybe-uninitialized]
   58 |         close(elf_fd->fd);
      |         ^~~~~~~~~~~~~~~~~
elf.c: In function ‘elf_find_func_offset_from_file’:
elf.c:377:23: note: ‘elf_fd.fd’ was declared here
  377 |         struct elf_fd elf_fd;
      |                       ^~~~~~
```

In reality, our use is fine, it's just that GCC doesn't model errno
here (see linked GCC bug). Suppress -Wmaybe-uninitialized accordingly.

Link: https://gcc.gnu.org/PR114952
Signed-off-by: Sam James <sam@gentoo.org>
---
v2: Fix Clang build.

Range-diff against v1:
1:  3ebbe7a4e93a ! 1:  8f5c3b173e4c libbpf: workaround -Wmaybe-uninitialized false positive
    @@ tools/lib/bpf/elf.c: long elf_find_func_offset(Elf *elf, const char *binary_path
      	return ret;
      }
      
    ++#if !defined(__clang__)
     +#pragma GCC diagnostic push
     +/* https://gcc.gnu.org/PR114952 */
     +#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
    ++#endif
      /* Find offset of function name in ELF object specified by path. "name" matches
       * symbol name or name@@LIB for library functions.
       */
    @@ tools/lib/bpf/elf.c: long elf_find_func_offset_from_file(const char *binary_path
      	elf_close(&elf_fd);
      	return ret;
      }
    ++#if !defined(__clang__)
     +#pragma GCC diagnostic pop
    ++#endif
      
      struct symbol {
      	const char *name;

 tools/lib/bpf/elf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index c92e02394159..7058425ca85b 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -369,6 +369,11 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 	return ret;
 }
 
+#if !defined(__clang__)
+#pragma GCC diagnostic push
+/* https://gcc.gnu.org/PR114952 */
+#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
+#endif
 /* Find offset of function name in ELF object specified by path. "name" matches
  * symbol name or name@@LIB for library functions.
  */
@@ -384,6 +389,9 @@ long elf_find_func_offset_from_file(const char *binary_path, const char *name)
 	elf_close(&elf_fd);
 	return ret;
 }
+#if !defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
 
 struct symbol {
 	const char *name;
-- 
2.45.2



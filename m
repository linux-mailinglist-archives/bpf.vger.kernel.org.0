Return-Path: <bpf+bounces-49513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF56DA197F9
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598A5188EED4
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA0D21A45D;
	Wed, 22 Jan 2025 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dlq/2Gyn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3621A42F
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567822; cv=none; b=DalvQhuwQcafXPeV/ASnO6do0y2qnIBoVh5m2A6e5jUbpsCM5ZRK2SrLigzNDDaKAJkYx3JkYuhxgp6pv4i5SHI5eInVg+2Uue6q4JxJZc+DhwBDQwETMBS3mEQkzFibgZsG6QtNDI25RKR7eUJBb9bAelHeCYpQQp4Tbh53Xn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567822; c=relaxed/simple;
	bh=qDGVbxupBPhehpggHu43Ttvfz1Jydc4UfVpiUQ9BNUw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lau8DLe01b8+ppngzarHEh8ppUY2qqCe0mNhkOtkyf8cffxmu8t8djrJyPss66Ur6dhHghTZafFy048V8GpvYWy3f4kgWaJQsF7BHzDslgEMHnB+B9Vtk3V/JxNuFTzs2ANeL5Kvjzjfo693KjF9ssNm3ABuZq0QNg8xUF5yMfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dlq/2Gyn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e579836ee17so13849217276.2
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 09:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567819; x=1738172619; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G8iKYF3csT963Oh0FXrUrlrS8IS249puoLm4/xmteLU=;
        b=Dlq/2GynidgaXxIKElqlIRz5xJcHp5p/4+YBd/d+ZI2pU0u0kDMLkPQQkfx1WYpKn4
         THfhprr7hckpY+wqj2KqRq5V2niH5hrwg3p+8f2DYf9eg7FEyItEk5gXhSgv7RJy+Ke9
         y04QnIctg6SwAJnodM/1AeDSlIgCWHnIIJbUbzkrDNydvZgETHnMeVpXXebC8Hm3pvlY
         zRqs5fYgX7cwOUp94rEqJ3FWlKRT6uvw7uFGSLUiO/Zmc6tbRtQ/2TgnLEIbE+ripjJm
         sdgWh6ospjum0oCeB6StkCSRbAljU0d1XO9J6SPo5vNojczLdZk4QJJme2/nchfDmsBG
         0jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567819; x=1738172619;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8iKYF3csT963Oh0FXrUrlrS8IS249puoLm4/xmteLU=;
        b=IY9myNE241AOZIBlTOzPidt616ckEpjc20+2N4xNxAyGMJ7mDcMD9sMZ8fwPgxMhpe
         B+lrl7NSN3Kh9EDU5pa4W0dgBusKT5AslmGMcJiq3USnFP1kcyUnRko+f63uihLwr8yc
         u5FegLhYUArmuS6GBSkhgdjhlC3F1MaoH39rXKlRA9Fc1+5noPsQFgyXXbXvpgCMsRzP
         jvxkuP9mayIu4rr7GnYmiTNaJXybuRhkA3/PFs/ZmQuwkhx28C89mF5QvG1fWoPu+MRE
         q5FLRg5zTLCiSbrqVKAUsGmUClYG46IVllQdE4/zrHj82A3Cw+bEA+Cmw4dwyuMcXEWc
         Ywzw==
X-Forwarded-Encrypted: i=1; AJvYcCWG9S6rr4Cfvml16swQJv5U448vzqR8lnnlwbeBpPfNk1rUxVtfQCWedYVn0TgVipU43BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98FHVDsVFugMBqMGkFkKnZo+cTnqF2rpkf8tM5U1lkMdrUqQr
	ZHULFucSOmZJjgGHItTDjNmKhdjb96CBqwg0ikEEF2sEocZ96r7ILIiiO5hd8pgq/at4jp/FHrL
	IX8a+dQ==
X-Google-Smtp-Source: AGHT+IEtRfnG1IrLEczd4lBlgALNrOa6BIlr7CTXw96GqaqmTOdAqOOF5wM1aeXH+2lC6ztXYgWsTiZsp3cM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a25:b291:0:b0:e3d:da4c:7981 with SMTP id
 3f1490d57ef6-e57b138d74bmr40604276.7.1737567819204; Wed, 22 Jan 2025 09:43:39
 -0800 (PST)
Date: Wed, 22 Jan 2025 09:43:02 -0800
In-Reply-To: <20250122174308.350350-1-irogers@google.com>
Message-Id: <20250122174308.350350-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 12/18] perf dso: Clean up read_symbol error handling
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ensure errno is set and return to caller for error handling. Unusually
for perf the value isn't negated as expected by
symbol__strerror_disassemble.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/capstone.c |  3 ++-
 tools/perf/util/dso.c      | 14 ++++++++++++--
 tools/perf/util/llvm.c     |  3 ++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index f103988184c8..032548828925 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -12,6 +12,7 @@
 #include "symbol.h"
 #include "thread.h"
 #include <dlfcn.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
 #include <string.h>
@@ -463,7 +464,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	buf = dso__read_symbol(dso, filename, map, sym,
 			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
-		return -1;
+		return errno;
 
 	/* add the function address and name */
 	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index a90799bed230..247e59605f26 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1697,6 +1697,7 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 
 	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
 		pr_debug("No BPF image disassembly support\n");
+		errno = EOPNOTSUPP;
 		return NULL;
 	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
 #ifdef HAVE_LIBBPF_SUPPORT
@@ -1715,6 +1716,7 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 		assert(len <= info_linear->info.jited_prog_len);
 #else
 		pr_debug("No BPF program disassembly support\n");
+		errno = EOPNOTSUPP;
 		return NULL;
 #endif
 	} else {
@@ -1725,26 +1727,34 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 			.ip = start,
 		};
 		u8 *code_buf = NULL;
+		int saved_errno;
 
 		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 		fd = open(symfs_filename, O_RDONLY);
+		saved_errno = errno;
 		nsinfo__mountns_exit(&nsc);
-		if (fd < 0)
+		if (fd < 0) {
+			errno = saved_errno;
 			return NULL;
+		}
 
-		if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0) {
+		if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) <= 0) {
 			close(fd);
+			errno = ENOENT;
 			return NULL;
 		}
 		buf = code_buf = malloc(len);
 		if (buf == NULL) {
 			close(fd);
+			errno = ENOMEM;
 			return NULL;
 		}
 		count = pread(fd, code_buf, len, data.offset);
+		saved_errno = errno;
 		close(fd);
 		if ((u64)count != len) {
 			free(code_buf);
+			errno = saved_errno;
 			return NULL;
 		}
 		*out_buf = code_buf;
diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index a28f130c8951..1607364ee736 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -9,6 +9,7 @@
 #include "srcline.h"
 #include "symbol.h"
 #include <dlfcn.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
 #include <unistd.h>
@@ -365,7 +366,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	buf = dso__read_symbol(dso, filename, map, sym,
 			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
-		return -1;
+		return errno;
 
 	init_llvm();
 	if (arch__is(args->arch, "x86")) {
-- 
2.48.1.262.g85cc9f2d1e-goog



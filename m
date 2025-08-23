Return-Path: <bpf+bounces-66336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F847B325D9
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 02:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B122B02727
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157241A5B8D;
	Sat, 23 Aug 2025 00:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Et0ONrYz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE53A19755B
	for <bpf@vger.kernel.org>; Sat, 23 Aug 2025 00:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909161; cv=none; b=TeQbC1UbBc+fh3UqZx18RmtFvKUnzSwbxY58r+7H4t6G8CLvjr8euIsPAHVwzv7aZwIs3aUhkw9LcgJCukntYaJj5LAmNOplo1Mw+gu+T4JF6veU08tc+kfGu4gzxkk5MaLYDoUjHqzffKSJ5jpvrTqfSuzOTpWIEjE7xgc2xsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909161; c=relaxed/simple;
	bh=GWOtu1t/RxChg6SCutGj+2xSmA0/8/DSnYIkVcOn91A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RCuGxlnRxTTtnfvKrEHDkWBJ+keoJL4qvqaXTTvAhWQ/18egn2bcaQeII718T5zsywvugfkJhHjU7D5eUC1Fgl20ZqhBLORMwb9OY8V/B9DT/w0zS4KyDhRt5QTDBiw+X5Eiyq3u3g4KcwdIaq8f/ZBOLfxiSFndFXZru6tqOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Et0ONrYz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-325228e9c12so1221227a91.1
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 17:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909159; x=1756513959; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGZPVvFltn2hif4rzsnR8vI4SCPhVrC0b2f8qajHQd8=;
        b=Et0ONrYzcn9octgs7nRgwUyWrhMhJeKCX7gSTWVjUBdndOSXAiSPHEdcnE8R1RbiZt
         sOgZX1NPTj+EGrQyFmtILrM/VfBX7cRirtcvpEwZs4o8OrWpsL0uzJ8snvRaKMDx5E6+
         mXRygSNyptAHdFo5vgOoVkK35sU6XPRpv+rmURvrMWoQHhHnUcufGkfsasyRaXyY7Zho
         ut17+Mppb2BPKCJcL6ptrFWXEQYXb3GlKsjCJuWkxINeNko63HMq1aBylULlbXL3jWum
         Wtv9ehAGI9oT/ceO7MdZqW/Zjogr7oUejpCQfsVK5kO1/8UC204GDWQt2CMXSbos/dFi
         rmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909159; x=1756513959;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGZPVvFltn2hif4rzsnR8vI4SCPhVrC0b2f8qajHQd8=;
        b=JsgVymf5uXal7FRff9mCMOQtNbjF/h86vg0rOVuPJCdubFmDI5WBH0f1oZgM5Hic0b
         kzQvRE45nlDGcA5srB82Pw2v4TkfX/sldPP8bM1Kn1BXafI5Lu9HLVXN9pcGnHFUt/GE
         cvB4SQPnFYqVRKUZ98O+ld5gRuLgRoXZ7mzhsvl6sVSDv+cCGizSJjxUekIk6208+QV9
         oc6WUcZ2Nl8LvBcv7S2QjDOm3S9JZ/oIAMgRbNkquOZdF9Bg5i8biHp2HyOanSOodJEL
         Bh+divmcU5DGNcML3waz06rG3Mov7DSQKzE6paXQYNnGytEy28CHznwUsvV5Sfy3jnPI
         pIoA==
X-Forwarded-Encrypted: i=1; AJvYcCXkUYF2L6LuN/jaYTiTI+OBxiCQZhPYLjLnWtSBHomAq0iApGsb+A/KBTn4+zCiDyTAVEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1gs1PAhBrtRUUU3B5PRLEsn0mWhWLIu6YxNZUInQz4MhtmSr
	ghGoLzJ4/6ZsaiUr9YIKFoB75ZC9PkLhttVd9m6olTCoMHDZslFaIT81XNW7sFqJOzL/BLzKfmS
	hqOY9ojUAMA==
X-Google-Smtp-Source: AGHT+IEAYyn8MnoCs7ci9R88Si+M25VoBVOTRZ+hlMPRzq35t3VjvUUYExahmk0Z8H9xhbWYZKKGEm9MENVy
X-Received: from pjbqj3.prod.google.com ([2002:a17:90b:28c3:b0:31c:2fe4:33ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52c3:b0:2fa:17e4:b1cf
 with SMTP id 98e67ed59e1d1-3251d471af8mr5719471a91.2.1755909159149; Fri, 22
 Aug 2025 17:32:39 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:32:01 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-6-irogers@google.com>
Subject: [PATCH v5 05/19] perf capstone: Remove open_capstone_handle
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
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

open_capstone_handle is similar to capstone_init and used only by
symbol__disassemble_capstone. symbol__disassemble_capstone_powerpc
already uses capstone_init, transition symbol__disassemble_capstone
and eliminate open_capstone_handle.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/capstone.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index dd58e574aa52..01e47d5c8e3e 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -137,33 +137,6 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
 #endif
 }
 
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
-static int open_capstone_handle(struct annotate_args *args, bool is_64bit, csh *handle)
-{
-	struct annotation_options *opt = args->options;
-	cs_mode mode = is_64bit ? CS_MODE_64 : CS_MODE_32;
-
-	/* TODO: support more architectures */
-	if (!arch__is(args->arch, "x86"))
-		return -1;
-
-	if (cs_open(CS_ARCH_X86, mode, handle) != CS_ERR_OK)
-		return -1;
-
-	if (!opt->disassembler_style ||
-	    !strcmp(opt->disassembler_style, "att"))
-		cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
-
-	/*
-	 * Resolving address operands to symbols is implemented
-	 * on x86 by investigating instruction details.
-	 */
-	cs_option(*handle, CS_OPT_DETAIL, CS_OPT_ON);
-
-	return 0;
-}
-#endif
-
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
 				  struct annotate_args *args, u64 addr)
@@ -309,6 +282,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	cs_insn *insn = NULL;
 	char disasm_buf[512];
 	struct disasm_line *dl;
+	bool disassembler_style = false;
 
 	if (args->options->objdump_path)
 		return -1;
@@ -333,7 +307,11 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 
 	annotation_line__add(&dl->al, &notes->src->source);
 
-	if (open_capstone_handle(args, is_64bit, &handle) < 0)
+	if (!args->options->disassembler_style ||
+	    !strcmp(args->options->disassembler_style, "att"))
+		disassembler_style = true;
+
+	if (capstone_init(maps__machine(args->ms.maps), &handle, is_64bit, disassembler_style) < 0)
 		goto err;
 
 	needs_cs_close = true;
-- 
2.51.0.rc2.233.g662b1ed5c5-goog



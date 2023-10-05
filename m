Return-Path: <bpf+bounces-11487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A8E7BAF08
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id CDEBBB20A61
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 23:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF026436A0;
	Thu,  5 Oct 2023 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y5CYriev"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C48843695
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:09:07 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E977C11C
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:08:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8997e79faeso2352115276.1
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 16:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547339; x=1697152139; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqO+Ua8t6nlwvlcHvKwWAEoEKjeWve4b13tLAZbDaS4=;
        b=y5CYrievUQqJddtm3FSnpLLnBc+12ItcewcwLI5BSIKVZzmjLaw15oYNWXpEWPbNqb
         1OefV/32exp7kzbcvh/ylAzZOem/GHN4NmQJFBrCj9G/8HpCSIg47vQmFPAvoHdywjs0
         Nyp/ErrLPeDmjiMGSbz84EsLRTXTRIi2EjFeii0BnkdQdsjIg2QQuRLIBU0t1jg6HYL+
         W5bMIZQgdNkCzYCDO368NZi2JVFt/4DE5HBCJqin4pqQKERZobffIam+Ye84BmjWhW7P
         d4obCpAKPWnhbkyuXhNAWdG7Mouh3ZvS1OnxqxTxZ2tbbgkAZUf19UK2qrGAhhbk42rw
         8BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547339; x=1697152139;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqO+Ua8t6nlwvlcHvKwWAEoEKjeWve4b13tLAZbDaS4=;
        b=UQpIXaaRSmojQXA2fQr1U77mXOVF0ydGKgar21OKZKGXY0EOS+iAm94wGvG+nUWHFv
         Ya6rFL25CKNSs0N81Ad0vCcZAfgTbtax2Md/+9naTwyxHOXHAXTcIUuT8jkz6+XvMEDX
         shgPAUpJJq7cXsqUi2oDl2jspYED0FRlJMJqGke+UmlcZR7wcTxEtN7pbFGmlLOe+IB9
         HAnm2aB5Khye0eGdO6lG4w4qrdlKDSi0lR7gzxLNp29ICWDppMJD+Mqk/zq5WRcM8W7P
         XiSOioFAuMhlfWy0bMwZKxXeQXsXCWIxIvV+f8R31aoNjF4xWy9SltSP25rkT5OSpjy9
         Q48Q==
X-Gm-Message-State: AOJu0YwRf7lmwfPYrZg/Cl6yv5sYYdbUaygZ8do9gHGMlj2XdnbZ/hQc
	7sCIKcSna/h77aZUeXih1FpW/9nE6vRJ
X-Google-Smtp-Source: AGHT+IG3kHmRqHWDft5tWM1zuYzngpqzvq67zhBHl4j2X94Z3ybhq4yxBzMt9WFB8IAAUgdjbeChJkU/HvMR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a25:868d:0:b0:d81:57ba:4d7a with SMTP id
 z13-20020a25868d000000b00d8157ba4d7amr80931ybk.6.1696547339163; Thu, 05 Oct
 2023 16:08:59 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:34 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 01/18] gen_compile_commands: Allow the line prefix to still
 be cmd_
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Builds in tools still use the cmd_ prefix in .cmd files, so don't
require the saved part. Name the groups in the line pattern match so
that changing the regular expression is more robust and works with the
addition of a new match group.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 scripts/clang-tools/gen_compile_commands.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index a84cc5737c2c..b43f9149893c 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -19,7 +19,7 @@ _DEFAULT_OUTPUT = 'compile_commands.json'
 _DEFAULT_LOG_LEVEL = 'WARNING'
 
 _FILENAME_PATTERN = r'^\..*\.cmd$'
-_LINE_PATTERN = r'^savedcmd_[^ ]*\.o := (.* )([^ ]*\.[cS]) *(;|$)'
+_LINE_PATTERN = r'^(saved)?cmd_[^ ]*\.o := (?P<command_prefix>.* )(?P<file_path>[^ ]*\.[cS]) *(;|$)'
 _VALID_LOG_LEVELS = ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
 # The tools/ directory adopts a different build system, and produces .cmd
 # files in a different format. Do not support it.
@@ -213,8 +213,8 @@ def main():
                 result = line_matcher.match(f.readline())
                 if result:
                     try:
-                        entry = process_line(directory, result.group(1),
-                                             result.group(2))
+                        entry = process_line(directory, result.group('command_prefix'),
+                                             result.group('file_path'))
                         compile_commands.append(entry)
                     except ValueError as err:
                         logging.info('Could not add line from %s: %s',
-- 
2.42.0.609.gbb76f46606-goog



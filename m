Return-Path: <bpf+bounces-11749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072EC7BE9C8
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 20:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA99281A7C
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EC0199D1;
	Mon,  9 Oct 2023 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJVw0PRw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71EC19451
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 18:39:33 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C79B7
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 11:39:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9299cac11aso5587970276.2
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876771; x=1697481571; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KnnQkZcbskEopBJnxGh+Vcp7ouLVD/1W8b2XeUOooQY=;
        b=rJVw0PRwWoWB1JfvSPLNZitx9J0lPvSXce12MjbCoJebzY1f9ObYixNey0ePBNFGfu
         k+lYGp4k8V7bZWyIhtZF87XDFupG6NLihJ/k8/6kLHwbifENW4htVxpYTIyzocosjnBD
         zi1BRAPqMy5DU/cb+BLUgRyLXV3jFcoQW5qaFBzzSbyhqCx7pgkBJouZ0CjLaixtELrp
         cxQ/xrh+S0k4ubh4VaeaDVdlkcuepGdD7Zyp51oQtxQBlLjvdiGNfUnFpfRM1xzmdXGM
         MO1x8FgShnL+xValM1rAQbHX/w8ozGFrtzMjX/rtNcAKSZhBmKazcwWpPPJ5C4y9eQuy
         /bwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876771; x=1697481571;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KnnQkZcbskEopBJnxGh+Vcp7ouLVD/1W8b2XeUOooQY=;
        b=WVk3mqBBKUM0ijP7EdhUyzFvy8ubbvV3T41Qe3L3Gt0wL4PHJVoi21gWVJgW7GIVz9
         ttoubLqtz6kG8iYqBd8a/bja1K0JR9oKEWD67B1tOuMvI+NMqysLSGk82DL3XTlRlAYD
         iyTtCptfQPl+9EnZ1GsM9+eLHP540gtUDEKbRW2KUqpZ14HNV48J7o9H4+k5goV0Fsam
         SKdyvdjyEU2sg5eykUgfD4gN+onk53qNQf4GCYX0cTAfTR7eYuKIh4G3JBbxOrVe4loy
         IKc3L47rsaomxtmCOMnFJSibZioKXp8aRcner+0+Wvqnkom78khbxUSpR6Y0vfWx+M6A
         6sNg==
X-Gm-Message-State: AOJu0Ywf3SjV+ynHKyrZaUQthx20ahAt+MDIJtwEejGn4HgV4KLn0+QJ
	pLzgLOpqmSsE6pGf5L8XjPQy0oCv5OS1
X-Google-Smtp-Source: AGHT+IGj936HBpMxd79H02f/BbU/72frkk4HM9RAto5NleLe3XJS2mgffVtBe63zJHi0k9rP3973otb4eFsT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a25:6881:0:b0:d89:4776:5d6b with SMTP id
 d123-20020a256881000000b00d8947765d6bmr254778ybc.5.1696876771177; Mon, 09 Oct
 2023 11:39:31 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:03 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 02/18] gen_compile_commands: Sort output compile commands
 by file name
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ming Wang <wangming01@loongson.cn>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make the output more stable and deterministic.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 scripts/clang-tools/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index b43f9149893c..180952fb91c1 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -221,7 +221,7 @@ def main():
                                      cmdfile, err)
 
     with open(output, 'wt') as f:
-        json.dump(compile_commands, f, indent=2, sort_keys=True)
+        json.dump(sorted(compile_commands, key=lambda x: x["file"]), f, indent=2, sort_keys=True)
 
 
 if __name__ == '__main__':
-- 
2.42.0.609.gbb76f46606-goog



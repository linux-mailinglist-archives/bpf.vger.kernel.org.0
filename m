Return-Path: <bpf+bounces-11488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F837BAF0A
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 92965B20AAD
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 23:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E4743696;
	Thu,  5 Oct 2023 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Z0reX4g"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD443697
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:09:08 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7754C134
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:09:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59ee66806d7so21705697b3.0
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 16:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547341; x=1697152141; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KnnQkZcbskEopBJnxGh+Vcp7ouLVD/1W8b2XeUOooQY=;
        b=0Z0reX4geR/cSknipaVM50KlvfEYYwo4gqWkdh+0Kxnm+ei7ORA6KATmihXv46NRiD
         odQSiVRni2UVxz3GFJihdgGtnaLj0DaEMhd9514EYS5BAYxzBUW/vkfpISY9StziFmQV
         KMYRXBHVoyUAvPrZIpK8lql5WIjs6/REwRuc9s1m3YTgcmL3QVU19SJSXKzX04vNUscn
         Rcb8Fq54cHIR/Q2j3LR7nS+I3U25dZ4fgtlepSj4TuvKgLMf/Qe35QB75hhWgqYOi662
         ic5iuHSx+1tuRRM1iFPJl4Jfhpw1VJjkvu+gaARkOOHIxw4aVGuhhEu2UZyERRUbTEzC
         W+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547341; x=1697152141;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KnnQkZcbskEopBJnxGh+Vcp7ouLVD/1W8b2XeUOooQY=;
        b=it3i64Gt9wUMxAp/qyLCLt8a2b4cYGWrEQ+niTncTb9XLHbWjcTqZkN+fFI0FqXbv+
         hQxBQQdXcLqix+0qwwi0F2E58HZVFeOEexXWy9d8hs/0WgHSbtQnr2y+DzHUaCAncImm
         rNtBStGq/o8MbVNVU1HUKza7+R/cHrpllOGPRoilhb5oJN4SFOHqdTrySBAOgcQiq11+
         JC5ZVw3T0ltvanmr6jHLSnu4IpRgqm16mJYXaxFVBduD/jByyDn7lg69Ura5dDmyxsxm
         uHHTwvWZIJkMswEQoPGplM+FRePvnP30eh9EyPouD49ajlabzJii4FvyIw2+L1+k/EEH
         3BLw==
X-Gm-Message-State: AOJu0Yx285mRgSqTYb25wP3ivBDEov22PiZ7sPbk2Uv4CkFMTqmnP1n5
	2NZI0LE/glmj4VHT8crz1Phs0VHIs3BG
X-Google-Smtp-Source: AGHT+IEq5EgGgGfFQhFuBi8DznGe/koY92/hRN8c1uDlC9VFhaJLStShPDnueShOCjNEO4Bz7a83VK6LLkIx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a5b:584:0:b0:d7b:94f5:1301 with SMTP id
 l4-20020a5b0584000000b00d7b94f51301mr103920ybp.9.1696547341616; Thu, 05 Oct
 2023 16:09:01 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:35 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 02/18] gen_compile_commands: Sort output compile commands
 by file name
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



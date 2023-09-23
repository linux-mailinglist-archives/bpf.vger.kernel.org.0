Return-Path: <bpf+bounces-10666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8872D7ABDDA
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 07:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 022F71F237F1
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 05:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC884C7A;
	Sat, 23 Sep 2023 05:35:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B114693
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 05:35:43 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DC81A1
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:35:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59e758d6236so54225257b3.1
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447341; x=1696052141; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sj6/NNUjZTKqDNZk1SrzqO39OG4waux/cevEfWDj9So=;
        b=wSpeEJoSnHeeMN/OFwKHmaYyMl0EnOFrXzlHb3EexqQjsrgk+ntB6zqLJVyy1P6y1t
         xUIo1eypAU0SCGR4oR3lV8pR+amWiDzQVtKOR2zXLhzK06beWvQWINcss6NmycJl9QLB
         EK00okbOTreMXq6AYeyTksE0I2Z+69ReD6+OInI56nzueVgl5LgYw32UjRIVLFoQwxk8
         scCN9+En+dqVgu3sFy+8kFoLHmkS45hWZvic4XDzC43T0oFAE6rAIX8StsT+MEayVW9V
         Ka+uEUDci2p/Fcuyv5qF+KWugxNc4K9Q7k+5nc8wzoD/ra+UMQyxidwvT4OMXh0AUkYj
         I9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447341; x=1696052141;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sj6/NNUjZTKqDNZk1SrzqO39OG4waux/cevEfWDj9So=;
        b=vsKIl7vPPM6F8rYKdkHIABBA2ZClDifSJKwSqWrZCWGJUdsio07hZJXwKEsy5m9d5s
         22dPBtf17sxnH5p2+ehPNpEKKMh1X+fZTa4W6YLQtLw9VcPCf3FRhIqjnD5PTBWODUPr
         dxyIO/IpxBusrh8Zv27e+bFysv8cXMTW720mE9HvNe7nN8dURHKF5mQxa9+vE4uHA9ma
         91HlMRF5/Ez9tO8TM9+KhzLfQbvAn1ueSZNWx9rj986psjCoi/uZTsr8IZhy81+K+iu8
         UpFMN27LJT4f6v7Dc78xmeP1s8zsM5YTsivZT/g+7j9uo8M9gCrAM7oU+XINgc1G8ScW
         qLOA==
X-Gm-Message-State: AOJu0Yz+mQqw5vzU3yY3n9skuh/LM2lfOynIj96fltGIoLmfzSMwJt55
	PGJDJLEjUxCeoNRJWK03VfaYO/tBSB09
X-Google-Smtp-Source: AGHT+IHbSzioQSTamsrTSTL4Bee/g9Pe12Cn5Z+M9ExBNqmPozrvsrmeb06sIAWOJ+A4bl9QoEI2702248Yo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a81:eb0d:0:b0:59b:ec33:ec6d with SMTP id
 n13-20020a81eb0d000000b0059bec33ec6dmr21490ywm.5.1695447341257; Fri, 22 Sep
 2023 22:35:41 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:34:59 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 02/18] gen_compile_commands: Sort output compile commands
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
	James Clark <james.clark@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev, 
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
2.42.0.515.g380fc7ccd1-goog



Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 467C8E3B9D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2019 21:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504308AbfJXTCZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Oct 2019 15:02:25 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:35042 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504298AbfJXTCX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Oct 2019 15:02:23 -0400
Received: by mail-yw1-f73.google.com with SMTP id t2so15228092ywd.2
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=98x/ZBLRTnMz91JDf+r9eCkgM4R/aoJz7oABA29poQw=;
        b=ZDhWZ5D7Wad+xuhdcDWVOwjHsUewHijXR4y/lysN14gT4QR+/zxGLfhiRxlGwAByFJ
         wvV2FnISzVdGITQXf0PO2HsO/HkwjZV7v2BE0VRLy04+b4hbSO4FKoY7WN4sz/JBP1ZV
         o3uEIPfSt625AEJBsANTLrgdPcGYLg6rMD08yGPhw2CvVkaj5YJyGZa4ERxFIT7hZQQx
         HeODyGP/Z5W+sz6bzgLTdAN+HCfRn7izfeYB2gAdWXzraeS/rDA+lGdfOdKktC7MJl0b
         YSufsmH3+5ztriU/uDRYbI53ZDXG2wUof1NI+EYLa+Zt3raRx1eQYkWBjgz3t8EjKwgQ
         YxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=98x/ZBLRTnMz91JDf+r9eCkgM4R/aoJz7oABA29poQw=;
        b=G2ueu7eofBOm1piZDNZDOtFqF9FpMaOlh0xX7xEGEqR6zjSxh6cBvIoP4Cv1VT73AV
         cyBofloXtW5ZhNVFW1cW7iv5tAJPgSml7nD1mf2HMxugBOiybBohVxy3xdFDC+E1JAzs
         F0DTkN8+H6brTGI4R+hX5UId35brW1qlV9u4V/gMbAUEbx0O7iQJqGy1tSH/uKrRcs3M
         i+DIdVUAmf6bP+Bb+6wdUwyHrRfSETweCv/ED23CaJ0di7BtywBJ6F09DTtQT8pcIv1U
         li+kMlpp062jCirDo514xCVbVhkVFotjFbuvJ1tfkyYXUS5r/Gd7Ja/irMSobjT9RGMZ
         m+sA==
X-Gm-Message-State: APjAAAXBpY8q2mDtlC9XCnVXVwxlnMIy1QkvGXbaIYn6ltmWG7pv7S68
        B7GUiTPB/aChhOXxBm7U2BkOrp++wcV3
X-Google-Smtp-Source: APXvYqy0z0w7HaNQVrFGbWenHVtVo7T0wRW7iIgngW02X25slgtdxq4MgrTgKqZ5Bo3fCcCgjigLNvemKmy6
X-Received: by 2002:a81:58d6:: with SMTP id m205mr8304346ywb.293.1571943740635;
 Thu, 24 Oct 2019 12:02:20 -0700 (PDT)
Date:   Thu, 24 Oct 2019 12:01:58 -0700
In-Reply-To: <20191024190202.109403-1-irogers@google.com>
Message-Id: <20191024190202.109403-6-irogers@google.com>
Mime-Version: 1.0
References: <20191023005337.196160-1-irogers@google.com> <20191024190202.109403-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v3 5/9] perf tools: avoid a malloc for array events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use realloc rather than malloc+memcpy to possibly avoid a memory
allocation when appending array elements.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 26cb65798522..545ab7cefc20 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -691,14 +691,12 @@ array_terms ',' array_term
 	struct parse_events_array new_array;
 
 	new_array.nr_ranges = $1.nr_ranges + $3.nr_ranges;
-	new_array.ranges = malloc(sizeof(new_array.ranges[0]) *
-				  new_array.nr_ranges);
+	new_array.ranges = realloc($1.ranges,
+				sizeof(new_array.ranges[0]) *
+				new_array.nr_ranges);
 	ABORT_ON(!new_array.ranges);
-	memcpy(&new_array.ranges[0], $1.ranges,
-	       $1.nr_ranges * sizeof(new_array.ranges[0]));
 	memcpy(&new_array.ranges[$1.nr_ranges], $3.ranges,
 	       $3.nr_ranges * sizeof(new_array.ranges[0]));
-	free($1.ranges);
 	free($3.ranges);
 	$$ = new_array;
 }
-- 
2.23.0.866.gb869b98d4c-goog


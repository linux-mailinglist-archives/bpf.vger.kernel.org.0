Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC8EA65F
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2019 23:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfJ3WfD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Oct 2019 18:35:03 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:56702 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfJ3WfB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Oct 2019 18:35:01 -0400
Received: by mail-pl1-f201.google.com with SMTP id k8so2208000pll.23
        for <bpf@vger.kernel.org>; Wed, 30 Oct 2019 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NBXoMPDHJVu6DlppqIY2kjj0WH1XM9PlNXSL9vxvGXc=;
        b=to6RZPB9HFoQbqmKAJUjZ3WJ1y220f1xnCCYFZnT8AHAyKvmI8iWBbzxYGOL4HqHKy
         1PmW2Bk89kqcN/6509Ht4gbojZ5Fh0aN5BFvIX8S68OJJTJ6Mff6wholdeCtt3kTjz3U
         w3vdMLOcc7/CbI89RYUlJHak4evKhlgVd+Rl/3BbdoruqPitAijXNWl5sHkS4nBHdEab
         ZSgXoFbdZZJmfYz/5M/8PUltrW61Xa7L/5ZyDlkdvZ+7Ga6yzrmZFGykRxZ7ShYVNaNP
         NJf+XleoCHdf0X22IRjQJPcYBshJ+diy+lRANqX0xK7jRsmAUBhOKu7lRtlqL9tBWAGB
         84HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NBXoMPDHJVu6DlppqIY2kjj0WH1XM9PlNXSL9vxvGXc=;
        b=pH0wQbZW0CHW6+k78B4+d5wIHvR81RoseRabVGXHoK6x6OLlJ4Dspx8oA9gPbjBEtQ
         OcDnwC1Y1Izz/om0ooO6dLhKbVCJ++y+WjKCMAa03b1p6vvd5hpN0mDN/lMIEfsGKzbJ
         7OnjYIi7dAIOyV5v+e30ojidBgNmhewFA23MgejL54QU5gus5rqaGvgaAYEHsCHp1Scs
         K6OPAeB7U5VYmwDVQjxj5cIw2e7GB9ct+CcigSJjXU0+i7iv/95KAqU7OzIcay7GKkvq
         q6uBBu1y3+mwAC1nCM3+zNAfo9xoeE9a8F0FXn7tiNIWMsVvLfhp5iYFeH3u4LJeiUrr
         Urfw==
X-Gm-Message-State: APjAAAX6JzWKzSvSiDvPlOmCLeLIEMeZ/yTaYtpF7zgSeXyILlMkVMTy
        70IcEft9e1pOxWB5EYvJ0yQJcN766Dh7
X-Google-Smtp-Source: APXvYqwFABu3kNyEZzoXKOLqzFswnHr6Oczw+2eZi3gXz92ar/LQWg0327BtdqSuK5s1slzmYFKaoRLbH4A8
X-Received: by 2002:a63:e145:: with SMTP id h5mr1976435pgk.447.1572474900839;
 Wed, 30 Oct 2019 15:35:00 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:34:41 -0700
In-Reply-To: <20191030223448.12930-1-irogers@google.com>
Message-Id: <20191030223448.12930-4-irogers@google.com>
Mime-Version: 1.0
References: <20191025180827.191916-1-irogers@google.com> <20191030223448.12930-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v5 03/10] perf tools: avoid a malloc for array events
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
index 5863acb34780..ffa1a1b63796 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -689,14 +689,12 @@ array_terms ',' array_term
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
2.24.0.rc1.363.gb1bccd3e3d-goog


Return-Path: <bpf+bounces-10669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBF47ABDE1
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 07:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4C177282574
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 05:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9F420F8;
	Sat, 23 Sep 2023 05:35:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F91BA53
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 05:35:51 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFD11B7
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:35:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d848694462aso4381547276.3
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447348; x=1696052148; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TUsgHG34tvRYixG1937P5Fi9+1duOaYRJoYEfUpa7o=;
        b=ac7U+/zovsVy7j2SNYIovLA3UTVgWwKkggpmvZy5N/ZOenXtldGk0iq5BsUEhfUvJh
         +QrxL21ZnLKxKmFLPi8WbF0mNVlKeOAVdbTybYw9jWt8IEakEV8CbXhtzt88E3WmZexb
         Z1L5hY210/5+lW2ZJHO9/Rd97HqpGf4XdAaXVrXMJU1HAxjwI6rwjh0pB49Y2APrsbjE
         DdNpJ95UeYLHgQEnTpK8frdOaIMZ8BqNfjq69W7adGekJUzDIJiZOFwF20gp5OyovTxU
         3YiItascMr1zE6XJqAdItnyiSJKWtZdM/ngBLPQZXKvLEahBcZH7FlEAH/2jgH50LK+j
         DmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447348; x=1696052148;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TUsgHG34tvRYixG1937P5Fi9+1duOaYRJoYEfUpa7o=;
        b=utQIFpeHpN6AnIu6YbodBIWgsgSRdlmwKhFr7E0DplDtmEeXzpXoWnDvDnaKd3ukyQ
         eelkRg2fkfX/REYkc6YjvWD+bH8GB2xiypZ+F+OlmMQRRm4ZZz8CM2PliLoZV+EEf+sq
         dq2pri2mgTJ0w63JBWQ4unaW/whgW5Vvf0YjnE8zhtKQb87cz8rkxK8fycmq9dJF5Gmv
         i4XjW0wAq28VypKoGVPKJ7/nfqQNzspQgx7w49V13VOuOpFk1cyWME/VzZjZWTQPURib
         dmboqpWMkxRa6JLCAemzEXE13L42NaBko4aQAo82/2VGhQGu+vSLK7XmTGTC2UO7REzS
         QqGA==
X-Gm-Message-State: AOJu0YwtJXG0+6GczX1P5LMB30sDJYyyy5oSsSW2oL6krQmApwkBMxq+
	s+XU0sPrxKIPdZfjt+dG9YxGI+wKdrlo
X-Google-Smtp-Source: AGHT+IEp4kbeLYXnxxqvZKp5O2vhys9x017pPzfHBmcwh+n5Yk8hZwya6+TOe1kFu1OjvjZAFx6MM0x3TpT1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a05:6902:a8c:b0:d80:6110:835e with SMTP id
 cd12-20020a0569020a8c00b00d806110835emr12073ybb.3.1695447348106; Fri, 22 Sep
 2023 22:35:48 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:02 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 05/18] perf bench uprobe: Fix potential use of memory after free
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

Found by clang-tidy:
```
bench/uprobe.c:98:3: warning: Use of memory after it is freed [clang-analyzer-unix.Malloc]
                bench_uprobe_bpf__destroy(skel);
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/uprobe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index 914c0817fe8a..5c71fdc419dd 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -89,6 +89,7 @@ static int bench_uprobe__setup_bpf_skel(enum bench_uprobe bench)
 	return err;
 cleanup:
 	bench_uprobe_bpf__destroy(skel);
+	skel = NULL;
 	return err;
 }
 
-- 
2.42.0.515.g380fc7ccd1-goog



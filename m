Return-Path: <bpf+bounces-1046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4885970CB64
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 22:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EE81C20BA7
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 20:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BA4174E4;
	Mon, 22 May 2023 20:41:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5D31642B
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 20:41:35 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BA9BB
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 13:41:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5653213f5c0so8014907b3.1
        for <bpf@vger.kernel.org>; Mon, 22 May 2023 13:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684788092; x=1687380092;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDof+QoJIpcW+bcC8mIq1dIhSy6Tx4m7myi7gPf3qCM=;
        b=hL4XZqmAmsZBqISb5cs2SY76dW2m/n3/dRqTTMYPVdlAsjXvYxhCKl/wYIuYN5dH1y
         M/Zgkcj29Ps7yZkdxvqlqLB071q0vvvwDPGSr8posF4+n+m/gUhclexIkD3Olk2KeqQV
         pTVYcM1HHnrL4uS435VahAb4o4/PTyTyKImzzctxQZvjJGnw4XTMrdTRjjKdnyjt0ZLi
         TIAogLgYmgvk031sY5cMg+7HCGNuWb8K3lzAN+pNqd33I//tCNpkQTjvyPsw67LorTaF
         hdFLUxCf9oAxG+uLPCDIzzVkbJwxtYLshP/HM2YZJzL+KgSUM1yh/o0jmt3XpS5ll4w6
         ztZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788092; x=1687380092;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDof+QoJIpcW+bcC8mIq1dIhSy6Tx4m7myi7gPf3qCM=;
        b=T58160VSXnhAwyq5pW28C+6fmBO2WWJjTjkaq+FTfaXf5dhXARXYKZH20PLdcTPgxT
         6LYD5VRFFQHRXnQbC8Q+QLCYvN2+NIsvbnsuWdD526QbY4PlmN1MEUG+Nuc/MvSkTlPW
         SL6wd9fupMEr3W2axe+IMvNeKXreLRl5ixisncYSBURbD+SgpujJfh2TNDaCqPhSHQT0
         4vojKVmzz6SIOxmD6Tb49R5b3lGrQK8iILlJHKiFF6HdYQaPDtiXJ3BzG4mLAKc3JoKJ
         rb9+Nqqs99SJuUDgKpAITJ6Wt3Px0bd2V/Jn6U63Ut3QRL0hyqfrps4rrHi3a9nhq2BD
         KghQ==
X-Gm-Message-State: AC+VfDyrNHIsLPhkMEyuRAKhsH2bZpPUSeqEFmeTVzstLLOnoKIEhTZC
	6ysucDYlFUDVJY98kIzk9Zrb+JwGLdJ5
X-Google-Smtp-Source: ACHHUZ6Ij6MmJUxaDx9xqk58WsfpUW60Sf6BCP5q+Vjx4RkK5eARDpLpq/+ExNmPLc2gquPDbKFREdVnHLrA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:33a6:6e42:aa97:9ab4])
 (user=irogers job=sendgmr) by 2002:a81:ad09:0:b0:559:e97a:cb21 with SMTP id
 l9-20020a81ad09000000b00559e97acb21mr7115495ywh.9.1684788092608; Mon, 22 May
 2023 13:41:32 -0700 (PDT)
Date: Mon, 22 May 2023 13:40:47 -0700
In-Reply-To: <20230522204047.800543-1-irogers@google.com>
Message-Id: <20230522204047.800543-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230522204047.800543-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 3/3] perf test: Add build tests for BUILD_BPF_SKEL
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add tests with and without generating vmlinux.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/make | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 8dd3f8090352..775f374d9345 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -69,6 +69,8 @@ make_clean_all      := clean all
 make_python_perf_so := $(python_perf_so)
 make_debug          := DEBUG=1
 make_nondistro      := BUILD_NONDISTRO=1
+make_bpf_skel       := BUILD_BPF_SKEL=1
+make_gen_vmlinux_h  := BUILD_BPF_SKEL=1 GEN_VMLINUX_H=1
 make_no_libperl     := NO_LIBPERL=1
 make_no_libpython   := NO_LIBPYTHON=1
 make_no_scripts     := NO_LIBPYTHON=1 NO_LIBPERL=1
@@ -136,6 +138,8 @@ endif
 run += make_python_perf_so
 run += make_debug
 run += make_nondistro
+run += make_build_bpf_skel
+run += make_gen_vmlinux_h
 run += make_no_libperl
 run += make_no_libpython
 run += make_no_scripts
-- 
2.40.1.698.g37aff9b760-goog



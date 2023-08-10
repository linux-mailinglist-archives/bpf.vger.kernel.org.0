Return-Path: <bpf+bounces-7488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93BE7780BA
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 20:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCA4281818
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 18:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F288922F09;
	Thu, 10 Aug 2023 18:49:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949B214FE
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 18:49:16 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A93273C
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 11:49:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5896bdb0b18so23079637b3.1
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691693352; x=1692298152;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAsvNbJV0xewLpRF082FT5wNDwT03/+fiaT2qH1TeCM=;
        b=LTICTcE8hNlmMkRTMYp+FBqxbDFL9VxGqxqFwVsETwRzlpfMVOHp4IwneSAJSBQkLW
         MR9vE7Rjc9bd3DeFHvMQP8MwP5RYD6a5WxQ3dvG5GDrq+CGWGrooh8LRg0e42SkY6AzY
         6VEb/wJdzpqLgkk7j+sSRWYsx/L83/0hyDnfCC3mfVYVYkiWjp5yPKYVIcDaoxKO4sYN
         dglRXksLGO1i0EsXt+LFA2SUAFs0jvlz62kG4mmRiThp2m1ODYM0xMJnyFu+1XmNkv5n
         smJbqbdBAdyl8ANQVK3LF4L8WuTZxBBNYLJN95pwCuwjNk36KloINZCo8EMe0Pt9vGEe
         Fg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691693352; x=1692298152;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAsvNbJV0xewLpRF082FT5wNDwT03/+fiaT2qH1TeCM=;
        b=LVX2CudMBGJ37rA3kGeOK4iE6VO5taaXNRaW7gzhR+P+qlfdcgT5gsm4PvYQ9C6PC+
         lSfrfMwR8LqVaEDGZhDhz3zPsK3ySWFz1xjwOB5ewxSV6DJzZ3BQFU9YCy9fFIrRMrHh
         dEwx2t3qLgtmHKh1Z0s6q4bOSglylKEgZAaWJdtyCNkUDb+9YXKwPgnKP9OvXAyc+OOi
         JQsMFJLgnIEeDdIJxWzQ8dlRNfoXj5ULTKFPVCcBOLBKsRqoXjDxV+XLp+QNO+Ho68CG
         2+ecPDVzA3aQ41oPZ+V7n7ayS6SYEUo3fGClUcMc1OVz2uuOgDgI7OAweqwBUhW7/2g4
         HN2w==
X-Gm-Message-State: AOJu0Yy84J3Um8ugWkhpCNpNrpBeSSZcBf2oCmAtGsuOgYiwIYGfFcAk
	JmCgwxvfLPhyvb2d/DnCjUuOguLGpl98
X-Google-Smtp-Source: AGHT+IHBdD4d2FEkNC8Rl2S0IuPwZraSrCdQGQrFkVvxGTI5IiXMSHQJ/2/nwp5UpXIZ9kZNRHwcozJrils6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:797f:302e:992f:97f2])
 (user=irogers job=sendgmr) by 2002:a81:7855:0:b0:586:e91a:46c2 with SMTP id
 t82-20020a817855000000b00586e91a46c2mr62264ywc.4.1691693351912; Thu, 10 Aug
 2023 11:49:11 -0700 (PDT)
Date: Thu, 10 Aug 2023 11:48:53 -0700
In-Reply-To: <20230810184853.2860737-1-irogers@google.com>
Message-Id: <20230810184853.2860737-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810184853.2860737-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH v1 4/4] perf trace: Tidy comments
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Fangrui Song <maskray@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Carsten Haitzler <carsten.haitzler@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, James Clark <james.clark@arm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>, Rob Herring <robh@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, Wang Nan <wangnan0@huawei.com>, 
	Wang ShaoBo <bobo.shaobowang@huawei.com>, YueHaibing <yuehaibing@huawei.com>, 
	He Kuang <hekuang@huawei.com>, Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now tools/perf/examples/bpf/augmented_syscalls.c is
tools/perf/util/bpf_skel/augmented_syscalls.bpf.c and not enabled as a
BPF event, tidy the comments to reflect this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/trace/beauty/beauty.h                  | 15 +++++++--------
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c    |  8 --------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 3d12bf0f6d07..788e8f6bd90e 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -67,15 +67,14 @@ extern struct strarray strarray__socket_level;
 /**
  * augmented_arg: extra payload for syscall pointer arguments
  
- * If perf_sample->raw_size is more than what a syscall sys_enter_FOO puts,
- * then its the arguments contents, so that we can show more than just a
+ * If perf_sample->raw_size is more than what a syscall sys_enter_FOO puts, then
+ * its the arguments contents, so that we can show more than just a
  * pointer. This will be done initially with eBPF, the start of that is at the
- * tools/perf/examples/bpf/augmented_syscalls.c example for the openat, but
- * will eventually be done automagically caching the running kernel tracefs
- * events data into an eBPF C script, that then gets compiled and its .o file
- * cached for subsequent use. For char pointers like the ones for 'open' like
- * syscalls its easy, for the rest we should use DWARF or better, BTF, much
- * more compact.
+ * tools/perf/util/bpf_skel/augmented_syscalls.bpf.c that will eventually be
+ * done automagically caching the running kernel tracefs events data into an
+ * eBPF C script, that then gets compiled and its .o file cached for subsequent
+ * use. For char pointers like the ones for 'open' like syscalls its easy, for
+ * the rest we should use DWARF or better, BTF, much more compact.
  *
  * @size: 8 if all we need is an integer, otherwise all of the augmented arg.
  * @int_arg: will be used for integer like pointer contents, like 'accept's 'upeer_addrlen'
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 70478b9460ee..0586c4118656 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -2,16 +2,8 @@
 /*
  * Augment the raw_syscalls tracepoints with the contents of the pointer arguments.
  *
- * Test it with:
- *
- * perf trace -e tools/perf/examples/bpf/augmented_raw_syscalls.c cat /etc/passwd > /dev/null
- *
  * This exactly matches what is marshalled into the raw_syscall:sys_enter
  * payload expected by the 'perf trace' beautifiers.
- *
- * For now it just uses the existing tracepoint augmentation code in 'perf
- * trace', in the next csets we'll hook up these with the sys_enter/sys_exit
- * code that will combine entry/exit in a strace like way.
  */
 
 #include <linux/bpf.h>
-- 
2.41.0.640.ga95def55d0-goog



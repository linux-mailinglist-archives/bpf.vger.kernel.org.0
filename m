Return-Path: <bpf+bounces-11490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E67B7BAF0B
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E2F9D282684
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 23:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5B6436BD;
	Thu,  5 Oct 2023 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhDVCBX4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F8436B6
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:09:13 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C3C11C
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:09:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59ee66806d7so21706867b3.0
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 16:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547349; x=1697152149; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2XqQMJ0GkpZoKYBOeb+AHUkFWOwFAfTNDekNOfqFv8=;
        b=dhDVCBX40y5B0cotpbQmfRlDiY983Jxw+B+ksE2VxDNGQrDNqQHwCSamlheGdTV0i4
         t0s+PAmnL/e+aU4zdEJLoS0St61Qc8CCAojtb7DPsl5Uk+AqtWsO26z8S1nPinspNIF2
         p4LqZDQcb5Cw7aEQnMnKgI/PODEyW1zxCZjVP355JrJF2W/aFOnTczx1uuK8jjtDTb/J
         u6BQF/8SA+GNQ0e8o+dTAk43PYDL2iBV84Llj1Dxd8vwxqWMmjWjA8jJrRbv3A6QK+3z
         b5uKJFJ4x9cHMYOyH//EsRPdrJ3WiYcBV/NeNOAC+9q5nAs1GNc8feFXgCMUOL3ICuqz
         cGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547349; x=1697152149;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2XqQMJ0GkpZoKYBOeb+AHUkFWOwFAfTNDekNOfqFv8=;
        b=QemKoDWWZ1RuBIuZjm3VXY7A/tAtaFb/nSVRnA2Bg251vhRa4Bx7VuC9t3rINlHZ+O
         kAiM3c5dxYb4wurotPS5w1wm+uBLxLpdoSQOAnSu8wUz+D3uCUMTN7gRqLJ5vxkaWJGb
         FcsexqCqhGhCAGsQmzTS7O/oDg+bMS4m1WszWiV0THFDylBFfHcraOr6n+3z1MJp7cq7
         s9JdxYyKgaDGL7aYAd38u7f1rz/g6zr2ZtpVkHXtCm2shmfSdPsyfcIe82eEMwomjqjQ
         eH2h/Xyz1A8yQgF46818V5o9s7hgsjpGm8QSKyn/IIPTIxSdP9D8H+vKQ6xdptln3mwo
         SmKA==
X-Gm-Message-State: AOJu0Yw6EKDc+vdQEOob7z0ULV8ys2OeTQTQca5exZ6jy19O2zNfgT1u
	t4qaNJ4pJkNY6Np0d292W7MvwGSYLmZE
X-Google-Smtp-Source: AGHT+IGfGlEcR5cafu/s4l0RQy8FE4MK3zRFkQ6Zp8BoRNaDEtxn5kvn9B3Xn4doaEJk2RCpa1Y7G/TCwC7Y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a81:a9c4:0:b0:59b:eace:d467 with SMTP id
 g187-20020a81a9c4000000b0059beaced467mr116956ywh.3.1696547348754; Thu, 05 Oct
 2023 16:09:08 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:38 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 05/18] perf bench uprobe: Fix potential use of memory after free
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
2.42.0.609.gbb76f46606-goog



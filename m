Return-Path: <bpf+bounces-10672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C0D7ABDE6
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 07:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 54328282BC2
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 05:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C7E4691;
	Sat, 23 Sep 2023 05:36:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117772116
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 05:35:59 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD43CE4A
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:35:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d77fa2e7771so4350565276.1
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447355; x=1696052155; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dlidEJ2kQokrDb8kn7wfdV/NkutdZ64KLuYSK3l+lfk=;
        b=0iMrAGF0iOdCZx3w6KXurMJEXCIoPDZGq69PwP02WL5MmrSjrz9RV9ifnvBRQrySBN
         3s1ezMBtlL5uYOGNUgG+F+Slr4TlXeRP6ugGJNUMMU1LPEMFAzgdtz5O/bo0dNUII1Ut
         FYvR9RCoPTwlKblLCNiki8ekoTXLTAAzQ0XRgQJlXXqP2JHDcG+1pCOh0ji+1hxH2LL8
         CYxc61y8sywDXnQWnEpzydu0DmjBihnVeySWZrX0zMrd1p1Fr1hKpLz39lYzFwRaPsDO
         qisb5CIP6cRg6FvxDArH3c1/IeS/OHLu+tegN5uTUYzfXehB5lqtK30tj0FqVTVvWQVn
         KO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447355; x=1696052155;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dlidEJ2kQokrDb8kn7wfdV/NkutdZ64KLuYSK3l+lfk=;
        b=C0MA+8NVRYe29rrtAVnANX7iWDpMb8ZIT0TxUImYc6Uf599NaYR0bSQduyi4O8ZBDh
         Agb5acfv9v3Nttd7j+Oi7uqGh+zW+jR64dmj0yej5VAxrErbaNJu8vNBQUEa5fETQVH2
         Wu2YmlW2aZDBO0o0V0yLH9r2dYCgcZ72wn93bIl4I5adpMeo8f3mkIpwdX/0fi+t2ijp
         C5rBEJ6VMcEHtq5Sz+jiKB+g0wBPtKQU6ajV5tkGt7cJjRsc9jhmS9Y06PP2LVyWU1Hk
         uuBwaXVSEPRiG0/EaYv29rFUYI2OphHSonZubE8ALJ8775lI4pzIZHiPNHsVHAXtbbKE
         5jSQ==
X-Gm-Message-State: AOJu0Ywq7sq8h2YIaQhgtJVmy4JInz0orzxao836Zley8/MtU/oaujCO
	4INz1uEnhZ5HZWmNEP2JK8i+K76NEMW6
X-Google-Smtp-Source: AGHT+IE5O/1uW/OzbQMR5RN6Xnw5h1anx/RzV4ErZJvmavBS84pg85VIDix3s20OM15IyOeG9FkrtyFxdmAF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a05:6902:161c:b0:d0e:e780:81b3 with SMTP
 id bw28-20020a056902161c00b00d0ee78081b3mr12406ybb.2.1695447354781; Fri, 22
 Sep 2023 22:35:54 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:05 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 08/18] perf jitdump: Avoid memory leak
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

jit_repipe_unwinding_info is called in a loop by jit_process_dump,
avoid leaking unwinding_data by free-ing before overwriting. Error
detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/jitdump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 6b2b96c16ccd..1f657ef8975f 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -675,6 +675,7 @@ jit_repipe_unwinding_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	jd->eh_frame_hdr_size = jr->unwinding.eh_frame_hdr_size;
 	jd->unwinding_size = jr->unwinding.unwinding_size;
 	jd->unwinding_mapped_size = jr->unwinding.mapped_size;
+	free(jd->unwinding_data);
 	jd->unwinding_data = unwinding_data;
 
 	return 0;
-- 
2.42.0.515.g380fc7ccd1-goog



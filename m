Return-Path: <bpf+bounces-11494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2267BAF0F
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 6FE82B20C17
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 23:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546FD436B9;
	Thu,  5 Oct 2023 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ydKxjYHy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13659436B5
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:09:24 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F9DD63
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:09:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a23ad271d7so23188407b3.1
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 16:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547356; x=1697152156; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GouG30KZVQtjqm6aov/swqA2g+y6OD5o5DKI6J9/hJA=;
        b=ydKxjYHy/+r3MmEk1WKAXHGcGhUSlEALRujuV8fZXUzyYkUXoOTRuBRx+QeQJOckMG
         mTTeVxR4gzbBXAFF/ZCKAdHtEDPYWVjnH47SF6EI4wBrS0AeIjO1edL5VuF7YVShxj1/
         o1fPhwUZCGOwfpzzWfLhaPF/at1IaPpxaW2g16ov4RYNrD1tBOo87BlHk13QaePpej2R
         JNYTaiBKhgIIeq4tLwCB0dE8FUovG8CFyl4kuxpw/90QasEoywvBmBvfL5Vdg1cIAgDv
         E7zx2AVYT9JUnvSUjlvZYFnC93WS2+RFDKr6CFoWAEYXLhZJna5l6JxzzborXQN+12+b
         pGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547356; x=1697152156;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GouG30KZVQtjqm6aov/swqA2g+y6OD5o5DKI6J9/hJA=;
        b=ik9MgNF6KEcsjHWUBSAiDKniATxrq+FsJzM0o47AX1gC5yNyStfmqWKJUBHg5FNfYZ
         tWBssdSTM1b5Unb23ShIILKBCdFEIZazovqLTkXllLiVbnkLWKpBpQZGTmY7KpNRS117
         a5cqH5/eyrukBYOZBRp9kr9i71fNBEq5mTh7L+4H3FGVqJL7k8V8VsBPhHlhNZGA9DqO
         x4yYTOULSZnfOJGEA0h9tWgpdxmIir8gTzmh/w19tH41Xk5hOvdEq3aAmVmBABd4oJy7
         X/yGrwpviTvrBNUAdz4bQoIa3jWQVmzucfLznOSkwseb0RHTIuNC39+6/Ts65eVuNbV/
         hsWg==
X-Gm-Message-State: AOJu0YwakLw6xIMPUYv20a5hUUChZDEFOxAVZ8ptXFw1W1FN0NHM2nKg
	FVUnohVDUy0tKOGEtjvb9P/CHf7RrQze
X-Google-Smtp-Source: AGHT+IGONU+OowDDx8a+TbL/FH+ObTrGvfI1GY50R5S+RVIAsaEN1VZNRoea3AVWMrrmFuuADHtm0K7HKpil
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a81:430c:0:b0:576:8cb6:62a9 with SMTP id
 q12-20020a81430c000000b005768cb662a9mr115006ywa.6.1696547355929; Thu, 05 Oct
 2023 16:09:15 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:41 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 08/18] perf jitdump: Avoid memory leak
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
2.42.0.609.gbb76f46606-goog



Return-Path: <bpf+bounces-8657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359FB788D43
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6619B1C20AFA
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB90E17AD6;
	Fri, 25 Aug 2023 16:41:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA3A1079A
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:41:57 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1DF2121;
	Fri, 25 Aug 2023 09:41:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bdc243d62bso8839825ad.3;
        Fri, 25 Aug 2023 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692981715; x=1693586515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3QJes05NERO623clvngPrcz5iKhTHEmajQSFREZ7RHQ=;
        b=jxoI1LtcqwdpP75jgx1mtveqD+kyGqFmGdEnkbMYOcHujRlLjYHHYhQYXblsfcddN3
         MSi5+QuNpaYQexiECkD6C9k1uvbjs/HEPj5BQjOGTNvWI66TDeL3m81b0kckF5TGbzau
         ayiRLNicgIvn9oPG3wc6zrIkaKp0LHISWiN+P+OsjyzwRFgpcyukZJ6PcwwRJ4DUcYLh
         K+l0EbeVOSRoHoF5dnCra7QREkZrvdD0/ZCKrDWKrrnVx/wSEJfmJMhHr7oqNCot5mTU
         nx0jvb2HfEdvn9Y6wyedZJ5sGsTLv5QYbGjXiSxx8o1Q1KN05CFfo9n7n2g2i+DXb0Pa
         u3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692981715; x=1693586515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QJes05NERO623clvngPrcz5iKhTHEmajQSFREZ7RHQ=;
        b=DCxvDGUG5at1sV/FGrzmf/tn9pjyOmc/vLH9FY6Bb+s3xW5KPNhQuersAhWWx1u1Pa
         BAT4EthPLfXPLaH0xzvQb+ShqUVszLYvf2gVpD3lyxsmNe/PBYUZygF+n88g4ohtlQdP
         sw+X8+mISQ0OEuXNGwz4/7GSEXFApY2vuQM8KzC1n94vygL8xqf8+S8jdREashhTtj/Y
         OdhZYP+bQUEGaZm9kGizNL5ApNq29Bkx39J7lk4zQUuFr3S7MVWLWiH7Wq7wdNB1nfRh
         TEL7GhQQ0S5a6CHsjcQxZCj9UHa9Vz/FvvXzdcSO5RO6Xyz9Zw1/UwTO283ZSWmeYITm
         33OQ==
X-Gm-Message-State: AOJu0YyfFsWMl//InjVDHd1H/zrKwJcC0Tbms9xuOU+2FqTPfj8DmG9x
	WeXIlxs9XkXyCK/r617j5pRz5VR4Kkk=
X-Google-Smtp-Source: AGHT+IF8i7jha5yussgSKZnvLHR2KUUvlM8uSielz0FaWw1Zw38xKLDQbajXkdl1d/zFB+agBHZJDg==
X-Received: by 2002:a17:902:e884:b0:1bc:3944:9391 with SMTP id w4-20020a170902e88400b001bc39449391mr19002224plg.25.1692981714726;
        Fri, 25 Aug 2023 09:41:54 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:a7ba:1788:3b00:4316])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b001a5fccab02dsm1938755plh.177.2023.08.25.09.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 09:41:54 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 1/3] perf test: Skip 6.2 kernel for bpf-filter test
Date: Fri, 25 Aug 2023 09:41:50 -0700
Message-ID: <20230825164152.165610-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The BPF sample filtering requires two kernel changes below:
 * bpf_cast_to_kernel_ctx() kfunc (added in v6.2)
 * setting perf_sample_data->sample_flags (finished in v6.3)

The perf tools can check bpf_cast_to_kernel_ctx() easily so it can
refuse BPF filters on those old kernels (v6.1 and earlier).  But
checking sample_flags appears to be difficult so current code won't
work on v6.2 kernel.  That's unfortunate but I don't know what's the
correct way to handle it.

For now, let's skip v6.2 kernels explicitly (if failed) in the test.

Fixes: 9575ecdd198a ("perf test: Add perf record sample filtering test")
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record_bpf_filter.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/record_bpf_filter.sh b/tools/perf/tests/shell/record_bpf_filter.sh
index e76ea861b92c..31c593966e8c 100755
--- a/tools/perf/tests/shell/record_bpf_filter.sh
+++ b/tools/perf/tests/shell/record_bpf_filter.sh
@@ -49,6 +49,12 @@ test_bpf_filter_basic() {
   fi
   if perf script -i "${perfdata}" -F ip | grep 'ffffffff[0-9a-f]*'
   then
+    if uname -r | grep -q ^6.2
+    then
+      echo "Basic bpf-filter test [Skipped unsupported kernel]"
+      err=2
+      return
+    fi
     echo "Basic bpf-filter test [Failed invalid output]"
     err=1
     return
-- 
2.42.0.rc1.204.g551eb34607-goog



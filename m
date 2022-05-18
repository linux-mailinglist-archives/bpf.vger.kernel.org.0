Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37D552C68D
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 00:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiERWrv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 18:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiERWrk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 18:47:40 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD551660A9;
        Wed, 18 May 2022 15:47:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id a9so1398342pgv.12;
        Wed, 18 May 2022 15:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z1uFAVp5XdqAsqLx9EOJ5fow9Z4hWpN//WzEgscyqLE=;
        b=fBLYm5nQkrulJpYuqInqIePkrrkle5Xz/TGqXIg7emfJIksvE5oo6jUTglIoDPl37F
         Taw0pNZU4Av4JhVBYDjpOAqrpBxKc9WXzckJnEgOSmPs6tgWHvmXeepIdbQx0odJO5uS
         UCY8HjLKxgYytwey/3wUVttqdsa85LrZBaLS6Yd5/cCmqSnaq/SYb9fq0fXe1v1oqxBK
         +htOZYS4h3n2aRsNyRVhsfwg6VoiWDIj62Ke5TnyGz+VO9gPQlnu7wGRaBFEoTXgSMkb
         lybadmtzGmFBrb89C9dS/uaq14UMWgieJnIPd3URaW+lHLIB1rQLElVu+tFnFAvHyjGk
         1TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Z1uFAVp5XdqAsqLx9EOJ5fow9Z4hWpN//WzEgscyqLE=;
        b=mCx6eheHuEpbpqNbTs6OTTht1UGaa5K9CnFntgp8Yypq52YMaGil158irxNTRfylhM
         ofzSX/tFrKlmN1KN5erA0ztP5z5UX/XRtAEDNKwpQCYNMvVifCoG7BVj2qDWgIc2n8nN
         seLScRjnwhzKdgcfcAchcPfpjdHXDyq5G6Jht/IpKOVTyRcthOqJQotF59OLSdhCFVn0
         uWSJuLZOTVlnSDR5MSf8Iid7Mu9XSsWcj37Kv2pS+o6dolAE8plVlX1O6z+HK+zBOfA1
         8anN98NuMiM3nY3htrmXdgoXXzrRv0FUwPSxIBz3BOCvVbHRaB6XzOgjHI6cdmc7P7ue
         t2MA==
X-Gm-Message-State: AOAM531L1PR0MOalbFXGmgV2YstX1hG4U+c+DogPvn00p+TQTAUCsemU
        10fodBJ9lPacFQnbwvNfrF4=
X-Google-Smtp-Source: ABdhPJwCafyFUhZ3nZq/yvh5UKIdujWhZkYuJ9C57bFPBhwiP9wXWuv4oXIaiSkjCGcqqZzgrHISFw==
X-Received: by 2002:a05:6a00:2908:b0:4fa:9297:f631 with SMTP id cg8-20020a056a00290800b004fa9297f631mr1859997pfb.3.1652914055231;
        Wed, 18 May 2022 15:47:35 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:a718:cbfe:31cb:3a04])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902aa9700b0015e8d4eb2besm2214100plr.264.2022.05.18.15.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:47:34 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: [PATCH 6/6] perf test: Add a basic offcpu profiling test
Date:   Wed, 18 May 2022 15:47:25 -0700
Message-Id: <20220518224725.742882-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220518224725.742882-1-namhyung@kernel.org>
References: <20220518224725.742882-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

  $ sudo ./perf test -v offcpu
   88: perf record offcpu profiling tests                              :
  --- start ---
  test child forked, pid 685966
  Basic off-cpu test
  Basic off-cpu test [Success]
  test child finished with 0
  ---- end ----
  perf record offcpu profiling tests: Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record_offcpu.sh | 60 +++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100755 tools/perf/tests/shell/record_offcpu.sh

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
new file mode 100755
index 000000000000..96e0739f7478
--- /dev/null
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+# perf record offcpu profiling tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+cleanup() {
+  rm -f ${perfdata}
+  rm -f ${perfdata}.old
+  trap - exit term int
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup exit term int
+
+test_offcpu() {
+  echo "Basic off-cpu test"
+  if [ `id -u` != 0 ]
+  then
+    echo "Basic off-cpu test [Skipped permission]"
+    err=2
+    return
+  fi
+  if perf record --off-cpu -o ${perfdata} --quiet true 2>&1 | grep BUILD_BPF_SKEL
+  then
+    echo "Basic off-cpu test [Skipped missing BPF support]"
+    err=2
+    return
+  fi
+  if ! perf record --off-cpu -e dummy -o ${perfdata} sleep 1 2> /dev/null
+  then
+    echo "Basic off-cpu test [Failed record]"
+    err=1
+    return
+  fi
+  if ! perf evlist -i ${perfdata} | grep -q "offcpu-time"
+  then
+    echo "Basic off-cpu test [Failed record]"
+    err=1
+    return
+  fi
+  if ! perf report -i ${perfdata} -q --percent-limit=90 | egrep -q sleep
+  then
+    echo "Basic off-cpu test [Failed missing output]"
+    err=1
+    return
+  fi
+  echo "Basic off-cpu test [Success]"
+}
+
+test_offcpu
+
+cleanup
+exit $err
-- 
2.36.1.124.g0e6072fb45-goog


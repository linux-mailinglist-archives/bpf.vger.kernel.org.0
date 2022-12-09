Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A6D6488D7
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 20:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiLITH6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 14:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiLITHn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 14:07:43 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474356441;
        Fri,  9 Dec 2022 11:07:37 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y17so5857500plp.3;
        Fri, 09 Dec 2022 11:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAU/j1NdwbvUI7spTdVmLXV+d6wFoRxuKA8kjpq/0+E=;
        b=QYEKC//N4gfLrm8aFH4teGNGwE5UrwqLs52KyKuUT76LejDrqWmphcWaZYFyjhECA+
         TZJ49uMAvsB1yPTNBuyUG7OdiLmrcImnM5gq9ZVcDTlHJJRHkh1jwHbphHNeCXGEFm3i
         Vkbhka5SA8PbmbmOrIhSTVUYXr6ihh3f7KiVblSLaPz32acZwxkiQBbEdptB2Ls8pg4m
         lubRcHW8lgwb2Jr1ri3unZ177hi94vHvw6x9wHqRLgETPZYXSJ6rWUhebYKRny4yY30O
         1+BLIyvvF8AOcXq5GsfSyU2nBxtJCWlQEZwRQb+XbQcKYgxpIuYWJbmk6WK/N5rDv5Lj
         itdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JAU/j1NdwbvUI7spTdVmLXV+d6wFoRxuKA8kjpq/0+E=;
        b=ImhZpiH2sQZ8QVM7BhuEmF28BJu/CyaoAq5yFQfQD5b53ucftGYyemJIC3CwaGIARm
         p5wg7alrEXWZld9w/Tpsmz3TO7c93Y5UXwKgqT+IWMacY04dwe9OFwebJi+sOzirrBis
         l4eTw/adeq9JcmSQSnYsvGjqAsnRn5OEG+jNwqn1V/6tjLuJZ6Le+dAbo8JNm32MwrEG
         xjvyEnGn3BeRFnmDNYA3vPDRct+bt9ejo/eK01g9KRDtzdZiGJHUkmCjR6y3JhDr7YAF
         ryKqfmqh+OR23/TWcay6nMCR4XY7sn+i0HZiXEK/lyOuXkUPxneYYvwClKB6aRMfALuN
         JpZg==
X-Gm-Message-State: ANoB5pk9hfbnYdxQu3aM87uWdSHbRTPLqoqql8QIUNUGaZUsdiMNn+RJ
        /3wQz1ziT3z+3W0TeBnRQTU=
X-Google-Smtp-Source: AA0mqf4IZ4uSmOpdJ4yd9rCzWpAiCyihPyyM5pmrtlLy7TzxOhoOCIg81lc5XbVmw8G+8PBjrrB6eA==
X-Received: by 2002:a17:90a:8684:b0:219:68f8:7aaa with SMTP id p4-20020a17090a868400b0021968f87aaamr6785914pjn.40.1670612856682;
        Fri, 09 Dec 2022 11:07:36 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:c952:d848:9e00:3cce])
        by smtp.gmail.com with ESMTPSA id nd17-20020a17090b4cd100b002135de3013fsm1431432pjb.32.2022.12.09.11.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:07:36 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org
Subject: [PATCH 4/4] perf test: Update perf lock contention test
Date:   Fri,  9 Dec 2022 11:07:27 -0800
Message-Id: <20221209190727.759804-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221209190727.759804-1-namhyung@kernel.org>
References: <20221209190727.759804-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add test cases for the task and addr aggregation modes.

  $ sudo ./perf test -v contention
   86: kernel lock contention analysis test                            :
  --- start ---
  test child forked, pid 680006
  Testing perf lock record and perf lock contention
  Testing perf lock contention --use-bpf
  Testing perf lock record and perf lock contention at the same time
  Testing perf lock contention --threads
  Testing perf lock contention --lock-addr
  test child finished with 0
  ---- end ----
  kernel lock contention analysis test: Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lock_contention.sh | 48 +++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index f7bd0d8eb5c3..cc9ceb9e19ca 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -77,10 +77,58 @@ test_record_concurrent()
 	fi
 }
 
+test_aggr_task()
+{
+	echo "Testing perf lock contention --threads"
+	perf lock contention -i ${perfdata} -t -E 1 -q 2> ${result}
+	if [ $(cat "${result}" | wc -l) != "1" ]; then
+		echo "[Fail] Recorded result count is not 1:" $(cat "${result}" | wc -l)
+		err=1
+		exit
+	fi
+
+	if ! perf lock con -b true > /dev/null 2>&1 ; then
+		return
+	fi
+
+	# the perf lock contention output goes to the stderr
+	perf lock con -a -b -t -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
+	if [ $(cat "${result}" | wc -l) != "1" ]; then
+		echo "[Fail] BPF result count is not 1:" $(cat "${result}" | wc -l)
+		err=1
+		exit
+	fi
+}
+
+test_aggr_addr()
+{
+	echo "Testing perf lock contention --lock-addr"
+	perf lock contention -i ${perfdata} -l -E 1 -q 2> ${result}
+	if [ $(cat "${result}" | wc -l) != "1" ]; then
+		echo "[Fail] Recorded result count is not 1:" $(cat "${result}" | wc -l)
+		err=1
+		exit
+	fi
+
+	if ! perf lock con -b true > /dev/null 2>&1 ; then
+		return
+	fi
+
+	# the perf lock contention output goes to the stderr
+	perf lock con -a -b -t -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
+	if [ $(cat "${result}" | wc -l) != "1" ]; then
+		echo "[Fail] BPF result count is not 1:" $(cat "${result}" | wc -l)
+		err=1
+		exit
+	fi
+}
+
 check
 
 test_record
 test_bpf
 test_record_concurrent
+test_aggr_task
+test_aggr_addr
 
 exit ${err}
-- 
2.39.0.rc1.256.g54fd8350bd-goog


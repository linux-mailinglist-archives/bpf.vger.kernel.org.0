Return-Path: <bpf+bounces-9015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A29B578E2FF
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 01:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0A0280E4D
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 23:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F22F8F4A;
	Wed, 30 Aug 2023 23:02:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52B8C1E
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 23:02:00 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57ACCC;
	Wed, 30 Aug 2023 16:01:38 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68c576d35feso148811b3a.2;
        Wed, 30 Aug 2023 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693436496; x=1694041296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvBgmxNy928oacmNI77J4OtVBnWVUvcPN3MQLBE4mjE=;
        b=RNqyd+CjUxd1VCUxYpKJu7MucmcDE3KkwijUACz+G5V9Lhn42bdAbKtePfdhEn7vuC
         IPlSuOYjiXpW/JNUZYIDt0YxzH8hb/q6pJuM6AKZVMjxjNowCv7mhEaf0GNXISmpvDae
         Wv5zDw3Vxv/XBrpeg94iihJLAFJcJHNo4fxqI5fgp7u53l1EGt4hvbglX7+RBGFZePN8
         Uj2ftcYPEsodhJ5ggvL974gCeG5cSi6gq47t6oxgDxU/0S7CYCHnIbc7R1IQ1AkP/FNQ
         kRB5E3HfpBe5ZsRunU09dUq0oKWGOW1QI7p0svng+jk7QLtWiwADqAgAHkp/PLskttS/
         i+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693436496; x=1694041296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZvBgmxNy928oacmNI77J4OtVBnWVUvcPN3MQLBE4mjE=;
        b=Bko1CsrG+LdjLJr379xYylOmzescVKiuD5Fb3j+z4b0s2dMqbvspR9zMNZp0RzvHxV
         QWrv+smhZz7WXqdj2zAW1ZWHoDVWKXtM0q3Th/enI+omyg4gJuctClMcKYeG98u+RKVO
         GIS31KMrXkelovuuKihXgOx1JNrHkafQqT2ViR+3+TvGY9fE289avzpvYnlJFni4Eaeg
         wOvDkUBwJW4ySx5THtDt9/wH1AMRq84MedIk7Z+8t5oYT8wNdncb/x8HSaxLLD61ma1s
         BS7JaEPJU4w3BOlxBzLgmEFyOQ8jH/un5trvWQKuLFK8v+rRQxVj5orjqJYVdV6Gvgab
         pyIw==
X-Gm-Message-State: AOJu0YwUYal6j8WMjWNMKAvkbSqOucvPUkNvFCP2PoPzfNifWk+tzUa2
	C0slHPO9f3V0JciKbI6rutA=
X-Google-Smtp-Source: AGHT+IFpmKYs7Zw0+pm0J10242Ax3PiMji8ib4QqZ3UTtY7hUmsedOoS6Y5fP90od5L+sEgDk0InWw==
X-Received: by 2002:a05:6a20:4cf:b0:137:5a89:daf5 with SMTP id 15-20020a056a2004cf00b001375a89daf5mr3406430pzd.28.1693436496062;
        Wed, 30 Aug 2023 16:01:36 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:4366:cd91:1c34:2aa7])
        by smtp.gmail.com with ESMTPSA id j13-20020aa7928d000000b00689f8dc26c2sm92531pfa.133.2023.08.30.16.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:01:35 -0700 (PDT)
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
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	bpf@vger.kernel.org
Subject: [PATCH 5/5] perf test: Improve perf lock contention test
Date: Wed, 30 Aug 2023 16:01:26 -0700
Message-ID: <20230830230126.260508-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230830230126.260508-1-namhyung@kernel.org>
References: <20230830230126.260508-1-namhyung@kernel.org>
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

Add cgroup aggregation and filter tests.

  $ sudo ./perf test -v contention
   84: kernel lock contention analysis test                            :
  --- start ---
  test child forked, pid 222423
  Testing perf lock record and perf lock contention
  Testing perf lock contention --use-bpf
  Testing perf lock record and perf lock contention at the same time
  Testing perf lock contention --threads
  Testing perf lock contention --lock-addr
  Testing perf lock contention --lock-cgroup
  Testing perf lock contention --type-filter (w/ spinlock)
  Testing perf lock contention --lock-filter (w/ tasklist_lock)
  Testing perf lock contention --callstack-filter (w/ unix_stream)
  Testing perf lock contention --callstack-filter with task aggregation
  Testing perf lock contention --cgroup-filter
  Testing perf lock contention CSV output
  test child finished with 0
  ---- end ----
  kernel lock contention analysis test: Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lock_contention.sh | 45 +++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index d120e83db7d9..966e67db75f3 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -123,6 +123,24 @@ test_aggr_addr()
 	fi
 }
 
+test_aggr_cgroup()
+{
+	echo "Testing perf lock contention --lock-cgroup"
+
+	if ! perf lock con -b true > /dev/null 2>&1 ; then
+		echo "[Skip] No BPF support"
+		return
+	fi
+
+	# the perf lock contention output goes to the stderr
+	perf lock con -a -b -g -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
+	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
+		echo "[Fail] BPF result count is not 1:" "$(cat "${result}" | wc -l)"
+		err=1
+		exit
+	fi
+}
+
 test_type_filter()
 {
 	echo "Testing perf lock contention --type-filter (w/ spinlock)"
@@ -232,6 +250,31 @@ test_aggr_task_stack_filter()
 		exit
 	fi
 }
+test_cgroup_filter()
+{
+	echo "Testing perf lock contention --cgroup-filter"
+
+	if ! perf lock con -b true > /dev/null 2>&1 ; then
+		echo "[Skip] No BPF support"
+		return
+	fi
+
+	perf lock con -a -b -g -E 1 -F wait_total -q -- perf bench sched messaging > /dev/null 2> ${result}
+	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
+		echo "[Fail] BPF result should have a cgroup result:" "$(cat "${result}")"
+		err=1
+		exit
+	fi
+
+	cgroup=$(cat "${result}" | awk '{ print $3 }')
+	perf lock con -a -b -g -E 1 -G "${cgroup}" -q -- perf bench sched messaging > /dev/null 2> ${result}
+	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
+		echo "[Fail] BPF result should have a result with cgroup filter:" "$(cat "${cgroup}")"
+		err=1
+		exit
+	fi
+}
+
 
 test_csv_output()
 {
@@ -275,10 +318,12 @@ test_bpf
 test_record_concurrent
 test_aggr_task
 test_aggr_addr
+test_aggr_cgroup
 test_type_filter
 test_lock_filter
 test_stack_filter
 test_aggr_task_stack_filter
+test_cgroup_filter
 test_csv_output
 
 exit ${err}
-- 
2.42.0.283.g2d96d420d3-goog



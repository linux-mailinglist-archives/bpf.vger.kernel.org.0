Return-Path: <bpf+bounces-9351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0AE794242
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 19:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFDD1C20A65
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 17:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529A1111AA;
	Wed,  6 Sep 2023 17:49:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2B11192
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 17:49:14 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E9719AB;
	Wed,  6 Sep 2023 10:49:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-26f3e26e55aso55960a91.3;
        Wed, 06 Sep 2023 10:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694022552; x=1694627352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sREEdJnLV25PRgE9rZctlCHLNA0dfro01PxzCPskaGg=;
        b=cqZnzUjqkFnXxuDHNehdFAtsTnFrWzXe7+jEKVi+EFz09VxOCnmiA4OD3UZo7D8mzR
         6i8QoSMAx0Uo6/FgrXYkNK0D2tjFUDAVeCw0eJy12NzZnpKFjmsh6gqdzWIP9ibEGo1F
         QY8TgBFfw2pG1ZBeyx90Syn9DwG/1giACV6kdrmfGAYyvHNddaaseMvVH+g5Sx3M/JUX
         fepLHY2ZEvq7ikS214V6isw/lJ+t2oevJZMPPF2epTvnSh1Rrbxu/zAUOhRUbuHQ3EM2
         WRQHcYFEbH7Dzp3SCXIjHfV16euxzJ8QbR1pUJQ+9eYqSa8pNquQLbeiNM1tL6wUkBRr
         y4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694022552; x=1694627352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sREEdJnLV25PRgE9rZctlCHLNA0dfro01PxzCPskaGg=;
        b=VQ7LrB62OsXAH90K1yf6IZtIniN/T8wnNdJcytHvhm269PNQU1BjA1mD5onBMj2c+h
         9pyXDzrd53t4GoCw42/rAuvbuiggYNDinL51xRkKXc84xxjikvgT3/wmHdEUKLUUHL26
         RV78g/ogpkqOLXjklgRi8OT6sMKqGodc0zfAzgOdHbw22rm9orV936V0Y5mSe2ogkFlO
         I/aKZMua7V/q1Bhb06bsfUhvF+oZIvDR6h7v3IgfMa+25sIYwxg2OHVT/fN0fYHrVj8B
         ILQG60Bx7DQlWzDkEXLHIh1JxbQqAq+j9bxpi7/utZgWQWOR5YpxHyu5QWuTNHm4bWmG
         NHQQ==
X-Gm-Message-State: AOJu0YyaQE6wu/bFP6pEecgx9R5GoYlFo4g9coAhOpX4+l2pFSVY38q2
	5f687yGW1IzP1+G/8nO+UzU=
X-Google-Smtp-Source: AGHT+IHLhl3/DR8t3gDwlwd9D+ssr1P6JOXbRwZvboLp+3yqpHPYpZ1qzegv1uKe9S5ZlaimsBJAOA==
X-Received: by 2002:a17:90a:898d:b0:263:9661:a35c with SMTP id v13-20020a17090a898d00b002639661a35cmr13834087pjn.8.1694022551829;
        Wed, 06 Sep 2023 10:49:11 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:5035:1b47:9a3f:312c])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090ad30b00b00262eccfa29fsm63564pju.33.2023.09.06.10.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 10:49:11 -0700 (PDT)
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
Date: Wed,  6 Sep 2023 10:49:03 -0700
Message-ID: <20230906174903.346486-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230906174903.346486-1-namhyung@kernel.org>
References: <20230906174903.346486-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
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

Reviewed-by: Ian Rogers <irogers@google.com>
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



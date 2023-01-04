Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8115565CD46
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 07:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjADGoZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 01:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjADGoN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 01:44:13 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCFB2E5;
        Tue,  3 Jan 2023 22:44:12 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o21so5092701pjw.0;
        Tue, 03 Jan 2023 22:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bliKfRbQDwAdV97iBZEDSuzGn0Y1LH+Sf/kDY4qOSE=;
        b=cxIOOkUt8IWLH0cIGaDmPPocHS4+b8nZeOZSKJTwIzIioIzzrJEWbsBdB20yQSLTiB
         rv8aZVuBiQlm99kquR8FaBb5qXjzD79AkKjTdku4QyfvVOwmu8K78HoD/z1UNroLYNP5
         uvhs7YDAwdb/IZ9WOWNum7qPngiGL0EOxJHL5VqnCJFRbY3AhYhmuDygjdIqjcS3vLHB
         5Iq7jDnCGpfFyzMHVh47Q0pUyrTzYlbqy9HNk5ZUuHdSiePuspbY78ZhES0RlLlYoiaY
         7C6x/p60oVKAZENXtwlbtXZ4qsjWf0yKWuQmEQX7N3WZ8qyYmTDPAx6YW9zPCi4QPykU
         2eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+bliKfRbQDwAdV97iBZEDSuzGn0Y1LH+Sf/kDY4qOSE=;
        b=3Mp2WTqkhoHjIxIR+9ORj+TBZL16Xc60e1/Q/sKuFFM+uLUcO/h0jdcq8DprogvWIw
         UfQE5nV1f8JS8vOJil6mE0DCYRa+JMNq+9TWPPlHv7O/xiYAoneSzeuNekm8P+n2kXDm
         us6ALSvGpeSk8N9cAYZp/wXuOH7M3f9jEPToqUsGiDj/SEzqrkUgtzM1JFYpV8tEdPYD
         f7jO5BiSqeEMk+04GsTpeDDrndI8CuvJP0zc5gcFWqPcKbSwqyMgtsrqz3d14SH6Gy8E
         +b6E3Va5+bmnx988VWHivGnX5NUzSD5X7BYszdqFh5lcUnaPvQGWOhA56d/2m1O2C60A
         hK6w==
X-Gm-Message-State: AFqh2kosCJs5JRPHsQ/cl2XDeORLQIxQjQgmkYyNJo2Qwe32q1JaUDih
        D5sgBbDWWho8M85BmT+jwzM=
X-Google-Smtp-Source: AMrXdXtBbMbi88hRDwiINdwpS40V2CHVQ+KcNL2U0hUv4HmmvG5LPPknJ0oCV8HBTVfS8GQyPNf4Rw==
X-Received: by 2002:a05:6a20:659d:b0:b0:275d:3036 with SMTP id p29-20020a056a20659d00b000b0275d3036mr56741439pzh.24.1672814651855;
        Tue, 03 Jan 2023 22:44:11 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:d1f4:a47f:3a41:e1a2])
        by smtp.gmail.com with ESMTPSA id e28-20020a056a0000dc00b00576f7bd92cdsm11829257pfj.14.2023.01.03.22.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 22:44:11 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: [PATCH 4/4] perf stat: Do not use the same cgroup more than once
Date:   Tue,  3 Jan 2023 22:44:02 -0800
Message-Id: <20230104064402.1551516-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230104064402.1551516-1-namhyung@kernel.org>
References: <20230104064402.1551516-1-namhyung@kernel.org>
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

The --for-each-cgroup can have the same cgroup multiple times, but it makes
bpf counters confused (since they have the same cgroup id), and the last
cgroup events are counted only.  Let's check the cgroup name before adding
a new entry.

Before:
  $ sudo ./perf stat -a --bpf-counters --for-each-cgroup /,/ sleep 1

   Performance counter stats for 'system wide':

       <not counted> msec cpu-clock                        /
       <not counted>      context-switches                 /
       <not counted>      cpu-migrations                   /
       <not counted>      page-faults                      /
       <not counted>      cycles                           /
       <not counted>      instructions                     /
       <not counted>      branches                         /
       <not counted>      branch-misses                    /
            8,016.04 msec cpu-clock                        /                #    7.998 CPUs utilized
               6,152      context-switches                 /                #  767.461 /sec
                 250      cpu-migrations                   /                #   31.187 /sec
                 442      page-faults                      /                #   55.139 /sec
         613,111,487      cycles                           /                #    0.076 GHz
         280,599,604      instructions                     /                #    0.46  insn per cycle
          57,692,724      branches                         /                #    7.197 M/sec
           3,385,168      branch-misses                    /                #    5.87% of all branches

         1.002220125 seconds time elapsed

After:
  $ sudo ./perf stat -a --bpf-counters --for-each-cgroup /,/  sleep 1

   Performance counter stats for 'system wide':

            8,013.38 msec cpu-clock                        /                #    7.998 CPUs utilized
               6,859      context-switches                 /                #  855.944 /sec
                 334      cpu-migrations                   /                #   41.680 /sec
                 345      page-faults                      /                #   43.053 /sec
         782,326,119      cycles                           /                #    0.098 GHz
         471,645,724      instructions                     /                #    0.60  insn per cycle
          94,963,430      branches                         /                #   11.851 M/sec
           3,685,511      branch-misses                    /                #    3.88% of all branches

         1.001864539 seconds time elapsed

Fixes: bb1c15b60b981 ("perf stat: Support regex pattern in --for-each-cgroup")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/cgroup.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index e99b41f9be45..cd978c240e0d 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -224,6 +224,19 @@ static int add_cgroup_name(const char *fpath, const struct stat *sb __maybe_unus
 	return 0;
 }
 
+static int check_and_add_cgroup_name(const char *fpath)
+{
+	struct cgroup_name *cn;
+
+	list_for_each_entry(cn, &cgroup_list, list) {
+		if (!strcmp(cn->name, fpath))
+			return 0;
+	}
+
+	/* pretend if it's added by ftw() */
+	return add_cgroup_name(fpath, NULL, FTW_D, NULL);
+}
+
 static void release_cgroup_list(void)
 {
 	struct cgroup_name *cn;
@@ -242,7 +255,7 @@ static int list_cgroups(const char *str)
 	struct cgroup_name *cn;
 	char *s;
 
-	/* use given name as is - for testing purpose */
+	/* use given name as is when no regex is given */
 	for (;;) {
 		p = strchr(str, ',');
 		e = p ? p : eos;
@@ -253,13 +266,13 @@ static int list_cgroups(const char *str)
 			s = strndup(str, e - str);
 			if (!s)
 				return -1;
-			/* pretend if it's added by ftw() */
-			ret = add_cgroup_name(s, NULL, FTW_D, NULL);
+
+			ret = check_and_add_cgroup_name(s);
 			free(s);
-			if (ret)
+			if (ret < 0)
 				return -1;
 		} else {
-			if (add_cgroup_name("", NULL, FTW_D, NULL) < 0)
+			if (check_and_add_cgroup_name("/") < 0)
 				return -1;
 		}
 
-- 
2.39.0.314.g84b9a713c41-goog


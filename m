Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56C75B3E40
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 19:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiIIRwr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 13:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiIIRwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 13:52:45 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ABB12BF9B;
        Fri,  9 Sep 2022 10:52:44 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c24so2240464pgg.11;
        Fri, 09 Sep 2022 10:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=9ehd9/6UapbHdanxJIohnP32ZiPMfDsE+vEMO9Oxisw=;
        b=GdQO7MFZo/mvI9h+l7XEm/Wp1hfXEkCTy2o2tcY5spbLZdcRdWqBZzqcD1O3ISOJIS
         2U61C2nKU63VkvHRyW4Zs3jGvv1amQPSbFdU8c3NBcCdWC3O8YBIQyatXvSNesg40TuF
         wydSJF9JtQWJnAajdyzcL0Gwlc6cuj12yJuqRbByyC8auEX2QVFWhXadyLeCWXMR5QgL
         8AmhhTiOG6rOarPggi5fbS3xOoWEEK9VExL5teE4qmInqO6i+KjLxPdP/7nq3mNCpxVP
         Bdw6riQ4Nm4hvAaTVuuWaE7O4UotWH6hq9RtY2qLmkapG/6YwLL+DbBEiQsY+oJGeHOu
         9mtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=9ehd9/6UapbHdanxJIohnP32ZiPMfDsE+vEMO9Oxisw=;
        b=3KkKNnBu3Ej0nF6H4S1baudrbz4qoetGjea0IWEgKX7+sEgMzeEk8C9p/xSLWTOxGX
         U2RhL9NTu3JHgvRnTQ/QEZLs3yUedq/mk9glH2AKPKUugNNozjejVsx8SoljUHpzx8/s
         ecgINAt+OLfeLlkMLMpXuw3zkLiMZdSdzwAVMsiNpLQ0jbJ+xEZzGHakybXdse7Sp5mP
         zriKgA4LCqHphsCh/x8I+2KAH3gAg/WqbAjRsTq7aJl89D7TBMpMnnyiQ+YShmmXnvZr
         qBMunn89DFxoX6GvSDz10ohoCbr9xIPi2iwW72Keldo0+WsQl/XXZu9Kwc7ALoYR1RkS
         65GQ==
X-Gm-Message-State: ACgBeo24sV0mkCSZ4asolxfjma0vlH1PQFgFLxlYzHbTtBXBJ9Jpe+VY
        9bKz+cRkprk8U037m1eqQC8=
X-Google-Smtp-Source: AA6agR5VeBR8pieqlgGzhpp7NvCL0LzjfMZM8QKF6lol1MJ3x/59ENgdHawWhEZ+SMsPnz4WXG9LAA==
X-Received: by 2002:a05:6a00:e8a:b0:535:cc5c:3d87 with SMTP id bo10-20020a056a000e8a00b00535cc5c3d87mr15404635pfb.24.1662745963556;
        Fri, 09 Sep 2022 10:52:43 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b77b:e812:1879:ec2f])
        by smtp.gmail.com with ESMTPSA id w207-20020a627bd8000000b0052d46b43006sm4275pfc.156.2022.09.09.10.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 10:52:43 -0700 (PDT)
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
Subject: [PATCH 1/3] perf stat: Fix BPF program section name
Date:   Fri,  9 Sep 2022 10:52:37 -0700
Message-Id: <20220909175239.206268-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220909175239.206268-1-namhyung@kernel.org>
References: <20220909175239.206268-1-namhyung@kernel.org>
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

It seems the recent libbpf got more strict about the section name.
I'm seeing a failure like this:

  $ sudo ./perf stat -a --bpf-counters --for-each-cgroup ^. sleep 1
  libbpf: prog 'on_cgrp_switch': missing BPF prog type, check ELF section name 'perf_events'
  libbpf: prog 'on_cgrp_switch': failed to load: -22
  libbpf: failed to load object 'bperf_cgroup_bpf'
  libbpf: failed to load BPF skeleton 'bperf_cgroup_bpf': -22
  Failed to load cgroup skeleton

The section name should be 'perf_event' (without the trailing 's').
Although it's related to the libbpf change, it'd be better fix the
section name in the first place.

Fixes: 944138f048f7 ("perf stat: Enable BPF counter with --for-each-cgroup")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
index 292c430768b5..c72f8ad96f75 100644
--- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
@@ -176,7 +176,7 @@ static int bperf_cgroup_count(void)
 }
 
 // This will be attached to cgroup-switches event for each cpu
-SEC("perf_events")
+SEC("perf_event")
 int BPF_PROG(on_cgrp_switch)
 {
 	return bperf_cgroup_count();
-- 
2.37.2.789.g6183377224-goog


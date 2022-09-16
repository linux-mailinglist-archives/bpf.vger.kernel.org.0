Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EE75BB24D
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 20:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiIPSlm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 14:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiIPSlk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 14:41:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37555B7778;
        Fri, 16 Sep 2022 11:41:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id y11so4947197pjv.4;
        Fri, 16 Sep 2022 11:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=RKJpmxEL/4rrX7/TLn5cIPoVCbxvKy1MHz9MxjM0RFM=;
        b=kqKDflP5KyjFkk+STZbQ9veV9qUodqQnSJrLbvm2QusLk+5QJiu24FX5lZm5xJymmw
         rFp6Sc4frts5Pr8ZxC7RWKAdA86WtEolAPx8uZDw9qte+KTqFh+da4XlWp7x0XYX2Y/t
         gb/TTZuHH5fOJa3CQljKlMXN/znRjmdfdDTz78yaLIAVZpN/5aJCB1WkvwmoyvsKORT2
         tIrLenD+ccbdTL0ulud7i4ion7lFxIF34YyHYrzG+jlVRWMEeBpZQQj4KX4QdcVgX34c
         Tauxq8ofBOouUVDEkb4W7WzdwSSgDyELDBjjC5/e7EbBFHwxMx4hjMXMZ6ehG0y+OEdE
         cCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=RKJpmxEL/4rrX7/TLn5cIPoVCbxvKy1MHz9MxjM0RFM=;
        b=bPH5Y+Y7bqhh++cKmAUEgHe1UVgcP0zod1tikW+B3H7rbHMHclMdJBz/xaAKZQeJwL
         G9O6iRZMADidpKapUpqlG3U7WAhuhyLh8XIlS2bWnwt2CHr8cwpz7lX6V3oWvNYofhbf
         x7iaSb2QrCtwTVTksZUMqrrc9nVHncyC4jr4yCEvahpVyVLh5iPKm/O4NOWnA9yfORky
         JUzUIaoCFOt1guD3wCoB1eRRbKFKRZ0ZDD/QCVVpSif5Hnj0jwJAojYNdvX/Kcmcd7IM
         TsmgOAuiOawKzaMiZVvsaUjdgWP8OH+S54UdEmTW6n2KqIeyTky4vYr0YX0cOf6+iE+a
         xamQ==
X-Gm-Message-State: ACrzQf3PuvRKdgvsKYI5HTfYEdNWjewzZhBOEaaIb0VXH0gJylLuBJSZ
        qTgLtYmIRfuzmLAeS41Simg=
X-Google-Smtp-Source: AMsMyM7cE9dYo6XVjGP7XmqtjsqZSdjYOy/E4eDebiQD3QkX60Wz7SwtjGOsGVQBZbq8oIiL+gNP/g==
X-Received: by 2002:a17:902:ebd2:b0:174:3e94:d01 with SMTP id p18-20020a170902ebd200b001743e940d01mr1220417plg.112.1663353696952;
        Fri, 16 Sep 2022 11:41:36 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:2952:dee7:a35e:6428])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b0016dcbdf9492sm15093004plr.92.2022.09.16.11.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:41:36 -0700 (PDT)
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
Subject: [PATCH 1/4] perf stat: Fix BPF program section name
Date:   Fri, 16 Sep 2022 11:41:29 -0700
Message-Id: <20220916184132.1161506-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220916184132.1161506-1-namhyung@kernel.org>
References: <20220916184132.1161506-1-namhyung@kernel.org>
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
2.37.3.968.ga6b4b080e4-goog


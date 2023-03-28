Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFAC6CB6CD
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 08:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjC1GRM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 02:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjC1GRF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 02:17:05 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BB83C1D
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 23:16:49 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o10-20020a17090ac08a00b0023f3196fa6fso2973000pjs.2
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 23:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679984209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+vNiceMoZ2PdzrNG/xVeRzEo7O+ovCZNHcQMp7VClk4=;
        b=FtVms547YGVdf9XAqjguoo0WST2Bomcq4pMeCW3qlg0ksZV5swPoVz0GmrxFu8vfrh
         HBzgJptVGGKy7geKpBPvC2PsWo0HmjT2F27i9dbdVA6zCF4EYemeZRNrh89DbSPqLObX
         h82tbSvZ/WCeLjLtii1Meb+k3BLVneGl+TdsHqmfTXT/vAFZIC+/S3Aw9k3ElSrpUy7X
         9xgxQRUTlE19S9rQfATi59HRnf65TEpEpviTmJbLID2U9/qvSayVfcGFQGEl03zvUEu5
         uDhGnK3XWBy1kJngfOB04Odcd1UeEO5WA33WjKyVDhleLQy8k50zMQSY0RXklX82o1Jn
         CmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vNiceMoZ2PdzrNG/xVeRzEo7O+ovCZNHcQMp7VClk4=;
        b=GfYV3R9xnh9l3z8WuqrnaUjQDVQvTGC8yegUinzI2k2dt/0hoU/nNlcN3G+3YEQ2L2
         BCzZw8C6oAjMzs4vBD0erkiuE0IPq3NQwwPrbpuyYE47G7ZY+cLywGN35SHCcBPEmmRD
         IBRQ+rAIYY+JQda+e0d0KJhAgVQ/Dmah7Rgs5rHJY02EyOAfvHbCC+33SBHQWrMTh9Bk
         2aRkgxN2Fnqo8p2XYLaudfHsmZ+3tq8iARQEjPP+SfE/sE/Od6qT63RFTeE6rDpH0/9X
         c8c2jQRxyMBBozIP8e1lbu9QFLthrIusq56ZXO/AHULshke5Y93/SUzQ6nrprrrjna9A
         nYoA==
X-Gm-Message-State: AAQBX9fTkqNeGNosuDYTkQ2nXTEM2c/d27SCyUelSt8ruVJrLZk2Vw8w
        rmtr3kFFRu6naqSZSgsNbL7GkeNXSueyCZiP
X-Google-Smtp-Source: AKy350az2ZQxKTBjGyFUiNza+YDGvWpTHjavWcHAugAuQk4rmOEm1wQoqfQkURL2u01jT9Cm3t+xr5muiADnxiOT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:1a46:b0:625:c7de:48c1 with
 SMTP id h6-20020a056a001a4600b00625c7de48c1mr7269994pfv.4.1679984209151; Mon,
 27 Mar 2023 23:16:49 -0700 (PDT)
Date:   Tue, 28 Mar 2023 06:16:33 +0000
In-Reply-To: <20230328061638.203420-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328061638.203420-5-yosryahmed@google.com>
Subject: [PATCH v1 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing outside
 task context
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>
Cc:     Vasily Averin <vasily.averin@linux.dev>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

rstat flushing is too expensive to perform in irq context.
The previous patch removed the only context that may invoke an rstat
flush from irq context, add a WARN_ON_ONCE() to detect future
violations, or those that we are not aware of.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/cgroup/rstat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d3252b0416b6..c2571939139f 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -176,6 +176,8 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 {
 	int cpu;
 
+	/* rstat flushing is too expensive for irq context */
+	WARN_ON_ONCE(!in_task());
 	lockdep_assert_held(&cgroup_rstat_lock);
 
 	for_each_possible_cpu(cpu) {
-- 
2.40.0.348.gf938b09366-goog


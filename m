Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8BC5ECE97
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 22:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiI0UdK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 16:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiI0UdI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 16:33:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DF98995D;
        Tue, 27 Sep 2022 13:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3D3AB81C17;
        Tue, 27 Sep 2022 20:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC978C433C1;
        Tue, 27 Sep 2022 20:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664310785;
        bh=aL7SicLvUw5LvgT/E6i/KGRP14jD0cSAYV7ECGaRcWs=;
        h=From:To:Cc:Subject:Date:From;
        b=jo1mHKcFMOonQxXgNyU5EPNG66pvJKVik4VmKMpxlxkj6AtYcGtpL8X0cZSWR9EbQ
         tZxSJsPVSjOPScWRfB5zhoP3jGrHuf4Np3Dg2z+Wwi6vbID9dLX7I7VBi7cQDFeavs
         3qqstOLAG4Y23DogiCUKwoCsE+g3He47M1drXnE4RFrDL62yCDoOgkLHEQrRC4o3OS
         mYYCp+SLAEAHlb+F8mH3b6hlDE3XMnFhx9XBZ04bNGOOynFBIUHckwVU1NQ0H0uBg3
         1U8FRTQ3YNYFKR9l+gHq28tj94qw9WxG+MUhp8gaSMcD924DE0BQjZdEBAqlAgSPe1
         i0NWy9WDIKrrg==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCH -tip] bpf: Check flags for branch stack in bpf_read_branch_records helper
Date:   Tue, 27 Sep 2022 22:32:59 +0200
Message-Id: <20220927203259.590950-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Recent commit [1] changed branch stack data indication from
br_stack pointer to sample_flags in perf_sample_data struct.

We need to check sample_flags for PERF_SAMPLE_BRANCH_STACK
bit for valid branch stack data.

[1] a9a931e26668 ("perf: Use sample_flags for branch stack")

Cc: Kan Liang <kan.liang@linux.intel.com>
Fixes: a9a931e26668 ("perf: Use sample_flags for branch stack")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
NOTE sending on top of tip/master because [1] is not
     merged in bpf-next/master yet

 kernel/trace/bpf_trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 68e5cdd24cef..1fcd1234607e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1507,6 +1507,9 @@ BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
 	if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
 		return -EINVAL;
 
+	if (unlikely(!(ctx->data->sample_flags & PERF_SAMPLE_BRANCH_STACK)))
+		return -ENOENT;
+
 	if (unlikely(!br_stack))
 		return -ENOENT;
 
-- 
2.37.3


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7806685CC
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 22:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjALVsJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 16:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjALVrd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 16:47:33 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200706DBAE;
        Thu, 12 Jan 2023 13:40:20 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id a184so14781334pfa.9;
        Thu, 12 Jan 2023 13:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sjVq4tOXJZ8sec8ReYRUdXeaFGuoHuExrBPraEOekVg=;
        b=bSU2EKc6Nr9oWX+e8xzlaIbJFz7XQWYkYddZ7psGxBUWPGc2nEQB9Hai+qcGJgRmBB
         UWQK0lpVpEbFsXZpoTJLtyP6ZQw5JIqI+d0gEnVVcY0a7Ibot7u0EwvzCxXKRZ/Jxfhj
         1sVAsOsoQ4U9wdOEKZXYhk2Y/SYDyq4v2TvGUQy83+w5uUK67GAqNXEF3wi5YV3Pl0bN
         liUo6YCIwDhqk79JFb0mFNsQ4taDMFDg2og1Qwn/tC7u65ve6bimsjwZQW62tRZOg4X5
         8T5iYpXOgnE+dytf2wxLDwVOylvER+HGxUFeLISeWNAurtK+ydvtDTamWoitAyjdy3Br
         5urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjVq4tOXJZ8sec8ReYRUdXeaFGuoHuExrBPraEOekVg=;
        b=j/zxvH2QyNzSQNBuv6oFs6Uy9s6U6KnXFRe+DnI5xZ52ka9OYxi/+LxG5lbMdmEugi
         oBC2p+0bX9LkvFu2UC7U2oSY3fd/t0u3TKmm+uS4rll6eUCFaxOi30NYfR+z0erLUn4h
         vP95N65hPVH3wByouZ6KNoJkaKf4a3Z65Izdb5INggZXfVWvJlQSFRHaTcmzkaKmLxWK
         POU5w1UjUSfwpc6/WburYgW7SyjfaYoFBUZdrU1dzAcnYpFpiXDJjq/yOQ81JYa4OP9L
         J0qMwz3NObigHCuGlyUVcdldPeAgGW/8KSHhq+uIdIYKOtFny5eSRix79kP+ui6TUWXr
         2gYg==
X-Gm-Message-State: AFqh2kqZbIUxKdJd1ZrIT9fnUgcRVzCXKbXkPEAv1wktsAAFsQ7gAE+8
        ZYvwIqFGSiBKQbaiss52u2fRaENHPTo=
X-Google-Smtp-Source: AMrXdXtFKod5F0GKjH+5v3HBCPVbobNT4gcesqhN+rvXFZ+Glbz3ACPJwFjDt7A7ccbmVouqUm8yLw==
X-Received: by 2002:a05:6a00:f92:b0:582:a224:e740 with SMTP id ct18-20020a056a000f9200b00582a224e740mr37411596pfb.27.1673559619300;
        Thu, 12 Jan 2023 13:40:19 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b71e:23d4:aa6a:47c0])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b0058134d2df41sm11344605pfl.146.2023.01.12.13.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:40:18 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org
Subject: [PATCHSET 0/8] perf/core: Prepare sample data for BPF
Date:   Thu, 12 Jan 2023 13:40:07 -0800
Message-Id: <20230112214015.1014857-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

The perf_prepare_sample() is to fill the perf sample data and update the
header info before sending it to the ring buffer.  But we want to use it
for BPF overflow handler so that it can access the sample data to filter
relevant ones.

Changes in v2)
 * the layout change is merged
 * reduce branches using __cond_set  (PeterZ)
 * add helpers to set dynamic sample data  (PeterZ)
 * introduce perf_prepare_header()  (PeterZ)
 * call perf_prepare_sample() before bpf_overflow_handler unconditionally

This means the perf_prepare_handler() can be called more than once.  To
avoid duplicate work, use the data->sample_flags and save the data size.

I also added a few of helpers to set those information accordingly.
But it looks some fields like REGS_USER, STACK_USER and AUX are saved in
the perf_prepare_sample() so I didn't add the helpers for them.

After than we can just check the filtered_sample_type flags begin zero
to determine if it has more work.  In that case, it needs to update the
data->type since it's possible to miss when PMU driver sets all required
sample flags before calling perf_prepare_sample().

The code is also available at 'perf/prepare-sample-v2' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Cc: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org


Namhyung Kim (8):
  perf/core: Save the dynamic parts of sample data size
  perf/core: Add perf_sample_save_callchain() helper
  perf/core: Add perf_sample_save_raw_data() helper
  perf/core: Add perf_sample_save_brstack() helper
  perf/core: Set data->sample_flags in perf_prepare_sample()
  perf/core: Do not pass header for sample id init
  perf/core: Introduce perf_prepare_header()
  perf/core: Call perf_prepare_sample() before running BPF

 arch/powerpc/perf/core-book3s.c    |   3 +-
 arch/s390/kernel/perf_cpum_cf.c    |   4 +-
 arch/s390/kernel/perf_cpum_sf.c    |   3 +-
 arch/s390/kernel/perf_pai_crypto.c |   4 +-
 arch/s390/kernel/perf_pai_ext.c    |   4 +-
 arch/x86/events/amd/core.c         |   6 +-
 arch/x86/events/amd/ibs.c          |   9 +-
 arch/x86/events/intel/core.c       |   6 +-
 arch/x86/events/intel/ds.c         |  24 ++--
 include/linux/perf_event.h         | 133 +++++++++++++-----
 kernel/events/core.c               | 207 ++++++++++++++++-------------
 kernel/trace/bpf_trace.c           |   6 +-
 12 files changed, 236 insertions(+), 173 deletions(-)


base-commit: 9fcad995c6c52cc9791f7ee9f1386a5684055f9c
-- 
2.39.0.314.g84b9a713c41-goog


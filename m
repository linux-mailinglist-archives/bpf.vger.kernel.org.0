Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF36688CF5
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 03:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjBCCNb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 21:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjBCCNa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 21:13:30 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396594FC13;
        Thu,  2 Feb 2023 18:13:29 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o13so3706236pjg.2;
        Thu, 02 Feb 2023 18:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PC+7eG5v0On9Uzu9MVNYf6K7hpU6NVQjdEiMJ0VLGkE=;
        b=keeD+V9wpUp/nx8XgqGbTDMyVi0M+fEtrWsSUmBnyKxJ4GDuH5fRH5bva6YnBJQ7Te
         3R+y3OR1wV7+BPGIVYvb9dVndsyhG06OhrzRJRuOaK9wbxkkupuyZfImtnGbQ+873biL
         Ab4xrFrOT7STQQ8uA6Opqf8YhfTIW7YSovexF6s0EiXIMfh72FFHcZdStvshG7ZqRd3t
         o6UjYhBPrdTtnzP4dOxB1MZh1WnlmnbX9k/Dr5n7ZLTLr39PtlFVZL/CRKJOT/KeNIvK
         PGoFwfPPw8iRgJ/CR41VFOiCs6tEqOAiU6zT8MbvX73I16AaXbmu0AxQuEBj0AvSGEoN
         IHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC+7eG5v0On9Uzu9MVNYf6K7hpU6NVQjdEiMJ0VLGkE=;
        b=W0tQZ9R+dYg1UyIvmT8vHDWBY3pwcjVZXZdSQ4PuIit9oQchhwpCLuvlh/Z10wooAd
         6BpjvhPTNHHOTXOvX+syFNAjE+8JyzutMqfLzUXFdoIUIywHO4skhI7X9MCSggl3jeHO
         Ng3HQXrVUpKU/6Pa0l4bX5YiiBYWW6PHh0tGJLjJJCZ8OYkcuUfC41besOh3WsTEDOiO
         AZC9kMBFgvu9xfazF9777kJYLqaseY7/UvYnuwapsxfFwrI5hcAOBjx2gmcKmD/ScQe+
         KxX6mk43L/LkBElzOk5zwZoxyLRygwM7yWW1h5JvunJfMtFKBaKurpJf/mulXoQty6TJ
         s9Lg==
X-Gm-Message-State: AO0yUKUPqZclwn9+ttbfF8XZWMZqAdQpL+Lvb14Mp77n4lXQqeUqWULe
        ClLLJaQtfs01jzVFmBqErVMxUYDS68M=
X-Google-Smtp-Source: AK7set87d/ZMAvBdw3n2FldFklqJRVFQHeTMq32URlTMIzi6XUEgshQfFV8JHTzbVRAq2OrBUaqp7g==
X-Received: by 2002:a17:90a:19d7:b0:22c:6d7c:c521 with SMTP id 23-20020a17090a19d700b0022c6d7cc521mr8593408pjj.45.1675390408407;
        Thu, 02 Feb 2023 18:13:28 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:6755:96ed:3f18:dac4])
        by smtp.gmail.com with ESMTPSA id fs23-20020a17090af29700b0022c942b8683sm497249pjb.56.2023.02.02.18.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 18:13:27 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, irogers@google.com,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, song@kernel.org,
        haoluo@google.com, bpf@vger.kernel.org, juri.lelli@redhat.com
Subject: [PATCH v2 0/3] perf lock contention: Improve aggr x filter combination
Date:   Thu,  2 Feb 2023 18:13:21 -0800
Message-Id: <20230203021324.143540-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
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

Hello,

The callstack filter can be useful to debug lock issues but it has a
limitation that it only works with caller aggregation mode (which is the
default setting).  IOW it cannot filter by callstack when showing tasks
or lock addresses/names.

But sometimes users want to use the filter for other aggregation mode.
Like "show me lock addresses/names from this caller only" or "show me
tasks having these callers".

When it's using tracepoint events from the data file, the situation is
good since the tracepoints have all the necessary info.  But when using
BPF it needs to extend the key of lock stat BPF map to have more than
one info like 'pid + stack_id' or 'lock_addr + stack_id'.  As callstack
filter works in userspace, it should save the both info.

With this change we can now use the -S/--callstack-filter with the
-t/--threads option or -l/--lock-addr option.  It's also possible to use
it with other filter options.

The following example shows the top 5 tasks that have contention
somewhere in the epoll handling.

  $ sudo perf lock con -abt -S epoll -E5 -- sleep 1
   contended   total wait     max wait     avg wait          pid   comm

           2     58.64 us     32.38 us     29.32 us      1514752   Chrome_IOThread
           3     29.31 us     12.65 us      9.77 us         3773   Xorg
           1     17.45 us     17.45 us     17.45 us      1514906   Chrome_ChildIOT
           1     15.41 us     15.41 us     15.41 us      1515382   Chrome_ChildIOT
           1     12.52 us     12.52 us     12.52 us       293878   IPC I/O Parent

You get get the code at 'perf/lock-filter-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (3):
  perf lock contention: Factor out lock_contention_get_name()
  perf lock contention: Use lock_stat_find{,new}
  perf lock contention: Support filters for different aggregation

 tools/perf/builtin-lock.c                     |  79 ++++----
 tools/perf/util/Build                         |   5 +-
 tools/perf/util/bpf_lock_contention.c         | 180 +++++++++++-------
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  15 +-
 tools/perf/util/bpf_skel/lock_data.h          |   4 +-
 tools/perf/util/lock-contention.h             |   5 +
 6 files changed, 178 insertions(+), 110 deletions(-)

-- 
2.39.1.519.gcb327c4b5f-goog


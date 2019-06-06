Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 458AD36DE0
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 09:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfFFH4k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 03:56:40 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40445 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFFH4k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 03:56:40 -0400
Received: by mail-yb1-f193.google.com with SMTP id g62so599319ybg.7
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5zxl/1kwHqAI4DRUEiMT/LtSxO6kWAE0NYYYjCPxIgw=;
        b=JYJ+BH8ph9BynXcTk2T/3rfh/N0Ej+7xz1AMhk6isvVyWzHAuJc/sM8EEU+qAcYtvl
         BAxgMC7pwl1YD2LI1XPyg1yT0FesASXKl7La/mTM9ibgfsmC/hJ3YYuBUQ76nPx1cXT8
         /wxcxr4b/GImAmIEFcbo/ufvJh6kqnUJJbztB6Tk5TB/n2VYGPO/fXFEJ/edIwOm6mnK
         hn7QrepywI0oofHP87M/f5zrj4UgwXMzpppSSCxAIu9s2tRr+IbB4g0APtILtcFMk/Ho
         xYMPWajy77pzC5mzpW7AXUsZQSEgWcNeMcjl3lhMNJyldTfbD9Na5CsLCdbrV7wWpM0Z
         gNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5zxl/1kwHqAI4DRUEiMT/LtSxO6kWAE0NYYYjCPxIgw=;
        b=J3mcpGQHy7ZaC4ARk7ZQrHmKRQvB45ONbP3+aZ3xnUTJilLgLNDpitfOkGozGsgZZw
         cpdmiPlDPzs6wcycHGnI9Ncj9FDRAjvO7xnz9IBhfU3nc8yREfuZYwum9C5upG+t9tn6
         fS1ptZwqHYE30bKhWxPhpZ/wknmrjbuIbWTfTuTbx/D3n3+EF/wc/lKrQbUCNocWPJz6
         q6WYfco0R8vVGy+ojut2IN2SekiiC2IXzh0/GcyC5NtMafJV9TZOD2VSEE81I9chSSLm
         uMKEdlyS9yGy5LOTGJWAXR63QLnI8bsncMlaIaUl7bARo0gNhR4PUV5a5dn0Wg7/OFJn
         6SWg==
X-Gm-Message-State: APjAAAUOeN4oqj85xL13Xg4tqKpTPZTVU22ipA87JbQC32NRFG1NlUAN
        //qTTEpCf87Hpa2o7Fvy2hHQcg==
X-Google-Smtp-Source: APXvYqzdoeciY6MLysk++kMEtzU9vvDXtgdZswYM+X9azUgBXZKQokrV4uheSAdrBO38BdvIhQn58A==
X-Received: by 2002:a25:19d6:: with SMTP id 205mr3559544ybz.135.1559807799726;
        Thu, 06 Jun 2019 00:56:39 -0700 (PDT)
Received: from localhost.localdomain (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id 14sm316343yws.16.2019.06.06.00.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 00:56:38 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/4] perf augmented_raw_syscalls: Support for arm64
Date:   Thu,  6 Jun 2019 15:56:13 +0800
Message-Id: <20190606075617.14327-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When I tried to run the trace on arm64 platform with eBPF program
augmented_raw_syscalls, it reports several failures for eBPF program
compilation.  So tried to resolve these issues and this patch set is
the working result.

0001 patch lets perf command to exit directly if find eBPF program
building failure.

0002 patch is minor refactoring code to remove duplicate macro.

0003 patch is to add support arm64 raw syscalls numbers.

0004 patch is to document clang configuration so that can easily use
this program on both x86_64 and aarch64 platforms.


Leo Yan (4):
  perf trace: Exit when build eBPF program failure
  perf augmented_raw_syscalls: Remove duplicate macros
  perf augmented_raw_syscalls: Support arm64 raw syscalls
  perf augmented_raw_syscalls: Document clang configuration

 tools/perf/builtin-trace.c                    |   8 ++
 .../examples/bpf/augmented_raw_syscalls.c     | 102 +++++++++++++++++-
 2 files changed, 109 insertions(+), 1 deletion(-)

-- 
2.17.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0F71C8DEE
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgEGOKQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgEGOIu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:08:50 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1524FC05BD0C
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 07:08:50 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id f56so6858454qte.18
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dJgmTX+e/XhBfHBE3JA0uHT0QwjnDN/7PIiY44zE/Pk=;
        b=MbcHpI1S5OxMmKRIL8TmEwAjmGUuXiQUNWFjjN/YpqFTRBD28jHsEegJVELa5W2k/9
         agkiEFw7uakxlx7LIOatx3eUukVnVn0MX1SdDkQwJzXM+Y6M2N3zKYZAyCDMwWCJgy2M
         JBlNzYMrEduwie1OvQrSwG8YaMYQii6XclidLVgaYWWMD3ddbi39V5bC3xMmWl3cV8oZ
         GvAUZw/74ADf8w/0A+sA97fiDE+T8g8zgMq8TDE6prBfrYqLthp7JHLjFbszGMXNXuca
         WT59CP91C8yIadGORdXB7PvIbWHaO45YbqSSxU5QDB6+oiQmCHFasvhmPsBfbgtxxVqm
         x4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dJgmTX+e/XhBfHBE3JA0uHT0QwjnDN/7PIiY44zE/Pk=;
        b=lbKq59XpKJxrndjg31i5Dc2is6bJmv/hnUNordNoK7As2By/zprbWvmmA9fsJA7ev7
         NB1CNkbdJjvNZgRKAP2A3obBtgUrtBaUzfs5CqqbpWSOUum4Y4bODTWevpzTrLCKhJk+
         iOSXbXVy3d4OALA3c8kFJfTk2wxKh8xK89Fh+utBADC0KQiL94o8GPyhjenVtPrG9JEy
         kVnZcLi9urDke5XHX61l8cdwDj1g2+8vtqfXhlpaE7cBCSabUIjPd3T8Mg6ebeZYPKbk
         I6vU28xP0LSvvDy7hlsu15cANqc8IumJ2NAXjGzTw7OuHvp5aDy615DHClkl0fRpY5si
         4c9g==
X-Gm-Message-State: AGi0Pua/11CDmR7J24Ovn5Ml7bsyqeJL2lQZtleNWHbA0jKq+3WcjhrW
        s2x+Mc4mYhzRvD6BMxFXmSvMykFwXHQ+
X-Google-Smtp-Source: APiQypLCl/Z5EIdl/XTfe2GJCrqiaYwhgjj4RK37r3mcFcJW50Dz8UgEcRa3XlIlulU2fheTegM9wZXLkQPa
X-Received: by 2002:ad4:4105:: with SMTP id i5mr13742509qvp.205.1588860529184;
 Thu, 07 May 2020 07:08:49 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:09 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-14-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 13/23] lib/bpf hashmap: increase portability
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Don't include libbpf_internal.h as it is unused and has conflicting
definitions, for example, with tools/perf/util/debug.h.
Fix a non-glibc include path.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index bae8879cdf58..d5ef212a55ba 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -13,9 +13,8 @@
 #ifdef __GLIBC__
 #include <bits/wordsize.h>
 #else
-#include <bits/reg.h>
+#include <linux/bitops.h>
 #endif
-#include "libbpf_internal.h"
 
 static inline size_t hash_bits(size_t h, int bits)
 {
-- 
2.26.2.526.g744177e7f7-goog


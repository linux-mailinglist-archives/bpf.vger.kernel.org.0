Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711201D4680
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 08:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgEOG5M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 02:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726656AbgEOG4k (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 May 2020 02:56:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1691BC05BD0A
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 23:56:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x10so1578787ybx.8
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 23:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rDN5X6ee0p3DPWcQJnEO6bz3ZGrQ0VwuHJwyeJb8UjA=;
        b=KLdZkd7htipcJURCMR14vvzpQP9A0y+OVxW6HSLzZHzFBZJHTKwz9IVBBxRF4GvUEm
         FSMZk7uKRPn2mlBTMmDdAt4esd/0s/s2wgWy5aAXz7LuQtGXRB+iIyTXNziR2p53QKE3
         T5PtllNVjRZJj4jCsHWttYebRTmUjfvvmRoDZtP0cJ7NI9MB3S+RPaCwNn8KeFIkYLI8
         0cJto9KU6HcZEH+wKsu4HJgbFDpQ5jMfV2/lsGTVbKVcr1J9sClqOkTc/McfHP0SuS/F
         XhDi9KXz9PRd5yRyXKq2SgvSHeLXQ916hTUQ41QXQgXuFNTFyzU/fLuAraZvRzw69afs
         DX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rDN5X6ee0p3DPWcQJnEO6bz3ZGrQ0VwuHJwyeJb8UjA=;
        b=GhYUuo5uLpDYgppLaJltAo0gFrEVP2uSt27YO7cJdmR9K33qYwbvksTkwN63jspTx9
         SfQrcEIn3dDPXGgIpcilsrPDOFrbKRcCwn3LJ1nr+v2rKO7U4HWToFpERPzwnbpyFjUd
         uDjJDrUf+edxJ7r9hXT7nFt0WKAOd1ypA3lRnLHmAqMylIf82NPyHY9h+AQxpRTI7fpX
         ueajRLYJDjFijdoQDy7+xkPBvFmL9AD7ZyJAoF876qSwiSsLq7WfNfdQqfz4FiouDBUE
         sQyoWxMNThuqkmMus4TL94T5yC8Q24mTr2/2LaFQt6Vw4gkCbrrkz6Nv/aPQH4DxhGg0
         6b7Q==
X-Gm-Message-State: AOAM530wWNDJdGhpgufDrIeTM3Llt+iaeXJuoqYpIKR2xtL56QuIhUui
        KFrGd5T/8ND128mKEdMEu3s6YXf1+a29
X-Google-Smtp-Source: ABdhPJyAKrEhG9hP88436bqQfTqIsJLRSZBZRWxiUsuHq6Q11uRmf18lQUT127u8JrDy04si5qc0Uj/kFk74
X-Received: by 2002:a25:a184:: with SMTP id a4mr3068042ybi.255.1589525797993;
 Thu, 14 May 2020 23:56:37 -0700 (PDT)
Date:   Thu, 14 May 2020 23:56:20 -0700
In-Reply-To: <20200515065624.21658-1-irogers@google.com>
Message-Id: <20200515065624.21658-5-irogers@google.com>
Mime-Version: 1.0
References: <20200515065624.21658-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH 4/8] libbpf hashmap: Localize static hashmap__* symbols
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Localize the hashmap__* symbols in libbpf.a. To allow for a version in
libapi.

Before:
$ nm libbpf.a
...
000000000002088a t hashmap_add_entry
000000000001712a t hashmap__append
0000000000020aa3 T hashmap__capacity
000000000002099c T hashmap__clear
00000000000208b3 t hashmap_del_entry
0000000000020fc1 T hashmap__delete
0000000000020f29 T hashmap__find
0000000000020c6c t hashmap_find_entry
0000000000020a61 T hashmap__free
0000000000020b08 t hashmap_grow
00000000000208dd T hashmap__init
0000000000020d35 T hashmap__insert
0000000000020ab5 t hashmap_needs_to_grow
0000000000020947 T hashmap__new
0000000000000775 t hashmap__set
00000000000212f8 t hashmap__set
0000000000020a91 T hashmap__size
...

After:
$ nm libbpf.a
...
000000000002088a t hashmap_add_entry
000000000001712a t hashmap__append
0000000000020aa3 t hashmap__capacity
000000000002099c t hashmap__clear
00000000000208b3 t hashmap_del_entry
0000000000020fc1 t hashmap__delete
0000000000020f29 t hashmap__find
0000000000020c6c t hashmap_find_entry
0000000000020a61 t hashmap__free
0000000000020b08 t hashmap_grow
00000000000208dd t hashmap__init
0000000000020d35 t hashmap__insert
0000000000020ab5 t hashmap_needs_to_grow
0000000000020947 t hashmap__new
0000000000000775 t hashmap__set
00000000000212f8 t hashmap__set
0000000000020a91 t hashmap__size
...

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index aee7f1a83c77..4a1cdbceb04e 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -20,6 +20,7 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
 
 INSTALL = install
+OBJCOPY ?= objcopy
 
 # Use DESTDIR for installing into a different root directory.
 # This is useful for building a package. The program will be
@@ -181,6 +182,7 @@ $(BPF_IN_SHARED): force elfdep zdep bpfdep $(BPF_HELPER_DEFS)
 
 $(BPF_IN_STATIC): force elfdep zdep bpfdep $(BPF_HELPER_DEFS)
 	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(STATIC_OBJDIR)
+	$(Q)$(OBJCOPY) -w -L hashmap__\* $@
 
 $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
 	$(QUIET_GEN)$(srctree)/scripts/bpf_helpers_doc.py --header \
-- 
2.26.2.761.g0e0b3e54be-goog


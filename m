Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD61A330503
	for <lists+bpf@lfdr.de>; Sun,  7 Mar 2021 23:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhCGWak (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Mar 2021 17:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCGWaa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Mar 2021 17:30:30 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7ADC06175F
        for <bpf@vger.kernel.org>; Sun,  7 Mar 2021 14:30:29 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 127so10502827ybc.19
        for <bpf@vger.kernel.org>; Sun, 07 Mar 2021 14:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=/dBG0yzSXzaEP6wMxF8WVCUzDpcnQDtjFnGEznOQX/s=;
        b=UWzHK5JD0jUddhVg2gtrM9KROWDj/CbEKimn+q4kgOYXPCwWDxoFugo11FmZ3cysNr
         wlvu9QYl8N2iMJ5fjHGAK+ELj+KqGlWLf6palIGL1N0ubRKGpZTlc+Q92A494HHN5laI
         p1a1c1catOsgPQ2tvE3mvKCgN1Nq2nHcELza21SvHZxwssx7glYkU1YknloO9910jgJI
         qbrjrwJc9g4gpD6hAZtBYqIGM6+RlFZSGqAVRvE4L/lo1yxHjZRugqMhTaeLRZcCfwf/
         gqa77N7+4ik92luA4iraU4dd7jh57MOQCDx4rzxwm7Yu+JPMN2pJHmSCvwOWxDr0Q3sE
         7chA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=/dBG0yzSXzaEP6wMxF8WVCUzDpcnQDtjFnGEznOQX/s=;
        b=Sjw9dQ16azpagc2h6rmvNb+ZEE5RW6dAI4KB9sQLOiIgDsS5fHKrEMAclFd1wdMhiG
         oadYD/Gbvt0VmQ8X10jwpktJjVXqu6gk189zGtD/z0An1756VZyerZNFRX5VOdoYaM+i
         Srky6rE0C9NCBwQAj+DXT6QBhKfvMIPZbRCag+cIOdk+zJFuDboe83JAn/+8qUxJiRVZ
         xf1oAIkX6bXEUHnmF8Ir/7UjKZhcNAnJK218wf/cHoEw+B/tgdE+qEzwJ2BogS5Yr2do
         mWRTduYk+RHsCfKPN+PrZbt+ygYdtAp+O8w2X7yGN3gQ5KW7+yByMVO9Rd2AQyTkqnvI
         XvAg==
X-Gm-Message-State: AOAM5338XOWbv7HnF/YGK0ro+ExgHcdYOm3hfXe8IzA+249wIo/Vb/rH
        5jK0AQyd4n6xKkq/DWkDd64SLCiO4K4Z
X-Google-Smtp-Source: ABdhPJwsYZzwXptjNwlzQryIbwpIEMnHOv6VOApg2GBKnTQas/Dhz8jbZZ4u/jD+wbomQDqeQHCD45YZ3YTN
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:54a7:6d37:d773:a2ec])
 (user=irogers job=sendgmr) by 2002:a25:7613:: with SMTP id
 r19mr29172005ybc.212.1615156228902; Sun, 07 Mar 2021 14:30:28 -0800 (PST)
Date:   Sun,  7 Mar 2021 14:30:24 -0800
Message-Id: <20210307223024.4081067-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] tools include: Add __sum16 and __wsum definitions.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds definitions available in the uapi version.

Explanation:
In the kernel include of types.h the uapi version is included.
In tools the uapi/linux/types.h and linux/types.h are distinct.
For BPF programs a definition of __wsum is needed by the generated
bpf_helpers.h. The definition comes either from a generated vmlinux.h or
from <linux/types.h> that may be transitively included from bpf.h. The
perf build prefers linux/types.h over uapi/linux/types.h for
<linux/types.h>*. To allow tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
to compile with the same include path used for perf then these
definitions are necessary.

There is likely a wider conversation about exactly how types.h should be
specified and the include order used by the perf build - it is somewhat
confusing that tools/include/uapi/linux/bpf.h is using the non-uapi
types.h.

*see tools/perf/Makefile.config:
...
INC_FLAGS += -I$(srctree)/tools/include/
INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi
INC_FLAGS += -I$(srctree)/tools/include/uapi
...
The include directories are scanned from left-to-right:
https://gcc.gnu.org/onlinedocs/gcc/Directory-Options.html
As tools/include/linux/types.h appears before
tools/include/uapi/linux/types.h then I say it is preferred.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/types.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index e9c5a215837d..6e14a533ab4e 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -61,6 +61,9 @@ typedef __u32 __bitwise __be32;
 typedef __u64 __bitwise __le64;
 typedef __u64 __bitwise __be64;
 
+typedef __u16 __bitwise __sum16;
+typedef __u32 __bitwise __wsum;
+
 typedef struct {
 	int counter;
 } atomic_t;
-- 
2.30.1.766.gb4fecdf3b7-goog


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 073FE140B02
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 14:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAQNhP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jan 2020 08:37:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39123 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728775AbgAQNgu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jan 2020 08:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579268209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kZR8zX+ydWBbBu89eT3Dfy7pXd3GWbtA0n7Gp7hmhwM=;
        b=OEvp8qa17BiG1p8jGUe5VCdM8CFwX5uYS26do52rFG/p2wzEhzvKCOkoXZepTpMA+ajcN9
        1nOWSG5/FKD8wuUejEV7y8O5uTopXYF7/udjagszBzpXMyV8UIiCVvtq59C7gtGgVihuZh
        mc42ijyYzlRd90mcnnWDIk4hGvEXW5I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-C1shQWxTNT64X9otwPXcqQ-1; Fri, 17 Jan 2020 08:36:48 -0500
X-MC-Unique: C1shQWxTNT64X9otwPXcqQ-1
Received: by mail-lf1-f72.google.com with SMTP id n24so4373818lfe.6
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2020 05:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kZR8zX+ydWBbBu89eT3Dfy7pXd3GWbtA0n7Gp7hmhwM=;
        b=Z79EUEpg/xW7KxVTQvYx7gPPcvKuc75yyq1pp6hxD218IalPvyvD/0zgQ6m5VOJjrd
         xT/Q+9ERPgnwOvT8gaY7scx5fho2wdyKvsN22b2xWRiP3OYJ1TfAlNeUGuFCLsPoXzvN
         d/nCy82KDiL1QsZsTShJewr+1twUuUh9emm8z1X5seeZMLoZiYkBnSJZZxRQJIWAH0tX
         Xvj4LYUbTls59gwSruBw5IRCVom0pa6YogvJ4/J8MDrAZ1r3/SoU+KWgMenm4sT4NkFE
         71KHpKHoVErFq0PjTvLeScb/wCDyAZwGD7gYq/sZWdpfTJb7asJvo7SC+KOpe5bWLC7m
         ComA==
X-Gm-Message-State: APjAAAU/qmEQFH6BUjm7PGTY893OMM/YuAgd4vgK7yzlS0F9yGfPEilF
        vWlBV6dQQ+xjhb5BXQDkAkjlJuOUfey45pjwy4ice70cGp3CCnVfwuSEo+6JG77IsDRzYuNHafP
        IE85gDNSQYsjP
X-Received: by 2002:a2e:548:: with SMTP id 69mr5667563ljf.67.1579268206511;
        Fri, 17 Jan 2020 05:36:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzQIWgc5FT4rMwZJg2UojEuLPhGl6YnWnw7UrIB2febpdvE/LkTz0PbsJPg+98VKBuAqWMejw==
X-Received: by 2002:a2e:548:: with SMTP id 69mr5667551ljf.67.1579268206336;
        Fri, 17 Jan 2020 05:36:46 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h14sm12058134lfc.2.2020.01.17.05.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:36:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9A5EF1804D6; Fri, 17 Jan 2020 14:36:44 +0100 (CET)
Subject: [PATCH bpf-next v4 07/10] perf: Use consistent include paths for
 libbpf
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Fri, 17 Jan 2020 14:36:44 +0100
Message-ID: <157926820454.1555735.5332893006269327491.stgit@toke.dk>
In-Reply-To: <157926819690.1555735.10756593211671752826.stgit@toke.dk>
References: <157926819690.1555735.10756593211671752826.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Fix perf to include libbpf header files with the bpf/ prefix, to
be consistent with external users of the library.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/perf/examples/bpf/5sec.c             |    2 +-
 tools/perf/examples/bpf/empty.c            |    2 +-
 tools/perf/examples/bpf/sys_enter_openat.c |    2 +-
 tools/perf/include/bpf/pid_filter.h        |    2 +-
 tools/perf/include/bpf/stdio.h             |    2 +-
 tools/perf/include/bpf/unistd.h            |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/examples/bpf/5sec.c b/tools/perf/examples/bpf/5sec.c
index b9c203219691..49f4f84da485 100644
--- a/tools/perf/examples/bpf/5sec.c
+++ b/tools/perf/examples/bpf/5sec.c
@@ -39,7 +39,7 @@
    Copyright (C) 2018 Red Hat, Inc., Arnaldo Carvalho de Melo <acme@redhat.com>
 */
 
-#include <bpf.h>
+#include <bpf/bpf.h>
 
 int probe(hrtimer_nanosleep, rqtp->tv_sec)(void *ctx, int err, long sec)
 {
diff --git a/tools/perf/examples/bpf/empty.c b/tools/perf/examples/bpf/empty.c
index 3776d26db9e7..7d7fb0c9fe76 100644
--- a/tools/perf/examples/bpf/empty.c
+++ b/tools/perf/examples/bpf/empty.c
@@ -1,3 +1,3 @@
-#include <bpf.h>
+#include <bpf/bpf.h>
 
 license(GPL);
diff --git a/tools/perf/examples/bpf/sys_enter_openat.c b/tools/perf/examples/bpf/sys_enter_openat.c
index 9cd124b09392..c4481c390d23 100644
--- a/tools/perf/examples/bpf/sys_enter_openat.c
+++ b/tools/perf/examples/bpf/sys_enter_openat.c
@@ -14,7 +14,7 @@
  * the return value.
  */
 
-#include <bpf.h>
+#include <bpf/bpf.h>
 
 struct syscall_enter_openat_args {
 	unsigned long long unused;
diff --git a/tools/perf/include/bpf/pid_filter.h b/tools/perf/include/bpf/pid_filter.h
index 6e61c4bdf548..607189a315b2 100644
--- a/tools/perf/include/bpf/pid_filter.h
+++ b/tools/perf/include/bpf/pid_filter.h
@@ -3,7 +3,7 @@
 #ifndef _PERF_BPF_PID_FILTER_
 #define _PERF_BPF_PID_FILTER_
 
-#include <bpf.h>
+#include <bpf/bpf.h>
 
 #define pid_filter(name) pid_map(name, bool)
 
diff --git a/tools/perf/include/bpf/stdio.h b/tools/perf/include/bpf/stdio.h
index 316af5b2ff35..7ca6fa5463ee 100644
--- a/tools/perf/include/bpf/stdio.h
+++ b/tools/perf/include/bpf/stdio.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <bpf.h>
+#include <bpf/bpf.h>
 
 struct bpf_map SEC("maps") __bpf_stdout__ = {
        .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
diff --git a/tools/perf/include/bpf/unistd.h b/tools/perf/include/bpf/unistd.h
index ca7877f9a976..d1a35b6c649d 100644
--- a/tools/perf/include/bpf/unistd.h
+++ b/tools/perf/include/bpf/unistd.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
 
-#include <bpf.h>
+#include <bpf/bpf.h>
 
 static int (*bpf_get_current_pid_tgid)(void) = (void *)BPF_FUNC_get_current_pid_tgid;
 


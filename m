Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF0ED13DB79
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 14:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgAPNW1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 08:22:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57011 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728600AbgAPNWZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 08:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579180943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2f/3xqMCvPgjOWRi/4hBoG4txZFOAtpty8CahkBiCk=;
        b=Bgp/qYsqcOk2AhDapd2Wap7sK6dE8tf4Sil4oO2eXOM5Kw0G6ia2JeInEazedmARE/e479
        Ku1vOAUuGPXEEGlo4dBzbiLpbMizqVYk0VcyS6EVcIYjcEhVL2EGdq31VFFL3nBNyN5UR4
        MQoeLKi133x46YEi0soSHr8dRiGmfuc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-32SglkflOIe6nEywvsM1xQ-1; Thu, 16 Jan 2020 08:22:22 -0500
X-MC-Unique: 32SglkflOIe6nEywvsM1xQ-1
Received: by mail-lj1-f198.google.com with SMTP id y24so5143487ljc.19
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 05:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=L2f/3xqMCvPgjOWRi/4hBoG4txZFOAtpty8CahkBiCk=;
        b=PmKnYXeztRqjfyD7I/ye1VNdev7nl40W8C2aS6g1TNZ1kpS3xaAnxKDtTv2djoZFgj
         9oWgPIggvEK1WeHqv33buv+ddCpGsGpdP4lEueqULACOwAygHGz/yLwCkSeCFtjaN9j5
         QN0U65foAaUeAXRCOQNeY3vnerWyFLq0GICYR9TSs5eslwfFc8sLfvFEaMuE61OVkGH9
         zfoD+zr3Vlx/SwZ/POGnbwsXl+JFA1k01HW9PjnablhQV3gPavSLLCvxcolMy+BGXti6
         JPVXlPuaNhwGQ4WCrDjdYCwC5IMJJRtfm90t/B6zJWrS3JS9A46hoQJP4dJuIPJFhmQt
         aVGg==
X-Gm-Message-State: APjAAAW33/HVk7wlPES2I/LZZcPSeaR5VyLJQHlY1A2cj5qFevdtaclE
        gjn8bZVdI1SAo0vUjowpQQnT7u177Jn7nmJa2dE0vCjL6UGXkn4xs14B10MldCEhPYva5HEA1tP
        3IaOxEjEDnpw5
X-Received: by 2002:ac2:4909:: with SMTP id n9mr2519589lfi.21.1579180941345;
        Thu, 16 Jan 2020 05:22:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqx7RbKsEGJIf7RVSb+wmQgd/Ns/aKeN6fJ+QOjJln4n2arZhUQqGwufoE6/BjDygelwzJbXtw==
X-Received: by 2002:ac2:4909:: with SMTP id n9mr2519569lfi.21.1579180941159;
        Thu, 16 Jan 2020 05:22:21 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o12sm10794767ljj.79.2020.01.16.05.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:22:20 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9E2171804D7; Thu, 16 Jan 2020 14:22:19 +0100 (CET)
Subject: [PATCH bpf-next v3 07/11] perf: Use consistent include paths for
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
Date:   Thu, 16 Jan 2020 14:22:19 +0100
Message-ID: <157918093952.1357254.13512235914811343382.stgit@toke.dk>
In-Reply-To: <157918093154.1357254.7616059374996162336.stgit@toke.dk>
References: <157918093154.1357254.7616059374996162336.stgit@toke.dk>
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
 


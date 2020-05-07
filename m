Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578471C8DF7
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgEGOKm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgEGOIi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:08:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AE0C05BD09
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 07:08:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n205so7152685ybf.14
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 07:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kaPuV4QeaPOgBS5KpMFoLQOvshqKxuzG67jCzUS9Y1Y=;
        b=t2vdQIPvTuaw1GcoNMlIdPgAkxtEo+9rt91Cg8ynmpG7HRj0sNH+uXO+nsyQr302z1
         /psxBlb4K9AhGUT8UfXLdXWjTrQYnxS3JgzmYGxCRti3kZubOn5DSU3gMHaFcCqiYnOW
         Luhm0zXQcVY7M9bZlTgLDwOn1cKf85agkyjFmgT000/0HA8plWGcOmM2p4z1OvLO7UXM
         zEq5/8CqGU7ImpXX9K1Jb4hCAl2X+hT5/5GE4dCXEBpGASUVhx83a/xO5ssuh3dLGDH4
         yqBNUsWKsqN+auXqPJdXVAr6gCZWNybyTXIGzVaps33XJSyIt8qGR4kAzkUsj4D6FK/I
         7N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kaPuV4QeaPOgBS5KpMFoLQOvshqKxuzG67jCzUS9Y1Y=;
        b=O6R1WkT/ThE21R1zy3BpNc6CB8d6uVKYjx1uCxkF80hfN6gMNQAxvOilZuZVGgv9nV
         d3tBmfsbl3Ni7MYQZbNgf4JFKMzn4uIiCMQ5fLiGd2Yo0AZ3lvzXAZFizM59bN83eEWG
         znti7X2RFSxGeWvKAYRC5kJM+ceVt4W9u9OoTg3sQhQ5taAC+mgedNeZlyxL4/YYzTGV
         Fgz/ObzENuUAwlXx8veZHT98pNgHBaoYzkNdaCGyCw5p8TdwnvBhxvQiuXzPnRwc897/
         Y0uV7lRHN92laeop7+zwyhNwblSR7R8Og5vKfWqTjK27cXfwzaLvv3cZHYvBepUZwpzN
         MJIw==
X-Gm-Message-State: AGi0PuZ7aw8dscK51eKVkHnCDVOBmXqpsRnRq32UGAC0uTZKYDCqjErH
        kBo64MSo9LoY04SSQJeE0WTFKLC2XKG7
X-Google-Smtp-Source: APiQypIj0TNxD8t6MORWi035rqjdD5V07jI6QDPkaYQHb6E8+t4cGs+uY73czbk+WmzTznhG2kkioDjdNb17
X-Received: by 2002:a25:848d:: with SMTP id v13mr16679607ybk.493.1588860517380;
 Thu, 07 May 2020 07:08:37 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:03 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-8-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 07/23] perf expr: debug lex if debugging yacc
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

Only effects parser debugging (disabled by default). Enables displaying
'--accepting rule at line .. ("...").

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index aa631e37ad1e..8b4ce704a68d 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -45,6 +45,7 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 
 #ifdef PARSER_DEBUG
 	expr_debug = 1;
+	expr_set_debug(1, scanner);
 #endif
 
 	ret = expr_parse(val, ctx, scanner);
-- 
2.26.2.526.g744177e7f7-goog


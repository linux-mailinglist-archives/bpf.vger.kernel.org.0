Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CBE1CA2C1
	for <lists+bpf@lfdr.de>; Fri,  8 May 2020 07:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgEHFg6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 May 2020 01:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgEHFg5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 May 2020 01:36:57 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C3EC05BD0A
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 22:36:56 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a18so885682qkl.0
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 22:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qye1SVonTjqMOsVJuQeCBVCNLKV3+4pjVh0/bspBuQI=;
        b=CbDfIOxVT2dx5RZ83D4pkiUFNFhJ1sVAiBjizdkmRAvy0BO+EEXFy/kOCH2+kOlyzC
         2HkZMRFi8zBHJVdpkv5SmTDm4wXrXSakYtZCKlFJy6GE9FCbZQS6v/BiCflmUiUKit5Q
         DtUESQzY5X6tgPPinxek9XaFvK95W5b2w1Vcxd4THyaoSj/8IfeWeMHFwOQ4niq6AI0h
         W1U0ZFn+S7qzVA6xC1h2trc43J0goe2fQ1PUJQwoPCsepiASp2TgeMIOv73mkynRu/mX
         T7oFZtsStM9SlRg7yw7whM1bd5C03VhGgYbFMoKesas0wrfRbgzNS2BNLzIJgkL0jl0I
         /xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qye1SVonTjqMOsVJuQeCBVCNLKV3+4pjVh0/bspBuQI=;
        b=DP47P50eSkYmSe1F+kaoZMpnztMrs/dIQvR9thBW/vmrhW3zFds4YMcrj536/K2ZVf
         wuzz4N1ABjEQwUZUGuAzRaYj+IFialdzWHpsQbWY6ikfePOstYRV0LLMIFhWUStMXMcj
         aMLj4sMLQyiNsZvSIvmDOSl+HbBzKunTnXFrIf/sBmK0W/Fx8JF5Iw0nmXGqM5XEKWSc
         U2sQt8Dna7IWZkugWQMz/OE672f5sNoqj/nNKTdRZ+yJI7wlG0brZql0UR+IULWIhULQ
         xfhfpi2mlfXHXGMJG/2/ZgMuM71az0DIPcw/63Mc/PLWS0DzQJU6WzjMS0tZmorE/vkL
         fVpA==
X-Gm-Message-State: AGi0PuaJN/IAz1iSBOOifdan0oZxK+rO93Gvh6G4LXel95KlYrAGvKb5
        YffD2FesYzFwtmhW5MaND3mO6BJ8q4sA
X-Google-Smtp-Source: APiQypJ1fookbhjSVt29vq8vulwRv7GbvsjbjS5kIOZ8ULGRiQnYVCkmIhCpb3LShI5EaEMa3+PzanIRhgqz
X-Received: by 2002:a05:6214:18c9:: with SMTP id cy9mr1066619qvb.35.1588916215992;
 Thu, 07 May 2020 22:36:55 -0700 (PDT)
Date:   Thu,  7 May 2020 22:36:27 -0700
In-Reply-To: <20200508053629.210324-1-irogers@google.com>
Message-Id: <20200508053629.210324-13-irogers@google.com>
Mime-Version: 1.0
References: <20200508053629.210324-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [RFC PATCH v3 12/14] perf metricgroup: order event groups by size
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
        Vince Weaver <vincent.weaver@maine.edu>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When adding event groups to the group list, insert them in size order.
This performs an insertion sort on the group list. By placing the
largest groups at the front of the group list it is possible to see if a
larger group contains the same events as a later group. This can make
the later group redundant - it can reuse the events from the large group.
A later patch will add this sharing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 2a6456fa178b..69fbff47089f 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -520,7 +520,21 @@ static int __metricgroup__add_metric(struct list_head *group_list,
 		return -EINVAL;
 	}
 
-	list_add_tail(&eg->nd, group_list);
+	if (list_empty(group_list))
+		list_add(&eg->nd, group_list);
+	else {
+		struct list_head *pos;
+
+		/* Place the largest groups at the front. */
+		list_for_each_prev(pos, group_list) {
+			struct egroup *old = list_entry(pos, struct egroup, nd);
+
+			if (hashmap__size(&eg->pctx.ids) <=
+			    hashmap__size(&old->pctx.ids))
+				break;
+		}
+		list_add(&eg->nd, pos);
+	}
 
 	return 0;
 }
-- 
2.26.2.645.ge9eca65c58-goog


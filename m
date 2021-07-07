Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C7C3BF196
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 23:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhGGVvo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 17:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233072AbhGGVvn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Jul 2021 17:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625694542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N6Lkp9H+PeXEJohL6vruWVGim8bb8jO4Rintdh3j+00=;
        b=VP32trsuwK7tdMZr5qDxW/pTWB54JJJGJeHr3B6hRge1Y3c664xpmIWf2TiHOVG+ADcS8X
        steStxfGmnTPM10WdMKacyRu26gXzMRthaoZGrV2z5vCw7UiwOPNdfwhHGQxczVrp1nwuL
        ehLHt5Pw8oyJe0oJE5MUZmnysIrpOBg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-MMn0LmJMPHGZL-tLnomIBg-1; Wed, 07 Jul 2021 17:49:01 -0400
X-MC-Unique: MMn0LmJMPHGZL-tLnomIBg-1
Received: by mail-wm1-f72.google.com with SMTP id t12-20020a7bc3cc0000b02901f290c9c44eso1534276wmj.7
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 14:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N6Lkp9H+PeXEJohL6vruWVGim8bb8jO4Rintdh3j+00=;
        b=T/L0900DCyAJn7CFnZKCJ1eOVEbHCDffrqpEYyM4Md5Alc4+yoSa13pRoLZM2n13ZR
         3i3nzpaIxusftyDI0jvQZelFCpLRNzj0Wjjs0VUJjHLKKNgocywHqMB6I+NtGlsiVi/n
         HuczWKEzCfJrp0UURzq4IOsv6AXUHUN7S0PhaOEFpHJQcH1qmwPrJq9ZkXaHOrE7f47j
         zVyoMKtzA57AzCHL2q52bh+BUYfSSLafcevGhU8VjS0JKX7K9e9iwqjRE+CB+hGQXgnj
         2ld/B0Q3sRHdVK4tfMybO5yHgh6IIAo5JqOxaaJW00LXQKQl5IUa0YCTivAyhdZYxBDf
         DT1g==
X-Gm-Message-State: AOAM530IIXjoA0S5wJZ+WcGTTbY8Cq2Cm6SobRcbNVXe72+Y37dsiz1n
        hBzpvsmaugVwpY3Og1RRz/qD4+Wo3/GWX+gr8vcd33t2DyGBMVw+4seX5vUphrI/mD1RNmWZnem
        Q3FXWCV1GtsAo
X-Received: by 2002:adf:9466:: with SMTP id 93mr30832144wrq.340.1625694540668;
        Wed, 07 Jul 2021 14:49:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs/zK/o/CEalUgy0txiMvjZKapygMpZixoKK0bABasdS9LEUn7Zpd1LxDLk2h3Osby8JMxBg==
X-Received: by 2002:adf:9466:: with SMTP id 93mr30832125wrq.340.1625694540543;
        Wed, 07 Jul 2021 14:49:00 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id c16sm144524wmr.2.2021.07.07.14.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 14:49:00 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCHv3 bpf-next 6/7] libbpf: allow specification of "kprobe/function+offset"
Date:   Wed,  7 Jul 2021 23:47:50 +0200
Message-Id: <20210707214751.159713-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210707214751.159713-1-jolsa@kernel.org>
References: <20210707214751.159713-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alan Maguire <alan.maguire@oracle.com>

kprobes can be placed on most instructions in a function, not
just entry, and ftrace and bpftrace support the function+offset
notification for probe placement.  Adding parsing of func_name
into func+offset to bpf_program__attach_kprobe() allows the
user to specify

SEC("kprobe/bpf_fentry_test5+0x6")

...for example, and the offset can be passed to perf_event_open_probe()
to support kprobe attachment.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1e04ce724240..60c9e3e77684 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10309,11 +10309,25 @@ struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
 					    const char *func_name)
 {
 	char errmsg[STRERR_BUFSIZE];
+	char func[BPF_OBJ_NAME_LEN];
+	unsigned long offset = 0;
 	struct bpf_link *link;
-	int pfd, err;
+	int pfd, err, n;
+
+	n = sscanf(func_name, "%[a-zA-Z0-9_.]+%lx", func, &offset);
+	if (n < 1) {
+		err = -EINVAL;
+		pr_warn("kprobe name is invalid: %s\n", func_name);
+		return libbpf_err_ptr(err);
+	}
+	if (retprobe && offset != 0) {
+		err = -EINVAL;
+		pr_warn("kretprobes do not support offset specification\n");
+		return libbpf_err_ptr(err);
+	}
 
-	pfd = perf_event_open_probe(false /* uprobe */, retprobe, func_name,
-				    0 /* offset */, -1 /* pid */);
+	pfd = perf_event_open_probe(false /* uprobe */, retprobe, func,
+				    offset, -1 /* pid */);
 	if (pfd < 0) {
 		pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
 			prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
-- 
2.31.1


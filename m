Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7959E3BF07E
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 21:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhGGTtw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 15:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233086AbhGGTtu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Jul 2021 15:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625687229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N6Lkp9H+PeXEJohL6vruWVGim8bb8jO4Rintdh3j+00=;
        b=Z2PpmaxhScqQGLUL6IQM8yOFVU3NPEuV995gMNMgerMFQ5RxYOj6c8BzPSppHwGWZoXL8Y
        KCs6rS2PJRAoYenBJwSM1W0H5ufXBtRW4ApCpUIHaJkwYCf+hUcWvI7laRm6n5CuPFZzVM
        D7x9N9UN+jkwdkUzQ+q7fzJbKQSkLts=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-kYbJR8WSMeq_rgPzqooUpg-1; Wed, 07 Jul 2021 15:47:08 -0400
X-MC-Unique: kYbJR8WSMeq_rgPzqooUpg-1
Received: by mail-wm1-f71.google.com with SMTP id l3-20020a05600c1d03b029021076e2b2f6so2547590wms.4
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 12:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N6Lkp9H+PeXEJohL6vruWVGim8bb8jO4Rintdh3j+00=;
        b=LzEjqrw36Ri/a25Pk2weuv279ov7YsAIuyak+jbm035lK5REMEetzIigb0xRmMxLgo
         9tYGXLHGME7PT+vxRn8QaiNHRNcpm+J3yOYIw7xhHwQbR5eQno3nEE+DrxZXhNdf3wAn
         qGAeuVtZErgx3OnPIisaaqsg7LWyhzCxCD3kpvz3HtiOAE+KvgHJbKOZkpzvJHM+C8TK
         Rup1Dd2X5m4zpkTOEfasNb9fUhHjv7rHIECKcypB0/f9F3Tg4fn0Ogy1Buk3PFHa3xRj
         vn0wEJ1Xa8xJa+lfg2udcgpprDw/1ZJZFf5xmALfO5A4fGU3niCCJEm5D0+mu08Ml6Hv
         8wNg==
X-Gm-Message-State: AOAM533e5R9VAQC6etT7fDuo85IWHmyeIWOt/Ja6BJjfxYrN8sAg9B1w
        JmhSk0xLNmDeXnMbfQrt8DA5rvXeh4oTkOhn3GTDdt7Dka3yg7hwlL/k0hfsuFeeLX4Tp380dAR
        oMQgb2nrinuEZ
X-Received: by 2002:a1c:4302:: with SMTP id q2mr792617wma.37.1625687227560;
        Wed, 07 Jul 2021 12:47:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwx6Hij6OUVN0HPvFYTpi+Y4VHcPBqilpZnkPQP9PAJQEeBMChoVHxNTGuD6GH5ZZ0UJXu2rA==
X-Received: by 2002:a1c:4302:: with SMTP id q2mr792598wma.37.1625687227390;
        Wed, 07 Jul 2021 12:47:07 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id l20sm20208357wmq.3.2021.07.07.12.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 12:47:07 -0700 (PDT)
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
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH 6/7] libbpf: allow specification of "kprobe/function+offset"
Date:   Wed,  7 Jul 2021 21:46:18 +0200
Message-Id: <20210707194619.151676-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210707194619.151676-1-jolsa@kernel.org>
References: <20210707194619.151676-1-jolsa@kernel.org>
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


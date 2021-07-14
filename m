Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBC13C81F9
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 11:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbhGNJrq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 05:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238964AbhGNJrp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Jul 2021 05:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626255894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gS2TUzSMuzLBnMpE+3kD0qi4Lo6QsgvFke4iFwk++og=;
        b=QZXZz3j58JpAMQE8T8mWZn6v8mF8ZlkEtKSwBsC9lUiOCiWfLZFwq6CQDfC/ieHqp48GXa
        8p2I9/MRvT7l4U/FNk8HlnNtCSOzP5L5nymoTGBcQXLsrYVLnPUKEt28+VSA1KN4tKpeuf
        Jk2YwVN7WpN6mLFvFKXhs8KqZZOVIzM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-fPEVnAf7PKae79kSdG22YA-1; Wed, 14 Jul 2021 05:44:53 -0400
X-MC-Unique: fPEVnAf7PKae79kSdG22YA-1
Received: by mail-wm1-f69.google.com with SMTP id b26-20020a7bc25a0000b0290218757e2783so567322wmj.7
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 02:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gS2TUzSMuzLBnMpE+3kD0qi4Lo6QsgvFke4iFwk++og=;
        b=fcTGjLZNFjOJmql4N6XeVjK7xbHV7qhCUt5jilclfZJaxpJWYHp9g9PLUH2ApOXHL5
         SrA8RYyyBUYKUS8VSp6A+Iv5B2cP82LnJUicucBshb+6pYWwMRwi75CmQopSZyNrAaEE
         gD4iAaKtBxGDhqeMI8SLUlq7jpHZUrwdAwxdAYjVe4Ic7PhsisvtNA1PhIfzeJQRCH8Z
         fIvsR9Gl080yS9Qvo+ZBUoaircWwZ4JdMMT5F5JZ7d5LR5nSIJAGEO10/HPKsI5wgYUp
         8e14nOWf9PDhiB3KTIdPHj8aOCG3GG+ovvQEmuwrGUGjYHiQXk4k4WWGra6FO/KA/hqF
         0vGA==
X-Gm-Message-State: AOAM5319s/imxWugCH0b5nxpRBDOk+/OGzWeScFkZV7/0FqURX24YQ5r
        0rn9H3WlsyBkKA65QiyFswL/w/TzRMUTa/5lDT2FffodEVifTfL2gqAeqa7HVJDXiU2ae5BFAcm
        OBFx8OPG714b9
X-Received: by 2002:a5d:58d6:: with SMTP id o22mr12007032wrf.307.1626255892109;
        Wed, 14 Jul 2021 02:44:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzopcNaGLLt7E6TkmR1jeyOlECEvn3WL1uHMzljuZ/xIarhd2afZNQp9cQ7vRgN7IuLJj4GGQ==
X-Received: by 2002:a5d:58d6:: with SMTP id o22mr12007013wrf.307.1626255891909;
        Wed, 14 Jul 2021 02:44:51 -0700 (PDT)
Received: from krava.redhat.com ([5.171.203.6])
        by smtp.gmail.com with ESMTPSA id a64sm1511979wme.8.2021.07.14.02.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 02:44:51 -0700 (PDT)
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
Subject: [PATCHv4 bpf-next 6/8] libbpf: Add bpf_program__attach_kprobe_opts function
Date:   Wed, 14 Jul 2021 11:43:58 +0200
Message-Id: <20210714094400.396467-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714094400.396467-1-jolsa@kernel.org>
References: <20210714094400.396467-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding bpf_program__attach_kprobe_opts that does the same
as bpf_program__attach_kprobe, but takes opts argument.

Currently opts struct holds just retprobe bool, but we will
add new field in following patch.

The function is not exported, so there's no need to add
size to the struct bpf_program_attach_kprobe_opts for now.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 88b99401040c..d93a6f9408d1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10346,19 +10346,24 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	return pfd;
 }
 
-struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
-					    bool retprobe,
-					    const char *func_name)
+struct bpf_program_attach_kprobe_opts {
+	bool retprobe;
+};
+
+static struct bpf_link*
+bpf_program__attach_kprobe_opts(struct bpf_program *prog,
+				const char *func_name,
+				struct bpf_program_attach_kprobe_opts *opts)
 {
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int pfd, err;
 
-	pfd = perf_event_open_probe(false /* uprobe */, retprobe, func_name,
+	pfd = perf_event_open_probe(false /* uprobe */, opts->retprobe, func_name,
 				    0 /* offset */, -1 /* pid */);
 	if (pfd < 0) {
 		pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
-			prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
+			prog->name, opts->retprobe ? "kretprobe" : "kprobe", func_name,
 			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return libbpf_err_ptr(pfd);
 	}
@@ -10367,23 +10372,34 @@ struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
 	if (err) {
 		close(pfd);
 		pr_warn("prog '%s': failed to attach to %s '%s': %s\n",
-			prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
+			prog->name, opts->retprobe ? "kretprobe" : "kprobe", func_name,
 			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
 		return libbpf_err_ptr(err);
 	}
 	return link;
 }
 
+struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
+					    bool retprobe,
+					    const char *func_name)
+{
+	struct bpf_program_attach_kprobe_opts opts = {
+		.retprobe = retprobe,
+	};
+
+	return bpf_program__attach_kprobe_opts(prog, func_name, &opts);
+}
+
 static struct bpf_link *attach_kprobe(const struct bpf_sec_def *sec,
 				      struct bpf_program *prog)
 {
+	struct bpf_program_attach_kprobe_opts opts;
 	const char *func_name;
-	bool retprobe;
 
 	func_name = prog->sec_name + sec->len;
-	retprobe = strcmp(sec->sec, "kretprobe/") == 0;
+	opts.retprobe = strcmp(sec->sec, "kretprobe/") == 0;
 
-	return bpf_program__attach_kprobe(prog, retprobe, func_name);
+	return bpf_program__attach_kprobe_opts(prog, func_name, &opts);
 }
 
 struct bpf_link *bpf_program__attach_uprobe(struct bpf_program *prog,
-- 
2.31.1


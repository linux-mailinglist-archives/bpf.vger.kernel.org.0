Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA93F3D1980
	for <lists+bpf@lfdr.de>; Wed, 21 Jul 2021 23:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhGUVR5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Jul 2021 17:17:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230017AbhGUVR5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 21 Jul 2021 17:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626904713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ccMewzkPCGXNEiOr3BDbhXGwV/AjKpWpsb/2bGggAwo=;
        b=TbewAVkCJOhLDv3oMxJ700RVgkIyK7xaRfoOkWuRjU5LuXRIl8in6BAPolWvHzfhrs0dA3
        qzpUqXCjRjmTWdb3/0xs0Yfw8zmgPa3M6jSmAIyj7uksCWeznoc/G3rwR6kKc0HmpRXdPD
        9202i+BQzOmXOb80Zl6OdKEEMG+XVB4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-sMwAKJ5pMYCHaPRvZUEo1A-1; Wed, 21 Jul 2021 17:58:31 -0400
X-MC-Unique: sMwAKJ5pMYCHaPRvZUEo1A-1
Received: by mail-ej1-f72.google.com with SMTP id e23-20020a1709062497b0290504bafdd58dso1300547ejb.4
        for <bpf@vger.kernel.org>; Wed, 21 Jul 2021 14:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ccMewzkPCGXNEiOr3BDbhXGwV/AjKpWpsb/2bGggAwo=;
        b=fI/Vdb2SBLNHgSprkQASe/FsGNbAQ6bVAIP9my/PGLeUeCLblyJ3RQYrSNGc6pyRLl
         uuipZ5Rdn+pC0aN9/tRXecqR24rwjtQZixGxkxg+YOMoCx5Ur2o7eAvUj3hAei5yYJhc
         vZfWirS5uzXn0t6gfyKQtg5VBXr0gd1qw75fyFismNdhKMTGsQYPc23myd9Fks+Zj1iL
         oF2GB9oRJxjB65Ov7RamJjccpKJmWz2OEpQKW8fQkHMmPOJtx5HuWA8cqRLctIVw9W6g
         eAoGZtJWZyxtGYmrHiJ8WsBwJpPKfKxsCAcVTkcphExFlMAIRdIPtxP5RFWUKYueEQty
         jm6A==
X-Gm-Message-State: AOAM530D5l9LWIdW5Udi58cI43zfXf9cZX/hkgxGGTqOTeNl0Mm5IFgm
        UtObIDvDSWDPpYIk97DeWta3PNnOpXmJkKvmWfwuNT0dOcsN5KzcxbrjiozzNS9fWa7hihF6CL7
        OKXopoHKiWNUY
X-Received: by 2002:a17:906:7c6:: with SMTP id m6mr24060881ejc.456.1626904710336;
        Wed, 21 Jul 2021 14:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/d/fmsrF6DFPHn3DuoAiXFEmIbfGuX7ba1DUS37m6SD8VFG7/J9X1w43TXoUs7i7D24VnZQ==
X-Received: by 2002:a17:906:7c6:: with SMTP id m6mr24060870ejc.456.1626904710189;
        Wed, 21 Jul 2021 14:58:30 -0700 (PDT)
Received: from krava.cust.in.nbox.cz ([83.240.60.59])
        by smtp.gmail.com with ESMTPSA id v16sm10741216edc.52.2021.07.21.14.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:58:29 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 3/3] libbpf: Export bpf_program__attach_kprobe_opts function
Date:   Wed, 21 Jul 2021 23:58:10 +0200
Message-Id: <20210721215810.889975-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721215810.889975-1-jolsa@kernel.org>
References: <20210721215810.889975-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Exporting bpf_program__attach_kprobe_opts function.

Renaming bpf_program_attach_kprobe_opts to bpf_kprobe_opts
and adding 'sz' field for forward/backward compatiblity.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 31 +++++++++++++++++--------------
 tools/lib/bpf/libbpf.h   | 14 ++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 52f4f1d4f495..63a6239d8569 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10366,25 +10366,28 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	return pfd;
 }
 
-struct bpf_program_attach_kprobe_opts {
-	bool retprobe;
-	unsigned long offset;
-};
-
-static struct bpf_link*
+struct bpf_link*
 bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 				const char *func_name,
-				struct bpf_program_attach_kprobe_opts *opts)
+				struct bpf_kprobe_opts *opts)
 {
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
+	unsigned long offset;
+	bool retprobe;
 	int pfd, err;
 
-	pfd = perf_event_open_probe(false /* uprobe */, opts->retprobe, func_name,
-				    opts->offset, -1 /* pid */);
+	if (!OPTS_VALID(opts, bpf_kprobe_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	retprobe = OPTS_GET(opts, retprobe, false);
+	offset = OPTS_GET(opts, offset, 0);
+
+	pfd = perf_event_open_probe(false /* uprobe */, retprobe, func_name,
+				    offset, -1 /* pid */);
 	if (pfd < 0) {
 		pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
-			prog->name, opts->retprobe ? "kretprobe" : "kprobe", func_name,
+			prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
 			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return libbpf_err_ptr(pfd);
 	}
@@ -10393,7 +10396,7 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 	if (err) {
 		close(pfd);
 		pr_warn("prog '%s': failed to attach to %s '%s': %s\n",
-			prog->name, opts->retprobe ? "kretprobe" : "kprobe", func_name,
+			prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
 			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
 		return libbpf_err_ptr(err);
 	}
@@ -10404,9 +10407,9 @@ struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
 					    bool retprobe,
 					    const char *func_name)
 {
-	struct bpf_program_attach_kprobe_opts opts = {
+	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts,
 		.retprobe = retprobe,
-	};
+	);
 
 	return bpf_program__attach_kprobe_opts(prog, func_name, &opts);
 }
@@ -10414,7 +10417,7 @@ struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
 static struct bpf_link *attach_kprobe(const struct bpf_sec_def *sec,
 				      struct bpf_program *prog)
 {
-	struct bpf_program_attach_kprobe_opts opts;
+	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
 	unsigned long offset = 0;
 	struct bpf_link *link;
 	const char *func_name;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 6b08c1023609..da4a63a1265d 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -104,6 +104,16 @@ struct bpf_object_open_opts {
 };
 #define bpf_object_open_opts__last_field btf_custom_path
 
+struct bpf_kprobe_opts {
+	/* size of this struct, for forward/backward compatiblity */
+	size_t sz;
+	/* kprobe is return probe */
+	bool retprobe;
+	/* function's offset to install kprobe to */
+	unsigned long offset;
+};
+#define bpf_kprobe_opts__last_field offset
+
 LIBBPF_API struct bpf_object *bpf_object__open(const char *path);
 LIBBPF_API struct bpf_object *
 bpf_object__open_file(const char *path, const struct bpf_object_open_opts *opts);
@@ -249,6 +259,10 @@ bpf_program__attach_perf_event(struct bpf_program *prog, int pfd);
 LIBBPF_API struct bpf_link *
 bpf_program__attach_kprobe(struct bpf_program *prog, bool retprobe,
 			   const char *func_name);
+LIBBPF_API struct bpf_link*
+bpf_program__attach_kprobe_opts(struct bpf_program *prog,
+                                const char *func_name,
+                                struct bpf_kprobe_opts *opts);
 LIBBPF_API struct bpf_link *
 bpf_program__attach_uprobe(struct bpf_program *prog, bool retprobe,
 			   pid_t pid, const char *binary_path,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 5bfc10722647..887d372a3f27 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -372,6 +372,7 @@ LIBBPF_0.5.0 {
 	global:
 		bpf_map__initial_value;
 		bpf_map_lookup_and_delete_elem_flags;
+		bpf_program__attach_kprobe_opts;
 		bpf_object__gen_loader;
 		btf_dump__dump_type_data;
 		libbpf_set_strict_mode;
-- 
2.31.1


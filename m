Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778A54A5204
	for <lists+bpf@lfdr.de>; Mon, 31 Jan 2022 23:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiAaWFk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 17:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiAaWFk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 17:05:40 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19859C06173B
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 14:05:40 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id h14so13758898plf.1
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 14:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YajtlJpKYNiMxWIJ+XKLL9zdOvWMdv62yuGFR7mYRog=;
        b=fk3naXrQYarscoIp0+Y1QXosH9JNx/OFW4ZRws6aE+NSRs2uPD2JY7wLH0f1jdVWdh
         C3CyekcfpKhNKstC124DJZZZfYbxH9lI07FpWdYHHlQylwwzImEI8fGlyb6Gszph/wR3
         IMC4VRUjh5tPovft/jMC47grvqW74iFauFLxJQstnJqkM1ZNM8YXmJqOXLREKmCddBsT
         Kq964TuBYrdHC1ws1xGpPEBuc0jEpC7DZ5vakBJEbbTG/bzJp5OtfdVTePl8AzoWmMnU
         QmvuvAEwrlMNPi26s3qeNzkgUZoxjJB3a4qPboNdg3faGdu3p3y44WTNtF7TTalQYmU/
         zpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YajtlJpKYNiMxWIJ+XKLL9zdOvWMdv62yuGFR7mYRog=;
        b=F4fr6R3eeWG815KPPOEsUQQ62DCkgs4pDT+MY3uFPcfQCmoZ55Hom4KT868aY0twq4
         z0jYixVNhO5A3S71YZG6mAPkGHfpzmrCwz/yd68zRol9PSB3Jk1FcpyCbbzDROe7DYYh
         bIzQuz5BXTUCXwhvQGQeJw2rWq5GTDhXsQEDGLgdX3sMlkAPej4cdshsIZNnh7nk9N6o
         cBFTSzNBfzOsKVqqwTfOWt5qUV01BhCyriXWO+ISHQR9J+y3BH/IZwYpZgKrNrV1Opkt
         TktKyyZDMinjCn3vTCyByLqWLzrPOJz9S27SboqeNf0xwwuKHEsru7k7dmZ/GTedCopt
         p/qA==
X-Gm-Message-State: AOAM533jYiq18JrkPCl0kH5Lm8FwICkRU3/ax6KlX4PfGbBvC2qPm0ms
        9oaw4jHWPEo+TwvT5XStfws=
X-Google-Smtp-Source: ABdhPJx6Nh0zqTysENrK/+U7X17+2uDvKlMrxq9IIBnJ8/KSg1Ine3YHGEbu7O2ls2gSMrmMl/Akbg==
X-Received: by 2002:a17:902:d48a:: with SMTP id c10mr22726849plg.139.1643666739534;
        Mon, 31 Jan 2022 14:05:39 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:78b6])
        by smtp.gmail.com with ESMTPSA id z13sm20202210pfj.23.2022.01.31.14.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:05:39 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next 3/7] libbpf: Open code raw_tp_open and link_create commands.
Date:   Mon, 31 Jan 2022 14:05:24 -0800
Message-Id: <20220131220528.98088-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
References: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Open code raw_tracepoint_open and link_create used by light skeleton
to be able to avoid full libbpf eventually.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/gen.c       |  6 +++---
 tools/lib/bpf/skel_internal.h | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 8eacfc79ec43..eacfc6a2060d 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -381,13 +381,13 @@ static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
 		switch (bpf_program__type(prog)) {
 		case BPF_PROG_TYPE_RAW_TRACEPOINT:
 			tp_name = strchr(bpf_program__section_name(prog), '/') + 1;
-			printf("\tint fd = bpf_raw_tracepoint_open(\"%s\", prog_fd);\n", tp_name);
+			printf("\tint fd = skel_raw_tracepoint_open(\"%s\", prog_fd);\n", tp_name);
 			break;
 		case BPF_PROG_TYPE_TRACING:
 			if (bpf_program__expected_attach_type(prog) == BPF_TRACE_ITER)
-				printf("\tint fd = bpf_link_create(prog_fd, 0, BPF_TRACE_ITER, NULL);\n");
+				printf("\tint fd = skel_link_create(prog_fd, 0, BPF_TRACE_ITER);\n");
 			else
-				printf("\tint fd = bpf_raw_tracepoint_open(NULL, prog_fd);\n");
+				printf("\tint fd = skel_raw_tracepoint_open(NULL, prog_fd);\n");
 			break;
 		default:
 			printf("\tint fd = ((void)prog_fd, 0); /* auto-attach not supported */\n");
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 57507f1c1934..dcd3336512d4 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -110,6 +110,32 @@ static inline int skel_map_update_elem(int fd, const void *key,
 	return skel_sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, attr_sz);
 }
 
+static inline int skel_raw_tracepoint_open(const char *name, int prog_fd)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, raw_tracepoint.prog_fd);
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+	attr.raw_tracepoint.name = (long) name;
+	attr.raw_tracepoint.prog_fd = prog_fd;
+
+	return skel_sys_bpf(BPF_RAW_TRACEPOINT_OPEN, &attr, attr_sz);
+}
+
+static inline int skel_link_create(int prog_fd, int target_fd,
+				   enum bpf_attach_type attach_type)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, link_create.iter_info_len);
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+	attr.link_create.prog_fd = prog_fd;
+	attr.link_create.target_fd = target_fd;
+	attr.link_create.attach_type = attach_type;
+
+	return skel_sys_bpf(BPF_LINK_CREATE, &attr, attr_sz);
+}
+
 static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 {
 	int map_fd = -1, prog_fd = -1, key = 0, err;
-- 
2.30.2


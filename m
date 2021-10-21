Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC321436D0E
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 23:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhJUVuk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 17:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhJUVuh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 17:50:37 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D187C061764
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 14:48:20 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id z7-20020a63c047000000b0026b13e40309so749268pgi.19
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 14:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=22on5KurhSC/wMRpOkSDnD2o7Xe4/6kDPgHAo+gdVWQ=;
        b=Ju+nXhRMXwpfwby1BGMyVXfOAgI5uceJpEgoaP8Ea8WD20SiCjU1sa+agLgywAXxB2
         4Wo9gYaLUSlR+/5UjCSKpJQ5XhJr+v8YFZll1rjgPf2kkBp3P7eFpqMcsDjAY4ht+P5A
         lIAV8MNEAG9Yd8phfrTpuC0PTVJiP8N5nwzCh+ZpDzAWBiJXq96y32bJICvFZzDbAOl5
         uBaKLy3+bvtv+fR6iFe6zSyOL4Ms/QuWsKHyPUwyu1oD+Bnu6FAW6XJIDAT6KGZe+lMB
         WY8tUXTegFqDYhPSZNKF/ugwKMhB9Oq6+oudtixwRjtBX1vVdVfSLNguN+RxAgBF51IP
         8OTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=22on5KurhSC/wMRpOkSDnD2o7Xe4/6kDPgHAo+gdVWQ=;
        b=KAonBZ6PO1LQc/NZYHcpXv4QjVQljRblexoYAgyVqS7ti8RvIVqyrFO3ofWq5B8HRJ
         GYVfhobvQKp67cIcRzFgi4Wa7F3cT8JV6TEEGJO+oLfP4HPZboAE8RZQ3f+E9HUDFyYO
         XgVG7NnqOk4HAT02WFZtwx4dNppOjNxwWFGh0F1Rh+YNR5jewGXLhAxlz8C3zB0bNtgI
         JGA8Q9oWMA87IG5a3XSk7oVjWFb17Z4oxxVdMtXk9nLQQoVhdtGE3LFZqmuho5mDsuE9
         M0LvjpvVk4+N1e8CD+u8X0Dn8pRpfdLgl05NLJ+rQ86zDoGJPiU8ajcPV5PAEtyuQ/N/
         S0og==
X-Gm-Message-State: AOAM533e5n/gg5KrXeLKo3C0G95HJBhfWAVg1fNA8YlkHyu+voi8/csB
        aZ2E6uLc7128h7FhbeoelmC7j3M=
X-Google-Smtp-Source: ABdhPJyMGw14K5cuWNlhmhnT3tlJtuKoK/u7P2/lYHaY0zS02XAKq8F01znSsTcq11PCmu6pwtkF4Dc=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:5d22:afc4:e329:550e])
 (user=sdf job=sendgmr) by 2002:a05:6a00:7d2:b0:47b:ab2c:7512 with SMTP id
 n18-20020a056a0007d200b0047bab2c7512mr861620pfu.27.1634852900020; Thu, 21 Oct
 2021 14:48:20 -0700 (PDT)
Date:   Thu, 21 Oct 2021 14:48:13 -0700
In-Reply-To: <20211021214814.1236114-1-sdf@google.com>
Message-Id: <20211021214814.1236114-3-sdf@google.com>
Mime-Version: 1.0
References: <20211021214814.1236114-1-sdf@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH bpf-next v5 2/3] bpftool: conditionally append / to the progtype
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Otherwise, attaching with bpftool doesn't work with strict section names.

Also, switch to libbpf strict mode to use the latest conventions
(note, I don't think we have any cli api guarantees?).

Cc: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/bpftool/main.c |  4 ++++
 tools/bpf/bpftool/prog.c | 35 +++++++++++++++++++----------------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 02eaaf065f65..8223bac1e401 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -409,6 +409,10 @@ int main(int argc, char **argv)
 	block_mount = false;
 	bin_name = argv[0];
 
+	ret = libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+	if (ret)
+		p_err("failed to enable libbpf strict mode: %d", ret);
+
 	hash_init(prog_table.table);
 	hash_init(map_table.table);
 	hash_init(link_table.table);
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 277d51c4c5d9..6fec425d5390 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1396,8 +1396,6 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 
 	while (argc) {
 		if (is_prefix(*argv, "type")) {
-			char *type;
-
 			NEXT_ARG();
 
 			if (common_prog_type != BPF_PROG_TYPE_UNSPEC) {
@@ -1407,21 +1405,26 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 			if (!REQ_ARGS(1))
 				goto err_free_reuse_maps;
 
-			/* Put a '/' at the end of type to appease libbpf */
-			type = malloc(strlen(*argv) + 2);
-			if (!type) {
-				p_err("mem alloc failed");
-				goto err_free_reuse_maps;
-			}
-			*type = 0;
-			strcat(type, *argv);
-			strcat(type, "/");
+			err = libbpf_prog_type_by_name(*argv, &common_prog_type,
+						       &expected_attach_type);
+			if (err < 0) {
+				/* Put a '/' at the end of type to appease libbpf */
+				char *type = malloc(strlen(*argv) + 2);
 
-			err = get_prog_type_by_name(type, &common_prog_type,
-						    &expected_attach_type);
-			free(type);
-			if (err < 0)
-				goto err_free_reuse_maps;
+				if (!type) {
+					p_err("mem alloc failed");
+					goto err_free_reuse_maps;
+				}
+				*type = 0;
+				strcat(type, *argv);
+				strcat(type, "/");
+
+				err = get_prog_type_by_name(type, &common_prog_type,
+							    &expected_attach_type);
+				free(type);
+				if (err < 0)
+					goto err_free_reuse_maps;
+			}
 
 			NEXT_ARG();
 		} else if (is_prefix(*argv, "map")) {
-- 
2.33.0.1079.g6e70778dc9-goog


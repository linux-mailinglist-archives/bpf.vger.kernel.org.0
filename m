Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B723C85D6
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 16:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhGNOSl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 10:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhGNOSj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Jul 2021 10:18:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B6FC06175F
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 07:15:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g12so1693776wme.2
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2e9bWP8sof1c4hjxI9a8uAGITp4HXNPUGK5CMz0uo/c=;
        b=AD9P7dIbeC/tvILoqAn/ihGMgFSzgIQk9U4kBgDLGnGk2rxQs034kvv53QS/2jiQTP
         whKo8jaRXRJlISw0LiXB87hE0eUb6Pp6+ii/W0JrkZvKordFmbt/NnfZ8e1VAfUyaQp7
         ZMgF5m5zX1yfj60svjvB1e8NqKxZLZ0eBhABFBOJqsmjVBWqp1UpcYaznOUvBo10Cdcb
         MRlY9NDSw2izpQ8YYny050IQN3Mv1SKdpmF/xH0C6F3pNRUqNUag9TPBIPV+gtMyYuL9
         Y6C2rYvcvfjtfuNI5d0pffAGEGqoFxRRH1bqxEuYU7PjCEsTv66ZtGkS6H7M8CXLeYHB
         zgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2e9bWP8sof1c4hjxI9a8uAGITp4HXNPUGK5CMz0uo/c=;
        b=BuqCWLLbJeTDtSOdo2qvQEs00jiO1sG/v+QHGk7Mxv2rIIS3vEmbXpBNIV7HAMUFX7
         UcQoOcimV0K9sRNAX2E5dpeD4/kaQ6z8aWR0UNsW0dIbJT/IkJ7b7Z24/RuHUQqibaZ+
         2M3S+Gh9l3vQEu27iLLq9LHn3vBktrRF5ydh879vrNpf7Rt3jWoLMsnbch1IQHakMlk1
         uvzAdrGIF0f71zpsmG5UfVIs5flJjy6CG6fuWJcP1EkbpvAs0wUzttarjsB0Iy9i8SNx
         SSFBROwasSB81q74fuoGV+5OGhfaTx46Qw2cPyDVuklQHCGzqmuCPs9aZAY5NdHqLTkE
         Rffw==
X-Gm-Message-State: AOAM531mHQeki9Yr9M7OjwasWP8TGEPbbk0db9d7FbU5mH2bKl5V67Dv
        TZQLLjvGBQ2hBBAh1QpY2GkICQ==
X-Google-Smtp-Source: ABdhPJx5CkeJ9H0z8Qc+tCY1bKPlX17dD3iuZG5n2melu/9cHOpMMLlMIgbFAgtz9VETXLUsNLjDcQ==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr11315586wmj.109.1626272145603;
        Wed, 14 Jul 2021 07:15:45 -0700 (PDT)
Received: from localhost.localdomain ([149.86.90.174])
        by smtp.gmail.com with ESMTPSA id a207sm6380037wme.27.2021.07.14.07.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 07:15:45 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 1/6] libbpf: rename btf__load() as btf__load_into_kernel()
Date:   Wed, 14 Jul 2021 15:15:27 +0100
Message-Id: <20210714141532.28526-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210714141532.28526-1-quentin@isovalent.com>
References: <20210714141532.28526-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As part of the effort to move towards a v1.0 for libbpf, rename
btf__load() function, used to "upload" BTF information into the kernel,
and rename it instead as btf__load_into_kernel().

This new name better reflects what the function does, and should be less
confusing.

References:

- https://github.com/libbpf/libbpf/issues/278
- https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#btfh-apis

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/lib/bpf/btf.c      | 3 ++-
 tools/lib/bpf/btf.h      | 1 +
 tools/lib/bpf/libbpf.c   | 2 +-
 tools/lib/bpf/libbpf.map | 5 +++++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b46760b93bb4..7e0de560490e 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1180,7 +1180,7 @@ int btf__finalize_data(struct bpf_object *obj, struct btf *btf)
 
 static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endian);
 
-int btf__load(struct btf *btf)
+int btf__load_into_kernel(struct btf *btf)
 {
 	__u32 log_buf_size = 0, raw_size;
 	char *log_buf = NULL;
@@ -1228,6 +1228,7 @@ int btf__load(struct btf *btf)
 	free(log_buf);
 	return libbpf_err(err);
 }
+int btf__load(struct btf *) __attribute__((alias("btf__load_into_kernel")));
 
 int btf__fd(const struct btf *btf)
 {
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index b54f1c3ebd57..b36f1b2805dc 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -46,6 +46,7 @@ LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf *base_b
 
 LIBBPF_API int btf__finalize_data(struct bpf_object *obj, struct btf *btf);
 LIBBPF_API int btf__load(struct btf *btf);
+LIBBPF_API int btf__load_into_kernel(struct btf *btf);
 LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
 				   const char *type_name);
 LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 88b99401040c..d8b7c7750402 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2768,7 +2768,7 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 		 */
 		btf__set_fd(kern_btf, 0);
 	} else {
-		err = btf__load(kern_btf);
+		err = btf__load_into_kernel(kern_btf);
 	}
 	if (sanitize) {
 		if (!err) {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 944c99d1ded3..d42f20b0e9e4 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -375,3 +375,8 @@ LIBBPF_0.5.0 {
 		bpf_object__gen_loader;
 		libbpf_set_strict_mode;
 } LIBBPF_0.4.0;
+
+LIBBPF_0.6.0 {
+	global:
+		btf__load_into_kernel;
+} LIBBPF_0.5.0;
-- 
2.30.2


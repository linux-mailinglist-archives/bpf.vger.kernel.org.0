Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAE31E4B80
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 19:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbgE0RJD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 13:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731097AbgE0RIw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 13:08:52 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D24C08C5C1
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 10:08:52 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id k11so3742721ejr.9
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 10:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ake+ZECmllu4KjoI5HH1jXA8S9PkpzaukmThdKDNcmU=;
        b=qEIqJDypMvwq/WQxXJFbsfi9MC0b7w5CtjoOu/BPko+4IuBgu8Z0qb1JSjyddg9Cp1
         FbEGHkh9jiXS3Li/XexO8U1mEBPVgcVQFphun467D9s3Z3uv/JrppbL+F/NS/mGcd/ja
         e7elLHS+lyzY3StbZZXJrvGZYnUnmdCTxvy04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ake+ZECmllu4KjoI5HH1jXA8S9PkpzaukmThdKDNcmU=;
        b=Kj9tegnS+IxPuCxu2CzsOs/jLfJRp7piqaOo9zePmlXlBGhrZSlse63KNLCl8+Es3R
         sZjVnMUW/T0DHcxOfssW4S2nZthjzhtMXlD2tAWAfRavfcLqZZa2f6VT+2s9kOzVaH0E
         kP1CnXZ39DJME4wwlibZlbBq4DVVUXmySikn8SNBr06Q92mUl5VZZ3Z2AHNwJsTz7Mms
         gKp24jutEQQja7TnKgCqkCuUcH/8TwoXKuwgjaHDimt7MVA8Mx9o3ri+MQ9I/jMjb+1c
         Icu7S6h6gy1ph+W1hyFGcq4dCX3WVANirFIicg6tinimAhc2lDd1+jxhbHU++De9n0IQ
         XWXA==
X-Gm-Message-State: AOAM5306VkDb9xyRBPIWKVX9Cj7wPhFCZuazM8AJHQKOHBpBs4EZkRQ3
        HcbC4KSjFfBSDSuJNTJAwTFpX+ihBr8=
X-Google-Smtp-Source: ABdhPJxVTX7traBXwpsonrqToKzBslZcI94UNACOACxgAotufo56gbZhV02X88DTU+1pZQMy25peNw==
X-Received: by 2002:a17:906:b299:: with SMTP id q25mr7390916ejz.448.1590599330909;
        Wed, 27 May 2020 10:08:50 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id h10sm2466273ejb.2.2020.05.27.10.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 10:08:50 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH bpf-next 6/8] libbpf: Add support for bpf_link-based netns attachment
Date:   Wed, 27 May 2020 19:08:38 +0200
Message-Id: <20200527170840.1768178-7-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200527170840.1768178-1-jakub@cloudflare.com>
References: <20200527170840.1768178-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_program__attach_nets(), which uses LINK_CREATE subcommand to create
an FD-based kernel bpf_link, for attach types tied to network namespace,
that is BPF_FLOW_DISSECTOR for the moment.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/lib/bpf/libbpf.c   | 20 ++++++++++++++++----
 tools/lib/bpf/libbpf.h   |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5d60de6fd818..a49c1eb5db64 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7894,8 +7894,8 @@ static struct bpf_link *attach_iter(const struct bpf_sec_def *sec,
 	return bpf_program__attach_iter(prog, NULL);
 }
 
-struct bpf_link *
-bpf_program__attach_cgroup(struct bpf_program *prog, int cgroup_fd)
+static struct bpf_link *
+bpf_program__attach_fd(struct bpf_program *prog, int target_fd)
 {
 	enum bpf_attach_type attach_type;
 	char errmsg[STRERR_BUFSIZE];
@@ -7915,11 +7915,11 @@ bpf_program__attach_cgroup(struct bpf_program *prog, int cgroup_fd)
 	link->detach = &bpf_link__detach_fd;
 
 	attach_type = bpf_program__get_expected_attach_type(prog);
-	link_fd = bpf_link_create(prog_fd, cgroup_fd, attach_type, NULL);
+	link_fd = bpf_link_create(prog_fd, target_fd, attach_type, NULL);
 	if (link_fd < 0) {
 		link_fd = -errno;
 		free(link);
-		pr_warn("program '%s': failed to attach to cgroup: %s\n",
+		pr_warn("program '%s': failed to attach to cgroup/netns: %s\n",
 			bpf_program__title(prog, false),
 			libbpf_strerror_r(link_fd, errmsg, sizeof(errmsg)));
 		return ERR_PTR(link_fd);
@@ -7928,6 +7928,18 @@ bpf_program__attach_cgroup(struct bpf_program *prog, int cgroup_fd)
 	return link;
 }
 
+struct bpf_link *
+bpf_program__attach_cgroup(struct bpf_program *prog, int cgroup_fd)
+{
+	return bpf_program__attach_fd(prog, cgroup_fd);
+}
+
+struct bpf_link *
+bpf_program__attach_netns(struct bpf_program *prog, int netns_fd)
+{
+	return bpf_program__attach_fd(prog, netns_fd);
+}
+
 struct bpf_link *
 bpf_program__attach_iter(struct bpf_program *prog,
 			 const struct bpf_iter_attach_opts *opts)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 1e2e399a5f2c..adf6fd9b6fe8 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -253,6 +253,8 @@ LIBBPF_API struct bpf_link *
 bpf_program__attach_lsm(struct bpf_program *prog);
 LIBBPF_API struct bpf_link *
 bpf_program__attach_cgroup(struct bpf_program *prog, int cgroup_fd);
+LIBBPF_API struct bpf_link *
+bpf_program__attach_netns(struct bpf_program *prog, int netns_fd);
 
 struct bpf_map;
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 381a7342ecfc..7ad21ba1feb6 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -263,4 +263,5 @@ LIBBPF_0.0.9 {
 		bpf_link_get_next_id;
 		bpf_program__attach_iter;
 		perf_buffer__consume;
+		bpf_program__attach_netns;
 } LIBBPF_0.0.8;
-- 
2.25.4


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9331361D99
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 12:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhDPJ7f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Apr 2021 05:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240426AbhDPJ7f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Apr 2021 05:59:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CD0C061574
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 02:59:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id v6so39987343ejo.6
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 02:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lisoivWZdn/NJWJHJwxTPZgg0k+GzP58ryC9b67p4Dk=;
        b=coWag5j2tla4lqFFGroJCpHzsajdUt10F+7CXsUsrGNevs8AZIRhaNNtNt77RcgTsM
         BYS6GCgDHNOezAdU3QJ6+2csgjtUMj9cK0JjKlpsiCotGIwk3YBrURfSLTPdBvKAwjNN
         ++IOs4nIX4LvmMkcGWHV0OhB6xidvrydzhKj7arlBtswfwdiq6FKo2b3ih0O0VDm3qYc
         PId0ARlXC/VuSrZmwsdRnl00LW6ihHB3yiejYUZjVpr3iBJdoSG5lym468jMtLPVhcaL
         gKFE6JiuGY2yx0jcuuW5Ijyb4T458DdjsGYNNLfMvLzOl3gzmJ3H1t1pYIMIl4wnCQYE
         NIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lisoivWZdn/NJWJHJwxTPZgg0k+GzP58ryC9b67p4Dk=;
        b=j+ssBbtyg3XuUn1CBaRdbxjKJeToGF12k9gUWEGEjveLyVeuYZNqCuva8bkODPpi7k
         g7Hdq6FOXoweUacjiFiz5iGz0JbGtUpIn0DVqeWykE0Udjr5Pvmwgnh8fiJdj916o86D
         virV2bSnVEmHvH1e1K4dJFtPuX4OsCmWyqcQS+OtO07zIu7LJekcef1mOHXsPCtGE7V9
         Tl129bMYBcUf44cJbIjfWY8BDIPlOKYonK7k/Whtn5tm1utfOfVjXXLXLW75+MLdux7m
         tgiReiRiMohwSdmYqdm/A2RT7hBJMAU9V+0pD04MwKOldBCHHeiLsgN7XioP6sh90fZM
         FdYQ==
X-Gm-Message-State: AOAM531lbzTelf6OpdWbOmnz0AoSIYFrkjbtR0kn7MB1YRqTmkJkoZQm
        Z62YRfYirb4NLQpt+S2h+k/KnXoDxAWOmlLe6Ppaoc2K+zZ9uuehy1UYvRVlU6dbgaztOiW9RmA
        aQR6wo5Oet6vnzWWJezY/VgYqEfovhOXNlmZwD8f+0HZJ90Q0Dw62AZiy6/HE1YCF+iWp5266
X-Google-Smtp-Source: ABdhPJzLbDQiA2vjERPTbs9KC0NtGpmHz/buk4v4CRokavY/rWYTEcr6IYdzV9Hw4x7e93b+I+/XrA==
X-Received: by 2002:a17:906:cb2:: with SMTP id k18mr7704440ejh.183.1618567149480;
        Fri, 16 Apr 2021 02:59:09 -0700 (PDT)
Received: from localhost.localdomain (93-136-90-129.adsl.net.t-com.hr. [93.136.90.129])
        by smtp.gmail.com with ESMTPSA id h15sm3926719ejs.72.2021.04.16.02.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 02:59:09 -0700 (PDT)
From:   Denis Salopek <denis.salopek@sartura.hr>
To:     bpf@vger.kernel.org
Cc:     Denis Salopek <denis.salopek@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v5 bpf-next 2/3] bpf: extend libbpf with bpf_map_lookup_and_delete_elem_flags
Date:   Fri, 16 Apr 2021 11:58:13 +0200
Message-Id: <20210416095814.2771-2-denis.salopek@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210416095814.2771-1-denis.salopek@sartura.hr>
References: <20210416095814.2771-1-denis.salopek@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_map_lookup_and_delete_elem_flags() libbpf API in order to use
the BPF_F_LOCK flag with the map_lookup_and_delete_elem() function.

Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
Cc: Yonghong Song <yhs@fb.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
---
v5: Move to the newest libbpf version (0.4.0).
---
 tools/lib/bpf/bpf.c      | 13 +++++++++++++
 tools/lib/bpf/bpf.h      |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 16 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index bba48ff4c5c0..b7c2cc12034c 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -458,6 +458,19 @@ int bpf_map_lookup_and_delete_elem(int fd, const void *key, void *value)
 	return sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
 }
 
+int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key, void *value, __u64 flags)
+{
+	union bpf_attr attr;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.map_fd = fd;
+	attr.key = ptr_to_u64(key);
+	attr.value = ptr_to_u64(value);
+	attr.flags = flags;
+
+	return sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
+}
+
 int bpf_map_delete_elem(int fd, const void *key)
 {
 	union bpf_attr attr;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 875dde20d56e..4f758f8f50cd 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -124,6 +124,8 @@ LIBBPF_API int bpf_map_lookup_elem_flags(int fd, const void *key, void *value,
 					 __u64 flags);
 LIBBPF_API int bpf_map_lookup_and_delete_elem(int fd, const void *key,
 					      void *value);
+LIBBPF_API int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key,
+						    void *value, __u64 flags);
 LIBBPF_API int bpf_map_delete_elem(int fd, const void *key);
 LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
 LIBBPF_API int bpf_map_freeze(int fd);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b9b29baf1df8..6c06267c020e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -360,5 +360,6 @@ LIBBPF_0.4.0 {
 		bpf_linker__free;
 		bpf_linker__new;
 		bpf_map__inner_map;
+		bpf_map_lookup_and_delete_elem_flags;
 		bpf_object__set_kversion;
 } LIBBPF_0.3.0;
-- 
2.26.2


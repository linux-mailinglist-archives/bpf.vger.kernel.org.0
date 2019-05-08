Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A62E17E74
	for <lists+bpf@lfdr.de>; Wed,  8 May 2019 18:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfEHQt5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 May 2019 12:49:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43499 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbfEHQt5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 May 2019 12:49:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so12805304wro.10
        for <bpf@vger.kernel.org>; Wed, 08 May 2019 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G8MAmQX+P9EF3nRW1/NWc8ojhP+nz5CJ1gNJjnmA4cg=;
        b=ZCtXN/UBXDKr4yWegjw+n02XmYzsSck/v6jyVvslNpgFHbjbp6A4UwUoVO8Q2GDcW6
         sfPlBIjoQpTTlW3zhqdygPYEUW+d0sgc2jZEN2vSA58Aa/fuObwXtGQ+XKII9hQpj4Ou
         zYRIefsbKUHbhVWUspT7mtUGtDV+8vWuDh+ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8MAmQX+P9EF3nRW1/NWc8ojhP+nz5CJ1gNJjnmA4cg=;
        b=f5MZ7LvDmXftIqL+CxwmtU6v4rthf6C2pafEQrHFXbOJ6ILCFLlSh5qep+ISWTeRph
         flV6/ohQGA5R6blZZNtpM/wKIz2VG0UYMTc6i9SNbWlyosS5kwTeHJQRVK/1ABnRkbYb
         IQYJxBoRbwTgUEiKI5J5mnSlbAqmo8TfSi5+Azo7jaIqCwC97LHoK325dyvffI0dC6fW
         zUoP7qy5flh2GlM0CbnODzA6Rug7eopN9cfIZ/0NpMupcy2J/1skrvUbeyh0YM4LzU9u
         zUgD+bVbqcJeWOkX9LSYhllFDR4IPS0wT7YhhTD0RjCu66KPJ45v1s0bCmD3saum6OOM
         Z5gw==
X-Gm-Message-State: APjAAAXqUfVQ8bA9EWgPROxxKqLqVJr15+p64O7DgoRjOTfMIDdDVfol
        7GdIsZNgasxqkntb7f0bcjhIDyo83Jbitg==
X-Google-Smtp-Source: APXvYqyeyf2CA7VpYSzZDuNqSfMjZwF1eq2NRu7M8YNjkzhh4psOodMNf6DYGHVoUoU027kZY5O7Rg==
X-Received: by 2002:adf:f548:: with SMTP id j8mr10715529wrp.171.1557334194939;
        Wed, 08 May 2019 09:49:54 -0700 (PDT)
Received: from antares.lan (b.0.9.9.d.c.a.3.f.3.d.a.b.3.c.2.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:2c3b:ad3f:3acd:990b])
        by smtp.gmail.com with ESMTPSA id q22sm3888249wmj.35.2019.05.08.09.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:49:53 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com
Cc:     Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf v2] selftests: bpf: initialize bpf_object pointers where needed
Date:   Wed,  8 May 2019 17:49:32 +0100
Message-Id: <20190508164932.28729-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190502154932.14698-1-lmb@cloudflare.com>
References: <20190502154932.14698-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are a few tests which call bpf_object__close on uninitialized
bpf_object*, which may segfault. Explicitly zero-initialise these pointers
to avoid this.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c  | 2 +-
 tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/tp_attach_query.c  | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 23b159d95c3f..b74e2f6e96d0 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -15,7 +15,7 @@ static int libbpf_debug_print(enum libbpf_print_level level,
 static int check_load(const char *file)
 {
 	struct bpf_prog_load_attr attr;
-	struct bpf_object *obj;
+	struct bpf_object *obj = NULL;
 	int err, prog_fd;
 
 	memset(&attr, 0, sizeof(struct bpf_prog_load_attr));
diff --git a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
index d636a4f39476..f9b70e81682b 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
@@ -9,7 +9,7 @@ static void test_task_fd_query_tp_core(const char *probe_name,
 	struct perf_event_attr attr = {};
 	__u64 probe_offset, probe_addr;
 	__u32 len, prog_id, fd_type;
-	struct bpf_object *obj;
+	struct bpf_object *obj = NULL;
 	__u32 duration = 0;
 	char buf[256];
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
index a2f476f91637..fb095e5cd9af 100644
--- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
+++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
@@ -13,6 +13,9 @@ void test_tp_attach_query(void)
 	struct bpf_prog_info prog_info;
 	char buf[256];
 
+	for (i = 0; i < num_progs; i++)
+		obj[i] = NULL;
+
 	snprintf(buf, sizeof(buf),
 		 "/sys/kernel/debug/tracing/events/sched/sched_switch/id");
 	efd = open(buf, O_RDONLY, 0);
-- 
2.19.1


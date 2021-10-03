Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8D2420305
	for <lists+bpf@lfdr.de>; Sun,  3 Oct 2021 18:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhJCRBV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Oct 2021 13:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhJCRBV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Oct 2021 13:01:21 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A80C0613EC
        for <bpf@vger.kernel.org>; Sun,  3 Oct 2021 09:59:33 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so2248736pjw.0
        for <bpf@vger.kernel.org>; Sun, 03 Oct 2021 09:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Acwr8XcOcTYs2qeNYiSVQYYEP2KtbiTAJ23bFDWj56o=;
        b=aw8HIJtUMujRh0zXw0TDwtP7/XJzwwlUpgxzFtePhahGO4LeTQ5WQjKFbeh2uW/tl4
         mFR4Wy7u24JMQ8+P9kya4LSQ7skNwwRSMQx+7f7lm40YyrAewxYbA0IDgnUyEHEoDNGi
         /SfU98rsk3TI5JopNx71+YOKZ+r6vidHUp/uvAnM66NvyWcNcZzC5Afy/3XRNfaxRu2F
         fb89yiIbbcDyW5C2PCfQdYEWC8A0xolOqvKzMR5AGLyEDiIlrPqawmx9E2uzbOBuky/a
         5pEx5sB1D2cRRT1HHbCXWEUfHWxA5ag1e+uVaILNd8lvqUI+qizHBgU7rBnthIxF3nbv
         Gr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Acwr8XcOcTYs2qeNYiSVQYYEP2KtbiTAJ23bFDWj56o=;
        b=oDKup33u/volvDcATTTj8G+qexLfAvsP7nXNEZQ4jDy6GEKj+xY0e1IOffZx9JifQ0
         Mm655Yo0rKSEhETAGlq/VVsM25QSyXV0haXXC4Fuydg1SAQYUoScrJJCsqskZJTRgzo6
         32lcty/NezGE/1BN8XxupHFFO4gZ4V/GQAmLTz+71uXU6z4A9IypMDfYhVqboW1/0DGN
         iIYCA1+oXT/xAdC7skrHNGf6qUl4u8XF55zKnnO2d5FkaDJAmYbOmUHDFgvuNbjKbEEr
         Q/PHNWVwYpxvRsPJld9xQWzZSC45rAZXA0Bz1vhnhM2nxLRpcQXvohcxm0NK9FInstcW
         i/WA==
X-Gm-Message-State: AOAM533oZa78b9RXuGuAW4hhL4YLwLNNT57II5tzjWA+FIr8IZkczi5z
        VAWDkEHZAJcDoM7gh99jDGnoueUS1JzQoA==
X-Google-Smtp-Source: ABdhPJyWBDSk4EWbT9EhnH08Y1tzaJYJJLJBZXBdQ5yqExc3TrqfWy3HX8g5OfF/FAo7OgOlZtoozQ==
X-Received: by 2002:a17:90b:3901:: with SMTP id ob1mr3991112pjb.24.1633280372978;
        Sun, 03 Oct 2021 09:59:32 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id e11sm11592296pfm.79.2021.10.03.09.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 09:59:32 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 2/2 v2] selftests/bpf: Switch to new bpf_object__next_{map,program} APIs
Date:   Mon,  4 Oct 2021 00:58:44 +0800
Message-Id: <20211003165844.4054931-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211003165844.4054931-1-hengqi.chen@gmail.com>
References: <20211003165844.4054931-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace deprecated bpf_{map,program}__next APIs with newly added
bpf_object__next_{map,program} APIs, so that no compilation warnings
emit.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c              | 2 +-
 tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c    | 6 +++---
 tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c          | 2 +-
 tools/testing/selftests/bpf/xdping.c                      | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 9c85d7d27409..acd33d0cd5d9 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4511,7 +4511,7 @@ static void do_test_file(unsigned int test_num)
 	if (CHECK(err, "obj: %d", err))
 		return;

-	prog = bpf_program__next(NULL, obj);
+	prog = bpf_object__next_program(obj, NULL);
 	if (CHECK(!prog, "Cannot find bpf_prog")) {
 		err = -1;
 		goto done;
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index c7c1816899bf..2839f4270a26 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -285,7 +285,7 @@ static void test_fmod_ret_freplace(void)
 	if (!ASSERT_OK_PTR(freplace_obj, "freplace_obj_open"))
 		goto out;

-	prog = bpf_program__next(NULL, freplace_obj);
+	prog = bpf_object__next_program(freplace_obj, NULL);
 	err = bpf_program__set_attach_target(prog, pkt_fd, NULL);
 	ASSERT_OK(err, "freplace__set_attach_target");

@@ -302,7 +302,7 @@ static void test_fmod_ret_freplace(void)
 		goto out;

 	attach_prog_fd = bpf_program__fd(prog);
-	prog = bpf_program__next(NULL, fmod_obj);
+	prog = bpf_object__next_program(fmod_obj, NULL);
 	err = bpf_program__set_attach_target(prog, attach_prog_fd, NULL);
 	ASSERT_OK(err, "fmod_ret_set_attach_target");

@@ -352,7 +352,7 @@ static void test_obj_load_failure_common(const char *obj_file,
 	if (!ASSERT_OK_PTR(obj, "obj_open"))
 		goto close_prog;

-	prog = bpf_program__next(NULL, obj);
+	prog = bpf_object__next_program(obj, NULL);
 	err = bpf_program__set_attach_target(prog, pkt_fd, NULL);
 	ASSERT_OK(err, "set_attach_target");

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 4efd337d6a3c..d40e9156c48d 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -114,7 +114,7 @@ static int prepare_bpf_obj(void)
 	err = bpf_object__load(obj);
 	RET_ERR(err, "load bpf_object", "err:%d\n", err);

-	prog = bpf_program__next(NULL, obj);
+	prog = bpf_object__next_program(obj, NULL);
 	RET_ERR(!prog, "get first bpf_program", "!prog\n");
 	select_by_skb_data_prog = bpf_program__fd(prog);
 	RET_ERR(select_by_skb_data_prog < 0, "get prog fd",
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
index d207e968e6b1..265b4fe33ec3 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
@@ -109,7 +109,7 @@ static int run_test(int cgroup_fd, int server_fd)
 		return -1;
 	}

-	map = bpf_map__next(NULL, obj);
+	map = bpf_object__next_map(obj, NULL);
 	map_fd = bpf_map__fd(map);

 	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
diff --git a/tools/testing/selftests/bpf/xdping.c b/tools/testing/selftests/bpf/xdping.c
index 79a3453dab25..30f12637f4e4 100644
--- a/tools/testing/selftests/bpf/xdping.c
+++ b/tools/testing/selftests/bpf/xdping.c
@@ -187,7 +187,7 @@ int main(int argc, char **argv)
 		return 1;
 	}

-	map = bpf_map__next(NULL, obj);
+	map = bpf_object__next_map(obj, NULL);
 	if (map)
 		map_fd = bpf_map__fd(map);
 	if (!map || map_fd < 0) {
--
2.25.1

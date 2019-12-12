Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD2611CA8E
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 11:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfLLKXN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 05:23:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34825 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfLLKXM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Dec 2019 05:23:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id j6so1673080lja.2
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 02:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QD2y/RaPoCMCJcQIGG1Mbdp/VjKYaYfXk46UjxrkZMY=;
        b=OzRTwqKk6EWihei2fLaMP7XjbdCgRFRVHTtTnuPAawOF9QPhz0ArR10tEpBQp2y+6o
         rL+mcBNR6CT/RLdXKDpi7AMmSMyEtFZHWnlJlOb0hFfGGWmdOe7sa9TSknPwHeUfq0F1
         BAFoTYdVxsF+DqrTI7W3alkgAFjpnit0FV2eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QD2y/RaPoCMCJcQIGG1Mbdp/VjKYaYfXk46UjxrkZMY=;
        b=PqywHdHYuGgXlfdBVZQ0MnQjo9cWwzkigNcnu9/8R5VL1yt/jdMa9YCQEaa5GpYUKp
         Q42YJNC49YytBVuOgcog1VOiwhQTa/SeWFyjthDTPn0cHffIxzBjx2tTKiEasRCS9uuk
         7LEeSc0gJCsZ5GUZYnNdGQUqxF6uUGWtvxhO/qdaWMndXdn2k5NT38ebudT92FkWBq/p
         67O5FqPU7ODndhpmwX3LcH9rHNA5AbsGdoRNPNHK4xGUzVjX1ET+IEhX668aNxtyEbZW
         XUO+Hv9jsB5eWrkqcP034/k5kJcXuQrFXzAORxyBjl1czyPkB6J/u6dg9QHTRHPV4Ohk
         nMWg==
X-Gm-Message-State: APjAAAV1djCO6O1zkPOEWoN1W4o9isoLSYVpCMc/gMhMQkJs9Ro8fkCK
        7wMc/r3qXV6QQPZeHIBypfru2y0cnOHOKw==
X-Google-Smtp-Source: APXvYqyS/zrSVVeDWkF4OZtITp86yHjyN5Od3xKkHSjDdD1qlJ3PqIqMgCwZMXoLKPVMvGFjR35qaQ==
X-Received: by 2002:a2e:9587:: with SMTP id w7mr5122838ljh.42.1576146189628;
        Thu, 12 Dec 2019 02:23:09 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id 192sm2702029lfh.28.2019.12.12.02.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:23:09 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     Martin Lau <kafai@fb.com>, kernel-team@cloudflare.com
Subject: [PATCH bpf-next 07/10] selftests/bpf: Propagate errors during setup for reuseport tests
Date:   Thu, 12 Dec 2019 11:22:56 +0100
Message-Id: <20191212102259.418536-8-jakub@cloudflare.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212102259.418536-1-jakub@cloudflare.com>
References: <20191212102259.418536-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prepare for switching reuseport tests to test_progs framework, where we
don't have the luxury to terminate the process on failure.

Modify setup helpers to signal failure via the return value with the help
of a macro similar to the one currently in use by the tests.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/test_select_reuseport.c     | 136 +++++++++++-------
 1 file changed, 85 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_select_reuseport.c b/tools/testing/selftests/bpf/test_select_reuseport.c
index cfff958da570..cc35816b7b34 100644
--- a/tools/testing/selftests/bpf/test_select_reuseport.c
+++ b/tools/testing/selftests/bpf/test_select_reuseport.c
@@ -32,7 +32,7 @@
 static int result_map, tmp_index_ovr_map, linum_map, data_check_map;
 static enum result expected_results[NR_RESULTS];
 static int sk_fds[REUSEPORT_ARRAY_SIZE];
-static int reuseport_array, outer_map;
+static int reuseport_array = -1, outer_map = -1;
 static int select_by_skb_data_prog;
 static int saved_tcp_syncookie;
 static struct bpf_object *obj;
@@ -55,7 +55,16 @@ static union sa46 {
 	}								\
 })
 
-static void create_maps(void)
+#define RET_ERR(condition, tag, format...) ({				\
+	int __ret = !!(condition);					\
+	if (__ret) {							\
+		printf("%s(%d):FAIL:%s ", __func__, __LINE__, tag);	\
+		printf(format);						\
+		return -1;						\
+	}								\
+})
+
+static int create_maps(void)
 {
 	struct bpf_create_map_attr attr = {};
 
@@ -67,8 +76,8 @@ static void create_maps(void)
 	attr.max_entries = REUSEPORT_ARRAY_SIZE;
 
 	reuseport_array = bpf_create_map_xattr(&attr);
-	CHECK(reuseport_array == -1, "creating reuseport_array",
-	      "reuseport_array:%d errno:%d\n", reuseport_array, errno);
+	RET_ERR(reuseport_array == -1, "creating reuseport_array",
+		"reuseport_array:%d errno:%d\n", reuseport_array, errno);
 
 	/* Creating outer_map */
 	attr.name = "outer_map";
@@ -78,57 +87,61 @@ static void create_maps(void)
 	attr.max_entries = 1;
 	attr.inner_map_fd = reuseport_array;
 	outer_map = bpf_create_map_xattr(&attr);
-	CHECK(outer_map == -1, "creating outer_map",
-	      "outer_map:%d errno:%d\n", outer_map, errno);
+	RET_ERR(outer_map == -1, "creating outer_map",
+		"outer_map:%d errno:%d\n", outer_map, errno);
+
+	return 0;
 }
 
-static void prepare_bpf_obj(void)
+static int prepare_bpf_obj(void)
 {
 	struct bpf_program *prog;
 	struct bpf_map *map;
 	int err;
 
 	obj = bpf_object__open("test_select_reuseport_kern.o");
-	CHECK(IS_ERR_OR_NULL(obj), "open test_select_reuseport_kern.o",
-	      "obj:%p PTR_ERR(obj):%ld\n", obj, PTR_ERR(obj));
+	RET_ERR(IS_ERR_OR_NULL(obj), "open test_select_reuseport_kern.o",
+		"obj:%p PTR_ERR(obj):%ld\n", obj, PTR_ERR(obj));
 
 	map = bpf_object__find_map_by_name(obj, "outer_map");
-	CHECK(!map, "find outer_map", "!map\n");
+	RET_ERR(!map, "find outer_map", "!map\n");
 	err = bpf_map__reuse_fd(map, outer_map);
-	CHECK(err, "reuse outer_map", "err:%d\n", err);
+	RET_ERR(err, "reuse outer_map", "err:%d\n", err);
 
 	err = bpf_object__load(obj);
-	CHECK(err, "load bpf_object", "err:%d\n", err);
+	RET_ERR(err, "load bpf_object", "err:%d\n", err);
 
 	prog = bpf_program__next(NULL, obj);
-	CHECK(!prog, "get first bpf_program", "!prog\n");
+	RET_ERR(!prog, "get first bpf_program", "!prog\n");
 	select_by_skb_data_prog = bpf_program__fd(prog);
-	CHECK(select_by_skb_data_prog == -1, "get prog fd",
-	      "select_by_skb_data_prog:%d\n", select_by_skb_data_prog);
+	RET_ERR(select_by_skb_data_prog == -1, "get prog fd",
+		"select_by_skb_data_prog:%d\n", select_by_skb_data_prog);
 
 	map = bpf_object__find_map_by_name(obj, "result_map");
-	CHECK(!map, "find result_map", "!map\n");
+	RET_ERR(!map, "find result_map", "!map\n");
 	result_map = bpf_map__fd(map);
-	CHECK(result_map == -1, "get result_map fd",
-	      "result_map:%d\n", result_map);
+	RET_ERR(result_map == -1, "get result_map fd",
+		"result_map:%d\n", result_map);
 
 	map = bpf_object__find_map_by_name(obj, "tmp_index_ovr_map");
-	CHECK(!map, "find tmp_index_ovr_map", "!map\n");
+	RET_ERR(!map, "find tmp_index_ovr_map\n", "!map");
 	tmp_index_ovr_map = bpf_map__fd(map);
-	CHECK(tmp_index_ovr_map == -1, "get tmp_index_ovr_map fd",
-	      "tmp_index_ovr_map:%d\n", tmp_index_ovr_map);
+	RET_ERR(tmp_index_ovr_map == -1, "get tmp_index_ovr_map fd",
+		"tmp_index_ovr_map:%d\n", tmp_index_ovr_map);
 
 	map = bpf_object__find_map_by_name(obj, "linum_map");
-	CHECK(!map, "find linum_map", "!map\n");
+	RET_ERR(!map, "find linum_map", "!map\n");
 	linum_map = bpf_map__fd(map);
-	CHECK(linum_map == -1, "get linum_map fd",
-	      "linum_map:%d\n", linum_map);
+	RET_ERR(linum_map == -1, "get linum_map fd",
+		"linum_map:%d\n", linum_map);
 
 	map = bpf_object__find_map_by_name(obj, "data_check_map");
-	CHECK(!map, "find data_check_map", "!map\n");
+	RET_ERR(!map, "find data_check_map", "!map\n");
 	data_check_map = bpf_map__fd(map);
-	CHECK(data_check_map == -1, "get data_check_map fd",
-	      "data_check_map:%d\n", data_check_map);
+	RET_ERR(data_check_map == -1, "get data_check_map fd",
+		"data_check_map:%d\n", data_check_map);
+
+	return 0;
 }
 
 static void sa46_init_loopback(union sa46 *sa, sa_family_t family)
@@ -157,31 +170,34 @@ static int read_int_sysctl(const char *sysctl)
 	int fd, ret;
 
 	fd = open(sysctl, 0);
-	CHECK(fd == -1, "open(sysctl)", "sysctl:%s fd:%d errno:%d\n",
-	      sysctl, fd, errno);
+	RET_ERR(fd == -1, "open(sysctl)",
+		"sysctl:%s fd:%d errno:%d\n", sysctl, fd, errno);
 
 	ret = read(fd, buf, sizeof(buf));
-	CHECK(ret <= 0, "read(sysctl)", "sysctl:%s ret:%d errno:%d\n",
-	      sysctl, ret, errno);
-	close(fd);
+	RET_ERR(ret <= 0, "read(sysctl)",
+		"sysctl:%s ret:%d errno:%d\n", sysctl, ret, errno);
 
+	close(fd);
 	return atoi(buf);
 }
 
-static void write_int_sysctl(const char *sysctl, int v)
+static int write_int_sysctl(const char *sysctl, int v)
 {
 	int fd, ret, size;
 	char buf[16];
 
 	fd = open(sysctl, O_RDWR);
-	CHECK(fd == -1, "open(sysctl)", "sysctl:%s fd:%d errno:%d\n",
-	      sysctl, fd, errno);
+	RET_ERR(fd == -1, "open(sysctl)",
+		"sysctl:%s fd:%d errno:%d\n", sysctl, fd, errno);
 
 	size = snprintf(buf, sizeof(buf), "%d", v);
 	ret = write(fd, buf, size);
-	CHECK(ret != size, "write(sysctl)",
-	      "sysctl:%s ret:%d size:%d errno:%d\n", sysctl, ret, size, errno);
+	RET_ERR(ret != size, "write(sysctl)",
+		"sysctl:%s ret:%d size:%d errno:%d\n",
+		sysctl, ret, size, errno);
+
 	close(fd);
+	return 0;
 }
 
 static void restore_sysctls(void)
@@ -190,22 +206,25 @@ static void restore_sysctls(void)
 	write_int_sysctl(TCP_SYNCOOKIE_SYSCTL, saved_tcp_syncookie);
 }
 
-static void enable_fastopen(void)
+static int enable_fastopen(void)
 {
 	int fo;
 
 	fo = read_int_sysctl(TCP_FO_SYSCTL);
-	write_int_sysctl(TCP_FO_SYSCTL, fo | 7);
+	if (fo < 0)
+		return -1;
+
+	return write_int_sysctl(TCP_FO_SYSCTL, fo | 7);
 }
 
-static void enable_syncookie(void)
+static int enable_syncookie(void)
 {
-	write_int_sysctl(TCP_SYNCOOKIE_SYSCTL, 2);
+	return write_int_sysctl(TCP_SYNCOOKIE_SYSCTL, 2);
 }
 
-static void disable_syncookie(void)
+static int disable_syncookie(void)
 {
-	write_int_sysctl(TCP_SYNCOOKIE_SYSCTL, 0);
+	return write_int_sysctl(TCP_SYNCOOKIE_SYSCTL, 0);
 }
 
 static __u32 get_linum(void)
@@ -683,9 +702,12 @@ static void cleanup_per_test(bool no_inner_map)
 
 static void cleanup(void)
 {
-	close(outer_map);
-	close(reuseport_array);
-	bpf_object__close(obj);
+	if (outer_map != -1)
+		close(outer_map);
+	if (reuseport_array != -1)
+		close(reuseport_array);
+	if (obj)
+		bpf_object__close(obj);
 }
 
 static const char *family_str(sa_family_t family)
@@ -765,16 +787,28 @@ static void test_all(void)
 
 int main(int argc, const char **argv)
 {
-	create_maps();
-	prepare_bpf_obj();
+	int ret = EXIT_FAILURE;
+
+	if (create_maps())
+		goto out;
+	if (prepare_bpf_obj())
+		goto out;
+
 	saved_tcp_fo = read_int_sysctl(TCP_FO_SYSCTL);
 	saved_tcp_syncookie = read_int_sysctl(TCP_SYNCOOKIE_SYSCTL);
-	enable_fastopen();
-	disable_syncookie();
+	if (saved_tcp_syncookie < 0 || saved_tcp_syncookie < 0)
+		goto out;
 	atexit(restore_sysctls);
 
+	if (enable_fastopen())
+		goto out;
+	if (disable_syncookie())
+		goto out;
+
 	test_all();
 
+	ret = EXIT_SUCCESS;
+out:
 	cleanup();
-	return 0;
+	return ret;
 }
-- 
2.23.0


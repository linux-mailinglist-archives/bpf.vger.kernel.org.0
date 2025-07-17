Return-Path: <bpf+bounces-63555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6E2B0836E
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 05:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02BB565227
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B261FFC48;
	Thu, 17 Jul 2025 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="l2mOejzP"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAFF1FF601;
	Thu, 17 Jul 2025 03:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752722968; cv=none; b=KW71FXAhcRo71kEmK+zEMgKhFgT0XhbNNNbAYt/u1olxHbhyR/VAO/WdiZXYPEd3AvvVrgdBBLf/4R6PwNpv2XFdnMKdzKTN6kJNPgBw/Z6+OqzhfkQISBI6btywuTn9tDHhVwBJmtchJRwQCkYbQJTTpMI77XK+aSc+APEuQS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752722968; c=relaxed/simple;
	bh=XldtMI1cI42MaOPtp5XjObeUW/TtuJzMmeGPBkeEP2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mw7ouim6pyX/wWRy7bGfoGWrBg9N7lfOy8PkewhH8dEoNITaYawUGsVkOKF03Y8Fyu5jdyPl1/HgjMhPQ4rQgAocwk17GL1j0wv1bYmLvJ3Pe9aF9zz5Xe/LNjhCt+ZcBReuLuw/lMPpSnuiNcunneJKOzAHeK3xvasU/c0rL6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=l2mOejzP; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=OB
	w5/BaGROLyPcGHk2TkTPqt5QXfRAUqLf98jtZEi/M=; b=l2mOejzPfGyFtz2LBl
	WMFahHvP5EbbOaVd2U29Zoz0YQ9yLVcb4C5fV6DM/7v2NinbsHz9ljjcSQcV44KS
	h2zPQlxfiwlfw0ebGhhxWcVri+GF5qnvSacDy227du4t6oPQt9qqTs1/fJILHDaX
	GR9r4dnT2Bz4WGk9EDUt46G4o=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3_4bdbXhoJsULFQ--.2953S4;
	Thu, 17 Jul 2025 11:28:33 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next 2/2] samples/bpf: Delete map_in_map test
Date: Thu, 17 Jul 2025 11:28:28 +0800
Message-Id: <20250717032828.500146-3-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250717032828.500146-1-yangfeng59949@163.com>
References: <20250717032828.500146-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_4bdbXhoJsULFQ--.2953S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3KFWfXw17AryrXw1xCFWDXFb_yoWkGr1Dpa
	y3ArZxCrW8ZF4UGayrtw48tryY9w4UXw1DWrs7K34SyrsF9ryxJr40qFZ29Fn8JrWqvFW5
	CF4av34rGFWDXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UEJmUUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbipQONeGh4ajB03wAAsy

From: Feng Yang <yangfeng@kylinos.cn>

Test cases should be placed in selftests,
and as selftests already include tests for map_in_map, this one should be deleted.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 samples/bpf/Makefile               |   3 -
 samples/bpf/test_map_in_map.bpf.c  | 172 -----------------------------
 samples/bpf/test_map_in_map_user.c | 168 ----------------------------
 3 files changed, 343 deletions(-)
 delete mode 100644 samples/bpf/test_map_in_map.bpf.c
 delete mode 100644 samples/bpf/test_map_in_map_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 95a4fa1f1e44..b5fb72c94050 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -28,7 +28,6 @@ tprogs-y += sampleip
 tprogs-y += tc_l2_redirect
 tprogs-y += lwt_len_hist
 tprogs-y += xdp_tx_iptunnel
-tprogs-y += test_map_in_map
 tprogs-y += per_socket_stats_example
 tprogs-y += syscall_tp
 tprogs-y += cpustat
@@ -69,7 +68,6 @@ sampleip-objs := sampleip_user.o $(TRACE_HELPERS)
 tc_l2_redirect-objs := tc_l2_redirect_user.o
 lwt_len_hist-objs := lwt_len_hist_user.o
 xdp_tx_iptunnel-objs := xdp_tx_iptunnel_user.o
-test_map_in_map-objs := test_map_in_map_user.o
 per_socket_stats_example-objs := cookie_uid_helper_example.o
 syscall_tp-objs := syscall_tp_user.o
 cpustat-objs := cpustat_user.o
@@ -103,7 +101,6 @@ always-y += trace_event_kern.o
 always-y += sampleip_kern.o
 always-y += lwt_len_hist.bpf.o
 always-y += xdp_tx_iptunnel_kern.o
-always-y += test_map_in_map.bpf.o
 always-y += tcp_synrto_kern.o
 always-y += tcp_rwnd_kern.o
 always-y += tcp_bufs_kern.o
diff --git a/samples/bpf/test_map_in_map.bpf.c b/samples/bpf/test_map_in_map.bpf.c
deleted file mode 100644
index 9f030f9c4e1b..000000000000
--- a/samples/bpf/test_map_in_map.bpf.c
+++ /dev/null
@@ -1,172 +0,0 @@
-/*
- * Copyright (c) 2017 Facebook
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- */
-#define KBUILD_MODNAME "foo"
-#include "vmlinux.h"
-#include <linux/version.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-#include <bpf/bpf_core_read.h>
-
-#define MAX_NR_PORTS 65536
-
-#define EINVAL 22
-#define ENOENT 2
-
-/* map #0 */
-struct inner_a {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__type(key, u32);
-	__type(value, int);
-	__uint(max_entries, MAX_NR_PORTS);
-} port_a SEC(".maps");
-
-/* map #1 */
-struct inner_h {
-	__uint(type, BPF_MAP_TYPE_HASH);
-	__type(key, u32);
-	__type(value, int);
-	__uint(max_entries, 1);
-} port_h SEC(".maps");
-
-/* map #2 */
-struct {
-	__uint(type, BPF_MAP_TYPE_HASH);
-	__type(key, u32);
-	__type(value, int);
-	__uint(max_entries, 1);
-} reg_result_h SEC(".maps");
-
-/* map #3 */
-struct {
-	__uint(type, BPF_MAP_TYPE_HASH);
-	__type(key, u32);
-	__type(value, int);
-	__uint(max_entries, 1);
-} inline_result_h SEC(".maps");
-
-/* map #4 */ /* Test case #0 */
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
-	__uint(max_entries, MAX_NR_PORTS);
-	__uint(key_size, sizeof(u32));
-	__array(values, struct inner_a); /* use inner_a as inner map */
-} a_of_port_a SEC(".maps");
-
-/* map #5 */ /* Test case #1 */
-struct {
-	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
-	__uint(max_entries, 1);
-	__uint(key_size, sizeof(u32));
-	__array(values, struct inner_a); /* use inner_a as inner map */
-} h_of_port_a SEC(".maps");
-
-/* map #6 */ /* Test case #2 */
-struct {
-	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
-	__uint(max_entries, 1);
-	__uint(key_size, sizeof(u32));
-	__array(values, struct inner_h); /* use inner_h as inner map */
-} h_of_port_h SEC(".maps");
-
-static __always_inline int do_reg_lookup(void *inner_map, u32 port)
-{
-	int *result;
-
-	result = bpf_map_lookup_elem(inner_map, &port);
-	return result ? *result : -ENOENT;
-}
-
-static __always_inline int do_inline_array_lookup(void *inner_map, u32 port)
-{
-	int *result;
-
-	if (inner_map != &port_a)
-		return -EINVAL;
-
-	result = bpf_map_lookup_elem(&port_a, &port);
-	return result ? *result : -ENOENT;
-}
-
-static __always_inline int do_inline_hash_lookup(void *inner_map, u32 port)
-{
-	int *result;
-
-	if (inner_map != &port_h)
-		return -EINVAL;
-
-	result = bpf_map_lookup_elem(&port_h, &port);
-	return result ? *result : -ENOENT;
-}
-
-SEC("ksyscall/connect")
-int BPF_KSYSCALL(trace_sys_connect, unsigned int fd, struct sockaddr_in6 *in6, int addrlen)
-{
-	u16 test_case, port, dst6[8];
-	int ret, inline_ret, ret_key = 0;
-	u32 port_key;
-	void *outer_map, *inner_map;
-	bool inline_hash = false;
-
-	if (addrlen != sizeof(*in6))
-		return 0;
-
-	ret = bpf_probe_read_user(dst6, sizeof(dst6), &in6->sin6_addr);
-	if (ret) {
-		inline_ret = ret;
-		goto done;
-	}
-
-	if (dst6[0] != 0xdead || dst6[1] != 0xbeef)
-		return 0;
-
-	test_case = dst6[7];
-
-	ret = bpf_probe_read_user(&port, sizeof(port), &in6->sin6_port);
-	if (ret) {
-		inline_ret = ret;
-		goto done;
-	}
-
-	port_key = port;
-
-	ret = -ENOENT;
-	if (test_case == 0) {
-		outer_map = &a_of_port_a;
-	} else if (test_case == 1) {
-		outer_map = &h_of_port_a;
-	} else if (test_case == 2) {
-		outer_map = &h_of_port_h;
-	} else {
-		ret = __LINE__;
-		inline_ret = ret;
-		goto done;
-	}
-
-	inner_map = bpf_map_lookup_elem(outer_map, &port_key);
-	if (!inner_map) {
-		ret = __LINE__;
-		inline_ret = ret;
-		goto done;
-	}
-
-	ret = do_reg_lookup(inner_map, port_key);
-
-	if (test_case == 0 || test_case == 1)
-		inline_ret = do_inline_array_lookup(inner_map, port_key);
-	else
-		inline_ret = do_inline_hash_lookup(inner_map, port_key);
-
-done:
-	bpf_map_update_elem(&reg_result_h, &ret_key, &ret, BPF_ANY);
-	bpf_map_update_elem(&inline_result_h, &ret_key, &inline_ret, BPF_ANY);
-
-	return 0;
-}
-
-char _license[] SEC("license") = "GPL";
-u32 _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/samples/bpf/test_map_in_map_user.c b/samples/bpf/test_map_in_map_user.c
deleted file mode 100644
index 55dca43f3723..000000000000
--- a/samples/bpf/test_map_in_map_user.c
+++ /dev/null
@@ -1,168 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2017 Facebook
- */
-#include <sys/socket.h>
-#include <arpa/inet.h>
-#include <stdint.h>
-#include <assert.h>
-#include <errno.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include "bpf_util.h"
-
-static int map_fd[7];
-
-#define PORT_A		(map_fd[0])
-#define PORT_H		(map_fd[1])
-#define REG_RESULT_H	(map_fd[2])
-#define INLINE_RESULT_H	(map_fd[3])
-#define A_OF_PORT_A	(map_fd[4]) /* Test case #0 */
-#define H_OF_PORT_A	(map_fd[5]) /* Test case #1 */
-#define H_OF_PORT_H	(map_fd[6]) /* Test case #2 */
-
-static const char * const test_names[] = {
-	"Array of Array",
-	"Hash of Array",
-	"Hash of Hash",
-};
-
-#define NR_TESTS ARRAY_SIZE(test_names)
-
-static void check_map_id(int inner_map_fd, int map_in_map_fd, uint32_t key)
-{
-	struct bpf_map_info info = {};
-	uint32_t info_len = sizeof(info);
-	int ret, id;
-
-	ret = bpf_map_get_info_by_fd(inner_map_fd, &info, &info_len);
-	assert(!ret);
-
-	ret = bpf_map_lookup_elem(map_in_map_fd, &key, &id);
-	assert(!ret);
-	assert(id == info.id);
-}
-
-static void populate_map(uint32_t port_key, int magic_result)
-{
-	int ret;
-
-	ret = bpf_map_update_elem(PORT_A, &port_key, &magic_result, BPF_ANY);
-	assert(!ret);
-
-	ret = bpf_map_update_elem(PORT_H, &port_key, &magic_result,
-				  BPF_NOEXIST);
-	assert(!ret);
-
-	ret = bpf_map_update_elem(A_OF_PORT_A, &port_key, &PORT_A, BPF_ANY);
-	assert(!ret);
-	check_map_id(PORT_A, A_OF_PORT_A, port_key);
-
-	ret = bpf_map_update_elem(H_OF_PORT_A, &port_key, &PORT_A, BPF_NOEXIST);
-	assert(!ret);
-	check_map_id(PORT_A, H_OF_PORT_A, port_key);
-
-	ret = bpf_map_update_elem(H_OF_PORT_H, &port_key, &PORT_H, BPF_NOEXIST);
-	assert(!ret);
-	check_map_id(PORT_H, H_OF_PORT_H, port_key);
-}
-
-static void test_map_in_map(void)
-{
-	struct sockaddr_in6 in6 = { .sin6_family = AF_INET6 };
-	uint32_t result_key = 0, port_key;
-	int result, inline_result;
-	int magic_result = 0xfaceb00c;
-	int ret;
-	int i;
-
-	port_key = rand() & 0x00FF;
-	populate_map(port_key, magic_result);
-
-	in6.sin6_addr.s6_addr16[0] = 0xdead;
-	in6.sin6_addr.s6_addr16[1] = 0xbeef;
-	in6.sin6_port = port_key;
-
-	for (i = 0; i < NR_TESTS; i++) {
-		printf("%s: ", test_names[i]);
-
-		in6.sin6_addr.s6_addr16[7] = i;
-		ret = connect(-1, (struct sockaddr *)&in6, sizeof(in6));
-		assert(ret == -1 && errno == EBADF);
-
-		ret = bpf_map_lookup_elem(REG_RESULT_H, &result_key, &result);
-		assert(!ret);
-
-		ret = bpf_map_lookup_elem(INLINE_RESULT_H, &result_key,
-					  &inline_result);
-		assert(!ret);
-
-		if (result != magic_result || inline_result != magic_result) {
-			printf("Error. result:%d inline_result:%d\n",
-			       result, inline_result);
-			exit(1);
-		}
-
-		bpf_map_delete_elem(REG_RESULT_H, &result_key);
-		bpf_map_delete_elem(INLINE_RESULT_H, &result_key);
-
-		printf("Pass\n");
-	}
-}
-
-int main(int argc, char **argv)
-{
-	struct bpf_link *link = NULL;
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-	char filename[256];
-
-	snprintf(filename, sizeof(filename), "%s.bpf.o", argv[0]);
-	obj = bpf_object__open_file(filename, NULL);
-	if (libbpf_get_error(obj)) {
-		fprintf(stderr, "ERROR: opening BPF object file failed\n");
-		return 0;
-	}
-
-	prog = bpf_object__find_program_by_name(obj, "trace_sys_connect");
-	if (!prog) {
-		printf("finding a prog in obj file failed\n");
-		goto cleanup;
-	}
-
-	/* load BPF program */
-	if (bpf_object__load(obj)) {
-		fprintf(stderr, "ERROR: loading BPF object file failed\n");
-		goto cleanup;
-	}
-
-	map_fd[0] = bpf_object__find_map_fd_by_name(obj, "port_a");
-	map_fd[1] = bpf_object__find_map_fd_by_name(obj, "port_h");
-	map_fd[2] = bpf_object__find_map_fd_by_name(obj, "reg_result_h");
-	map_fd[3] = bpf_object__find_map_fd_by_name(obj, "inline_result_h");
-	map_fd[4] = bpf_object__find_map_fd_by_name(obj, "a_of_port_a");
-	map_fd[5] = bpf_object__find_map_fd_by_name(obj, "h_of_port_a");
-	map_fd[6] = bpf_object__find_map_fd_by_name(obj, "h_of_port_h");
-	if (map_fd[0] < 0 || map_fd[1] < 0 || map_fd[2] < 0 ||
-	    map_fd[3] < 0 || map_fd[4] < 0 || map_fd[5] < 0 || map_fd[6] < 0) {
-		fprintf(stderr, "ERROR: finding a map in obj file failed\n");
-		goto cleanup;
-	}
-
-	link = bpf_program__attach(prog);
-	if (libbpf_get_error(link)) {
-		fprintf(stderr, "ERROR: bpf_program__attach failed\n");
-		link = NULL;
-		goto cleanup;
-	}
-
-	test_map_in_map();
-
-cleanup:
-	bpf_link__destroy(link);
-	bpf_object__close(obj);
-	return 0;
-}
-- 
2.43.0



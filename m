Return-Path: <bpf+bounces-67918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBC1B503D2
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52EF67B9093
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFC2393DF9;
	Tue,  9 Sep 2025 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="vGpiHpnk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8E13705A9
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437239; cv=none; b=lLjhZQTTNqt+JqmdF8qKQ/v4BqkDJTNNMRX2MOf4VMiOqXG6OtilyY3vUG1K5kLFZ7M99b72g6/vDDp7mIFScX51E8rzV7Q+X923vomhX9pmBOYyooqC4bjD/7o3SLX8MCLn2zh+oueXS0pDOHGg4S3HqUaq0VosPZtL2x+AIUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437239; c=relaxed/simple;
	bh=F7mnhGyHczKrhTIgMCHCPKT+ALds7fyAYj4stUyLUSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qu8S8mvJr0/rUyNm3lhw0mF7+gh+gXj039VpyuWp05cgDrlK1apa97ahUfDa97QadqcGMtmNG0a3Q1v5fL6pCtIxby4mQo4THZ7kw8oiuFSw2zZVHkEoVwUpoNZm6prUqvuuv8Q71wrQaK2UhECBuQy8Ss4gb8btirBAmgPcXJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=vGpiHpnk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77240e78306so446547b3a.0
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437237; x=1758042037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMlAeByNnDLR7iTLgB8MyhJY1KzdIC01eogmdymhYiE=;
        b=vGpiHpnkK7MO0HynsNv3GHfs7menDn/dSURge7HZLo+2jVPA8tR434BvYuwu1cSs77
         Qc1J14fFhhNCN45Q0nlU7P3UzA/In5h6HV7ECZK/yH9YQJdaaRMr28FjJPjHm7i+dRNc
         yPkYyZ4Bh65vOEvYXgb7IagRILxWjoeA9D872QCZUZlg7hvNPgRsUxKAjX9SEzBUGAo6
         jDFZlQA0TuDOWAxDz01chlSDVVhKPvHyO12nWzN08yGSFgcMBuWHOXJrNM3kV3ae2Zho
         l7kdMXgD3DiIah6p5f+i59YROEgbFbaBd1HDWwu2qYAModPJFk05f0Nw+EoYwzRQlVes
         1dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437237; x=1758042037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMlAeByNnDLR7iTLgB8MyhJY1KzdIC01eogmdymhYiE=;
        b=C0ZuF4pyiuRqe90KU6i5MsMyNiBMuYTZ8PTU9TicH1BwJ0OrYHw+lDrUGOgD48Ki06
         WoZ6ark4RRlObGgnmheROylfn0eFLzcQGm1LYGJzULXeK9/zsG36VYRcM1BcdRRGArGF
         IHBW9V8qlCt0PxqNB0322EJiJ9Dr3Rd7B2/WV0cLjv3F5l/EUzI4OIf9lsEStYY9RiG9
         eTj5+eB8TsHWnliHUKyk7b3gtp6e3F2E6LvsnsMgHPVt7xze5FmgrGhOTyQ5SWKaXS9C
         tcfpdcTnP6ucTF1jeni87PrAsTuz9BMI2rXGJ8UdN6J4xaJZoORm0aGQiHHabc/bvzCH
         aB7A==
X-Gm-Message-State: AOJu0Yxic5OB1idOS4mgXoDpl6G7vaJ9n1rZ31J49kxZbzHj7wiVJ2Nj
	5MGsFAVmdpeLA3N5FIFKsdY4dQAXHQAcX3I/bLK4JxliKwM32ChTMgNdFXhJtk6OujlM3f1vdCM
	ka2S6
X-Gm-Gg: ASbGncsXu7EVbi7P0bJn5ByLLI1sXFnbWub6wo9UYW87f05zR78DMIeVZQzgDgGCgIv
	58bodJg4zTX3Iiu+Gb5YmUGblvGwIjjMn0nNkbSOH3M/VI0DQa/P7QYCO/qAOtJsprDjhz0g0ei
	KVZqi+FncucphR9PALso56PVlWg+7zUvsvvKgWEW29+c4+bibAWg95/2VDVmpuY3ExPcFuZY/8q
	dBIarwcEiBQI8I5Eh6BUpmZ6fFv4B9KR7Wb0ZbVKvcKBlpamYNpPvl7vWrAef2rFNJkpS1Z+yG3
	m+WO4+L36zSb+094C4ItGiIaZOjUXRr+BTNbr2nWgzcES6VR6dpYNMX9HTOo0toOsTui/uoG6ny
	KNjhPRF60SQoHDO8iGG1oKxAQv6J7L+QnANI=
X-Google-Smtp-Source: AGHT+IEM+eSf+XzQ9PoltWJtkMnq0eD4kP61MBzq3XY3shMxJYuloxxK0gbfpm2E/0gppX9bmcQfJw==
X-Received: by 2002:a05:6a21:6da2:b0:24a:1b2d:641a with SMTP id adf61e73a8af0-25335c8100emr10535747637.0.1757437236911;
        Tue, 09 Sep 2025 10:00:36 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:36 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 09/14] selftests/bpf: Test socket hash iterator resume scenarios
Date: Tue,  9 Sep 2025 10:00:03 -0700
Message-ID: <20250909170011.239356-10-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the suite of tests that exercise edge cases around iteration over
multiple sockets in the same bucket to cover socket hashes using key
prefix filtering.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 119 +++++++++++++++++-
 .../selftests/bpf/progs/sock_iter_batch.c     |  31 +++++
 2 files changed, 147 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index e6fc4fd994f9..2034ddfdf134 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -10,6 +10,7 @@
 #define TEST_CHILD_NS "sock_iter_batch_child_netns"
 
 static const int init_batch_size = 16;
+static const __u32 key_prefix = 1;
 static const int nr_soreuse = 4;
 
 struct iter_out {
@@ -255,6 +256,31 @@ static int *connect_to_server(int family, int sock_type, const char *addr,
 	return NULL;
 }
 
+static int insert_sockets_hash(struct bpf_map *sock_map, __u32 first_id,
+			       int *sock_fds, int sock_fds_len)
+{
+	int map_fd = bpf_map__fd(sock_map);
+	struct {
+		__u32 bucket_key;
+		__u32 id;
+	} key = {
+		.bucket_key = key_prefix,
+	};
+	__s64 sfd;
+	int ret;
+	__u32 i;
+
+	for (i = 0; i < sock_fds_len; i++) {
+		sfd = sock_fds[i];
+		key.id = first_id + i;
+		ret = bpf_map_update_elem(map_fd, &key, &sfd, BPF_NOEXIST);
+		if (!ASSERT_OK(ret, "map_update"))
+			return -1;
+	}
+
+	return 0;
+}
+
 static void remove_seen(int family, int sock_type, const char *addr, __u16 port,
 			int *socks, int socks_len, int *established_socks,
 			int established_socks_len, struct sock_count *counts,
@@ -609,6 +635,7 @@ struct test_case {
 	int init_socks;
 	int max_socks;
 	int sock_type;
+	bool fill_map;
 	int family;
 };
 
@@ -660,6 +687,33 @@ static struct test_case resume_tests[] = {
 		.family = AF_INET6,
 		.test = force_realloc,
 	},
+	{
+		.description = "sockhash: udp: resume after removing a seen socket",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_DGRAM,
+		.family = AF_INET6,
+		.test = remove_seen,
+		.fill_map = true,
+	},
+	{
+		.description = "sockhash: udp: resume after removing one unseen socket",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_DGRAM,
+		.family = AF_INET6,
+		.test = remove_unseen,
+		.fill_map = true,
+	},
+	{
+		.description = "sockhash: udp: resume after removing all unseen sockets",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_DGRAM,
+		.family = AF_INET6,
+		.test = remove_all,
+		.fill_map = true,
+	},
 	{
 		.description = "tcp: resume after removing a seen socket (listening)",
 		.init_socks = nr_soreuse,
@@ -770,13 +824,49 @@ static struct test_case resume_tests[] = {
 		.family = AF_INET6,
 		.test = force_realloc_established,
 	},
+	{
+		.description = "sockhash: tcp: resume after removing a seen socket",
+		.connections = nr_soreuse,
+		.init_socks = nr_soreuse,
+		/* Room for connect()ed and accept()ed sockets */
+		.max_socks = nr_soreuse * 3,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_seen_established,
+		.fill_map = true,
+	},
+	{
+		.description = "sockhash: tcp: resume after removing one unseen socket",
+		.connections = nr_soreuse,
+		.init_socks = nr_soreuse,
+		/* Room for connect()ed and accept()ed sockets */
+		.max_socks = nr_soreuse * 3,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_unseen_established,
+		.fill_map = true,
+	},
+	{
+		.description = "sockhash: tcp: resume after removing all unseen sockets",
+		.connections = nr_soreuse,
+		.init_socks = nr_soreuse,
+		/* Room for connect()ed and accept()ed sockets */
+		.max_socks = nr_soreuse * 3,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_all_established,
+		.fill_map = true,
+	},
 };
 
 static void do_resume_test(struct test_case *tc)
 {
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo = {};
 	struct sock_iter_batch *skel = NULL;
 	struct sock_count *counts = NULL;
 	static const __u16 port = 10001;
+	struct bpf_program *prog = NULL;
 	struct nstoken *nstoken = NULL;
 	struct bpf_link *link = NULL;
 	int *established_fds = NULL;
@@ -825,10 +915,33 @@ static void do_resume_test(struct test_case *tc)
 	if (!ASSERT_OK(err, "sock_iter_batch__load"))
 		goto done;
 
-	link = bpf_program__attach_iter(tc->sock_type == SOCK_STREAM ?
+	if (tc->fill_map) {
+		/* Established sockets must be inserted first so that all
+		 * listening sockets will be seen first during iteration.
+		 */
+		if (!ASSERT_OK(insert_sockets_hash(skel->maps.sockets, 0,
+						   established_fds,
+						   tc->connections*2),
+			       "insert_sockets_hash"))
+			goto done;
+		if (!ASSERT_OK(insert_sockets_hash(skel->maps.sockets,
+						   tc->connections*2, fds,
+						   tc->init_socks),
+			       "insert_sockets_hash"))
+			goto done;
+		linfo.map.map_fd = bpf_map__fd(skel->maps.sockets);
+		linfo.map.sock_hash.key_prefix = (__u64)(void *)&key_prefix;
+		linfo.map.sock_hash.key_prefix_len = sizeof(key_prefix);
+		opts.link_info = &linfo;
+		opts.link_info_len = sizeof(linfo);
+		prog = skel->progs.iter_sockmap;
+	} else {
+		prog = tc->sock_type == SOCK_STREAM ?
 					skel->progs.iter_tcp_soreuse :
-					skel->progs.iter_udp_soreuse,
-					NULL);
+					skel->progs.iter_udp_soreuse;
+	}
+
+	link = bpf_program__attach_iter(prog, &opts);
 	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
 		goto done;
 
diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
index 77966ded5467..a19581f19eda 100644
--- a/tools/testing/selftests/bpf/progs/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
@@ -130,4 +130,35 @@ int iter_udp_soreuse(struct bpf_iter__udp *ctx)
 	return 0;
 }
 
+struct sock_hash_key {
+	__u32 bucket_key;
+	__u32 id;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, 16);
+	__ulong(map_extra, offsetof(struct sock_hash_key, id));
+	__type(key, sizeof(struct sock_hash_key));
+	__type(value, __u64);
+} sockets SEC(".maps");
+
+SEC("iter/sockmap")
+int iter_sockmap(struct bpf_iter__sockmap *ctx)
+{
+	struct sock *sk = ctx->sk;
+	__u32 *key = ctx->key;
+	__u64 sock_cookie;
+	int idx = 0;
+
+	if (!key || !sk)
+		return 0;
+
+	sock_cookie = bpf_get_socket_cookie(sk);
+	bpf_seq_write(ctx->meta->seq, &idx, sizeof(idx));
+	bpf_seq_write(ctx->meta->seq, &sock_cookie, sizeof(sock_cookie));
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0



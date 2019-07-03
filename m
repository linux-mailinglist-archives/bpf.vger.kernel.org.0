Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D75F95E9F2
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2019 19:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfGCRCU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jul 2019 13:02:20 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:39944 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfGCRCT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jul 2019 13:02:19 -0400
Received: by mail-qk1-f202.google.com with SMTP id c1so3757515qkl.7
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2019 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ld5qNoKshdyRmavLPGoPc6BR++OK/w6IRlR9/ebcOn4=;
        b=TZrCGi3jcqjHluRGRqVScSH3nnF0ngfzc7kFNydCQYZVuwuUp9YebJ1FMq1bxqWMB2
         tHhtCnnfbK7nhfIkJVSbdsly1Sb2uJEw63ORMMbMjGr+rgwFeja8VYmU9bIvdijewmMB
         skRF5jPJjA2NhKt8fyeSp1jCTaAEYa1NkzzKxF1iRkEaRFI3/EQRfY+F+d+TlRIsPdAv
         IzoPvqZd+U6VyoEB4zaqJQ0v0zehg1PHAldRx3VPq/5pID7CAoImHt+9f8+LdaSB4iK/
         jfZo3e5+EO4pm+3WJra8HHkX2pcDrI7PQWAwwDh+lDqqDiUn/6Y+hvW1lnoMzw3cM47K
         dJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ld5qNoKshdyRmavLPGoPc6BR++OK/w6IRlR9/ebcOn4=;
        b=BGCP+1DrT9+zY8NCCeWxhaCHfZAf72jK22ZYmurTQrCjVuCA92tsYKpNj3zGoM/QL6
         5PiTWg56XtqONu2PH1OfZAr/kKor9ahVwOW3kS9rGPN/D5gfLzdd47pTdjT7KafGXbwr
         iXYsDbndcp6q05+e05/3cPEdspvQQBbr7MXJBesu+vJzyxHrO1EhnVXe3LeWZb1ipM7A
         17aehzMxlIqtd9xWsMvl1m+2n5iwqxxvqLI6ioUbPaZ+G2nOc7J766iglc6EXz3eGq2r
         9CWg6mYpViNTNSzDpjl6xnzcsIxoxYNNyN5ayY1YaW2GLV0m6MNVQt+TKXvboPFA/YLw
         f59A==
X-Gm-Message-State: APjAAAVOpnH1O7kw5q7LyFdCoyJ7muSBgqFFhUzs07a6Pj6K/fCOM2RC
        ChnZ3ssrv4Rp/zx8f7iimJX59xO3mr2G
X-Google-Smtp-Source: APXvYqzUJWgXSVAR31qVHYmLDhXP3MkV6i2uPSVDio5Wx5fkOVznYsw7k/Ij5SbCILaDCrihlPc/nePm9qGy
X-Received: by 2002:ac8:6958:: with SMTP id n24mr32368355qtr.360.1562173338277;
 Wed, 03 Jul 2019 10:02:18 -0700 (PDT)
Date:   Wed,  3 Jul 2019 10:01:18 -0700
In-Reply-To: <20190703170118.196552-1-brianvv@google.com>
Message-Id: <20190703170118.196552-7-brianvv@google.com>
Mime-Version: 1.0
References: <20190703170118.196552-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next RFC v3 6/6] selftests/bpf: add test to measure
 performance of BPF_MAP_DUMP
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This tests compares the amount of time that takes to read an entire
table of 100K elements on a bpf hashmap using both BPF_MAP_DUMP and
BPF_MAP_GET_NEXT_KEY + BPF_MAP_LOOKUP_ELEM.

Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 tools/testing/selftests/bpf/test_maps.c | 65 +++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index b19ba6aa8e36..786d0e340aed 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -18,6 +18,7 @@
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <linux/bpf.h>
+#include <linux/time64.h>
 
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
@@ -388,6 +389,69 @@ static void test_hashmap_dump(void)
 	close(fd);
 }
 
+static void test_hashmap_dump_perf(void)
+{
+	int fd, i, max_entries = 100000;
+	uint64_t key, value, next_key;
+	bool next_key_valid = true;
+	void *buf;
+	u32 buf_len, entries;
+	int j = 0;
+	int clk_id = CLOCK_MONOTONIC;
+	struct timespec begin, end;
+	long long time_spent, dump_time_spent;
+	double res;
+	int tests[] = {1, 2, 230, 5000, 73000, 100000, 234567};
+	int test_len = ARRAY_SIZE(tests);
+	const int elem_size = sizeof(key) + sizeof(value);
+
+	fd = helper_fill_hashmap(max_entries);
+	// Alloc memory considering the largest buffer
+	buf = malloc(elem_size * tests[test_len-1]);
+	assert(buf != NULL);
+
+test:
+	entries = tests[j];
+	buf_len = elem_size*tests[j];
+	j++;
+	clock_gettime(clk_id, &begin);
+	errno = 0;
+	i = 0;
+	while (errno == 0) {
+		bpf_map_dump(fd, !i ? NULL : &key,
+				  buf, &buf_len);
+		if (errno)
+			break;
+		if (!i)
+			key = *((uint64_t *)(buf + buf_len - elem_size));
+		i += buf_len / elem_size;
+	}
+	clock_gettime(clk_id, &end);
+	assert(i  == max_entries);
+	dump_time_spent = NSEC_PER_SEC * (end.tv_sec - begin.tv_sec) +
+			  end.tv_nsec - begin.tv_nsec;
+	next_key_valid = true;
+	clock_gettime(clk_id, &begin);
+	assert(bpf_map_get_next_key(fd, NULL, &key) == 0);
+	for (i = 0; next_key_valid; i++) {
+		next_key_valid = bpf_map_get_next_key(fd, &key, &next_key) == 0;
+		assert(bpf_map_lookup_elem(fd, &key, &value) == 0);
+		key = next_key;
+	}
+	clock_gettime(clk_id, &end);
+	time_spent = NSEC_PER_SEC * (end.tv_sec - begin.tv_sec) +
+		     end.tv_nsec - begin.tv_nsec;
+	res = (1-((double)dump_time_spent/time_spent))*100;
+	printf("buf_len_%u:\t %llu entry-by-entry: %llu improvement %lf\n",
+	       entries, dump_time_spent, time_spent, res);
+	assert(i  == max_entries);
+
+	if (j < test_len)
+		goto test;
+	free(buf);
+	close(fd);
+}
+
 static void test_hashmap_zero_seed(void)
 {
 	int i, first, second, old_flags;
@@ -1748,6 +1812,7 @@ static void run_all_tests(void)
 	test_hashmap_walk(0, NULL);
 	test_hashmap_zero_seed();
 	test_hashmap_dump();
+	test_hashmap_dump_perf();
 
 	test_arraymap(0, NULL);
 	test_arraymap_percpu(0, NULL);
-- 
2.22.0.410.gd8fdbe21b5-goog


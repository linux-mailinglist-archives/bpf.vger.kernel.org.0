Return-Path: <bpf+bounces-34962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1FC934314
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 22:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12502837EE
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 20:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E138A1849CC;
	Wed, 17 Jul 2024 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="LcxApAqI"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1711EA71;
	Wed, 17 Jul 2024 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247329; cv=none; b=ObALyLS3LJMQ2uKySoKc953Fqbq6Vpc1q4YSADuCkB+210Vac/dpycxn62Xgt1qbu2CVsmEL4Kzcc94TLap1JIT5EiCrOKDPibkxxHT+zBcer6Hu4o6MvOMG7PLlhtpTdcZlC1rFqXh/KjZnl90M8a6lKINJ+4Ht6Aga5VGvW6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247329; c=relaxed/simple;
	bh=0g+ZT+4uE6FwLos7ELn16xjQND4xQamWxa5AzJl0M18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhcnLEU9T0V16idjDG2Hz5JhkHEEMMDb6KCIBZf6/0QTdzJ72uhtqosa1ckE1YQWlD8kPOIVkjgGfYz5C04LLUiNc5mtpOLehZ7b2D2dZB0v2td1OLPWUnl9Cw9EJpZUO5NUipRxW2nEOKv7e31wvakJa2vcMI2OXAEKgHriVms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=LcxApAqI; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sUB3V-006Rwm-Ce; Wed, 17 Jul 2024 22:15:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=/YsfU3vHc8Ijpi0inmDcDvDT1S6B5Z8cNwDXZQuauJE=; b=LcxApAqISg4lpPpHPpaylX3h8O
	ORK4F+UpF8aM2K6EqJo8t0xBY5e97mWJ/3iGjWBaS2cAXcz8b+wGTK83PaiYidYUvpuN+/n9cUeXE
	JiWaJu+rruSnaAw1H2ZwOKiW7+aWfHujkckre3Qi4zXLnEgQwsYMRJYdnvI8qN1VvEYHb30qYjbwj
	sHBstSovXBqnGG2PEonNozEyHLH2kMQncruCicvDPbqVDyAEKYipfIgfWzx8Jpzf3yJYAVpVbZIS4
	2dIhZp14pp0bVF1Bo5foYiI7nKiPQ9ikmwiSgvRQlWl3P+aNRZUZOrUyLTRwwvUVz5ZyYekOW3ago
	T8U8yabQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sUB3U-0003Va-E6; Wed, 17 Jul 2024 22:15:16 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sUB3I-00CYbP-5I; Wed, 17 Jul 2024 22:15:04 +0200
Message-ID: <2eae7943-38d7-4839-ae72-97f9a3123c8a@rbox.co>
Date: Wed, 17 Jul 2024 22:15:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in
 unix_inet_redir_to_connected()
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.fastabend@gmail.com, kuniyu@amazon.com, Rao.Shoaib@oracle.com,
 cong.wang@bytedance.com
References: <20240707222842.4119416-1-mhal@rbox.co>
 <20240707222842.4119416-3-mhal@rbox.co> <87zfqqnbex.fsf@cloudflare.com>
 <fb95824c-6068-47f2-b9eb-894ea9182ede@rbox.co>
 <87ikx962wm.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87ikx962wm.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/24 11:45, Jakub Sitnicki wrote:
> On Thu, Jul 11, 2024 at 10:33 PM +02, Michal Luczaj wrote:
>> And looking at that commit[1], inet_unix_redir_to_connected() has its
>> @type ignored, too.  Same treatment?
> 
> That one will not be a trivial fix like this case. inet_socketpair()
> won't work for TCP as is. It will fail trying to connect() a listening
> socket (p0). I recall now that we are in this state due to some
> abandoned work that began in 75e0e27db6cf ("selftest/bpf: Change udp to
> inet in some function names").
> [...]

Is this what you've meant? With this patch inet_socketpair() and
vsock_socketpair_connectible can be reduced to a single call to
create_pair(). And pairs creation in inet_unix_redir_to_connected()
and unix_inet_redir_to_connected() accepts both sotypes.

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1337153eb0ad..5b17d69c9ee6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -451,11 +451,11 @@ static void test_sockmap_progs_query(enum bpf_attach_type attach_type)
 #define MAX_EVENTS 10
 static void test_sockmap_skb_verdict_shutdown(void)
 {
+	int n, err, map, verdict, c1 = -1, p1 = -1;
 	struct epoll_event ev, events[MAX_EVENTS];
-	int n, err, map, verdict, s, c1 = -1, p1 = -1;
 	struct test_sockmap_pass_prog *skel;
-	int epollfd;
 	int zero = 0;
+	int epollfd;
 	char b;
 
 	skel = test_sockmap_pass_prog__open_and_load();
@@ -469,10 +469,7 @@ static void test_sockmap_skb_verdict_shutdown(void)
 	if (!ASSERT_OK(err, "bpf_prog_attach"))
 		goto out;
 
-	s = socket_loopback(AF_INET, SOCK_STREAM);
-	if (s < 0)
-		goto out;
-	err = create_pair(s, AF_INET, SOCK_STREAM, &c1, &p1);
+	err = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
 	if (err < 0)
 		goto out;
 
@@ -570,16 +567,12 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 
 static void test_sockmap_skb_verdict_peek_helper(int map)
 {
-	int err, s, c1, p1, zero = 0, sent, recvd, avail;
+	int err, c1, p1, zero = 0, sent, recvd, avail;
 	char snd[256] = "0123456789";
 	char rcv[256] = "0";
 
-	s = socket_loopback(AF_INET, SOCK_STREAM);
-	if (!ASSERT_GT(s, -1, "socket_loopback(s)"))
-		return;
-
-	err = create_pair(s, AF_INET, SOCK_STREAM, &c1, &p1);
-	if (!ASSERT_OK(err, "create_pairs(s)"))
+	err = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
+	if (!ASSERT_OK(err, "create_pair()"))
 		return;
 
 	err = bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index e880f97bc44d..4fa8dc97ac88 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -312,54 +312,6 @@ static inline int add_to_sockmap(int sock_mapfd, int fd1, int fd2)
 	return xbpf_map_update_elem(sock_mapfd, &key, &value, BPF_NOEXIST);
 }
 
-static inline int create_pair(int s, int family, int sotype, int *c, int *p)
-{
-	struct sockaddr_storage addr;
-	socklen_t len;
-	int err = 0;
-
-	len = sizeof(addr);
-	err = xgetsockname(s, sockaddr(&addr), &len);
-	if (err)
-		return err;
-
-	*c = xsocket(family, sotype, 0);
-	if (*c < 0)
-		return errno;
-	err = xconnect(*c, sockaddr(&addr), len);
-	if (err) {
-		err = errno;
-		goto close_cli0;
-	}
-
-	*p = xaccept_nonblock(s, NULL, NULL);
-	if (*p < 0) {
-		err = errno;
-		goto close_cli0;
-	}
-	return err;
-close_cli0:
-	close(*c);
-	return err;
-}
-
-static inline int create_socket_pairs(int s, int family, int sotype,
-				      int *c0, int *c1, int *p0, int *p1)
-{
-	int err;
-
-	err = create_pair(s, family, sotype, c0, p0);
-	if (err)
-		return err;
-
-	err = create_pair(s, family, sotype, c1, p1);
-	if (err) {
-		close(*c0);
-		close(*p0);
-	}
-	return err;
-}
-
 static inline int enable_reuseport(int s, int progfd)
 {
 	int err, one = 1;
@@ -412,5 +364,83 @@ static inline int socket_loopback(int family, int sotype)
 	return socket_loopback_reuseport(family, sotype, -1);
 }
 
+static inline int create_pair(int family, int sotype, int *c, int *p)
+{
+	struct sockaddr_storage addr;
+	socklen_t len = sizeof(addr);
+	int s, err;
+
+	s = socket_loopback(family, sotype);
+	if (s < 0)
+		return s;
+
+	err = xgetsockname(s, sockaddr(&addr), &len);
+	if (err)
+		goto close_s;
+
+	*c = xsocket(family, sotype, 0);
+	if (*c < 0) {
+		err = *c;
+		goto close_s;
+	}
+
+	err = connect(*c, sockaddr(&addr), len);
+	if (err) {
+		if (errno != EINPROGRESS) {
+			FAIL_ERRNO("connect");
+			goto close_c;
+		}
+
+		err = poll_connect(*c, IO_TIMEOUT_SEC);
+		if (err) {
+			FAIL_ERRNO("poll_connect");
+			goto close_c;
+		}
+	}
+
+	if (sotype & SOCK_DGRAM) {
+		err = xgetsockname(*c, sockaddr(&addr), &len);
+		if (err)
+			goto close_c;
+
+		err = xconnect(s, sockaddr(&addr), len);
+		if (!err) {
+			*p = s;
+			return err;
+		}
+	} else if (sotype & SOCK_STREAM) {
+		*p = xaccept_nonblock(s, NULL, NULL);
+		if (*p >= 0)
+			goto close_s;
+
+		err = *p;
+	} else {
+		FAIL("Unsupported socket type %#x", sotype);
+		err = -1;
+	}
+
+close_c:
+	close(*c);
+close_s:
+	close(s);
+	return err;
+}
+
+static inline int create_socket_pairs(int s, int family, int sotype,
+				      int *c0, int *c1, int *p0, int *p1)
+{
+	int err;
+
+	err = create_pair(family, sotype, c0, p0);
+	if (err)
+		return err;
+
+	err = create_pair(family, sotype, c1, p1);
+	if (err) {
+		close(*c0);
+		close(*p0);
+	}
+	return err;
+}
 
 #endif // __SOCKMAP_HELPERS__
-- 
2.45.2



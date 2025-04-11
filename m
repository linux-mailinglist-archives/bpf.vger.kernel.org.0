Return-Path: <bpf+bounces-55799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D0CA868E2
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 00:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C851B65CBA
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 22:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3256429DB72;
	Fri, 11 Apr 2025 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Okr4W/ht"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8C236451
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744410753; cv=none; b=TZdL14TggEYv044iC7VGAlAFQn1etGbvs1PDMxhVLCzI6+7Zv9dssH/E9eQb3k3vm0GNCoKyLw67FMpW0sv36yCV4DqFDTPyzlHjgMj3CrGKbZwhCBIwRejCOu1YkHQuUHaEJjRQTzpzp+ZC2qeWzKMP1GFdSdf+H0wjrogCx+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744410753; c=relaxed/simple;
	bh=2lCsrlUW8rwvVBaOiNV0PxN0VsQjU1LOCwmFqbD0TM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7tV/6PoBAH6jDk+naglbbGEm/xCqxmIsT5ZHi0vWIuKJPNB31aU7vpR11d5lnZ9KVyUG3n/stMt/CPOUOXiBnyb2yzdB/RF0e8Gb7pi27e9oanCG3Yt8rVk08wNaok1ysbV1krXNGZckka5FRc0KPAiKwREvwY9OR1u/py7YKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Okr4W/ht; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <315cc79b-fc63-4164-9725-8b5fe2fb27f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744410735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1A0aKt1+2X4pyxLE4isYfWElCIRdoii66G/IhV0//ng=;
	b=Okr4W/htAohX7vZ54Kbh+NyBLgYD1tM5cpt098Xl/ajx6AKnb99QwvVDDthAWz1l5r5K44
	5GwyStaYUIeno9Og2WRsCGVDewbWX/uuAaxuUixA+7IrQZdpAUFDEl8t8x2u/GkjfJCIub
	2yuqhvivcbqTjROF+pnRvLiFaZveYiY=
Date: Fri, 11 Apr 2025 15:32:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 5/5] selftests/bpf: Add tests for bucket
 resume logic in UDP socket iterators
To: Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Aditi Ghag <aditi.ghag@isovalent.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20250411173551.772577-1-jordan@jrife.io>
 <20250411173551.772577-6-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250411173551.772577-6-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/11/25 10:35 AM, Jordan Rife wrote:
> Introduce a set of tests that exercise various bucket resume scenarios:
> 
> * remove_seen resumes iteration after removing a socket from the bucket
>    that we've already processed. Before, with the offset-based approach,
>    this test would have skipped an unseen socket after resuming
>    iteration. With the cookie-based approach, we now see all sockets
>    exactly once.
> * remove_unseen exercises the condition where the next socket that we
>    would have seen is removed from the bucket before we resume iteration.
>    This tests the scenario where we need to scan past the first cookie in
>    our remembered cookies list to find the socket from which to resume
>    iteration.
> * remove_all exercises the condition where all sockets we remembered
>    were removed from the bucket to make sure iteration terminates and
>    returns no more results.
> * add_some exercises the condition where a few, but not enough to
>    trigger a realloc, sockets are added to the head of the current bucket
>    between reads. Before, with the offset-based approach, this test would
>    have repeated sockets we've already seen. With the cookie-based
>    approach, we now see all sockets exactly once.
> * force_realloc exercises the condition that we need to realloc the
>    batch on a subsequent read, since more sockets than can be held in the
>    current batch array were added to the current bucket. This exercies
>    the logic inside bpf_iter_udp_realloc_batch that copies cookies into
>    the new batch to make sure nothing is skipped or repeated.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> ---
>   .../bpf/prog_tests/sock_iter_batch.c          | 418 ++++++++++++++++++
>   1 file changed, 418 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
> index 74dbe91806a0..93b992fa5efe 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
> @@ -7,6 +7,7 @@
>   
>   #define TEST_NS "sock_iter_batch_netns"
>   
> +static const int init_batch_size = 16;
>   static const int nr_soreuse = 4;
>   
>   struct iter_out {
> @@ -14,6 +15,422 @@ struct iter_out {
>   	__u64 cookie;
>   } __packed;
>   
> +struct sock_count {
> +	__u64 cookie;
> +	int count;
> +};
> +
> +static int insert(__u64 cookie, struct sock_count counts[], int counts_len)
> +{
> +	int insert = -1;
> +	int i = 0;
> +
> +	for (; i < counts_len; i++) {
> +		if (!counts[i].cookie) {
> +			insert = i;
> +		} else if (counts[i].cookie == cookie) {
> +			insert = i;
> +			break;
> +		}
> +	}
> +	if (insert < 0)
> +		return insert;
> +
> +	counts[insert].cookie = cookie;
> +	counts[insert].count++;
> +
> +	return counts[insert].count;
> +}
> +
> +static int read_n(int iter_fd, int n, struct sock_count counts[],
> +		  int counts_len)
> +{
> +	struct iter_out out;
> +	int nread = 1;
> +	int i = 0;
> +
> +	for (; nread > 0 && (n < 0 || i < n); i++) {
> +		nread = read(iter_fd, &out, sizeof(out));
> +		if (!nread || !ASSERT_GE(nread, 1, "nread"))

why checks nread >= 1 instead of nread == sizeof(out)?

> +			break;
> +		ASSERT_GE(insert(out.cookie, counts, counts_len), 0, "insert");
> +	}
> +
> +	ASSERT_TRUE(n < 0 || i == n, "n < 0 || i == n");
> +
> +	return i;
> +}
> +
> +static __u64 socket_cookie(int fd)
> +{
> +	__u64 cookie;
> +	socklen_t cookie_len = sizeof(cookie);
> +	static __u32 duration;	/* for CHECK macro */
> +
> +	if (CHECK(getsockopt(fd, SOL_SOCKET, SO_COOKIE, &cookie, &cookie_len) < 0,

ASSERT_OK

> +		  "getsockopt(SO_COOKIE)", "%s\n", strerror(errno)))
> +		return 0;
> +	return cookie;
> +}
> +
> +static bool was_seen(int fd, struct sock_count counts[], int counts_len)
> +{
> +	__u64 cookie = socket_cookie(fd);
> +	int i = 0;
> +
> +	for (; cookie && i < counts_len; i++)
> +		if (cookie == counts[i].cookie)
> +			return true;
> +
> +	return false;
> +}
> +
> +static int get_seen_socket(int *fds, struct sock_count counts[], int n)
> +{
> +	int i = 0;
> +
> +	for (; i < n; i++)
> +		if (was_seen(fds[i], counts, n))
> +			return i;
> +	return -1;
> +}
> +
> +static int get_nth_socket(int *fds, int fds_len, struct bpf_link *link, int n)
> +{
> +	int i, nread, iter_fd;
> +	int nth_sock_idx = -1;
> +	struct iter_out out;
> +
> +	iter_fd = bpf_iter_create(bpf_link__fd(link));
> +	if (!ASSERT_GE(iter_fd, 0, "bpf_iter_create"))

ASSERT_OK_FD

> +		return -1;
> +
> +	for (; n >= 0; n--) {
> +		nread = read(iter_fd, &out, sizeof(out));
> +		if (!nread || !ASSERT_GE(nread, 1, "nread"))
> +			goto done;
> +	}
> +
> +	for (i = 0; i < fds_len && nth_sock_idx < 0; i++)
> +		if (fds[i] >= 0 && socket_cookie(fds[i]) == out.cookie)
> +			nth_sock_idx = i;
> +done:
> +	if (iter_fd >= 0)

Not needed.

> +		close(iter_fd);
> +	return nth_sock_idx;
> +}
> +
> +static int get_seen_count(int fd, struct sock_count counts[], int n)
> +{
> +	__u64 cookie = socket_cookie(fd);
> +	int count = 0;
> +	int i = 0;
> +
> +	for (; cookie && !count && i < n; i++)
> +		if (cookie == counts[i].cookie)
> +			count = counts[i].count;
> +
> +	return count;
> +}
> +
> +static void check_n_were_seen_once(int *fds, int fds_len, int n,
> +				   struct sock_count counts[], int counts_len)
> +{
> +	int seen_once = 0;
> +	int seen_cnt;
> +	int i = 0;
> +
> +	for (; i < fds_len; i++) {
> +		/* Skip any sockets that were closed or that weren't seen
> +		 * exactly once.
> +		 */
> +		if (fds[i] < 0)
> +			continue;
> +		seen_cnt = get_seen_count(fds[i], counts, counts_len);
> +		if (seen_cnt && ASSERT_EQ(seen_cnt, 1, "seen_cnt"))
> +			seen_once++;
> +	}
> +
> +	ASSERT_EQ(seen_once, n, "seen_once");
> +}
> +
> +static void remove_seen(int family, int sock_type, const char *addr, __u16 port,
> +			int *socks, int socks_len, struct sock_count *counts,
> +			int counts_len, struct bpf_link *link, int iter_fd)
> +{
> +	int close_idx;
> +
> +	/* Iterate through the first socks_len - 1 sockets. */
> +	read_n(iter_fd, socks_len - 1, counts, counts_len);
> +
> +	/* Make sure we saw socks_len - 1 sockets exactly once. */
> +	check_n_were_seen_once(socks, socks_len, socks_len - 1, counts,
> +			       counts_len);
> +
> +	/* Close a socket we've already seen to remove it from the bucket. */
> +	close_idx = get_seen_socket(socks, counts, counts_len);
> +	if (!ASSERT_GE(close_idx, 0, "close_idx"))
> +		return;
> +	close(socks[close_idx]);
> +	socks[close_idx] = -1;
> +
> +	/* Iterate through the rest of the sockets. */
> +	read_n(iter_fd, -1, counts, counts_len);
> +
> +	/* Make sure the last socket wasn't skipped and that there were no
> +	 * repeats.
> +	 */
> +	check_n_were_seen_once(socks, socks_len, socks_len - 1, counts,
> +			       counts_len);
> +}
> +
> +static void remove_unseen(int family, int sock_type, const char *addr,
> +			  __u16 port, int *socks, int socks_len,
> +			  struct sock_count *counts, int counts_len,
> +			  struct bpf_link *link, int iter_fd)
> +{
> +	int close_idx;
> +
> +	/* Iterate through the first socket. */
> +	read_n(iter_fd, 1, counts, counts_len);
> +
> +	/* Make sure we saw a socket from fds. */
> +	check_n_were_seen_once(socks, socks_len, 1, counts, counts_len);
> +
> +	/* Close what would be the next socket in the bucket to exercise the
> +	 * condition where we need to skip past the first cookie we remembered.
> +	 */
> +	close_idx = get_nth_socket(socks, socks_len, link, 1);
> +	if (!ASSERT_GE(close_idx, 0, "close_idx"))
> +		return;
> +	close(socks[close_idx]);
> +	socks[close_idx] = -1;
> +
> +	/* Iterate through the rest of the sockets. */
> +	read_n(iter_fd, -1, counts, counts_len);
> +
> +	/* Make sure the remaining sockets were seen exactly once and that we
> +	 * didn't repeat the socket that was already seen.
> +	 */
> +	check_n_were_seen_once(socks, socks_len, socks_len - 1, counts,
> +			       counts_len);
> +}
> +
> +static void remove_all(int family, int sock_type, const char *addr,
> +		       __u16 port, int *socks, int socks_len,
> +		       struct sock_count *counts, int counts_len,
> +		       struct bpf_link *link, int iter_fd)
> +{
> +	int close_idx, i;
> +
> +	/* Iterate through the first socket. */
> +	read_n(iter_fd, 1, counts, counts_len);
> +
> +	/* Make sure we saw a socket from fds. */
> +	check_n_were_seen_once(socks, socks_len, 1, counts, counts_len);
> +
> +	/* Close all remaining sockets to exhaust the list of saved cookies and
> +	 * exit without putting any sockets into the batch on the next read.
> +	 */
> +	for (i = 0; i < socks_len - 1; i++) {
> +		close_idx = get_nth_socket(socks, socks_len, link, 1);
> +		if (!ASSERT_GE(close_idx, 0, "close_idx"))
> +			return;
> +		close(socks[close_idx]);
> +		socks[close_idx] = -1;
> +	}
> +
> +	/* Make sure there are no more sockets returned */
> +	ASSERT_EQ(read_n(iter_fd, -1, counts, counts_len), 0, "read_n");
> +}
> +
> +static void add_some(int family, int sock_type, const char *addr, __u16 port,
> +		     int *socks, int socks_len, struct sock_count *counts,
> +		     int counts_len, struct bpf_link *link, int iter_fd)
> +{
> +	int *new_socks = NULL;
> +
> +	/* Iterate through the first socks_len - 1 sockets. */
> +	read_n(iter_fd, socks_len - 1, counts, counts_len);
> +
> +	/* Make sure we saw socks_len - 1 sockets exactly once. */
> +	check_n_were_seen_once(socks, socks_len, socks_len - 1, counts,
> +			       counts_len);
> +
> +	/* Double the number of sockets in the bucket. */
> +	new_socks = start_reuseport_server(family, sock_type, addr, port, 0,
> +					   socks_len);
> +	if (!ASSERT_OK_PTR(new_socks, "start_reuseport_server"))
> +		goto done;
> +
> +	/* Iterate through the rest of the sockets. */
> +	read_n(iter_fd, -1, counts, counts_len);
> +
> +	/* Make sure each of the original sockets was seen exactly once. */
> +	check_n_were_seen_once(socks, socks_len, socks_len, counts,
> +			       counts_len);
> +done:
> +	if (new_socks)

Not needed.

> +		free_fds(new_socks, socks_len);
> +}
> +
> +static void force_realloc(int family, int sock_type, const char *addr,
> +			  __u16 port, int *socks, int socks_len,
> +			  struct sock_count *counts, int counts_len,
> +			  struct bpf_link *link, int iter_fd)
> +{
> +	int *new_socks = NULL;
> +
> +	/* Iterate through the first socket just to initialize the batch. */
> +	read_n(iter_fd, 1, counts, counts_len);
> +
> +	/* Double the number of sockets in the bucket to force a realloc on the
> +	 * next read.
> +	 */
> +	new_socks = start_reuseport_server(family, sock_type, addr, port, 0,
> +					   socks_len);
> +	if (!ASSERT_OK_PTR(new_socks, "start_reuseport_server"))
> +		goto done;
> +
> +	/* Iterate through the rest of the sockets. */
> +	read_n(iter_fd, -1, counts, counts_len);
> +
> +	/* Make sure each socket from the first set was seen exactly once. */
> +	check_n_were_seen_once(socks, socks_len, socks_len, counts,
> +			       counts_len);
> +done:
> +	if (new_socks)

Not needed.

> +		free_fds(new_socks, socks_len);
> +}
> +
> +struct test_case {
> +	void (*test)(int family, int sock_type, const char *addr, __u16 port,
> +		     int *socks, int socks_len, struct sock_count *counts,
> +		     int counts_len, struct bpf_link *link, int iter_fd);
> +	const char *description;
> +	int init_socks;
> +	int max_socks;
> +	int sock_type;
> +	int family;
> +};
> +
> +static struct test_case resume_tests[] = {
> +	{
> +		.description = "udp: resume after removing a seen socket",
> +		.init_socks = nr_soreuse,
> +		.max_socks = nr_soreuse,
> +		.sock_type = SOCK_DGRAM,
> +		.family = AF_INET6,
> +		.test = remove_seen,
> +	},
> +	{
> +		.description = "udp: resume after removing one unseen socket",
> +		.init_socks = nr_soreuse,
> +		.max_socks = nr_soreuse,
> +		.sock_type = SOCK_DGRAM,
> +		.family = AF_INET6,
> +		.test = remove_unseen,
> +	},
> +	{
> +		.description = "udp: resume after removing all unseen sockets",
> +		.init_socks = nr_soreuse,
> +		.max_socks = nr_soreuse,
> +		.sock_type = SOCK_DGRAM,
> +		.family = AF_INET6,
> +		.test = remove_all,
> +	},
> +	{
> +		.description = "udp: resume after adding a few sockets",
> +		.init_socks = nr_soreuse,
> +		.max_socks = nr_soreuse,
> +		.sock_type = SOCK_DGRAM,
> +		/* Use AF_INET so that new sockets are added to the head of the
> +		 * bucket's list.
> +		 */
> +		.family = AF_INET,
> +		.test = add_some,
> +	},
> +	{
> +		.description = "udp: force a realloc to occur",
> +		.init_socks = init_batch_size,
> +		.max_socks = init_batch_size * 2,
> +		.sock_type = SOCK_DGRAM,
> +		/* Use AF_INET6 so that new sockets are added to the tail of the
> +		 * bucket's list, needing to be added to the next batch to force
> +		 * a realloc.
> +		 */
> +		.family = AF_INET6,
> +		.test = force_realloc,
> +	},
> +};
> +
> +static void do_resume_test(struct test_case *tc)
> +{
> +	static const __u16 port = 10001;
> +	struct bpf_link *link = NULL;
> +	struct sock_iter_batch *skel;
> +	struct sock_count *counts;
> +	int err, iter_fd = -1;
> +	const char *addr;
> +	int *fds;
> +
> +	counts = calloc(tc->max_socks, sizeof(*counts));


free(counts) is missing.

> +	if (!counts)
> +		return;
> +	skel = sock_iter_batch__open();
> +	if (!ASSERT_OK_PTR(skel, "sock_iter_batch__open"))
> +		return;
> +
> +	/* Prepare a bucket of sockets in the kernel hashtable */
> +	int local_port;

Move to the beginning of the function.

> +
> +	addr = tc->family == AF_INET6 ? "::1" : "127.0.0.1";
> +	fds = start_reuseport_server(tc->family, tc->sock_type, addr, port, 0,
> +				     tc->init_socks);
> +	if (!ASSERT_OK_PTR(fds, "start_reuseport_server"))
> +		goto done;
> +	local_port = get_socket_local_port(*fds);
> +	if (!ASSERT_GE(local_port, 0, "get_socket_local_port"))
> +		goto done;
> +	skel->rodata->ports[0] = ntohs(local_port);
> +	skel->rodata->sf = tc->family;
> +
> +	err = sock_iter_batch__load(skel);
> +	if (!ASSERT_OK(err, "sock_iter_batch__load"))
> +		goto done;
> +
> +	link = bpf_program__attach_iter(tc->sock_type == SOCK_STREAM ?
> +					skel->progs.iter_tcp_soreuse :
> +					skel->progs.iter_udp_soreuse,
> +					NULL);
> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
> +		goto done;
> +
> +	iter_fd = bpf_iter_create(bpf_link__fd(link));
> +	if (!ASSERT_GE(iter_fd, 0, "bpf_iter_create"))

ASSERT_OK_FD

> +		goto done;
> +
> +	tc->test(tc->family, tc->sock_type, addr, port, fds, tc->init_socks,
> +		 counts, tc->max_socks, link, iter_fd);
> +done:
> +	free_fds(fds, tc->init_socks);
> +	if (iter_fd >= 0)
> +		close(iter_fd);
> +	bpf_link__destroy(link);
> +	sock_iter_batch__destroy(skel);
> +}
> +
> +static void do_resume_tests(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(resume_tests); i++) {
> +		if (test__start_subtest(resume_tests[i].description)) {
> +			do_resume_test(&resume_tests[i]);
> +		}
> +	}
> +}
> +
>   static void do_test(int sock_type, bool onebyone)
>   {
>   	int err, i, nread, to_read, total_read, iter_fd = -1;
> @@ -135,6 +552,7 @@ void test_sock_iter_batch(void)
>   		do_test(SOCK_DGRAM, true);
>   		do_test(SOCK_DGRAM, false);
>   	}
> +	do_resume_tests();
>   	close_netns(nstoken);
>   
>   done:



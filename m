Return-Path: <bpf+bounces-11426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4027B9B4F
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 09:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 413D02818EB
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 07:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D965398;
	Thu,  5 Oct 2023 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc8Z7CbD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73587F
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 07:21:21 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBD77A9B
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 00:21:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bdcade7fbso112237166b.1
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 00:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696490478; x=1697095278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/weGMO90ZqVs6EIwFOUupvoVReSN2ILfHo/gKXJ/3yY=;
        b=Kc8Z7CbDf+pO8GfPMDW59RJVDKLPwpRmhO0Ba5rVHnYR+xV2RjdK/c+/u7l/vmD2Fv
         bEgmXKBhJUnDQTqsWd0rga8c5xjvcxNY2YX8+2CrwRYEPdw3bFp7gPbd4Zt9fJw23QDc
         kaxiUtEu5mkNGTEmNHpAD5CnozMNF4MvqV+2S/YOAKi0OxNwVUeDwYS6ZgDWWBllJqor
         XKsNrZSRNvNsJZ4u19PCSGkj7NMrrQ60OnR6mjBtRWcCHPltWCGkPZrZ7X1CcSlAOrBr
         U752Nfx2R40zupPtu+Q4YpYEZrNp9doIfR7W7+9P59vm37hRNFnlL+h7F32a1LT0F+A+
         tpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696490478; x=1697095278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/weGMO90ZqVs6EIwFOUupvoVReSN2ILfHo/gKXJ/3yY=;
        b=EYXUDEu+gu1R1p85X+rlnDgE14sMH+XtUB9d9xo1SbFx4B5K7DtGVUdbY0R0leZQev
         qzcPReV64n7HMZ4RW6eqjxYoRap6NlDAPwNT1wUVz9GOr15o3NCEmxs8Ezzx6o4ZN/gG
         Oxu/nshwnf+WTzNwAHhXf7BeCF2oPbCKKVkurIBaSDA831DhvZsm4WRPuRnuQsLvdROx
         o6cbvr+pMwovwQgxGWRUEwiRU/JVXYeW4ahqF3Y8EZtBg1cI0Q03/XK7PhydFfYKOUrd
         3n5s+7/Uy/+pBzfvUSgRUn8YbpzekksTmVMnX4aso14TBK9R9Sy70UNLGZ4NHKgE6Cpw
         wdkg==
X-Gm-Message-State: AOJu0Yy2JYIDCFjedNgjiZS1CyUwO5feOT1ILXHS7f2rnsmEz/KjQMpu
	cb3k9SAEc5V1wdunq8P1cq4=
X-Google-Smtp-Source: AGHT+IGNforPb/qaAzBiR2DKM/KrfzlWrtRGWp77lfIxhtyq9aT92w64J7g6fvlpy87ruHjYhDuiQg==
X-Received: by 2002:a17:906:768e:b0:9ae:729c:f651 with SMTP id o14-20020a170906768e00b009ae729cf651mr3940232ejm.17.1696490477479;
        Thu, 05 Oct 2023 00:21:17 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ci24-20020a170906c35800b00992ea405a79sm680696ejb.166.2023.10.05.00.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:21:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Oct 2023 09:21:15 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: fix compiler warnings
 reported in -O2 mode
Message-ID: <ZR5j6zHoEuifv/1C@krava>
References: <20231004001750.2939898-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004001750.2939898-1-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 05:17:48PM -0700, Andrii Nakryiko wrote:
> Fix a bunch of potentially unitialized variable usage warnings that are
> reported by GCC in -O2 mode. Also silence overzealous stringop-truncation
> class of warnings.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

there's now small conflict in xskxceiver.c change on latest bpf-next/master,
but anyway looks good

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/Makefile                      | 4 +++-
>  .../selftests/bpf/map_tests/map_in_map_batch_ops.c        | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/connect_ping.c     | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/linked_list.c      | 2 +-
>  tools/testing/selftests/bpf/prog_tests/lwt_helpers.h      | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/queue_stack_map.c  | 2 +-
>  tools/testing/selftests/bpf/prog_tests/sockmap_basic.c    | 8 ++++----
>  tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h  | 2 +-
>  tools/testing/selftests/bpf/prog_tests/sockmap_listen.c   | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/xdp_metadata.c     | 2 +-
>  tools/testing/selftests/bpf/test_loader.c                 | 4 ++--
>  tools/testing/selftests/bpf/xdp_features.c                | 4 ++--
>  tools/testing/selftests/bpf/xdp_hw_metadata.c             | 2 +-
>  tools/testing/selftests/bpf/xskxceiver.c                  | 2 +-
>  15 files changed, 27 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 47365161b6fc..a25e262dbc69 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -27,7 +27,9 @@ endif
>  BPF_GCC		?= $(shell command -v bpf-gcc;)
>  SAN_CFLAGS	?=
>  SAN_LDFLAGS	?= $(SAN_CFLAGS)
> -CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)	\
> +CFLAGS += -g -O0 -rdynamic						\
> +	  -Wall -Werror 						\
> +	  $(GENFLAGS) $(SAN_CFLAGS)					\
>  	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
>  	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
>  LDFLAGS += $(SAN_LDFLAGS)
> diff --git a/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
> index 16f1671e4bde..66191ae9863c 100644
> --- a/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
> +++ b/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
> @@ -33,11 +33,11 @@ static void create_inner_maps(enum bpf_map_type map_type,
>  {
>  	int map_fd, map_index, ret;
>  	__u32 map_key = 0, map_id;
> -	char map_name[15];
> +	char map_name[16];
>  
>  	for (map_index = 0; map_index < OUTER_MAP_ENTRIES; map_index++) {
>  		memset(map_name, 0, sizeof(map_name));
> -		sprintf(map_name, "inner_map_fd_%d", map_index);
> +		snprintf(map_name, sizeof(map_name), "inner_map_fd_%d", map_index);
>  		map_fd = bpf_map_create(map_type, map_name, sizeof(__u32),
>  					sizeof(__u32), 1, NULL);
>  		CHECK(map_fd < 0,
> diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
> index d2d9e965eba5..053f4d6da77a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
> @@ -193,8 +193,8 @@ static int setup_progs(struct bloom_filter_map **out_skel, __u32 **out_rand_vals
>  
>  void test_bloom_filter_map(void)
>  {
> -	__u32 *rand_vals, nr_rand_vals;
> -	struct bloom_filter_map *skel;
> +	__u32 *rand_vals = NULL, nr_rand_vals = 0;
> +	struct bloom_filter_map *skel = NULL;
>  	int err;
>  
>  	test_fail_cases();
> diff --git a/tools/testing/selftests/bpf/prog_tests/connect_ping.c b/tools/testing/selftests/bpf/prog_tests/connect_ping.c
> index 289218c2216c..40fe571f2fe7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/connect_ping.c
> +++ b/tools/testing/selftests/bpf/prog_tests/connect_ping.c
> @@ -28,9 +28,9 @@ static void subtest(int cgroup_fd, struct connect_ping *skel,
>  		.sin6_family = AF_INET6,
>  		.sin6_addr = IN6ADDR_LOOPBACK_INIT,
>  	};
> -	struct sockaddr *sa;
> +	struct sockaddr *sa = NULL;
>  	socklen_t sa_len;
> -	int protocol;
> +	int protocol = -1;
>  	int sock_fd;
>  
>  	switch (family) {
> diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
> index db3bf6bbe01a..69dc31383b78 100644
> --- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
> +++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
> @@ -268,7 +268,7 @@ static struct btf *init_btf(void)
>  
>  static void list_and_rb_node_same_struct(bool refcount_field)
>  {
> -	int bpf_rb_node_btf_id, bpf_refcount_btf_id, foo_btf_id;
> +	int bpf_rb_node_btf_id, bpf_refcount_btf_id = 0, foo_btf_id;
>  	struct btf *btf;
>  	int id, err;
>  
> diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h b/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
> index 61333f2a03f9..e9190574e79f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
> +++ b/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
> @@ -49,7 +49,8 @@ static int open_tuntap(const char *dev_name, bool need_mac)
>  		return -1;
>  
>  	ifr.ifr_flags = IFF_NO_PI | (need_mac ? IFF_TAP : IFF_TUN);
> -	memcpy(ifr.ifr_name, dev_name, IFNAMSIZ);
> +	strncpy(ifr.ifr_name, dev_name, IFNAMSIZ - 1);
> +	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
>  
>  	err = ioctl(fd, TUNSETIFF, &ifr);
>  	if (!ASSERT_OK(err, "ioctl(TUNSETIFF)")) {
> diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> index 722c5f2a7776..a043af9cd6d9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> @@ -14,7 +14,7 @@ static void test_queue_stack_map_by_type(int type)
>  	int i, err, prog_fd, map_in_fd, map_out_fd;
>  	char file[32], buf[128];
>  	struct bpf_object *obj;
> -	struct iphdr iph;
> +	struct iphdr iph = {};
>  	LIBBPF_OPTS(bpf_test_run_opts, topts,
>  		.data_in = &pkt_v4,
>  		.data_size_in = sizeof(pkt_v4),
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 064cc5e8d9ad..2535d0653cc8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -359,7 +359,7 @@ static void test_sockmap_progs_query(enum bpf_attach_type attach_type)
>  static void test_sockmap_skb_verdict_shutdown(void)
>  {
>  	struct epoll_event ev, events[MAX_EVENTS];
> -	int n, err, map, verdict, s, c1, p1;
> +	int n, err, map, verdict, s, c1 = -1, p1 = -1;
>  	struct test_sockmap_pass_prog *skel;
>  	int epollfd;
>  	int zero = 0;
> @@ -414,9 +414,9 @@ static void test_sockmap_skb_verdict_shutdown(void)
>  static void test_sockmap_skb_verdict_fionread(bool pass_prog)
>  {
>  	int expected, zero = 0, sent, recvd, avail;
> -	int err, map, verdict, s, c0, c1, p0, p1;
> -	struct test_sockmap_pass_prog *pass;
> -	struct test_sockmap_drop_prog *drop;
> +	int err, map, verdict, s, c0 = -1, c1 = -1, p0 = -1, p1 = -1;
> +	struct test_sockmap_pass_prog *pass = NULL;
> +	struct test_sockmap_drop_prog *drop = NULL;
>  	char buf[256] = "0123456789";
>  
>  	if (pass_prog) {
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> index 36d829a65aa4..e880f97bc44d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> @@ -378,7 +378,7 @@ static inline int enable_reuseport(int s, int progfd)
>  static inline int socket_loopback_reuseport(int family, int sotype, int progfd)
>  {
>  	struct sockaddr_storage addr;
> -	socklen_t len;
> +	socklen_t len = 0;
>  	int err, s;
>  
>  	init_addr_loopback(family, &addr, &len);
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index 8df8cbb447f1..e08e590b2cf8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -73,7 +73,7 @@ static void test_insert_bound(struct test_sockmap_listen *skel __always_unused,
>  			      int family, int sotype, int mapfd)
>  {
>  	struct sockaddr_storage addr;
> -	socklen_t len;
> +	socklen_t len = 0;
>  	u32 key = 0;
>  	u64 value;
>  	int err, s;
> @@ -871,7 +871,7 @@ static void test_msg_redir_to_listening(struct test_sockmap_listen *skel,
>  
>  static void redir_partial(int family, int sotype, int sock_map, int parser_map)
>  {
> -	int s, c0, c1, p0, p1;
> +	int s, c0 = -1, c1 = -1, p0 = -1, p1 = -1;
>  	int err, n, key, value;
>  	char buf[] = "abc";
>  
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 626c461fa34d..4439ba9392f8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -226,7 +226,7 @@ static int verify_xsk_metadata(struct xsk *xsk)
>  	__u64 comp_addr;
>  	void *data;
>  	__u64 addr;
> -	__u32 idx;
> +	__u32 idx = 0;
>  	int ret;
>  
>  	ret = recvfrom(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, NULL);
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index b4edd8454934..37ffa57f28a1 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -69,7 +69,7 @@ static int tester_init(struct test_loader *tester)
>  {
>  	if (!tester->log_buf) {
>  		tester->log_buf_sz = TEST_LOADER_LOG_BUF_SZ;
> -		tester->log_buf = malloc(tester->log_buf_sz);
> +		tester->log_buf = calloc(tester->log_buf_sz, 1);
>  		if (!ASSERT_OK_PTR(tester->log_buf, "tester_log_buf"))
>  			return -ENOMEM;
>  	}
> @@ -538,7 +538,7 @@ void run_subtest(struct test_loader *tester,
>  		 bool unpriv)
>  {
>  	struct test_subspec *subspec = unpriv ? &spec->unpriv : &spec->priv;
> -	struct bpf_program *tprog, *tprog_iter;
> +	struct bpf_program *tprog = NULL, *tprog_iter;
>  	struct test_spec *spec_iter;
>  	struct cap_state caps = {};
>  	struct bpf_object *tobj;
> diff --git a/tools/testing/selftests/bpf/xdp_features.c b/tools/testing/selftests/bpf/xdp_features.c
> index b449788fbd39..595c79141cf3 100644
> --- a/tools/testing/selftests/bpf/xdp_features.c
> +++ b/tools/testing/selftests/bpf/xdp_features.c
> @@ -360,9 +360,9 @@ static int recv_msg(int sockfd, void *buf, size_t bufsize, void *val,
>  static int dut_run(struct xdp_features *skel)
>  {
>  	int flags = XDP_FLAGS_UPDATE_IF_NOEXIST | XDP_FLAGS_DRV_MODE;
> -	int state, err, *sockfd, ctrl_sockfd, echo_sockfd;
> +	int state, err = 0, *sockfd, ctrl_sockfd, echo_sockfd;
>  	struct sockaddr_storage ctrl_addr;
> -	pthread_t dut_thread;
> +	pthread_t dut_thread = 0;
>  	socklen_t addrlen;
>  
>  	sockfd = start_reuseport_server(AF_INET6, SOCK_STREAM, NULL,
> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> index 613321eb84c1..17c980138796 100644
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> @@ -234,7 +234,7 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
>  	struct pollfd fds[rxq + 1];
>  	__u64 comp_addr;
>  	__u64 addr;
> -	__u32 idx;
> +	__u32 idx = 0;
>  	int ret;
>  	int i;
>  
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 43e0a5796929..b0ee1307a63b 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -1023,7 +1023,7 @@ static int receive_pkts(struct test_spec *test, struct pollfd *fds)
>  	pkt = pkt_stream_get_next_rx_pkt(pkt_stream, &pkts_sent);
>  	while (pkt) {
>  		u32 frags_processed = 0, nb_frags = 0, pkt_len = 0;
> -		u64 first_addr;
> +		u64 first_addr = 0;
>  
>  		ret = gettimeofday(&tv_now, NULL);
>  		if (ret)
> -- 
> 2.34.1
> 
> 


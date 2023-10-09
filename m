Return-Path: <bpf+bounces-11739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A08227BE6EE
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E8C281AAF
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD2B18B11;
	Mon,  9 Oct 2023 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SbCb84N/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3661715AD7
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 16:49:58 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B20392
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 09:49:56 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-56c306471ccso2798340a12.3
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696870196; x=1697474996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bMIkGjyRYQaniwgX1VwN1yvNzp3XWIxIueEXO1Vjz9g=;
        b=SbCb84N/VZPkkbxRHTTJct06OI1YV2Af1WXCHtHn3hqWNfswBvZeQKDSIz0czJa1Me
         ISRKtX3lG6/DYSQo2OhNvJzRq9Hpizwh+df5qYhCom8db6wU8aKteEXwPyEYjQJDv4pr
         AmOaG4i9WV8nESu6HnpFYpe9knvdjFIJJVvwGn/APA8g3YLOo2nkvoOlElsyGIP9z4Wj
         87/NCb1fETEo+CYtPno6rDGiHRa8mL6lOlA3VxTEeZQKIS3SMIz1myeb6UKH9RX0qKJm
         SAMrjH9xnFRuS9VXu9YZiYmFWOCsvepv7f2Rin08WwxWRp7ytA2216ez6+WLXQJSq5AC
         SByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696870196; x=1697474996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMIkGjyRYQaniwgX1VwN1yvNzp3XWIxIueEXO1Vjz9g=;
        b=UIcM6b22lgM701v1ahd7+uZpHN/P1SwqryE+k8FvbjEzSZLEI5B7spRciP0hlHHd8H
         ncTdiZovbHOFjDERMhk1J1jwT92PmJfNLTVmxsgnjyBUHPttbJB4dpXmehwsHI1AvAi4
         dCOeC8/LXkDrnZCRkNq3AD0OYEC72CjqWPZgwvAW1xZ3TBw6zcyy0E1/qFbbT2bHmwOr
         8cH4CCrvkwFELGT+YGQytsqtTJfGCP5ZLqI9W8iYu/geOQ36njFluv1FeRD73ZECaDMF
         /B+Kb/HXSVCmXTvdIMVzhkk+MDALBLbsqfJFULN5p/qK8fQr8phejdpngigK3zAl232w
         iXnA==
X-Gm-Message-State: AOJu0YzqrPLuoxbTnz2a8oleVtTIo5ihTWrvz7PmHzNu4jKLa/hXNxCb
	xCe72esaW/JO/sc4DNFmO6rCDHlpVGVyDzqWemVL8oI6WnBa6O7q2lyF9djsiJSN/nRTIgjbD0C
	gpvc6
X-Google-Smtp-Source: AGHT+IFC5L4rKTdUFwItgOfKJkjWgimq+UyPCfXidAeEd6C0SS9TnNX+4cS3h+k/P9b8ejUCqnoU+Pc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:7b4a:0:b0:577:6bf1:499b with SMTP id
 k10-20020a637b4a000000b005776bf1499bmr253491pgn.10.1696870196036; Mon, 09 Oct
 2023 09:49:56 -0700 (PDT)
Date: Mon, 9 Oct 2023 09:49:54 -0700
In-Reply-To: <20231009160520.20831-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009160520.20831-1-larysa.zaremba@intel.com>
Message-ID: <ZSQvMr3-lY9uTzn_@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add options and frags to xdp_hw_metadata
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="utf-8"
X-ccpol: medium
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/09, Larysa Zaremba wrote:
> This is a follow-up to the commit 9b2b86332a9b ("bpf: Allow to use kfunc
> XDP hints and frags together").
> 
> The are some possible implementations problems that may arise when
> providing metadata specifically for multi-buffer packets, therefore there
> must be a possibility to test such option separately.
> 
> Add an option to use multi-buffer AF_XDP xdp_hw_metadata and mark used XDP
> program as capable to use frags.
> 
> As for now, xdp_hw_metadata accepts no options, so add simple option
> parsing logic and a help message.
> 
> For quick reference, also add an ingress packet generation command to the
> help message. The command comes from [0].
> 
> Example of output for multi-buffer packet:
> 
> xsk_ring_cons__peek: 1
> 0xead018: rx_desc[15]->addr=10000000000f000 addr=f100 comp_addr=f000
> rx_hash: 0x5789FCBB with RSS type:0x29
> rx_timestamp:  1696856851535324697 (sec:1696856851.5353)
> XDP RX-time:   1696856843158256391 (sec:1696856843.1583)
> 	delta sec:-8.3771 (-8377068.306 usec)
> AF_XDP time:   1696856843158413078 (sec:1696856843.1584)
> 	delta sec:0.0002 (156.687 usec)
> 0xead018: complete idx=23 addr=f000
> xsk_ring_cons__peek: 1
> 0xead018: rx_desc[16]->addr=100000000008000 addr=8100 comp_addr=8000
> 0xead018: complete idx=24 addr=8000
> xsk_ring_cons__peek: 1
> 0xead018: rx_desc[17]->addr=100000000009000 addr=9100 comp_addr=9000 EoP
> 0xead018: complete idx=25 addr=9000
> 
> Metadata is printed for the first packet only.
> 
> [0] https://lore.kernel.org/all/20230119221536.3349901-18-sdf@google.com/
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  .../selftests/bpf/progs/xdp_hw_metadata.c     |  2 +-
>  tools/testing/selftests/bpf/xdp_hw_metadata.c | 92 ++++++++++++++++---
>  2 files changed, 79 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> index 63d7de6c6bbb..8767d919c881 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> @@ -21,7 +21,7 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
>  extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
>  				    enum xdp_rss_hash_type *rss_type) __ksym;
>  
> -SEC("xdp")
> +SEC("xdp.frags")
>  int rx(struct xdp_md *ctx)
>  {
>  	void *data, *data_meta, *data_end;
> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> index 17c980138796..25225720346b 100644
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> @@ -26,6 +26,7 @@
>  #include <linux/sockios.h>
>  #include <sys/mman.h>
>  #include <net/if.h>
> +#include <ctype.h>
>  #include <poll.h>
>  #include <time.h>
>  
> @@ -49,19 +50,29 @@ struct xsk {
>  struct xdp_hw_metadata *bpf_obj;
>  struct xsk *rx_xsk;
>  const char *ifname;
> +bool use_frags;
>  int ifindex;
>  int rxq;
>  
>  void test__fail(void) { /* for network_helpers.c */ }
>  
> -static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
> +static struct xsk_socket_config gen_socket_config(void)
>  {
> -	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
> -	const struct xsk_socket_config socket_config = {
> +	struct xsk_socket_config socket_config = {
>  		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
>  		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
>  		.bind_flags = XDP_COPY,
>  	};
> +
> +	if (use_frags)
> +		socket_config.bind_flags |= XDP_USE_SG;
> +	return socket_config;
> +}

nit: why not drop const from socket_config and add this 'if (use_frags)'
directly to open_xsk? Not sure separate function really buys us anything?

> +static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
> +{
> +	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
> +	struct xsk_socket_config socket_config = gen_socket_config();
>  	const struct xsk_umem_config umem_config = {
>  		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
>  		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
> @@ -263,11 +274,14 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
>  			verify_skb_metadata(server_fd);
>  
>  		for (i = 0; i < rxq; i++) {
> +			bool first_seg = true;
> +			bool is_eop = true;
> +
>  			if (fds[i].revents == 0)
>  				continue;
>  
>  			struct xsk *xsk = &rx_xsk[i];
> -
> +peek:
>  			ret = xsk_ring_cons__peek(&xsk->rx, 1, &idx);
>  			printf("xsk_ring_cons__peek: %d\n", ret);
>  			if (ret != 1)
> @@ -276,12 +290,19 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
>  			rx_desc = xsk_ring_cons__rx_desc(&xsk->rx, idx);
>  			comp_addr = xsk_umem__extract_addr(rx_desc->addr);
>  			addr = xsk_umem__add_offset_to_addr(rx_desc->addr);
> -			printf("%p: rx_desc[%u]->addr=%llx addr=%llx comp_addr=%llx\n",
> -			       xsk, idx, rx_desc->addr, addr, comp_addr);
> -			verify_xdp_metadata(xsk_umem__get_data(xsk->umem_area, addr),
> -					    clock_id);
> +			is_eop = !(rx_desc->options & XDP_PKT_CONTD);
> +			printf("%p: rx_desc[%u]->addr=%llx addr=%llx comp_addr=%llx%s\n",
> +			       xsk, idx, rx_desc->addr, addr, comp_addr, is_eop ? " EoP" : "");
> +			if (first_seg) {
> +				verify_xdp_metadata(xsk_umem__get_data(xsk->umem_area, addr),
> +						    clock_id);
> +				first_seg = false;
> +			}
> +
>  			xsk_ring_cons__release(&xsk->rx, 1);
>  			refill_rx(xsk, comp_addr);
> +			if (!is_eop)
> +				goto peek;
>  		}
>  	}
>  
> @@ -404,6 +425,54 @@ static void timestamping_enable(int fd, int val)
>  		error(1, errno, "setsockopt(SO_TIMESTAMPING)");
>  }
>  
> +static void print_usage(void)
> +{
> +	const char *usage =
> +		"  Usage: xdp_hw_metadata [OPTIONS] [IFNAME]\n"
> +		"  Options:\n"
> +		"  -m            Enable multi-buffer XDP for larger MTU\n"
> +		"  -h            Display this help and exit\n\n"
> +		"  Generate test packets on the other machine with:\n"
> +		"    echo -n xdp | nc -u -q1 <dst_ip> 9091\n";

nit: any reason we have two spaces in the help description? I don't
think it's a standard practice, so maybe drop them?


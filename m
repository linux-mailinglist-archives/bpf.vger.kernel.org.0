Return-Path: <bpf+bounces-10544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C96A17A992E
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 20:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD462829EC
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 18:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD27144496;
	Thu, 21 Sep 2023 17:23:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B26842BF4;
	Thu, 21 Sep 2023 17:22:47 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414D3573CE;
	Thu, 21 Sep 2023 10:18:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690fe1d9ba1so300400b3a.0;
        Thu, 21 Sep 2023 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316713; x=1695921513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5q3Il3iyqMne8gqEjfUahXva7VtyYgk1IJOkOH3elkw=;
        b=cieT2Pk3hlEbrw0pFniWYuCRBCBGNT3OKcPz3qetJQTfjtRUjJZWgAKPtX0wpGWcau
         /+owfP1t/YKOBxlWhq2fB9AKK8NA12mHwRKmRpkORUWPtw5w47xQfZKS7UdJ61YDBVIr
         zhjpUw1owuB3OWMYSUGL2tGjjFKWA/zsPr2m3oxqvg3t5F+ux0jV2+bsOCx9ZqObXY+a
         WfO33dfirNtEnBIDLwOmxtqQzK/lqx+AdvzpmuPVCU9pgkEtF5UvjeonOOubXFaeSar6
         ylZgiB1DPJTsOhcC8OhMjl+8bCdjTZYasg6cdtH1SJcfwms+0wu11obrnSOYVoK9c/mr
         C/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316713; x=1695921513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5q3Il3iyqMne8gqEjfUahXva7VtyYgk1IJOkOH3elkw=;
        b=XyZtoxXSNKlRRCGCFO9GPL5W28Uhr9+C4Z5BLCNR15Qnr1XXpBZ9B/CJNS9pJvk61b
         qRmbJSRubLrK2iEY9B7MIAhHbTlP8Mmi32r5q7zQL4Lb9Iw3pV+kMpuxeZ8Q4imbzW0C
         2ZRKoDVfy+GxIU+NoHfseAEUUo0/TmTPUt28Pynhv/MK2RYGsV4LX6qQhzGxmRNPo4Wq
         SJp9yO138FWCeR3syDCzn1fUVnuVn9HJWDGyJYJX1YGzjY3hS37hA1WcenO7POceMSDU
         Zz8p12Sk827aDZ24sMJStf7aAB63aZHDt9DgHjC7KwhxBNFVJefIq1FLMDQVFWg7SKE1
         mo6g==
X-Gm-Message-State: AOJu0Yx64oAPCSqUlPVstMmBINB1OU/smXee+qfwwZLUTJDt6PDdvo0b
	h4SQY024G2wjXf6gb2HDLL7F2b+TFDfnfAM1sJUWuuMMakI=
X-Google-Smtp-Source: AGHT+IHG8NxDP/QinPs3JQlu8rvBxT1D7zqKf8WDI0BZ3NF4fzjARx7yPaFthNuIAdktLFgWb9oJLI5DtP8a8rzEVnE=
X-Received: by 2002:a05:6214:21ab:b0:655:ebd0:1fc2 with SMTP id
 t11-20020a05621421ab00b00655ebd01fc2mr4592620qvc.5.1695278604404; Wed, 20 Sep
 2023 23:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918093304.367826-1-tushar.vyavahare@intel.com> <20230918093304.367826-4-tushar.vyavahare@intel.com>
In-Reply-To: <20230918093304.367826-4-tushar.vyavahare@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 21 Sep 2023 08:43:13 +0200
Message-ID: <CAJ8uoz1nLdzY3BDYwaRnYbZZvtASOWg39=Cwyy1WsfELA9WNpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/8] selftests/xsk: implement a function that
 generates MAC addresses
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	tirthendu.sarkar@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 18 Sept 2023 at 11:13, Tushar Vyavahare
<tushar.vyavahare@intel.com> wrote:
>
> Move the src_mac and dst_mac fields from the ifobject structure to the
> xsk_socket_info structure to achieve per-socket MAC address assignment.
> Implement the function called generate_mac_addresses() to generate MAC
> addresses based on the required number by the framework.
>
> Require this in order to steer traffic to various sockets in subsequent
> patches.
>
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 45 ++++++++++++++----------
>  tools/testing/selftests/bpf/xskxceiver.h |  8 +++--
>  2 files changed, 33 insertions(+), 20 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index ad1f7f078f5f..9f241f503eed 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -104,9 +104,6 @@
>  #include "../kselftest.h"
>  #include "xsk_xdp_common.h"
>
> -static const char *MAC1 = "\x00\x0A\x56\x9E\xEE\x62";
> -static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
> -
>  static bool opt_verbose;
>  static bool opt_print_tests;
>  static enum test_mode opt_mode = TEST_MODE_ALL;
> @@ -145,6 +142,18 @@ static void report_failure(struct test_spec *test)
>         test->fail = true;
>  }
>
> +static void generate_mac_addresses(const u8 *g_mac, u32 num_macs)
> +{
> +       u32 i, j;
> +
> +       for (i = 0; i < num_macs; i++) {
> +               for (j = 0; j < ETH_ALEN; j++)
> +                       macs[i][j] = g_mac[j];
> +
> +               macs[i][ETH_ALEN - 1] += i;
> +       }
> +}
> +
>  /* The payload is a word consisting of a packet sequence number in the upper
>   * 16-bits and a intra packet data sequence number in the lower 16 bits. So the 3rd packet's
>   * 5th word of data will contain the number (2<<16) | 4 as they are numbered from 0.
> @@ -159,10 +168,10 @@ static void write_payload(void *dest, u32 pkt_nb, u32 start, u32 size)
>                 ptr[i] = htonl(pkt_nb << 16 | (i + start));
>  }
>
> -static void gen_eth_hdr(struct ifobject *ifobject, struct ethhdr *eth_hdr)
> +static void gen_eth_hdr(struct xsk_socket_info *xsk, struct ethhdr *eth_hdr)
>  {
> -       memcpy(eth_hdr->h_dest, ifobject->dst_mac, ETH_ALEN);
> -       memcpy(eth_hdr->h_source, ifobject->src_mac, ETH_ALEN);
> +       memcpy(eth_hdr->h_dest, xsk->dst_mac, ETH_ALEN);
> +       memcpy(eth_hdr->h_source, xsk->src_mac, ETH_ALEN);
>         eth_hdr->h_proto = htons(ETH_P_LOOPBACK);
>  }
>
> @@ -445,6 +454,9 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
>                                 ifobj->xsk_arr[j].pkt_stream = test->tx_pkt_stream_default;
>                         else
>                                 ifobj->xsk_arr[j].pkt_stream = test->rx_pkt_stream_default;
> +
> +                       memcpy(ifobj->xsk_arr[j].src_mac, macs[j * 2 + i % 2], ETH_ALEN);
> +                       memcpy(ifobj->xsk_arr[j].dst_mac, macs[j * 2 + (i + 1) % 2], ETH_ALEN);
>                 }
>         }
>
> @@ -726,16 +738,16 @@ static void pkt_stream_cancel(struct pkt_stream *pkt_stream)
>         pkt_stream->current_pkt_nb--;
>  }
>
> -static void pkt_generate(struct ifobject *ifobject, u64 addr, u32 len, u32 pkt_nb,
> -                        u32 bytes_written)
> +static void pkt_generate(struct xsk_socket_info *xsk, struct xsk_umem_info *umem, u64 addr, u32 len,
> +                        u32 pkt_nb, u32 bytes_written)
>  {
> -       void *data = xsk_umem__get_data(ifobject->umem->buffer, addr);
> +       void *data = xsk_umem__get_data(umem->buffer, addr);
>
>         if (len < MIN_PKT_SIZE)
>                 return;
>
>         if (!bytes_written) {
> -               gen_eth_hdr(ifobject, data);
> +               gen_eth_hdr(xsk, data);
>
>                 len -= PKT_HDR_SIZE;
>                 data += PKT_HDR_SIZE;
> @@ -1209,7 +1221,7 @@ static int __send_pkts(struct ifobject *ifobject, struct pollfd *fds, bool timeo
>                                 tx_desc->options = 0;
>                         }
>                         if (pkt->valid)
> -                               pkt_generate(ifobject, tx_desc->addr, tx_desc->len, pkt->pkt_nb,
> +                               pkt_generate(xsk, umem, tx_desc->addr, tx_desc->len, pkt->pkt_nb,
>                                              bytes_written);
>                         bytes_written += tx_desc->len;
>
> @@ -2120,15 +2132,11 @@ static bool hugepages_present(void)
>         return true;
>  }
>
> -static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *src_mac,
> -                      thread_func_t func_ptr)
> +static void init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
>  {
>         LIBBPF_OPTS(bpf_xdp_query_opts, query_opts);
>         int err;
>
> -       memcpy(ifobj->dst_mac, dst_mac, ETH_ALEN);
> -       memcpy(ifobj->src_mac, src_mac, ETH_ALEN);
> -
>         ifobj->func_ptr = func_ptr;
>
>         err = xsk_load_xdp_programs(ifobj);
> @@ -2391,6 +2399,7 @@ int main(int argc, char **argv)
>                 ksft_exit_xfail();
>         }
>
> +       generate_mac_addresses(g_mac, NUM_MAC_ADDRESSES);

Why pass down a global variable?

>         shared_netdev = (ifobj_tx->ifindex == ifobj_rx->ifindex);
>         ifobj_tx->shared_umem = shared_netdev;
>         ifobj_rx->shared_umem = shared_netdev;
> @@ -2404,8 +2413,8 @@ int main(int argc, char **argv)
>                         modes++;
>         }
>
> -       init_iface(ifobj_rx, MAC1, MAC2, worker_testapp_validate_rx);
> -       init_iface(ifobj_tx, MAC2, MAC1, worker_testapp_validate_tx);
> +       init_iface(ifobj_rx, worker_testapp_validate_rx);
> +       init_iface(ifobj_tx, worker_testapp_validate_tx);
>
>         test_spec_init(&test, ifobj_tx, ifobj_rx, 0, &tests[0]);
>         tx_pkt_stream_default = pkt_stream_generate(ifobj_tx->umem, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
> diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> index 06b82b39c59c..e003f9ca4692 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.h
> +++ b/tools/testing/selftests/bpf/xskxceiver.h
> @@ -59,6 +59,7 @@
>  #define HUGEPAGE_SIZE (2 * 1024 * 1024)
>  #define PKT_DUMP_NB_TO_PRINT 16
>  #define RUN_ALL_TESTS UINT_MAX
> +#define NUM_MAC_ADDRESSES 4
>
>  #define print_verbose(x...) do { if (opt_verbose) ksft_print_msg(x); } while (0)
>
> @@ -90,6 +91,8 @@ struct xsk_socket_info {
>         struct pkt_stream *pkt_stream;
>         u32 outstanding_tx;
>         u32 rxqsize;
> +       u8 dst_mac[ETH_ALEN];
> +       u8 src_mac[ETH_ALEN];
>  };
>
>  struct pkt {
> @@ -140,8 +143,6 @@ struct ifobject {
>         bool unaligned_supp;
>         bool multi_buff_supp;
>         bool multi_buff_zc_supp;
> -       u8 dst_mac[ETH_ALEN];
> -       u8 src_mac[ETH_ALEN];
>  };
>
>  struct test_spec {
> @@ -168,4 +169,7 @@ pthread_mutex_t pacing_mutex = PTHREAD_MUTEX_INITIALIZER;
>
>  int pkts_in_flight;
>
> +static const u8 g_mac[] = {0x55, 0x44, 0x33, 0x22, 0x11, 0x00};
> +static u8 macs[NUM_MAC_ADDRESSES][ETH_ALEN] = {0};

I do not think you need this last array. You already have added
dst_mac and src_mac in the xsk_socket_info that you can use, so no
need for this.

> +
>  #endif                         /* XSKXCEIVER_H_ */
> --
> 2.34.1
>
>


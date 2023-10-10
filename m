Return-Path: <bpf+bounces-11814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DCA7C011B
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 18:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF4A1C20D22
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 16:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185492747C;
	Tue, 10 Oct 2023 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ACR0fxxe"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4952744B
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 16:05:11 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCA819A7
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 09:04:50 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-58c3a049bb7so1714848a12.3
        for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696953889; x=1697558689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2uOLNrftYUCXs6jDTX3A0LMS5b85nq2eL6h5s8Yk9gA=;
        b=ACR0fxxeDJ1DsOgnjemH31l7mzGgyYPlCtbKPBHXZ94cyOG+cj53P3tNPJc4/V+yIc
         6c2G+bC+Tb/T8HLi01dLceiC8kdoXzlLhTNJODYr3whYf2msPj3T8GnKK7t2NDO21VrT
         mjMGzGcsKZq/BaNcH7hjUBGbKo1jI71OOK3NBuso+XbwxYhja5cgxRPJBuX8HWVxuC+z
         U0GyX2XImHN2/UqW3NW/hdDpsx0HW+yGYGUau9Vm2342qVXgznYCG4hlzklw7/+UTdLp
         2eEbLZpuIaihds5YJkSR5KgFZv7BNwNQw942pPXt6/DtRkGtiEc+ftFSVkDFU+ZGhnXh
         KkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696953889; x=1697558689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2uOLNrftYUCXs6jDTX3A0LMS5b85nq2eL6h5s8Yk9gA=;
        b=DEP3iF0OgheWUok2rATFgLyiWUjjW4zMN5QdXecnp2JXpVa1uPQMXhI3ACFOEPrVOv
         Ne21U+R4Rw13IYMLppMGR3F5n7ykOywTeQ6ncY/WdoSvZYND1OG1dWnFuslTtarFaKIx
         WaI+BnkWfnLrNxVA6gCUwHsd8NaGr9D2hwJiGV6mS3Mw4fn0M5qx+eaVXWprq4pTeswL
         q2oxtSWa89auve/PgFebqDhK1WUEz0nxukYd7vRqMqtEr+xCkz9sAmdKyCQaJQcFmSua
         KUk0E7CqKVhlh0hF/d7OpZfACY4/qC2C8tZH9ryB1o99xS7uGAzdq/dUYyVMOuTuem9o
         RfJg==
X-Gm-Message-State: AOJu0YxiHQeFCliw10jAIVRm5rG7foVlQeb/Cuk3aeKPh6ACoYmPAWFO
	TcjyLZehSc2YUttbCXUEpH8tJ+k1yc8nTgfvZG4nm3dRD1wiw9O8sp2pWynRTpQmjQGqZ/+bgHO
	Id93B
X-Google-Smtp-Source: AGHT+IFJitCyVlJKj66I2VbkxR001T+0blrYFon2XBjC0yxEOcmHyys35tQDlE+b2jmi4A2TysJoyWk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:734f:0:b0:59d:852d:148a with SMTP id
 d15-20020a63734f000000b0059d852d148amr25199pgn.1.1696953889298; Tue, 10 Oct
 2023 09:04:49 -0700 (PDT)
Date: Tue, 10 Oct 2023 09:04:47 -0700
In-Reply-To: <ZST8OTwh+6y1S170@lzaremba-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009160520.20831-1-larysa.zaremba@intel.com>
 <ZSQvMr3-lY9uTzn_@google.com> <ZST8OTwh+6y1S170@lzaremba-mobl.ger.corp.intel.com>
Message-ID: <ZSV2HwOhuNr3XLbv@google.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10, Larysa Zaremba wrote:
> On Mon, Oct 09, 2023 at 09:49:54AM -0700, Stanislav Fomichev wrote:
> > On 10/09, Larysa Zaremba wrote:
> > > This is a follow-up to the commit 9b2b86332a9b ("bpf: Allow to use kfunc
> > > XDP hints and frags together").
> > > 
> > > The are some possible implementations problems that may arise when
> > > providing metadata specifically for multi-buffer packets, therefore there
> > > must be a possibility to test such option separately.
> > > 
> > > Add an option to use multi-buffer AF_XDP xdp_hw_metadata and mark used XDP
> > > program as capable to use frags.
> > > 
> > > As for now, xdp_hw_metadata accepts no options, so add simple option
> > > parsing logic and a help message.
> > > 
> > > For quick reference, also add an ingress packet generation command to the
> > > help message. The command comes from [0].
> > > 
> > > Example of output for multi-buffer packet:
> > > 
> > > xsk_ring_cons__peek: 1
> > > 0xead018: rx_desc[15]->addr=10000000000f000 addr=f100 comp_addr=f000
> > > rx_hash: 0x5789FCBB with RSS type:0x29
> > > rx_timestamp:  1696856851535324697 (sec:1696856851.5353)
> > > XDP RX-time:   1696856843158256391 (sec:1696856843.1583)
> > > 	delta sec:-8.3771 (-8377068.306 usec)
> > > AF_XDP time:   1696856843158413078 (sec:1696856843.1584)
> > > 	delta sec:0.0002 (156.687 usec)
> > > 0xead018: complete idx=23 addr=f000
> > > xsk_ring_cons__peek: 1
> > > 0xead018: rx_desc[16]->addr=100000000008000 addr=8100 comp_addr=8000
> > > 0xead018: complete idx=24 addr=8000
> > > xsk_ring_cons__peek: 1
> > > 0xead018: rx_desc[17]->addr=100000000009000 addr=9100 comp_addr=9000 EoP
> > > 0xead018: complete idx=25 addr=9000
> > > 
> > > Metadata is printed for the first packet only.
> > > 
> > > [0] https://lore.kernel.org/all/20230119221536.3349901-18-sdf@google.com/
> > > 
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  .../selftests/bpf/progs/xdp_hw_metadata.c     |  2 +-
> > >  tools/testing/selftests/bpf/xdp_hw_metadata.c | 92 ++++++++++++++++---
> > >  2 files changed, 79 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > > index 63d7de6c6bbb..8767d919c881 100644
> > > --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > > +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > > @@ -21,7 +21,7 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
> > >  extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
> > >  				    enum xdp_rss_hash_type *rss_type) __ksym;
> > >  
> > > -SEC("xdp")
> > > +SEC("xdp.frags")
> > >  int rx(struct xdp_md *ctx)
> > >  {
> > >  	void *data, *data_meta, *data_end;
> > > diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > > index 17c980138796..25225720346b 100644
> > > --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > > +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > > @@ -26,6 +26,7 @@
> > >  #include <linux/sockios.h>
> > >  #include <sys/mman.h>
> > >  #include <net/if.h>
> > > +#include <ctype.h>
> > >  #include <poll.h>
> > >  #include <time.h>
> > >  
> > > @@ -49,19 +50,29 @@ struct xsk {
> > >  struct xdp_hw_metadata *bpf_obj;
> > >  struct xsk *rx_xsk;
> > >  const char *ifname;
> > > +bool use_frags;
> > >  int ifindex;
> > >  int rxq;
> > >  
> > >  void test__fail(void) { /* for network_helpers.c */ }
> > >  
> > > -static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
> > > +static struct xsk_socket_config gen_socket_config(void)
> > >  {
> > > -	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
> > > -	const struct xsk_socket_config socket_config = {
> > > +	struct xsk_socket_config socket_config = {
> > >  		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > >  		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > >  		.bind_flags = XDP_COPY,
> > >  	};
> > > +
> > > +	if (use_frags)
> > > +		socket_config.bind_flags |= XDP_USE_SG;
> > > +	return socket_config;
> > > +}
> > 
> > nit: why not drop const from socket_config and add this 'if (use_frags)'
> > directly to open_xsk? Not sure separate function really buys us anything?
> >
> 
> Considering there will also be ZC/copy option, I thought it would be good to 
> separate socket config creation. After giving this a sencond thought though, 
> for now options would control bind_flags only. What do you this about removing 
> gen_socket_config(), but introducing get_bind_flags()?

In my pending series [0] I ended up adding bind_flags argument
to open_xsk. Maybe do the same here? This also lets you drop
global use_frags (if you move option parsing directly into main).

Or maybe add global bind_flags if you want to keep separate parsing
routine (read_args)? Doesn't seem like we get anything by storing
separate use_flags/use_copy and then construct bind_flags via extra
get_bind_flags()?
 
0: https://lore.kernel.org/bpf/20231003200522.1914523-10-sdf@google.com/


Return-Path: <bpf+bounces-5874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B918762409
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 22:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADD82819DA
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 20:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF5426B6E;
	Tue, 25 Jul 2023 20:59:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF2A1F188;
	Tue, 25 Jul 2023 20:59:17 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F77599;
	Tue, 25 Jul 2023 13:59:16 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7653bd3ff2fso616855985a.3;
        Tue, 25 Jul 2023 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690318755; x=1690923555;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQT4CWtf4mJ5fxuXEahsMEsrtApDWNKjhlbuKuN2pcI=;
        b=XhUI8s5ouoFGkany53TNKsgiLvRcHy4FtD3K/zDNI8H6mkRFx3wMlE9fMvKXAZOuc5
         zLBqk8gPXt24QfKVeuK5Dg77aBbJTweywoz3SW84vmNOoC7FLiK3PS+un2CC4IeGG8F4
         DouGHxMA1M+05ifHzhO8YN13X3eZGKM/woA1mVpN58tiDVZOy1UYNtLmiPHtPLFxxbq3
         yIds2VjzPYyFLnAjqDa9jyYPicMl6aekdSk9Y64mfjfhPUs6lYAqySMlO03TI0odwaJW
         usSoGrm0zi734f27cLy7pweMdOYbU6AZoXwAJZa6ZG3LePWZr/R1hk8cnuw512gQliTz
         PYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690318755; x=1690923555;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zQT4CWtf4mJ5fxuXEahsMEsrtApDWNKjhlbuKuN2pcI=;
        b=N8AVeCuCBIdwx+DR/pgLS1jPUFxk3dnHTgeDFnSjK1H/8FrNip/XaWLoUABhbEModP
         X/Xu7DOX7/UWq7ukad3jMdpX9pN6GrDVQuelwhenacybc0JKdmO6mNGNLtiq4ZZo+toZ
         sQcdAHLETDS7F8e11v9IPu8Jg1jBUV714Dtt8gFYvpS/3/GoRuDAQBOxNjW7scceL7/v
         qFAFLQ2RwxNDSr0cPJ/wVvu6BeeyNtwljuPVPJa7K+HB9RhnXtb79/pU8RMrsRTt3HhW
         wPi8gpiSe6/4SnD0B9kYtmrdV7YfOTgPfBjwVsvb0+UTPQltMMqTK6HwkO3xqFOr8MFp
         SCrg==
X-Gm-Message-State: ABy/qLYIpL7e3OsZGaZ/1x467uZgS4QDyfCmLT1RFaNRRKFhoF2DVNjf
	+A3AONZiXJsKGUy0Yxt257c=
X-Google-Smtp-Source: APBJJlEjKu1cbNJyzjxBvmhqKT/0B7iVOucrA0PspBWTREMkkSmaoA7a6/C5w7qDocAHGdzp5uJoDA==
X-Received: by 2002:a05:620a:2a01:b0:76c:4d4c:7942 with SMTP id o1-20020a05620a2a0100b0076c4d4c7942mr129512qkp.21.1690318755303;
        Tue, 25 Jul 2023 13:59:15 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id g26-20020a37e21a000000b00767e62bcf0csm3914389qki.65.2023.07.25.13.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:59:15 -0700 (PDT)
Date: Tue, 25 Jul 2023 16:59:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <sdf@google.com>, 
 bpf@vger.kernel.org
Cc: ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yhs@fb.com, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@google.com, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 kuba@kernel.org, 
 toke@kernel.org, 
 willemb@google.com, 
 dsahern@kernel.org, 
 magnus.karlsson@intel.com, 
 bjorn@kernel.org, 
 maciej.fijalkowski@intel.com, 
 hawk@kernel.org, 
 netdev@vger.kernel.org, 
 xdp-hints@xdp-project.net
Message-ID: <64c037a2cab54_3fe1bc29433@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230724235957.1953861-9-sdf@google.com>
References: <20230724235957.1953861-1-sdf@google.com>
 <20230724235957.1953861-9-sdf@google.com>
Subject: RE: [RFC net-next v4 8/8] selftests/bpf: Add TX side to
 xdp_hw_metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Stanislav Fomichev wrote:
> When we get packets on port 9091, we swap src/dst and send it out.
> At this point, we also request the timestamp and plumb it back
> to the userspace. The userspace simply prints the timestamp.
> 
> Also print current UDP checksum, rewrite it with the pseudo-header
> checksum and offload TX checksum calculation to devtx. Upon
> completion, report TX checksum back (mlx5 doesn't put it back, so
> I've used tcpdump to confirm that the checksum is correct).
> 
> Some other related changes:
> - switched to zerocopy mode by default; new flag can be used to force
>   old behavior
> - request fixed TX_METADATA_LEN headroom
> - some other small fixes (umem size, fill idx+i, etc)
> 
> mvbz3:~# ./xdp_hw_metadata eth3 -c mlx5e_devtx_complete_xdp -s mlx5e_devtx_submit_xd
> attach rx bpf program...
> ...
> 0x206d298: rx_desc[0]->addr=80100 addr=80100 comp_addr=80100
> rx_hash: 0x2BFB7FEC with RSS type:0x2A
> rx_timestamp:  1690238278345877848 (sec:1690238278.3459)
> XDP RX-time:   1690238278538397674 (sec:1690238278.5384) delta sec:0.1925 (192519.826 usec)
> AF_XDP time:   1690238278538515250 (sec:1690238278.5385) delta sec:0.0001 (117.576 usec)
> 0x206d298: ping-pong with csum=8e3b (want 57c9) csum_start=54 csum_offset=6
> 0x206d298: complete tx idx=0 addr=10
> 0x206d298: tx_timestamp:  1690238278577008140 (sec:1690238278.5770)
> 0x206d298: complete rx idx=128 addr=80100
> 
> mvbz4:~# nc  -Nu -q1 ${MVBZ3_LINK_LOCAL_IP}%eth3 9091
> 
> mvbz4:~# tcpdump -vvx -i eth3 udp
> tcpdump: listening on eth3, link-type EN10MB (Ethernet), snapshot length 262144 bytes
> 10:12:43.901436 IP6 (flowlabel 0x7a5d2, hlim 127, next-header UDP (17) payload length: 11) fe80::1270:fdff:fe48:1087.44339 > fe80::1270:fdff:fe48:1077.9091: [bad udp cksum 0x3b8e -> 0x0b4b!] UDP, length 3
>         0x0000:  6007 a5d2 000b 117f fe80 0000 0000 0000
>         0x0010:  1270 fdff fe48 1087 fe80 0000 0000 0000
>         0x0020:  1270 fdff fe48 1077 ad33 2383 000b 3b8e
>         0x0030:  7864 70
> 10:12:43.902125 IP6 (flowlabel 0x7a5d2, hlim 127, next-header UDP (17) payload length: 11) fe80::1270:fdff:fe48:1077.9091 > fe80::1270:fdff:fe48:1087.44339: [udp sum ok] UDP, length 3
>         0x0000:  6007 a5d2 000b 117f fe80 0000 0000 0000
>         0x0010:  1270 fdff fe48 1077 fe80 0000 0000 0000
>         0x0020:  1270 fdff fe48 1087 2383 ad33 000b 0b4b
>         0x0030:  7864 70
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  tools/testing/selftests/bpf/xdp_hw_metadata.c | 201 +++++++++++++++++-
>  1 file changed, 191 insertions(+), 10 deletions(-)
> 

> +static void usage(const char *prog)
> +{
> +	fprintf(stderr,
> +		"usage: %s [OPTS] <ifname>\n"
> +		"OPTS:\n"
> +		"    -T    don't generate AF_XDP reply (rx metadata only)\n"
> +		"    -Z    run in copy mode\n",

nit: makes more sense to call copy mode 'C', rather than 'Z'


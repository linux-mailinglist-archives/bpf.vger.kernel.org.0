Return-Path: <bpf+bounces-5886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3C7762717
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 00:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20AE1C20FA3
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 22:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378E026B9F;
	Tue, 25 Jul 2023 22:56:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B88462;
	Tue, 25 Jul 2023 22:56:27 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AAA19AD;
	Tue, 25 Jul 2023 15:55:57 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63cfa3e564eso16801286d6.0;
        Tue, 25 Jul 2023 15:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690325718; x=1690930518;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kbj5lxfkvWMdsjF9kVA8NWZM6/EjrqCXvMX8wEWcrMw=;
        b=Wze65UH6RBtVLAD27deRt24gt7k1G9A08vAdMMEmNVUSDfCoWsm/6q881oZkb85q9j
         rnQtSgizCB6t/MpBjawMb0gx6o7xGxdiwxUzNbn7Qq9HhR9fb2lW8/Cn65QvOyYR19Fw
         gPckqCLv5yBh1FH5l25MHseoiL6TOWiSE8Hs5dM34Yh5tvpAB/VumQxfHFFBGYJrAhZp
         g+SCDHBmv4SHUR+z6VRaoXZAiT9mXKwS5OJiqeNIzzwgcS+c2FCC6gE1nt5u8W9Dj10A
         8ddNpSE5xHrFB8ds2VCy5hVcqwfw/YZUOBln8clETeWG/EMPTWAJPPD0k8bvLKq8M0BN
         Wq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690325718; x=1690930518;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kbj5lxfkvWMdsjF9kVA8NWZM6/EjrqCXvMX8wEWcrMw=;
        b=YGQItbDz1hF+GufCOht5O0ryRqaX2yPtKrecP6qaHM63OoC3zjqTcclNymWrvzInQA
         ovNyeEF0WRfaCNnCcMzP++YhcRo0p9Xb8uLg6yJu8vPA3qCNzICZgOXYMhveK14LPQ1Y
         IWcNNttHDPtXhSFx6t6ea8tfdQy8vXCzpMhLLE+LTeS0KhhOz04m+wYJPdGkUTwZ785x
         M1HBbIvc8nIuQABmt6fbfm7woZH7wRt5ymtwwOpYFrvcGeOF71JgeNVHcRHY71bgz4Fv
         iS5IQ5RP7kuSnK7wmhTCMwkanZvFIarrNs02UYZhMd3v40TQlBytVpengrhnelQ+5KLS
         pr2w==
X-Gm-Message-State: ABy/qLbWl8m3ERiFxc0VhTp/q/st/OlQQq948gMSTQkXfK519M/MjGG6
	QgIU0NWxXQtbVZNPfOmOeE0=
X-Google-Smtp-Source: APBJJlGYhX+pr+M6uWblnAhyB0i2hb5yjsdPBZmsYG2RBV550Si6WR0uiRJ9lmXgZB3J9bou+w12qQ==
X-Received: by 2002:a0c:e08a:0:b0:63d:8fe:784d with SMTP id l10-20020a0ce08a000000b0063d08fe784dmr418457qvk.6.1690325718278;
        Tue, 25 Jul 2023 15:55:18 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id b25-20020a05620a119900b00765ab6d3e81sm3967045qkk.122.2023.07.25.15.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:55:17 -0700 (PDT)
Date: Tue, 25 Jul 2023 18:55:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <sdf@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yhs@fb.com, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
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
Message-ID: <64c052d5b3baa_3a4d294cb@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZMBOflNd3TOV7sd4@google.com>
References: <20230724235957.1953861-1-sdf@google.com>
 <20230724235957.1953861-9-sdf@google.com>
 <64c037a2cab54_3fe1bc29433@willemb.c.googlers.com.notmuch>
 <ZMBOflNd3TOV7sd4@google.com>
Subject: Re: [RFC net-next v4 8/8] selftests/bpf: Add TX side to
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
> On 07/25, Willem de Bruijn wrote:
> > Stanislav Fomichev wrote:
> > > When we get packets on port 9091, we swap src/dst and send it out.
> > > At this point, we also request the timestamp and plumb it back
> > > to the userspace. The userspace simply prints the timestamp.
> > > 
> > > Also print current UDP checksum, rewrite it with the pseudo-header
> > > checksum and offload TX checksum calculation to devtx. Upon
> > > completion, report TX checksum back (mlx5 doesn't put it back, so
> > > I've used tcpdump to confirm that the checksum is correct).
> > > 
> > > Some other related changes:
> > > - switched to zerocopy mode by default; new flag can be used to force
> > >   old behavior
> > > - request fixed TX_METADATA_LEN headroom
> > > - some other small fixes (umem size, fill idx+i, etc)
> > > 
> > > mvbz3:~# ./xdp_hw_metadata eth3 -c mlx5e_devtx_complete_xdp -s mlx5e_devtx_submit_xd
> > > attach rx bpf program...
> > > ...
> > > 0x206d298: rx_desc[0]->addr=80100 addr=80100 comp_addr=80100
> > > rx_hash: 0x2BFB7FEC with RSS type:0x2A
> > > rx_timestamp:  1690238278345877848 (sec:1690238278.3459)
> > > XDP RX-time:   1690238278538397674 (sec:1690238278.5384) delta sec:0.1925 (192519.826 usec)
> > > AF_XDP time:   1690238278538515250 (sec:1690238278.5385) delta sec:0.0001 (117.576 usec)
> > > 0x206d298: ping-pong with csum=8e3b (want 57c9) csum_start=54 csum_offset=6
> > > 0x206d298: complete tx idx=0 addr=10
> > > 0x206d298: tx_timestamp:  1690238278577008140 (sec:1690238278.5770)
> > > 0x206d298: complete rx idx=128 addr=80100
> > > 
> > > mvbz4:~# nc  -Nu -q1 ${MVBZ3_LINK_LOCAL_IP}%eth3 9091
> > > 
> > > mvbz4:~# tcpdump -vvx -i eth3 udp
> > > tcpdump: listening on eth3, link-type EN10MB (Ethernet), snapshot length 262144 bytes
> > > 10:12:43.901436 IP6 (flowlabel 0x7a5d2, hlim 127, next-header UDP (17) payload length: 11) fe80::1270:fdff:fe48:1087.44339 > fe80::1270:fdff:fe48:1077.9091: [bad udp cksum 0x3b8e -> 0x0b4b!] UDP, length 3
> > >         0x0000:  6007 a5d2 000b 117f fe80 0000 0000 0000
> > >         0x0010:  1270 fdff fe48 1087 fe80 0000 0000 0000
> > >         0x0020:  1270 fdff fe48 1077 ad33 2383 000b 3b8e
> > >         0x0030:  7864 70
> > > 10:12:43.902125 IP6 (flowlabel 0x7a5d2, hlim 127, next-header UDP (17) payload length: 11) fe80::1270:fdff:fe48:1077.9091 > fe80::1270:fdff:fe48:1087.44339: [udp sum ok] UDP, length 3
> > >         0x0000:  6007 a5d2 000b 117f fe80 0000 0000 0000
> > >         0x0010:  1270 fdff fe48 1077 fe80 0000 0000 0000
> > >         0x0020:  1270 fdff fe48 1087 2383 ad33 000b 0b4b
> > >         0x0030:  7864 70
> > > 
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > >  tools/testing/selftests/bpf/xdp_hw_metadata.c | 201 +++++++++++++++++-
> > >  1 file changed, 191 insertions(+), 10 deletions(-)
> > > 
> > 
> > > +static void usage(const char *prog)
> > > +{
> > > +	fprintf(stderr,
> > > +		"usage: %s [OPTS] <ifname>\n"
> > > +		"OPTS:\n"
> > > +		"    -T    don't generate AF_XDP reply (rx metadata only)\n"
> > > +		"    -Z    run in copy mode\n",
> > 
> > nit: makes more sense to call copy mode 'C', rather than 'Z'
> 
> Initially I had -c and -s for completion/submission bpf hooks. Now that
> these are gone, can actually use -c. Capital letter here actually means
> 'not'. Z - not zerocopy. T - no tx.
> 
> I'll rename to:
> -r - rx only
> -c - copy mode
> 
> LMK if it doesn't make sense..

Sounds great, thanks. I did not grasp the capitalization implies negation.


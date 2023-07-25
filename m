Return-Path: <bpf+bounces-5883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C01C7626F2
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 00:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524B31C21048
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 22:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAD82416F;
	Tue, 25 Jul 2023 22:38:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E0D8462
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 22:38:20 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C563A8F
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 15:37:58 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-563bcd2cb78so1675839a12.3
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690324608; x=1690929408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mMfI3arKf9+YbxM5YZ3Ev/94eLBo3EGM5wKxDcmFtGU=;
        b=CA5p7AoCQp/A+5LexlFHmH6M1E/EdsT2gZ07zUtXmpkqX/JmkTUEgmODI8gV73H8bg
         qAiOZSuFLD8GZNhC2qL1340KL6dUfoKUvZPjT9so7h32p9aZeSQvjNE4KEKzoXAbppDe
         yeIh5xNJiwnJrevV0n8pbyoXwO9UhHW9cuCiHlN5Go+/wm1CKzU9+9zcuVMMHAjyHzi/
         w7n/gKemORarXKEC6j/Hi1wh8mXgTU0kSiFVd2G1oCaCOmdvx5itLN6JJhdHGPdqFEIr
         Zsr7B2DGlvdac+gYGzXITizsm0iHj4GfUp7InvdKh2T+bd7d9e4sMl+NOhPhRykoCMTO
         isww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690324608; x=1690929408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMfI3arKf9+YbxM5YZ3Ev/94eLBo3EGM5wKxDcmFtGU=;
        b=eqkvPSeCCB0/KOV936H7mHMJ8mRmr6yqlgKhm5JhZEEDy2kignHkh2P2QPZ1rY3kqz
         1mtFhVbEsbIkeJzY5AJh9uZEtZF1rfQwtzjnTh44ywLLUpmrSeObbJlmeQc5iUC2KzsE
         IgJy+jj3a30FMw9K/MCsYGBEc6TcqV8OIpS5z5gNnH/pI0MlzDkh+kPDrXWYXBzsPnk2
         dJVFFnGix1OWp9HvVeuPtctWvSzq6Hp41W3glfmhXd38fqq7HwTVW34RVAap/YjwNH/N
         qvrb78CgmaQlp3hXHWeX4+NQ2gtcmPmQPDNyFHQyVEIUimxX7wbb4ZgHKlCZgG2MEGQ5
         FSYw==
X-Gm-Message-State: ABy/qLb2sgoTdyKpo5olwWzejqzetDZsvq2poUyTMkZBBuVFwbjqWJ/K
	i+4ff1mn7vhIEnETOBXl8wXthT8=
X-Google-Smtp-Source: APBJJlEZNki/cKWgg0Mhfcy8+MorsUExicYY85Pi8mD/yQP4agFWfIhcHNdF4aGg7gtbmcwO/5lRFVc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:7d5c:0:b0:534:6903:efd8 with SMTP id
 m28-20020a637d5c000000b005346903efd8mr3150pgn.1.1690324608178; Tue, 25 Jul
 2023 15:36:48 -0700 (PDT)
Date: Tue, 25 Jul 2023 15:36:46 -0700
In-Reply-To: <64c037a2cab54_3fe1bc29433@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724235957.1953861-1-sdf@google.com> <20230724235957.1953861-9-sdf@google.com>
 <64c037a2cab54_3fe1bc29433@willemb.c.googlers.com.notmuch>
Message-ID: <ZMBOflNd3TOV7sd4@google.com>
Subject: Re: [RFC net-next v4 8/8] selftests/bpf: Add TX side to xdp_hw_metadata
From: Stanislav Fomichev <sdf@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, hawk@kernel.org, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/25, Willem de Bruijn wrote:
> Stanislav Fomichev wrote:
> > When we get packets on port 9091, we swap src/dst and send it out.
> > At this point, we also request the timestamp and plumb it back
> > to the userspace. The userspace simply prints the timestamp.
> > 
> > Also print current UDP checksum, rewrite it with the pseudo-header
> > checksum and offload TX checksum calculation to devtx. Upon
> > completion, report TX checksum back (mlx5 doesn't put it back, so
> > I've used tcpdump to confirm that the checksum is correct).
> > 
> > Some other related changes:
> > - switched to zerocopy mode by default; new flag can be used to force
> >   old behavior
> > - request fixed TX_METADATA_LEN headroom
> > - some other small fixes (umem size, fill idx+i, etc)
> > 
> > mvbz3:~# ./xdp_hw_metadata eth3 -c mlx5e_devtx_complete_xdp -s mlx5e_devtx_submit_xd
> > attach rx bpf program...
> > ...
> > 0x206d298: rx_desc[0]->addr=80100 addr=80100 comp_addr=80100
> > rx_hash: 0x2BFB7FEC with RSS type:0x2A
> > rx_timestamp:  1690238278345877848 (sec:1690238278.3459)
> > XDP RX-time:   1690238278538397674 (sec:1690238278.5384) delta sec:0.1925 (192519.826 usec)
> > AF_XDP time:   1690238278538515250 (sec:1690238278.5385) delta sec:0.0001 (117.576 usec)
> > 0x206d298: ping-pong with csum=8e3b (want 57c9) csum_start=54 csum_offset=6
> > 0x206d298: complete tx idx=0 addr=10
> > 0x206d298: tx_timestamp:  1690238278577008140 (sec:1690238278.5770)
> > 0x206d298: complete rx idx=128 addr=80100
> > 
> > mvbz4:~# nc  -Nu -q1 ${MVBZ3_LINK_LOCAL_IP}%eth3 9091
> > 
> > mvbz4:~# tcpdump -vvx -i eth3 udp
> > tcpdump: listening on eth3, link-type EN10MB (Ethernet), snapshot length 262144 bytes
> > 10:12:43.901436 IP6 (flowlabel 0x7a5d2, hlim 127, next-header UDP (17) payload length: 11) fe80::1270:fdff:fe48:1087.44339 > fe80::1270:fdff:fe48:1077.9091: [bad udp cksum 0x3b8e -> 0x0b4b!] UDP, length 3
> >         0x0000:  6007 a5d2 000b 117f fe80 0000 0000 0000
> >         0x0010:  1270 fdff fe48 1087 fe80 0000 0000 0000
> >         0x0020:  1270 fdff fe48 1077 ad33 2383 000b 3b8e
> >         0x0030:  7864 70
> > 10:12:43.902125 IP6 (flowlabel 0x7a5d2, hlim 127, next-header UDP (17) payload length: 11) fe80::1270:fdff:fe48:1077.9091 > fe80::1270:fdff:fe48:1087.44339: [udp sum ok] UDP, length 3
> >         0x0000:  6007 a5d2 000b 117f fe80 0000 0000 0000
> >         0x0010:  1270 fdff fe48 1077 fe80 0000 0000 0000
> >         0x0020:  1270 fdff fe48 1087 2383 ad33 000b 0b4b
> >         0x0030:  7864 70
> > 
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  tools/testing/selftests/bpf/xdp_hw_metadata.c | 201 +++++++++++++++++-
> >  1 file changed, 191 insertions(+), 10 deletions(-)
> > 
> 
> > +static void usage(const char *prog)
> > +{
> > +	fprintf(stderr,
> > +		"usage: %s [OPTS] <ifname>\n"
> > +		"OPTS:\n"
> > +		"    -T    don't generate AF_XDP reply (rx metadata only)\n"
> > +		"    -Z    run in copy mode\n",
> 
> nit: makes more sense to call copy mode 'C', rather than 'Z'

Initially I had -c and -s for completion/submission bpf hooks. Now that
these are gone, can actually use -c. Capital letter here actually means
'not'. Z - not zerocopy. T - no tx.

I'll rename to:
-r - rx only
-c - copy mode

LMK if it doesn't make sense..


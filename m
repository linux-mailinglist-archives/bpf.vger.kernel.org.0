Return-Path: <bpf+bounces-13145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1768B7D58EC
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 18:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B404B20C74
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 16:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21A63A296;
	Tue, 24 Oct 2023 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8vZpnYh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C064C3B2AD
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 16:41:52 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE2CDA
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 09:41:49 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5ac865d1358so2953632a12.3
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 09:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698165709; x=1698770509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9cI2QYCQEc0Q/Z2mJbULzav03v+BRSAlGepCbIXf4g=;
        b=k8vZpnYhUGkLINDaRw74tvPFE8FRGFFzm6dO1ITeTaTHgE5Qjw1l4T+KeiGvQPrVMQ
         Lp2xFGAJR/xzMfJ/G2EnMle6UXY/mwUxiq8RVPbxBgiqDtrKpF2nkbalKXBxcQ/FUBuz
         VTDXVhTdzEYiC+aAYZ4FC+CdPJJweEARSdZZSPgNjxUtFb8qTMsO2XRArKMMdn/45LPQ
         NS+c8hiK79mIjpaqBbRb3lXMWd1c5toX2rozbDQCkdVQv04/uW7NJynD7Ysrz3vgUg7W
         2J3EvBAlAOe6knt8vhzk9OqQ6XeSUz8FpQNbcaTtQMC5mwAbFjQEk68LBJWdUF9TEQ4z
         XHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698165709; x=1698770509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9cI2QYCQEc0Q/Z2mJbULzav03v+BRSAlGepCbIXf4g=;
        b=Wl5ENG6jdG52Arj0jGHtDVZQ7B76o++swfli+u2tCTfENHKfm271hAkRBvDQpMKQhL
         F4bjIrXcl6rtNMgzA7zwBGJ/ihJ7EtItsifX0DF90Yq59NXtJH+hwWN2HVsCrUiQNPvi
         0e6MNpWfvLhXd8BW8O/5QKF0+V9nfMbIO+ERA5GDGjUJo1qPIbFjqZQIZkzZQHBNeH9M
         V06sCgx64Ky2NmAqTePuRq6BepBaOxTOPpafttAfNZc5qdm5nvioMil+T+r/1Jjpp/59
         zUu+AIjkSMKMolD20TR2UTSn/YsTCUs+hrKQD6qMTGlbeS2imxx8Qoez9B5HNhiwn3fs
         YgVA==
X-Gm-Message-State: AOJu0YypeFxrvsb/JFpSgDgMFSRtK/1SuHx0+FUO0ALOQ0PBQniZhb+K
	ddgt22Z9G2+mksafaxe4mpu+HeJwB0jbIE+22KnVfA==
X-Google-Smtp-Source: AGHT+IGAdVWT4mftFEAGQrXm3G8HV7gIjum7jCbwbb9KaUknUgk1WfDEZHCMV8V8bp+yGQa2u32B3NoAvqDI+8P/hfU=
X-Received: by 2002:a17:90a:4f45:b0:27e:3880:d03d with SMTP id
 w5-20020a17090a4f4500b0027e3880d03dmr6113296pjl.7.1698165708830; Tue, 24 Oct
 2023 09:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com> <20231019174944.3376335-11-sdf@google.com>
 <PH0PR11MB5830DF14E012DCAC75090010D8DFA@PH0PR11MB5830.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5830DF14E012DCAC75090010D8DFA@PH0PR11MB5830.namprd11.prod.outlook.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Tue, 24 Oct 2023 09:41:36 -0700
Message-ID: <CAKH8qBtqbRRER-qbT3YghgYkaHVzz=Rdvpe9h7b5bv3+gM-a5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 10/11] selftests/bpf: Add TX side to xdp_hw_metadata
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, "toke@kernel.org" <toke@kernel.org>, 
	"willemb@google.com" <willemb@google.com>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, "bjorn@kernel.org" <bjorn@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "hawk@kernel.org" <hawk@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 7:19=E2=80=AFPM Song, Yoong Siang
<yoong.siang.song@intel.com> wrote:
>
> On Friday, October 20, 2023 1:50 AM Stanislav Fomichev <sdf@google.com> w=
rote:
> >When we get a packet on port 9091, we swap src/dst and send it out.
> >At this point we also request the timestamp and checksum offloads.
> >
> >Checksum offload is verified by looking at the tcpdump on the other side=
.
> >The tool prints pseudo-header csum and the final one it expects.
> >The final checksum actually matches the incoming packets checksum
> >because we only flip the src/dst and don't change the payload.
> >
> >Some other related changes:
> >- switched to zerocopy mode by default; new flag can be used to force
> >  old behavior
> >- request fixed tx_metadata_len headroom
> >- some other small fixes (umem size, fill idx+i, etc)
> >
> >mvbz3:~# ./xdp_hw_metadata eth3
> >...
> >xsk_ring_cons__peek: 1
> >0x19546f8: rx_desc[0]->addr=3D80100 addr=3D80100 comp_addr=3D80100
> >rx_hash: 0x80B7EA8B with RSS type:0x2A
> >rx_timestamp:  1697580171852147395 (sec:1697580171.8521)
> >HW RX-time:   1697580171852147395 (sec:1697580171.8521), delta to User R=
X-time sec:0.2797 (279673.082 usec)
> >XDP RX-time:   1697580172131699047 (sec:1697580172.1317), delta to User =
RX-time sec:0.0001 (121.430 usec)
> >0x19546f8: ping-pong with csum=3D3b8e (want d862) csum_start=3D54 csum_o=
ffset=3D6
> >0x19546f8: complete tx idx=3D0 addr=3D8
> >tx_timestamp:  1697580172056756493 (sec:1697580172.0568)
>
> Hi Stanislav,
>
> rx_timestamp is duplicating HW RX-time while tx_timestamp is duplicating =
HW TX-complete-time,
> so, I think can remove printing of rx_timestamp and tx_timestamp to avoid=
 confusion.

That's fair, I think I'll do the following:

if (meta->rx_timestamp) {
  /* print all those reference points */
} else {
  printf("No rx_timestamp\n");
}

And the same for tx. So at least the users get a signal that the
timestamps weren't set.

> >HW TX-complete-time:   1697580172056756493 (sec:1697580172.0568), delta =
to User TX-complete-time sec:0.0852 (85175.537 usec)
> >XDP RX-time:   1697580172131699047 (sec:1697580172.1317), delta to User =
TX-complete-time sec:0.0102 (10232.983 usec)
> >HW RX-time:   1697580171852147395 (sec:1697580171.8521), delta to HW TX-=
complete-time sec:0.2046 (204609.098 usec)
> >0x19546f8: complete rx idx=3D128 addr=3D80100
> >
> >mvbz4:~# nc  -Nu -q1 ${MVBZ3_LINK_LOCAL_IP}%eth3 9091
> >
> >mvbz4:~# tcpdump -vvx -i eth3 udp
> >        tcpdump: listening on eth3, link-type EN10MB (Ethernet), snapsho=
t length 262144
> >bytes
> >12:26:09.301074 IP6 (flowlabel 0x35fa5, hlim 127, next-header UDP (17) p=
ayload
> >length: 11) fe80::1270:fdff:fe48:1087.55807 > fe80::1270:fdff:fe48:1077.=
9091: [bad
> >udp cksum 0x3b8e -> 0xde7e!] UDP, length 3
> >        0x0000:  6003 5fa5 000b 117f fe80 0000 0000 0000
> >        0x0010:  1270 fdff fe48 1087 fe80 0000 0000 0000
> >        0x0020:  1270 fdff fe48 1077 d9ff 2383 000b 3b8e
> >        0x0030:  7864 70
> >12:26:09.301976 IP6 (flowlabel 0x35fa5, hlim 127, next-header UDP (17) p=
ayload
> >length: 11) fe80::1270:fdff:fe48:1077.9091 > fe80::1270:fdff:fe48:1087.5=
5807: [udp
> >sum ok] UDP, length 3
> >        0x0000:  6003 5fa5 000b 117f fe80 0000 0000 0000
> >        0x0010:  1270 fdff fe48 1077 fe80 0000 0000 0000
> >        0x0020:  1270 fdff fe48 1087 2383 d9ff 000b de7e
> >        0x0030:  7864 70
> >
> >This reverts commit c3c9abc1d0c989e0be21d78cccd99076cc94ec44.
>
> It didn't looked like this patch is reverting something.
> If this is not a mistake, can you add the commit title behind the ID?

Ah, that's a leftover from my rebasing and reshuffling, will drop, thanks!


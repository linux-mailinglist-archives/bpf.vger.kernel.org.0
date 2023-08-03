Return-Path: <bpf+bounces-6869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ABC76EC4A
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1437E1C2156D
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DD523BC9;
	Thu,  3 Aug 2023 14:20:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C742221D57
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 14:20:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDA810D4
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691072413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbrWzc88d0mXXcVtOfac4PPN+ZD5v291zVOH90s9S3k=;
	b=cTnheOVO8kJXraFjuO09NK/ScD/8o07v6yFdR8rcVUN2SCLau49sdq2aW/voILDwjqOfA4
	kcm/o6sRRXcEksXk0W42NHdVRbaRjWE1pbI/4zCOcvQCxcL1hLXkAEFFlOiCbgyif3l0dy
	FrdiQaXHOdlBYr8YKxjrNSXgBoHWMDg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403--h3xvEeHOfyrOnzscid6sA-1; Thu, 03 Aug 2023 10:20:12 -0400
X-MC-Unique: -h3xvEeHOfyrOnzscid6sA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63d2b88325bso1891016d6.1
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 07:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691072412; x=1691677212;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbrWzc88d0mXXcVtOfac4PPN+ZD5v291zVOH90s9S3k=;
        b=G3Woxdy/8xSTd8ZrgEHcriQ02kxO3nbEtriUTeBJwj6spHNu1QY+oyZW15khIwJuVv
         57NphrEaHLYaz1xbj6S5FuI/f1paWagOniZ0hzLSi1AG+69QjmqV5jGHEtGLiKScI25k
         Uxp7VP6wohbc0oDRyK5VH4PcwEtnkqAIJBH0ZytFbvwlCxGlW4bujWTf1kSRDHK4jdp+
         V82/TR5wh3gE18iyBMx0p2VrcLD6F/5YMoF9+bXmIZJKQyYRIYiAB6Rr8kVZNm+3NgWm
         qa6bObeNPUsXeRg2wdDSOVswTkd08LXdeR5gDxAJUfe6c/OajoEXyvQgMPMPak/JcMZ4
         aovg==
X-Gm-Message-State: ABy/qLaIGk6b0XUrOaVQprmL/+ONI9mbhfJdQrw7rK2u63miKChlO5Gu
	U8DMXkcTmWwhBTxVQ6T5XIPjlA1+DG5487wT45pNW/Qm8dyC5Dy9Q0VWVVBVTyMSZTgyKt+cZ46
	KKW1yTmJ7rkKG
X-Received: by 2002:a05:6214:c8d:b0:63c:7427:e7e9 with SMTP id r13-20020a0562140c8d00b0063c7427e7e9mr19747697qvr.6.1691072412121;
        Thu, 03 Aug 2023 07:20:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGNys8vM7ek/eHEjSQxNfohkfJgnLkZpZ8gVvxXJqVykAOZhfgtp41kcpSaVUS9/K2KfELkGg==
X-Received: by 2002:a05:6214:c8d:b0:63c:7427:e7e9 with SMTP id r13-20020a0562140c8d00b0063c7427e7e9mr19747675qvr.6.1691072411850;
        Thu, 03 Aug 2023 07:20:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-226.dyn.eolo.it. [146.241.226.226])
        by smtp.gmail.com with ESMTPSA id m9-20020a0cdb89000000b0063d2898f210sm6292922qvk.103.2023.08.03.07.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:20:11 -0700 (PDT)
Message-ID: <a144aa6351412e25bbdf866c0d31b550e6ff3e8a.camel@redhat.com>
Subject: Re: [RFC Optimizing veth xsk performance 00/10]
From: Paolo Abeni <pabeni@redhat.com>
To: "huangjie.albert" <huangjie.albert@bytedance.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>,  =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?=
 <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Kees Cook <keescook@chromium.org>,
 Richard Gobert <richardbgobert@gmail.com>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Date: Thu, 03 Aug 2023 16:20:06 +0200
In-Reply-To: <20230803140441.53596-1-huangjie.albert@bytedance.com>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-08-03 at 22:04 +0800, huangjie.albert wrote:
> AF_XDP is a kernel bypass technology that can greatly improve performance=
.
> However, for virtual devices like veth, even with the use of AF_XDP socke=
ts,
> there are still many additional software paths that consume CPU resources=
.=20
> This patch series focuses on optimizing the performance of AF_XDP sockets=
=20
> for veth virtual devices. Patches 1 to 4 mainly involve preparatory work.=
=20
> Patch 5 introduces tx queue and tx napi for packet transmission, while=
=20
> patch 9 primarily implements zero-copy, and patch 10 adds support for=20
> batch sending of IPv4 UDP packets. These optimizations significantly redu=
ce=20
> the software path and support checksum offload.
>=20
> I tested those feature with
> A typical topology is shown below:
> veth<-->veth-peer                                    veth1-peer<--->veth1
> 	1       |                                                  |   7
> 	        |2                                                6|
> 	        |                                                  |
> 	      bridge<------->eth0(mlnx5)- switch -eth1(mlnx5)<--->bridge1
>                   3                    4                 5   =20
>              (machine1)                              (machine2)   =20
> AF_XDP socket is attach to veth and veth1. and send packets to physical N=
IC(eth0)
> veth:(172.17.0.2/24)
> bridge:(172.17.0.1/24)
> eth0:(192.168.156.66/24)
>=20
> eth1(172.17.0.2/24)
> bridge1:(172.17.0.1/24)
> eth0:(192.168.156.88/24)
>=20
> after set default route=EF=BF=BD=EF=BF=BD?snat=EF=BF=BD=EF=BF=BD?dnat. we=
 can have a tests
> to get the performance results.
>=20
> packets send from veth to veth1:
> af_xdp test tool:
> link:https://github.com/cclinuxer/libxudp
> send:(veth)
> ./objs/xudpperf send --dst 192.168.156.88:6002 -l 1300
> recv:(veth1)
> ./objs/xudpperf recv --src 172.17.0.2:6002
>=20
> udp test tool:iperf3
> send:(veth)
> iperf3 -c 192.168.156.88 -p 6002 -l 1300 -b 60G -u

Should be: '-b 0' otherwise you will experience additional overhead.

And you would likely pin processes and irqs to ensure BH and US run on
different cores of the same numa node.

Cheers,

Paolo



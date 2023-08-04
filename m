Return-Path: <bpf+bounces-7008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1213177017E
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 15:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C292D2826A3
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165D3C12A;
	Fri,  4 Aug 2023 13:28:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05CCBE59
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 13:28:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1796E3595
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691155696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MaywohC+LFSW7AF7nVGv9yHzowQamawqHZwaoNWo3B0=;
	b=Wp3jRJNOJpPJqUudx/bFrISGgPURd/ZN3UsrcKy63Xbhkbw3rVn9HYIR7M0qX/AP6+K2eQ
	Pv4QFrNXx5TnMnj24rULObOw1voIrkf+25N6x0lLPlEmyVqnJcTVulKKK5QMRQ712W+iVs
	5BrKc4y7Ns1tVfFBhXadSccGv4y2/bM=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-JuiQtTqePkOz2yHPO-QNjg-1; Fri, 04 Aug 2023 09:28:14 -0400
X-MC-Unique: JuiQtTqePkOz2yHPO-QNjg-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a73fbef692so3327992b6e.2
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 06:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691155694; x=1691760494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MaywohC+LFSW7AF7nVGv9yHzowQamawqHZwaoNWo3B0=;
        b=fgGos9SL56Vjq0ASlGmiX4NoXFVqdtESpphbDfRfTLXL3WZ10jG1+4ECaUpvUWLOH1
         Cggw6vF1yhgBKQNQ9uO73d80mWPDjgFgg8e3se3ZB49MSzbAIKbYcTzYRDfgOJVmZfpN
         EhFf5tVy5nPb9ikiL1rB6qtpiCRRRBZkxujS3ye2pSvTZy+xCH3DVHfYADv6bcLnqnrx
         6YrBVokehsED400abOjptRxzBUmqQbkUPd+HdIW7ZqIktTe3xUfN4oEomqtjZq8v3v8H
         G/ZvFChyXdDfWPoeh1Rvf7xf330AMtVTuSpA9el93Q29bGz9L2ogS/9aZDDaAxiWGf4p
         +MQA==
X-Gm-Message-State: AOJu0Yz+oBIx1e/lz1VnL0hGwi1Ki6ywri72dxN7FI8UXCdNt9UZvuG+
	xoMnwpgi5683SQhwWRmfbIcHCElZaCUjWRzALGApR1ksF/9uM5OyV8e+o7qPDGvbhMvbgJU7aFr
	7YsV+gOEwHovY
X-Received: by 2002:aca:90e:0:b0:3a7:5327:b38e with SMTP id 14-20020aca090e000000b003a75327b38emr1804315oij.39.1691155693982;
        Fri, 04 Aug 2023 06:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXYwMED4nkJFgaoRaWCsJQatWRY5bbMvaEPJcytTfZDIMrL14uAu8ltS1chCmTD6xPCLaeog==
X-Received: by 2002:aca:90e:0:b0:3a7:5327:b38e with SMTP id 14-20020aca090e000000b003a75327b38emr1804293oij.39.1691155693643;
        Fri, 04 Aug 2023 06:28:13 -0700 (PDT)
Received: from debian ([2001:4649:fcb8:0:dc2e:5d37:b73a:3fff])
        by smtp.gmail.com with ESMTPSA id n7-20020a0cdc87000000b0063d152e5d9asm654103qvk.120.2023.08.04.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:28:13 -0700 (PDT)
Date: Fri, 4 Aug 2023 15:28:08 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org,
	Siwar Zitouni <siwar.zitouni@6wind.com>
Subject: Re: [PATCH net v2] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
Message-ID: <ZMz86ADsBWV1gAal@debian>
References: <20230802122106.3025277-1-nicolas.dichtel@6wind.com>
 <ZMtpSdLUQx2A6bdx@debian>
 <34f246ba-3ebc-1257-fe8d-5b7e0670a4a6@6wind.com>
 <ZMuI5mxR704O9nDq@debian>
 <62a8762c-40b4-f03f-ca8f-13d33db84f10@6wind.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62a8762c-40b4-f03f-ca8f-13d33db84f10@6wind.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 03, 2023 at 02:22:17PM +0200, Nicolas Dichtel wrote:
> Le 03/08/2023 à 13:00, Guillaume Nault a écrit :
> > On Thu, Aug 03, 2023 at 11:37:00AM +0200, Nicolas Dichtel wrote:
> >> Le 03/08/2023 à 10:46, Guillaume Nault a écrit :
> >>> On Wed, Aug 02, 2023 at 02:21:06PM +0200, Nicolas Dichtel wrote:
> >>>> This kind of interface doesn't have a mac header.
> >>>
> >>> Well, PPP does have a link layer header.
> >> It has a link layer, but not an ethernet header.
> > 
> > This is generic code. The layer two protocol involved doesn't matter.
> > What matter is that the device requires a specific l2 header.
> Ok. Note, that addr_len is set to 0 for these devices:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ppp/ppp_generic.c#n1614

PPP has no hardware address. It doesn't need any since it's point to
point. But it still has an l2 header.

> >>> Do you instead mean that PPP automatically adds it?
> >>>
> >>>> This patch fixes bpf_redirect() to a ppp interface.
> >>>
> >>> Can you give more details? Which kind of packets are you trying to
> >>> redirect to PPP interfaces?
> >> My ebpf program redirect an IP packet (eth / ip) from a physical ethernet device
> >> at ingress to a ppp device at egress.
> > 
> > So you're kind of bridging two incompatible layer two protocols.
> > I see no reason to be surprised if that doesn't work out of the box.
> I don't see the difference with a gre or ip tunnel. This kind of "bridging" is
> supported.

From a protocol point of view, this feature just needs to strip the l2
header (or add it for the other way around). Here we have to remove the
previous l2 header, then add a new one of a different kind.

But honestly, even for the l3-tunnel<->Ethernet "bridging", I don't
really like how the code tries to be too clever. It'd have been much
simpler to just require the user to drop the l2 headers explicitely.
Anyway, that ship has sailed.

> > Let me be clearer too. As I said, this patch may be the best we can do.
> > Making a proper l2 generic BPF-redirect/TC-mirred might require too
> > much work for the expected gain (how many users of non-Ethernet l2
> > devices are going to use this). But at least we should make it clear in
> > the commit message and in the code why we're finding it convenient to
> > treat PPP as an l3 device. Like
> > 
> > +	/* PPP adds its l2 header automatically in ppp_start_xmit().
> > +	 * This makes it look like an l3 device to __bpf_redirect() and
> > +	 * tcf_mirred_init().
> > +	 */
> > +	case ARPHRD_PPP:
> I better understand your point with this comment, I can add it, no problem.
> But I fail to see why it is different from a L3 device. ip, gre, etc. tunnels
> also add automatically another header (ipip.c has dev->addr_len configured to 4,
> ip6_tunnels.c to 16, etc.).

These are encapsulation protocols. They glue the inner and outer
packets together. PPP doesn't do that, it's just an l2 protocol.
To encapsulate PPP into IP or UDP, you need another protocol, like
L2TP.

We can compare GRE or IPIP to L2TP (to some extend), not to PPP.

> A tcpdump on the physical output interface shows the same kind of packets (the
> outer hdr (ppp / ip / etc.) followed by the encapsulated packet and a tcpdump on
> the ppp or ip tunnel device shows only the inner packet.

Packets captured on ppp interfaces seem to be a bit misleading. They
don't show the l2-header, but the "Linux cooked capture" header
instead. I don't know the reasoning behind that, maybe to help people
differenciate between Rx and Tx packets. Anyway, that's different from
the raw IP packets captured on ipip devices for example.

Really, PPP isn't like any ip tunnel protocol. It's just not an
encapsulation protocol. PPP is like Ethernet. And just like Ethernet,
it can be encapsulated by tunnels, but that requires a separate
tunneling protocol. As an example, Ethernet has VXLAN and PPP has L2TP.

> Without my patch, a redirect from a ppp interface to another ppp interface would
> have the same problem.

True, but that's because the PPP code is so old and unmaintained, it
hasn't evolved with the rest of the networking stack. And again, I
agree that your patch is the easiest way to make it work. But it will
also expose inconsistencies in how BPF and tc-mirred handle different
l2 protocols. That makes the logic hard to get from a developper point
of view and that's why I'm asking for a better commit message and some
comments in the code. For the user space inconsistencies, well, I guess
nobody will really care :(.

> Regards,
> Nicolas
> 



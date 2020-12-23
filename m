Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261252E18DA
	for <lists+bpf@lfdr.de>; Wed, 23 Dec 2020 07:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgLWGV6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 23 Dec 2020 01:21:58 -0500
Received: from d.mail.sonic.net ([64.142.111.50]:45152 "EHLO d.mail.sonic.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbgLWGV5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Dec 2020 01:21:57 -0500
Received: from [192.168.42.85] (173-228-4-241.dsl.dynamic.fusionbroadband.com [173.228.4.241])
        (authenticated bits=0)
        by d.mail.sonic.net (8.15.1/8.15.1) with ESMTPSA id 0BN6L011018771
        (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Dec 2020 22:21:00 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [tcpdump-workers] Performance impact with multiple pcap handlers
 on Linux
From:   Guy Harris <gharris@sonic.net>
In-Reply-To: <20201222233143.GB5758@otheros>
Date:   Tue, 22 Dec 2020 22:20:59 -0800
Cc:     tcpdump-workers <tcpdump-workers@lists.tcpdump.org>,
        bpf@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <07EC8A9F-E197-4B94-8979-2C61359AF976@sonic.net>
References: <mailman.79.1608674752.8496.tcpdump-workers@lists.tcpdump.org>
 <BEB73616-3CB7-4CE2-B2D4-D6FA32B258FF@sonic.net>
 <20201222233143.GB5758@otheros>
To:     =?utf-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Sonic-CAuth: UmFuZG9tSVZElTppmqRTxRTOLiV53L4xNoJBYYSrl2sunF/LmHehcOrwxxp4n6CqjuaGbukwpJwZt0ttvaybGvW8iHSLiYTr
X-Sonic-ID: C;0lOIBudE6xGNJeyC/iHpiQ== M;7JTDBudE6xGNJeyC/iHpiQ==
X-Spam-Flag: No
X-Sonic-Spam-Details: 0.0/5.0 by cerberusd
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Dec 22, 2020, at 3:31 PM, Linus Lüssing <linus.luessing@c0d3.blue> wrote:

> Basically we want to do live measurements of the overhead of the mesh
> routing protocol and measure and dissect the layer 2 broadcast traffic.
> To measure how much ARP, DHCP, ICMPv6 NS/NA/RS/RA, MDNS, LLDP overhead
> etc. we have.

OK, so I'm not a member of the bpf mailing list, so this message won't get to that list, but:

Given how general (e)BPF is in Linux, and given the number of places where you can add an eBPF program, and given the extensions added by the "(e)" part, it might be possible to:

	construct a single eBPF program that matches all of those packet types;

	provides, in some fashion, an indication of *which* of the packet types matched;

	provides the packet length as well.

If you *only* care about the packet counts and packet byte counts, that might be sufficient if the eBPF program can be put into the right place in the networking stack - it would also mean that the Linux kernel wouldn't have to copy the packets (as it does for each PF_PACKET socket being used for capturing, and there's one of those for every pcap_t), and your program wouldn't have to read those packets.

libpcap won't help you there, as it doesn't even know about eBPF, much less about it's added capabilities, but it sounds as if this is a Linux-specific program, so that doesn't matter.  There may be a compiler allowing you to write a program to do what's described above and get it compiled into eBPF.

I don't know whether there's a place in the networking stack to which you can attach an eBPF probe to do this, but I wouldn't be surprised to find out that there is one.

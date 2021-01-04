Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AFF2E9517
	for <lists+bpf@lfdr.de>; Mon,  4 Jan 2021 13:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbhADMma (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jan 2021 07:42:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbhADMma (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 4 Jan 2021 07:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609764063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9uW4y2jQTaljHLO4lPc7SECPJtOzyPNHiZ6NhexWKpY=;
        b=LNCzo1+SHX5JJi8GwF0Hq1yAjPi4Ti5UMyCc/tfhpkfYNVHcu63tuQLu3+LSCOP4JrsPYS
        X5ZkUyGuEqk6LjcQZEmWVO52KMybs0jiHmv2xQVUF/Jwv41BNN3qI09joMVeXpp1F7gv+t
        O+CXmdKcOlkgzgF0qnD1fqBDT04EQd8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196--367h4bePRK-lJnyvbkzgA-1; Mon, 04 Jan 2021 07:40:59 -0500
X-MC-Unique: -367h4bePRK-lJnyvbkzgA-1
Received: by mail-wm1-f71.google.com with SMTP id 4so4912467wmj.2
        for <bpf@vger.kernel.org>; Mon, 04 Jan 2021 04:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9uW4y2jQTaljHLO4lPc7SECPJtOzyPNHiZ6NhexWKpY=;
        b=Uo1EW0zpvNCvdEqOJc9HmkjLEiKYZ1KLcmPlbeopMvLFj9qKjNGLcz/Tac7YybYl61
         VnJeMza+JytrDyCvV5GOsplT9tT4F53nCtV6Ep8QmlxRgiHG/piAmC3O34oBG7I5qRQo
         7D2T0azMoxRcjgRU1A88aMhOvaglKieoO7DzvoquhKSbIrTOceEbtM0RNGLBCZQPlt8n
         /JJeZCKxeMVtKQwb0A7QhUT5weDtTM7vDBnuxzN9EeYDEHp5hD1kct2lmFnT0mijNKfs
         /l0Zv7xvebHPSNd54S1ds3yecapSW2EVhIFMAjrATya5NUeRuZjynZpuj/WAsIkFTyAL
         YTcA==
X-Gm-Message-State: AOAM530KLOVwMWMXjiQVgFqLkpZg41+ZM66F9DrPkqDtV5v/89dd5RvA
        zV8SAK7ZRSdcdy7sdVOHdM0nJviiZ+d126ebiCGTetjKB4OvpQNw5bsrO2wKN+yviOvjAYdFnWM
        IHS5P8YipLYW6
X-Received: by 2002:adf:f58a:: with SMTP id f10mr83027983wro.338.1609764057948;
        Mon, 04 Jan 2021 04:40:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4XUcYiUH0b+OrBbZjtGgessWuxNJve6UFzp8B/TxcAs1sJu3r/+jotoqLhjp26C8iG4IG6A==
X-Received: by 2002:adf:f58a:: with SMTP id f10mr83027956wro.338.1609764057522;
        Mon, 04 Jan 2021 04:40:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g1sm50492665wrq.30.2021.01.04.04.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 04:40:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8B4AA180063; Mon,  4 Jan 2021 13:40:56 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Guy Harris <gharris@sonic.net>,
        Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc:     tcpdump-workers <tcpdump-workers@lists.tcpdump.org>,
        bpf@vger.kernel.org
Subject: Re: [tcpdump-workers] Performance impact with multiple pcap
 handlers on Linux
In-Reply-To: <07EC8A9F-E197-4B94-8979-2C61359AF976@sonic.net>
References: <mailman.79.1608674752.8496.tcpdump-workers@lists.tcpdump.org>
 <BEB73616-3CB7-4CE2-B2D4-D6FA32B258FF@sonic.net>
 <20201222233143.GB5758@otheros>
 <07EC8A9F-E197-4B94-8979-2C61359AF976@sonic.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 04 Jan 2021 13:40:56 +0100
Message-ID: <87v9cc50yv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Guy Harris <gharris@sonic.net> writes:

> On Dec 22, 2020, at 3:31 PM, Linus L=C3=BCssing <linus.luessing@c0d3.blue=
> wrote:
>
>> Basically we want to do live measurements of the overhead of the mesh
>> routing protocol and measure and dissect the layer 2 broadcast traffic.
>> To measure how much ARP, DHCP, ICMPv6 NS/NA/RS/RA, MDNS, LLDP overhead
>> etc. we have.
>
> OK, so I'm not a member of the bpf mailing list, so this message won't
> get to that list, but:

Yes it did :)

> Given how general (e)BPF is in Linux, and given the number of places
> where you can add an eBPF program, and given the extensions added by
> the "(e)" part, it might be possible to:
>
> 	construct a single eBPF program that matches all of those packet types;
>
> 	provides, in some fashion, an indication of *which* of the packet types =
matched;
>
> 	provides the packet length as well.
>
> If you *only* care about the packet counts and packet byte counts,
> that might be sufficient if the eBPF program can be put into the right
> place in the networking stack - it would also mean that the Linux
> kernel wouldn't have to copy the packets (as it does for each
> PF_PACKET socket being used for capturing, and there's one of those
> for every pcap_t), and your program wouldn't have to read those
> packets.
>
> libpcap won't help you there, as it doesn't even know about eBPF, much
> less about it's added capabilities, but it sounds as if this is a
> Linux-specific program, so that doesn't matter. There may be a
> compiler allowing you to write a program to do what's described above
> and get it compiled into eBPF.

You could certainly do this in eBPF: Write an eBPF program that matches
each packet type, and updates a BPF map with the count and total size.
Then you just need to read this map from userspace to get the values you
want, and there will be no copying involved anywhere.

We have some examples of packet parsing in the XDP tutorial (also partly
applicable to other eBPF hooks with direct packet access):
https://github.com/xdp-project/xdp-tutorial/blob/master/packet-solutions/xd=
p_prog_kern_02.c

> I don't know whether there's a place in the networking stack to which
> you can attach an eBPF probe to do this, but I wouldn't be surprised
> to find out that there is one.

On egress you could attach to the TC hook; on ingress if your driver has
native XDP support you can attach there with very little overhead. If it
doesn't (which would be the case for WiFi drivers), you may as well use
the TC hook on ingress as well (via a tc 'ingress' filter). There's also
a 'generic XDP', but it doesn't really have any performance benefit over
TC, so you may as well just use the TC hook...

Here's an example of how to share code between the XDP and TC hooks:

https://github.com/xdp-project/bpf-examples/tree/master/encap-forward

The bpf-examples repository is also meant as a way to showcase
real-world examples of how to do useful things with BPF, and contains
some Makefile infrastructure to get the build setup. If you want to
contribute your packet monitor as an example here, feel free to open a
pull request! :)

-Toke


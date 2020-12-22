Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92FA2E1097
	for <lists+bpf@lfdr.de>; Wed, 23 Dec 2020 00:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgLVXcc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Dec 2020 18:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgLVXcb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Dec 2020 18:32:31 -0500
X-Greylist: delayed 5169 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Dec 2020 15:31:50 PST
Received: from mail.aperture-lab.de (mail.aperture-lab.de [IPv6:2a01:4f8:171:314c::100:a1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A416DC0613D3
        for <bpf@vger.kernel.org>; Tue, 22 Dec 2020 15:31:50 -0800 (PST)
Date:   Wed, 23 Dec 2020 00:31:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1608679908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pt6IG1R5V1ZOB/n45F/MVoOEWWOSvz5Eu+lWj5m0rfk=;
        b=vEz2KglS3oTCctogzFUGIAsPFUhYMaDQKypMA7WT4+VkTmYombxGOjtb7hgNk7cYUBwu8+
        9zNpHjRgPlLvwmns3WgKplFHVBcQD9dh29nCf7gNS+KOyeOAcJcwBBdgwsf7eNXWfpPvjA
        xJKcCb0LMBcT5VYxtUhDlPOv3xAnVVTuUsPgoY45ABDOCvyrY60/bU/2QHYxNFza6V/N6L
        3g1dj/hl3u6fXES3q/6c1oRynApmhH99MlruSV21chMzuHkM/mrGfNRDv6lzop2Mjv7YTP
        7PLV/fo5cM3xn9jkTOs7NrwuZIanSZhdsJJUxv8XTR6lRT2D4n7qA5CYMhRR+Q==
From:   Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To:     Guy Harris <gharris@sonic.net>
Cc:     tcpdump-workers@lists.tcpdump.org, bpf@vger.kernel.org
Subject: Re: [tcpdump-workers] Performance impact with multiple pcap handlers
 on Linux
Message-ID: <20201222233143.GB5758@otheros>
References: <mailman.79.1608674752.8496.tcpdump-workers@lists.tcpdump.org>
 <BEB73616-3CB7-4CE2-B2D4-D6FA32B258FF@sonic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BEB73616-3CB7-4CE2-B2D4-D6FA32B258FF@sonic.net>
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 22, 2020 at 02:28:17PM -0800, Guy Harris wrote:
> On Dec 22, 2020, at 2:05 PM, Linus Lüssing via tcpdump-workers <tcpdump-workers@lists.tcpdump.org> wrote:
> 
> > I was experimenting a bit with migrating from the use of
> > pcap_offline_filter() to pcap_setfilter().
> > 
> > I was a bit surprised that installing for instance 500 pcap
> > handlers
> 
> What is a "pcap handler" in this context?  An open live-capture pcap_t?
> 
> > with a BPF rule "arp" via pcap_setfilter() reduced
> > the TCP performance of iperf3 over veth interfaces from 73.8 Gbits/sec
> > to 5.39 Gbits/sec. Using only one or even five handlers seemed
> > fine (71.7 Gbits/sec and 70.3 Gbits/sec).
> > 
> > Is that expected?
> > 
> > Full test setup description and more detailed results can be found
> > here: https://github.com/lemoer/bpfcountd/pull/8
> 
> That talks about numbers of "rules" rather than "handlers".  It does speak of "pcap *handles*"; did you mean "handles", rather than "handlers"?

Sorry, right, I ment pcap handles everywhere.

So far the bpfcountd code uses one pcap_t handle created via one
pcap_open_live() call. And then for each received packet iterates
over a list of user specified filter expressions and applies
pcap_offline_filter() for each filter to the packet. And then
counts the number of packets and packet bytes that matched each
filter expression.

> 
> Do those "rules" correspond to items in the filter expression that's compiled into BPF code, or do they correspond to open `pcap_t`s?  If a "rule" corresponds to a "handle", then does it correspond to an open pcap_t?
> 
> Or do they correspond to an entire filter expression?

What I ment with "rule" was an entire filter expression. The user
specifies a list of filter expressions. And bpfcountd counts how
many packets and the sum of packet bytes which matched each filter
expression.

Basically we want to do live measurements of the overhead of the mesh
routing protocol and measure and dissect the layer 2 broadcast traffic.
To measure how much ARP, DHCP, ICMPv6 NS/NA/RS/RA, MDNS, LLDP overhead
etc. we have.

> 
> Does this change involve replacing a *single* pcap_t, on which you use pcap_offline_filter() with multiple different filter expressions, with *multiple* pcap_t's, with each one having a separate filter, set with pcap_setfilter()?  If so, note that this involves replacing a single file descriptor with multiple file descriptors, and replacing a single ring buffer into which the kernel puts captured packets with multiple ring buffers into *each* of which the kernel puts captured packets, which increases the amount of work the kernel does.

Correct. I tried to replace the single pcap_t with multiple
pcap_t's, one for each filter expression the user specified. And
then tried using pcap_setfilter() on each pcap_t and removing the
filtering in userspace via pcap_offline_filter().

The idea was to improve performance by A): Avoiding to copy the
actual packet data to userspace. And B) I was hoping that
traffic which does not match any filter expression would not be
impacted by running bpfcountd / libpcap that much anymore.

Right, for matching, captured traffic the work for the kernel is
probably more, with mulitple ring buffers as you described. But
we only want to match and measure and dissect broadcast and mesh
protocol traffic with bpfcountd. For which we are expecting traffic
rates of about 100 to 500 kbits/s which are supposed to match.

Unicast IP traffic at much higher rates will not be matched and the
idea/hope for these changes was to leave the IP unicast performance
mostly untampered while still measuring and dissecting the other,
non IP unicast traffic.

> 
> > PS: And I was also surprised that there seems to be a limit of
> > only 510 pcap handlers on Linux.
> 
> "handlers" or "handles"?
> 
> If it's "handles", as in "pcap_t's open for live capture", and if you're switching from a single pcap_t to multiple pcap_t's, that means using more file descriptors (so that you may eventually run out) and more ring buffers (so that the kernel may eventually say "you're tying up too much wired memory for all those ring buffers").
> 
> In either of those cases, the attempt to open a pcap_t will eventually get an error; what is the error that's reported?

pcap_activate() returns "socket: Too many open files" for the
511th pcap_t and pcap_activate() call.

Ah! "ulimit -n" as root returns "1024" for me. Increasing that
limit helps, I can have more pcap_t handles then, thanks!

(as a non-root user "ulimit -n" returns 1048576 - interesting that
an unprivileged user can open more sockets than root by default,
didn't expect that)

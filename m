Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F172D2E105D
	for <lists+bpf@lfdr.de>; Tue, 22 Dec 2020 23:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgLVWkh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 22 Dec 2020 17:40:37 -0500
Received: from d.mail.sonic.net ([64.142.111.50]:56816 "EHLO d.mail.sonic.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgLVWkh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Dec 2020 17:40:37 -0500
X-Greylist: delayed 678 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Dec 2020 17:40:37 EST
Received: from [192.168.42.85] (173-228-4-241.dsl.dynamic.fusionbroadband.com [173.228.4.241])
        (authenticated bits=0)
        by d.mail.sonic.net (8.15.1/8.15.1) with ESMTPSA id 0BMMSILM005302
        (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Dec 2020 14:28:18 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [tcpdump-workers] Performance impact with multiple pcap handlers
 on Linux
From:   Guy Harris <gharris@sonic.net>
In-Reply-To: <mailman.79.1608674752.8496.tcpdump-workers@lists.tcpdump.org>
Date:   Tue, 22 Dec 2020 14:28:17 -0800
Cc:     tcpdump-workers@lists.tcpdump.org, bpf@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <BEB73616-3CB7-4CE2-B2D4-D6FA32B258FF@sonic.net>
References: <mailman.79.1608674752.8496.tcpdump-workers@lists.tcpdump.org>
To:     =?utf-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Sonic-CAuth: UmFuZG9tSVaRIgBQ/oi1Bozk+7oTTqaT6FX1ce5yeXPf0LnFgdh/+8fS70vzgH+39TOaAylE8JuWmWN/fijqyEwe0x4MpL66
X-Sonic-ID: C;FkqK/aRE6xGbW+yC/iHpiQ== M;ENrI/aRE6xGbW+yC/iHpiQ==
X-Spam-Flag: No
X-Sonic-Spam-Details: 0.0/5.0 by cerberusd
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Dec 22, 2020, at 2:05 PM, Linus Lüssing via tcpdump-workers <tcpdump-workers@lists.tcpdump.org> wrote:

> I was experimenting a bit with migrating from the use of
> pcap_offline_filter() to pcap_setfilter().
> 
> I was a bit surprised that installing for instance 500 pcap
> handlers

What is a "pcap handler" in this context?  An open live-capture pcap_t?

> with a BPF rule "arp" via pcap_setfilter() reduced
> the TCP performance of iperf3 over veth interfaces from 73.8 Gbits/sec
> to 5.39 Gbits/sec. Using only one or even five handlers seemed
> fine (71.7 Gbits/sec and 70.3 Gbits/sec).
> 
> Is that expected?
> 
> Full test setup description and more detailed results can be found
> here: https://github.com/lemoer/bpfcountd/pull/8

That talks about numbers of "rules" rather than "handlers".  It does speak of "pcap *handles*"; did you mean "handles", rather than "handlers"?

Do those "rules" correspond to items in the filter expression that's compiled into BPF code, or do they correspond to open `pcap_t`s?  If a "rule" corresponds to a "handle", then does it correspond to an open pcap_t?

Or do they correspond to an entire filter expression?

Does this change involve replacing a *single* pcap_t, on which you use pcap_offline_filter() with multiple different filter expressions, with *multiple* pcap_t's, with each one having a separate filter, set with pcap_setfilter()?  If so, note that this involves replacing a single file descriptor with multiple file descriptors, and replacing a single ring buffer into which the kernel puts captured packets with multiple ring buffers into *each* of which the kernel puts captured packets, which increases the amount of work the kernel does.

> PS: And I was also surprised that there seems to be a limit of
> only 510 pcap handlers on Linux.

"handlers" or "handles"?

If it's "handles", as in "pcap_t's open for live capture", and if you're switching from a single pcap_t to multiple pcap_t's, that means using more file descriptors (so that you may eventually run out) and more ring buffers (so that the kernel may eventually say "you're tying up too much wired memory for all those ring buffers").

In either of those cases, the attempt to open a pcap_t will eventually get an error; what is the error that's reported?

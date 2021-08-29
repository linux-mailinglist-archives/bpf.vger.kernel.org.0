Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043593FAE27
	for <lists+bpf@lfdr.de>; Sun, 29 Aug 2021 21:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbhH2Tii (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Aug 2021 15:38:38 -0400
Received: from mail1.oneunified.net ([63.85.42.215]:49058 "EHLO
        mail1.oneunified.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbhH2Tii (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Aug 2021 15:38:38 -0400
X-Greylist: delayed 1416 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Aug 2021 15:38:37 EDT
X-Spam-Status: No
X-One-Unified-MailScanner-Watermark: 1630869240.57518@UdM70apz5p0fkeJKzmNVDA
X-One-Unified-MailScanner-From: ray@oneunified.net
X-One-Unified-MailScanner: Not scanned: postmaster@oneunified.net
X-One-Unified-MailScanner-ID: 17TJDv4t010820
X-OneUnified-MailScanner-Information: Please contact the ISP for more information
Received: from [10.55.90.10] (host96-45-2-121-eidnet.org [96.45.2.121] (may be forged))
        (authenticated bits=0)
        by mail1.oneunified.net (8.14.4/8.14.4/Debian-4) with ESMTP id 17TJDv4t010820
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Aug 2021 19:13:59 GMT
Subject: Re: [PATCH bpf-next v2 00/13] bpfilter
To:     Dmitrii Banshchikov <me@ubique.spb.ru>, bpf@vger.kernel.org
References: <20210829183608.2297877-1-me@ubique.spb.ru>
From:   Raymond Burkholder <ray@oneunified.net>
Organization: One Unified Net Limited
Message-ID: <42c5e32a-edb9-08a3-f37f-9def9583f5fc@oneunified.net>
Date:   Sun, 29 Aug 2021 13:13:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210829183608.2297877-1-me@ubique.spb.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/29/21 12:35 PM, Dmitrii Banshchikov wrote:
> The patchset is based on the patches from David S. Miller [1] and
> Daniel Borkmann [2].
> 
> The main goal of the patchset is to prepare bpfilter for
> iptables' configuration blob parsing and code generation.

The referenced patches are from 2018.  Since then, and since this is 
bpf-next, places like [1] indicate that we are moving on from iptables 
towards nftables.

Any thoughts?

[1] https://wiki.archlinux.org/title/Iptables

> 
> The patchset introduces data structures and code for matches,
> targets, rules and tables. Beside that the code generation
> is introduced.
> 
> The first version of the code generation supports only "inline"
> mode - all chains and their rules emit instructions in linear
> approach. The plan for the code generation is to introduce a
> bpf_map_for_each subprogram that will handle all rules that
> aren't generated in inline mode due to verifier's limit. This
> shall allow to handle arbitrary large rule sets.
> 
> Things that are not implemented yet:
>    1) The process of switching from the previous BPF programs to the
>       new set isn't atomic.
>    2) The code generation for FORWARD chain isn't supported
>    3) Counters setsockopts() are not handled
>    4) No support of device ifindex - it's hardcoded
>    5) No helper subprog for counters update
> 
> Another problem is using iptables' blobs for tests and filter
> table initialization. While it saves lines something more
> maintainable should be done here.
> 
> The plan for the next iteration:
>    1) Handle large rule sets via bpf_map_for_each
>    2) Add a helper program for counters update
>    3) Handle iptables' counters setsockopts()
>    4) Handle ifindex
>    5) Add TCP match
> 
> Patch 1 adds definitions of the used types.
> Patch 2 adds logging to bpfilter.
> Patch 3 adds bpfilter header to tools
> Patch 4 adds an associative map.
> Patch 5 adds code generation basis
> Patches 6/7/8/9 add code for matches, targets, rules and table.
> Patch 10 adds code generation for table
> Patch 11 handles hooked setsockopt(2) calls.
> Patch 12 adds filter table
> Patch 13 uses prepared code in main().
> 

...

> 
> 1. https://lore.kernel.org/patchwork/patch/902785/
> 2. https://lore.kernel.org/patchwork/patch/902783/
> 3. https://kernel.ubuntu.com/~cking/stress-ng/stress-ng.pdf

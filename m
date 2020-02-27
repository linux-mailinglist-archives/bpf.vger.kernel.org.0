Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33381729F2
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2020 22:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgB0VLf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Feb 2020 16:11:35 -0500
Received: from www62.your-server.de ([213.133.104.62]:50820 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0VLe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Feb 2020 16:11:34 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1j7QRN-0006Ns-HP; Thu, 27 Feb 2020 22:11:29 +0100
Received: from [85.7.42.192] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1j7QRN-000AS1-80; Thu, 27 Feb 2020 22:11:29 +0100
Subject: Re: [PATCH bpf-next] bpf: Add drgn script to list progs/maps
To:     Andrey Ignatov <rdna@fb.com>, Stanislav Fomichev <sdf@fomichev.me>,
        osandov@fb.com, ast@kernel.org
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, tj@kernel.org
References: <20200227023253.3445221-1-rdna@fb.com>
 <20200227180102.GA188741@mini-arch.hsd1.ca.comcast.net>
 <20200227182653.GC29488@rdna-mbp>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8cbe6219-004c-e4f0-5f1e-5270c326f21b@iogearbox.net>
Date:   Thu, 27 Feb 2020 22:11:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200227182653.GC29488@rdna-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25735/Thu Feb 27 20:18:16 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ +tj ]

On 2/27/20 7:26 PM, Andrey Ignatov wrote:
> Stanislav Fomichev <sdf@fomichev.me> [Thu, 2020-02-27 10:01 -0800]:
>> On 02/26, Andrey Ignatov wrote:
>>> drgn is a debugger that reads kernel memory and uses DWARF to get types
>>> and symbols. See [1], [2] and [3] for more details on drgn.
>>>
>>> Since drgn operates on kernel memory it has access to kernel internals
>>> that user space doesn't. It allows to get extended info about various
>>> kernel data structures.
>>>
>>> Introduce bpf.py drgn script to list BPF programs and maps and their
>>> properties unavailable to user space via kernel API.
>> Any reason this is not pushed to https://github.com/osandov/drgn/ ?
>> I have a bunch of networking helpers for drgn as well, but I was
>> thinking about contributing them to the drgn github, not the kernel.
>> IMO, seems like a better place to consolidate all drgn stuff.
> 
> I have this part in the commit message:
> 
>>> The script can be sent to drgn repo where it's easier to maintain its
>>> "drgn-ness", but in kernel tree it should be easier to maintain BPF
>>> functionality itself what can be more important in this case.
> 
> That's being said it's debatable which place is better and I'm still
> trying to figure it out myself since, from what i see, there is no
> widely adopted practice.
> 
> I've been contributing to drgn as well mostly in two forms:
> * helpers [1];
> * examples [2]
> 
> And so far I used examples/ dir as a place to keep small useful "tools"
> (tcp_sock.py, cgroup.py, bpf.py).
> 
> But there is no place for bigger "scripts" or "tools" in drgn (yet?). On
> the other hand I see two drgn scripts in kernel tree already:
> * tools/cgroup/iocost_coef_gen.py
> * tools/cgroup/iocost_monitor.py
> 
> So maybe it's time to discuss where to keep tools like this in the
> future.
> 
> In this specifc case I'd love to see feedback from Omar and BPF
> maintainers.

I can certainly see both sides given that drgn tools have been added to
tools/cgroup/ already. I presume if so, then these could live in tools/drgn/
which would also make it more clear what is needed to run as dependency
plus there should be be a proper high-level readme to document what developers
need to run in order to run them. But from looking at [1], I can also see that
those scripts would depend on new helpers being added/updated/deleted, so it
might be easier to add drgn/tools/ directory where scripts could be updated
in one go with updates to drgn helpers. Either way, I think it would be nice
to add documentation somewhere for getting people started.

> [1] https://github.com/osandov/drgn/tree/master/drgn/helpers/linux
> [2] https://github.com/osandov/drgn/tree/master/examples/linux

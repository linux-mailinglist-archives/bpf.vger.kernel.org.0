Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395D9419627
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbhI0OXC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 10:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbhI0OW7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 10:22:59 -0400
X-Greylist: delayed 582 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Sep 2021 07:21:21 PDT
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D16CC061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 07:21:21 -0700 (PDT)
Received: from [192.168.178.130] (p57bc9b61.dip0.t-ipconnect.de [87.188.155.97])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 8F5FD3AF449;
        Mon, 27 Sep 2021 14:11:37 +0000 (UTC)
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR
 BSD-2-Clause
To:     Luca Boccassi <bluca@debian.org>, bpf@vger.kernel.org
Cc:     bjorn@kernel.org, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, joe@ovn.org, jbacik@fb.com
References: <20210923000540.47344-1-luca.boccassi@gmail.com>
 <49c54bf3f4a95562592575062058f069654fd253.camel@debian.org>
 <bf0958b799e00e41a6ff7ea1ad3a331a7230378e.camel@debian.org>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <79774ce1-02b5-842b-6777-d2c0092fc989@zonque.org>
Date:   Mon, 27 Sep 2021 16:11:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bf0958b799e00e41a6ff7ea1ad3a331a7230378e.camel@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/27/21 4:07 PM, Luca Boccassi wrote:
> On Thu, 2021-09-23 at 11:41 +0100, Luca Boccassi wrote:
>> On Thu, 2021-09-23 at 01:05 +0100, luca.boccassi@gmail.com wrote:
>>> From: Luca Boccassi <bluca@debian.org>
>>>
>>> libbpf and bpftool have been dual-licensed to facilitate inclusion in
>>> software that is not compatible with GPL2-only (ie: Apache2), but the
>>> samples are still GPL2-only.
>>>
>>> Given these files are samples, they get naturally copied around. For
>>> example
>>> it is the case for samples/bpf/bpf_insn.h which was copied into the
>>> systemd
>>> tree:
>>> https://github.com/systemd/systemd/blob/main/src/shared/linux/bpf_insn.h
>>>
>>> Dual-license this header as GPL-2.0-only OR BSD-2-Clause to follow
>>> the same licensing used by libbpf and bpftool:
>>>
>>> 1bc38b8ff6cc ("libbpf: relicense libbpf as LGPL-2.1 OR BSD-2-Clause")
>>> 907b22365115 ("tools: bpftool: dual license all files")
>>>
>>> Signed-off-by: Luca Boccassi <bluca@debian.org>
>>> ---
>>> Most of systemd is (L)GPL2-or-later, which means there is no
>>> perceived
>>> incompatibility with Apache2 softwares and can thus be linked with
>>> OpenSSL 3.0. But given this GPL2-only header is included this is
>>> currently
>>> not possible.
>>> Dual-licensing this header solves this problem for us as we are
>>> scoping
>>> moving to OpenSSL 3.0, see:
>>>
>>> https://lists.freedesktop.org/archives/systemd-devel/2021-September/046882.html
>>>
>>> The authors of this file according to git log are:
>>>
>>> Alexei Starovoitov <ast@kernel.org>
>>> Björn Töpel <bjorn.topel@intel.com>
>>> Brendan Jackman <jackmanb@google.com>
>>> Chenbo Feng <fengc@google.com>
>>> Daniel Borkmann <daniel@iogearbox.net>
>>> Daniel Mack <daniel@zonque.org>
>>> Jakub Kicinski <jakub.kicinski@netronome.com>
>>> Jiong Wang <jiong.wang@netronome.com>
>>> Joe Stringer <joe@ovn.org>
>>> Josef Bacik <jbacik@fb.com>
>>>
>>> (excludes a commit adding the SPDX header)
>>>
>>> All authors and maintainers are CC'ed. An Acked-by from everyone in
>>> the
>>> above list of authors will be necessary.
>>>
>>> One could probably argue for relicensing all the samples/bpf/ files
>>> given both
>>> libbpf and bpftool are, however the authors list would be much larger
>>> and thus
>>> it would be much more difficult, so I'd really appreciate if this
>>> header could
>>> be handled first by itself, as it solves a real license
>>> incompatibility issue
>>> we are currently facing.
>>>
>>>  samples/bpf/bpf_insn.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/samples/bpf/bpf_insn.h b/samples/bpf/bpf_insn.h
>>> index aee04534483a..29c3bb6ad1cd 100644
>>> --- a/samples/bpf/bpf_insn.h
>>> +++ b/samples/bpf/bpf_insn.h
>>> @@ -1,4 +1,4 @@
>>> -/* SPDX-License-Identifier: GPL-2.0 */
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>  /* eBPF instruction mini library */
>>>  #ifndef __BPF_INSN_H
>>>  #define __BPF_INSN_H
>>
>> Got "address not found" for the following:
>>
>> Björn Töpel <bjorn.topel@intel.com>
>> Jakub Kicinski <jakub.kicinski@netronome.com>
>> Jiong Wang <jiong.wang@netronome.com>
>>
>> Trying again with different aliases from more recent commits for Björn
>> and Jakub.
>>
>> I cannot find other commits from Jiong with a different email address -
>> Jakub, do you happen to know how we can reach Jiong? Perhaps it's not
>> necessary as it's Netronome that owns the copyright and thus your ack
>> would cover both contributions?
> 
> Gentle ping. We got ACKs from Netronome and Google so far (thanks!).
> 

For my bits:

Acked-by: Daniel Mack <daniel@zonque.org>


Thanks,
Daniel


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646A11E657B
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 17:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403901AbgE1PG6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 11:06:58 -0400
Received: from www62.your-server.de ([213.133.104.62]:39948 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403787AbgE1PG6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 11:06:58 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jeK75-0001th-BD; Thu, 28 May 2020 17:06:31 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jeK74-000Ei1-Ul; Thu, 28 May 2020 17:06:30 +0200
Subject: Re: [PATCH] powerpc/bpf: Enable bpf_probe_read{, str}() on powerpc
 again
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Christoph Hellwig <hch@lst.de>, bpf@vger.kernel.org
References: <20200527122844.19524-1-pmladek@suse.com>
 <87ftbkkh00.fsf@mpe.ellerman.id.au> <20200528091351.GE3529@linux-b0ei>
 <87d06ojlib.fsf@mpe.ellerman.id.au>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <aace2e9e-c63c-a1a2-a1e1-c7a46904e8c5@iogearbox.net>
Date:   Thu, 28 May 2020 17:06:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87d06ojlib.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25826/Thu May 28 14:33:30 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/28/20 2:23 PM, Michael Ellerman wrote:
> Petr Mladek <pmladek@suse.com> writes:
>> On Thu 2020-05-28 11:03:43, Michael Ellerman wrote:
>>> Petr Mladek <pmladek@suse.com> writes:
>>>> The commit 0ebeea8ca8a4d1d453a ("bpf: Restrict bpf_probe_read{, str}() only
>>>> to archs where they work") caused that bpf_probe_read{, str}() functions
>>>> were not longer available on architectures where the same logical address
>>>> might have different content in kernel and user memory mapping. These
>>>> architectures should use probe_read_{user,kernel}_str helpers.
>>>>
>>>> For backward compatibility, the problematic functions are still available
>>>> on architectures where the user and kernel address spaces are not
>>>> overlapping. This is defined CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.
>>>>
>>>> At the moment, these backward compatible functions are enabled only
>>>> on x86_64, arm, and arm64. Let's do it also on powerpc that has
>>>> the non overlapping address space as well.
>>>>
>>>> Signed-off-by: Petr Mladek <pmladek@suse.com>
>>>
>>> This seems like it should have a Fixes: tag and go into v5.7?
>>
>> Good point:
>>
>> Fixes: commit 0ebeea8ca8a4d1d4 ("bpf: Restrict bpf_probe_read{, str}() only to archs where they work")
>>
>> And yes, it should ideally go into v5.7 either directly or via stable.
>>
>> Should I resend the patch with Fixes and
>> Cc: stable@vger.kernel.org #v45.7 lines, please?
> 
> If it goes into v5.7 then it doesn't need a Cc: stable, and I guess a
> Fixes: tag is nice to have but not so important as it already mentions
> the commit that caused the problem. So a resend probably isn't
> necessary.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> Daniel can you pick this up, or should I?

Yeah I'll take it into bpf tree for v5.7.

Thanks everyone,
Daniel

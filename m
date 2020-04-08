Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B681A192C
	for <lists+bpf@lfdr.de>; Wed,  8 Apr 2020 02:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgDHAP6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Apr 2020 20:15:58 -0400
Received: from www62.your-server.de ([213.133.104.62]:33280 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgDHAP5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Apr 2020 20:15:57 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jLyNl-0003Wt-MF; Wed, 08 Apr 2020 02:15:53 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jLyNl-000CZ7-Bb; Wed, 08 Apr 2020 02:15:53 +0200
Subject: Re: Question on "uaccess: Add strict non-pagefault kernel-space read
 function"
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        bgregg@netflix.com
References: <20200403133533.GA3424@infradead.org>
 <5ddc8c04-279d-9a14-eaa7-755467902ead@iogearbox.net>
 <20200404093105.GA445@infradead.org>
 <2adc77e1-e84d-f303-fd88-133ec950c33f@iogearbox.net>
 <20200407093357.GA24309@infradead.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <776e5c99-57c9-b61b-d466-412db440a859@iogearbox.net>
Date:   Wed, 8 Apr 2020 02:15:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200407093357.GA24309@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25775/Tue Apr  7 14:53:51 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/7/20 11:33 AM, Christoph Hellwig wrote:
> On Tue, Apr 07, 2020 at 11:03:23AM +0200, Daniel Borkmann wrote:
>>
>> ... where archs with non-overlapping user and kernel address range would
>> only end up having to implementing kernel_range_ok() check. Or, instead of
>> a generic kernel_range_ok() this could perhaps be more probing-specific as
>> in probe_kernel_range_ok() where this would then also cover the special
>> cases we seem to have in parisc and um. Then, this would allow to get rid
>> of all the __weak aliasing as well which may just be confusing. I could look
>> into coming up with something along these lines. Thoughts?
> 
> FYI, this is what I cooked up a few days ago:
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/maccess-fixups
> 
> Still misses the final work to switch probe_kernel_read to be the
> strict version.  Any good naming suggestion for the non-strict one?

Ah great, thanks for working on it including the cleanups in your branch above.
Good naming suggestion is usually the hardest ... ;-) Maybe adding an _unsafe or
_lax suffix ...

Regarding commits:

* http://git.infradead.org/users/hch/misc.git/commitdiff/019f5d7894711a8046d1d57640d3db47f690c61e

I think the extra HAVE_PROBE_KERNEL_ALLOWED / HAVE_PROBE_KERNEL_STRICT_ALLOWED
reads a bit odd. Could we simply have an equivalent for access_ok() that archs
implement under KERNEL_DS where it covers the allowed/restricted kernel-only range?
Like mentioned earlier e.g. probe_{user,kernel}_range_ok() helpers where the user
one defaults to access_ok() internally and the kernel one contains all the range
restrictions that archs can then define if needed (and if not there could be an
asm-generic `return true` fallback, for example).

* http://git.infradead.org/users/hch/misc.git/commitdiff/2d6070ac749d0af26367892545d1c288cc00823a

This would still need to set dst[0] = '\0' in that case to be consistent with
the other error handling cases there when count > 0.

Thanks,
Daniel

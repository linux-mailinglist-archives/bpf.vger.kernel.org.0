Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B29C91A09B4
	for <lists+bpf@lfdr.de>; Tue,  7 Apr 2020 11:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgDGJD3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Apr 2020 05:03:29 -0400
Received: from www62.your-server.de ([213.133.104.62]:44216 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgDGJD3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Apr 2020 05:03:29 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jLk8i-0002BD-Sf; Tue, 07 Apr 2020 11:03:24 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jLk8i-000BDN-Hp; Tue, 07 Apr 2020 11:03:24 +0200
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
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2adc77e1-e84d-f303-fd88-133ec950c33f@iogearbox.net>
Date:   Tue, 7 Apr 2020 11:03:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200404093105.GA445@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25774/Mon Apr  6 14:53:25 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/4/20 11:31 AM, Christoph Hellwig wrote:
> On Fri, Apr 03, 2020 at 04:20:24PM +0200, Daniel Borkmann wrote:
>> With crazy old functions I presume you mean the old bpf_probe_read()
>> which is mapped to BPF_FUNC_probe_read helper or something else entirely?
> 
> I couldn't care less about bpf, this is about the kernel API.
> 
> What I mean is that your new probe_kernel_read_strict and
> strncpy_from_unsafe_strict helpers are good and useful.  But for this
> to actually make sense we need to get rid of the non-strict versions,
> and we also need to get rid of some of the weak alias magic.

Yeah agree, the probe_kernel_read() should do the strict checks by default
and there would need to be some way to opt-out for the legacy helpers to
not break. So it would end up looking like the below ...

long __probe_kernel_read(void *dst, const void *src, size_t size)
{
         long ret = -EFAULT;
         mm_segment_t old_fs = get_fs();

         set_fs(KERNEL_DS);
         if (kernel_range_ok(src, size))
                 ret = probe_read_common(dst, (__force const void __user *)src, size);
         set_fs(old_fs);

         return ret;
}

... where archs with non-overlapping user and kernel address range would
only end up having to implementing kernel_range_ok() check. Or, instead of
a generic kernel_range_ok() this could perhaps be more probing-specific as
in probe_kernel_range_ok() where this would then also cover the special
cases we seem to have in parisc and um. Then, this would allow to get rid
of all the __weak aliasing as well which may just be confusing. I could look
into coming up with something along these lines. Thoughts?

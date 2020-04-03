Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3B9619D8DE
	for <lists+bpf@lfdr.de>; Fri,  3 Apr 2020 16:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgDCOUa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Apr 2020 10:20:30 -0400
Received: from www62.your-server.de ([213.133.104.62]:40646 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDCOUa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Apr 2020 10:20:30 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jKNBJ-0007Yy-8S; Fri, 03 Apr 2020 16:20:25 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jKNBI-000EqM-Uq; Fri, 03 Apr 2020 16:20:24 +0200
Subject: Re: Question on "uaccess: Add strict non-pagefault kernel-space read
 function"
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        bgregg@netflix.com
References: <20200403133533.GA3424@infradead.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5ddc8c04-279d-9a14-eaa7-755467902ead@iogearbox.net>
Date:   Fri, 3 Apr 2020 16:20:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200403133533.GA3424@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25770/Thu Apr  2 14:58:54 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Christoph,

On 4/3/20 3:35 PM, Christoph Hellwig wrote:
[...]
> I just stumbled over your above commit, and it really confuses me.
> 
> Not the newly added functions, which seems perfectly sane, but why you
> left the crazy old functions in place instead of investing a little
> bit of extra effort to clean the existing mess up and switch everyone
> to the sane new variants?

With crazy old functions I presume you mean the old bpf_probe_read()
which is mapped to BPF_FUNC_probe_read helper or something else entirely?

For the former, basically my main concern was that these would otherwise
break existing tools like bcc/bpftrace/.. unfortunately until they are not
converted over yet to _strict variants.

At least on x86, they would still rely on the broken semantic to probe
kernel and user memory with probe_read where it 'happens to work', but not
on other archs where the address space is not shared.

But once these are fixed, I would love to deprecate these in one way or
another. The warning in 00c42373d397 ("x86-64: add warning for non-canonical
user access address dereferences") should be a good incentive to switch
since people have been hitting it in production as the non-canonical space
is sometimes used in user space to tag pointers, for example.

Thanks,
Daniel

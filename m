Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399021D3FB3
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 23:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgENVKl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 17:10:41 -0400
Received: from www62.your-server.de ([213.133.104.62]:54352 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgENVKl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 May 2020 17:10:41 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jZL7m-0002wo-Pa; Thu, 14 May 2020 23:10:38 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jZL7m-000SGY-El; Thu, 14 May 2020 23:10:38 +0200
Subject: Re: [PATCH bpf 0/3] Restrict bpf_probe_read{,str}() and
 bpf_trace_printk()'s %s
To:     Christoph Hellwig <hch@lst.de>
Cc:     ast@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
        torvalds@linux-foundation.org, mhiramat@kernel.org,
        brendan.d.gregg@gmail.com, john.fastabend@gmail.com, yhs@fb.com
References: <20200514161607.9212-1-daniel@iogearbox.net>
 <20200514165802.GA3059@lst.de>
 <cb0749ab-e37b-6fe4-5830-a40fb4fca995@iogearbox.net>
 <20200514195813.GA14720@lst.de>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0b64dbdc-25f3-cfff-36f8-9b20a9d84707@iogearbox.net>
Date:   Thu, 14 May 2020 23:10:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200514195813.GA14720@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25812/Thu May 14 14:13:00 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/14/20 9:58 PM, Christoph Hellwig wrote:
> On Thu, May 14, 2020 at 09:54:06PM +0200, Daniel Borkmann wrote:
>> On 5/14/20 6:58 PM, Christoph Hellwig wrote:
>>> On Thu, May 14, 2020 at 06:16:04PM +0200, Daniel Borkmann wrote:
>>>> Small set of fixes in order to restrict BPF helpers for tracing which are
>>>> broken on archs with overlapping address ranges as per discussion in [0].
>>>> I've targetted this for -bpf tree so they can be routed as fixes. Thanks!
>>>
>>> Does that mean you are targeting them for 5.7?
>>
>> Yes, it would make most sense to me based on the discussion we had in the
>> other thread. If there is concern wrt latency we could route these to DaveM's
>> net tree in a timely manner (e.g. still tonight or so).
> 
> I don't think we should rush this too much.  I just want to make sure
> it either goes into 5.7 or that we have a coordinated tree that I can
> base the maccess series on.

Yep, makes sense, we'll target 5.7 for it.

Thanks,
Daniel

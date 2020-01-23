Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 092D91473BC
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 23:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAWWXl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 17:23:41 -0500
Received: from www62.your-server.de ([213.133.104.62]:45156 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgAWWXl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 17:23:41 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iuksy-000790-9r; Thu, 23 Jan 2020 23:23:36 +0100
Received: from [178.197.248.20] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1iuksx-000EkD-TE; Thu, 23 Jan 2020 23:23:35 +0100
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
To:     Daniel Xu <dxu@dxuuu.xyz>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
References: <C03FZ2ZXKIY9.21PQ3FP3MQYU7@dlxu-fedora-R90QNFJV>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <297f40e7-667b-63ea-c7d7-6d03a636c4c7@iogearbox.net>
Date:   Thu, 23 Jan 2020 23:23:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <C03FZ2ZXKIY9.21PQ3FP3MQYU7@dlxu-fedora-R90QNFJV>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25704/Thu Jan 23 12:37:43 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/23/20 9:09 PM, Daniel Xu wrote:
> Hi John, thanks for looking.
> 
> On Wed Jan 22, 2020 at 9:39 PM, John Fastabend wrote:
> [...]
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 033d90a2282d..7350c5be6158 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -2885,6 +2885,16 @@ union bpf_attr {
>>>    *		**-EPERM** if no permission to send the *sig*.
>>>    *
>>>    *		**-EAGAIN** if bpf program can try again.
>>> + *
>>> + * int bpf_perf_prog_read_branches(struct bpf_perf_event_data *ctx, void *buf, u32 buf_size)
>>> + * 	Description
>>> + * 		For en eBPF program attached to a perf event, retrieve the
>>> + * 		branch records (struct perf_branch_entry) associated to *ctx*
>>> + * 		and store it in	the buffer pointed by *buf* up to size
>>> + * 		*buf_size* bytes.
>>
>> It seems extra bytes in buf will be cleared. The number of bytes
>> copied is returned so I don't see any reason to clear the extra bytes I
>> would
>> just let the BPF program do this if they care. But it should be noted in
>> the description at least.
> 
> In include/linux/bpf.h:
> 
>          /* the following constraints used to prototype bpf_memcmp() and other
>           * functions that access data on eBPF program stack
>           */
>          ARG_PTR_TO_UNINIT_MEM,  /* pointer to memory does not need to be initialized,
>                                   * helper function must fill all bytes or clear
>                                   * them in error case.
>                                   */
> 
> I figured it would be good to clear out the stack b/c this helper
> writes data on program stack.
> 
> Also bpf_perf_prog_read_value() does something similar (fill zeros on
> failure).
> 
> [...]
>>> +	to_copy = min_t(u32, br_stack->nr * sizeof(struct perf_branch_entry), size);
>>> +	to_clear -= to_copy;
>>> +
>>> +	memcpy(buf, br_stack->entries, to_copy);
>>> +	err = to_copy;
>>> +clear:
>>> +	memset(buf + to_copy, 0, to_clear);
>>
>>
>> Here, why do this at all? If the user cares they can clear the bytes
>> directly from the BPF program. I suspect its probably going to be
>> wasted work in most cases. If its needed for some reason provide
>> a comment with it.
> 
> Same concern as above, right?

Yes, so we've been following this practice for all the BPF helpers no matter
which program type. Though for tracing it may be up to debate whether it makes
still sense given there's nothing to be leaked here since you can read this data
anyway via probe read if you'd wanted to. So we might as well get rid of the
clearing for all tracing helpers.

Different question related to your set. It looks like br_stack is only available
on x86, is that correct? For other archs this will always bail out on !br_stack
test. Perhaps we should document this fact so users are not surprised why their
prog using this helper is not working on !x86. Wdyt?

Thanks,
Daniel


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68042CF47E
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 20:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgLDTEX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 14:04:23 -0500
Received: from www62.your-server.de ([213.133.104.62]:56666 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDTEX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 14:04:23 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1klGMn-0000ZR-Iz; Fri, 04 Dec 2020 20:03:41 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1klGMn-000D50-Cp; Fri, 04 Dec 2020 20:03:41 +0100
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Expose bpf_get_socket_cookie to
 tracing programs
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Florent Revest <revest@chromium.org>, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, kpsingh@chromium.org,
        revest@google.com, linux-kernel@vger.kernel.org
References: <20201203213330.1657666-1-revest@google.com>
 <bdd7153b-4bf9-12dd-5950-df0ebe91659d@iogearbox.net>
Message-ID: <7c70a64f-1aba-0e11-983d-9338f25a367e@iogearbox.net>
Date:   Fri, 4 Dec 2020 20:03:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <bdd7153b-4bf9-12dd-5950-df0ebe91659d@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26007/Thu Dec  3 14:13:31 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/4/20 7:56 PM, Daniel Borkmann wrote:
> On 12/3/20 10:33 PM, Florent Revest wrote:
>> This creates a new helper proto because the existing
>> bpf_get_socket_cookie_sock_proto has a ARG_PTR_TO_CTX argument and only
>> works for BPF programs where the context is a sock.
>>
>> This helper could also be useful to other BPF program types such as LSM.
>>
>> Signed-off-by: Florent Revest <revest@google.com>
>> ---
>>   include/uapi/linux/bpf.h       | 7 +++++++
>>   kernel/trace/bpf_trace.c       | 4 ++++
>>   net/core/filter.c              | 7 +++++++
>>   tools/include/uapi/linux/bpf.h | 7 +++++++
>>   4 files changed, 25 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index c3458ec1f30a..3e0e33c43998 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1662,6 +1662,13 @@ union bpf_attr {
>>    *     Return
>>    *         A 8-byte long non-decreasing number.
>>    *
>> + * u64 bpf_get_socket_cookie(void *sk)
>> + *     Description
>> + *         Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
>> + *         *sk*, but gets socket from a BTF **struct sock**.
>> + *     Return
>> + *         A 8-byte long non-decreasing number.
> 
> I would not mention this here since it's not fully correct and we should avoid users
> taking non-decreasing granted in their progs. The only assumption you can make is
> that it can be considered a unique number. See also [0] with reverse counter..
> 
>    [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=92acdc58ab11af66fcaef485433fde61b5e32fac

One more thought, in case you plan to use this from sleepable context, you would
need to use sock_gen_cookie() variant in the BPF helper instead.

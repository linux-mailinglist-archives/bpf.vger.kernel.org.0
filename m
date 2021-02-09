Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A347731451E
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 01:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhBIAyu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 19:54:50 -0500
Received: from www62.your-server.de ([213.133.104.62]:59190 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhBIAys (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 19:54:48 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1l9HHz-000A5j-TM; Tue, 09 Feb 2021 01:53:59 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1l9HHz-000Nu1-Nn; Tue, 09 Feb 2021 01:53:59 +0100
Subject: Re: [PATCH v2 bpf-next 1/7] bpf: Optimize program stats
To:     Alexei Starovoitov <ast@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     bpf@vger.kernel.org, kernel-team@fb.com
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
 <20210206170344.78399-2-alexei.starovoitov@gmail.com>
 <ae1b3d4b-59fd-4ad2-1e72-f9d987250757@iogearbox.net>
 <49f8a832-43a1-74c8-25b4-b66c8a3014be@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <30c74011-4958-985e-cab5-2a5ce56a3866@iogearbox.net>
Date:   Tue, 9 Feb 2021 01:53:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <49f8a832-43a1-74c8-25b4-b66c8a3014be@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26074/Mon Feb  8 13:20:40 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/9/21 12:13 AM, Alexei Starovoitov wrote:
> On 2/8/21 1:28 PM, Daniel Borkmann wrote:
>> On 2/6/21 6:03 PM, Alexei Starovoitov wrote:
[...]
>>> @@ -539,6 +540,12 @@ struct bpf_binary_header {
>>>       u8 image[] __aligned(BPF_IMAGE_ALIGNMENT);
>>>   };
>>> +struct bpf_prog_stats {
>>> +    u64 cnt;
>>> +    u64 nsecs;
>>> +    struct u64_stats_sync syncp;
>>> +} __aligned(2 * sizeof(u64));
>>> +
>>>   struct bpf_prog {
>>>       u16            pages;        /* Number of allocated pages */
>>>       u16            jited:1,    /* Is our filter JIT'ed? */
>>> @@ -559,6 +566,7 @@ struct bpf_prog {
>>>       u8            tag[BPF_TAG_SIZE];
>>>       struct bpf_prog_aux    *aux;        /* Auxiliary fields */
>>>       struct sock_fprog_kern    *orig_prog;    /* Original BPF program */
>>> +    struct bpf_prog_stats __percpu *stats;
>>>       unsigned int        (*bpf_func)(const void *ctx,
>>>                           const struct bpf_insn *insn);
>>
>> nit: could we move aux & orig_prog while at it behind bpf_func just to avoid it slipping
>> into next cacheline by accident when someone extends this again?
> 
> I don't understand what moving aux+orig_prog after bpf_func will do.
> Currently it's this:
> struct bpf_prog_aux *      aux;                  /*    32     8 */
> struct sock_fprog_kern *   orig_prog;            /*    40     8 */
> unsigned int               (*bpf_func)(const void  *, const struct bpf_insn  *); /*    48     8 */
> 
> With stats and active pointers the bpf_func goes into 2nd cacheline.
> In the past the motivation for bpf_func right next to insns were
> due to interpreter. Now everyone has JIT on. The interpreter
> is often removed from .text too. So having insn and bpf_func in
> the same cache line is not important.

Yeah that's not what I meant, the interpreter case is less important.

> Whereas having bpf_func with stats and active could be important
> if stats/active are also used in other places than fexit/fentry.
> For this patch set bpf_func location is irrelevant, since the
> prog addr is hardcoded inside bpf trampoline generated asm.
> For the best speed only stats and active should be close to each other.
> And they both will be in the 1st.

I meant to say that it's zero effort to move aux/orig_prog behind the
bpf_func, so stats/active/bpf_func can still be on same cacheline. Yes,
it's potentially less important with dispatcher being up to 64, but
still more relevant to fast path than aux/orig_prog. Also for non-x86
case.

>>> @@ -249,7 +249,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
>>>       if (fp->aux) {
>>>           mutex_destroy(&fp->aux->used_maps_mutex);
>>>           mutex_destroy(&fp->aux->dst_mutex);
>>> -        free_percpu(fp->aux->stats);
>>> +        free_percpu(fp->stats);
>>
>> This doesn't look correct, stats is now /not/ tied to fp->aux anymore which this if block
>> is taking care of freeing. It needs to be moved outside so we don't leak fp->stats.
> 
> Great catch. thanks!


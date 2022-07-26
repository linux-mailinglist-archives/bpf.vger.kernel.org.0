Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD915811CF
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 13:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbiGZLUN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 07:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiGZLUE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 07:20:04 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF383244A
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 04:20:03 -0700 (PDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oGIbY-0009Zn-IR; Tue, 26 Jul 2022 13:20:00 +0200
Received: from [2a01:118f:505:3400:57f9:d43a:5622:24a8] (helo=linux-4.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oGIbY-000IeF-9r; Tue, 26 Jul 2022 13:20:00 +0200
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Fix bpf_xdp_pointer return pointer
To:     Joanne Koong <joannelkoong@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <20220722220105.2065466-1-joannelkoong@gmail.com>
 <20220725201658.t55raspwmj2eguek@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1ac5GzwCL_ZSGcX9nPqokJG63K2khjKbgW5maYm66mLPw@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d76023cb-aeb5-59fc-e987-65db550aac97@iogearbox.net>
Date:   Tue, 26 Jul 2022 13:19:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAJnrk1ac5GzwCL_ZSGcX9nPqokJG63K2khjKbgW5maYm66mLPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26613/Tue Jul 26 09:56:56 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/25/22 11:55 PM, Joanne Koong wrote:
> On Mon, Jul 25, 2022 at 1:17 PM Martin KaFai Lau <kafai@fb.com> wrote:
>>
>> On Fri, Jul 22, 2022 at 03:01:05PM -0700, Joanne Koong wrote:
>>> For the case where offset + len == size, bpf_xdp_pointer should return a
>>> valid pointer to the addr because that access is permitted. We should
>>> only return NULL in the case where offset + len exceeds size.
>>>
>>> Fixes: 3f364222d032 ("net: xdp: introduce bpf_xdp_pointer utility routine")
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> ---
>>>   net/core/filter.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>> index 289614887ed5..4307a75eeb4c 100644
>>> --- a/net/core/filter.c
>>> +++ b/net/core/filter.c
>>> @@ -3918,7 +3918,7 @@ static void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len)
>>>                offset -= frag_size;
>>>        }
>>>   out:
>>> -     return offset + len < size ? addr + offset : NULL;
>>> +     return offset + len <= size ? addr + offset : NULL;
>> This fix should be for the bpf tree.
> Ah I see. To confirm my understanding, fixes should always go to the
> bpf tree (unless it's fixing a patch that only resides in the bpf-next
> tree), correct?

Yes, correct. Given we're really late in the cycle with rc8 my preference is to
only queue really urgent fixes to bpf tree at this point. This one I just took
to bpf-next given merge window is opening this Sun, thus this will go to Linus'
tree with just few days offset anyway.

Thanks,
Daniel

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B51B5AB491
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 16:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbiIBO6Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 10:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbiIBO5s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 10:57:48 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7A71115C
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 07:22:51 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oU6gP-0006EO-KG; Fri, 02 Sep 2022 15:26:05 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oU6gP-000Sl2-Cb; Fri, 02 Sep 2022 15:26:05 +0200
Subject: Re: [PATCH bpf-next 1/2] bpf: Support getting tunnel flags
To:     Shmulik Ladkani <shmulik@metanetworks.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
References: <20220831144010.174110-1-shmulik.ladkani@gmail.com>
 <3b4e74bb-5ede-e773-69e6-6c272ffa2459@iogearbox.net>
 <20220901091040.2fcd73af@blondie>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e74b6ed1-82e0-c4f9-8b2d-7aca3ab6e41f@iogearbox.net>
Date:   Fri, 2 Sep 2022 15:26:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220901091040.2fcd73af@blondie>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26646/Fri Sep  2 09:55:25 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/1/22 8:10 AM, Shmulik Ladkani wrote:
> On Wed, 31 Aug 2022 22:46:15 +0200
> Daniel Borkmann <daniel@iogearbox.net> wrote:
> 
>> The bpf_skb_set_tunnel_key() helper has a number of flags we pass in, e.g.
>> BPF_F_ZERO_CSUM_TX, BPF_F_DONT_FRAGMENT, BPF_F_SEQ_NUMBER, and then based on
>> those flags we set:
>>
>>     [...]
>>     info->key.tun_flags = TUNNEL_KEY | TUNNEL_CSUM | TUNNEL_NOCACHE;
>>     if (flags & BPF_F_DONT_FRAGMENT)
>>             info->key.tun_flags |= TUNNEL_DONT_FRAGMENT;
>>     if (flags & BPF_F_ZERO_CSUM_TX)
>>             info->key.tun_flags &= ~TUNNEL_CSUM;
>>     if (flags & BPF_F_SEQ_NUMBER)
>>             info->key.tun_flags |= TUNNEL_SEQ;
>>     [...]
>>
>> Should we similarly only expose those which are interesting/relevant to BPF
>> program authors as a __u16 tunnel_flags and not the whole set? Which ones
>> do you have a need for? TUNNEL_SEQ, TUNNEL_CSUM, TUNNEL_KEY, and then the
>> TUNNEL_OPTIONS_PRESENT?
> 
> Indeed, I noticed this and considered various approaches:
> 
> 1. Convert the "interesting" internal TUNNEL_xxx flags back to BPF_F_yyy
> and place into the new 'tunnel_flags' field.
> This has 2 drawbacks:
>   - The BPF_F_yyy flags are from *set_tunnel_key* enumeration space,
>     e.g. BPF_F_ZERO_CSUM_TX.
>     I find it awkward that it is "returned" into tunnel_flags from a
>     *get_tunnel_key* call.
>   - Not all "interesting" TUNNEL_xxx flags can be mapped to existing
>     BPF_F_yyy flags, and it doesn't make sense to create new BPF_F_yyy
>     flags just for purposes of the returned tunnel_flags.
> 
> 2. Place key.tun_flags into 'tunnel_flags' but mask them, keeping only
>     "interesting" flags.
>     That's ok, but the drawback is that what's "intersting" for my
>     usecase might be limiting for other usecases.
> 
> Therefore I decided to expose what's in key.tun_flags *as is*, which seems
> most flexible. The bpf user can just choose to ingore bits he's not
> interested in. The TUNNEL_xxx are uapi, so no harm exposing them back in
> the get_tunnel_key call.
> 
> WDYT?

Yes, the argumentation sounds reasonable to me. I've added this note to the
commit message to reflect the design decision, and applied it to bpf-next.

Thanks Shmulik!

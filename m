Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CF15AB490
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 16:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbiIBO6Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 10:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbiIBO5s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 10:57:48 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F3DAE4A
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 07:22:53 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oU65Y-000C5F-GN; Fri, 02 Sep 2022 14:48:00 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oU65Y-000B5y-7e; Fri, 02 Sep 2022 14:48:00 +0200
Subject: Re: [RFC bpf-next 1/2] bpf: tnums: warn against the usage of
 tnum_in(tnum_range(), ...)
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
References: <20220831031907.16133-1-shung-hsi.yu@suse.com>
 <20220831031907.16133-2-shung-hsi.yu@suse.com>
 <0f6d7f97-8cd9-d513-368b-39706dd6b06a@iogearbox.net>
 <YxF984GIloJWnV9x@syu-laptop>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <615a2102-2244-f0be-6375-16cf795715ef@iogearbox.net>
Date:   Fri, 2 Sep 2022 14:47:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <YxF984GIloJWnV9x@syu-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26646/Fri Sep  2 09:55:25 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/2/22 5:52 AM, Shung-Hsi Yu wrote:
> On Thu, Sep 01, 2022 at 05:00:58PM +0200, Daniel Borkmann wrote:
>> On 8/31/22 5:19 AM, Shung-Hsi Yu wrote:
>>> Commit a657182a5c51 ("bpf: Don't use tnum_range on array range checking
>>> for poke descriptors") has shown that using tnum_range() as argument to
>>> tnum_in() can lead to misleading code that looks like tight bound check
>>> when in fact the actual allowed range is much wider.
>>>
>>> Document such behavior to warn against its usage in general, and suggest
>>> some scenario where result can be trusted.
>>>
>>> Link: https://lore.kernel.org/bpf/984b37f9fdf7ac36831d2137415a4a915744c1b6.1661462653.git.daniel@iogearbox.net/
>>> Link: https://www.openwall.com/lists/oss-security/2022/08/26/1
>>> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
>>
>> Any objections from your side if I merge this? Thanks for adding doc. :)
> 
> There is a small typo I meant to fix with s/including/include below.
> 
> Other than that, none at all, thanks! :)

Fixed up and applied to bpf-next, thanks!

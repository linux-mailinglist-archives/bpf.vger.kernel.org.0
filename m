Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C80D67B8DB
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 18:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjAYR5H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 12:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYR5G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 12:57:06 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3BA5421F
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 09:57:05 -0800 (PST)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pKk18-000AOm-5r; Wed, 25 Jan 2023 18:57:02 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pKk17-0003z8-V6; Wed, 25 Jan 2023 18:57:01 +0100
Subject: Re: [PATCH bpf-next] bpftool: disable bpfilter kernel config checks
To:     Quentin Monnet <quentin@isovalent.com>,
        Chethan Suresh <chethan.suresh@sony.com>, bpf@vger.kernel.org
Cc:     Kenta Tada <Kenta.Tada@sony.com>, Quentin Deslandes <qde@naccy.de>
References: <20230125025516.5603-1-chethan.suresh@sony.com>
 <2e84c348-c07d-8028-d099-a73bcfba4a09@isovalent.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2da59c17-dead-9cd7-0b21-3cc59b4ef9b7@iogearbox.net>
Date:   Wed, 25 Jan 2023 18:57:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2e84c348-c07d-8028-d099-a73bcfba4a09@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26792/Wed Jan 25 09:49:26 2023)
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/25/23 11:33 AM, Quentin Monnet wrote:
> 2023-01-25 08:25 UTC+0530 ~ Chethan Suresh <chethan.suresh@sony.com>
>> We've experienced similar issues about bpfilter like below:
>> https://github.com/moby/moby/issues/43755
>> https://lore.kernel.org/bpf/CAADnVQJ5MxGkq=ng214aYoH-NmZ1gjoS=ZTY1eU-Fag4RwZjdg@mail.gmail.com/
>>
>> Considering the current development status of bpfilter,
>> disable bpfilter kernel config checks in bpftool feature.
>> For production system, we should disable both
>> CONFIG_BPFILTER and CONFIG_BPFILTER_UMH for now.
>> Or can be enabled as some tools depend on bpfilter.
>>
>> Signed-off-by: Chethan Suresh <chethan.suresh@sony.com>
>> Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
>> ---
>>   tools/bpf/bpftool/feature.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
>> index 36cf0f1517c9..c6087bbc6613 100644
>> --- a/tools/bpf/bpftool/feature.c
>> +++ b/tools/bpf/bpftool/feature.c
>> @@ -426,10 +426,6 @@ static void probe_kernel_image_config(const char *define_prefix)
>>   		{ "CONFIG_BPF_STREAM_PARSER", },
>>   		/* xt_bpf module for passing BPF programs to netfilter  */
>>   		{ "CONFIG_NETFILTER_XT_MATCH_BPF", },
>> -		/* bpfilter back-end for iptables */
>> -		{ "CONFIG_BPFILTER", },
>> -		/* bpftilter module with "user mode helper" */
>> -		{ "CONFIG_BPFILTER_UMH", },

Right, for bpftool this change is rather moot. Maybe until the work from
QuentinD materializes, the BPFILTER should just be built with `depends on
COMPILE_TEST` so that this doesn't negatively affect users as reported in
above links.

>>   
>>   		/* test_bpf module for BPF tests */
>>   		{ "CONFIG_TEST_BPF", },
> 
> Hi,
> I don't understand. The feature probe simply looks for the kconfig
> option in the kconfig file. What are you hoping to achieve by removing
> this check? How is it going to help with your issues?
> 
> Quentin
> 


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC16E4BBD22
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 17:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiBRQOy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 11:14:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbiBRQOy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 11:14:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9E01A3762
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 08:14:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4F5B91F380;
        Fri, 18 Feb 2022 16:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645200876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KY6zbDS5Qw1q9IenTlcjGc9l1ESRcLVfbNg8efkstZE=;
        b=qFBQ15wK0tjfwNQWTc4bXn1hpBOb+8p/GJIzR4GkFBeqTYSkiUhVvdwe5h8MKAAVHhxekQ
        XeimiZtSocZOJg4outvsXIpzirC5DSUJrAmN1mbQlmRAMzuRqvPotf6M4jteTu8qCIE4Ce
        Qtr/nTMqP6sTyxGmPD+GSlVeeVKvBTI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0650313CA1;
        Fri, 18 Feb 2022 16:14:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WskGOuvFD2IAOgAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 18 Feb 2022 16:14:35 +0000
Message-ID: <dee15742-da4b-1622-8c0a-cc95a6c7ee91@suse.com>
Date:   Fri, 18 Feb 2022 18:14:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] bpftool: Allow building statically
Content-Language: en-US
To:     Quentin Monnet <quentin@isovalent.com>, andrii@kernel.org
Cc:     ast@kernel.org, bpf@vger.kernel.org
References: <20220217120435.2245447-1-nborisov@suse.com>
 <8c890e30-d701-0da4-c6f9-f5ca7d80d7ee@isovalent.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <8c890e30-d701-0da4-c6f9-f5ca7d80d7ee@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 18.02.22 г. 18:08 ч., Quentin Monnet wrote:
> 2022-02-17 14:04 UTC+0200 ~ Nikolay Borisov <nborisov@suse.com>
>> Sometime it can be useful to haul around a statically built version of
>> bpftool. Simply add support for passing STATIC=1 while building to build
>> the tool statically.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>
>> Currently the bpftool being distributed as part of libbpf-tools under bcc project
>> is dynamically built on a system using GLIBC 2.28, this makes the tool unusable on
>> ubuntu 18.04 for example. Perhaps after this patch has landed the bpftool in bcc
>> can be turned into a static binary.
>>
>>   tools/bpf/bpftool/Makefile | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>> index 83369f55df61..835621e215e4 100644
>> --- a/tools/bpf/bpftool/Makefile
>> +++ b/tools/bpf/bpftool/Makefile
>> @@ -13,6 +13,10 @@ else
>>     Q = @
>>   endif
>>
>> +ifeq ($(STATIC),1)
>> +	CFLAGS += --static
>> +endif
>> +
>>   BPF_DIR = $(srctree)/tools/lib/bpf
>>
>>   ifneq ($(OUTPUT),)
>> --
>> 2.25.1
>>
> 
> Why not just pass the flag on the command line? I don't think the
> Makefile overwrites it:
> 
>      $ CFLAGS=--static make

Yeah, this also works, I initially thought that overriding a variable on 
the command line would require having the override directive in the 
makefile but apparently is not the case. I guess this patch can be 
scratched.

> 
> Quentin
> 

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938A34FFE6A
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 21:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbiDMTGv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 15:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiDMTGm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 15:06:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61DD1102
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 12:04:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5DAE71FCFD;
        Wed, 13 Apr 2022 19:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649876657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZR9Ychf8LiOZHmixJRr8xCakw8pil8rogxTWLyj1vk=;
        b=MiW1o9H5HU7yHYkYbnHsyOgrKfCW9H5Oif0UgMOXWesRx7eYNMgwED4B4NETxiq0/zgNOB
        Bm0IyuhVLGoTvRRcF7QhSzyHCVo7KX4X5cY5vnuhUXmfR9fG9ixrEZK60r91vi7Z3a+zN0
        blzU286A0CC4VEL/15hukgBpQOAHdhA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2325413A91;
        Wed, 13 Apr 2022 19:04:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id amiABbEeV2LjfwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 13 Apr 2022 19:04:17 +0000
Message-ID: <960ea765-5c2c-c21d-5c8c-4f9bb26d5536@suse.com>
Date:   Wed, 13 Apr 2022 22:04:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Error validating array access
Content-Language: en-US
To:     Zvi Effron <zeffron@riotgames.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
References: <ceeb6831-7b2e-440b-69d9-3b46c7320b3c@suse.com>
 <CAEf4BzY6NXqsOVLLiaoGS2vv7S2eNeP1BQFh9cbPffJbf-2X5Q@mail.gmail.com>
 <7e7b5534-934c-f0fc-11c0-1d00560a4100@suse.com>
 <CAC1LvL2VZoik563Z8N_o49hyTA37iLsHi+O-gM7x8_rfrWth=w@mail.gmail.com>
 <28743474-02be-950f-a0ed-cd8fec42ca85@suse.com>
 <CAC1LvL2YpBZxt33bnmHsTYRDbZwSwvPxLP251YrPZRQXDOANOA@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <CAC1LvL2YpBZxt33bnmHsTYRDbZwSwvPxLP251YrPZRQXDOANOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 13.04.22 г. 20:29 ч., Zvi Effron wrote:
> On Wed, Apr 13, 2022 at 12:08 AM Nikolay Borisov <nborisov@suse.com> wrote:
>>
>> <snip>
>>>>>>             // Add this dentry name to path
>>>>>>             struct qstr d_name = BPF_CORE_READ(dentry, d_name);
>>>>>>             // Ensure path is no longer than PATH_MAX-1 and copy the terminating NULL
>>>>>>             unsigned int len = (d_name.len+1) & (PATH_MAX-1);
>>>>>>             // Start writing from the end of the buffer
>>>>>>             unsigned int off = buf_off - len;
>>>>>>             // Is string buffer big enough for dentry name?
>>>>>>             int sz = 0;
>>>>>>             // verify no wrap occurred
>>>>>>             if (off <= buf_off)
>>>>>>                 sz = bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (void *)d_name.name);
>>>>>>             else
>>>>>>                 break;
>>>>>>
>>>>>>             if (sz > 1) {
>>>>>>                 buf_off -= 1; // replace null byte termination with slash sign
>>>>>>                 bpf_probe_read(&(string_p->buf[IDX(buf_off)]), 1, &slash);
>>>>>>                 buf_off -= sz - 1;
>>>
>>> Isn't it (theoretically) possible for this to underflow? What happens if
>>> sz > 1 and sz >= buf_off?
>>
>> No, because sz is bounded by len since bpf_probe_read_kernel_str would
>> copy at most len -1 bytes as per description of the function. Since
>> we've ensured len is smaller than buff_off (due to off <= buf_off check)
>> then sz is also guaranteed to be less than buf_off.
>>
>> <snip>
>>
> 
> That's in a single iteration, though. Each iteration, sz can be 4095 (when
> len = PATH_MAX - 1). buff_off can be reduced by up to 4095 (1 + sz - 1). Your
> loop allows 20 iterations, which would be a total adjustment to buff_off of
> 77,786 before the last iteration. This would cause buff_off to underflow (it
> starts at 32767).

But in the last iteration it would result in an underflow which means 
we'd go into the else arm and break.

> 
>>>>> IDX(off) is bounded, but verifier needs to be sure that `off + len`
>>>>> never goes beyond map value. so you should make sure and prove off <=
>>>>> MAX_PERCPU_BUFSIZE - PATH_MAX. Verifier actually caught a real bug for
>>>>
>>>> But that is guaranteed since off = buff_off - len, and buf_off is
>>>> guaranteed to be at most MAX_PERCPU_BUFSIZE -1, meaning off is in the
>>>> worst case MAX_PERCPU_BUFSIZE - len  so the map value access can't go
>>>> beyond the end ?
>>>>
>>>
>>> If there's underflow in the calculation of buff_off (see above) then
>>> buff_off > MAX_PERCPU_BUFSIZE - 1. Which makes off no longer bounded by
>>> MAX_PERCPU_BUFSIZE - len, and it could exceed MAX_PERCPU_BUFSIZE.
>>
>> As per my rationale above I don't think buf_off can underflow.
>>
>>>
>>
>> <snip>
> 

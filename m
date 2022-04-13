Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1708D4FF05E
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 09:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiDMHKd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 03:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiDMHKc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 03:10:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018E32612D
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 00:08:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B8DBB1F37C;
        Wed, 13 Apr 2022 07:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649833686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z+S6Ci8gmygYXmIiHHcH56nlPSzJHiQrnlB+7fit9XA=;
        b=cB4UqkAV6K6qDc6Q1LcrbiAXl6q2GmTZa776ERj3D5zKb152HG6ohwxzrzFrXM//uzDRvp
        a6cTGgbN0GfyFn5A+1+u60qBfX2avRX1vNt07iV9xda/I8jAlkE2vxRVIICN4yQ8FBRb4B
        vfAidDYkpq4J/+2ArI+X1jk6hZO6TwQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FAFF13A91;
        Wed, 13 Apr 2022 07:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5WxDHNZ2VmILXQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 13 Apr 2022 07:08:06 +0000
Message-ID: <28743474-02be-950f-a0ed-cd8fec42ca85@suse.com>
Date:   Wed, 13 Apr 2022 10:08:05 +0300
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
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <CAC1LvL2VZoik563Z8N_o49hyTA37iLsHi+O-gM7x8_rfrWth=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

<snip>
>>>>            // Add this dentry name to path
>>>>            struct qstr d_name = BPF_CORE_READ(dentry, d_name);
>>>>            // Ensure path is no longer than PATH_MAX-1 and copy the terminating NULL
>>>>            unsigned int len = (d_name.len+1) & (PATH_MAX-1);
>>>>            // Start writing from the end of the buffer
>>>>            unsigned int off = buf_off - len;
>>>>            // Is string buffer big enough for dentry name?
>>>>            int sz = 0;
>>>>            // verify no wrap occurred
>>>>            if (off <= buf_off)
>>>>                sz = bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (void *)d_name.name);
>>>>            else
>>>>                break;
>>>>
>>>>            if (sz > 1) {
>>>>                buf_off -= 1; // replace null byte termination with slash sign
>>>>                bpf_probe_read(&(string_p->buf[IDX(buf_off)]), 1, &slash);
>>>>                buf_off -= sz - 1;
> 
> Isn't it (theoretically) possible for this to underflow? What happens if
> sz > 1 and sz >= buf_off?

No, because sz is bounded by len since bpf_probe_read_kernel_str would 
copy at most len -1 bytes as per description of the function. Since 
we've ensured len is smaller than buff_off (due to off <= buf_off check) 
then sz is also guaranteed to be less than buf_off.

<snip>

>>> IDX(off) is bounded, but verifier needs to be sure that `off + len`
>>> never goes beyond map value. so you should make sure and prove off <=
>>> MAX_PERCPU_BUFSIZE - PATH_MAX. Verifier actually caught a real bug for
>>
>> But that is guaranteed since off = buff_off - len, and buf_off is
>> guaranteed to be at most MAX_PERCPU_BUFSIZE -1, meaning off is in the
>> worst case MAX_PERCPU_BUFSIZE - len  so the map value access can't go
>> beyond the end ?
>>
> 
> If there's underflow in the calculation of buff_off (see above) then
> buff_off > MAX_PERCPU_BUFSIZE - 1. Which makes off no longer bounded by
> MAX_PERCPU_BUFSIZE - len, and it could exceed MAX_PERCPU_BUFSIZE.

As per my rationale above I don't think buf_off can underflow.

> 

<snip>

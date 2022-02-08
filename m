Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38674ADE88
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 17:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238504AbiBHQpW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 11:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiBHQpW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 11:45:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7585BC061576
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 08:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644338720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5lOEVjNknib7wHEhgUA05PCUgecUN0uwYe1Y6Kz5A9Y=;
        b=M2qBhOvIV5NjFjKWcsfU8xxWARveaYlOJkrOYM/xYYez/3bNSmBC28UUIm2bnfkipx7wi3
        MADD9NST7NFJDI3tHqjHOnncyZsWKNHH6Lam7svaneXbB0B3k1VLNNbdWPO6t9XtW38WHh
        nPvdLgU7pdfW1R0O6r3BEJxMuGOB/SE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-3iBPVbHJNz6J62FR26c4cA-1; Tue, 08 Feb 2022 11:45:19 -0500
X-MC-Unique: 3iBPVbHJNz6J62FR26c4cA-1
Received: by mail-wm1-f72.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so780381wmj.5
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 08:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5lOEVjNknib7wHEhgUA05PCUgecUN0uwYe1Y6Kz5A9Y=;
        b=5AGYZw23iFzomLSs66AlGxSnpRlIdF/B1JnmrkZMbAH0Njgyz2KukcxqcHig4nuROL
         umKU2DtSOOz1Eq63oe7OeI8osz1E9fK01eXhmubXW2sUidSR3UeOEqCfk7h8ULqbPu87
         dasRluG2snsWB2jn462Ul5HvJ6bD11zngvw78saVpnK4OADvexrNgvwBdLacBQpv3LOd
         A1o+eE95Qgdm77KIeKcFocOBB4Qbpud6UshjCqN2noNcGVxwJuHKUCOiRKm2SYmkY9+u
         rcqCSyW0r7+GADpqv0XnDipY2B2pA6Mt2BOkYmvQ2pGTpyE7eP1t4IGbuHHhc1InAqUt
         vEuw==
X-Gm-Message-State: AOAM533drCWNGyxs2hCVe1zM54uB3BjmPPSW4shr87wvQ6aHonsNYZNY
        xdh8J/3pQieHAB8NLONoDnob7JVDhMSrwyAlnrWqKTA6vaRa2RFE1nntKbyAGIfU4yNyR5jWXkG
        n/AYzN5Icjr58
X-Received: by 2002:a05:600c:889:: with SMTP id l9mr1829851wmp.79.1644338716995;
        Tue, 08 Feb 2022 08:45:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnkM4UDoqyqku4XrCRQlAicIC3iSn8gaDyfipLiEfKZOLlCVFhVABpYPgbYPQt+G7qLnV1Bg==
X-Received: by 2002:a05:600c:889:: with SMTP id l9mr1829598wmp.79.1644338715288;
        Tue, 08 Feb 2022 08:45:15 -0800 (PST)
Received: from ?IPV6:2001:9e8:3210:9700:5a4c:461:df06:d1a5? ([2001:9e8:3210:9700:5a4c:461:df06:d1a5])
        by smtp.gmail.com with ESMTPSA id i2sm3305209wmq.23.2022.02.08.08.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 08:45:14 -0800 (PST)
Message-ID: <38889612-9aca-de7e-d7d8-039131a82700@redhat.com>
Date:   Tue, 8 Feb 2022 17:45:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH bpf-next] bpf: Do not try bpf_msg_push_data with len 0
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org
References: <05989b20a8793d1ee1fa70a8a7a4328a768263d0.1644314545.git.fmaurer@redhat.com>
 <3273861b-5475-eac5-c827-c128a72c8b04@fb.com>
From:   Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <3273861b-5475-eac5-c827-c128a72c8b04@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08.02.22 17:23, Yonghong Song wrote:
> On 2/8/22 2:45 AM, Felix Maurer wrote:
>> If bpf_msg_push_data is called with len 0 (as it happens during
>> selftests/bpf/test_sockmap), we do not need to do anything and can
>> return early.
>>
>> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
>> ---
>>   net/core/filter.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 4603b7cd3cd1..9eb785842258 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -2710,6 +2710,9 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *,
>> msg, u32, start,
>>       if (unlikely(flags))
>>           return -EINVAL;
>>   +    if (unlikely(len == 0))
>> +        return 0;
> 
> If len == 0 is really unlikely in production environment, we
> probably can keep it as is. There are some helpers like this
> with a 'len' parameter, e.g.,  bpf_probe_read_kernel,
> bpf_probe_read_user, etc. which don't have 'size == 0' check.

My point with this is that the rest of the code does not expect len to
be 0. E.g., we later call get_order(copy + len); if len is 0, copy + len
is also often 0 and get_order returns some undefined value (at the
moment 52). alloc_pages catches that and fails, but then
bpf_msg_push_data returns ENOMEM. This seems wrong because we are not
out of memory and actually do not need any additional memory.

> John, could you also take a look?
> 
>> +
>>       /* First find the starting scatterlist element */
>>       i = msg->sg.start;
>>       do {
> 


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85377567F8D
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 09:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiGFHIO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 03:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiGFHIN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 03:08:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEB22678
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 00:08:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso9057130pjc.1
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 00:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/3hIk7s+pq0MUQbliDynIMl3woNqshFG3hDn0rKNdAs=;
        b=gyl/QPGjVQfl+FB7yoT0f+Ha+6Lo03VQOAxK++0iAuWOs06Bcb85Ln7RhJCIb9KSOU
         n5hQ64UyZ0L+PFZiYBfrDnkSfG6Mff0R6iZYa/doq3zyVVzyv8fOdSuBQli8+e83WYxv
         qrdHXdISuhDX0EfBQpe2GvSSAhbtjRgoM1HhMtTfTsUmkf5SWyco256qvFq2cpeUkI1n
         d5BpriH/NbocMYVlH0+nyQ587jGrOIkBj6c9peK8rA2OQEmgK7r3srC6t5WTx3mR2biX
         xsmHpjmTryTDXNpUqmSzdrxU6cCrxswyG31wIVhAj0TRmtqACy+fjd4tqleqQLQGKh55
         bUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/3hIk7s+pq0MUQbliDynIMl3woNqshFG3hDn0rKNdAs=;
        b=QQbrWjgIDrpFXsc7FQyuGF6TwdGwgk5uVRd6MMZ0+Jx4H/32iFHb1YA8dm3C9vC+y8
         KgF2CIxqhEfnMZ2R5am9q062eJ5Bfq8Jn9fgGiBZH0fsUuJK6IgW5ZdLJQEo8yanvG/Y
         YI8rsoSCptr9DVnt2BTNlQwfdND+Xp+BFVMrBYnIqCIlNIlq9HfmNo+MCSrl85gd9QYs
         Bjkfkrgsk7fKrSoxmcUo7quwiADqy9bA1v4fv/LXxRFjFBAStQJYzRgogqKl2zZNSQBE
         t/QJFFGZRdJ+DMSlRla1HL47dKeCqI50XT77Z9eb9X/3xo54Q6DUK6NrtR1X6S4D6zj9
         RHwQ==
X-Gm-Message-State: AJIora+DrhtUjeM6SJkh5nzoRfXS4Ks18zkCi02nPpkIkk2IakvvDIzl
        ZSnNrF20bU2QWj7JoKsXZSY=
X-Google-Smtp-Source: AGRyM1vA1WldkfZma2Za8/G35dHuCCN8BuwyMk58PL3dMS2mToj4eDwJAvRH8fiIJMBtznQfUvLEEQ==
X-Received: by 2002:a17:90b:17d0:b0:1ef:b6d1:c3ee with SMTP id me16-20020a17090b17d000b001efb6d1c3eemr1384968pjb.224.1657091292173;
        Wed, 06 Jul 2022 00:08:12 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.115])
        by smtp.gmail.com with ESMTPSA id i8-20020a1709026ac800b0016bf8048bd2sm1976729plt.175.2022.07.06.00.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 00:08:11 -0700 (PDT)
Message-ID: <111d4f5b-f174-128b-166b-65f91ce965fa@gmail.com>
Date:   Wed, 6 Jul 2022 15:08:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next] libbpf: Error out when missing binary_path for
 USDT attach
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
References: <20220704140850.1106119-1-hengqi.chen@gmail.com>
 <CAEf4Bzbo0GbLv0YdyLLZq8myGK=eGz_GgYbifw1LMu2Adxhjvg@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <CAEf4Bzbo0GbLv0YdyLLZq8myGK=eGz_GgYbifw1LMu2Adxhjvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Andrii

On 2022/7/6 13:05, Andrii Nakryiko wrote:
> On Mon, Jul 4, 2022 at 7:09 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> The binary_path parameter is required for bpf_program__attach_usdt().
>> Error out when user attach USDT probe without specifying a binary_path.
>>
> 
> This is a required parameter, libbpf doesn't add pr_warn() for every
> `const char *` parameter that the user incorrectly passes NULL for
> (e.g., bpf_program__attach_kprobe's func_name). If you think

I understand this is a required parameter. The intention of this patch is
to avoid coredump if user passes NULL for binary_path argument, not just
emit a warning. The uprobe handling code of libbpf already did this.

BTW, most of libbpf APIs do NULL check for their const char * parameters
and return -EINVAL.

> bpf_program__attach_usdt() doc comment about this is not clear enough,
> let's improve the documentation instead of littering libbpf source
> code with Java-like NULL checks everywhere.
>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
>>  tools/lib/bpf/libbpf.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 8a45a84eb9b2..5e4153c5b0a6 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -10686,6 +10686,12 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
>>                 return libbpf_err_ptr(-EINVAL);
>>         }
>>
>> +       if (!binary_path) {
>> +               pr_warn("prog '%s': USDT attach requires binary_path\n",
>> +                       prog->name);
>> +               return libbpf_err_ptr(-EINVAL);
>> +       }
>> +
>>         if (!strchr(binary_path, '/')) {
>>                 err = resolve_full_path(binary_path, resolved_path, sizeof(resolved_path));
>>                 if (err) {
>> --
>> 2.30.2


--
Hengqi

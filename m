Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65695643D7B
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 08:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbiLFHOs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 02:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiLFHOr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 02:14:47 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3451C14D04;
        Mon,  5 Dec 2022 23:14:47 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jn7so13080223plb.13;
        Mon, 05 Dec 2022 23:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AwV+aQezPrqmBi+1p608TRrRU2Dd7rb+QPCbuqXm00Y=;
        b=Io1NM++sncn5eRES2/jZKZmNDFCuHxRqdNKbdkNpigNzh7SEoBIzImpXdIPsY+havC
         CZJhgEnmVdHYPoLotanDGcdPmMeW1NA1r4YBo4d8juIQSW5H0iGPrHKFLYWa/L1c0Kkw
         PmZvdPrdiTIhQogbicWB7Xr7P3iPZh3WJXQLwIEIz1DpERD8mbiTHFoAuMUZHVlj8y9Y
         WURfOT55kx/+dqp+wwdGjyTZZjFQelCGkul6W7AG4mLzQnG64wJtO62f/7v+KWUuD+2c
         xQWugvy/kzhVboqUEzoMRz/5Kc6FaXSp7J0EkteABUTP6CzWr3kyYC7Bee6IWugnH5/0
         bhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwV+aQezPrqmBi+1p608TRrRU2Dd7rb+QPCbuqXm00Y=;
        b=t7ep6CpNbv58f2UptR/3bHtPjYCuw10d0LneNRa4M+dWjqExHsVSoZT85AjuO0r+hb
         u1eo2OvFQysbpP+1inXbbsO/9QkjaVNyVSZX/a1qm/7WzcSskec7MhNX3elBTEDW+lur
         xjJnVRIovfX1o6n/BgY2DfOVWiOcwezbNO2oN8X0guGe6fok33Rx1vFDQudnvy+UE1IG
         qLM6giDHUnElAHtvvFD+vK1uCFmfCnyXqN9ZOXwOLNcUB/T3CxTwdAk9EfN+DOUkh7Vd
         e7Nv1hdjoPDn0ZZ7YKsIIUyV9gsApgQkgh1AQ84of/QPMy8NQQw6BSrvJPqA9bDp3lMU
         DZjg==
X-Gm-Message-State: ANoB5pktTyErNvDo3hYaKjXNrOIlPPHogJju6oLOSDyabKXoAje6OSuW
        Mu+caOOWi58J1yO+nBlShjFIRyFYU8TBxQ==
X-Google-Smtp-Source: AA0mqf5njaIFBPQ0FAuyk01o8a5QFgvF/4emMR4KG5ol+LRQkLvgFF0RC6vHDP2XDLJ9vRuYRSzhxQ==
X-Received: by 2002:a17:902:d1d2:b0:189:d637:cc63 with SMTP id g18-20020a170902d1d200b00189d637cc63mr8638266plb.92.1670310886580;
        Mon, 05 Dec 2022 23:14:46 -0800 (PST)
Received: from [192.168.1.5] ([180.171.235.177])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902f64d00b001891ea4d133sm11753590plg.12.2022.12.05.23.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 23:14:45 -0800 (PST)
Message-ID: <59dd6dba-cabf-bd80-dc1e-87da9cdd1671@gmail.com>
Date:   Tue, 6 Dec 2022 15:14:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] bpftool: Fix memory leak in do_build_table_cb
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221205081300.561974-1-linmq006@gmail.com>
 <8d7ac47d-5d76-eaf1-7c1e-a4418d80dac5@iogearbox.net>
Content-Language: en-US
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <8d7ac47d-5d76-eaf1-7c1e-a4418d80dac5@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Daniel

On 2022/12/6 4:05, Daniel Borkmann wrote:
> On 12/5/22 9:13 AM, Miaoqian Lin wrote:
>> strdup() allocates memory for path. We need to release the memory in
>> the following error paths. Add free() to avoid memory leak.
>>
>> Fixes: 8f184732b60b ("bpftool: Switch to libbpf's hashmap for pinned paths of BPF objects")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>> ---
>>   tools/bpf/bpftool/common.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
>> index 0cdb4f711510..8a820356525e 100644
>> --- a/tools/bpf/bpftool/common.c
>> +++ b/tools/bpf/bpftool/common.c
>> @@ -499,9 +499,11 @@ static int do_build_table_cb(const char *fpath, const struct stat *sb,
>>       if (err) {
>>           p_err("failed to append entry to hashmap for ID %u, path '%s': %s",
>>                 pinned_info.id, path, strerror(errno));
>> -        goto out_close;
>> +        goto out_free;
>>       }
>>   +out_free:
>> +    free(path);
>
> It would be ok if you were to add the free(path) into the err condition, but here you
> also cause the !err to be freed which would trigger as UAF. See the hashmap_insert()
> where just set the pointer entry->value = <path>.. how was this tested before submission?
>
Thanks for your review. You're right. Sorry for the mistake, I meant to free it in the error path.

I'll send v2 to fix this. I spotted it with static detection tool.

>>   out_close:
>>       close(fd);
>>   out_ret:
>>
>

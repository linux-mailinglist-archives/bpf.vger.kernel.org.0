Return-Path: <bpf+bounces-7033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BD1770703
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 19:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60581C218F9
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746231AA87;
	Fri,  4 Aug 2023 17:25:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38546BE7C
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 17:25:18 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D919B469A
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 10:25:16 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-579de633419so25245317b3.3
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 10:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691169916; x=1691774716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYJs1okAAkLZX21ubw2REPcAvfWq54iT+nlBiAWPZZs=;
        b=cxMEG6QRTlGh92K92aVxZ96c5M1Uo3aR0a6HJxy3ePyo67axWXn+G166ePFhTa0Ras
         SW2b5yiGCRXxPqCNNJwCW+rG+dwr7CNl3+d1HkkXsIlRFZdZDFNJd2SG/pMiB1OQm6xS
         JF9y4rPejpcJQ+Yyv6VFPQ/Ua3lgPz5AiKgTIFCFRcD7Ia8sdQWaV/D60Ibfxd7h9R18
         uZVT5RTUknWfnsRCp4x8B/oJ8sjrdD+Uhg0EJ6MZDVhLOC0n1Zz28rpQtETEGMKpo3U7
         wZfoOf7tM/I3bE3CrG212XPb8v8hYunWO7X3PWgEv79JwHjLevheAF8R9VxWgUwnfOg0
         jHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691169916; x=1691774716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYJs1okAAkLZX21ubw2REPcAvfWq54iT+nlBiAWPZZs=;
        b=QJExAQaJODIPUxiMK1xS1Q487Rc3H5SWge/3jo4yRKOwS8q64QkMzDjMgSkCXnnlgg
         gXeSHCfHeVH0wlOZrHBrvDOtRmd5SitsuI3H6ygrHP620gsaTBLWaW6vALIrxtWSyN94
         oQtkcH3LulnqqXhOSKZq+GPyQJmp9B//bH7E0EfdJJ84Fh8/sWq+CCyuBnjT90hPbodA
         evo6kHDYOGg+jBrAKJlZDNYRdZ3dmSOv1vywV7RddPf7MgdDOL8iMergpM+0Jec/Ne9t
         aSa3+glktKE7DYP77adv+uZX0ULHbxXxhvS/2nazZRsY4VnbDzbjwF7rQDnIhmt7IPM5
         2AoQ==
X-Gm-Message-State: AOJu0Yyb4sCli/y6zdBHbbOmmW1KFMycvwJKNixsjMJbvMUnIP5whrNH
	JAE7W8EaOgJLPC8Xedv1xa0=
X-Google-Smtp-Source: AGHT+IH1fz8K01GQ8E9Ow+K+bAmPRt9xHcWYi/QsRgGNhbZMR4LuOyVHZyxAPKk9IrStxN6ncLnl/Q==
X-Received: by 2002:a81:770b:0:b0:57a:2cd2:fdb9 with SMTP id s11-20020a81770b000000b0057a2cd2fdb9mr2351285ywc.18.1691169915978;
        Fri, 04 Aug 2023 10:25:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:174:cd0c:d94f:4c1f? ([2600:1700:6cf8:1240:174:cd0c:d94f:4c1f])
        by smtp.gmail.com with ESMTPSA id m2-20020a0de302000000b0054f50f71834sm838297ywe.124.2023.08.04.10.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 10:25:15 -0700 (PDT)
Message-ID: <2c05d7dc-ba60-b8d2-65ec-265a5032002f@gmail.com>
Date: Fri, 4 Aug 2023 10:25:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next] bpf: fix inconsistent return types of
 bpf_xdp_copy_buf().
Content-Language: en-US
To: yonghong.song@linux.dev, thinker.li@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20230804005101.1534505-1-thinker.li@gmail.com>
 <38f076e4-908f-d1be-a3f6-4b276d5cd6bd@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <38f076e4-908f-d1be-a3f6-4b276d5cd6bd@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/3/23 18:41, Yonghong Song wrote:
> 
> 
> On 8/3/23 5:51 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Fix inconsistent return types in two implementations of 
>> bpf_xdp_copy_buf().
>>
>> There are two implementations: one is an empty implementation whose 
>> return
>> type does not match the actual implementation.
>>
>> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Looks like a fix tag is not needed as the old code won't cause
> compilation warnings or runtime errors despite the signature mismatch.
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Thank you for the review!

> 
>> ---
>>   include/linux/filter.h | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 2d6fe30bad5f..761af6b3cf2b 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -1572,10 +1572,9 @@ static inline void *bpf_xdp_pointer(struct 
>> xdp_buff *xdp, u32 offset, u32 len)
>>       return NULL;
>>   }
>> -static inline void *bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned 
>> long off, void *buf,
>> -                     unsigned long len, bool flush)
>> +static inline void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned 
>> long off, void *buf,
>> +                    unsigned long len, bool flush)
>>   {
>> -    return NULL;
>>   }
>>   #endif /* CONFIG_NET */


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C3D6AF5B5
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 20:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjCGTcL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 14:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjCGTb5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 14:31:57 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919142CC7E
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 11:17:40 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x34so14299606pjj.0
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 11:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678216660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/tiQhcJCkvDNHsXF/xDzB6T+ywkwA2v7Yfl1KHP9gvs=;
        b=HbFVgeB5aNaK9tzswjqb3t5LUmwausTv3sF6JqtrQT+76jHVihrrGaKtN/nYjvHvzo
         F+jfCtcKxfMDV6hjDujOF6m1iHjGw4gq4799GTAQ1o3QQ3be6nVNJvZ2oHdg5KcO7QsJ
         c5w8XtbRiOVF+dP0GRvbDEt48/dhR0I66j6xLBodMXDnrrynr3xyrBf1wL3m65jFVaYD
         ilgeRtTOreDsd8dT6DKOBZIAS5s/2KXxCPr+1ieafi2CAAOYh09pYxqtSCC9L0nw5Uu0
         TN7w9mFMPqsVe66W4yjZJuKTv6x82miWqQQq4fGnzfgpTmb9OxlOfF2mSwTWi4EOMYgk
         KLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678216660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/tiQhcJCkvDNHsXF/xDzB6T+ywkwA2v7Yfl1KHP9gvs=;
        b=c9NyswxENV70wHtM5QmA1Rq4UHCm0cEYNlNbsLnNBDPEgJ6TzFJcI3aZy/7y16oiWn
         v0saqj+zu2FlaOXKcS0nxNlq1UONBQzHAK6vYP5T0kzjozSSLZOng2iuvj27SSTpG6Sp
         JEFbqdDlFxOiCqexWrOv2+NrdFm5qa7Eqltkqw/qkN4E+C0KgYcHu76jj5x15SGgrnxP
         kp3IOf9RsTE4ya7xPXL7+bQ1NVtonyAswyvZ+zWsOwUnDt7xFyUGZpMma48n3wNxBaHK
         eVFrQW41PeOLq+soGaZwF4g5JZ8itBwhHK2oOQ1COSl/DVk7WKTY12qDn58EfWTdrmNM
         xQ2g==
X-Gm-Message-State: AO0yUKVcL7EnhjW8KK5WI9JPkqA8nb0m3DesYFrY5rxDJVtHAMYdGRFA
        b+8YnfSknE7/b7bOHcCKFnI=
X-Google-Smtp-Source: AK7set+Os6ga8dUjlWeKTjSue2oOq1Ej6+o5cjYWjSS2l/1vXpdqO9GE5LpOQ3Ejzmc31lQja8tIsQ==
X-Received: by 2002:a17:903:2290:b0:19c:dbce:dce8 with SMTP id b16-20020a170903229000b0019cdbcedce8mr19584496plh.15.1678216660115;
        Tue, 07 Mar 2023 11:17:40 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21cf::1402? ([2620:10d:c090:400::5:173])
        by smtp.gmail.com with ESMTPSA id w4-20020a17090a6b8400b00227223c58ecsm7665496pjj.42.2023.03.07.11.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 11:17:39 -0800 (PST)
Message-ID: <c870e6b2-059a-052a-70d7-d62dd15319af@gmail.com>
Date:   Tue, 7 Mar 2023 11:17:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v3 3/8] net: Update an existing TCP congestion
 control algorithm.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230303012122.852654-1-kuifeng@meta.com>
 <20230303012122.852654-4-kuifeng@meta.com>
 <e80abe7f-40d5-b35f-1fdc-f82a2ebaf937@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <e80abe7f-40d5-b35f-1fdc-f82a2ebaf937@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/6/23 18:17, Martin KaFai Lau wrote:
> On 3/2/23 5:21 PM, Kui-Feng Lee wrote:
>> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
>> index db8b4b488c31..981501871609 100644
>> --- a/net/ipv4/tcp_cong.c
>> +++ b/net/ipv4/tcp_cong.c
>> @@ -75,14 +75,8 @@ struct tcp_congestion_ops *tcp_ca_find_key(u32 key)
>>       return NULL;
>>   }
>> -/*
>> - * Attach new congestion control algorithm to the list
>> - * of available options.
>> - */
>> -int tcp_register_congestion_control(struct tcp_congestion_ops *ca)
>> +static int tcp_ca_validate(struct tcp_congestion_ops *ca)
> 
> It is useful to call tcp_ca_validate() before update_elem transiting a 
> struct_ops to BPF_STRUCT_OPS_STATE_READY. Otherwise, the user space will 
> end up having a struct_ops that can never be used to create a link.

I will add a function pointer in struct bpf_struct_ops to expose this 
check function.  At the struct_ops side, it will call the function to 
check kdata before transiting to READY if the function pointer is set.

> 
> 
> 

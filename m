Return-Path: <bpf+bounces-2451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A7572D37F
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 23:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CDC1C20BC1
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 21:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B352D23412;
	Mon, 12 Jun 2023 21:49:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8286722D60
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 21:49:50 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85F818E
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 14:49:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-653436fcc1bso4092800b3a.2
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 14:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686606588; x=1689198588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1MNyUHZeQiodtcOHjn41Myp6pyPmhoOHv6B3DZjPEB0=;
        b=azvcHGwUWd71qwP+0Td87QH0DzhAwLSD/YAwnl11RJaHfM2ZyhRr6dNQQvh1Z/L7lf
         jsGiJqu45K9yOakXZo9t76S4GeA1SNxGlghWInEw6BQ3lMjbryMMn9k+t9QwPaIMpUsb
         96O6LEOXaPlUwGVRfiINeF2NDdpscG+rcV/IyYED35EXWRn1AVgwwmV6JhMi4QMhOfKF
         cpFjV850yqtvE7heYAgU+FSvWRMtWPdlaAhMyLVIqDE++rWXvxa0NLOdgc3z/6WfPl6o
         UHi6VqPtRUpNTGAWWJWKyQpey1t+5dHcF31u2a8vEmconDdZPCok1N7vPg4uM9WO4HKt
         6BLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686606588; x=1689198588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MNyUHZeQiodtcOHjn41Myp6pyPmhoOHv6B3DZjPEB0=;
        b=huWqNbvJUYYV/8y2SwFSWRzF9uRyjo3Y+0i2yX33UmVJb2yjDzfT66qsnPLweomkPX
         crBjRD86JXHJzlhVU7UBcQc8Zi7LBnu+AU+iBzgi5cNxKab6xPxknTZSodffhxS0AwOg
         kQ/SCvDiCoZqT22yeyE3rVlCmPaxtjJRyYHF0nfgY7emL5fv/fBVFHlecChplw139OxO
         i1pt5f/bbdnuuYRp0cfe2ohiBAK9vUJy7Sb7KU/MMTEa2I3L+FRsHNQfImMaP7Wpu0wq
         1PslMbEQWLV2oxkOjAiAUaHNbkxS6a/K0g7ZyvL3GO3B28XvFBQH4J0IYH6zN4LMz4EB
         letA==
X-Gm-Message-State: AC+VfDxt8sW4/TiiGQvV+yQRnV4eB7fvPS3GF/XAylisFnXnPz2nhApB
	KzykxPSS0l6gFof7Mg//j1ZjiC49WVQ=
X-Google-Smtp-Source: ACHHUZ6VvfNcMKtIQg/qJ/O9My//Ylnx3d5OkH8jBMBilPGrsFOED+M82Rk/xLkvg3WYTb3Afk3Y3A==
X-Received: by 2002:a05:6a21:170e:b0:10b:78d6:a2c8 with SMTP id nv14-20020a056a21170e00b0010b78d6a2c8mr9082736pzb.15.1686606588153;
        Mon, 12 Jun 2023 14:49:48 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::12b4? ([2620:10d:c090:400::5:8131])
        by smtp.gmail.com with ESMTPSA id u1-20020aa78381000000b0064f7c56d8b7sm7242899pfm.219.2023.06.12.14.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 14:49:47 -0700 (PDT)
Message-ID: <e15949d2-3ec7-5e15-de11-0d7d9f6a30fa@gmail.com>
Date: Mon, 12 Jun 2023 14:49:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH bpf-next 1/2] net: bpf: Always call BPF cgroup filters for
 egress.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kui-Feng Lee <kuifeng@meta.com>
References: <20230612191641.441774-1-kuifeng@meta.com>
 <20230612191641.441774-2-kuifeng@meta.com>
 <CAADnVQKi0c=Mf3b=z43=b6n2xBVhwPw4QoV_au5+pFE29iLkaQ@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQKi0c=Mf3b=z43=b6n2xBVhwPw4QoV_au5+pFE29iLkaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/12/23 13:17, Alexei Starovoitov wrote:
> On Mon, Jun 12, 2023 at 12:16 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> Always call BPF filters if CGROUP BPF is enabled for EGRESS without
>> checking skb->sk against sk.
>>
>> The filters were called only if sk_buff is owned by the sock that the
>> sk_buff is sent out through.  In another words, sk_buff::sk should point to
> 
> What is "sk_buff::sk" ? Did you mean skb->sk ?

Yes!
> 
>> the sock that it is sending through its egress.  However, the filters would
>> miss SYNACK sk_buffs that they are owned by a request_sock but sent through
>> the listening sock, that is the socket listening incoming connections.
>> This is an unnecessary restrict.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   include/linux/bpf-cgroup.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
>> index 57e9e109257e..e656da531f9f 100644
>> --- a/include/linux/bpf-cgroup.h
>> +++ b/include/linux/bpf-cgroup.h
>> @@ -199,7 +199,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>>   #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk, skb)                              \
>>   ({                                                                            \
>>          int __ret = 0;                                                         \
>> -       if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk && sk == skb->sk) { \
>> +       if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {
> 
> 
> I did a bit of git-archeology.
> That check was there since the beginning of cgroup-bpf and
> came as a suggestion to use 'sk' instead of 'skb->sk':
> https://lore.kernel.org/all/58193E9D.7040201@iogearbox.net/
> 
> Using sk is certainly correct. It looks to me that the check
> was added just for a "piece of mind".
> 
Good to know that.  Thank you for the confirmation.


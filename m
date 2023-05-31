Return-Path: <bpf+bounces-1521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED5F7188E0
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 19:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CE71C20F3D
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D5618C08;
	Wed, 31 May 2023 17:54:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811C14294
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 17:54:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AA2125
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685555667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2OwHuayh2TJteuoq3W7+bFOABwZExNtlVfErFXF9TA=;
	b=BedAr1IS7yqWPV9r1znnnHtYL1OV1wrLtksx3c3XWSmso/ZI6ZeCveUrzuZc2Q4MoD2Ehq
	UUjM6gYrEAzVEXrLNY4j6TbEDOLDhlNSMGMNHfV3THDdtQQ+9XQ+6Ulbw5g29xyhdRwXKW
	6PGYiCR/ZuHU6DAPSjIUEdCe299QtSA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-PZsGo_pbNdm5pXteZ4Chng-1; Wed, 31 May 2023 13:54:26 -0400
X-MC-Unique: PZsGo_pbNdm5pXteZ4Chng-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-514bcf60cd1so10976a12.2
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 10:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685555665; x=1688147665;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2OwHuayh2TJteuoq3W7+bFOABwZExNtlVfErFXF9TA=;
        b=DlkhRcclUMjkHaDjR4ISOBfXSj0tqrzcA8dva5hnNVTDnkrf2FjgXBEnhHqqwgsnAb
         kcQnQ5B32oh6mOu+oFyQRPMqPZwPA025MnYlT/Hsnpg7IxGSxwHfc3ojEeZ8+L0AUmrZ
         83M7p/L+PAwEa45BhrAvR0VhI8zyR/wljn+todRxaPIDJqfV/nW5x1/KnWjEym6frjWS
         TqmpAx8EwxO4ftCsjsHI5ee1nMQG8XU/3jB+IoPJbAcsYTbXe5ZBb7lmoKrGEdxex0n8
         UIZDT4bUE+Mw/Hy7UF9OrsulaK+28Xtq3BFL7bHM4C/HBoVQf4QjQFOVZGStEGMFDRyJ
         mKjg==
X-Gm-Message-State: AC+VfDwVDUL4CS+kvT+SBSxuGdt3m6BSIdgmyrE05NW46Zq8/74e7vnv
	+/aYj4tzKjFS4jWb+GsL1+WNSRfQdxzfokyj8/v/HxnhJ8aOMKO5q6ts+h6AxTA5X6PPazmzIGG
	uqvTtj09zrVwW
X-Received: by 2002:a05:6402:795:b0:50d:f9b1:6918 with SMTP id d21-20020a056402079500b0050df9b16918mr4244499edy.9.1685555665715;
        Wed, 31 May 2023 10:54:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6DgJV1jPTDPRDq0GVdExf6YPn4c8XQlq/PvHhK9mfOwUTcar8dpHmA8ZWHY/96asKw+zKnNA==
X-Received: by 2002:a05:6402:795:b0:50d:f9b1:6918 with SMTP id d21-20020a056402079500b0050df9b16918mr4244476edy.9.1685555665395;
        Wed, 31 May 2023 10:54:25 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id g25-20020aa7d1d9000000b00515c8024cb9sm337383edp.55.2023.05.31.10.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 10:54:24 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <f6b26173-fa51-662c-ae40-3f776abf9c7b@redhat.com>
Date: Wed, 31 May 2023 19:54:23 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, Tariq Toukan <ttoukan.linux@gmail.com>,
 Daniel Borkmann <borkmann@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 bpf@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, gal@nvidia.com,
 netdev@vger.kernel.org, echaudro@redhat.com, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH bpf-next] bpf/xdp: optimize bpf_xdp_pointer to avoid
 reading sinfo
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>
References: <168554475365.3262482.9868965521545045945.stgit@firesoul>
 <ZHdrLSDC7UfLKKfp@lore-desk> <87353ceaej.fsf@toke.dk>
In-Reply-To: <87353ceaej.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 31/05/2023 18.24, Toke Høiland-Jørgensen wrote:
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> 
>>> Currently we observed a significant performance degradation in
>>> samples/bpf xdp1 and xdp2, due XDP multibuffer "xdp.frags" handling,
>>> added in commit 772251742262 ("samples/bpf: fixup some tools to be able
>>> to support xdp multibuffer").
>>>
>>> This patch reduce the overhead by avoiding to read/load shared_info
>>> (sinfo) memory area, when XDP packet don't have any frags. This improves
>>> performance because sinfo is located in another cacheline.
>>>
>>> Function bpf_xdp_pointer() is used by BPF helpers bpf_xdp_load_bytes()
>>> and bpf_xdp_store_bytes(). As a help to reviewers, xdp_get_buff_len() can
>>> potentially access sinfo.
>>>
>>> Perf report show bpf_xdp_pointer() percentage utilization being reduced
>>> from 4,19% to 3,37% (on CPU E5-1650 @3.60GHz).
>>>
>>> The BPF kfunc bpf_dynptr_slice() also use bpf_xdp_pointer(). Thus, it
>>> should also take effect for that.
>>>
>>> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
>>> ---
>>>   net/core/filter.c |   12 ++++++++----
>>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>> index 968139f4a1ac..a635f537d499 100644
>>> --- a/net/core/filter.c
>>> +++ b/net/core/filter.c
>>> @@ -3948,20 +3948,24 @@ void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
>>>   
>>>   void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len)
>>>   {
>>> -	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
>>>   	u32 size = xdp->data_end - xdp->data;
>>> +	struct skb_shared_info *sinfo;
>>>   	void *addr = xdp->data;
>>>   	int i;
>>>   
>>>   	if (unlikely(offset > 0xffff || len > 0xffff))
>>>   		return ERR_PTR(-EFAULT);
>>>   
>>> -	if (offset + len > xdp_get_buff_len(xdp))
>>> -		return ERR_PTR(-EINVAL);
>>> +	if (likely((offset < size))) /* linear area */
>>> +		goto out;
>>
>> Hi Jesper,
>>
>> please correct me if I am wrong but looking at the code, in this way
>> bpf_xdp_pointer() will return NULL (and not ERR_PTR(-EINVAL)) if:
>> - offset < size
>> - offset + len > xdp_get_buff_len()
>>
>> doing so I would say bpf_xdp_copy_buf() will copy the full packet starting from
>> offset leaving some part of the auxiliary buffer possible uninitialized.
>> Do you think it is an issue?
> 
> Yeah, you're right, bpf_xdp_load_bytes() should fail if trying to read
> beyond the frame, and in this case it won't for non-frags; that's a
> change in behaviour we probably shouldn't be making...
> 

Thanks for spotting this!
I will work on a V2 tomorrow.

--Jesper



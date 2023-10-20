Return-Path: <bpf+bounces-12856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DF07D1535
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 19:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F4E282412
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 17:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116D5208B5;
	Fri, 20 Oct 2023 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWgkIzPx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD91E530;
	Fri, 20 Oct 2023 17:53:55 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DB4D55;
	Fri, 20 Oct 2023 10:53:54 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59b5484fbe6so12327697b3.1;
        Fri, 20 Oct 2023 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697824434; x=1698429234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WrkktZKBRPlFCzqyWlpvovV2LO5dRVDhRGH6sL1EBdg=;
        b=WWgkIzPxn4p4m2QCyxnn7HjZ2WiJYZsQJeqmJbzvY980pNPal5jh/TIX543wbQkry2
         Or2aB8hqcHlEvTtCuEiE0yunVPxyTMoJzquJxnnBrbBbAtKCJqOHufgS4C6G2f+5n0dg
         8d2nKRgPR5omRxKPWN256Gh0NalOZLfRl7jYoouCsr2kOQX47qNy7PZbZ0Frbuk3FFf1
         MxGNem6XS9FWlfCw1j036USuodgRkM4/GFlGnk2WE9I5/PGzxs/wFfZed7TVbe0vJ94U
         GTseM1cjw9Dn/8gP/VCelRHZqNrHYDdnN/fHmugX6eHIsfTPK7aZdJfO+iHOU2+Jb0f0
         fcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697824434; x=1698429234;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WrkktZKBRPlFCzqyWlpvovV2LO5dRVDhRGH6sL1EBdg=;
        b=cb7IfFksNjeUnTcRfZRcn2vevWeyk+ASv9dsX9bXOKQY9aAec5NHH5d99N1ph7mk++
         lXHn04VWymCa4cBK+ru0S/wE3WNmu/J3/k1ctbK21JNS/TTvps1+YdB3XSXJWo/8KN1w
         +/0zWLJnmLs2JV4300/HoxgTtFTB2VjsC/bRYJKyQYjKigltSndoLj9yDIpqY+E544NB
         PjiCB5YTtQN4eg9NLwNtBlbgXlhDVGb888y25TJJIQ5jA7t7Zil8y+JP/DwYxKOVrRxC
         57laMaQ348pahIxCxR8WuvLnSjBhspWl7nmVXryE5IPa+jhTituhGPySeuhVOAzhbc5/
         XNqQ==
X-Gm-Message-State: AOJu0YyKapU66870eaCj6NdAT2n/e7tND6fq0EoP0CkoEtMWftkML0qE
	UAn5syadNKSQEx90Z/iRMRk=
X-Google-Smtp-Source: AGHT+IFtURqb6fN+sYUYMlRQVStxudTfcXAC9A3VU4s4N5kleYFIUozk0gwuopi37iYAOB4GDZjZiw==
X-Received: by 2002:a0d:ea8b:0:b0:5a7:aad1:6567 with SMTP id t133-20020a0dea8b000000b005a7aad16567mr2938236ywe.7.1697824433997;
        Fri, 20 Oct 2023 10:53:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:74bb:66ec:3132:3e97? ([2600:1700:6cf8:1240:74bb:66ec:3132:3e97])
        by smtp.gmail.com with ESMTPSA id o11-20020a81de4b000000b0059511008958sm828029ywl.76.2023.10.20.10.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 10:53:53 -0700 (PDT)
Message-ID: <bef24789-819c-4a7b-bbb0-f38ffe9f67f0@gmail.com>
Date: Fri, 20 Oct 2023 10:53:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 6/9] bpf, net: switch to dynamic registration
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231017162306.176586-1-thinker.li@gmail.com>
 <20231017162306.176586-7-thinker.li@gmail.com>
 <72104b12-4573-7f6d-183e-4761673329e2@linux.dev>
 <9e7ec07f-bc03-4e62-a0f6-28f668a1ec42@gmail.com>
In-Reply-To: <9e7ec07f-bc03-4e62-a0f6-28f668a1ec42@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/20/23 08:12, Kui-Feng Lee wrote:
> 
> 
> On 10/18/23 18:49, Martin KaFai Lau wrote:
>> On 10/17/23 9:23 AM, thinker.li@gmail.com wrote:
>>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>>   static const struct bpf_struct_ops *
>>>   bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
>>>   {
>>> +    const struct bpf_struct_ops *st_ops = NULL;
>>> +    const struct bpf_struct_ops **st_ops_list;
>>>       unsigned int i;
>>> +    u32 cnt = 0;
>>>       if (!value_id || !btf_vmlinux)
>>
>> The "!btf_vmlinux" should have been changed to "!btf" in the earlier 
>> patch (patch 2?),
> 
> This is not btf. It mean to check if btf_vmlinux is initialized.
> It is not necessary anymore.
> For checking btf, the following btf_get_struct_ops() will keep cnt zero
> if btf is NULL, so it is unnecessary as well.

Forget my previous comment.  I think you are right!



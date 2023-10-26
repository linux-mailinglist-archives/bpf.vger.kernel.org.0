Return-Path: <bpf+bounces-13327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF847D84D5
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 16:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCDE1C20DD1
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 14:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259542EAFE;
	Thu, 26 Oct 2023 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="VyYAEIbW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A852DF6E
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 14:34:10 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C5128
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 07:34:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-409299277bbso722355e9.2
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698330848; x=1698935648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9EOHVIQcy7UU9cwqwd+tluLHTxjtvTgjkkcZlOPXvCc=;
        b=VyYAEIbWyF1cnp2EPHZFxbERn/9Lr3EiHv0HA0y5yKpm4sfU1ysTJRTV8wykiBqQ8N
         8ite+wKkwd6KQ9zyRzej25dY0uXLhhp614l6OnUL9mC18YFlUerabN/+pMsHFSNl579Z
         3PdFy3vMYvZMV1RFzYCDTqQxnMsDu+SYyOHunAvwiRX3rt6oLVx8Reik+c9WeUi4vUyB
         t6oAlSP0h/jd0XkxebJl+CWimDZ99WIeBuJp4ODGtlYpeUllTPkvct2NTGdscxtw9GT3
         w755E5/jI3d4pG9CoQKfKCi0SNEmE3PGU//m4G+eE0i+IEzQc/2C0eASEbtAjCaflCqs
         jPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330848; x=1698935648;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9EOHVIQcy7UU9cwqwd+tluLHTxjtvTgjkkcZlOPXvCc=;
        b=s4/2FuI3uzeiVwM54wfphEiFjqAKkmvWwNQ/ydTxiEi4Cb06RPTqCpi49nV74mOkr0
         jtIUhZk+CqaKCO9xVZP16C0vIDs8k1DI1mZbywl6zVnqzizB5zG67XZAHJtCRAach02p
         0A1HZ8wOk1nBrEIUSHcXW2AWpuhk2XpsosVfnHoFDnaRiXAjPjD+mAW9Z6DvGF0uCOG6
         eLACeBu036fwg/BYDv7QWatc+dEjKrEghbIdEzOn5pn5EbSm0yN518NgM6rxKFAN0wo7
         bZ4lMEHlxiRht7u7yfMZEszwU4NpfLmzOcEY083SxsiwkriRiyKwJpcVOdAcqRiEcZM2
         Lslw==
X-Gm-Message-State: AOJu0YwR865LfclVZKRLKIDtzkrPiBNDRfiAAuabgAV8f3n+zcwWiKBo
	XZYfYBPg/1Mcfh0TbIn4jhwwpQ==
X-Google-Smtp-Source: AGHT+IFNq02evhGW3aI6zTPqy+iBveUSalg6gcLk6pE7A1BGCrhJPK0NLseg8Vlg/DTqI0ZRW6sjdA==
X-Received: by 2002:adf:f346:0:b0:32d:bc6e:7f0d with SMTP id e6-20020adff346000000b0032dbc6e7f0dmr12711213wrp.18.1698330847630;
        Thu, 26 Oct 2023 07:34:07 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id d14-20020adffd8e000000b0031984b370f2sm14326243wrr.47.2023.10.26.07.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 07:34:07 -0700 (PDT)
Message-ID: <5f2655c0-8e66-4aa4-a94a-e6a45be44105@blackwall.org>
Date: Thu, 26 Oct 2023 17:34:05 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next 2/2] netkit: use netlink policy for mode and
 policy attributes validation
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: bpf@vger.kernel.org, jiri@resnulli.us, netdev@vger.kernel.org,
 martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, andrew@lunn.ch, toke@kernel.org,
 toke@redhat.com, sdf@google.com, daniel@iogearbox.net
References: <20231026094106.1505892-1-razor@blackwall.org>
 <20231026094106.1505892-3-razor@blackwall.org> <ZTpzfckQ5n4o2F7D@shredder>
 <36072f45-0d42-7284-d0dc-295f543fe40f@blackwall.org>
In-Reply-To: <36072f45-0d42-7284-d0dc-295f543fe40f@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/26/23 17:23, Nikolay Aleksandrov wrote:
> On 10/26/23 17:11, Ido Schimmel wrote:
>> On Thu, Oct 26, 2023 at 12:41:06PM +0300, Nikolay Aleksandrov wrote:
>>>   static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
>>>       [IFLA_NETKIT_PEER_INFO]        = { .len = sizeof(struct 
>>> ifinfomsg) },
>>> -    [IFLA_NETKIT_POLICY]        = { .type = NLA_U32 },
>>> -    [IFLA_NETKIT_MODE]        = { .type = NLA_U32 },
>>> -    [IFLA_NETKIT_PEER_POLICY]    = { .type = NLA_U32 },
>>> +    [IFLA_NETKIT_POLICY]        = NLA_POLICY_VALIDATE_FN(NLA_U32,
>>> +                                 netkit_check_policy),
>>
>> Nik, it's problematic to use NLA_POLICY_VALIDATE_FN() with anything
>> other than NLA_BINARY. See commit 9e17f99220d1 ("net/sched: act_mpls:
>> Fix warning during failed attribute validation").
>>
> 
> But how is that code called at all? The validation type is 
> NLA_VALIDATE_FUNCTION(), not NLA_VALIDATE_MIN/MAX/RANGE/RANGE_WARN...
> nla_validate_int_range() is called only on:
>          case NLA_VALIDATE_RANGE_PTR:
>          case NLA_VALIDATE_RANGE:
>          case NLA_VALIDATE_RANGE_WARN_TOO_LONG:
>          case NLA_VALIDATE_MIN:
>          case NLA_VALIDATE_MAX:
> 

Ah, I'm looking at the wrong thing.. I saw the problem. :)

> Anyway, I'll switch to NLA_BINARY in a bit to make sure it's ok. Thanks 
> for the pointer.
> 
>>> +    [IFLA_NETKIT_MODE]        = NLA_POLICY_VALIDATE_FN(NLA_U32,
>>> +                                 netkit_check_mode),
>>> +    [IFLA_NETKIT_PEER_POLICY]    = NLA_POLICY_VALIDATE_FN(NLA_U32,
>>> +                                 netkit_check_policy),
>>>       [IFLA_NETKIT_PRIMARY]        = { .type = NLA_REJECT,
>>>                           .reject_message = "Primary attribute is 
>>> read-only" },
>>>   };
>>> -- 
>>> 2.38.1
>>>
>>>
> 



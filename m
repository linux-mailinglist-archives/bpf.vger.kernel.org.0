Return-Path: <bpf+bounces-4729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7AF74E7B2
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EAC2814D1
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 07:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0AE171C0;
	Tue, 11 Jul 2023 07:09:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8579B1643F
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 07:09:47 +0000 (UTC)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83367B1;
	Tue, 11 Jul 2023 00:09:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1b8ad907ba4so26448695ad.0;
        Tue, 11 Jul 2023 00:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689059386; x=1691651386;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fAJEHFRFccEP7Hb1nj3eYe98VEYPI6ml6BwcBewRA5E=;
        b=nbpiEakzvYmhH+PxYKc6d8A+ReCPDESUY8Pxk32+sCNiC8no7y5S6A8SQSqjypPQtK
         Hh3KhOAIlYZSsYsOjUAa5+qIxpNIdnyflqrxtQUqGTWOHLFDvd/fuuLa9CU/rpcDCqGg
         oE0gIBia8bENDnmQN2xR7Iae3UQz1kfGc5wTbC3WBS6lMpXSWyh611PdAVHXHh9tDDq7
         FS1QxvO6BUJnQ7Obw8IpyRJhc5RNSXWMrhHQED37csVsIYwgIXFTMVxeUlc4SIo40Jy4
         N8X5HJcuJnKR+w1yaXPlVGcgP7B+JA/mS2JrJGwltVHHGHmmzJc0uIbtqaX3q7sOqMDo
         W3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689059386; x=1691651386;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAJEHFRFccEP7Hb1nj3eYe98VEYPI6ml6BwcBewRA5E=;
        b=Tp3MASsmtLL4s7LxUVHZrshCyH5tzybaLPE652H/YbsHcrm6ZDhQWons2w7tcoRHAf
         4PgKBfc6MrDJJu02kFbGsK1tT87DkVBGAxXlOLKI2hY/6quu84RorwHs7lri9alQyn7x
         EwLu0ROWUeRu1em0y9IjB+7mllNtlm72rb7nI4DvKgJNqPfo84acafs9M8CtZqN9Ite5
         m55iqq1z4jCLNVBIxkCqEdYUVI4zIVGdj3o/tlRoapNe6Rw4O0xUSY+cifFmhjCesqoY
         R+NMkfle7OrrX2X5WAyQFi1Z3Twi21gumK9cKCLehbJYkNIK3NpSfU1HMhiv7dc0pVEm
         Bxpw==
X-Gm-Message-State: ABy/qLYc2YFvxfKOzA3bwJgwvIhiAhgmx5fIS8ATx1ohdVK/eLup5OQG
	scwijkSzlg63uHoH836ajrM=
X-Google-Smtp-Source: APBJJlHrtIgjsHLonBaeZTbTsatRDdcxyV/hePRGrjVnGQSPPl98ByiRPgY7VVRlGtK/YHhqJVLrlA==
X-Received: by 2002:a17:903:482:b0:1b8:a2af:fe23 with SMTP id jj2-20020a170903048200b001b8a2affe23mr11426619plb.2.1689059385957;
        Tue, 11 Jul 2023 00:09:45 -0700 (PDT)
Received: from ?IPV6:2409:893c:3630:6d3:a311:402f:5c08:744e? ([2409:893c:3630:6d3:a311:402f:5c08:744e])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709027d9200b001ac7f583f72sm1067870plm.209.2023.07.11.00.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 00:09:45 -0700 (PDT)
Message-ID: <665fac58-f258-6824-5eb0-c185deac33de@gmail.com>
Date: Tue, 11 Jul 2023 15:09:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: John Sanpe <sanpeqf@gmail.com>
Subject: Re: [PATCH v2 2/2] libbpf: fix some typo of hashmap init
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Stanislav Fomichev <sdf@google.com>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230710055614.1030300-1-sanpeqf@gmail.com>
 <ZKw+6edWZJoSPGdn@google.com>
 <CAEf4Bzb-xSmpVFM_nCX7DgLuT=tR2GRCDHa0mw8FwO-rpy3xoA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEf4Bzb-xSmpVFM_nCX7DgLuT=tR2GRCDHa0mw8FwO-rpy3xoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/11/23 05:12, Andrii Nakryiko wrote:

> On Mon, Jul 10, 2023 at 10:25 AM Stanislav Fomichev<sdf@google.com>  wrote:
>> On 07/10, John Sanpe wrote:
>>> Remove the whole HASHMAP_INIT. It's not used anywhere in libbpf.
>>>
>>> Signed-off-by: John Sanpe<sanpeqf@gmail.com>
>> Acked-by: Stanislav Fomichev<sdf@google.com>
>>
>> Doesn't look like it was ever used.
> Ack for the change, but the subject doesn't correspond to the change
> itself. You are not fixing typo, you are removing static
> initialization helper.

Thanks for your suggestion, I have merged the two commits and used a 
more reasonable subject in v3:

https://lore.kernel.org/all/20230711070712.2064144-1-sanpeqf@gmail.com



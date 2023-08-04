Return-Path: <bpf+bounces-7034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5636770704
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 19:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0F9282716
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 17:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BAF1AA89;
	Fri,  4 Aug 2023 17:25:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F47EBE7C
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 17:25:32 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A3946A6
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 10:25:31 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-585fd99ed8bso49390777b3.1
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691169930; x=1691774730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FP2h4709BRlf+Vb2BEZujn0tSX7QuuNCavjE0Fb7j1A=;
        b=TunUrltLvJ9VkWcqEnyFndT/gHII6x7v6kiC+yEjKXVz+Q1KJxvK9UfmZo3aM0HDDb
         zcp/5cVeh+3cIwj+FuXff5eKzj6apGqI04abDPV7tFc4VNb6vKhHt2MMuyCncwFClrli
         DRSwYHEIFbq0/TTxZmd4LCWiEEz+PWDIEpNi+eRkLrlIIIc9wY4EWA0EXF4SrgKChjiS
         Flke0PxmvTGKzuU1McRsSOUcBMaFZXYCxHCLPRbwOtDK2EKbIOx9FyMdoyOK9OVFa9MM
         9evo5thc2c27YlpZ13JztW/Rh0zKGU5+D0gvosU9cQu9DLU7RdAIIYNsS0DndHCCEuOS
         jpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691169930; x=1691774730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FP2h4709BRlf+Vb2BEZujn0tSX7QuuNCavjE0Fb7j1A=;
        b=WGrd7n7U6539s1foihhWo7U7cmpRkHC6zhykeG4csxJ9uAVIwL0meLuJF6Z6SngMor
         3XrD6z58FsKrooyH8mR2SJ945xxpZ6Qx6CrtQmSnVN9y+V0vnESpOGJWidNF7Lj8RTVu
         Gd8EFS3o15vXOTm//1ynTG18siLNkgm0BIfeZDWO6waQAmWeks3TDud0OfCGlocuyAJR
         PNAco90Om1QeeDPTMUj+SHEaQi/rD7kHBxbt2yl3qmKZJZ4wnlmhOsHvFSp2hQ3GO8YO
         xGkG+TW2Zb7m35Vm7iB0ztmrxezxPPTMX0s1tshxiU49Kj4MEuMGcUzcPpD5GsRvGdjZ
         Wahg==
X-Gm-Message-State: AOJu0Yz2pjCekKVxztrR07PwfSl9tk3gMGNeoIOO5N4LVQw9J+ptJvCB
	/cV5D8MFkvoGTNG5gk6loiU=
X-Google-Smtp-Source: AGHT+IHdNLFnArVKeOI3N4Tco1aAZ5Ehwb2ivXuYgdfc/gIy1XWdEyR1UfPTAeKHmuc4r1dHd/0s8g==
X-Received: by 2002:a0d:df55:0:b0:576:87b1:ae0d with SMTP id i82-20020a0ddf55000000b0057687b1ae0dmr417081ywe.21.1691169930231;
        Fri, 04 Aug 2023 10:25:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:174:cd0c:d94f:4c1f? ([2600:1700:6cf8:1240:174:cd0c:d94f:4c1f])
        by smtp.gmail.com with ESMTPSA id s4-20020a0dd004000000b005704c4d3579sm840785ywd.40.2023.08.04.10.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 10:25:29 -0700 (PDT)
Message-ID: <d872c37e-3066-71c1-0132-214a6cd4f97e@gmail.com>
Date: Fri, 4 Aug 2023 10:25:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next] bpf: fix bpf_dynptr_slice() to stop return an
 ERR_PTR.
Content-Language: en-US
To: yonghong.song@linux.dev, thinker.li@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com, Dan Carpenter <dan.carpenter@linaro.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20230803231206.1060485-1-thinker.li@gmail.com>
 <e1c0312b-636f-c1b1-fae4-76964afeca28@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <e1c0312b-636f-c1b1-fae4-76964afeca28@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/3/23 18:32, Yonghong Song wrote:
> 
> 
> On 8/3/23 4:12 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Verify if the pointer obtained from bpf_xdp_pointer() is either an 
>> error or
>> NULL before returning it.
>>
>> The function bpf_dynptr_slice() mistakenly returned an ERR_PTR. 
>> Instead of
>> solely checking for NULL, it should also verify if the pointer 
>> returned by
>> bpf_xdp_pointer() is an error or NULL.
>>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: 
>> https://lore.kernel.org/bpf/d1360219-85c3-4a03-9449-253ea905f9d1@moroto.mountain/
>> Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and 
>> bpf_dynptr_slice_rdwr")
>> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
Thanks!


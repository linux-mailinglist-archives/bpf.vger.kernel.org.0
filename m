Return-Path: <bpf+bounces-7561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AEF7793E2
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 18:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581CA1C21810
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 16:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFF75692;
	Fri, 11 Aug 2023 16:01:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D111707
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:01:50 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E5630D2
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 09:01:49 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-589a9fc7fc6so21752627b3.1
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691769709; x=1692374509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+l97p5LIv/+nwHAdYaWopnJ2wZeI0CX915zgLfwHoY=;
        b=I1k+hZ1fL2X+bZ3quzIO1WEJAyLMh1qbb1PoDX02kExdZ0700Iqhot5KRitQgaOjVG
         6HuEA77YD6KGodL6MRjWZ0pD5vuakJ8AUkX+ogIxD+RUT+ctKEvJspwg+6cxXIyZ7nKI
         OX29ETOPOXRI7GDrkDmlT/LfMWQiLWvO7y9vQCf9xMxjPF2TnkXssPZe9i6HPjAbDdTW
         eWWymQEWCEg3GbX9cxta9IYhb3RK0AoBaLBd1JvNR4bZV/P/g9dThz6PFpQnLZ9vlJGQ
         zlwwERjgPm43TbranqNxHU0ncLQTtqF2gZ4of1AtS9dd/8H0u3qoNZ7yukUT1mO9p/lC
         K+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769709; x=1692374509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+l97p5LIv/+nwHAdYaWopnJ2wZeI0CX915zgLfwHoY=;
        b=GhJqxypNEdz9gOMvW202ah0c5DgAxaIg4AVPej+zQCwCbYbQmObndz1Mg6GIo/Tvev
         T0AhFDpbZqaRGnCEKDUvho+mrcnKnxKE3Fe0aEjM2S7s2GhnVKA2KEVEwasmWoEt4Z/r
         r/fJ2/ZzZo182L+iFk0Rma9qNrzOBMHgIsp6i+fVZVGY33hNfm13J9NWVnRRFk6eqfEV
         oaP4oS7I149ba2ih/5hF7eSbvsDlImGRCLyNzle3Uw9OaJeUSFIDNOu9i6quXhyMm6pi
         eLKM7GvWgYtXfsXwPddlzCxuHsu2gU9uhr89SvdcEkl7icjaHBGwsQRlVdmQ9jLyKKvg
         eq8w==
X-Gm-Message-State: AOJu0YxxPjqcd1h7TYCe4eyzFZe+wgMV+iGyhpwMTnbbLbRYHpvMeNVy
	dTmppEgugM4nCsKflTs+Ebo=
X-Google-Smtp-Source: AGHT+IE0FO465+uicNNc/h5TXjzO9G79rb+LK7NblvOj0GszOSGeNSKUZaq7WdPpFgovmWvksZhhLw==
X-Received: by 2002:a81:8081:0:b0:57a:8de8:6f88 with SMTP id q123-20020a818081000000b0057a8de86f88mr2243206ywf.22.1691769708694;
        Fri, 11 Aug 2023 09:01:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:8983:2941:ca8e:8213? ([2600:1700:6cf8:1240:8983:2941:ca8e:8213])
        by smtp.gmail.com with ESMTPSA id s10-20020a81770a000000b005845e6f9b50sm1066991ywc.113.2023.08.11.09.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 09:01:48 -0700 (PDT)
Message-ID: <43d2e15e-361b-adc4-05be-c11843c05d50@gmail.com>
Date: Fri, 11 Aug 2023 09:01:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next v2 2/6] bpf: Prevent BPF programs from access the
 buffer pointed by user_optval.
To: yonghong.song@linux.dev, thinker.li@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, sdf@google.com
Cc: kuifeng@meta.com
References: <20230811043127.1318152-1-thinker.li@gmail.com>
 <20230811043127.1318152-3-thinker.li@gmail.com>
 <528b748b-6893-016c-a921-a37748213bbe@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <528b748b-6893-016c-a921-a37748213bbe@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/10/23 23:27, Yonghong Song wrote:
> 
> 
> On 8/10/23 9:31 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <kuifeng@meta.com>
>>
>> Since the buffer pointed by ctx->user_optval is in user space, BPF 
>> programs
>> in kernel space should not access it directly.  They should use
>> bpf_copy_from_user() and bpf_copy_to_user() to move data between user and
>> kernel space.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> 
> You probably only want
>     Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> since it matches email 'From'. Also,
>     From: Kui-Feng Lee <kuifeng@meta.com>
> is different from email 'From'. Strange.


Got it!sssssssssssssss

> 
> [...]


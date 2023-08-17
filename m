Return-Path: <bpf+bounces-8015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C81177FE3F
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 21:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7D4282075
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 19:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BEF18023;
	Thu, 17 Aug 2023 19:00:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAE214AA6
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 19:00:10 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8336F2722
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 12:00:08 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-56c85b723cfso118944eaf.3
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692298808; x=1692903608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bl0oJJLRWxGdeUOwUxophw+2BKzi7z8MwV1uJYNczH8=;
        b=mip5RIKau2axqdVziy+M54CqPlu0ysvmHpAm8/Pk0/iB30bbCgz3lvEgPbrXCJRsS9
         8NuVrQiPEGpsnKAUsurFm/H7ET9m7A8oz8BzHWttHnPODUBXOc4XP58hJvdCpM2y9HOS
         wx6Pnl7YyLJpXrnukx+U9lC65Z+jD4WW+06nQjJgevnmEm6KaI7Jnc1dj7Bvtk5jV66Q
         4UGkxVgQUpI/im4OeXS2ZlTFMwIiLkrqDpww6AIKG0HfL2dz/AFsgtIeVHVbe4b7j6b2
         p+rALYfqfRnvyWgFZYTJKusPZSol4RGZIEOldpM3cb639IxgcpPmYSvKBF92Umw6StQi
         NaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692298808; x=1692903608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bl0oJJLRWxGdeUOwUxophw+2BKzi7z8MwV1uJYNczH8=;
        b=C7YAxucofMgVlT3Y5H6ZS/muCZ6SD0fHxFpSSmoIMGy8wRvBUIU9PE/JuTT7lFls+8
         IUi5A03/kt5K+7f1bsztLUv7EXE9JbB1COtO6EneIVJzT7B9Sb18RkOWwwipQpwSLOsP
         mZ3lzQNEhumlDizfkYKdsHHvUykgwJ0ydNQo6pPjn2BdznAj+SwCW0JRlae+kC98cqgQ
         TpRr2WzgwggZez4605aBF4QAic7g+glVqwb3PPQ0UyYyEQfl1+OY/sS+JuASnvWnecff
         1wY3dnKyN9jn77TEIAPfw3c58ujG+u0uOHERJsx7x5TyHe7M5L1cfWVF7B6eLsI7UDto
         pn2w==
X-Gm-Message-State: AOJu0Yyy7OrIeRbgR+kKBM/hMzSGWwfkayLDSgxtphbQ31fX1Gg+c/gC
	HpRRx1CoCUiUYcUkD+ah5EQ=
X-Google-Smtp-Source: AGHT+IFQncmOnYLn2Z5IqKurVW9gvJoDd8WpSRIG0rX4/eagud5LUpgSU4PwF6H4+dEmoCRJKYWEiQ==
X-Received: by 2002:a05:6358:c1f:b0:129:c50d:6a37 with SMTP id f31-20020a0563580c1f00b00129c50d6a37mr345973rwj.16.1692298807716;
        Thu, 17 Aug 2023 12:00:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:b6d:34bc:f82a:990? ([2600:1700:6cf8:1240:b6d:34bc:f82a:990])
        by smtp.gmail.com with ESMTPSA id d15-20020a814f0f000000b00584554be59dsm44295ywb.85.2023.08.17.12.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 12:00:07 -0700 (PDT)
Message-ID: <5dd24d8c-17b8-53d3-3701-93693a11279b@gmail.com>
Date: Thu, 17 Aug 2023 12:00:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next v3 4/5] bpf: Add a new dynptr type for
 CGRUP_SOCKOPT.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, sdf@google.com,
 yonghong.song@linux.dev, kuifeng@meta.com
References: <20230815174712.660956-1-thinker.li@gmail.com>
 <20230815174712.660956-5-thinker.li@gmail.com>
 <20230817012518.erfkm4tgdm3isnks@MacBook-Pro-8.local>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230817012518.erfkm4tgdm3isnks@MacBook-Pro-8.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/16/23 18:25, Alexei Starovoitov wrote:
> On Tue, Aug 15, 2023 at 10:47:11AM -0700, thinker.li@gmail.com wrote:
>>   
>> +BTF_SET8_START(cgroup_common_btf_ids)
>> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_copy_to, KF_SLEEPABLE)
>> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_alloc, KF_SLEEPABLE)
>> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_install, KF_SLEEPABLE)
>> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_release, KF_SLEEPABLE)
>> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_from, KF_SLEEPABLE)
>> +BTF_SET8_END(cgroup_common_btf_ids)
> 
> These shouldn't be sockopt specific.
> If we want dynptr to represent a pointer to a user contiguous user memory
> we should use generic kfunc that do so.
> 
> I suspect a single new kfunc: bpf_dynptr_from_user_mem() would do.
> New dynptr type can be hidden in the kernel and all existing
> kfuncs dynptr_slice, dynptr_data, dynptr_write could be made to work
> with user memory.
> 
> But I think we have to step back. Why do we need this whole thing in the first place?
> _why_ sockopt bpf progs needs to read and write user memory?
> 
> Yes there is one page limit, but what is the use case to actually read and write
> beyond that? iptables sockopt was mentioned, but I don't think bpf prog can do
> anything useful with iptables binary blobs. They are hard enough for kernel to parse.

The ideal behind the design is let the developers of filters to decide
when to replace the existing buffer.  And, access the content of
buffers just like accessing raw pointers. However, seems almost everyone
love to use *_read() & *_write(). I will move to that direction.


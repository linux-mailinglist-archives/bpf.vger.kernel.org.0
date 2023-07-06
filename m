Return-Path: <bpf+bounces-4210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6C774989E
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 11:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52411C20CFE
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 09:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1308C7498;
	Thu,  6 Jul 2023 09:36:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21EC185A;
	Thu,  6 Jul 2023 09:36:40 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D639171D;
	Thu,  6 Jul 2023 02:36:39 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-56352146799so307102eaf.3;
        Thu, 06 Jul 2023 02:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688636198; x=1691228198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0TR7CywRQO+aq8xLN85+i2ij1DCchNy9h8cDmr7LMVY=;
        b=n958nsaYsRJ0cV+cDdTPfS/mR4DvFnNL2P6duh7QjfojO67n8rowyY9+n+M3k+MlwT
         M+n8HlwVBM+aRezimBkj8akqMv+a2kxsTZE2hih2hyv6tryc9vDzVXM9FaxnmgnGJRx2
         oOhRt+ZFBXYSLKC8Clv9BCAQNo5J2RyiUbuqNGLPyy/ooB2ue6ARmvmc9+USvXvi4a9X
         3Mpd/uvbDB/VwRiqlIXc4jXb1eqjxjHAY423OUCZUmIVhi2ecbDpm1RKXDfgkTwj6uBX
         p0M0Nrws7XMO83LhU3u9+BADCgk9cIXyZsW+IwttpzLgxQjBBgbvsRFiG9izSkzjoc09
         h6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688636198; x=1691228198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0TR7CywRQO+aq8xLN85+i2ij1DCchNy9h8cDmr7LMVY=;
        b=WJJkH/fmptXN5zt6UGrRl+NDoU9yKkEHKgMov/+qL2w4JY2zvn1BIdmXa4tKKkOb4g
         rEVO47XbNHuQA0PKRcvYMgNQwB8xCwacoh1nvlkz1yZCTN1KUrA+ZN2aF9g17tQer+Sz
         PShOdUOqMdGmks7B4yIs4/gN0k1/LuyA7ogu63epqTjHNkI8sVUy8aBlTbY/0zRw42hf
         Xm3uLjG8OgpuHvS35gCADfJ6cqI4HtubgOqbra9TlbgINdeWgvFPX8jujseErZSIxP2n
         oufNoebszPFDmy3oT1WpP18EYRi2uKWqCX03q4CEvoNbHkYWBV3mkdKab5vFi6lfTHGI
         m+TQ==
X-Gm-Message-State: ABy/qLYn7yDyMhDSkcMFO5jmIMKRjny/8qOY8ER7S8kkZZtvRaGGzFbk
	5Djqtvay3iix3stERtv17YA=
X-Google-Smtp-Source: APBJJlFgz9v5xjO3Kl70Hs+b7oagVUEpBIbdNA7dz/sx1WFquCj68yhoXxMCn21eqHwderVZZfJ6IA==
X-Received: by 2002:a05:6358:705:b0:134:f070:d6b8 with SMTP id e5-20020a056358070500b00134f070d6b8mr2261223rwj.4.1688636198238;
        Thu, 06 Jul 2023 02:36:38 -0700 (PDT)
Received: from [10.22.68.96] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id j14-20020aa7800e000000b0066875f17266sm893454pfi.135.2023.07.06.02.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 02:36:37 -0700 (PDT)
Message-ID: <a945ff6e-1cd7-ef03-9ab4-3e5ab2a3bfa8@gmail.com>
Date: Thu, 6 Jul 2023 17:36:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next] bpf: Introduce bpf generic log
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
 tangyeechou@gmail.com, kernel-patches-bot@fb.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20230705132058.46194-1-hffilwlqm@gmail.com>
 <1a205a85-ebf2-6d90-468d-4fd63ce3dd0f@iogearbox.net>
 <a42c246a-01e1-9e7e-8260-57835c6351ae@gmail.com>
 <688cbc7b-b23e-7edd-4603-b5734eaa9bd7@iogearbox.net>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <688cbc7b-b23e-7edd-4603-b5734eaa9bd7@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 6/7/23 00:54, Daniel Borkmann wrote:
> On 7/5/23 6:20 PM, Leon Hwang wrote:
>> On 2023/7/5 22:39, Daniel Borkmann wrote:
>>> On 7/5/23 3:20 PM, Leon Hwang wrote:
>>>> Currently, excluding verifier, users are unable to obtain detailed 
>>>> error
>>>> information when issues occur in BPF syscall.
>>>>
>>>> To overcome this limitation, bpf generic log is introduced to provide
>>>> error details similar to the verifier. This enhancement will enable 
>>>> the
>>>> reporting of error details along with the corresponding errno in BPF
>>>> syscall.
>>>>
>>>> Essentially, bpf generic log functions as a mechanism similar to 
>>>> netlink,
>>>> enabling the transmission of error messages to user space. This
>>>> mechanism greatly enhances the usability of BPF syscall by allowing
>>>> users to access comprehensive error messages instead of relying solely
>>>> on errno.
>>>>
>>>> This patch specifically addresses the error reporting in 
>>>> dev_xdp_attach()
>>>> . With this patch, the error messages will be transferred to user 
>>>> space
>>>> like the netlink approach. Hence, users will be able to check the 
>>>> error
>>>> message along with the errno.
>>>>
>>>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>>>> ---
>>>>   include/linux/bpf.h            | 30 ++++++++++++++++++++++++++++++
>>>>   include/uapi/linux/bpf.h       |  6 ++++++
>>>>   kernel/bpf/log.c               | 33 
>>>> +++++++++++++++++++++++++++++++++
>>>>   net/core/dev.c                 | 11 ++++++++++-
>>>>   tools/include/uapi/linux/bpf.h |  6 ++++++
>>>>   5 files changed, 85 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>> index f58895830..fd63f4a76 100644
>>>> --- a/include/linux/bpf.h
>>>> +++ b/include/linux/bpf.h
>>>> @@ -3077,4 +3077,34 @@ static inline gfp_t bpf_memcg_flags(gfp_t 
>>>> flags)
>>>>       return flags;
>>>>   }
>>>>   +#define BPF_GENERIC_TMP_LOG_SIZE    256
>>>> +
>>>> +struct bpf_generic_log {
>>>> +    char        kbuf[BPF_GENERIC_TMP_LOG_SIZE];
>>>> +    char __user    *ubuf;
>>>> +    u32        len_used;
>>>> +    u32        len_total;
>>>> +};
>>>> +
>>>> +__printf(2, 3) void bpf_generic_log_write(struct bpf_generic_log 
>>>> *log,
>>>> +            const char *fmt, ...);
>>>> +static inline void bpf_generic_log_init(struct bpf_generic_log *log,
>>>> +            const struct bpf_generic_user_log *ulog)
>>>> +{
>>>> +    log->ubuf = (char __user *) (unsigned long) ulog->log_buf;
>>>> +    log->len_total = ulog->log_size;
>>>> +    log->len_used = 0;
>>>> +}
>>>> +
>>>> +#define BPF_GENERIC_LOG_WRITE(log, ulog, fmt, ...)    do {    \
>>>> +    const char *____fmt = (fmt);                \
>>>> +    bpf_generic_log_init(log, ulog);            \
>>>> +    bpf_generic_log_write(log, ____fmt, ##__VA_ARGS__); \
>>>> +} while (0)
>>>> +
>>>> +#define BPF_GENERIC_ULOG_WRITE(ulog, fmt, ...)    do {            \
>>>> +    struct bpf_generic_log ____log;                    \
>>>> +    BPF_GENERIC_LOG_WRITE(&____log, ulog, fmt, ##__VA_ARGS__);    \
>>>> +} while (0)
>>>> +
>>>
>>> Could we generalize the bpf_verifier_log infra and reuse bpf_log() 
>>> helper
>>> instead of adding something new?
>>
>>
>> Yes. It's possible to reuse the bpf_verifier_log infra and reuse 
>> bpf_log()
>> helper. I'll try this way:
>>
>> #define BPF_LOG_USER  BPF_LOG_LEVEL1     /* user log flag */
>>
>> #define BPF_ULOG_WRITE(log_buf, log_size, fmt, ...) do {               \
>>         const char *____fmt = 
>> (fmt);                                    \
>>         struct bpf_verifier_log 
>> ____vlog;                               \
>>         bpf_vlog_init(&____vlog, BPF_LOG_USER, log_buf, 
>> log_size);      \
>>         bpf_log(&____vlog, ____fmt, 
>> ##__VA_ARGS__);                         \
>> } while (0)
>
> Could we hide all of this inside bpf_log() or better create a new 
> bpf_log_once() wrapper,
> passing in attr so we only need to use the latter w/o the extra macros?
>
> Essentially what your bpf_xdp_link_log() is doing, just that 
> bpf_log_once(attr, extack._msg)
> would be generic and sufficient.
>
> Thanks,
> Daniel

I try to use BPF_ULOG_WRITE() successfully, but with a warning:


net/core/dev.c: In function 'bpf_xdp_link_log.isra.0':
net/core/dev.c:9093:1: warning: the frame size of 1056 bytes is larger 
than 1024 bytes [-Wframe-larger-than=]
  9093 | }
       |


How should we generalize the bpf_verifier_log infra with a smaller

BPF_VERIFIER_TMP_LOG_SIZE (1024 currently) ?


If to use bpf_log_once(attr, extack._msg), I think 
bpf_ulog_once(&attr->link_create.xdp.log, extack._msg)

is better. attr->link_create.xdp.log is struct bpf_generic_user_log.

Or bpf_xdp_link_log() is better to wrap log details.



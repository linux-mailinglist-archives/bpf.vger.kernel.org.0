Return-Path: <bpf+bounces-6484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C35F76A3DD
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 00:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5528C1C20D74
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 22:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA95D1E534;
	Mon, 31 Jul 2023 22:02:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7856C1DDC5
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 22:02:55 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C564E7
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 15:02:53 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1bed90ee8b7so949431fac.0
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 15:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690840973; x=1691445773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pIR/g2bc3EklzK5P8OHzEHuOKelo94F+rp0af5finqQ=;
        b=m9jUAexOBboYaLbTXMKa49qLrDkbWJx4tIXkyPIKnaAPGZ7mIPcBQcRNbdXZWmEKA6
         Vr7W49znL6qyf8tVjWFcddGyBxcf4yfiRvfxrLF1rYujG7wrqyJop7mwg7DxREkdbrEK
         d66VqfIu+x3E/vjnAWN0Vmzg49ndmVqlNaquDjcVJ9ZvGkChxaqWL76lT3hsiDcHGwJH
         fiY+0dYGV/NJ2Twpnox6K4+fzw1E6FbgptZ3l78wsH6GgJMnPW/uTOnMz/cZJ/L+xHGe
         Je76qf4BrOjQIWNBA9LJltZ9S8jHoFLJ6e6IEGgcY3ZX1qBF8bWA17Q2bMreppe4116H
         Zqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690840973; x=1691445773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pIR/g2bc3EklzK5P8OHzEHuOKelo94F+rp0af5finqQ=;
        b=XCHvVE0nklXXyTB2HAduMGMk/zzx/qSTLDwCzOkNbPGdBkdBC5nB6Xf4DQjyTJ3MJ5
         vQeSLYgi1EpRgQs/RGul2iv59Z4k2gNSPlxnZEWtttvotRkMKiiRbzb42xfcfGVsiDoK
         dkEbvUAcHAd+hVLBN0kw8nDFwNwn7ByTuglkOL1fYAq3QATzf5M/B9N0vYybspjDpIug
         n4ZAdKTkTJP8K3s6g2Yon+RyLNrMCMZz6lfpOQMDROyExyMK6GZzX+FBfjKFI/jvJ/bx
         Ty9Aok8wZ6knRzT+lUonbwO8v1YFAtjco9lhchDvQOczHI/hfhHBgDCEONz9Ep+RgX3S
         JLig==
X-Gm-Message-State: ABy/qLbqXVZw/d19VgtJbANHYNX2gqDl3+4OhlbaW5RRXs82iszgQjkb
	ILIF1hYeRgV96QIxfjoXi8A=
X-Google-Smtp-Source: APBJJlG491/Rt0VRMGK1U90bjqbgBWP/MN+mPtkDgTwkC6H8Qil5H/ieGtp+KhfbAH71vL6nTSJl3g==
X-Received: by 2002:a05:6870:4708:b0:1bb:9dfd:f4dc with SMTP id b8-20020a056870470800b001bb9dfdf4dcmr10845251oaq.19.1690840972647;
        Mon, 31 Jul 2023 15:02:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:f8ab:246f:fcd3:4e5d? ([2600:1700:6cf8:1240:f8ab:246f:fcd3:4e5d])
        by smtp.gmail.com with ESMTPSA id w204-20020a0dd4d5000000b00583d67839fasm3290614ywd.121.2023.07.31.15.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 15:02:52 -0700 (PDT)
Message-ID: <00dbd930-5ec2-7fb6-202b-38d09e13eb0b@gmail.com>
Date: Mon, 31 Jul 2023 15:02:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next 1/5] bpf: enable sleepable BPF programs attached to
 cgroup/{get,set}sockopt.
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, kuifeng@meta.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230722052248.1062582-1-kuifeng@meta.com>
 <20230722052248.1062582-2-kuifeng@meta.com> <ZL7Ery1lzqj4as7N@google.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZL7Ery1lzqj4as7N@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sorry for the late reply! I just backed from a vacation.


On 7/24/23 11:36, Stanislav Fomichev wrote:
> On 07/21, kuifeng@meta.com wrote:
>> From: Kui-Feng Lee <kuifeng@meta.com>
>>
>> Enable sleepable cgroup/{get,set}sockopt hooks.
>>
>> The sleepable BPF programs attached to cgroup/{get,set}sockopt hooks may
>> received a pointer to the optval in user space instead of a kernel
>> copy. ctx->user_optval and ctx->user_optval_end are the pointers to the
>> begin and end of the user space buffer if receiving a user space
>> buffer. ctx->optval and ctx->optval_end will be a kernel copy if receiving
>> a kernel space buffer.
>>
>> A program receives a user space buffer if ctx->flags &
>> BPF_SOCKOPT_FLAG_OPTVAL_USER is true, otherwise it receives a kernel space
>> buffer.  The BPF programs should not read/write from/to a user space buffer
>> dirrectly.  It should access the buffer through bpf_copy_from_user() and
>> bpf_copy_to_user() provided in the following patches.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   include/linux/filter.h         |   3 +
>>   include/uapi/linux/bpf.h       |   9 ++
>>   kernel/bpf/cgroup.c            | 189 ++++++++++++++++++++++++++-------
>>   kernel/bpf/verifier.c          |   7 +-
>>   tools/include/uapi/linux/bpf.h |   9 ++
>>   tools/lib/bpf/libbpf.c         |   2 +
>>   6 files changed, 176 insertions(+), 43 deletions(-)
>>
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index f69114083ec7..301dd1ba0de1 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -1345,6 +1345,9 @@ struct bpf_sockopt_kern {
>>   	s32		level;
>>   	s32		optname;
>>   	s32		optlen;
>> +	u32		flags;
>> +	u8		*user_optval;
>> +	u8		*user_optval_end;
>>   	/* for retval in struct bpf_cg_run_ctx */
>>   	struct task_struct *current_task;
>>   	/* Temporary "register" for indirect stores to ppos. */
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 739c15906a65..b2f81193f97b 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7135,6 +7135,15 @@ struct bpf_sockopt {
>>   	__s32	optname;
>>   	__s32	optlen;
>>   	__s32	retval;
>> +
>> +	__bpf_md_ptr(void *, user_optval);
>> +	__bpf_md_ptr(void *, user_optval_end);
> 
> Can we re-purpose existing optval/optval_end pointers
> for the sleepable programs? IOW, when the prog is sleepable,
> pass user pointers via optval/optval_end and require the programs
> to do copy_to/from on this buffer (even if the backing pointer might be
> in kernel memory - we can handle that in the kfuncs?).
> 
> The fact that the program now needs to look at the flag
> (BPF_SOCKOPT_FLAG_OPTVAL_USER) and decide which buffer to
> use makes the handling even more complicated; and we already have a
> bunch of hairy stuff in these hooks. (or I misreading the change?)
> 
> Also, regarding sleepable and non-sleepable co-existence: do we really need
> that? Can we say that all the programs have to be sleepable
> or non-sleepable? Mixing them complicates the sharing of that buffer.

I considered this approach as well. This is an open question for me.
If we go this way, it means we can not attach a BPF program of a type
if any program of the other type has been installed.



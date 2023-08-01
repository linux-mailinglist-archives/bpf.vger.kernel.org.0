Return-Path: <bpf+bounces-6527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AE876A98B
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 08:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410FB281057
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 06:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DF063D0;
	Tue,  1 Aug 2023 06:53:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C438D611B
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 06:53:11 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4ACC6
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 23:53:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4040738a12.1
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 23:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690872789; x=1691477589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MhlIfhe6t4kTcIvTYJKrWsmkQqO8HfOd2ecUpgycz/E=;
        b=LVUBwf8RVARX2umwNwUWVEf7YhOcuiEYLwXY42jE8cRMn9jVtUBxM9CsA51m5svKv0
         aaeUhCMrTtdbEG580lnIn6sz6Pjzl4ivlFdXQ9UcM0cNWIZYnCBaGCMIMTT+nCD/yDcM
         8WqZZAoBovneVvUyfbdLc2lSR/swmmx0Mt5cA/9HIbWlxcI2YijOrd9Xi3LUCp3pCpFK
         Gnz1cDFTLnjoNyMq1tE9VUKCWiw90HsfL7jGSkBx0O5lyJapczvJmJQ3xBRYd2r7BEsj
         odIIdrl/CWQ2zK6UwBflLE8VtNITPGm0Ahs7eMOtcSIT7UWwRVjAsTvL911aHMFigi2X
         SKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690872789; x=1691477589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhlIfhe6t4kTcIvTYJKrWsmkQqO8HfOd2ecUpgycz/E=;
        b=KRcIf3NP16h7IPBXEVsTJ82EElacb2wv6hvzBg3fmXbOH6WV+to8obgWc5WM4ww51h
         TbQOrO37B23TM8Ajp5G17A+j0ta9k/p/M9Hjk/wgYzh0KIBUHVOSMRWZj1uGcVTrEZHW
         faaT6Py11tIApm+CA7Se2fg34uIAnGSw7MHfTI3W3tR0yJyHQusfTXDT7aM2CEwHNZhy
         HtBMT0s1MNl37pfCAxeM6FOyQjSsHlP0P/3B3U3b6yzm1Idll/Kbcq4lQNS1svJuoErZ
         ycxzpE9CS+RBhgoqm1OydVyArlpLQiCiGGH1AdRGK6kouZih95azDF+G7p27MvHPhxN5
         Rh1A==
X-Gm-Message-State: ABy/qLZ7YKXk7bTEhxJRFUHEduEfv1xekFFtkAGVbeS6b9BysAFGsKaF
	JuCn6pJWZzddxD+XEJrUqjmxsw==
X-Google-Smtp-Source: APBJJlG/SsJjlaV/QMxtmqFCo8lqOiX16OzPxSvFMDwqFsM4rxccjXX+eml0I83yGB5kxChGPp9ZfQ==
X-Received: by 2002:a17:902:a510:b0:1bc:2188:ef88 with SMTP id s16-20020a170902a51000b001bc2188ef88mr1723154plq.3.1690872789658;
        Mon, 31 Jul 2023 23:53:09 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:11bb:1457:9302:1528:c8f4? ([240e:694:e21:b::2])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001b9ff5aa2e7sm9647662pll.239.2023.07.31.23.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 23:53:09 -0700 (PDT)
Message-ID: <bb1fc46e-5573-71f7-d0fa-cb74fcfc61c3@bytedance.com>
Date: Tue, 1 Aug 2023 14:53:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.1
Subject: Re: Re: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
Content-Language: en-US
To: Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@suse.com>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, robin.lu@bytedance.com
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <ZMInlGaW90Uw1hSo@dhcp22.suse.cz> <ZMNESaE/tWgRd4FI@P9FQF9L96D>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <ZMNESaE/tWgRd4FI@P9FQF9L96D>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/28/23 12:30 PM, Roman Gushchin wrote:
> On Thu, Jul 27, 2023 at 10:15:16AM +0200, Michal Hocko wrote:
>> On Thu 27-07-23 15:36:27, Chuyi Zhou wrote:
>>> This patchset tries to add a new bpf prog type and use it to select
>>> a victim memcg when global OOM is invoked. The mainly motivation is
>>> the need to customizable OOM victim selection functionality so that
>>> we can protect more important app from OOM killer.
>>
>> This is rather modest to give an idea how the whole thing is supposed to
>> work. I have looked through patches very quickly but there is no overall
>> design described anywhere either.
>>
>> Please could you give us a high level design description and reasoning
>> why certain decisions have been made? e.g. why is this limited to the
>> global oom sitation, why is the BPF program forced to operate on memcgs
>> as entities etc...
>> Also it would be very helpful to call out limitations of the BPF
>> program, if there are any.
> 
> One thing I realized recently: we don't have to make a victim selection
> during the OOM, we [almost always] can do it in advance.

I agree. We take precautions against memory shortage on over-committed
machines through oomd-like userspace tools, to mitigate possible SLO
violations on important services. The kernel OOM-killer in our scenario
works as a last resort, since userspace tools are not that reliable.
IMHO it would be useful for kernel to provide such flexibility.

> 
> Kernel OOM's must guarantee the forward progress under heavy memory pressure
> and it creates a lot of limitations on what can and what can't be done in
> these circumstances.
> 
> But in practice most policies except maybe those which aim to catch very fast
> memory spikes rely on things which are fairly static: a logical importance of
> several workloads in comparison to some other workloads, "age", memory footprint
> etc.
> 
> So I wonder if the right path is to create a kernel interface which allows
> to define a OOM victim (maybe several victims, also depending on if it's
> a global or a memcg oom) and update it periodically from an userspace.

Something like [1] proposed by Chuyi? IIUC there is still lack of some
triggers to invoke the procedure so we can actually do this in advance.

[1] 
https://lore.kernel.org/lkml/f8f44103-afba-10ee-b14b-a8e60a7f33d8@bytedance.com/

Thanks & Best,
	Abel


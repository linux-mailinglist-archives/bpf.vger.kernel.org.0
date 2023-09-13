Return-Path: <bpf+bounces-9875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F75B79E157
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 10:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597E7281F6E
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EC11DA43;
	Wed, 13 Sep 2023 08:00:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC31DA2E
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 08:00:25 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A8BD3
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 01:00:25 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-570836f1c79so4615572a12.0
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 01:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694592025; x=1695196825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIwCz4faVfGKEVy049aFmV+8W59Pfbk4tk2yjPYgoB8=;
        b=JQ9dHnxXqwxlhV3ZE+L2zLI3zRPAs0D80hjuj15dYucpBFGwTuJF1Ns9Tl0HhDQmBc
         GwszwtZy7K0aFM/bvOABgai+q5dAveYh8UxxmcCLVHrgnC2wNAaYII6v6rn8YuissJJG
         9V7jxa3pIcgZrxACAyEARRRQQMVKyhEPw/MkYAddk3a7UHE+A8+MAseAVgGSi/R37fdP
         1UwDHi3HRHsUIazL29FkCDpqOwtBuvb30q+vaEEANWpCerCDrMhCtUL2g2pwcqfG0ujk
         9a72SFT4NdZ6ZGJzoesISib0H0/CsJmdQkrr6SrW57zlvjT692Jis6p/xvuU9KMrKXNk
         LORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694592025; x=1695196825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dIwCz4faVfGKEVy049aFmV+8W59Pfbk4tk2yjPYgoB8=;
        b=gC7kMrQqdOQPslDc88CpDE2oWcU6kMsKMEItfbcReR7q77TzB7sBPUVUYwbAkrHfb2
         CeWiSQXxIwcAh6BgvtFkLcvsp5zHeIabA7jwEubZtSymLJ7qtd1sFmR+AjWqXLYSmQZp
         TUToVj0IzG5xz+C2NVJ+AoWRH/J7hiKtYVsWwpqfITDZWUrICyyBlXrgp5UjiW1FP5LZ
         o5fsxC55ujQ1xi5dJ8jB6MFq42CX5+VknjJVuUn0Jn01ePvJB2Rj/Kq500xLbl8jD7hz
         pxxPbeWLsR4CooHk7/ERzqAVrbKb2cc8oCc9suyl8Ix2A3flJIRoKyZqDeeNfBsJsdWw
         y5Yw==
X-Gm-Message-State: AOJu0YySafNW6xaoY9CplRN663zACVDH+BCcL1rFbRcAlkfUM5L3MqYi
	oVeqrovwueUrTdA4l36t/4L1Fg==
X-Google-Smtp-Source: AGHT+IGSfghnaKlgMzQ4SkAe9zaZTX6miCTsIa8a3+D7CDVac7Rg1w4Q94HbBRGXRM1BmbIAX+07Ig==
X-Received: by 2002:a05:6a21:19b:b0:152:efa4:228 with SMTP id le27-20020a056a21019b00b00152efa40228mr1956725pzb.20.1694592024709;
        Wed, 13 Sep 2023 01:00:24 -0700 (PDT)
Received: from [10.254.99.16] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id d11-20020a170903230b00b001bb99ea5d02sm9794632plh.4.2023.09.13.01.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:00:24 -0700 (PDT)
Message-ID: <89afc718-b5e5-38e4-6698-bb28b80e2c83@bytedance.com>
Date: Wed, 13 Sep 2023 16:00:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v2 1/5] mm, oom: Introduce bpf_oom_evaluate_task
To: Bixuan Cui <cuibixuan@vivo.com>, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, muchun.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com,
 Michal Hocko <mhocko@suse.com>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-2-zhouchuyi@bytedance.com>
 <e88fe274-cd53-40d4-9a8e-7c6a4e1d8c44@vivo.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <e88fe274-cd53-40d4-9a8e-7c6a4e1d8c44@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello, Bixuan.

在 2023/9/13 09:18, Bixuan Cui 写道:
> 
> 
> 在 2023/8/10 16:13, Chuyi Zhou 写道:
>> +#include <linux/bpf.h> #include <linux/oom.h> #include <linux/mm.h> 
>> #include <linux/err.h> @@ -305,6 +306,27 @@ static enum oom_constraint 
>> constrained_alloc(struct oom_control *oc) return CONSTRAINT_NONE; } 
>> +enum { + NO_BPF_POLICY, + BPF_EVAL_ABORT, + BPF_EVAL_NEXT, + 
>> BPF_EVAL_SELECT, +}; +
> 
> I saw that tools/testing/selftests/bpf/progs/oom_policy.c is also using 
> NO_BPF_POLICY etc. I think
> +enum {
> +    NO_BPF_POLICY,
> +    BPF_EVAL_ABORT,
> +    BPF_EVAL_NEXT,
> +    BPF_EVAL_SELECT,
> +};
> +
> definitions can be placed in include/linux/oom.h
> 

Thanks for your feedback!

Yes, Maybe we should move these enums to a more proper place so that 
they can be generated by BTF and we can take them from vmlinux.h.

> Thanks
> Bixuan Cui


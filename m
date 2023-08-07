Return-Path: <bpf+bounces-7110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ECD77183D
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 04:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4911C20909
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 02:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77A880E;
	Mon,  7 Aug 2023 02:21:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E31B392
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 02:21:16 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747271709
	for <bpf@vger.kernel.org>; Sun,  6 Aug 2023 19:21:14 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bbd03cb7c1so24989895ad.3
        for <bpf@vger.kernel.org>; Sun, 06 Aug 2023 19:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691374874; x=1691979674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpfBoE9Y590w/Sf+Dz/Le636FBNjqDAu8TPrvM1o1jQ=;
        b=IsiyqTVDpnFsGxkGGtd9mPI4j9dDCr8HtUmQl/O5Y+/h3Q387L9jARgAMHQx8keKIQ
         jNnF3fs2cPSI2voNKdrnUdH+q0ZUJ73HCLveN3x5CvahdowTzMzrAseNDIc4n1vJLi1X
         cMo8+jLmUZQqHd5GfMA9R4W33GOKcND52FQMgrrkMW03KpymaUotXs5kvVsOqicjzXi9
         4QNB3thQdacEU6Sg4aOnsRjx4Ahf+b+efIVvjM5qPqQw1RLprLmtIZtTrk0pLzN54WUn
         WSTFULU5KwhfEUceEncA7l7Yif6T0sWzsbaswU5VvUO6updvur/kedBQZiCE0cSYf29S
         MJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691374874; x=1691979674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dpfBoE9Y590w/Sf+Dz/Le636FBNjqDAu8TPrvM1o1jQ=;
        b=lqQ13NwA1Y6afX5M2uYPyZ+qabOwD1pS2nvCEZVBu12RMzpysFr9EzrBKU2l/Wrwvj
         Dgn/sRaWVA940hTffssIdrzBflOp0rPj2Ngr+A8obDBTPNY0nnztmUzWwfzFMQkvSQYT
         mpkSRN3w+SFQtylWTO7LETVf3rmkCMTJC/0GENhVBMdolPWkBz8ovmqp4mZyln7ef/ZG
         wsENT9BnvRmUPUtlzai3mRrYELSTGGAGan4hcEWIlB++IYgQcSAcXDBylK7fwKFzEfgf
         Ayw34xE60FwwK3EkIsR51lxNThme0oPQ6TNtGBcfVPW59sSlTPZY914OGXJMu9d6PDPj
         icKw==
X-Gm-Message-State: AOJu0Yx3CXqp5kzfX7UrQ7RM7z+k5O3ZudZFxZRE6wOn/Pth5OlRL5wW
	cjaXdLbsk62F4hLw/ECUSG6zRw==
X-Google-Smtp-Source: AGHT+IGXf1jXu+iFSbvQC0e3gpDtxmxqpYliUoFhZtb1FgsrjGnia6rlH1z2J9bd4to0NexKFX7gHg==
X-Received: by 2002:a17:902:a505:b0:1b9:ebf4:5d2 with SMTP id s5-20020a170902a50500b001b9ebf405d2mr6181704plq.33.1691374873796;
        Sun, 06 Aug 2023 19:21:13 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:11b8:85a:5d8b:9c7a:fbf2? ([240e:694:e21:b::2])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b001bb04755212sm5482892pls.228.2023.08.06.19.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 19:21:13 -0700 (PDT)
Message-ID: <866462cf-6045-6239-6e27-45a733aa7daa@bytedance.com>
Date: Mon, 7 Aug 2023 10:21:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
To: Michal Hocko <mhocko@suse.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
 robin.lu@bytedance.com
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
 <20230804093804.47039-2-zhouchuyi@bytedance.com>
 <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
 <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
 <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/8/4 21:34, Michal Hocko 写道:
> On Fri 04-08-23 21:15:57, Chuyi Zhou wrote:
> [...]
>>> +	switch (bpf_oom_evaluate_task(task, oc, &points)) {
>>> +		case -EOPNOTSUPP: break; /* No BPF policy */
>>> +		case -EBUSY: goto abort; /* abort search process */
>>> +		case 0: goto next; /* ignore process */
>>> +		default: goto select; /* note the task */
>>> +	}
>>
>> Why we need to change the *points* value if we do not care about oom_badness
>> ? Is it used to record some state? If so, we could record it through bpf
>> map.
> 
> Strictly speaking we do not need to. That would require BPF to keep the
> state internally. Many will do I suppose but we have to keep track of
> the victim so that the oom killer knows what to kill so I thought that
> it doesn't hurt to keep track of an abstract concept of points as well.
> If you think this is not needed then oc->points could be always 0 for
> bpf selected victims. The value is not used anyway in the proposed
> scheme.
> 
> Btw. we will need another hook or metadata for the reporting side of
> things. Generally dump_header() to know what has been the selection
> policy.
> 
OK. Maybe a integer like policy_type is enough to distinguish different 
policies and the default method is zero. Or we can let BPF return a 
string like policy_name.

Which one should I start implementing in next version? Do you have a 
better idea?

Thanks.


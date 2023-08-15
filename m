Return-Path: <bpf+bounces-7782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD7B77C5D9
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 04:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98091C20BD1
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 02:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DBE185D;
	Tue, 15 Aug 2023 02:28:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC90E17C4
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 02:28:29 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8296710C1
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 19:28:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-687ca37628eso4745536b3a.1
        for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 19:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692066508; x=1692671308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0lxq9OjfrA60t47ee0fVJ+mpuBSaW/wISgNC9Vr6aM=;
        b=LRLT6XP/XT24hYVtEu3IvtUN57S9JLlno5LNRkdEtYZV4f2UieqgXdcPq4qlVC1iVw
         lfZu9hnms0iFTvbbIbJXIDDaK/RE1hjvlN+2vhknUB8GXoGlq7MSbu67hxSY6VDq3BQ+
         Plr/WMT57GfqWc/UZF7hXtwA8VSJHGrjleUwAKZuiKlgh/WhikEYV4L26qIsgp1DPApK
         Aq2Lsmm7ANV1743gfKej8PRH7SeT5BKGn5wNO+TwteP5XO3AOjehrkjRZiwdLXjmmf9i
         impumhPSk0pbbQNu27JpjBVFownW6iiChFQtzNxbHzC4qMKl9eCSYGZISzSLLPVOtnXE
         WKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692066508; x=1692671308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A0lxq9OjfrA60t47ee0fVJ+mpuBSaW/wISgNC9Vr6aM=;
        b=DsbF3gOOjf5jLrzhHbjGNH2eIssg5jmFxHHNQughXu9iZObeZwltEIYMDmq4pHRH4L
         +0vDwtGUpmW3Vy4p60kanYdyYXFtBEWRMjTkCEaPS/IofShfmPPRGV9CVMng1stFoqj0
         a+ql6ICH/sEm0JHMVjqrYxyja87ACg8FkY2k75NftzVn+SvnNg2roaT/tzcRrX6qPWBN
         cMOtVEK3u8mdeXEtQQoo5OlwaDd7Tnou7WdLioF7ARLkDQCcZSd5j0jggsuNF6/UN+el
         d/8A2EMNwG2nG/iWGcimgsCNIuNKrKmz+XqPSrg34pCv7tUs5kxjplG54dnTy6yJ+czH
         laUQ==
X-Gm-Message-State: AOJu0YwX8J8xJ2uUfxahcm6IycYGx/iXYiqwy1vZuIPiv6mhChWeyuey
	WyfZjCd/1Cx6o1zG6tf9yb43Zg==
X-Google-Smtp-Source: AGHT+IF0Oahb0/bzmi8xlwgfys35ZcW8ZDVuZHtOLCZ/YfMQuqZlHjVmsVUEHQPx+bRFNXftB5V0SA==
X-Received: by 2002:a05:6a00:10cc:b0:686:babd:f5c1 with SMTP id d12-20020a056a0010cc00b00686babdf5c1mr12653781pfu.25.1692066507969;
        Mon, 14 Aug 2023 19:28:27 -0700 (PDT)
Received: from [10.85.117.81] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id k19-20020aa790d3000000b00682bec0b680sm8539945pfk.89.2023.08.14.19.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 19:28:27 -0700 (PDT)
Message-ID: <dda53b5a-3298-500f-45c5-f5d123559e8e@bytedance.com>
Date: Tue, 15 Aug 2023 10:28:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 2/5] mm: Add policy_name to identify OOM policies
To: Jonathan Corbet <corbet@lwn.net>, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, muchun.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-3-zhouchuyi@bytedance.com>
 <87h6p1uz3w.fsf@meer.lwn.net>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <87h6p1uz3w.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

在 2023/8/15 04:51, Jonathan Corbet 写道:
> Chuyi Zhou <zhouchuyi@bytedance.com> writes:
> 
>> This patch adds a new metadata policy_name in oom_control and report it
>> in dump_header(), so we can know what has been the selection policy. In
>> BPF program, we can call kfunc set_oom_policy_name to set the current
>> user-defined policy name. The in-kernel policy_name is "default".
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   include/linux/oom.h |  7 +++++++
>>   mm/oom_kill.c       | 42 +++++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 46 insertions(+), 3 deletions(-)
> 
> So I have a possibly dumb question here...
> 
>> diff --git a/include/linux/oom.h b/include/linux/oom.h
>> index 7d0c9c48a0c5..69d0f2ec6ea6 100644
>> --- a/include/linux/oom.h
>> +++ b/include/linux/oom.h
>> @@ -22,6 +22,10 @@ enum oom_constraint {
>>   	CONSTRAINT_MEMCG,
>>   };
>>   
>> +enum {
>> +	POLICY_NAME_LEN = 16,
>> +};
> 
> We've defined our name length, fine...
> 
>>   /*
>>    * Details of the page allocation that triggered the oom killer that are used to
>>    * determine what should be killed.
>> @@ -52,6 +56,9 @@ struct oom_control {
>>   
>>   	/* Used to print the constraint info. */
>>   	enum oom_constraint constraint;
>> +
>> +	/* Used to report the policy info. */
>> +	char policy_name[POLICY_NAME_LEN];
>>   };
> 
> ...that is the length of the array, appended to the structure...
> 
>>   extern struct mutex oom_lock;
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 255c9ef1d808..3239dcdba4d7 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -443,6 +443,35 @@ static int dump_task(struct task_struct *p, void *arg)
>>   	return 0;
>>   }
>>   
>> +__bpf_kfunc void set_oom_policy_name(struct oom_control *oc, const char *src, size_t sz)
>> +{
>> +	memset(oc->policy_name, 0, sizeof(oc->policy_name));
>> +
>> +	if (sz > POLICY_NAME_LEN)
>> +		sz = POLICY_NAME_LEN;
>> +
>> +	memcpy(oc->policy_name, src, sz);
>> +}
> 
> This truncates the name, possibly leaving it without a terminating NUL
> character, right?
> 

Yes, indeed. We should guarantee that the policy_name is terminated with 
a NULL character to avoid some undefined behavior.

Thanks for your helpful review.

------
Chuyi Zhou



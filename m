Return-Path: <bpf+bounces-10132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199107A1469
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 05:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F561C20ADA
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 03:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE484258C;
	Fri, 15 Sep 2023 03:31:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A569E211A
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 03:31:26 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0FB2126
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 20:31:25 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c0c6d4d650so15269645ad.0
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 20:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694748685; x=1695353485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpWRm2xOvIj7k2faB4bOIBQWQx7RWcYPohu2ZtEfRdI=;
        b=lfpB69hQ+HT7cPnK56ljrqcQBQqiPG7lfKlClk/ftatbtDW/YWsKWpw8A7lJEgoLqj
         HMvm/FQz7Gnh0/Gtrb0Tax1Zuk6d/boGznKWSmBBQEjNi/ahlXxK1fwok7ENOF/q08I0
         KrAVUHKgnvTOO1+FvWKr3O04hURZK92ddlZZSawhZoPMc/w+5zokVC46/hRW812UY918
         BX2SSxMdVC+jPVPMjKbKU8wjHqnSYvl48JvB5GcSziEEbkrkzsoaBPqhoQMNKGiy+E3Z
         jTWwQpNEnQc6aF2kd7Z0i9fg+yW3nWI+LQ2+Yx/mtZ4D9ILms8UX+/CH2JEF5JwR6EzK
         73xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694748685; x=1695353485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hpWRm2xOvIj7k2faB4bOIBQWQx7RWcYPohu2ZtEfRdI=;
        b=TS4JUBnhqEgzTJr2BzYH+YMFXu13M8YnfWUnWOi3AS66B5fr7XDi/1IBp/+HUGjBhc
         nKPi4USY0Dt29B3znTu9ZEb7FXXyzm4LKsp5zdoC2kE48ojtedEXUEfA6DHXPoPyX183
         zsbgTNFS9Xq+NMLNPmCtNyLRUBpoT0yq9829uuMXvWoQl5C91iLP3/TBhR5c8t01h44Z
         BGFMLdzXp2QDPRWj1dnEyvIoAc1nP1N8zUIC1hFzgt9JczC8KpR4JKps0YMI/TjW2YFo
         IdVunF7VZhkABh49CXhsctjo5Fqq23I/doqpG9wCY4hz0ZfDBjG4NRuFNoRiLdOlQHuQ
         Tv9Q==
X-Gm-Message-State: AOJu0Yzbtl7xiySsWGE0KdALUtTR69Xx7Afr98oLkkrXtc96IySBDeKD
	eZaFLukrn7lowjv8r69pDy0D1g==
X-Google-Smtp-Source: AGHT+IHkWRJQiv5Qf/cfuGEDWVM5jxQ4hNQK+qCRnUK1ZewV+/2s0bDDBdtvBsWAfFab3l8fsODlRw==
X-Received: by 2002:a17:903:258a:b0:1c4:3956:585e with SMTP id jb10-20020a170903258a00b001c43956585emr70750plb.51.1694748685025;
        Thu, 14 Sep 2023 20:31:25 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001ab2b4105ddsm2303584plg.60.2023.09.14.20.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 20:31:24 -0700 (PDT)
Message-ID: <513b8479-4c2d-b6c1-2081-15ea0cd0ebeb@bytedance.com>
Date: Fri, 15 Sep 2023 11:31:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 2/5] mm: Add policy_name to identify OOM policies
To: Bixuan Cui <cuibixuan@vivo.com>, Jonathan Corbet <corbet@lwn.net>,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 muchun.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-3-zhouchuyi@bytedance.com>
 <87h6p1uz3w.fsf@meer.lwn.net> <5343d12a-630c-4d54-91f1-7a7d08326840@vivo.com>
 <89295904-3afa-4c8f-ccdb-1d78d9ad3024@bytedance.com>
 <9f6b8aaa-50b1-435b-a525-9a7986f63845@vivo.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <9f6b8aaa-50b1-435b-a525-9a7986f63845@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/9/15 10:28, Bixuan Cui 写道:
> 
> 
> 在 2023/9/14 20:50, Chuyi Zhou 写道:
>>>
>>> Delete set_oom_policy_name, it makes no sense for users to set policy 
>>> names. 🙂
>>>
>>
>> There can be multiple OOM policy in the system at the same time.
>>
>> If we need to apply different OOM policies to different memcgs based 
>> on different scenarios, we can use this hook(set_oom_policy_name) to 
>> set name to identify which policy in invoked at that time.
>>
>> Just some thoughts.
> Well, I thought the system would only load one OOM policy(set one policy 
> name), which would set the prio of all memcgs.
> 
> What you mean is that multiple bpf.c may be loaded at the system, and 
> each bpf.c sets the different policy for different memcgs?

No. Not multiple bpf_oompolicy.c but multiple OOM Policy in one BPF Program.


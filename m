Return-Path: <bpf+bounces-6072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB86765359
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 14:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA82D1C215D0
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 12:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBBF168D1;
	Thu, 27 Jul 2023 12:12:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B952E56E
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 12:12:08 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0A52688
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 05:12:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8b2b60731so4663335ad.2
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690459927; x=1691064727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5nZwlDTOjjdFNeLj34AgBP1KRxYvABwCck0KA10li8=;
        b=d5HUSXYecrOqzle0oVqz4drff4ZQiVhdjWtCNcXBfkOQRjlgotwdGM1eIxPF6GqzL9
         VpPwyq7dem3aT4tkzUV4Pen/88lIcK8i0FveJLAE4FvSLqPQJnWWe/jstAPTsCMLJhnV
         favCG5jNfeSSIwL5Znae+hBJky6iHZSiDNiKc9eAySXEaqIUSi1Asa9OUP5Kf2UvFWYl
         UbuamXcDsJJHqFSBnmxA9OcbO8uQ56ro2QwXkjC2HSXfJhAfbBT9fZhAlqlpqQ3Xkt7M
         /VhE/Z/vhAQqqvHt+5IvcvPrUWRtBeVkry5R0Af014ekkRVIWwvny2M91/KM6FSEKijq
         QIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690459927; x=1691064727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i5nZwlDTOjjdFNeLj34AgBP1KRxYvABwCck0KA10li8=;
        b=BHisdnv5KgBH7YlQ7J3GuE8pSabcTaQN5Z/HXsN/j+toHBLHUMPLTH/tE+X7lHx6jJ
         aAfiZUIVln/phJwZWMuh5ZF8hjD4UmM2VMKXk3gf7/Mq/T9Ls4yaV1oemq9A5AIvDzvr
         UxicshyP+XVuHghLetMXOEYGgEpZkT5yiy+0y4fWJjsdRUdwJFx/bXUyWB02RNy3OUD+
         LZPv+w681J8x68g0fN5AQtuPliVZo/MnoJ0ATVswmsbEnrdF9XaiCitwHs8DxCo47K3z
         sNcMoMSS0+IfbemfdgyAXyLfTB5gxK0fnv5Rj8/fdYfmso50+xkEVen8vrQCiyKTIVJB
         CphA==
X-Gm-Message-State: ABy/qLbiWTD0WuqOZsBdqWmTWTqOHHtF3rLAnpRoIU5tGE63110JOSlE
	Tyg94OiLZ/TXUPN4aSJ8TqX6CA==
X-Google-Smtp-Source: APBJJlHqKW8CCRyJ3AZOP6tqhhNw3mx2jsk9y1MIxwC11gwPSDgjjHCDoDhGIu9t10rPv2gM0V/ztw==
X-Received: by 2002:a17:902:ec83:b0:1bb:59a0:3d34 with SMTP id x3-20020a170902ec8300b001bb59a03d34mr3551847plg.30.1690459927101;
        Thu, 27 Jul 2023 05:12:07 -0700 (PDT)
Received: from [10.85.117.81] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ce9000b001ac6b926621sm1459893plg.292.2023.07.27.05.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 05:12:06 -0700 (PDT)
Message-ID: <7347aad5-f25c-6b76-9db5-9f1be3a9f303@bytedance.com>
Date: Thu, 27 Jul 2023 20:12:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
To: Michal Hocko <mhocko@suse.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
 robin.lu@bytedance.com
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <ZMInlGaW90Uw1hSo@dhcp22.suse.cz>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <ZMInlGaW90Uw1hSo@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/7/27 16:15, Michal Hocko 写道:
> On Thu 27-07-23 15:36:27, Chuyi Zhou wrote:
>> This patchset tries to add a new bpf prog type and use it to select
>> a victim memcg when global OOM is invoked. The mainly motivation is
>> the need to customizable OOM victim selection functionality so that
>> we can protect more important app from OOM killer.
> 
> This is rather modest to give an idea how the whole thing is supposed to
> work. I have looked through patches very quickly but there is no overall
> design described anywhere either.
> 
> Please could you give us a high level design description and reasoning
> why certain decisions have been made? e.g. why is this limited to the
> global oom sitation, why is the BPF program forced to operate on memcgs
> as entities etc...
> Also it would be very helpful to call out limitations of the BPF
> program, if there are any.
> 
> Thanks!

Hi,

Thanks for your advice.

The global/memcg OOM victim selection uses process as the base search 
granularity. However, we can see a need for cgroup level protection and 
there's been some discussion[1]. It seems reasonable to consider using 
memcg as a search granularity in victim selection algorithm.

Besides, it seems pretty well fit for offloading policy decisions to a 
BPF program, since BPF is scalable and flexible. That's why the new BPF
program operate on memcgs as entities.

The idea is to let user choose which leaf in the memcg tree should be 
selected as the victim. At the first layer, if we choose A, then it 
protects the memcg under the B, C, and D subtrees.

         root
      /   ｜ \  \
     A    B  C  D
    /\
   E F


Using the BPF prog, we are allowed to compare the OOM priority between
two siblings so that we can choose the best victim in each layer.
For example:

run_prog(B, C) -> choose B
run_prog(B, D) -> choose D
run_prog(A, D) -> choose A

Once we select A as the victim in the first layer, the victim in next 
layer would be selected among A's children. Finally, we select a leaf 
memcg as victim.

In our scenarios, the impact caused by global OOM's is much more common, 
so we only considered global in this patchset. But it seems that the 
idea can also be applied to memcg OOM.

[1]https://lore.kernel.org/lkml/ZIgodGWoC%2FR07eak@dhcp22.suse.cz/

Thanks!
-- 
Chuyi Zhou


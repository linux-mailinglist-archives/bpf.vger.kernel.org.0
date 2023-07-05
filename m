Return-Path: <bpf+bounces-4069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F20748832
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 17:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0C9281052
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 15:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2125111CB3;
	Wed,  5 Jul 2023 15:40:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B246AB
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 15:40:26 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DC010F5
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 08:40:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbdfda88f4so23727205e9.1
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 08:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688571624; x=1691163624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kf9dpGbPYLRb7hYGeUUJzayjWRarC+ddpPgDxkSbtnI=;
        b=QrruCyyrF/gec5ujb7ePxEv6WXl/c+qaX2kaiBSHLBe2zJBEGWz1FL1BZnrJam8AWQ
         x//NBX1CpNnGT7aRV/5NGjocWRZ4u/MOPy4Iuyl4SmRby7X6khcSkFEJLcvDrcM55UyG
         yqjJ3hTb4y/jDQVNIdvIXqSmCqCTkORhguYCsK4tcHeIPNjV6ZN/3U68GeWQw1X0jJhK
         oAFDIIAePI2SZtmcj+FLGDSJOyq0ZL7kQe2UrcOezvY7nqzQpgVd4yVw+pDGGg+Co5K2
         OUfjGAqaVrYqaRk0OyJ8Chur9n11HrEN41uAdPCQSxNwl/CVLYQt/ede1oKo7nrdRJ3t
         OOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688571624; x=1691163624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kf9dpGbPYLRb7hYGeUUJzayjWRarC+ddpPgDxkSbtnI=;
        b=hZ11rd1Ha03YENrxhQQeAXzYKggLHVWrVlE0GGekLvVZ2luIm/XGDTCIdSyZs2dlLe
         DZvGkVEDfHmrKJGeYnkp9vv8D+NaWIMLpPmps6RWy2HSbzYkUzxKBesD6Av4Dc3RNewA
         3WbA8sIHa7XG03J0RduzCpcy9girVH29Km9065WNaLYPin4aWQwORJIvv69Tf6t6QBad
         M4ipEsHZmyQ9RfY/0cGmQiLsd3tPRkswuUzc8Kc9FrdgiM+pD2Dfbc0iWd2vGyLAF13S
         FYbQhlw0O1p0jSrK4KibdR0PLvgVU6BMfV5+nNwXZBzBU8EPIG6rSA24+zgCFpSX7K21
         7Wuw==
X-Gm-Message-State: AC+VfDwV1JXulKDjhquD5fNmR0WBFaINM+akKhtP3kPgyr+3xKNagyy4
	SLtvKXOElc4/SMQz9PCI/sJUIg==
X-Google-Smtp-Source: ACHHUZ5oACS6Aj6eqqJkRtO/U3DZzHrhMn8vRtOok/dLQ1DnwYFp606s+ItF5bcsIAuUL/9C6vrxPA==
X-Received: by 2002:a05:600c:2906:b0:3fb:ba04:6d5d with SMTP id i6-20020a05600c290600b003fbba046d5dmr13573203wmd.12.1688571623950;
        Wed, 05 Jul 2023 08:40:23 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id p7-20020a7bcc87000000b003fbb8c7c799sm2472896wma.30.2023.07.05.08.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:40:23 -0700 (PDT)
Date: Wed, 5 Jul 2023 15:41:35 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Subject: Re: [v3 PATCH bpf-next 5/6] selftests/bpf: test map percpu stats
Message-ID: <ZKWPL4OsRqJcTQbJ@zh-lab-node-5>
References: <20230630082516.16286-1-aspsk@isovalent.com>
 <20230630082516.16286-6-aspsk@isovalent.com>
 <3e761472-051d-4e46-8a66-79926493e5db@huawei.com>
 <ZKQ0iF+8fMND5Qmg@zh-lab-node-5>
 <ZKQ5chXIwe0ItMbT@zh-lab-node-5>
 <ec62d127-2cc5-3f0a-6eb7-d77a9aaaa7a3@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec62d127-2cc5-3f0a-6eb7-d77a9aaaa7a3@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 05, 2023 at 08:46:09AM +0800, Hou Tao wrote:
> Hi,
> 
> On 7/4/2023 11:23 PM, Anton Protopopov wrote:
> > On Tue, Jul 04, 2023 at 03:02:32PM +0000, Anton Protopopov wrote:
> >> On Tue, Jul 04, 2023 at 10:41:10PM +0800, Hou Tao wrote:
> >>> Hi,
> >>>
> >>> On 6/30/2023 4:25 PM, Anton Protopopov wrote:
> >>> [...]
> >>>> +}
> >>>> +
> >>>> +void test_map_percpu_stats(void)
> >>>> +{
> >>>> +	map_percpu_stats_hash();
> >>>> +	map_percpu_stats_percpu_hash();
> >>>> +	map_percpu_stats_hash_prealloc();
> >>>> +	map_percpu_stats_percpu_hash_prealloc();
> >>>> +	map_percpu_stats_lru_hash();
> >>>> +	map_percpu_stats_percpu_lru_hash();
> >>>> +}
> >>> Please use test__start_subtest() to create multiple subtests.
> > After looking at code, I think that I will leave the individual functions here,
> > as the test__start_subtest() function is only implemented in test_progs (not
> > test_maps), and adding it here looks like out of scope for this patch.
> > .
> I see. But can we just add these tests in test_progs instead which is
> more flexible ?

I think that it makes more sense to port this test_prog flexibility to the
test_maps program. I can volunteer to do this (but not right away).


Return-Path: <bpf+bounces-7907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F80A77E58D
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 17:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408F91C21149
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 15:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249AE16414;
	Wed, 16 Aug 2023 15:49:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231115AEA
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 15:49:11 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4A326AD
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 08:49:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589a4c6ab34so89366467b3.2
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692200950; x=1692805750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WAWvKCkwfauUZy7DnRIZa7AGoqOvOdt/+0z6BX+C7Hw=;
        b=dgWz9RZfxB5tPtjZnTUFymZTYd4MEB25AkNhSBaziJrwcVLGQM9L34ednfDOzS6EvP
         ytJhyRYbjwZ8At6a1HdDXVnf2vrsdAWVz2k6mv6787jeq94AKCu7ixwem/S40GWpcjOT
         zFWTy0x+qQB7QPPm1dsoPAx2Dv8gp+KQ+HcEiSXQ20Ywno8iQ1JLlmP9hYRI3LsieH10
         e88JszcAdR6f8NQkXMmkm73tOjwDVplG5+hH62UKPhu5JxCy0FvbBLWCz9O9PS2hGOga
         YKuFcpwmNV3dTZnlXQP+dh2xCKdi6EVhNwAcTtFNLzGbChWQEHj4SLVxAmE9fqU+rJba
         cfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200950; x=1692805750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WAWvKCkwfauUZy7DnRIZa7AGoqOvOdt/+0z6BX+C7Hw=;
        b=AU2mw95mhjRJXmOJROH0F3q1lY1i+fqRtNumzeYK0cPAEE0MwQoPVvU1xZ0fUc3T81
         he13cunrES4iFjs3ymq+m0oLEFoPNDdNJBh3kEQBqnI+0h8v3WXbRbM34ozmyZmPl8Iv
         Msp9umJkfhMn/hviB8ftGSp1305+cSIq3AtPZNSKtuSPt8arStBNU3WXgTra5Wva9zSF
         gCSkIMK3DACF+nwtvl8j7UhQ6aImTX6+FA9U6WczQ1c++vHESQrBRQwMjPKrbXtQjzZ/
         Ppzk7ha0hwkSGJub785ZJp6moQ4oMSd3j54zXLk1oBnimWjIUd0ezGYSBaRw9eP4F0po
         1WYg==
X-Gm-Message-State: AOJu0YyhNwyNc60JevJQ4X4XaH4ZYSF/MxulmFc0qcoDAa6FvrSQWhNA
	A6z+f0jBlozaaEVXSwXDP0Lp5VQI4bdmwOX/
X-Google-Smtp-Source: AGHT+IG2JyR8oeRaSxEFwriQyLUAD5PR5rlJhjQ+jsi6W+ZxggcKjDAot1S5LhMbAZgHdtoiOidiADZ3BwfcP3+q
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:ad04:0:b0:584:41a6:6cd8 with SMTP
 id l4-20020a81ad04000000b0058441a66cd8mr28927ywh.8.1692200949829; Wed, 16 Aug
 2023 08:49:09 -0700 (PDT)
Date: Wed, 16 Aug 2023 15:49:07 +0000
In-Reply-To: <20230810081319.65668-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816154907.2724856-1-yosryahmed@google.com>
Subject: Re: [PATCH RFC v2 0/5] mm: Select victim using bpf_oom_evaluate_task
From: Yosry Ahmed <yosryahmed@google.com>
To: zhouchuyi@bytedance.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mhocko@kernel.org, muchun.song@linux.dev, robin.lu@bytedance.com, 
	roman.gushchin@linux.dev, wuyun.abel@bytedance.com, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Changes
> -------
>
> This is v2 of the BPF OOM policy patchset.
> v1 : https://lore.kernel.org/lkml/20230804093804.47039-1-zhouchuyi@bytedance.com/
> v1 -> v2 changes:
>
> - rename bpf_select_task to bpf_oom_evaluate_task and bypass the
> tsk_is_oom_victim (and MMF_OOM_SKIP) logic. (Michal)
>
> - add a new hook to set policy's name, so dump_header() can know
> what has been the selection policy when reporting messages. (Michal)
>
> - add a tracepoint when select_bad_process() find nothing. (Alan)
>
> - add a doc to to describe how it is all supposed to work. (Alan)
>
> ================
>
> This patchset adds a new interface and use it to select victim when OOM
> is invoked. The mainly motivation is the need to customizable OOM victim
> selection functionality.
>
> The new interface is a bpf hook plugged in oom_evaluate_task. It takes oc
> and current task as parameters and return a result indicating which one is
> selected by the attached bpf program.
>
> There are several conserns when designing this interface suggested by
> Michal:
>
> 1. Hooking into oom_evaluate_task can keep the consistency of global and
> memcg OOM interface. Besides, it seems the least disruptive to the existing
> oom killer implementation.
>
> 2. Userspace can handle a lot on its own and provide the input to the BPF
> program to make a decision. Since the oom scope iteration will be
> implemented already in the kernel so all the BPF program has to do is to
> rank processes or memcgs.
>
> 3. The new interface should better bypass the current heuristic rules
> (e.g., tsk_is_oom_victim, and MMF_OOM_SKIP) to meet an arbitrary oom
> policy's need.

Can we linux-mm on such changes? I almost missed this series :)


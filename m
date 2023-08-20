Return-Path: <bpf+bounces-8134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC164781F40
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 20:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72341C2083E
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 18:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB3663DE;
	Sun, 20 Aug 2023 18:22:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B28763CB
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 18:22:17 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735004211
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 11:19:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-997c4107d62so344125666b.0
        for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692555567; x=1693160367;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=jyjIIEtgE5oaHbyAm5gzVWUG+dED/JrA1tkaaPTN1yw=;
        b=r7PqpouSPColuKBU492aC7DKgWRAdZR7x1/uIudEygQVWH2M7CpnK+XcPe3m0EvifL
         wWkZHZxhQ+EJQ17juZ8HPfmYVtGq4nG765pbNdV14uT4Zya1QXr7XxnAWiuO402MLGq7
         wwD8TKRX/hoS4qgc+eUc1xnm5hM1kHzwqrsjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692555567; x=1693160367;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyjIIEtgE5oaHbyAm5gzVWUG+dED/JrA1tkaaPTN1yw=;
        b=JbOR26RNwi25DJVHpkS/zNZmuL1KiyLhq6vtu+xwEXw7TL77jG6BU2BsfaKoh1Glaa
         atplAU1lKIQJxbGb/7Hhbj5FSTFY8bBWgLRJpEk9dBfoIOYewJNptNc4ftXKnOfMou4p
         874gUjK8gGZKziMDtjomdxuVgu7kTnEYvFvWbxN4ugfLBG4qvH2cvVWOM9+6DZ7vkpYR
         FQUbQMm8ztale5e4b3Hn41pRZNhPdLDiNFtLn5BvMQwhDXbiJmyTskeh7myenmlZ95G4
         +ZKqjwYLPVfXPwiR1tSY3aEW/iwLXDK5N1pzXE5cI86d0hcnYVrWY0bW/BUd4pzXS8Co
         jC2w==
X-Gm-Message-State: AOJu0YyPimPxnzOhvqimw1PHUWkM+RKlu6DU8crRX7s8ROE8GO8dbz8v
	f46gzgPLz71V+JzRIEO2LgNkrQ==
X-Google-Smtp-Source: AGHT+IGAquWWtN82VfNoF84xCUuFd/x9j8gYXEjQB2zwVE1e2rOyG+YEoKnNq4tjJMphJQ59b1tliQ==
X-Received: by 2002:a17:906:8446:b0:99d:dc87:5f29 with SMTP id e6-20020a170906844600b0099ddc875f29mr3802580ejy.12.1692555566879;
        Sun, 20 Aug 2023 11:19:26 -0700 (PDT)
Received: from cloudflare.com (79.184.134.65.ipv4.supernova.orange.pl. [79.184.134.65])
        by smtp.gmail.com with ESMTPSA id jw11-20020a17090776ab00b0099d0a8ccb5fsm5023453ejc.152.2023.08.20.11.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 11:19:26 -0700 (PDT)
References: <20230811093237.3024459-1-liujian56@huawei.com>
 <20230811093237.3024459-2-liujian56@huawei.com>
 <64ddba9e1df57_32c0720898@john.notmuch>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, liujian56@huawei.com
Subject: Re: [PATCH bpf-next v2 1/7] bpf, sockmap: add BPF_F_PERMANENTLY
 flag for skmsg redirect
Date: Sun, 20 Aug 2023 20:03:11 +0200
In-reply-to: <64ddba9e1df57_32c0720898@john.notmuch>
Message-ID: <877cpp7f0y.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 11:13 PM -07, John Fastabend wrote:
> Liu Jian wrote:
>> If the sockmap msg redirection function is used only to forward packets
>> and no other operation, the execution result of the BPF_SK_MSG_VERDICT
>> program is the same each time. In this case, the BPF program only needs to
>> be run once. Add BPF_F_PERMANENTLY flag to bpf_msg_redirect_map() and
>> bpf_msg_redirect_hash() to implement this ability.
>> 
>
> I like the use case. Did you consider using
>
>  long bpf_msg_apply_bytes(struct sk_msg_buff *msg, u32 bytes)
>
> This could be set to UINT32_MAX and then the BPF prog would only be run
> every 0xfffffff bytes.

It would be great to have the permanent redirect feature implemented
also for BPF_SK_SKB_STREAM_VERDICT and BPF_SK_SKB_VERDICT. I don't think
there are any obstacles to support it for both input configurations.

But in SK_SKB verdict prog we don't have apply_bytes. So we couldn't
keep the API the same without introducing a helper.

That's why I'd go with the flag.

[...]


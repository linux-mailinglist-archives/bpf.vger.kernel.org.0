Return-Path: <bpf+bounces-77833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F61ACF3FDD
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 14:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DC8A300A98E
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 13:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A850C335559;
	Mon,  5 Jan 2026 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxNs4woR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyfJUffD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86892255F3F
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621370; cv=none; b=SOz2dlAZeGHbu5Hb7xKMXEfCEJyVN+O/Sv5oqh5H4FujJLEmDQnKrGmmu7IF3Lc2iK3LEN6C6HQGwOki5Rc6bhZmBVksgKtu31CzsVw0pgc7ozBysyqZQcBsXL8a+CD3OR8ar51eCDpuqlbc6l/MGt84uFuXoCqINM9ybyx+eu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621370; c=relaxed/simple;
	bh=2AXve2RVv3Fx6YOvospEYEqh4Y9K3EooVWW06ml7JoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSGUio13P02loKvoNYugLnTh2lURtxmw/bdAAp4e3k6fWRz0NAZM30pZ/tjBLdlP5cK6BPp29YRodH/7cX5UMK0MhI8zbRXELgoF3156I7eJo5hUYDDSw6ta6bpZxeyx/8UX09d2mEQOqyAHM8LoMLffXUdPxB1zreAyzsLmkkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxNs4woR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyfJUffD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767621365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4zxKV5KisOZLklnIhqPWg8+R5Qnw1OvgpHfGWe2u6k=;
	b=TxNs4woRvjaPy0efeiZy8R+qtI0AXfqQGl4AmZTwki1LMf9PEmxKqmAVC3uFJavISwKgnI
	5zpnKhaSMtlI5aDRYAITBQ5/Lf3fsnlcetqLKDWtBBZKCOjI3XFGSRXAPy51RqZxB+ONSD
	ADhtdNUo83uyoA/n+wxnU85pUVm1r94=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-v5xhYCkVOQ2F3KjvuCsgfw-1; Mon, 05 Jan 2026 08:56:04 -0500
X-MC-Unique: v5xhYCkVOQ2F3KjvuCsgfw-1
X-Mimecast-MFC-AGG-ID: v5xhYCkVOQ2F3KjvuCsgfw_1767621363
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so101956435e9.1
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 05:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767621362; x=1768226162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4zxKV5KisOZLklnIhqPWg8+R5Qnw1OvgpHfGWe2u6k=;
        b=gyfJUffDFt5mae0t85GIAmi87ApazsnpkkbLhJNmUnBvWWrJeFcqINDzCs+3IF1YmV
         MIim5WoAY2QJ03r4k/5bZttR0XwbNoyk6EySm592atFJfsG/RqJgisSYlB6BdPD/CX4Z
         E+UCTn6pvWtjwP8mh645le6ucE9xgH+3RhXCRnTWIHPCGsZ2Ce6mhoEi3ySrqoLSm8yB
         nzqQl73ZEI13u9mGo2gc4vhH0vMsiSfWojE14wy69vbAbyPbgdH1FiQEYCZADav6f1Kj
         AkG18Wz/58xvBCgLvKtC16fbHRbdyJbQwYHZ3O1IO/X78D6cCTLPVnId/oigQAJ5L2UR
         1uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767621362; x=1768226162;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4zxKV5KisOZLklnIhqPWg8+R5Qnw1OvgpHfGWe2u6k=;
        b=vRSMAtODsKJ39C1Xlo90YW/Qxgg+ACPZ/k6lEDcq5qe6wcRrAj2H8R9KGTf0vDOdx4
         wvq9IirRjLtpYr/DjuIFdM8OwNskFPyvRSI658HMVbGI0IyQ6HCJk+Osn4cMQSpQMla6
         92QuhAUB8ds6foobFwKnTlX5RuMe/RiqxYwEM6JaCyXbU67pXng5UvHj6lh0JKwYToc8
         a+5kT0EIOK8NgN4fgUM/ff8BG+d76r7wkMl/pf4FVZsoyHfsMpFtXzy42gG8ZT2uQl1o
         IPSZuyHttBCxpg3FjOGtvw7lkZtqGcItQGAC7s+kmOZ67MP8W0yPkL1uZ0lLtFivQXX/
         c4/w==
X-Gm-Message-State: AOJu0Yx1FJCp6hNvQeq+cKILPv0a7ewA6ZetcIZ58Tkc3weBVN9aB2+W
	DMEhHk9tzvFbOywSBM5FeXWzBr3544UKaDsoX3wOLw2mChKBGFmcq8XwW+aSKqYjc5QMER7eeGz
	lqXKl89n5xnHla+YWdgRE1a7v9DQEAMPgs6vdtXy+C0xmJmoSQA4R6/FTF9/JFJ1KPXYE1HG3HA
	69TNjxeE38r34tFGMYw9vMT3H7EjFKW0htbA==
X-Gm-Gg: AY/fxX4dbCy4wiYmy3OVPWlcFem2Fy/dctqX0FLKwNcxdzckIr4PBzJ3Z02T4LVICji
	NNXZkJqodE/rSZBgDiQOSG1iCnwBHYEXPwrG3NRxirFMhWJcOIAnBQotOpHIO+3hwd+RB7M8POI
	yId/6td8C/8xiki7/MuiBZxjWfj0Ge4EZdajCjp+jUV+UAk5A0cbiVc2/oNeIhIQEJU9DDN0DK6
	MqPdAYvtkF+l9Zmty22QbVl1hNQngyIKgFofxPr6lrOAH9PWU3ZTMswAh74L5UAtCnzxMxEbkku
	qPvLgOReVvc7afrSdOUvh8y4Sbm2389CHkG9J6Yan+IvumX5obfIwBM12Y/y7r/tFU5qO5g9QP4
	hlFdwIyqfENtMfQcJv2fWOkokrfbzKL3D6+qgGjuDUZ3V
X-Received: by 2002:a05:600c:4e8f:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-47d1957da79mr548082135e9.18.1767621362458;
        Mon, 05 Jan 2026 05:56:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwkc9xT5MvAHbAzqBog1JNIM9VFxAc64wmZIIOhWpWsIlDZ7Xk0cIs/gMJo0V9qDmhI+RJwA==
X-Received: by 2002:a05:600c:4e8f:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-47d1957da79mr548081655e9.18.1767621361932;
        Mon, 05 Jan 2026 05:56:01 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d143f57sm155098545e9.4.2026.01.05.05.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 05:56:01 -0800 (PST)
Message-ID: <6482b711-4def-427a-a416-f59fe08e61d0@redhat.com>
Date: Mon, 5 Jan 2026 14:55:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/4] Use correct destructor kfunc types
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sami Tolvanen <samitolvanen@google.com>
References: <20251126221724.897221-6-samitolvanen@google.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20251126221724.897221-6-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 23:17, Sami Tolvanen wrote:
> Hi folks,
> 
> While running BPF self-tests with CONFIG_CFI (Control Flow
> Integrity) enabled, I ran into a couple of failures in
> bpf_obj_free_fields() caused by type mismatches between the
> btf_dtor_kfunc_t function pointer type and the registered
> destructor functions.
> 
> It looks like we can't change the argument type for these
> functions to match btf_dtor_kfunc_t because the verifier doesn't
> like void pointer arguments for functions used in BPF programs,
> so this series fixes the issue by adding stubs with correct types
> to use as destructors for each instance of this I found in the
> kernel tree.
> 
> The last patch changes btf_check_dtor_kfuncs() to enforce the
> function type when CFI is enabled, so we don't end up registering
> destructors that panic the kernel.

Hi,

this seems to have slipped through the cracks so I'm bumping the thread.
It would be nice if we could merge this.

Thanks.
Viktor

> 
> Sami
> 
> ---
> v4:
> - Rebased on bpf-next/master.
> - Renamed CONFIG_CFI_CLANG to CONFIG_CFI.
> - Picked up Acked/Tested-by tags.
> 
> v3: https://lore.kernel.org/bpf/20250728202656.559071-6-samitolvanen@google.com/
> - Renamed the functions and went back to __bpf_kfunc based
>   on review feedback.
> 
> v2: https://lore.kernel.org/bpf/20250725214401.1475224-6-samitolvanen@google.com/
> - Annotated the stubs with CFI_NOSEAL to fix issues with IBT
>   sealing on x86.
> - Changed __bpf_kfunc to explicit __used __retain.
> 
> v1: https://lore.kernel.org/bpf/20250724223225.1481960-6-samitolvanen@google.com/
> 
> ---
> Sami Tolvanen (4):
>   bpf: crypto: Use the correct destructor kfunc type
>   bpf: net_sched: Use the correct destructor kfunc type
>   selftests/bpf: Use the correct destructor kfunc type
>   bpf, btf: Enforce destructor kfunc type with CFI
> 
>  kernel/bpf/btf.c                                     | 7 +++++++
>  kernel/bpf/crypto.c                                  | 8 +++++++-
>  net/sched/bpf_qdisc.c                                | 8 +++++++-
>  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 8 +++++++-
>  4 files changed, 28 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 688b745401ab16e2e1a3b504863f0a45fd345638



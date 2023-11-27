Return-Path: <bpf+bounces-15949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B097FA784
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 18:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18272819FE
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 17:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DADC36AF9;
	Mon, 27 Nov 2023 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="c9sknugR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317A11BD3
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 09:07:20 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507e85ebf50so6052051e87.1
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 09:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1701104838; x=1701709638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2D4r2jN/1Ox/IKCojw/R4bZOooiLi3ep+J+AVjKR8G0=;
        b=c9sknugRmVOEU5i68uoy/r/0/nEuOHc5tCE5fcPKPbV7vsyWYkfiFiGb8Yf5wTNtwB
         UIZbrrkXDlUXMbB5g9Nm9doUZdWunUIkfJjnIsM6lw2fEVYOCNavruK55fJ1apwg8YRc
         HKk1vYCpvnJDBuhH5QBgnG7T406UOqJum7SjZjie4CLXUevXxOVsEOGUzhBlEpPXt9ex
         KA8JX/WGzAviQHno2kbPknV/5NH4Zc2zp+fAbSDFC8fQNc5ZBFZaXz2XK1RyJ4Mnf/Li
         8ZkCoaVy4K3D5B0QEsGcp2133qgqZEr6ySgU9bC5NuPLVro8K0ForKVOsKskbyIkwcqj
         DpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701104838; x=1701709638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2D4r2jN/1Ox/IKCojw/R4bZOooiLi3ep+J+AVjKR8G0=;
        b=Huewnsnrg+Q5kpDpLKRAGDKlDn9nvO07WUrYOZaGAXVdepsnNjkVIiO5X200oz7Q7Y
         Js1ZMF3QhWxuOPHCCKIS0OdGAE610hYT4P5+5nTUShSLwpUtPd6x6K57RWzGvAKQbl1d
         jHTUnX4J+7zUx2MlXKGQsPG17dN30b5NwgPB/1JQP4qPcvmCeWZx/inRbSo040HqNmNU
         e1ymbV2zJyt86LFJNvHOZhF+olzK82G9bK8K15xvBULoWyMc4FWvdGOkXPOavc8BCXzF
         jMPkm4xorXisH3OkEBoUCBEv+nH/qvZoWpViw1mjNGmNIHPkqjLYggph/91ZibJPtbvE
         gufw==
X-Gm-Message-State: AOJu0YznFQKS1PQYgDYIaNPjPgk8eH/5i5F/SiXCJLUBVaJMdBsRYd9P
	6Oj2w9J4TEETftiAQqORAt57TA==
X-Google-Smtp-Source: AGHT+IGcz5UIsATA4K4x2g5/PPcjaLwOHC3HhSRdaw2nty1b26DUV5kfU6Tr6uELaOY60w3DA5ITdg==
X-Received: by 2002:a05:6512:220a:b0:507:cb04:59d4 with SMTP id h10-20020a056512220a00b00507cb0459d4mr8625518lfu.8.1701104838241;
        Mon, 27 Nov 2023 09:07:18 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:681:d418:ec9d:2778? ([2a02:8011:e80c:0:681:d418:ec9d:2778])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d5652000000b00332f6ad2ca8sm6767202wrw.36.2023.11.27.09.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 09:07:18 -0800 (PST)
Message-ID: <4aa42cb9-a03b-403c-976b-a1426a2fcdc4@isovalent.com>
Date: Mon, 27 Nov 2023 17:07:15 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 bpf-next 1/9] bpftool: add testing skeleton
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Manu Bretelle <chantr4@gmail.com>, bpf <bpf@vger.kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <20231116194236.1345035-1-chantr4@gmail.com>
 <20231116194236.1345035-2-chantr4@gmail.com>
 <CAADnVQ+Mb-eQUxp-0c_C_nVme0Sqy7CST_vaCiawefjTb5spiw@mail.gmail.com>
 <a9ac8c82-7b97-4001-a839-215eb4cc292f@isovalent.com>
 <CAADnVQ+f80KNBcjYRzBJw4zhYfhYa=Cw9bdQEe+Z1=CnQaa9Gw@mail.gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAADnVQ+f80KNBcjYRzBJw4zhYfhYa=Cw9bdQEe+Z1=CnQaa9Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2023-11-21 16:42 UTC+0000 ~ Alexei Starovoitov
<alexei.starovoitov@gmail.com>
> On Tue, Nov 21, 2023 at 8:26 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>>>
>>> Does it have to leave in the kernel tree?
>>> We have bpftool on github, maybe it can be there?
>>> Do you want to run bpftool tester as part of BPF CI and that's why
>>> you want it to be in the kernel tree?
>>
>> It doesn't _have_ to be in the kernel tree, although it's a nice place
>> where to have it. We have bpftool on GitHub, but the CI that runs there
>> is triggered only when syncing the mirror to check that mirroring is not
>> broken, so after new patches are applied to bpf-next. If we want this on
>> GitHub, we would rather target the BPF CI infra.
>>
>> A nice point of having it in the repo would be the ability to add tests
>> at the same time as we add features in bpftool, of course.
> 
> Sounds nice in theory, but in practice that would mean that
> every bpftool developer adding a new feature would need to learn rust
> to add a corresponding test?
> I suspect devs might object to such a requirement.

True. I've been hoping the tests would look easy enough that devs could
update them without being particularly versed in Rust, but this is
probably wishful thinking, and prone to getting bugs in the tests.

I don't have a good proposal to address this, so I agree, this is
probably not a reasonable requirement.

> If tester and bpftool are not sync then they can be in separate repos.

Makes sense. I'd like to have the tests in the same repo, but for this
time, let's focus on getting these Rust tests added to the BPF CI infra
instead, if there's no easy way to switch to a more consensual language.
Manu, thoughts?

Quentin


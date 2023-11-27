Return-Path: <bpf+bounces-15948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4DF7FA782
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 18:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1711C20CCA
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4313736AF9;
	Mon, 27 Nov 2023 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="FvYOXCuN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B889B1998
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 09:07:11 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b472f99a0so7569225e9.3
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 09:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1701104830; x=1701709630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zGFlUtzsiJQbCFirrwTByVy6qyG7w04DfhlDZ1+SsiE=;
        b=FvYOXCuNL5Khz/UiE/FXcRYsV2FAWp36SbT2bkjRB8NM/YplYlNz6QI3COXcoP2ly6
         wvFMf6I+BINKu+4MAGi+k2+uTHx0Y1SQnMfkARzztI8R6Rlm7AyIm4wPtK3RFl5HSbNo
         JJdqEo7dGWz4mwImFkjbvUSmw/zR4KR9pc/THbR1CbdS3JUCw1VseppnwYfmoxlgPn8h
         frdRclDpwdIsYKuOngwOdPRnJkBc9KnuN7XJrN47OanG/72monkpOufzPn3tftC/ApP4
         Mo5CyIXaiqv8xBxSEKGQt0brSds147azv1GAis6g5lyT2FClshaXJcRI2t7KCVnoMXSE
         PS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701104830; x=1701709630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zGFlUtzsiJQbCFirrwTByVy6qyG7w04DfhlDZ1+SsiE=;
        b=rVg1U4u7+6BAWT7GBlqd6ODp2rsUKekyJdybsOlOBwUt9Jq0PdlnAnJERR90qxxRcX
         8C7FWiZp105+P15BDOBhtg3khPEScGBPaKnj9xfmKYg8xSkilkqAeNF3JZ+Txdt+Gw/h
         Cw012mmKW87zIozpRy8NU1Mc4SfXlRECe1rGeQCYstV1I7Au9nh/htY5sGFnXdn8qAfg
         NSaNjCjE4KNgNmlAsbijm1IOdD1cuWHvmDpFQ94Doauc2hW1N3NYbawQzqnvkzK3QYFn
         dl/yH4Uevx+svvJlJI+Ncz4xBHdGUbOFWdr5FHL2jQV+Ouuy2m9BoIp/7aBAcdubmmtB
         BpSw==
X-Gm-Message-State: AOJu0YwX4ztmvdUYuqj80t+myhMOnDFZG8QCe67ebqLkTCnvZThDpway
	ZhMw/sAMF/jJuW+DqDnB6PqxBw==
X-Google-Smtp-Source: AGHT+IFJ1zO0rlYxTp2BVFrZ01FX3G+S7zO/QepYGho/+nSZcw6Ukw1FzwNPW9wUlR/IQvE58oy1bQ==
X-Received: by 2002:adf:cd05:0:b0:32f:7967:aa4d with SMTP id w5-20020adfcd05000000b0032f7967aa4dmr9201809wrm.68.1701104829951;
        Mon, 27 Nov 2023 09:07:09 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:681:d418:ec9d:2778? ([2a02:8011:e80c:0:681:d418:ec9d:2778])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d5652000000b00332f6ad2ca8sm6767202wrw.36.2023.11.27.09.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 09:07:09 -0800 (PST)
Message-ID: <0ab6a40e-c1a7-4313-ad01-1d2d86835fb3@isovalent.com>
Date: Mon, 27 Nov 2023 17:07:08 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 bpf-next 1/9] bpftool: add testing skeleton
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
 <CAEf4BzZMDfBao58ynxAKys3bB=A+SRLORz65Ce4ron60m=NojQ@mail.gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzZMDfBao58ynxAKys3bB=A+SRLORz65Ce4ron60m=NojQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2023-11-21 19:50 UTC+0000 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Tue, Nov 21, 2023 at 8:42 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue, Nov 21, 2023 at 8:26 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>>
>>>>
>>>> Does it have to leave in the kernel tree?
>>>> We have bpftool on github, maybe it can be there?
>>>> Do you want to run bpftool tester as part of BPF CI and that's why
>>>> you want it to be in the kernel tree?
>>>
>>> It doesn't _have_ to be in the kernel tree, although it's a nice place
>>> where to have it. We have bpftool on GitHub, but the CI that runs there
>>> is triggered only when syncing the mirror to check that mirroring is not
>>> broken, so after new patches are applied to bpf-next. If we want this on
>>> GitHub, we would rather target the BPF CI infra.
>>>
>>> A nice point of having it in the repo would be the ability to add tests
>>> at the same time as we add features in bpftool, of course.
>>
>> Sounds nice in theory, but in practice that would mean that
>> every bpftool developer adding a new feature would need to learn rust
>> to add a corresponding test?
>> I suspect devs might object to such a requirement.
>> If tester and bpftool are not sync then they can be in separate repos.
> 
> I'm also wondering what Rust and libbpf-rs dependency adds here? It
> feels like bash+jq or Python script should be able to "drive" bpftool
> CLI and validate output, no?

As I understand, one advantage is to get an easy way to tap into
libbpf's functions to load the objects we need in order to test the
different bpftool features. There are a number of program/map types that
we just cannot load with bpftool at this time, so we need to set up the
objects we need with another loader. Libbpf-rs allows to do that, and
the "cargo test" infra seems like a convenient way to focus on the tests
only. Bash+jq wouldn't allow to load objects unsupported by bpftool, for
example.

Manu, did you have other reasons in mind?


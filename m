Return-Path: <bpf+bounces-28093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BC68B5895
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 14:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD34B1C23070
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 12:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21019468;
	Mon, 29 Apr 2024 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cukXNbG1"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9DB322E
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393962; cv=none; b=QzBTOwk9w3OjREBjQGDhAiSOYb/x6sIkLCFL5hu9u9Xu14SxxBbqToyyrmsRqDa3BkTbzUNM/O8Nax4tWs11YxRJFnu7EU8HDndl6WSTSTagIJ/zyZJ/29NVTqNQpOcPSHWGQHzGCg1I5EBI8U7ai7+9AZMLiQh8y9m/eXsuq5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393962; c=relaxed/simple;
	bh=2XjcBWFrWlfkGaMgZjTQ97kaiCVz5kolKVBh3NNAPj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jq3Ze7ofxkrIqXKMLIZCYPS6YluRMRkLszDXBgKpv1Tgga5aQusOBPzitf+I+DaX5eRfiFI4zesYFRC5F7J6KP0bJQPvHkOv0yYRfW3fTy7YawVuYwJLsKpI6jK/ztQdNQZrXal3SC4msuKt9pmEEFCku9u0mEp3ZQy5XQ599WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cukXNbG1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714393959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dyf6KycC4dhbSKnBc2/iiNqmUUWpWCbuGk2GuFKP/xs=;
	b=cukXNbG1YYzkhrO54O0MJRw0mvjD9myioRxzCxf0HgX+yoJHzldP1tx0uUd/OY5phVlZtd
	FPJkuL5EcgwaAMvjWHkdwCAPE4PQZJ+ZupBYzDQKNqUXcQBLBUCoSFkXfqghy1SzvOoQLy
	gxm0WmcKIBeoWo3/Mmj+c1Ghivhh5F0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-d27bIobAMHqV6ZY7ucrnCA-1; Mon, 29 Apr 2024 08:32:38 -0400
X-MC-Unique: d27bIobAMHqV6ZY7ucrnCA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a58bca80981so228909866b.0
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 05:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714393957; x=1714998757;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyf6KycC4dhbSKnBc2/iiNqmUUWpWCbuGk2GuFKP/xs=;
        b=KirbXYJrJgEcpXTHgZmAxg7nFjtiVuqo+7RuVFrXkPYZ/80TJzzvC3ad27SXKGDmB2
         xluY+ZpJ52cb0+kksij4KvmzlFdj7dOkUleZs2RjJoK/jr9VD3qblQvDOoJSn5ywPPAl
         U1xigCdG46JmFYCIGdrsoPB5HyjoNYAxIfda+W5yVKpJj1XfWPRGMtgsXdgn5hiF+OuA
         C3Ux/WC7dUvm9YCQMzmiSyQUiGep9E2X+RgY3TkLL/w7n2wOZEAZQCNO38YoKdkFfBc1
         gwGGeNyrc1qb51Zv1FJCsTZe7tfNmMkOS3hD7ZKewvD+nyljOm8wgn34eVBtPY6fwh5g
         XQwA==
X-Gm-Message-State: AOJu0YzHIs1p+Qliyly+v30mD2L1TqDNWBQ7xsBu7cxaVFUeKtlAioo8
	IZ7D/qZoAkwFzxCbhJZXVyTOH08Taip8eMEsuMFm/e07t8gboo8r7lKrcWgiRV0oHUKLQpiW+cF
	Uh6aJ6A/U969CuhSA2BqXtTqR2oSWZbP6xTcQVcpB0Cs98JoOMzUM1NG/w/k=
X-Received: by 2002:a17:906:4ec6:b0:a52:6e3b:fcf1 with SMTP id i6-20020a1709064ec600b00a526e3bfcf1mr6565933ejv.17.1714393957155;
        Mon, 29 Apr 2024 05:32:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVUDA/8s0a00qirEwI0Svbv4Tp2LfswlPGvzV2+5PR3FHQm0/lS1un/YbUaA3e8sfqAvhdaw==
X-Received: by 2002:a17:906:4ec6:b0:a52:6e3b:fcf1 with SMTP id i6-20020a1709064ec600b00a526e3bfcf1mr6565919ejv.17.1714393956772;
        Mon, 29 Apr 2024 05:32:36 -0700 (PDT)
Received: from [192.168.0.159] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906311100b00a5599f3a057sm11191015ejx.107.2024.04.29.05.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 05:32:36 -0700 (PDT)
Message-ID: <51af75df-6909-451e-9d83-8c1bbfb3deba@redhat.com>
Date: Mon, 29 Apr 2024 14:32:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/2] libbpf: support "module:function" syntax for
 tracing programs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1714133551.git.vmalik@redhat.com>
 <CAEf4BzZ8ckB0f7g86XCYxsMgLZFRQ_3eYswZzZNokbrC8Z=qHQ@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzZ8ckB0f7g86XCYxsMgLZFRQ_3eYswZzZNokbrC8Z=qHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/26/24 18:54, Andrii Nakryiko wrote:
> On Fri, Apr 26, 2024 at 5:17 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> In some situations, it is useful to explicitly specify a kernel module
>> to search for a tracing program target (e.g. when a function of the same
>> name exists in multiple modules or in vmlinux).
>>
>> This change enables that by allowing the "module:function" syntax for
>> the find_kernel_btf_id function. Thanks to this, the syntax can be used
>> both from a SEC macro (i.e. `SEC(fentry/module:function)`) and via the
>> bpf_program__set_attach_target API call.
>>
> 
> how about function[module] syntax. This follows how modules are
> reported in kallsyms and a bunch of other kernel-generated files. I've
> been using this syntax in retsnoop for a while, and it feels very
> natural. It's also distinctive enough to be recognizable and parseable
> without any possible confusions.
> 
> Can you please also check if we can/should support this for kprobes as well?

For kprobes, it's a bit more complicated. The legacy kprobe attachment
(via tracefs) supports the "module:function" syntax [1] (which is the
reason I chose that syntax in the first place). On the other hand,
kprobe attachment via the perf_event_open syscall eventually calls
kallsyms_lookup_name for the passed function name which doesn't support
specifying the module at all.

So, to properly support this for kprobes, we'd have to extend
kallsyms_lookup_name to handle the "function[module]" or
"module:function" syntax (here, the former makes more sense).

Since kallsyms_lookup_name is used in many places, I would prefer adding
the kprobe support separately. In any case, the "function[module]"
syntax feels more natural for non-legacy kprobes, so I'm ok with using
it. libbpf will just have to do the transformation to "module:function"
for legacy kprobe attachment.

Let me know if that makes sense and I'll post v2.

Thanks!
Viktor

[1] https://www.kernel.org/doc/Documentation/trace/kprobetrace.rst

> 
>> Viktor Malik (2):
>>   libbpf: support "module:function" syntax for tracing programs
>>   selftests/bpf: add tests for the "module:function" syntax
>>
>>  tools/lib/bpf/libbpf.c                        | 33 ++++++++++++++-----
>>  .../selftests/bpf/prog_tests/module_attach.c  |  6 ++++
>>  .../selftests/bpf/progs/test_module_attach.c  | 23 +++++++++++++
>>  3 files changed, 53 insertions(+), 9 deletions(-)
>>
>> --
>> 2.44.0
>>
> 



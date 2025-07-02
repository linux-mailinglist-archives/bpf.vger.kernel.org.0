Return-Path: <bpf+bounces-62066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EBCAF0ABF
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 07:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF8C4464ED
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6F91E8348;
	Wed,  2 Jul 2025 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbrL4bE6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D507F60B8A
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 05:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751434348; cv=none; b=qWfibI9S4BlyWecAoBAf6wt/jOVOkA9xiq8SPTdqsQIBkIz4/rhMs9LMn9J+mAvBCjp5BLvizafrifct/V9jvfEf416X9wJNyl+75d/q0xzVwuo5M2Fkrrn9bPuRCpLA0UzSqPwd1yk2iCQlYsqpDfIKKJ+/zkIjfPhRepkyFSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751434348; c=relaxed/simple;
	bh=bNKFqQx5BA4F1gcMkOC05yyFEMhQLatxj+2XyRPztec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhVFRUC+jUWHU8FuHJW3GYolTpOTOOlDmUzzfymRM5JDaz/1ZuUKCllultcNGqj4yWPwfOj3c+zq6sdk9R0WueL/3/BBrQ+ZR+9BeDtL2UED8bnURUWlrVAC/tFjVlggUZJAO0GCclz9nn+3ZOXAAsFjTH/326DOiACX24/xo84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbrL4bE6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751434345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwDYL2eazjrtz/Jxwq3mONSkZ5R616EwPNg/QCuqgDU=;
	b=PbrL4bE6T1ESHdbZdzD1BsdGvWYajLGx2cIT0Z4wuc9L7zfoopQNI4KB/6LIZcmpet9XAx
	lHokNLmdVkez4Ih6SCfw01glgY3MYFqb1xKHBd9itD38Jym7859LlrsKje/bGrV0pfskUp
	HMzZHzwIA6JUBtGAygYVOAi1VYF55D8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-Nt8la4HEPeKmhdve54PGBg-1; Wed, 02 Jul 2025 01:32:24 -0400
X-MC-Unique: Nt8la4HEPeKmhdve54PGBg-1
X-Mimecast-MFC-AGG-ID: Nt8la4HEPeKmhdve54PGBg_1751434343
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6095fc6bc40so3245992a12.1
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 22:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751434343; x=1752039143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwDYL2eazjrtz/Jxwq3mONSkZ5R616EwPNg/QCuqgDU=;
        b=MVSfqdD+RjFoj/bCUFDe9ZjBkQfalYjgrYjos2XGlfMjzqmaGulOFyGSoDmbP2bxiR
         zYuhcww56ml0Z5AyVaWxjqM82374uBif6wNTetXvW8sviS026Nv62jjYzUk9mkfK3rl1
         diWdWGHoiDgHbm+8vpwCxYpcVBTt17VR7tiUU2/nG/2kf2lpyszaEU3QWOdWqzKO87aB
         dnLwWXZMxN9PVSFf/ojp/RQ10tH6f98jR+74avTOd53BctKEpLOUJOLIVwLmG7Q/rrgI
         IOXsfH67mFrmN4AziHCX5FKgs33t71tCfaWEVa063iYSk5XWA783K0SlxNDUP9M06u1l
         rb/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZed6TMkXW3UvlBRFlpVt/YzrzxiRV5s/5dGMc8OZYpWVn4bLopRjlmCKeCTOhKr4Ltv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsjjIlVTDcgOTvEmCppR279aAsZvDSx8N43ki8lJQ4wY0MSw3e
	48J9z2KEc23FXaqDC7hJmxWJTDxNl09bE+VpeTPThd6vhCJJt1ToSmgpoxgQ9RxqMjE2yakEpz8
	XxsNmVs4tFNRPWS6V0BnxZS0XwTivlFXvKOKB06cyLJ7dauTr7gFt
X-Gm-Gg: ASbGncuOvCYzmGPC/jbLZPZfuR6Fk93XGqgXJx2BzWMqabSW08PRUy3KiLLhfrUf7+G
	TGAh+BnXaHPwZ+/R1OkcbBfKK1HxcUSZJcDnlv6Hns8OyMcPSzC0oDgLPLjSeKlcmpEJ7Ef2b5w
	7V+gKVopkI02K9aD/Ay4ctrd+fbTuLPgGMwS0qC6pxLFLoDK9H5VB7mgFsiGFCN+/s3RSuysEnW
	Lct1dXsKJjoSruWP58VzvYO3E97WzkQ/l2SJ+cJfFgd1riuVOTXZXRTIzv2KvSiDwC2uvHHFsa3
	CtGoURGGZgGjOgqGqJc5HF76wH4kULu/9YTzgXU/b58J9BswGIxm9nVs
X-Received: by 2002:a05:6402:b7a:b0:608:f399:d73b with SMTP id 4fb4d7f45d1cf-60e52ceab4fmr827411a12.15.1751434343295;
        Tue, 01 Jul 2025 22:32:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmpn8ScV+Ib7lvO+v0YduI5T6VWOi/DXSafgr5XZrw0UsMz4RzmrI/bDQSeIDcoFz4FC0uow==
X-Received: by 2002:a05:6402:b7a:b0:608:f399:d73b with SMTP id 4fb4d7f45d1cf-60e52ceab4fmr827388a12.15.1751434342852;
        Tue, 01 Jul 2025 22:32:22 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c831d8be2sm8530890a12.65.2025.07.01.22.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 22:32:21 -0700 (PDT)
Message-ID: <3941f0b0-c7a8-4ca3-8893-791749ce250f@redhat.com>
Date: Wed, 2 Jul 2025 07:32:20 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] selftests/bpf: Re-add kfunc declarations to qdisc
 tests
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Amery Hung <ameryhung@gmail.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgense?=
 =?UTF-8?Q?n?= <toke@redhat.com>, Feng Yang <yangfeng@kylinos.cn>
References: <20250630133524.364236-1-vmalik@redhat.com>
 <CAADnVQJF8-8zHV75Cf7v8XWGVrJwU5JaQjBm0B-Q3JUUMqNmcQ@mail.gmail.com>
 <49fcc6c3-8075-4134-bdbd-fbd8a40f4202@redhat.com>
 <CAADnVQKQTLDP1W1ao-mCPfLDbZWykW1TdcouJPSVapNWu=bCBw@mail.gmail.com>
 <CAEf4BzaM9_RbUfi2Gk-=_2D3OC8GiDS-vT5-9CHOd07r=+wyeg@mail.gmail.com>
 <36400b83-1a6f-4da0-9561-073bd268c58e@redhat.com>
 <CAEf4BzZZ2f1cP8zDDsqME5wcOYUECh6UKwxtTWbDfSjmdJD60Q@mail.gmail.com>
Content-Language: en-US
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <CAEf4BzZZ2f1cP8zDDsqME5wcOYUECh6UKwxtTWbDfSjmdJD60Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/1/25 23:07, Andrii Nakryiko wrote:
> On Tue, Jul 1, 2025 at 1:54 PM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> On 7/1/25 22:28, Andrii Nakryiko wrote:

[...]

>>> Note, we have a VMLINUX_H argument that can be passed into BPF
>>> selftests' makefile. We used to use this for libbpf CI to build latest
>>> selftests against (very) old kernels, and it worked well.
>>>
>>> I don't think we need to make exceptions for a few kfuncs, all it
>>> takes is to have vmlinux.h generated from kernel image built from
>>> proper configuration.
>>>
>>> Also note, that "proper configuration" only applies to *built* kernel,
>>> not the actually running host kernel. See how VMLINUX_BTF_PATHS is
>>> defined and handled: host kernel is the last thing we use for
>>> vmlinux.h generation, only if all other options are unavailable.
>>
>> This is a good point but the problem here is the extra kernel build. If
>> you want to check that BPF in your kernel is working properly, you don't
>> want to do another kernel build with a different config just for the
>> sake of being able to build selftests.
> 
> What exactly is problematic? That's what I and others do all the time.
> If kernel build time is a concern, then pre-generate/pre-package
> vmlinux.h separately and use it to avoid building the kernel. (but BPF
> selftest *expects* kernel to be built first, we also build bpf_testmod
> against that kernel). Or just build/package test_progs itself, if
> that's what works better.

Yes, we need to have a kernel built before building selftests but your
solution would require to build it twice - once with the desired
configuration and once with added selftests/bpf/config to generate
vmlinux.h that can be used for selftests build.

Pre-building vmlinux.h is not really an option for automated builds as
every kernel change may introduce some new kfuncs which will be needed
for selftests build. So, we'd need to build vmlinux.h every time.

> Basically, we have that selftest/bpf/config file for a reason: so that
> we don't guard every single thing that might not build or work
> properly if some of the Kconfig value is not set.

[...]

> we should be getting rid of all those __ksym __weak kfunc
> redefinitions because they now should come from vmlinux.h, not add
> more of that, IMO.

I understand that having those kfunc definitions in selftests is
cumbersome and has maintenence cost. While vmlinux.h works for upstream
use-cases, it has its problems for distro packagers, so I'll try to
think about some solution that would be acceptable for both sides.



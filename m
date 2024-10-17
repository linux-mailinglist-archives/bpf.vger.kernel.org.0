Return-Path: <bpf+bounces-42280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8DD9A1D40
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 10:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08BCC1C259B1
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 08:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CA31D27BA;
	Thu, 17 Oct 2024 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrWDNe0T"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085723398B
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154049; cv=none; b=H7rrmEznM82DZ1r+88cKgsrzGYg6hqx7LXWybReM2aAbzX1KNaSHghsF5TDz2uWBPseH+/NzVLbIj4d2r3fzJcLHiRgJblU94/GvjNH95kuNt6I4vC8sG7gwrk4RHBeVaq9icnvg3n14dIlxuAjL0oq1wJbm5Ea0Q8v91PC/B4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154049; c=relaxed/simple;
	bh=P0nXvfWomw3C9ESVkp7IbAL2d0G5sWwm4C710nBdT+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4XN6iPxo+pmp4AGPPvudgF2zS9RxLm/XStoaXml4OnlKG5SchK0110VY3eKQFSKl2EwpW1g9k3AORJzgbXXV+AIwcoRLbprpwmbR1qBSgsxJIbF++2EvqTKRRlRaDkAfMw4KPovXsyi6LwWMmsX4UUchnpqvxUC55i7+mjlElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HrWDNe0T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729154047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aX2zKy52+AP6o5lPWX9LcXwcwPL2vLt549s5dMVMcqw=;
	b=HrWDNe0TIW+SLNV18HWdiAViqyGaTgppUzgiZpTmT9k10k4p1pbJMpeSbhNakInBatMw+v
	FV6G9bqhp61K2vrC0yJPsQTwMpFfCfvrxkjtLv0oVAkxLmZpFlyyJaS8U3W8PKYZ5Aotck
	rGU3MZjQhLtHyoHKqzm5VXvm78dOwe4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-cISU_BR5MzOQrpjNPji-9g-1; Thu, 17 Oct 2024 04:34:05 -0400
X-MC-Unique: cISU_BR5MzOQrpjNPji-9g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-431518ae047so7273385e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 01:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729154044; x=1729758844;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aX2zKy52+AP6o5lPWX9LcXwcwPL2vLt549s5dMVMcqw=;
        b=w1KsciDodXOa9EBT0H50/gK7D0c06r7so8MrGzv1RIN4LvvDhSfmwlLF4MPnujXoam
         ts73ubWBaycdiA3OX7vAZss687s4564Vo1WBzjtW1tzd6DRW75YRqnhikrRWL5nHvzBz
         QDMjK1JhAoLJQs5JngXm/9ZacM+GrRfet3j5liVnRRUdmpzlfCN3J6oIqMhLVj/QbhmB
         PIbjiokzqPXZD8/75C09ysURTV+5aHRwK0bDkHgP81CQ36EF1F1CCYNd9Ot6vrPcl5tf
         jS3mbPf0NCFhxbVxr0FfGmHyFn/8v8EqgUchftpg144LviNzfiwtk+kdWJH/pJiwLJkD
         8/Lw==
X-Gm-Message-State: AOJu0YxeIn6/1xnNIlYprOjs9j8xNZm/LSeCd2m+w4Yk6/5vTutvfip3
	Jo4RRsBRXl0qkz8e1omecXOQ6lSluuozi+Ct9Uql9zy987sV/TNhOrxvodkr7iQwC0eLQtr1rgk
	Ftf5wiHTpLp4rWM8LxOqNVUWguATj8IXdqmjV3a0knkfWAeY1
X-Received: by 2002:a05:600c:198f:b0:431:136b:8bef with SMTP id 5b1f17b1804b1-43158710561mr13721895e9.7.1729154044618;
        Thu, 17 Oct 2024 01:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES3rghOEhZoMv+3jsAQKaygZINGv0RXpwqexySdSvbhBSMAYc7mrFBM3dUXv+RRsOzYWrh9A==
X-Received: by 2002:a05:600c:198f:b0:431:136b:8bef with SMTP id 5b1f17b1804b1-43158710561mr13721645e9.7.1729154044170;
        Thu, 17 Oct 2024 01:34:04 -0700 (PDT)
Received: from [10.43.17.54] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa90915sm6595072f8f.56.2024.10.17.01.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 01:34:03 -0700 (PDT)
Message-ID: <094b356d-ecfb-4bfe-9d90-4268d4cf5f12@redhat.com>
Date: Thu, 17 Oct 2024 10:34:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Allow ignoring some flags for
 Clang builds
To: Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <cover.1728975031.git.vmalik@redhat.com>
 <08becac5b0b536d918adeb90efd63bdd7dcc856c.1728975031.git.vmalik@redhat.com>
 <CAEf4BzYv6+v_AUp-xF=1z6spjLc0cp55fg-t=b4-bcwR+LFanA@mail.gmail.com>
 <7fdc3253df59bd216eec02a53bbd0adc06fb8e7c.camel@gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <7fdc3253df59bd216eec02a53bbd0adc06fb8e7c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/17/24 00:18, Eduard Zingerman wrote:
> On Wed, 2024-10-16 at 13:37 -0700, Andrii Nakryiko wrote:
>> On Mon, Oct 14, 2024 at 11:55 PM Viktor Malik <vmalik@redhat.com> wrote:
>>>
>>> There exist compiler flags supported by GCC but not supported by Clang
>>> (e.g. -specs=...). Currently, these cannot be passed to BPF selftests
>>> builds, even when building with GCC, as some binaries (urandom_read and
>>> liburandom_read.so) are always built with Clang and the unsupported
>>> flags make the compilation fail (as -Werror is turned on).
>>>
>>> Add new Makefile variable CLANG_FILTEROUT_FLAGS which can be used by
>>> users to specify which flags (from the user-provided CFLAGS or LDFLAGS)
>>> should be filtered out for Clang invocations.
>>>
>>> This allows to do things like:
>>>
>>>     $ CFLAGS="-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1" \
>>>       CLANG_FILTEROUT_FLAGS="-specs=%" \
>>>       make -C tools/testing/selftests/bpf
>>>
>>> Without this patch, the compilation would fail with:
>>>
>>>     [...]
>>>     clang: error: argument unused during compilation: '-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1' [-Werror,-Wunused-command-line-argument]
>>
>> maybe we should just not error out (i.e., enable
>> -Wno-unused-command-line-argument)?
> 
> I agree with Andrii, grepping for FILTEROUT in kernel source code does
> not show anything similar to this. Are such filter-out variables some
> kind of convention?
> 
> Another option might be to remove `-Werror` and add it on CI via EXTRA_CFLAGS.

Enabling -Wno-unused-command-line-argument is the simplest way here,
let's do that.

Thank you both for suggestions!

> 
> [...]
> 



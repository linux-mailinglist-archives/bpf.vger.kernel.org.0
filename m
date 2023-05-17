Return-Path: <bpf+bounces-787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C888706C0B
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 17:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F33280D02
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 15:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CA65CA1;
	Wed, 17 May 2023 15:03:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F26C1C26
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 15:03:42 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EAC9032
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 08:03:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f41dceb93bso6348265e9.1
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 08:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684335730; x=1686927730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNJBKKeCjzTVVFdLwQ1isVioJ2mhZaKWga8sMhuJA30=;
        b=QYLaYhTIe30ASbyvkDpTjsscVfqFCbRhfyp4rv87lxZI8g/lnDj26iIAdVpcmHXCUu
         G1DHQ7zMdXND2/oWg3mLP6Jom2O7kXVQ7xWTt3qSQL9VJMJ5bMGwSH5DRh6OuD3thyHE
         8TZXEud5ypYQaF/x3esg71xfvBWjlRuW/thiYmPraTZwfihsd4rMHafxkJLSdpBKed+7
         P+LdcWR+U58ovaRwALfTL2FTKUzkRvBkAo8Aw27+BtXcnbVU8kAUl6A1OHTVnmw7hwB5
         qyDcCxgHAoGj8lucByESYao5vHvScBK1NrK9VrxmjZS6jb0qPaklcUYUm5KQFr7C/+k2
         mqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335730; x=1686927730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNJBKKeCjzTVVFdLwQ1isVioJ2mhZaKWga8sMhuJA30=;
        b=VZbQRksev7nCo07VxqnMNb2yzgJyNo/xJDdK8sTSKofD6diO6XCwvbTYwHyHcvCxcD
         OZTnM1Eu8DNDChJWtKqFANxbhgFnjrmGeH5xyg3Z+dAK9bO44NQyQkQQfGg7SiGl9Tjt
         P6eg+ak4ObkmxRc7+1cgY+8CkSeLWLPNlj35PI3877WeaFi4a+iaNRJQnlLAqtJKjNnr
         1/yh7pv/si203rEgp3SyVRS00+4lNEE5pxN/p3rk1478K2VxpJDNrwATxtt201HKARN1
         TXcEPGgv1sDStesavnC1FpHCgDB5Xi8Qazn4FQMYY+Xw0wwsWt8gZT9zScsEwVQXWxST
         z67w==
X-Gm-Message-State: AC+VfDwMI7IfhpqekM1EADr+j0izkplzqyCJCSZ5TXXWlDz6jgHA5/4r
	SecvrU87IicEHpUTais3lRz27g==
X-Google-Smtp-Source: ACHHUZ4GXtj29HDN3E9WiPvHyIzudXajkc1nBF8TRUawkEqqS3eMYv9guelSkMv+bfqkawkb9e+6oQ==
X-Received: by 2002:a7b:cb92:0:b0:3f4:2374:3515 with SMTP id m18-20020a7bcb92000000b003f423743515mr25680401wmi.5.1684335730448;
        Wed, 17 May 2023 08:02:10 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:d197:4e36:5d90:37fe? ([2a02:8011:e80c:0:d197:4e36:5d90:37fe])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c220400b003f4069417absm2477963wml.24.2023.05.17.08.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 08:02:10 -0700 (PDT)
Message-ID: <06d1e47a-8ed2-6714-7d2b-da5deb55b1f2@isovalent.com>
Date: Wed, 17 May 2023 16:02:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next 4/4] bpftool: use a local bpf_perf_event_value to
 fix accessing its fields
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Alexander Lobakin <alobakin@pm.me>
References: <20230512103354.48374-1-quentin@isovalent.com>
 <20230512103354.48374-5-quentin@isovalent.com>
 <CAEf4BzZ=wp81zdfTTWefiuq2O28aLiHc5Vq88D4hGeb=qy6zJg@mail.gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzZ=wp81zdfTTWefiuq2O28aLiHc5Vq88D4hGeb=qy6zJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-05-16 14:30 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Fri, May 12, 2023 at 3:34 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> From: Alexander Lobakin <alobakin@pm.me>
>>
>> Fix the following error when building bpftool:
>>
>>   CLANG   profiler.bpf.o
>>   CLANG   pid_iter.bpf.o
>> skeleton/profiler.bpf.c:18:21: error: invalid application of 'sizeof' to an incomplete type 'struct bpf_perf_event_value'
>>         __uint(value_size, sizeof(struct bpf_perf_event_value));
>>                            ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helpers.h:13:39: note: expanded from macro '__uint'
>> tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
>> struct bpf_perf_event_value;
>>        ^
>>
>> struct bpf_perf_event_value is being used in the kernel only when
>> CONFIG_BPF_EVENTS is enabled, so it misses a BTF entry then.
>> Define struct bpf_perf_event_value___local with the
>> `preserve_access_index` attribute inside the pid_iter BPF prog to
>> allow compiling on any configs. It is a full mirror of a UAPI
>> structure, so is compatible both with and w/o CO-RE.
>> bpf_perf_event_read_value() requires a pointer of the original type,
>> so a cast is needed.
>>
>> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>> ---
> 
> What's the point of using vmlinux.h at all if we redefine every single
> type? bpf_perf_event_value is part of BPF UAPI, so if we included
> linux/bpf.h header we'd get it.

I gave a quick try at the UAPI header before posting this patch, but it
was an Ubuntu box and I got the "asm/types.h not found" error. If I
remember correctly, one way to fix this is to have the gcc-multilib,
which I'd rather avoid to add as a dependency; or adding the correct
include path for x86_64 at least, which I haven't tried for bpftool yet.

> 
> This feels a bit split-brained. We either drop vmlinux.h completely
> and use UAPI headers + CO-RE-relocatable definitions of internal
> types, or we make sure that vmlinux.h does work (e.g., by pre-checking
> in a very small version of it). Both using vmlinux.h and not relying
> on it having necessary types seems like the worst of both worlds?...

Yeah I do feel like I'm missing something in this set and the approach
is not optimal. What do you mean exactly by "pre-checking in a very
small version of it"? Checking for the availability of a few types and
exit early from the functions if they're missing, because we're assuming
we won't have support for the feature?

> Quentin, can you see if you can come up with some simple way to use
> vmlinux.h if building from inside kernel repo, but using a minimized
> vmlinux.h generated using `bpftool gen min_core_btf` when building
> from Github mirror? Sync script could also generate this minimal
> vmlinux.h automatically, presumably?

Sure, I can look into it. But not right now - I'd like to get the
current issue, and the (unrelated) LLVM feature detection, sorted before
starting on this.

Thanks for your feedback!
Quentin


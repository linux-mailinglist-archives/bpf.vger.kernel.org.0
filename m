Return-Path: <bpf+bounces-4415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3F174AE26
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 11:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025A21C20FB7
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 09:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6DDBA43;
	Fri,  7 Jul 2023 09:54:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381D420E0
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:53:59 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C5790
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 02:53:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbf7fbe722so15741725e9.3
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 02:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688723637; x=1691315637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZzIDbJubyJPiHNRpLaVKCet8/bSMK1Lr6hWXR+SUvc=;
        b=NWTsoTrD+M4qwEA/veiShmrn9OHOcCG+42ppe/xgI+2zPnOn4e96MlqsZPVp67y4IH
         Gl40GTKx/v1IlkYoMgezrnN2EnxjyNLu199Fnk7cQMYwI7UNOCC93hgB5f4ubncDjLJ8
         lXF+C58ABDH6kX4D/Jiba3v5RJHsukz3sDFKybBt94c4CKt3zHs4G2u19mjn7z/tiCKL
         dCND74loNqbo0+FPZzbvwq4mpX87DzTnXpo0xDoD96kNXXP9rHW57s1TzQFLfqnkzNIu
         jIj4atW+neHBRrBOBVhxEnRtTrOlUMzgza6r+7SOcMWmz3R19MpC5gaEaACh9NSaCeUH
         Qz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688723637; x=1691315637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZzIDbJubyJPiHNRpLaVKCet8/bSMK1Lr6hWXR+SUvc=;
        b=Z20oDKgLKhl0R3Q4UwCyU+YR6zfpRhf1j2hWAoons5ItpDL1IJcC80vxcolp97+1df
         1Dpi0/c6u0nuhlDxv6UxXHRNYoTNxUQWJvfq5m2hqCvtp4iVPyXzHISyJhtdhhS98wc4
         8PA/kzzRTH/dQpGkhb0ACm5QEANDA0zqx3QogfI0DtfNGV9xoP5koxYoVpyfFxXjvcyt
         GikdnV3mmPs6TsbVsMMHHnAuzKwYbEc0fVqCLUgBLfexMW5p95JfYufVYXqa+UioEmDL
         FbC4aTBBNKig2yV9uHPS8NOCBUUzIL/n1oFya098W5Ou+EMkMYD3BPab0iQgW6O33BWq
         JCig==
X-Gm-Message-State: ABy/qLbd8JX1jf2gD7rnwSV9mxYHRR0D0DWfrnmR5vpNf42g+B+JAVKa
	W9J88mX4thX7uHhstCwY3Z/K8/2FWiF9oDjgl8FlCA==
X-Google-Smtp-Source: APBJJlEtNkkqnlClPXIsNzKyKldxzQWzLR+77ot0Oe3efo9YkV9GLom91aWWdsL5wnaGOeBThGzpuw==
X-Received: by 2002:a05:600c:247:b0:3fc:65:8dff with SMTP id 7-20020a05600c024700b003fc00658dffmr1108375wmj.4.1688723636889;
        Fri, 07 Jul 2023 02:53:56 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:9d9e:aaa3:b629:361? ([2a02:8011:e80c:0:9d9e:aaa3:b629:361])
        by smtp.gmail.com with ESMTPSA id f23-20020a7bcd17000000b003fbb5506e54sm1951377wmj.29.2023.07.07.02.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 02:53:56 -0700 (PDT)
Message-ID: <47f6bb17-6a18-99b3-bc13-773fbf8a9243@isovalent.com>
Date: Fri, 7 Jul 2023 10:53:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next 4/4] bpftool: use a local bpf_perf_event_value to
 fix accessing its fields
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Alexander Lobakin <alobakin@pm.me>
References: <20230512103354.48374-1-quentin@isovalent.com>
 <20230512103354.48374-5-quentin@isovalent.com> <ZF44Nzzw09x2n88o@krava>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <ZF44Nzzw09x2n88o@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-05-12 14:59 UTC+0200 ~ Jiri Olsa <olsajiri@gmail.com>
> On Fri, May 12, 2023 at 11:33:54AM +0100, Quentin Monnet wrote:
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
> 
> hi,
> when I switch off CONFIG_BPF_EVENTS the bpftool build fails for me
> with missing BTF error:
> 
>   GEN     vmlinux.h
> libbpf: failed to find '.BTF' ELF section in /home/jolsa/kernel/linux-qemu/vmlinux
> Error: failed to load BTF from /home/jolsa/kernel/linux-qemu/vmlinux: No data available
> make: *** [Makefile:208: vmlinux.h] Error 195
> make: *** Deleting file 'vmlinux.h'
> 
> so I wonder you need to care about bpf_perf_event_value
> in that case
> 
> jirka

Coming back to this - I haven't been able to reproduce. I turned
CONFIG_BPF_EVENTS off but had the vmlinux.h building fine in my case,
and applying the patchset fixes the build for bpftool. Is there any
chance your .../vmlinux was not generated correctly?

I'll re-submit the series after addressing Yonghong's feedback on the
commit log.

Thanks,
Quentin


Return-Path: <bpf+bounces-556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D577034E8
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 18:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D00280DE3
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 16:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2F9FBF9;
	Mon, 15 May 2023 16:53:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82AFBF0
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 16:53:58 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872C672BA
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 09:53:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30789a4c537so7005692f8f.0
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684169635; x=1686761635;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m14BdaDxJ7yTw7d4acibNNyRKhXHt6eNiGPjqWA1oIA=;
        b=S/AGDai5rbz/iKgBIlUFd2ID67LMCI9GlXpzREWcWg/fpkkXnhiyaNNgQkGcM8HMUF
         sjBX0L2oM8qWiG5rx1PHGVm0Em9XGD0D7J+GL8M7wyz25TMxbdB24WR0CoAx7d6r7jHa
         iU71n0kORPBBTGkDqobWuHvhID29yQDscRadcHGjXqf6j4xdz8ePOVq5Hwqsy++q20/u
         2/pdHLIjQGIVVkwOKL7Se+KCo6aN2ZNyA1pHtcDQjWRimba6iqW0RaInVDBFOVU57Ktb
         b1gHX3QJ/QdNWHWGR2GhePH8NSuNMWfosZgT9wFa/qRXWXlypaWshjsqjv4PzdWuq3mA
         AL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169635; x=1686761635;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m14BdaDxJ7yTw7d4acibNNyRKhXHt6eNiGPjqWA1oIA=;
        b=J18EMas15BSB3LgE/BfI4Z8TNW2WqHQ9mu5s1FnOZ8CmQzNI/9oVSqdRuGK65/FT3J
         +4xLOy9HQRW5kQqv9h1duDEMmnolk/aLs1d/8uAlNI3noqhbH7UAk29MQnlJjwYcXrmx
         BoF+KgGt2lPmfFW5ae7kUqW1OVQJ6mu4fxmJD1qmiH8MzP91va8/8Nf1QwnHZGOuhywF
         N3j7obK3CJXixZKN6q2QX1jkFr1b0LwCaKdl750+dD4AjYYsTT8Uxj/0UkQl+Bna39fU
         s0H8GuYwGji3walZjp2yc1/E/fGcwEHKZyZDQWw83dt3/35OR49SFE1HznInj8gzNM7A
         Qutg==
X-Gm-Message-State: AC+VfDxXPAqygAoV3kNNfrBIipvr71dd2biXLzaAKycCquJWQUdq7ck1
	JhIxkbtwjj9qM+w2h9hs6XrHcg==
X-Google-Smtp-Source: ACHHUZ5iUP1/omlobqQgXI6DTcn9/ibeHFhAOlQ4CIPk1R/Ovh/3k3po/gaoKdX4QMoU3di+RFIiSg==
X-Received: by 2002:a5d:6841:0:b0:307:8d93:a47f with SMTP id o1-20020a5d6841000000b003078d93a47fmr22351503wrw.55.1684169635020;
        Mon, 15 May 2023 09:53:55 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:9cdc:e9dc:864d:1455? ([2a02:8011:e80c:0:9cdc:e9dc:864d:1455])
        by smtp.gmail.com with ESMTPSA id b12-20020adfee8c000000b00304832cd960sm350044wro.10.2023.05.15.09.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 09:53:54 -0700 (PDT)
Message-ID: <0a1ef50c-f593-225f-2e53-4a58fb1fdeca@isovalent.com>
Date: Mon, 15 May 2023 17:53:53 +0100
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
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
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

Thanks for testing, Jiri! As I understand, this is the vmlinux.h
generation failing, not the compilation from the updated skeletons, so
I'm not sure this is related to this patch, could be an existing bug.
Have you tried the same build without the patches, by any chance?

I'll try to reproduce on my side to try and figure out why libbpf's
bpf_parse_elf() fails to find the .BTF section.

Quentin



Return-Path: <bpf+bounces-394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576FD700778
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 14:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782401C211DE
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 12:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5451ED530;
	Fri, 12 May 2023 12:09:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C27F0
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 12:09:47 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB5311B5E
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 05:09:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f4ad71b00eso20423745e9.2
        for <bpf@vger.kernel.org>; Fri, 12 May 2023 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683893384; x=1686485384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bR5m6+kVJzDP3tWDyiYV6KeeUfXkuj2q0OdvpS6EZ0w=;
        b=N0Aq377gTyNjx0+RK96foxIeywDFBa6CYx4Q1Lk5LyBpgJdQOPbnOhJss0VAcxFRco
         PDS4ETR+WKX6S46mgakTY+sEgyRfnBEzJ6PSCcl0EGY18V9OpkCUf978H/jQjC3Ia8Jl
         FCs6UHPSGLOgfICxdrXrgISCf8iSh8RE9zDzemXC5G3AGSkES6xPtNkmFrJIu0LzOk0p
         9WVZJdsQJ3P7LF2ggrzobhdUKGthjf2By3gyel+T8JkpvJ/BNfwf08sgCMAlItIBIDgK
         /FPvvkySHci3tlrJ/2Z9TlXIZUCw6zRQN9M6rnw+vr3MQzMJbAlYcbGT3HvjOjbRaxzt
         ytHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683893384; x=1686485384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bR5m6+kVJzDP3tWDyiYV6KeeUfXkuj2q0OdvpS6EZ0w=;
        b=OZk0Y91srPVEVwYYdZE4q2C+tB+aWmhZWJGEgNi+LB0ITumw92zq3lrQO7CEwK+cYy
         yPiP+kip7Y6IjhuhoFnmW5HtYT+kUB0uNvmfxb0p60lqCMpoZav8GYN7pTh3WMFUFiTI
         fC2WWZvrdlWmK0A8Uxlv7aAnUeaTTm/ck9oD2EUBk1C2q6AQWHWXL1vJl7KIQ0NF1X09
         Oj6aH1Up12sFFd+lfVxJVWpscNLqFkCBsLNR8emwZ2Rh0t7/PW1ZvkCgZepYsJ718w4o
         eaQMzNDspaN09NDQpZVOUoZh9jkL5q8wqqxK5tuHfx0V9qKPmQteM5AmLju9Y4M9FWsv
         R9cg==
X-Gm-Message-State: AC+VfDy6HwfxsBw2wQ8bp6dv1UToU2x7jUTKdGJbFHccNtme6v1AMF+f
	XYKCbgQBA1lx3m8aZ6OjMaGzbQ==
X-Google-Smtp-Source: ACHHUZ4oHgcJYc2CunmcLppTVvjV0a9AAaehcoCE/p5Tu/z7kvlal8hQL/TBsKmqWQci0uIW0f5h3g==
X-Received: by 2002:a5d:4485:0:b0:2fe:c0ea:18b4 with SMTP id j5-20020a5d4485000000b002fec0ea18b4mr16907745wrq.24.1683893384416;
        Fri, 12 May 2023 05:09:44 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:a162:20e4:626a:dd? ([2a02:8011:e80c:0:a162:20e4:626a:dd])
        by smtp.gmail.com with ESMTPSA id n19-20020a1c7213000000b003f4268f51f5sm14145411wmc.0.2023.05.12.05.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 05:09:44 -0700 (PDT)
Message-ID: <294f1d94-0afa-5155-6c43-a3b1e3fd5604@isovalent.com>
Date: Fri, 12 May 2023 13:09:43 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH bpf] tools: bpftool: JIT limited misreported as negative
 value on aarch64
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>, Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, kuba@kernel.org,
 bpf@vger.kernel.org, Nicky Veitch <nicky.veitch@oracle.com>
References: <20230512113134.58996-1-alan.maguire@oracle.com>
 <ZF4p1qAaJ1UwjInt@krava>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <ZF4p1qAaJ1UwjInt@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-05-12 13:58 UTC+0200 ~ Jiri Olsa <olsajiri@gmail.com>
> On Fri, May 12, 2023 at 12:31:34PM +0100, Alan Maguire wrote:
>> On aarch64, "bpftool feature" reports an incorrect BPF JIT limit:
>>
>> $ sudo /sbin/bpftool feature
>> Scanning system configuration...
>> bpf() syscall restricted to privileged users
>> JIT compiler is enabled
>> JIT compiler hardening is disabled
>> JIT compiler kallsyms exports are enabled for root
>> skipping kernel config, can't open file: No such file or directory
>> Global memory limit for JIT compiler for unprivileged users is -201326592 bytes
>>
>> This is because /proc/sys/net/core/bpf_jit_limit reports
>>
>> $ sudo cat /proc/sys/net/core/bpf_jit_limit
>> 68169519595520
>>
>> ...and an int is assumed in read_procfs().  Change read_procfs()
>> to return a long to avoid negative value reporting.
>>
>> Fixes: 7a4522bbef0c ("tools: bpftool: add probes for /proc/ eBPF parameters")
>> Reported-by: Nicky Veitch <nicky.veitch@oracle.com>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> jirka

Acked-by: Quentin Monnet <quentin@isovalent.com>

Thanks!



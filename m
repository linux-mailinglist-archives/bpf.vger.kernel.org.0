Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16BF6D2328
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 16:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjCaOxv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 10:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjCaOxf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 10:53:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7FF2061A
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 07:53:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p34so13042000wms.3
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 07:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680274387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FjQfBygyGyyQ6qzN5cwRkGLirbe9fl6JMlCUNfyAmbM=;
        b=e3jdgicUcMH1wQPXI4HLcZTzVMSn3gkxMtGe7BsIvQcWkmj4wQzRymSEkFAvm/Nr/0
         /HfCrr+2GVWMN//eUIPAZmVUMY8k6BCQpOYtkAG5YeoIUnb0pByUpnUyhvfWqDF7b1sY
         pcAnzCve6InFFpYV9QAnewUA0Es+ybd9b5PrAzaZAngdcuZLEaVcmpIW7XgJnzEj1voX
         ePWWJcbSpi28F9cCWXuXNt0Sv1JhEgPj8e2tbkYguNk6wAgEAd9DSDMinZCs/FdrTDtB
         K3K1TKlt3h3ps7iJjnq00Bo3X80L7VSOZv9L/36u1hK+VoCuvkqJjoAlN+AfPdUUnRze
         ZQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680274387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FjQfBygyGyyQ6qzN5cwRkGLirbe9fl6JMlCUNfyAmbM=;
        b=zWaXwrbdgTqKRYPwHaCepYlumAOtfcvDzxUtNVj7RcIkAC1yO5DDWwYo/YKxPaiPx2
         VB6DnT1nyxyoDixg9Za1x7NRvsd+7kBh7CZMSJy9Q9zn5pgKUG4yT0CrYl4PbUiaijRa
         c/ekloOoVIuKLNeUcpx/NIHpsDR7vudn/uI9rHO/O0FpfznVinzqG9gtpvPGCyFRGssa
         MLhaq4fZLMd0x16E4v6RbN/Fchz5XL4vEv7a/45gXIb5+nrzNQ7qFebzDsnquELvdVhu
         72SbLFF81zbigc3v4HzeWQJmM0z8zNpG3arb2HO/zDRyEIOm2GRwC8eGOODZtSPUygiQ
         ugGA==
X-Gm-Message-State: AO0yUKW7dMCX1GwiwxdIzaB9MgfgmABrGllG/x3NfST9lmkr51gWg43d
        2zOjNfZKw2CGKacxs8iwvf7kwA==
X-Google-Smtp-Source: AK7set8cXZq45UP4GEXIfBQ3Vi7A83jZYB7HvPrUBNtdpburX1QXnm6rsFlU1xTx2nOsFdtCpytAIg==
X-Received: by 2002:a05:600c:22c4:b0:3ee:67ff:4aad with SMTP id 4-20020a05600c22c400b003ee67ff4aadmr20650554wmg.26.1680274386782;
        Fri, 31 Mar 2023 07:53:06 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:2132:91fa:4658:d135? ([2a02:8011:e80c:0:2132:91fa:4658:d135])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d5002000000b002cfe0ab1246sm2396822wrt.20.2023.03.31.07.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:53:06 -0700 (PDT)
Message-ID: <7cb20aa0-fd1c-d459-5250-82843b65c37e@isovalent.com>
Date:   Fri, 31 Mar 2023 15:53:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH bpf-next v2 0/5] bpftool: Add inline annotations when
 dumping program CFGs
Content-Language: en-GB
To:     Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
References: <20230327110655.58363-1-quentin@isovalent.com>
 <cdd67fd11f71210b75e48a848ade42f545cddf8f.camel@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <cdd67fd11f71210b75e48a848ade42f545cddf8f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-03-27 20:56 UTC+0300 ~ Eduard Zingerman <eddyz87@gmail.com>
> On Mon, 2023-03-27 at 12:06 +0100, Quentin Monnet wrote:
>> This set contains some improvements for bpftool's "visual" program dump
>> option, which produces the control flow graph in a DOT format. The main
>> objective is to add support for inline annotations on such graphs, so that
>> we can have the C source code for the program showing up alongside the
>> instructions, when available. The last commits also make it possible to
>> display the line numbers or the bare opcodes in the graph, as supported by
>> regular program dumps.
>>
>> v2: Replace fputc(..., stdout) with putchar(...) in dotlabel_puts().
> 
> Hi Quentin,
> 
> It looks like currently there are no test cases for bpftool prog dump.
> Borrowing an idea to mix bpf program with comments parsed by awk from
> prog_tests/btf_dump.c it is possible to put together something like
> below (although, would be much simpler as a bash script). Is it worth
> the effort or dump format is too unstable?
> 
> Thanks,
> Eduard

Correct, I don't think we have tests for that at the moment.

But yes, I would love to get a test like this (and more bpftool tests in
general, when I can find cycles). I don't mind a bash script,
personally; your bpftool_cfg.c is mostly a succession of commands, and
the other tests we have for bpftool are in bash or Python anyway
(test_bpftool*). We could use bpftool to load the program (I suppose
it's debatable whether it's good to use bpftool itself to set up a test
for bpftool; on the other hand, it's heavily based on libbpf, so using
libbpf directly doesn't seem to make that much of a difference).

As for the stability of the output, generally the produced BPF bytecode
is obviously subject to change, but for a program so simple as "return
0;" we should be mostly good. Just make sure you specify the ISA version
when you compile the program, with < v3 we would load 64 bits instead of
32 in the first instruction. On bpftool's side, I don't expect the CFG
output to change much, so no problem.

Thanks a lot for your review, and for working on this test!

I'll send a v3, probably sometime next week.
Quentin

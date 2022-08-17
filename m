Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06607596CA1
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 12:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiHQKOZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 06:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHQKOY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 06:14:24 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EF554CB2
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 03:14:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so719399wmc.1
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 03:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Qrd/MV/xHUqE3tF3rv+dOOaUTXhognEqdhY1tOfKxhg=;
        b=LuzNoFhi9rmYaxtwfsT82ojtXkCB/8hjxrH4b1jPrSaLajyYdH+4iFkBgc92HnKMZr
         U4nTI9zn4Jy5/TT0X4erfaPZJVN+kjew7h9v0zQwNVrAElu2uEzqidLJxdNEWGNYuB+I
         Bdv4gabDGamSUDnUWSxANFp1bbX0qycQ3qGrB0grBSu3O3EgL1NB2V1YbRIzY9StREYr
         qR0AWgfjGG1cH5tB3Mt03+fyv6Ce+C0IlPi6iYMpXFOJseFY3aF4A97V6ylytgYDH8a6
         wADTvMKr55k73YrTR605MMBL1hiVq6KiiMB2ku2B08JKir/BfczkEXuG5aDDeCoCpPnc
         Mitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Qrd/MV/xHUqE3tF3rv+dOOaUTXhognEqdhY1tOfKxhg=;
        b=HoRMSiPPGM2CkfNtQv4W9FsbvNL20ky86Mtb1+JRXEECldvfwLFvgAEBdSorDoCNRs
         lKDIjfRMz2h07KFAUf0n+N1UYzXCSLjD0efQey5WB7TAhjCzDRvwwEnX360iAY8uw6i4
         fuFHqEDbiTtHe8vBDYWMcxcgTH0KWQ4KIIV1BWY72UUkdDplzunFyPxYY5QHSnoCB9tP
         +MYbRLFS66DipAa7FPamZcTwJ9t4E9WA3QkugqZV1Jb/Zj4ZICbUmFTdzhxuOkU5p5Ue
         SIQYcSnHD/xPWgVPIhUzE3abm3ZyKaNmY4pTGxOCrQiX3nRAELMySuJl/tszAtNSSTtn
         XwVA==
X-Gm-Message-State: ACgBeo0qszSuZOVXpoe8oHPykBEzRTxM00H+17p5H24wY3snrwfp0f4l
        /yknCRA5xyWmFjjg7RyVgDA4ag==
X-Google-Smtp-Source: AA6agR4Jl0Rr0g1vsd4ij7IujDd51DgHjIqkyYER27SA7yaRl1xLjXskFhcoi7W9NzyRnCkZjo/Fjg==
X-Received: by 2002:a05:600c:1d26:b0:3a5:d146:6f07 with SMTP id l38-20020a05600c1d2600b003a5d1466f07mr1676377wms.202.1660731262435;
        Wed, 17 Aug 2022 03:14:22 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id v8-20020adff688000000b0022528d3e071sm353831wrp.84.2022.08.17.03.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 03:14:22 -0700 (PDT)
Message-ID: <2ee546ac-cd2d-8418-1a54-7c799b626fa2@isovalent.com>
Date:   Wed, 17 Aug 2022 11:14:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next] bpftool: Add trace subcommand
Content-Language: en-GB
To:     Wei Yongjun <weiyongjun1@huawei.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20220816151725.153343-1-weiyongjun1@huawei.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220816151725.153343-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 16/08/2022 16:17, Wei Yongjun wrote:
> Currently, only one command is supported
>   bpftool trace pin <bpf_prog.o> <path>
> 
> It will pin the trace bpf program in the object file <bpf_prog.o>
> to the <path> where <path> should be on a bpffs mount.
> 
> For example,
>   $ bpftool trace pin ./mtd_mchp23k256.o /sys/fs/bpf/mchp23k256
> 
> The implementation a BPF based backend for mockup mchp23k256 mtd
> SPI device.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks a lot for the patch.

However, I don't think it's a good idea to add the new "trace" command
just for loading/attaching/pinning tracepoints programs. Instead I see
two possible approaches.

The first would be to extend support for program attachment. Bpftool is
already able to load programs including tracepoints via "bpftool prog
load", and it is able to attach some of them via "bpftool
prog/net/cgroup attach". We don't support attaching tracing-related
programs because at the time, BPF links didn't exist so we couldn't keep
the programs running after bpftool exited, and after links were created
nobody implemented it.

So I would prefer that we extend this, by making bpftool able to attach
(and pin the link for) tracing-related programs. Not necessarily just
tracepoints by the way, it would be nice to have support for kprobes
too. This could be by extending "bpftool prog attach" or creating
"bpftool perf attach" ("bpftool perf" already focuses on tracing
programs, so no need to add a new "trace" subcommand).

Second approach: I realise that the above adds a constraint, because if
we attach a program that was already loaded, we can't get the attach
point from the section name in the ELF file, we need to pass it on the
command line instead. I understand the desire for a one-step
load-attach-pin_link, but with your new subcommand it would ignore all
the work we've done on "bpftool prog load": support loading multiple
programs from an ELF file, for reusing or pinning the maps, etc. So I
would rather extend the existing "bpftool prog load(_all)" with a new
keyword to tell bpftool to attach and create the link(s), if possible
(when all relevant info for attaching is present in the ELF file), after
loading the program(s).

I'd really have the first approach in bpftool at some point, I haven't
found the time to look into it just yet. The second one is probably
closer to what you're looking to achieve, and would be nice to have as
well. What do you think?

Thanks,
Quentin

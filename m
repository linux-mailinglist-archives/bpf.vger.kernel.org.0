Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF3F6CB517
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 05:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjC1Dsv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 23:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjC1Dsk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 23:48:40 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FEE1721
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 20:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=udoYHX47BgHSQOxnmeb4YYo125F42vKks2vtpqe2oc0=; b=cvaunPKF75eMvvm/oxqTGvKcgf
        WbKlNFGdmIX8o5O0rNuRJeDXbhkuUeB5IwvVdS7ZgDomw+mef8UbWyscE/Lkzaj+L24YXZexj6eHt
        6EXwN7XdXivN3VdDlBjD61/w3qEHCov1nwxezW+UvP8vpAiYgtRzuE9Tyk5q745/2V7tznJBltOe1
        TuHIo8jvSOrjfCfCA+/q8wYBVa7GxSgfoQoHyqasUMPJJ4rG7TNHiQxOiA67dLpg/Y9lOL3ib28fr
        U4Zo3fdHHjP+GJF6qe9Gn6/fT8jF18YkDooVrq3c9H1X1ZzjBwMZD2CAmEf6wtyncXmwv1Uuq5n9E
        0L+RjVhA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1ph0K1-000Gs1-7j; Tue, 28 Mar 2023 05:48:33 +0200
Received: from [219.59.88.22] (helo=localhost.localdomain)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ph0K0-000EBX-N5; Tue, 28 Mar 2023 05:48:33 +0200
Subject: Re: [PATCH bpf-next 00/43] First set of verifier/*.c migrated to
 inline assembly
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
References: <20230325025524.144043-1-eddyz87@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <359ea18b-5996-afea-b81e-32f13f134852@iogearbox.net>
Date:   Tue, 28 Mar 2023 05:48:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230325025524.144043-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26856/Mon Mar 27 09:24:05 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Eduard,

On 3/25/23 3:54 AM, Eduard Zingerman wrote:
> This is a follow up for RFC [1]. It migrates a first batch of 38
> verifier/*.c tests to inline assembly and use of ./test_progs for
> actual execution. The migration is done by a python script (see [2]).
> 
> Each migrated verifier/xxx.c file is mapped to progs/verifier_xxx.c
> plus an entry in the prog_tests/verifier.c. One patch per each file.
> 
> A few patches at the beginning of the patch-set extend test_loader
> with necessary functionality, mainly:
> - support for tests execution in unprivileged mode;
> - support for test runs for test programs.
> 
> Migrated tests could be selected for execution using the following filter:
> 
>    ./test_progs -a verifier_*
>    
> An example of the migrated test:
> 
>    SEC("xdp")
>    __description("XDP pkt read, pkt_data' > pkt_end, corner case, good access")
>    __success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
>    __naked void end_corner_case_good_access_1(void)
>    {
>            asm volatile ("                                 \
>            r2 = *(u32*)(r1 + %[xdp_md_data]);              \
>            r3 = *(u32*)(r1 + %[xdp_md_data_end]);          \
>            r1 = r2;                                        \
>            r1 += 8;                                        \
>            if r1 > r3 goto l0_%=;                          \
>            r0 = *(u64*)(r1 - 8);                           \
>    l0_%=:  r0 = 0;                                         \
>            exit;                                           \
>    "       :
>            : __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
>              __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
>            : __clobber_all);
>    }
> 
> Changes compared to RFC:
> - test_loader.c is extended to support test program runs;
> - capabilities handling now matches behavior of test_verifier;
> - BPF_ST_MEM instructions are automatically replaced by BPF_STX_MEM
>    instructions to overcome current clang limitations;
> - tests styling updates according to RFC feedback;
> - 38 migrated files are included instead of 1.
> 
> I used the following means for testing:
> - migration tool itself has a set of self-tests;
> - migrated tests are passing;
> - manually compared each old/new file side-by-side.
> 
> While doing side-by-side comparison I've noted a few defects in the
> original tests:
> - and.c:
>    - One of the jump targets is off by one;
>    - BPF_ST_MEM wrong OFF/IMM ordering;
> - array_access.c:
>    - BPF_ST_MEM wrong OFF/IMM ordering;
> - value_or_null.c:
>    - BPF_ST_MEM wrong OFF/IMM ordering.
> 
> These defects would be addressed separately.

The cover letter describes what this series does, but not /why/ we need it. Would be
useful in future to also have the rationale in here. The migration of the verifier
tests look ok, and probably simplifies things to some degree, it certainly makes the
tests more readable. Is the goal to eventually get rid of test_verifier altogether?
I don't think we fully can do that, e.g. what about verifier testing of invalid insn
encodings or things like invalid jumps into the middle of double insns, invalid call
offsets, etc?

> [1] RFC
>      https://lore.kernel.org/bpf/20230123145148.2791939-1-eddyz87@gmail.com/
> [2] Migration tool
>      https://github.com/eddyz87/verifier-tests-migrator

Thanks,
Daniel

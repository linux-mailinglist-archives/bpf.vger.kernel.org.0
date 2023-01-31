Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D3A6836DB
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 20:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjAaTwK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 14:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjAaTwJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 14:52:09 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621B5166C1
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 11:52:08 -0800 (PST)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pMwfh-000EHe-7w; Tue, 31 Jan 2023 20:52:01 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pMwfg-000CRx-T5; Tue, 31 Jan 2023 20:52:00 +0100
Subject: Re: [Lsf-pc] LSF/MM/BPF activity proposal: Compiled BPF
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        lsf-pc@lists.linuxfoundation.org
Cc:     ndesaulniers@google.com, david.faust@oracle.com,
        elena.zannoni@oracle.com,
        James Hilliard <james.hilliard1@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <87edrbhq3k.fsf@oracle.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cb0532ae-3500-6caf-7e84-c9ed0763c49d@iogearbox.net>
Date:   Tue, 31 Jan 2023 20:52:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87edrbhq3k.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26798/Tue Jan 31 09:21:25 2023)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/30/23 6:47 PM, Jose E. Marchesi wrote:
> 
> Hello.
> 
> We would like to suggest to the LSF/MM/BPF organization to have a
> working session on "compiled BPF", i.e. on the part of BPF that involves
> compilers and linkers.  This mainly involves the two mainstream
> compilers that target BPF: clang and GCC, but other BPF toolchains are
> slowly appearing (like the Rust compiler) and that makes it even more
> important to consolidate compiled BPF.
> 
> Examples of topics to cover are the covergence of the support in both
> clang/llvm and GCC, several aspects of the ABI that need to be
> discussed/clarified/decided in order to avoid undefined compiler
> behavior and divergences, issues related to the BPF standarization, and
> suggestions on how to lift some of the existing limitations impacting
> BPF C programs.
> 
> The goal is to reach agreements about particular things, document the
> agreements, stick to them, and a clear plan to implement whatever is
> needed in the respective compilers/tools.
> 
> Potential participants in case the activity takes place:
> 
> - Both David Faust (GNU toolchain, BPF port hacker) and myself (GNU
>    toolchain, BPF port maintainer) are willing to attend the event,
>    prepare discussion material, organize and participate in the
>    discussions.
> 
> - Nick Desaulniers (LLVM maintainer) is also interested in attending and
>    participating, provided other compromises he has in May don't get in
>    the way.

Plus Yonghong Song with regards to LLVM BPF backend.

> - More? (Please add yourself to this list by replying to this email in
>    case you are interested.)
> 
> Would the BPF community and the LSF/MM/BPF organization be interested in
> having such an activity?

Yes, we can definitely add this to the agenda for the BPF track. This sounds
very reasonable to me!

Thanks Jose!

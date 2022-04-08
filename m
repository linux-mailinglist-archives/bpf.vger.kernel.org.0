Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36734F9F39
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 23:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiDHVft (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 17:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiDHVfs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 17:35:48 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EC52709
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 14:33:43 -0700 (PDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1ncwEf-0000X0-QG; Fri, 08 Apr 2022 23:33:41 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ncwEf-0004cc-Kw; Fri, 08 Apr 2022 23:33:41 +0200
Subject: Re: [PATCH bpf-next v3 0/5] Attach a cookie to a tracing program.
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, kernel-team@fb.com
References: <20220407192552.2343076-1-kuifeng@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <283a6823-0f19-4f91-a111-752590776b7c@iogearbox.net>
Date:   Fri, 8 Apr 2022 23:33:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220407192552.2343076-1-kuifeng@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26506/Fri Apr  8 10:23:48 2022)
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/7/22 9:25 PM, Kui-Feng Lee wrote:
> Allow users to attach a 64-bits cookie to a bpf_link of fentry, fexit,
> or fmod_ret.
> 
> This patchset includes several major changes.
> 
>   - Define struct bpf_tramp_links to replace bpf_tramp_prog.
>     struct bpf_tramp_links collects bpf_links of a trampoline
> 
>   - Generate a trampoline to call bpf_progs of given bpf_links.
> 
>   - Trampolines always set/reset bpf_run_ctx before/after
>     calling/leaving a tracing program.
> 
>   - Attach a cookie to a bpf_link of fentry/fexit/fmod_ret.  The value
>     will be available when running the associated bpf_prog.
> 
> The major differences from v2:
> 
>   - Move the allocations of run_ctx (struct bpf_tramp_run_ctx) out of
>     invoke_bpf_prog().
> 
>   - Move hlist_node out of bpf_link and introduce struct bpf_tramp_link
>     to own hlist_node.
> 
>   - Store cookies at struct bpf_tracing_link.
> 
>   - Use SIB byte to reduce the number of instructions to set cookie
>     values. (Use RSP directly)
> 
> v1: https://lore.kernel.org/all/20220126214809.3868787-1-kuifeng@fb.com/
> v2: https://lore.kernel.org/bpf/20220316004231.1103318-1-kuifeng@fb.com/

Kui-Feng, would be great if you have a chance to rebase, so that the set can
also go through BPF CI.

Thanks a lot,
Daniel

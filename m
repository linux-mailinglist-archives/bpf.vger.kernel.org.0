Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C36D6789DA
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 22:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjAWVpU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 16:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjAWVpU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 16:45:20 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA16A359A
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 13:45:18 -0800 (PST)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pK4cu-000ONs-J8; Mon, 23 Jan 2023 22:45:17 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pK4cu-000EFZ-CC; Mon, 23 Jan 2023 22:45:16 +0100
Subject: Re: [PATCH] bpf, docs: Fix modulo zero, division by zero, overflow,
 and underflow
To:     dthaler1968@googlemail.com, bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
References: <CAADnVQLZd1u_wJUC2ViRcEPveRcGaAnOsjbPiZ8bPZcwV1p=gw@mail.gmail.com>
 <20230120201634.1588-1-dthaler1968@googlemail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8f1b6f37-c46c-f493-d02c-6777049f91af@iogearbox.net>
Date:   Mon, 23 Jan 2023 22:45:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230120201634.1588-1-dthaler1968@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26790/Mon Jan 23 09:31:32 2023)
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/20/23 9:16 PM, dthaler1968@googlemail.com wrote:
[...]
> -BPF_MOD   0x90   dst %= src
> +BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst   
[...]
> +If execution would result in modulo by zero,
> +the destination register is instead set to the source register
> +as ``BPF_MOV`` would do, meaning that for ``BPF_ALU64`` the value
> +is unchanged whereas for ``BPF_ALU`` the upper 32 bits are zeroed.

I think the "the destination register is instead set to the source register
as ``BPF_MOV`` would do" is a bit ambiguous. Could we just simplify it to the
following:

If execution would result in modulo by zero, for ``BPF_ALU64`` the value of
the destination register is unchanged whereas for ``BPF_ALU`` the upper 32 bits
of the destination register are zeroed.

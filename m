Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704E1629F11
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 17:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiKOQa1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 11:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKOQa0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 11:30:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CCFAE7C
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:30:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B7B5618F6
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 16:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7864DC433D6;
        Tue, 15 Nov 2022 16:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668529824;
        bh=BAgRUrUssox6LzPjirOLhvVxlnZvIE0RwnL9kWqvCGs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hMT+58Lu1tCWrd2vdV62FKt/x8Z2QuDXdi/IudRd3QdogXy5vDKAotmxFZhZBKa82
         O1vChm82eYoBUc319gkmCVglG1+ZI0Ic/m2fAqACwUMjYBal19gP3Xxo3I05Jmt7Ak
         rKBC3vc5svu15K2nHxeJCefWuYo71yHvtBE6fRizhYZ0X6OQf2UiOhQ1suVVDIEfil
         hWmQ+AHZ+lweW85MY6EK4W24jeEZgY62HE0PMDTdfsbtL7mPrqhla0uvTTUxZrxmkD
         Qjzhyft7mU5tvZdXH7cRhtqGai4t6iDBqAClNuAILvqItqTGBL4E2XKDInLPnNdSJY
         jG0BRrDXnrl/A==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D3ABB7A6CE3; Tue, 15 Nov 2022 17:30:20 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Implement bpf_get_kern_btf_id()
 kfunc
In-Reply-To: <20221114162328.622665-1-yhs@fb.com>
References: <20221114162328.622665-1-yhs@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 15 Nov 2022 17:30:20 +0100
Message-ID: <87edu4i3j7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> writes:

> Currenty, a non-tracing bpf program typically has a single 'context' argument
> with predefined uapi struct type. Following these uapi struct, user is able
> to access other fields defined in uapi header. Inside the kernel, the
> user-seen 'context' argument is replaced with 'kernel context' (or 'kcontext'
> in short) which can access more information than what uapi header provides.
> To access other info not in uapi header, people typically do two things:
>   (1). extend uapi to access more fields rooted from 'context'.
>   (2). use bpf_probe_read_kernl() helper to read particular field based on
>     kcontext.
> Using (1) needs uapi change and using (2) makes code more complex since
> direct memory access is not allowed.
>
> There are already a few instances trying to access more information from
> kcontext:
>   (1). trying to access some fields from perf_event kcontext.
>   (2). trying to access some fields from xdp kcontext.
>
> This patch set tried to allow direct memory access for kcontext fields
> by introducing bpf_get_kern_btf_id() kfunc.

I think the general idea is neat. However, I'm a bit concerned that with
this we're allowing networking BPF programs (like XDP) to walk more or
less arbitrary kernel structures, which has thus far been something only
tracing programs have had access to. So we probably require programs to
have CAP_PERFMON to use this kfunc, no?

-Toke

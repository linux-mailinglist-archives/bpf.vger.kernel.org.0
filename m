Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268F665BFDE
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 13:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbjACM2f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 07:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbjACM2I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 07:28:08 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97BAB7E8
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 04:28:07 -0800 (PST)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pCgOj-000IuX-NK; Tue, 03 Jan 2023 13:28:05 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pCgOj-000TAG-H0; Tue, 03 Jan 2023 13:28:05 +0100
Subject: Re: [PATCH bpf-next] libbpf: Add LoongArch support to bpf_tracing.h
To:     Huacai Chen <chenhuacai@kernel.org>,
        Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev, andrii@kernel.org
References: <20221231100757.3177034-1-hengqi.chen@gmail.com>
 <CAAhV-H6hdXXE4EwFe66rUxJMixc=s7PYuxeyCjaQ5z3Fck40jA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9d2d3268-6558-2387-7d26-0fc51c365204@iogearbox.net>
Date:   Tue, 3 Jan 2023 13:28:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6hdXXE4EwFe66rUxJMixc=s7PYuxeyCjaQ5z3Fck40jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26770/Tue Jan  3 09:59:01 2023)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/3/23 7:53 AM, Huacai Chen wrote:
> LGTM, I will queue this patch for loongarch-next if no one has
> objections. Thank you.

To avoid potential merge conflicts for the next dev cycle, any objections if
you could Ack it and we'd take it via bpf-next tree instead?

Thanks,
Daniel

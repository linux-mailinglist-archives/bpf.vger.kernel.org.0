Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1838A4B2838
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 15:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiBKOsg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 09:48:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiBKOsf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 09:48:35 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F6EFE
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 06:48:34 -0800 (PST)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nIXDs-0006jK-Hk; Fri, 11 Feb 2022 15:48:32 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nIXDs-000P2b-AA; Fri, 11 Feb 2022 15:48:32 +0100
Subject: Re: [PATCH bpf 2/2] bpf: emit bpf_timer in vmlinux BTF
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20220211073903.3455193-1-yhs@fb.com>
 <20220211073913.3455777-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0d21a6bb-c8d0-840c-faba-365e0fc298e8@iogearbox.net>
Date:   Fri, 11 Feb 2022 15:48:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220211073913.3455777-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26450/Fri Feb 11 10:24:09 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/11/22 8:39 AM, Yonghong Song wrote:
> Previously, the following code in check_and_init_map_value()
>    *(struct bpf_timer *)(dst + map->timer_off) =
>        (struct bpf_timer){};
> can help generate bpf_timer definition in vmlinuxBTF.
> But previous patch replaced the above code with memset
> so bpf_timer definition disappears from vmlinuxBTF.
> Let us emit the type explicitly so bpf program can continue
> to use it from vmlinux.h.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>

Needs at minimum rebase for the bpf tree as target, see also:

   https://github.com/kernel-patches/bpf/pull/2549

Thanks,
Daniel

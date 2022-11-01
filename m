Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F91C614F28
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 17:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiKAQ1j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 12:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAQ1i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 12:27:38 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F541A213;
        Tue,  1 Nov 2022 09:27:35 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1optic-000Ate-8J; Tue, 01 Nov 2022 17:02:26 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1optib-0007FE-U4; Tue, 01 Nov 2022 17:02:25 +0100
Subject: Re: [PATCH] bpftool: Support use full prog name in prog subcommand
To:     Tao Chen <chentao.kernel@linux.alibaba.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c26d1dde6d1665a9195b054e5fd209a32c94e490.1667313454.git.chentao.kernel@linux.alibaba.com>
 <c26d1dde6d1665a9195b054e5fd209a32c94e490.1667313454.git.chentao.kernel@linux.alibaba.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7e775aff-a4d3-f1b0-ea55-06a30097348c@iogearbox.net>
Date:   Tue, 1 Nov 2022 17:02:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c26d1dde6d1665a9195b054e5fd209a32c94e490.1667313454.git.chentao.kernel@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26706/Tue Nov  1 08:52:34 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/1/22 3:38 PM, Tao Chen wrote:
> Now that the commit: <b662000aff84> ("bpftool: Adding support for BTF
> program names") supported show the full prog name, we can also use
> the full prog name more than 16 (BPF_OBJ_NAME_LEN) chars in prog
> subcommand, such as "bpftool prog show name PROG_NAME".
> 
> Signed-off-by: Tao Chen <chentao.kernel@linux.alibaba.com>

Please rebase against bpf-next, this does not apply cleanly.

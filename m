Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA39161576D
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 03:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiKBCQ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 22:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKBCQ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 22:16:27 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC046302;
        Tue,  1 Nov 2022 19:16:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=chentao.kernel@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VTlSXDO_1667355382;
Received: from 30.43.40.25(mailfrom:chentao.kernel@linux.alibaba.com fp:SMTPD_---0VTlSXDO_1667355382)
          by smtp.aliyun-inc.com;
          Wed, 02 Nov 2022 10:16:23 +0800
Message-ID: <5e3e3ba1-08b2-9f03-1f31-f4852620e34d@linux.alibaba.com>
Date:   Wed, 2 Nov 2022 10:16:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH] bpftool: Support use full prog name in prog subcommand
To:     Daniel Borkmann <daniel@iogearbox.net>,
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
 <7e775aff-a4d3-f1b0-ea55-06a30097348c@iogearbox.net>
From:   Tao Chen <chentao.kernel@linux.alibaba.com>
In-Reply-To: <7e775aff-a4d3-f1b0-ea55-06a30097348c@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

在 2022/11/2 上午12:02, Daniel Borkmann 写道:
> On 11/1/22 3:38 PM, Tao Chen wrote:
>> Now that the commit: <b662000aff84> ("bpftool: Adding support for BTF
>> program names") supported show the full prog name, we can also use
>> the full prog name more than 16 (BPF_OBJ_NAME_LEN) chars in prog
>> subcommand, such as "bpftool prog show name PROG_NAME".
>>
>> Signed-off-by: Tao Chen <chentao.kernel@linux.alibaba.com>
> 
> Please rebase against bpf-next, this does not apply cleanly.
Ok, i will resend it, thank you!

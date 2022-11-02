Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8726F616327
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 13:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiKBMze (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 08:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiKBMzd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 08:55:33 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AD127CFE;
        Wed,  2 Nov 2022 05:55:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=chentao.kernel@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VToH.zb_1667393727;
Received: from 30.37.19.41(mailfrom:chentao.kernel@linux.alibaba.com fp:SMTPD_---0VToH.zb_1667393727)
          by smtp.aliyun-inc.com;
          Wed, 02 Nov 2022 20:55:28 +0800
Message-ID: <1f124efa-ac5b-5a50-2efe-243f4405a314@linux.alibaba.com>
Date:   Wed, 2 Nov 2022 20:55:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [RESEND PATCH] bpftool: Support use full prog name in prog
 subcommand
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2851b8859666a02878bc897d6c2fb51c80cadce8.1667356049.git.chentao.kernel@linux.alibaba.com>
 <6927ffa1-e7f5-6691-dc86-da6c0d628c4f@isovalent.com>
From:   Tao Chen <chentao.kernel@linux.alibaba.com>
In-Reply-To: <6927ffa1-e7f5-6691-dc86-da6c0d628c4f@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

在 2022/11/2 下午7:56, Quentin Monnet 写道:
> 2022-11-02 10:35 UTC+0800 ~ Tao Chen <chentao.kernel@linux.alibaba.com>
>> Now that the commit: <b662000aff84> ("bpftool: Adding support for BTF
>> program names") supported show the full prog name, we can also use
>> the full prog name more than 16 (BPF_OBJ_NAME_LEN) chars in prog
>> subcommand, such as "bpftool prog show name PROG_NAME".
>>
>> Signed-off-by: Tao Chen <chentao.kernel@linux.alibaba.com>
> 
> Thanks! But you mean you want something like this, correct?
> 
> 	# ./bpftool prog pin \
> 		name prog_with_a_very_long_name /sys/fs/bpf/foo
> 
> This is already possible since commit d55dfe587bc0 ("bpftool: Remove
> BPF_OBJ_NAME_LEN restriction when looking up bpf program by name"). Your
> first version of the patch was based on a version that didn't have this
> commit, but bpftool from bpf-next already supports this.
> 
> Quentin
Yes, sorry my branch is a little behind，please ignore this patch, thank 
you for your reply!

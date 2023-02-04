Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0775368A885
	for <lists+bpf@lfdr.de>; Sat,  4 Feb 2023 07:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjBDGGn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Feb 2023 01:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBDGGm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Feb 2023 01:06:42 -0500
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20985D92C
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 22:06:41 -0800 (PST)
Message-ID: <4da7e8dc-25cf-1c4a-bac0-1965df74b645@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675490799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cu5Wz0uoepKW11ULQP5ZT7Q5lxy/8AHtK4afKm071yA=;
        b=J90adppd24nW1A3eHsYRuwk4kNxEerppNyQ4fSpLQ5bwiasDqUI6XA/vQLpaDfPcXedosa
        Wri7GRvl1ftokXLNF7HjsgzqTqLDpzo95vagGobWxz0TCgtSBF4HiTnf4M1Osq8v9uNrE+
        fxkryNuthdzAhv7Q5meYgH1e3GK7Dio=
Date:   Fri, 3 Feb 2023 22:06:29 -0800
MIME-Version: 1.0
Subject: Re: [bpf-next v1] bpf: introduce stats update helper
Content-Language: en-US
To:     tong@infragraf.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>, bpf@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>
References: <20230203133220.48919-1-tong@infragraf.org>
 <63ddd56327756_6bb1520881@john.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <63ddd56327756_6bb1520881@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/3/23 7:47 PM, John Fastabend wrote:
> tong@ wrote:
>> From: Tonghao Zhang <tong@infragraf.org>
>>
>> This patch introduce a stats update helper to simplify codes.
>>
>> Signed-off-by: Tonghao Zhang <tong@infragraf.org>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Andrii Nakryiko <andrii@kernel.org>
>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>> Cc: Song Liu <song@kernel.org>
>> Cc: Yonghong Song <yhs@fb.com>
>> Cc: John Fastabend <john.fastabend@gmail.com>
>> Cc: KP Singh <kpsingh@kernel.org>
>> Cc: Stanislav Fomichev <sdf@google.com>
>> Cc: Hao Luo <haoluo@google.com>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Hou Tao <houtao1@huawei.com>
>> ---
>>   include/linux/filter.h  | 22 +++++++++++++++-------
>>   kernel/bpf/trampoline.c | 10 +---------
>>   2 files changed, 16 insertions(+), 16 deletions(-)
> 
> Seems fine but I'm not sure it makes much difference.

I also don't think it is needed. There are only two places. Also, it is not 
encouraged to collect more stats. Refactoring it is not going to help in the future.


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B656637E5
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 04:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjAJDoU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 22:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjAJDoS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 22:44:18 -0500
Received: from out-146.mta0.migadu.com (out-146.mta0.migadu.com [91.218.175.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E601EEE1
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 19:44:17 -0800 (PST)
Message-ID: <7a476ec6-9bd0-beec-00ff-e8cd0121ce57@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673322256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XadTJY4of2M6MLVPR0KC+JPokPjO4xpBN+kyvzgjFQk=;
        b=TCYiY2TG6x/jFJWWp9mWRkNrbjaYeAlOGaFaTKrQ9d2UVjg5xRCnXirk8MsD1hOQMc79Pw
        Q3ntXL7ZSfV59OsnzjMugALPa1ji/ZLmKsHbKZxEpUiN2VKevmp413NdouYIC6TusnpJDi
        ZTngdT/62eI2AvXZ4AW58agKI7bgAmw=
Date:   Mon, 9 Jan 2023 19:44:11 -0800
MIME-Version: 1.0
Subject: Re: [bpf-next v4 2/2] selftests/bpf: add test case for htab map
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     Tonghao Zhang <tong@infragraf.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>, bpf@vger.kernel.org,
        Manu Bretelle <chantra@meta.com>
References: <20230105092637.35069-1-tong@infragraf.org>
 <20230105092637.35069-2-tong@infragraf.org>
 <6bd49922-9d38-3bf9-47e8-3208adfd2f31@linux.dev>
 <AE6C6A22-4411-4109-93DD-164FA53DCBE0@infragraf.org>
 <85737292-efbf-636c-99f1-39569cd215c8@linux.dev>
In-Reply-To: <85737292-efbf-636c-99f1-39569cd215c8@linux.dev>
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

On 1/9/23 7:25 PM, Martin KaFai Lau wrote:
>>>
>>> btw, from a quick look at __perf_event_overflow, I suspect doing the 
>>> bpf_map_update_elem() here instead of the fentry/perf_event_overflow above 
>>> can also reproduce the patch 1 issue?
>> No
>> bpf_overflow_handler will check the bpf_prog_active, if syscall increase it, 
>> bpf_overflow_handler will skip the bpf prog.
> 
> tbh, I am quite surprised the bpf_prog_active would be noisy enough to avoid 
> this deadlock being reproduced easily. fwiw, I just tried doing map_update here 
> and can reproduce it in the very first run.
Correcting my self. I only reproduced the warning splat but not the deadlock. 
This test is using map_update from the syscall that bumps the prog_active.

Agree that SEC("perf_event") alone won't work unless the bpf_map_update_elem() 
is not done from the syscall in prog_tests/htab_deadlock.c, eg. from another bpf 
prog.

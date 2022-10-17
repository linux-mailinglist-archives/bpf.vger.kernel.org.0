Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BEF601C57
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 00:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJQW1P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 18:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJQW1M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 18:27:12 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A11D81107
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 15:26:50 -0700 (PDT)
Message-ID: <0e95e931-b30a-24a6-78bf-c73402a470b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666045605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3cNjmv9DiHj3oHEqiFdpY7VDD2GV2xZF5mOA9idFV4=;
        b=Q6qDQY7rhOg1VU2nHDsykPEAJfdN/LnHVHd2APuo+Jf1ZJm+J24SBw6pkyWf6qwL/G1nhZ
        6N237Fz1A6Ng85vHQ+MrnHFJ6fkatMtvOOpBeAkxkAzIhxjEToeb4oBKP9VABoWj2YOYPV
        bbem7N9q+x36iNb+QEJTyuxeEiP/x+4=
Date:   Mon, 17 Oct 2022 15:26:41 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
Content-Language: en-US
To:     sdf@google.com
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, Yonghong Song <yhs@fb.com>
References: <20221014045619.3309899-1-yhs@fb.com>
 <20221014045630.3311951-1-yhs@fb.com> <Y02Yk8gUgVDuZR4Q@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <Y02Yk8gUgVDuZR4Q@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/17/22 11:01 AM, sdf@google.com wrote:
>> +static bool bpf_cgroup_storage_trylock(void)
>> +{
>> +    migrate_disable();
>> +    if (unlikely(this_cpu_inc_return(bpf_cgroup_storage_busy) != 1)) {
>> +        this_cpu_dec(bpf_cgroup_storage_busy);
>> +        migrate_enable();
>> +        return false;
>> +    }
>> +    return true;
>> +}
> 
> Task storage has lock/unlock/trylock; inode storage doesn't; why does
> cgroup need it as well?

This was added in bc235cdb423a2 to avoid deadlock for tracing program which can 
get a hold to the same task ptr easily with bpf_get_current_task_btf().  I 
believe there was no known way to hit this problem in inode storage, so inode 
storage does not use it.

The common tracing use case to get a hold of the cgroup ptr is through task 
(including bpf_get_current_task_btf()), so it seems to make sense to mimic the 
trylock here.  I have plan to relax it for all non-tracing programs like 
cgroup-bpf and bpf-lsm.

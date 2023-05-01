Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA056F3661
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 20:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjEAS6h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 14:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjEAS6g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 14:58:36 -0400
Received: from out-33.mta0.migadu.com (out-33.mta0.migadu.com [91.218.175.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCF1E65
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 11:58:34 -0700 (PDT)
Message-ID: <07b89cc9-badf-4803-2d43-cfc3e4ff883d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682967513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IcOUzlwL/kZNQ94niW48x/ByHz8uqN6QG4wkxvAVQOc=;
        b=auiGEbKjQaCowgsjYxS1PfWMBgIY0Ze0bGymMAGc2x1tKGKMpTiXCLn+4Qmx/NRt4qCwEW
        o4Cm94qKYmVkPVQeMoLe4zz6lwtopgny/sI3GJ4g89k6AHS8tTyZwkh9NDiv4RX0MmTPSp
        XfoEkAdHFrriIa8hlpnsFSe1dsHSnbE=
Date:   Mon, 1 May 2023 11:58:28 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Don't EFAULT for {g,s}setsockopt
 with wrong optlen
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20230427200409.1785263-1-sdf@google.com>
 <20230427200409.1785263-2-sdf@google.com>
 <5ebd6775-2be4-76b3-d364-a4462663e32d@linux.dev>
 <CAKH8qBv_CdoKy07_y5Umcxq_-K7_hcLj4jxaMmezhVnLviDgCg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAKH8qBv_CdoKy07_y5Umcxq_-K7_hcLj4jxaMmezhVnLviDgCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/1/23 9:55 AM, Stanislav Fomichev wrote:
> On Sun, Apr 30, 2023 at 10:52 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 4/27/23 1:04 PM, Stanislav Fomichev wrote:
>>> @@ -1881,8 +1886,10 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>>>                .optname = optname,
>>>                .current_task = current,
>>>        };
>>> +     int orig_optlen;
>>>        int ret;
>>>
>>> +     orig_optlen = max_optlen;
>>
>> For getsockopt, when the kernel's getsockopt finished successfully (the
>> following 'if (!retval)' case), how about also setting orig_optlen to the kernel
>> returned 'optlen'. For example, the user's orig_optlen is 8096 and the kernel
>> returned optlen is 1024. If the bpf prog still sets the ctx.optlen to something
>>   > PAGE_SIZE, -EFAULT will be returned.
> 
> Wouldn't it defeat the purpose? Or am I missing something?
> 
> ctx.optlen would still be 8096, not 1024, right (regardless of what
> the kernel returns)?
> So it would trigger EFAULT case which we try to avoid.

My understanding is the ctx.optlen should be 1024 after the 'if (!retval)' 
statement.

The 'int __user *optlen' arg has the kernel returned optlen (1024). The 'int 
max_optlen' arg has the original user's optlen (8096).

int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
				       int optname, char __user *optval,
				       int __user *optlen /* 1024 */,
				       int max_optlen /* 8096 */,
				       int retval)
{
	/* ... */

	orig_optlen = max_optlen; /* orig_optlen == 8096 */
	ctx.optlen = max_optlen;  /* ctx.optlen == 8096 */

	
	if (!retval) {
		/* If kernel getsockopt finished successfully,
		 * copy whatever was returned to the user back
		 * into our temporary buffer. Set optlen to the
		 * one that kernel returned as well to let
		 * BPF programs inspect the value.
		 */

		if (get_user(ctx.optlen, optlen)) {
			ret = -EFAULT;
			goto out;
		}

		/* ctx.optlen == 1024 */

		orig_optlen = ctx.optlen;
	}

	/* ... */
}

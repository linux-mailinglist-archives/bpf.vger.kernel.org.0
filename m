Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F388865CBA5
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 02:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbjADBvq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 20:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjADBvp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 20:51:45 -0500
Received: from out-59.mta0.migadu.com (out-59.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9ABDEC2
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 17:51:43 -0800 (PST)
Message-ID: <9b7bfabe-1d67-07b6-80e9-19e87143beec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672797102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snIq6m9wRrVyZ9+6UYWgkC6UFr4zUkiUpPYv83mNzmo=;
        b=X564ivbhBqX19gJ8Y+yasdqOy6m97FGdc3dPI4rrNMe7VwWZ2w3m/mX8XpyGpuwTfvJDzM
        +MQ7Lb3vW+WSwa/i/wuQIiLCz/uN+1zMrxIZPgC6hj1M8kJNci8QNRWf026hO0b/V6Hspf
        UUeiQ/5qXq6XHbbc0uPCyGIL9yYxeFo=
Date:   Tue, 3 Jan 2023 17:51:34 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 08/17] bpf: Support consuming XDP HW metadata
 from fext programs
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org
References: <20221220222043.3348718-1-sdf@google.com>
 <20221220222043.3348718-9-sdf@google.com>
 <5983e0f0-e1ee-5843-33ea-64d139e2e849@linux.dev>
 <CAKH8qBtCrAqxTzSECyG2VjO7rx27mdSEKMwXadrvVOvDaf5rBg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAKH8qBtCrAqxTzSECyG2VjO7rx27mdSEKMwXadrvVOvDaf5rBg@mail.gmail.com>
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

On 12/22/22 8:06 PM, Stanislav Fomichev wrote:
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index 11c558be4992..64a68e8fb072 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -2605,6 +2605,12 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
>>>                        goto free_prog_sec;
>>>        }
>>>
>>> +     if (type == BPF_PROG_TYPE_EXT && dst_prog) {
>> Does it also need to test the bpf_prog_is_dev_bound(dst_prog->aux)?  Otherwise,
>> the bpf_prog_dev_bound_inherit() below will fail on everything for !CONFIG_NET.
> We do the following in bpf_prog_dev_bound_inherit which should be enough?
> 
> if (!bpf_prog_is_dev_bound(old_prog->aux))
>       return 0;
> 
> Or am I missing something?

The inline one in include/linux/bpf.h will be called instead when CONFIG_NET is 
not set:

static inline int bpf_prog_dev_bound_inherit(struct bpf_prog *new_prog,
					     struct bpf_prog *old_prog)
{
	return -EOPNOTSUPP;
}


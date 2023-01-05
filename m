Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E33265E15B
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 01:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjAEAOo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 19:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjAEAOR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 19:14:17 -0500
Received: from out-98.mta0.migadu.com (out-98.mta0.migadu.com [IPv6:2001:41d0:1004:224b::62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CABD44344
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 16:13:25 -0800 (PST)
Message-ID: <5cde0738-67d3-ca70-d025-cbd1769b0900@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672877603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VWt0ONMfkMHMihCd04sQ6wLmtwiJcvu5EXMSgSxhHLw=;
        b=W3D2A489Zkr8Y3pOnFcOIWuhVJljX3cqcLHb93bil306iMR8wzOs+boL5z52jt4D4RAMsj
        IOZNnwtNaaiUnf92knSqRvMa1ws7xQ0jNem5MG4SlE9QzrixXrujCDJGAdkkxsaqnZXVa9
        K3VXvnrcavxs1pG+oNFwNMmq31qg1SI=
Date:   Wed, 4 Jan 2023 16:13:19 -0800
MIME-Version: 1.0
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     David Vernet <void@manifault.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, kernel-team@meta.com,
        Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>
References: <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
 <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan>
 <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
 <f69b7d7a-cdac-a478-931a-f534b34924e9@iogearbox.net>
 <20230103235107.k5dobpvrui5ux3ar@macbook-pro-6.dhcp.thefacebook.com>
 <43406cdf-19c1-b80e-0f10-39a1afbf4b8b@iogearbox.net>
 <20230104193735.ji4fa5imvjvnhrqf@macbook-pro-6.dhcp.thefacebook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230104193735.ji4fa5imvjvnhrqf@macbook-pro-6.dhcp.thefacebook.com>
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

On 1/4/23 11:37 AM, Alexei Starovoitov wrote:
> Would you invest in developing application against unstable syscall API? Absolutely.
> People develop all tons of stuff on top of fuse-fs. People develop apps that interact
> with tracing bpf progs that are clearly unstable. They do suffer when kernel side
> changes and people accept that cost. BPF and tracing in general contributed to that mind change.
> In a datacenter quite a few user apps are tied to kernel internals.
> 
>> Imho, it's one of BPF's strengths and
>> we should keep the door open, not close it.
> The strength of BPF was and still is that it has both stable and unstable interfaces.
> Roughly: networking is stable, tracing is unstable.
> The point is that to be stable one doesn't need to use helpers.
> We can make kfuncs stable too if we focus all our efforts this way and
> for that we need to abandon adding helpers though it's a pain short term.
> 
>>>> to actual BPF helpers by then where we go and say, that kfunc has proven itself in production
>>>> and from an API PoV that it is ready to be a proper BPF helper, and until this point
>>> "Proper BPF helper" model is broken.
>>> static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
>>>
>>> is a hack that works only when compiler optimizes the code.
>>> See gcc's attr(kernel_helper) workaround.
>>> This 'proper helper' hack is the reason we cannot compile bpf programs with -O0.
>>> And because it's uapi we cannot even fix this
>>> With kfuncs we will be able to compile with -O0 and debug bpf programs with better tools.
>>> These tools don't exist yet, but we have a way forward whereas with helpers
>>> we are stuck with -O2.
>> Better debugging tools are needed either way, independent of -O0 or -O2. I don't
>> think -O0 is a requirement or barrier for that. It may open up possibilities for
>> new tools, but production is still running with -O2. Proper BPF helper model is
>> broken, but everyone relies on it, and will be for a very very long time to come,
>> whether we like it or not. There is a larger ecosystem around BPF devs outside of
>> kernel, and developers will use the existing means today. There are recommendations /
>> guidelines that we can provide but we also don't have control over what developers
>> are doing. Yet we should make their life easier, not harder.
> Fully fleshed out kfunc infra will make developers job easier. No one is advocating
> to make users suffer.

It is a long discussion. I am replying on a thread with points that I have also 
been thinking about kfunc and helper.

I think bpf helper is a kernel function but helpers need to be defined in a more 
tedious form. It requires to define bpf_func_proto and then wrap into 
BPF_CALL_x. It was not obvious for me to get around to understand the reason 
behind it. With kfunc, it is a more natural way for other kernel developers to 
expose subsystem features to bpf prog. In time, I believe we will be able to 
make kfunc has a similar experience as EXPORT_SYMBOL_*.

Thus, for subsystem (hid, fuse, netdev...etc) exposing functions to bpf prog, I 
think it makes sense to stay with kfunc from now on. The subsystem is not 
exposing something like syscall as an uapi. bpf prog is part of the kernel in 
the sense that it extends that subsystem code. I don't think bpf needs to 
provide extra and more guarantee than the EXPORT_SYMBOL_* in term of api. That 
said, we should still review kfunc in a way that ensuring it is competent to the 
best of our knowledge at that point with the limited initial use cases at hand. 
I won't be surprised some of the existing EXPORT_SYMBOL_* kernel functions will 
be exposed to the bpf prog as kfunc as-is without any change in the future. For 
example, a few tcp cc kfuncs such as tcp_slow_start. They are likely stable 
without much change for a long time. It can be directly exposed as bpf kfunc. 
kfunc is a way to expose subsystem function without needing the bpf_func_proto 
and BPF_CALL_x quirks. When the function can be dual compiled later, the kfunc 
can also be inlined.

If kfunc will be used for subsystem, it is very likely the number of kfunc will 
grow and exceed the bpf helpers soon.  This seems to be a stronger need to work 
on the user experience problems about kfunc that have mentioned in this thread 
sooner than later. They have to be solved regardless. May be start with stable 
kfunc first. If the new helper is guaranteed stable, then why it cannot be kfunc 
but instead needs to go through the bpf_func_proto and BPF_CALL_x?  In time, I 
hope the bpf helper support in the verifier can be quieted down (eg. 
check_helper_call vs check_kfunc_call) and focus energy into kfunc like inlining 
kfunc...etc.

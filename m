Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A0B3C3DAC
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 17:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhGKPcA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Jul 2021 11:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbhGKPb7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Jul 2021 11:31:59 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8A3C0613E5
        for <bpf@vger.kernel.org>; Sun, 11 Jul 2021 08:29:11 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id a14so7709363pls.4
        for <bpf@vger.kernel.org>; Sun, 11 Jul 2021 08:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n3YRHkj0c58PDufExs5GW5EqSsqejMDzvuIBPPdMvOg=;
        b=cftgdsHyZHCgsdByowpFdQGqA8FjOTGeVyz2P4bO1ZPaUO0n6CJX5jUm0hkxED8zJU
         xq0gPh0zyTrbhWUCVnYCl9bXBNqoDAEEFBtUYF9VTbhlnbXwl7oof186KaSl6kpWyLdC
         TPuQygx25GH/YQdmFAbmgOvPIn0iGuugXMqezVWieGdmwgTAI2lb39QeTGSKIGO6ZukQ
         QemdQWgetrSXQJ/NuI0UGINfnUhbQW6KvuPJlat/l9Rfe1IgacNIagJ1La0M6T0Ivy84
         qPq40yPnzuWfNAjtVjtqbmf+/FATYadA9qE7b2wNo75WEtZ7/r3epXFna48S+AgdmBri
         xM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n3YRHkj0c58PDufExs5GW5EqSsqejMDzvuIBPPdMvOg=;
        b=qcCHlcgzfhx+eCLH3GbxDtfshn6N46teOj9Pp1gEcGZRZUyj9JyiyIdMujonJ0E8id
         pKr3Wazf5YJIDmnSGWPGUtWVfC3EnWry+wk5SVsaNtypbF6a3YlGy4HH0Te/RpiWd79k
         JJ9E1sM92ce0B5gWOROMMVrHyKxj3bzDb1DJLc9Tjs0cQO8zXwm6lM9ev5bibFcry4ko
         TGE6gsJUGM7i0ldC19yY9vN3hXUTCQ2RhpJWYbPCLpNPT7DmNFlVRBO8vLwt0qoJ7Lxh
         Ph0MNWLS6ymucWo4RZPNLXI0cDodne9ls2X0rKaNxbQGuoEFKN/GgmnBXpb/JQP6pk+0
         gLwA==
X-Gm-Message-State: AOAM53166U36tnE4Ut8tqx4gbZX6yBzEaPvnZhqiHvYkF9hy6rIxxa+4
        I0wZlduBV76bdtLDsRU5hGUMmQ==
X-Google-Smtp-Source: ABdhPJz0wCI+ok2I8JvUEiK3CSWSTqh3K3oYq6HltM2HravvA/Af1qVij8wZ0KUEEG9Ey2GdBpymAA==
X-Received: by 2002:a17:90a:7d13:: with SMTP id g19mr49022034pjl.163.1626017351507;
        Sun, 11 Jul 2021 08:29:11 -0700 (PDT)
Received: from ?IPv6:240e:38a:3604:2400:8585:964d:c4ab:ba4c? ([240e:38a:3604:2400:8585:964d:c4ab:ba4c])
        by smtp.gmail.com with ESMTPSA id j20sm9964157pfc.203.2021.07.11.08.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jul 2021 08:29:10 -0700 (PDT)
Subject: Re: [PATCH -tip v8 11/13] x86/unwind: Recover kretprobe trampoline
 entry
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162400002631.506599.2413605639666466945.stgit@devnote2>
 <YOLurg5mGHdBc+fz@hirez.programming.kicks-ass.net>
 <20210706004257.9e282b98f447251a380f658f@kernel.org>
 <YOQMV8uE/2bVkPOY@hirez.programming.kicks-ass.net>
 <20210706111136.7c5e9843@oasis.local.home>
 <YOVj2VoyrcOvJfEB@hirez.programming.kicks-ass.net>
 <20210707191510.cb48ca4a20f0502ce6c46508@kernel.org>
 <YOWACec65qVdTD1y@hirez.programming.kicks-ass.net>
 <20210707194530.766a9c8364f3b2d7714ca590@kernel.org>
 <20210707222925.87ecc1391d0ab61db3d8398e@kernel.org>
 <3fc578e0-5b26-6067-d026-5b5d230d6720@bytedance.com>
 <20210711230909.dac1ff010a94831d5e9c25cd@kernel.org>
From:   Matt Wu <wuqiang.matt@bytedance.com>
Message-ID: <9c160404-ad6d-816a-93ed-91bb6e7c26a9@bytedance.com>
Date:   Sun, 11 Jul 2021 23:28:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210711230909.dac1ff010a94831d5e9c25cd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021/7/11 PM10:09, Masami Hiramatsu wrote:
> On Wed, 7 Jul 2021 22:42:47 +0800
> Matt Wu <wuqiang.matt@bytedance.com> wrote:
> 
>> On 2021/7/7 PM9:29, Masami Hiramatsu wrote:
>>> On Wed, 7 Jul 2021 19:45:30 +0900
>>> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>>
>>>> On Wed, 7 Jul 2021 12:20:57 +0200
>>>> Peter Zijlstra <peterz@infradead.org> wrote:
>>>>
>>>>> On Wed, Jul 07, 2021 at 07:15:10PM +0900, Masami Hiramatsu wrote:
>>>>>
>>>>>> I actually don't want to keep this feature because no one use it.
>>>>>> (only systemtap needs it?)
>>>>>
>>>>> Yeah, you mentioned systemtap, but since that's out-of-tree I don't
>>>>> care. Their problem.
>>>
>>> Yeah, maybe it is not hard to update.
>>>
>>>>>
>>>>>> Anyway, if we keep the idea-level compatibility (not code level),
>>>>>> what we need is 'void *data' in the struct kretprobe_instance.
>>>>>> User who needs it can allocate their own instance data for their
>>>>>> kretprobes when initialising it and sets in their entry handler.
>>>>>>
>>>>>> Then we can have a simple kretprobe_instance.
>>>>>
>>>>> When would you do the alloc? When installing the retprobe, but that
>>>>> might be inside the allocator, which means you can't call the allocator
>>>>> etc.. :-)
>>>>
>>>> Yes, so the user may need to allocate a pool right before register_kretprobe().
>>>> (whether per-kretprobe or per-task or global pool, that is user's choice.)
>>>>
>>>>>
>>>>> If we look at struct ftrace_ret_stack, it has a few fixed function
>>>>> fields. The calltime one is all that is needed for the kretprobe
>>>>> example code.
>>>>
>>>> kretprobe consumes 3 fields, a pointer to 'struct kretprobe' (which
>>>> stores callee function address in 'kretprobe::kp.addr'), a return
>>>> address and a frame pointer (*).
>>>   > Oops, I forgot to add "void *data" for storing user data.
>>>
>>
>> Should use "struct kretprobe_holder *rph", since "struct kretprobe" belongs
>> to 3rd-party module (which might be unloaded any time).
> 
> Good catch. Yes, instead of 'struct kretprobe', we need to use the holder.
> 
>> User's own pool might not work if the module can be unloaded. Better manage
>> the pool in kretprobe_holder, which needs no changes from user side.
> 
> No, since the 'data' will be only refered from user handler. If the kretprobe
> is released, then the kretprobe_holder will clear the refernce to the 'struct
> kretprobe'. Then, the user handler is never called. No one access the 'data'.

Indeed, there is no race of "data" accessing, since unregister_kretprobes()
is taking care of it.

This implementation just increases the complexity of caller to keep track
of all allocated instances and release them after unregistration.

But guys are likely to use kmalloc in pre-handler and kfree in post-handler,
which will lead to memory leaks.

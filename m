Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A063BE9FC
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 16:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhGGOps (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 10:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbhGGOps (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 10:45:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BA1C06175F
        for <bpf@vger.kernel.org>; Wed,  7 Jul 2021 07:43:04 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id p14-20020a17090ad30eb02901731c776526so1540862pju.4
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DnHcmdXOtXxSHt5VDmjCHahDFwLNZGsXgX+YAyZDBEc=;
        b=dyqaCx/N48KX4H1SOiYEJ7PlH2DgZrxPddiT51efORM4VAeAPXJo6nIOFtiJU6o4Xo
         Q8Of1CEYQvU+AsfeTu5VY27yUy/Ljf4M6WY/RHH66dXl+0+77p8g8vsAUl73GqPvDKDp
         Xhy+MdUZxOAN6OgTanjuLdYyUbAOX78rwvghAXf7vMqrsTypIKiI5Z1lubDyzs0wuurA
         g/MqSFlCo+N7J1KU3aXhEpjlWOkkJMUQS6QXzEEm0SlgZpWu0nCJT+aIdA3vLXGfpG0W
         Xd8wK6kTedeHZcNm7w5Xba0HN3GRaIqaWW2quXXEo6hC30uhDwY3tc4zeA0ZfYN+61xn
         C74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DnHcmdXOtXxSHt5VDmjCHahDFwLNZGsXgX+YAyZDBEc=;
        b=E5K7KvW7gexSLnGy1hADuv+iEZHmJfM8ExFGc5muvianBxClTmOUQTyQO0f+KtnqlZ
         zj6FZaBDf9Z8dhKP9M5V+h10u1Ug3c07BXxz7SH9TB8TgsluTdlhzhUsSWFwLKvAzU/9
         FbW1vTZ18MwJQTA0oicj8FYGxISzPzYxBI7vqw5EsBp2uzy1jTQiqkkf+Wawr2J589jU
         0cZZ+x/7AlsiFgGdHHTODkh8XrZwB1CtGPlMo4jWX8vAV7fGl2xC2jIfQDHMQOHWUvSX
         IQkSpPhU4cuz6k+8fsJvNuJKuejOCIz+8uuZmuuM0Rsaet30Or8037NQcqrXIwSt3rGL
         XzaA==
X-Gm-Message-State: AOAM533GiCgaD53ALBG1K5AK54TXp8jpvfHL6+j7m5st8gG6O+ZCS/Ty
        9lKghO8+v7sc1i/dL2zJCXSFWg==
X-Google-Smtp-Source: ABdhPJz4cLmXypP8N6Xga5x368CM+hcB4Kd43JDg63IlBF7D576Gx/qo/nrb/bYGDZHIoeMTXBp3RA==
X-Received: by 2002:a17:902:6904:b029:fb:42b6:e952 with SMTP id j4-20020a1709026904b02900fb42b6e952mr21656710plk.16.1625668983573;
        Wed, 07 Jul 2021 07:43:03 -0700 (PDT)
Received: from ?IPv6:240e:38a:3604:2400:7485:644e:8f74:dc56? ([240e:38a:3604:2400:7485:644e:8f74:dc56])
        by smtp.gmail.com with ESMTPSA id q17sm12610916pfh.30.2021.07.07.07.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 07:43:02 -0700 (PDT)
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
From:   Matt Wu <wuqiang.matt@bytedance.com>
Message-ID: <3fc578e0-5b26-6067-d026-5b5d230d6720@bytedance.com>
Date:   Wed, 7 Jul 2021 22:42:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707222925.87ecc1391d0ab61db3d8398e@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021/7/7 PM9:29, Masami Hiramatsu wrote:
> On Wed, 7 Jul 2021 19:45:30 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>> On Wed, 7 Jul 2021 12:20:57 +0200
>> Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>> On Wed, Jul 07, 2021 at 07:15:10PM +0900, Masami Hiramatsu wrote:
>>>
>>>> I actually don't want to keep this feature because no one use it.
>>>> (only systemtap needs it?)
>>>
>>> Yeah, you mentioned systemtap, but since that's out-of-tree I don't
>>> care. Their problem.
> 
> Yeah, maybe it is not hard to update.
> 
>>>
>>>> Anyway, if we keep the idea-level compatibility (not code level),
>>>> what we need is 'void *data' in the struct kretprobe_instance.
>>>> User who needs it can allocate their own instance data for their
>>>> kretprobes when initialising it and sets in their entry handler.
>>>>
>>>> Then we can have a simple kretprobe_instance.
>>>
>>> When would you do the alloc? When installing the retprobe, but that
>>> might be inside the allocator, which means you can't call the allocator
>>> etc.. :-)
>>
>> Yes, so the user may need to allocate a pool right before register_kretprobe().
>> (whether per-kretprobe or per-task or global pool, that is user's choice.)
>>
>>>
>>> If we look at struct ftrace_ret_stack, it has a few fixed function
>>> fields. The calltime one is all that is needed for the kretprobe
>>> example code.
>>
>> kretprobe consumes 3 fields, a pointer to 'struct kretprobe' (which
>> stores callee function address in 'kretprobe::kp.addr'), a return
>> address and a frame pointer (*).
>  > Oops, I forgot to add "void *data" for storing user data.
> 

Should use "struct kretprobe_holder *rph", since "struct kretprobe" belongs
to 3rd-party module (which might be unloaded any time).

User's own pool might not work if the module can be unloaded. Better manage
the pool in kretprobe_holder, which needs no changes from user side.

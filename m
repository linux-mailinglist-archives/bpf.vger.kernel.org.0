Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465CD19B555
	for <lists+bpf@lfdr.de>; Wed,  1 Apr 2020 20:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbgDASYI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Apr 2020 14:24:08 -0400
Received: from pub.regulars.win ([89.163.144.234]:42612 "EHLO pub.regulars.win"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732809AbgDASYI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Apr 2020 14:24:08 -0400
Subject: Re: [PATCH v3 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bacher09.org;
        s=reg; t=1585765442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=1kkKEtu2FNsotuDvZHjyrVpQBdv8liMb6LlRmFQfZoE=;
        b=Py92+5ns2kudY9v+j/rMfz6e9ULZf2d+9VY8vx4ba0jeSq508KPc37HUfX7PusmECzzEPq
        dnewUNNd45/60N0xsaGHFI6BxV+D1IHM7ECS4p20IwOvUFrz3GvM7zU6E71a6e1sWTkTDO
        jJVW96CodHSTyq+lDJs5XfHFsp/YLPM=
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>,
        KP Singh <kpsingh@google.com>
References: <202004010033.A1523890@keescook>
 <20200401142057.453892-1-slava@bacher09.org>
 <eba80d4e-a385-1fba-37f9-38888ae91f1e@bacher09.org>
 <CAEf4BzYx7hffHm5RV3QQQqvgAzy-41DRgFQDKh+4xcM9OL890A@mail.gmail.com>
From:   Slava Bacherikov <slava@bacher09.org>
Autocrypt: addr=slava@bacher09.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <758ddac6-17ab-2e24-0199-ae0223517894@bacher09.org>
Date:   Wed, 1 Apr 2020 21:24:00 +0300
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYx7hffHm5RV3QQQqvgAzy-41DRgFQDKh+4xcM9OL890A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



01.04.2020 20:46, Andrii Nakryiko пишет:
> On Wed, Apr 1, 2020 at 7:38 AM Slava Bacherikov <slava@bacher09.org> wrote:
>>
>>
>>
>> 01.04.2020 17:20, Slava Bacherikov wrotes:
>>> Currently turning on DEBUG_INFO_SPLIT when DEBUG_INFO_BTF is also
>>> enabled will produce invalid btf file, since gen_btf function in
>>> link-vmlinux.sh script doesn't handle *.dwo files.
>>>
>>> Enabling DEBUG_INFO_REDUCED will also produce invalid btf file, and
>>> using GCC_PLUGIN_RANDSTRUCT with BTF makes no sense.
>>>
>>> Signed-off-by: Slava Bacherikov <slava@bacher09.org>
>>> Reported-by: Jann Horn <jannh@google.com>
>>> Reported-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
>>> Acked-by: KP Singh <kpsingh@google.com>
>>> Acked-by: Andrii Nakryiko <andriin@fb.com>
>>> Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for vmlinux")
>>> ---
>>>  lib/Kconfig.debug | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>>> index f61d834e02fe..b94227be2d62 100644
>>> --- a/lib/Kconfig.debug
>>> +++ b/lib/Kconfig.debug
>>> @@ -222,7 +222,9 @@ config DEBUG_INFO_DWARF4
>>>
>>>  config DEBUG_INFO_BTF
>>>       bool "Generate BTF typeinfo"
>>> -     depends on DEBUG_INFO
>>> +     depends on DEBUG_INFO || COMPILE_TEST
>> I had to add this, since DEBUG_INFO which depends on:
>>
>>         DEBUG_KERNEL && !COMPILE_TEST
>>
>> would block DEBUG_INFO_BTF when COMPILE_TEST is turned on.
>>
> 
> Sorry if I'm being dense here. But what's the point in enabling
> DEBUG_INFO_BTF if there is no *valid* DWARF info available for
> DWARF-to-BTF conversion?

As I mention in [0] there is no point in having `!GCC_PLUGIN_RANDSTRUCT
|| COMPILE_TEST` without `DEBUG_INFO || COMPILE_TEST`, since without it
COMPILE_TEST would block DEBUG_INFO_BTF and because of that
GCC_PLUGIN_RANDSTRUCT would be never blocked by BTF.

As far as I understood from [1] main point for all these these things
with COMPILE_TEST is to be able to check if kernel could be compiled
with all these options (e.g. check syntax, build scripts, etc).

I can rollback `DEBUG_INFO || COMPILE_TEST`, but in that case there is
no point in `GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST` since COMPILE_TEST
in that case will not affect anything here, regardless from it's value.

[0]:
https://lore.kernel.org/bpf/202004010029.167BA4AA1F@keescook/T/#m2f493902d6aed09d30e5c4144a0164459386339d
[1]:
https://lore.kernel.org/bpf/202004010029.167BA4AA1F@keescook/T/#m8f25fab3476c9619249fee9ae692acb98c02cdc7
> 
> 
>> In that case allyesconfig will emit both:
>>
>> CONFIG_DEBUG_INFO_BTF=y
>> CONFIG_GCC_PLUGIN_RANDSTRUCT=y
> 
> Which I thought is exactly what we wanted to avoid. Not sure what's
> the point of compiling kernel (even if it's the one that is not
> supposed to ever run) that apriori has broken BTF? If it was
> acceptable to not have DEBUG_INFO for COMPILE_TEST, why it's not
> acceptable to not have DEBUG_INFO_BTF in that situation as well?
> 
>>
>>
>>
>>> +     depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
>>> +     depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
>>>       help
>>>         Generate deduplicated BTF type information from DWARF debug info.
>>>         Turning this on expects presence of pahole tool, which will convert
>>>

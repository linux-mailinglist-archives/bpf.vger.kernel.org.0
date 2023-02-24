Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F396A1B93
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 12:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjBXLte (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 06:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBXLtd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 06:49:33 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70534158B3
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 03:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677239372; x=1708775372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i1Z/QhlGR3vBRA1wf+D/QKHeURL4ph5jwJSogcizdBo=;
  b=QrWhDyElddM5uQuhClO410zs9fgRm4KRwnRnRNLrYV9Lm3kRqpENH18g
   +iTEYMiV/IMssuUAdjkf/VOEVOxP2xl6SlfMAJ8Sc1dltlXvqmXtMTMEI
   laoPXZ4vbIJWpmHm9aa3KUpjZupN10UUJPl9Ng7M5QMyf3XmiChG7Es2x
   cOe4YTwAcho4IpWc6AyOBuF/PaAaCnPzA4/WNiPXMOW/X8lMQrhHNjDF4
   76hSBSgOJawdQT7Vt6RxL4v8pNeogIJJxXLB3WGrCUYG/EUviFoW+tXzP
   TZ+MX96fatDfxHJ3vk7V3QCVu915m6XkDucY2O0hZuawG+VEoUwazP1s3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="331193677"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="331193677"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 03:49:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="672873680"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="672873680"
Received: from hhalland-mobl.ger.corp.intel.com (HELO [10.249.40.112]) ([10.249.40.112])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 03:49:30 -0800
Message-ID: <f171f10b-f7e5-e63d-b446-b37a2856909a@linux.intel.com>
Date:   Fri, 24 Feb 2023 13:49:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: bpf: RFC for platform specific BPF helper addition
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <0838bc96-c8a8-c326-a8f0-80240cf6b31a@linux.intel.com>
 <CAADnVQJ4fHzqeuhbCF5SDR5V1Ktku=U2RRRPLc17ia0aFgNG=w@mail.gmail.com>
From:   Tero Kristo <tero.kristo@linux.intel.com>
In-Reply-To: <CAADnVQJ4fHzqeuhbCF5SDR5V1Ktku=U2RRRPLc17ia0aFgNG=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 23/02/2023 19:46, Alexei Starovoitov wrote:
> On Thu, Feb 23, 2023 at 5:23 AM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>> Hi,
>>
>> Some background first; on x86 platforms there is a free running TSC
>> counter which can be used to generate extremely accurate profiling time
>> stamps. Currently this can be used by BPF programs via hooking into perf
>> subsystem and reading the value there; however this reduces the accuracy
>> due to latency + jitter involved with long execution chain, and also the
>> timebase gets converted into relative from the start of the execution of
>> the program, instead of getting an absolute system level value.
> Are you talking about rdtsc or some other counter?
> Does it need an arch specific setup?
Yes, this is rdtsc. TSC is setup automatically by the arch, but 
exporting it to BPF takes a few lines of arch specific code (I did use 
register_btf_kfunc_id_set() during init, under arch/x86/kernel/tsc.c.)
>
>> Now, I do have a pretty trivial patch (under internal review atm. at
>> Intel) that adds an x86 platform specific bpf helper that can directly
>> read this timestamp counter without relying to perf subsystem hooks.
>>
>> Do people have any feedback / insights on this list about addition of
>> such platform specific BPF helper, basically thumbs up/down for adding
>> such a thing? Currently I don't think there are any platform specific
>> helpers in the kernel.
> Right. That's one of the reasons we don't add new helpers anymore.
> Please use kfunc instead. You can add it to:
> arch/x86/net/bpf_jit_comp.c
> like:
> __bpf_kfunc u64 bpf_read_rdtsc(void)
> { asm ("...
> or to arch specific kernel module.
>
> Make sure to add selftests when you submit a patch.

Ok, I can take a look at the selftest side if things nudge forward, 
however there is some internal pressure to ditch the whole idea of 
bpf_rdtsc() due to potential of side channel attacks by using BPF, and 
exploiting the accurate timer in the process. Any thoughts on that side? 
Using BPF requires root access nowadays so it is sort of on-par to 
out-of-tree kernel modules.

-Tero


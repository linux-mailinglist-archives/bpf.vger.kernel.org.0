Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE136A561B
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 10:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjB1JqJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 04:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjB1JqI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 04:46:08 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1651322019
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 01:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677577547; x=1709113547;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xN1b9qEAp/J/OxT4tSEb+SKXdNjgqIoCxLD5M3dCYyE=;
  b=I/F320ai6DxvQvAUOc8MCrxL3OnzawP7d8eftcX3NaBS5pXIUvYlogKU
   l0yzzc4wFFugGs3VmY/A7MO+bJvPbIqDLmppvE/O7MUUAuOmGPQ9iZ4FO
   R2U96KwfVbBJZLeU1Nyl7STCljzeVPzri8hy3fEv7c6P9omNebxSyXMIh
   wmFUyBMc0K3k6Ad+wN5pOCM+9WczgTR5aPGllryiM2dwGJZ1ULkSeqvCo
   6fLsTxses0QdLzFCnR5oM9+TNul7GumPBCvsSLMVed18jLSYKgAmFCQFw
   Xrbm0ThhS1yeY3sBzkXDdY0/pxqtxG/5llp62Pxkc6/1SOy6/CGQNtx1b
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="317895263"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="317895263"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 01:45:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="817032314"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="817032314"
Received: from kgaier-mobl.ger.corp.intel.com (HELO [10.252.46.152]) ([10.252.46.152])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 01:45:31 -0800
Message-ID: <73557717-e0b2-3969-4f08-c0951361af45@linux.intel.com>
Date:   Tue, 28 Feb 2023 11:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: bpf: RFC for platform specific BPF helper addition
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <0838bc96-c8a8-c326-a8f0-80240cf6b31a@linux.intel.com>
 <CAADnVQJ4fHzqeuhbCF5SDR5V1Ktku=U2RRRPLc17ia0aFgNG=w@mail.gmail.com>
 <f171f10b-f7e5-e63d-b446-b37a2856909a@linux.intel.com>
 <CAADnVQKQ+eEyNt_3EsNkCbxgu93tNEOFq+EGs-6JJhMt-A50cA@mail.gmail.com>
From:   Tero Kristo <tero.kristo@linux.intel.com>
In-Reply-To: <CAADnVQKQ+eEyNt_3EsNkCbxgu93tNEOFq+EGs-6JJhMt-A50cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 25/02/2023 02:01, Alexei Starovoitov wrote:
> On Fri, Feb 24, 2023 at 3:49 AM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>>
>> On 23/02/2023 19:46, Alexei Starovoitov wrote:
>>> On Thu, Feb 23, 2023 at 5:23 AM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>>>> Hi,
>>>>
>>>> Some background first; on x86 platforms there is a free running TSC
>>>> counter which can be used to generate extremely accurate profiling time
>>>> stamps. Currently this can be used by BPF programs via hooking into perf
>>>> subsystem and reading the value there; however this reduces the accuracy
>>>> due to latency + jitter involved with long execution chain, and also the
>>>> timebase gets converted into relative from the start of the execution of
>>>> the program, instead of getting an absolute system level value.
>>> Are you talking about rdtsc or some other counter?
>>> Does it need an arch specific setup?
>> Yes, this is rdtsc. TSC is setup automatically by the arch, but
>> exporting it to BPF takes a few lines of arch specific code (I did use
>> register_btf_kfunc_id_set() during init, under arch/x86/kernel/tsc.c.)
>>>> Now, I do have a pretty trivial patch (under internal review atm. at
>>>> Intel) that adds an x86 platform specific bpf helper that can directly
>>>> read this timestamp counter without relying to perf subsystem hooks.
>>>>
>>>> Do people have any feedback / insights on this list about addition of
>>>> such platform specific BPF helper, basically thumbs up/down for adding
>>>> such a thing? Currently I don't think there are any platform specific
>>>> helpers in the kernel.
>>> Right. That's one of the reasons we don't add new helpers anymore.
>>> Please use kfunc instead. You can add it to:
>>> arch/x86/net/bpf_jit_comp.c
>>> like:
>>> __bpf_kfunc u64 bpf_read_rdtsc(void)
>>> { asm ("...
>>> or to arch specific kernel module.
>>>
>>> Make sure to add selftests when you submit a patch.
Regarding this I got a follow up question, where would you recommend to 
put selftests for such functionality? Any of the BPF selftests appear to 
be generic currently.
>> Ok, I can take a look at the selftest side if things nudge forward,
>> however there is some internal pressure to ditch the whole idea of
>> bpf_rdtsc() due to potential of side channel attacks by using BPF, and
>> exploiting the accurate timer in the process. Any thoughts on that side?
>> Using BPF requires root access nowadays so it is sort of on-par to
>> out-of-tree kernel modules.
> Can you elaborate on that security concern?
> User space can do rdtsc, so not clear how doing the same in bpf prog
> loaded by root makes any difference.
> Unpriv bpf is pretty much non-existent.
> bpf subsystem went root only long ago.

I am working on this internally with our security team atm., and the 
initial assessment is that the concern may not be valid due to the 
points you mention also.

-Tero


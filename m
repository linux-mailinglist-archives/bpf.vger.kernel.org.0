Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24BA3246D1
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 23:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhBXW2E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 17:28:04 -0500
Received: from www62.your-server.de ([213.133.104.62]:40664 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhBXW2D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 17:28:03 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lF2cn-0005Cu-3w; Wed, 24 Feb 2021 23:27:17 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lF2cm-000RoQ-UQ; Wed, 24 Feb 2021 23:27:16 +0100
Subject: Re: arch_prepare_bpf_trampoline() for arm ?
To:     KP Singh <kpsingh@kernel.org>
Cc:     Luigi Rizzo <rizzo@iet.unipi.it>, bpf <bpf@vger.kernel.org>,
        will@kernel.org
References: <CA+hQ2+hhDG2JprNLaUdX4xgcihvchEda1aJuQN3jtJ3hYucDcQ@mail.gmail.com>
 <6af0ab27-48f1-e389-d2f4-41b3c1db4a18@iogearbox.net>
 <CACYkzJ52rAyOWQsKXOOej1=Wh_Fw_S0yBROK7POwbnnccqdvQA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4f57cfa1-baf9-771d-b8c3-29e02b87c989@iogearbox.net>
Date:   Wed, 24 Feb 2021 23:27:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACYkzJ52rAyOWQsKXOOej1=Wh_Fw_S0yBROK7POwbnnccqdvQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26090/Wed Feb 24 13:09:42 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/24/21 10:30 PM, KP Singh wrote:
> I checked with Will about it and learnt that ARM64 does support
> patching certain instructions (e.g. branch, brk, nops) using
> aarch64_insn_patch_text_nosync, it's used in ftrace:
> 
> https://elixir.bootlin.com/linux/latest/source/arch/arm64/kernel/ftrace.c#L24
> 
> But one has to tolerate that not all CPUs will execute these
> instructions until a context synchronization happens due to an
> exception or an ISB instruction. But I think we can start
> with the same thing that FTrace does?

Is there any downside or road blocker for a aarch64_insn_patch_text_sync()
variant which would then trigger an explicit isb()? Presumably to perform
this reliably at that point you would end up at aarch64_insn_patch_text()
which needs the brute force stop CPU, right? I guess my noob question is
what happens if, for example, an old JITed BPF prog got freed (RCU) and the
JIT mem got reused for something else in meantime when patching JMP->NOP
via aarch64_insn_patch_text_nosync() and not all CPUs did a context sync,
is such scenario/worry realistic?

> On Wed, Feb 24, 2021 at 10:01 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 2/24/21 8:54 PM, Luigi Rizzo wrote:
>>> I prepared a BPF version of kstats[1]
>>> https://github.com/luigirizzo/lr-cstats
>>> that uses fentry/fexit hooks to monitor the execution time
>>> of a kernel function.
>>>
>>> I hoped to have it working on ARM64 too, but it looks like
>>> arch_prepare_bpf_trampoline() only exists for x86.
>>>
>>> Is there any outstanding patch for this function on ARM64,
>>> or any similar function I could look at to implement it myself ?
>>
>> Not that I'm currently aware of, arm64 support would definitely be great
>> to have. From x86 side, the underlying arch dependency was basically on
>> text_poke_bp() to patch instructions on a live kernel. Haven't checked
>> recently whether an equivalent exists on arm64 yet, but perhaps Will
>> might know.
>>
>>> [1] kstats is an in-kernel also in the above repo and previously
>>> discussed at https://lwn.net/Articles/813303/
>>


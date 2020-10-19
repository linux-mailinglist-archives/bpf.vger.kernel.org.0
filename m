Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C55D2927C2
	for <lists+bpf@lfdr.de>; Mon, 19 Oct 2020 14:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgJSM6n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Oct 2020 08:58:43 -0400
Received: from www62.your-server.de ([213.133.104.62]:47710 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbgJSM6n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Oct 2020 08:58:43 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kUUkK-0006lw-Sx; Mon, 19 Oct 2020 14:58:40 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kUUkK-000AHt-NJ; Mon, 19 Oct 2020 14:58:40 +0200
Subject: Re: Running JITed and interpreted programs simultaneously
To:     Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        David Marcinkovic <david.marcinkovic@sartura.hr>,
        alexei.starovoitov@gmail.com
References: <CAOjtDRXzkwG84UCUVw0J_WmRt585OhOSjuWbdenYFNFinsSG0Q@mail.gmail.com>
 <CAEf4BzazaFZQHLcNARGWn4TTJJTQPdBVbskg+bJGp-dds-t1xw@mail.gmail.com>
 <CAOjtDRXrSzqb4PTBXDAHMuCArYjpMoTcT0Maw2UqefJN2DbATA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8cc1629c-8a85-2d84-f779-6a20bb5d36bd@iogearbox.net>
Date:   Mon, 19 Oct 2020 14:58:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAOjtDRXrSzqb4PTBXDAHMuCArYjpMoTcT0Maw2UqefJN2DbATA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25961/Sun Oct 18 15:56:23 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/19/20 12:20 PM, Juraj Vijtiuk wrote:
> On Wed, Oct 14, 2020 at 12:05 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> On Fri, Oct 9, 2020 at 12:58 PM Juraj Vijtiuk <juraj.vijtiuk@sartura.hr> wrote:
>>>
>>> It would be great to hear if anyone has any thoughts on running a set
>>> of BPF programs JITed while other programs are run by the interpreter.
>>>
>>> Something like that would be useful on 32-bit architectures, as the
>>> JIT compiler there doesn't support some instructions, primarily
>>> instructions that work with 64-bit data. As far as I can tell, it is
>>> unlikely that support will be coming soon as it is a general issue for
>>> all 32-bit architectures. Atomic operations like BPF_XADD look
>>> especially problematic regarding support on 32 bit platforms. From
>>> what I managed to see such a conclusion appeared in a few patches
>>> where support for 32-bit JITs was added, for example [0].
>>> That results in some programs being runnable with BPF JIT enabled, and
>>> some failing during load time, but running successfully without JIT on
>>> 32-bit platforms.
>>>
>>> The only way to run some programs with JIT and some without, that
>>> seems possible right now, is to manually change
>>> /proc/sys/net/core/bpf_jit_enable every time a program is loaded.
>>> Although I've managed to do that and it seems to be working, it seems
>>> pretty hacky and looks like it could cause race conditions if multiple
>>> programs were loaded, especially by independent loaders.
>>
>> I agree, the global file is not flexible enough and can cause problems
>> in production environment.
>>
>> I don't see any reason why we shouldn't allow to decide interpreted vs
>> jitted mode per program during BPF_PROG_LOAD.
>>
>> See kernel/bpf/core.c, bpf_prog's jit_requested field determines
>> whether a program is going to be jitted or not. It should be trivial
>> to allow overriding that during BPF_PROG_LOAD command.
>>
>> We can probably also generalize this to allow to "force-jit" or
>> "force-interpret" by users, which would fail if kernel didn't support
>> requested mode.
> 
> Thanks for the suggestion, that makes sense. I've started working on a
> patch today.
> I'll post again when I get something working and test it.

Hmm, I'm probably missing some context, but why is it not enough to just set the
bpf_jit_enable to 1, and if 32 bit JITs don't support specific instructions like
BPF_XADD then they should transparently fall back to interpreter if you have
the latter compiled in. That is what it /should/ do today and user loading the
prog shouldn't have to care about it. Juraj, you are suggesting that this is not
happening in your case? Or is the issue tail calls?

Wrt force-interpret vs force-jit BPF_PROG_LOAD flag, I'm more concerned that this
decision will then be pushed to the user who should not have to care about these
internals. And how would generic loaders try to react if force-jit fails? They would
then fallback to force-interpret same way as kernel does?

Wrt BPF_XADD, maybe 32 bit platforms should just implement a function call to the
atomic64_add() internally, it will be slow but otoh the rest can then be JITed, so
most likely this still ends up being faster than using interpreter for everything
anyway.

Thanks,
Daniel

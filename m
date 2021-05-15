Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2C53819AD
	for <lists+bpf@lfdr.de>; Sat, 15 May 2021 17:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhEOPuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 May 2021 11:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbhEOPuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 May 2021 11:50:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C79A61377;
        Sat, 15 May 2021 15:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621093742;
        bh=9ko5ujwWSKEVrSBOJZLnsjRLIRjeY6NbE+C84Janp6A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VplB6vOb81I15gaP96w7NAfJVwBNSo74K+pZrkTh2byuCeMxQS4KLu9HwfPChFwSS
         zoZtyHDfitTCrovGL8PqPXzzrnGc3OGQqZoXCuKpIG2PkswHTt+S6HVNiq3ToKpM1i
         vLeYc7r42NQKcHhTVtK7T9Sd6hbBw2kPZtcRS0zPhAv78fiMN/i02hJM+tlwyJiVI3
         Po6rRsz0HhWInqitj82tjWdkLVZgD+byf2Zo55BMthAbYP3sRdozcMZUjZ4U3Mu6Ol
         rn3vG6O8S4W2QtP7cEHXROW8fC1R6u3t9Fd+cJA8illFbq1x/5yDbu/WLzVyCkbSj+
         aeYm1tq2x25fQ==
Subject: Re: [RFC PATCH bpf-next seccomp 00/12] eBPF seccomp filters
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     containers@lists.linux.dev, bpf <bpf@vger.kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Austin Kuo <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
 <CALCETrUQBonh5BC4eomTLpEOFHVcQSz9SPcfOqNFTf2TPht4-Q@mail.gmail.com>
 <CABqSeASYRXMwTQwLfm_Tapg45VUy9sPfV7BeeV8p7XJrDoLf+Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <b3a1684b-86e4-74c4-184b-7700613aa838@kernel.org>
Date:   Sat, 15 May 2021 08:49:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CABqSeASYRXMwTQwLfm_Tapg45VUy9sPfV7BeeV8p7XJrDoLf+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/10/21 10:21 PM, YiFei Zhu wrote:
> On Mon, May 10, 2021 at 12:47 PM Andy Lutomirski <luto@kernel.org> wrote:
>> On Mon, May 10, 2021 at 10:22 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>>>
>>> From: YiFei Zhu <yifeifz2@illinois.edu>
>>>
>>> Based on: https://lists.linux-foundation.org/pipermail/containers/2018-February/038571.html
>>>
>>> This patchset enables seccomp filters to be written in eBPF.
>>> Supporting eBPF filters has been proposed a few times in the past.
>>> The main concerns were (1) use cases and (2) security. We have
>>> identified many use cases that can benefit from advanced eBPF
>>> filters, such as:
>>
>> I haven't reviewed this carefully, but I think we need to distinguish
>> a few things:
>>
>> 1. Using the eBPF *language*.
>>
>> 2. Allowing the use of stateful / non-pure eBPF features.
>>
>> 3. Allowing the eBPF programs to read the target process' memory.
>>
>> I'm generally in favor of (1).  I'm not at all sure about (2), and I'm
>> even less convinced by (3).
>>
>>>
>>>   * exec-only-once filter / apply filter after exec
>>
>> This is (2).  I'm not sure it's a good idea.
> 
> The basic idea is that for a container runtime it may wait to execute
> a program in a container without that program being able to execve
> another program, stopping any attack that involves loading another
> binary. The container runtime can block any syscall but execve in the
> exec-ed process by using only cBPF.
> 
> The use case is suggested by Andrea Arcangeli and Giuseppe Scrivano.
> @Andrea and @Giuseppe, could you clarify more in case I missed
> something?

We've discussed having a notifier-using filter be able to replace its
filter.  This would allow this and other use cases without any
additional eBPF or cBPF code.

>> eBPF doesn't really have a privilege model yet.  There was a long and
>> disappointing thread about this awhile back.
> 
> The idea is that “seccomp-eBPF does not make life easier for an
> adversary”. Any attack an adversary could potentially utilize
> seccomp-eBPF, they can do the same with other eBPF features, i.e. it
> would be an issue with eBPF in general rather than specifically
> seccomp’s use of eBPF.
> 
> Here it is referring to the helpers goes to the base
> bpf_base_func_proto if the caller is unprivileged (!bpf_capable ||
> !perfmon_capable). In this case, if the adversary would utilize eBPF
> helpers to perform an attack, they could do it via another
> unprivileged prog type.
> 
> That said, there are a few additional helpers this patchset is adding:
> * get_current_uid_gid
> * get_current_pid_tgid
>   These two provide public information (are namespaces a concern?). I
> have no idea what kind of exploit it could add unless the adversary
> somehow side-channels the task_struct? But in that case, how is the
> reading of task_struct different from how the rest of the kernel is
> reading task_struct?

Yes, namespaces are a concern.  This idea got mostly shot down for kdbus
(what ever happened to that?), and it likely has the same problems for
seccomp.

>>
>> What is this for?
> 
> Memory reading opens up lots of use cases. For example, logging what
> files are being opened without imposing too much performance penalty
> from strace. Or as an accelerator for user notify emulation, where
> syscalls can be rejected on a fast path if we know the memory contents
> does not satisfy certain conditions that user notify will check.
> 

This has all kinds of race conditions.


I hate to be a party pooper, but this patchset is going to very high bar
to acceptance.  Right now, seccomp has a couple of excellent properties:

First, while it has limited expressiveness, it is simple enough that the
implementation can be easily understood and the scope for
vulnerabilities that fall through the cracks of the seccomp sandbox
model is low.  Compare this to Windows' low-integrity/high-integrity
sandbox system: there is a never ending string of sandbox escapes due to
token misuse, unexpected things at various integrity levels, etc.
Seccomp doesn't have tokens or integrity levels, and these bugs don't
happen.

Second, seccomp works, almost unchanged, in a completely unprivileged
context.  The last time making eBPF work sensibly in a less- or
-unprivileged context, the maintainers mostly rejected the idea of
developing/debugging a permission model for maps, cleaning up the bpf
object id system, etc.  You are going to have a very hard time
convincing the seccomp maintainers to let any of these mechanism
interact with seccomp until the underlying permission model is in place.

--Andy

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E77E165369
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2020 01:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgBTAPd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 19:15:33 -0500
Received: from www62.your-server.de ([213.133.104.62]:55082 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgBTAPd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Feb 2020 19:15:33 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1j4ZV5-0006KN-72; Thu, 20 Feb 2020 01:15:31 +0100
Received: from [85.7.42.192] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1j4ZV4-0009oJ-Ve; Thu, 20 Feb 2020 01:15:31 +0100
Subject: Re: [PATCH bpf-next] selftests/bpf: change llvm flag -mcpu=probe to
 -mcpu=v3
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Kernel Team <kernel-team@fb.com>
References: <20200219004236.2291125-1-yhs@fb.com>
 <956ccea3-0440-7c59-9c75-90cd7b25afb7@iogearbox.net>
 <CAADnVQLWJ+F8w0g9XaLbNHZEXKbcQeXt+AiAZX7gMX=L_PWrhw@mail.gmail.com>
 <CAADnVQ+CtuOkpidngFxEXWU_efLOv9_ozj=eSgNo1os1w3b8Sw@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e53c30a2-5979-6358-025a-bae11a8d01a3@iogearbox.net>
Date:   Thu, 20 Feb 2020 01:15:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+CtuOkpidngFxEXWU_efLOv9_ozj=eSgNo1os1w3b8Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.1/25728/Wed Feb 19 15:06:20 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/20/20 12:17 AM, Alexei Starovoitov wrote:
> On Wed, Feb 19, 2020 at 9:06 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Wed, Feb 19, 2020 at 8:56 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>> On 2/19/20 1:42 AM, Yonghong Song wrote:
>>>> The latest llvm supports cpu version v3, which is cpu version v1
>>>> plus some additional 64bit jmp insns and 32bit jmp insn support.
>>>>
>>>> In selftests/bpf Makefile, the llvm flag -mcpu=probe did runtime
>>>> probe into the host system. Depending on compilation environments,
>>>> it is possible that runtime probe may fail, e.g., due to
>>>> memlock issue. This will cause generated code with cpu version v1.
>>>
>>> But those are tiny BPF progs that LLVM is probing. If memlock is not
>>> sufficient, should it try to bump the limit with the diff needed and
>>> only if that fails as well then it bails out to v1.
>>
>> with hundred parallel clangs running and all stamping on the same rlimit
>> I don't think bumping that limit can work.

Right, my main worry is that the default memlock limit is usually very
low, so it would be quite ugly to have the probe fail and fall-back to
v1 even though the underlying kernel would be totally fine to support v3
in general. Hard-coding v3 for selftests is okay; perhaps we need to
resurrect the old CAP_IPC_LOCK patch or some different accounting, the
memlock limit has never been working great from a usability pov.

>> Also building on older kernel should still do v3, since build should
>> produce selftest binaries for the same vmlinux as this kernel tree.
>> We hit this issue with github/libbpf CI. The vm used to do the build
>> was too old. So far we cannot build vmlinux out of latest tree,
>> boot into it and only then build selftests inside. It's too complex
>> for CI system.
>> So we build vmlinux and build selftests in that CI's VM, and then boot into it
>> and run selftests.
>> Upgrading VM is an easy fix for now, but the issue will cause the problems
>> later. So imo fixing selftests build to predictable -mcpu=v3 is the
>> most sensible way.

It would definitely be great to test all at some point, meaning, test run
with v1, v2, v3 to ensure there are no regressions e.g. on verifier side
for all of them.

Thanks,
Daniel

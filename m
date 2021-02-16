Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D6E31C4AF
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 01:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhBPAoQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 19:44:16 -0500
Received: from www62.your-server.de ([213.133.104.62]:32878 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhBPAoP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Feb 2021 19:44:15 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lBoSh-0006Jy-NC; Tue, 16 Feb 2021 01:43:31 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lBoSh-000E2g-H2; Tue, 16 Feb 2021 01:43:31 +0100
Subject: Re: [PATCH bpf-next] bpf: x86: Explicitly zero-extend rax after
 32-bit cmpxchg
To:     KP Singh <kpsingh@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Brendan Jackman <jackmanb@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>
References: <20210215171208.1181305-1-jackmanb@google.com>
 <44912664-5c0b-8d95-de01-c87b1e8a846c@iogearbox.net>
 <b4b116fd53ac14a3006d81ed90069600b3abae4f.camel@linux.ibm.com>
 <725b73b5-be08-f253-165d-e027ec568691@iogearbox.net>
 <5f7b836cc07980352215a5ad9a959c7e7c47f1cf.camel@linux.ibm.com>
 <CACYkzJ7-P4E71G-Ek_Hm5YQmvmYL_--K1dkm8pUZWbChgdjrfg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net>
Date:   Tue, 16 Feb 2021 01:43:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACYkzJ7-P4E71G-Ek_Hm5YQmvmYL_--K1dkm8pUZWbChgdjrfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26081/Mon Feb 15 13:19:24 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/16/21 12:30 AM, KP Singh wrote:
> On Mon, Feb 15, 2021 at 11:42 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>>
> 
> [...]
> 
>>>>> How does the situation look on other archs when they need to
>>>>> implement this in future?
>>>>> Mainly asking whether it would be better to instead to move this
>>>>> logic into the verifier
>>>>> instead, so it'll be consistent across all archs.
>>>>
>>>> I have exactly the same check in my s390 wip patch.
>>>> So having a common solution would be great.
>>>
>>> We do rewrites for various cases like div/mod handling, perhaps would
>>> be
>>> best to emit an explicit BPF_MOV32_REG(insn->dst_reg, insn->dst_reg)
>>> there,
>>> see the fixup_bpf_calls().
> 
> Agreed, this would be better.
> 
>>
>> How about BPF_ZEXT_REG? Then arches that don't need this (I think
>> aarch64's instruction always zero-extends) can detect this using
>> insn_is_zext() and skip such insns.
>>
> 
> +1

That would be nicer indeed.

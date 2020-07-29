Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DBB2326BE
	for <lists+bpf@lfdr.de>; Wed, 29 Jul 2020 23:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgG2V3s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jul 2020 17:29:48 -0400
Received: from www62.your-server.de ([213.133.104.62]:39626 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2V3s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jul 2020 17:29:48 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k0tdw-0006LB-BM; Wed, 29 Jul 2020 23:29:44 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k0tdw-000LCe-1p; Wed, 29 Jul 2020 23:29:44 +0200
Subject: Re: [PATCH bpf-next 1/1] arm64: bpf: Add BPF exception tables
To:     Song Liu <song@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, bpf <bpf@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, zlim.lnx@gmail.com,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
References: <20200728152122.1292756-1-jean-philippe@linaro.org>
 <20200728152122.1292756-2-jean-philippe@linaro.org>
 <CAPhsuW5CmQzELjc8+tQVWZStjPxENhGB7066YJLp=ANs8BYiHA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4791872a-9f7e-1c1c-392c-8b68a13091e3@iogearbox.net>
Date:   Wed, 29 Jul 2020 23:29:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5CmQzELjc8+tQVWZStjPxENhGB7066YJLp=ANs8BYiHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25888/Wed Jul 29 16:57:45 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/29/20 7:28 PM, Song Liu wrote:
> On Tue, Jul 28, 2020 at 8:37 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
>>
>> When a tracing BPF program attempts to read memory without using the
>> bpf_probe_read() helper, the verifier marks the load instruction with
>> the BPF_PROBE_MEM flag. Since the arm64 JIT does not currently recognize
>> this flag it falls back to the interpreter.
>>
>> Add support for BPF_PROBE_MEM, by appending an exception table to the
>> BPF program. If the load instruction causes a data abort, the fixup
>> infrastructure finds the exception table and fixes up the fault, by
>> clearing the destination register and jumping over the faulting
>> instruction.
>>
>> To keep the compact exception table entry format, inspect the pc in
>> fixup_exception(). A more generic solution would add a "handler" field
>> to the table entry, like on x86 and s390.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> This patch looks good to me.
> 
> Acked-by: Song Liu <songliubraving@fb.com>

+1, applied, thanks a lot!

> It is possible to add a selftest for this? I thought about this a
> little bit, but
> didn't get a good idea.

Why not adding a test_verifier.c test case which calls into bpf_get_current_task()
to fetch pointer to current and then read out some field via BPF_PROBE_MEM which
should then succeed on x86/s390x/arm64 but be skipped on the other archs? Jean-Philippe,
could you look into following up with such test case(s)?

Thanks,
Daniel

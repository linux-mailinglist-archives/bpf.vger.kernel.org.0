Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AA43E8547
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 23:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhHJVaj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 17:30:39 -0400
Received: from www62.your-server.de ([213.133.104.62]:57152 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbhHJV3k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Aug 2021 17:29:40 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDZIm-000FYZ-OE; Tue, 10 Aug 2021 23:28:53 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDZIm-0008HB-HR; Tue, 10 Aug 2021 23:28:48 +0200
Subject: Re: [PATCH v2 bpf-next 5/5] Record all failed tests and output after
 the summary line.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, sunyucong@gmail.com
References: <20210810001625.1140255-1-fallentree@fb.com>
 <20210810001625.1140255-6-fallentree@fb.com>
 <1c6e9434-4bd4-ebf1-9ea9-f4439c8974be@iogearbox.net>
 <CAEf4BzY0=e6PrJGsaOgutWmH=JRvmROv8x7BOVXTKNjj0CbcCg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4ee0da63-a8e2-3308-0e07-952e7824080e@iogearbox.net>
Date:   Tue, 10 Aug 2021 23:28:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4BzY0=e6PrJGsaOgutWmH=JRvmROv8x7BOVXTKNjj0CbcCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26259/Tue Aug 10 10:19:56 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/10/21 6:25 PM, Andrii Nakryiko wrote:
> On Tue, Aug 10, 2021 at 4:23 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 8/10/21 2:16 AM, Yucong Sun wrote:
>>> This patch records all failed tests and subtests during the run, output
>>> them after the summary line, making it easier to identify failed tests
>>> in the long output.
>>>
>>> Signed-off-by: Yucong Sun <fallentree@fb.com>
>>
>> nit: please prefix all $subjects with e.g. 'bpf, selftests:'. for example, here should
>> be 'bpf, selftests: Record all failed tests and output after the summary line' so it's
>> more clear in the git log which subsystem is meant.
> 
> Thank, Daniel, for catching this!
> 
> We've more or less consistently used these prefixes (with the emphasis
> on "more or less", of course):
> 
> 1. 'bpf:', for BPF-related kernel proper patches
> 2. 'libbpf:', for libbpf patches
> 3. 'selftests/bpf:'. for BPF selftests
> 4. 'bpftool:', for bpftool-specific patches
> 5. 'samples/bpf', for, you guessed it, samples/bpf :)
> 
> I don't know how much value it is to record this convention in our
> docs Q&A doc, but it's worth keeping this convention consistent.

Agree, it somewhat evolved into these 5 main areas above. Might be worth putting
a note into q&a doc or at least tweak $subject line while applying if it's too
far off. :)

> Haven't checked the logic of this patch yet, but thought I'll comment
> on this convention (and a minor styling nit below).

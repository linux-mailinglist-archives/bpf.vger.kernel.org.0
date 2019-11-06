Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C89F224A
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 00:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfKFXIF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Nov 2019 18:08:05 -0500
Received: from www62.your-server.de ([213.133.104.62]:35112 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfKFXIF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Nov 2019 18:08:05 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iSUP9-0000W7-Oi; Thu, 07 Nov 2019 00:07:59 +0100
Received: from [178.197.248.39] (helo=pc-63.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iSUP9-000OX5-FQ; Thu, 07 Nov 2019 00:07:59 +0100
Subject: Re: [RFC PATCH bpf-next] bpf: allow JIT debugging if
 CONFIG_BPF_JIT_ALWAYS_ON is set
To:     John Fastabend <john.fastabend@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20191106161204.87261-1-iii@linux.ibm.com>
 <CAADnVQ+jOo61VoOp+CDAW7k+GnacgEB8Kge-4JsDBaF25sVhWA@mail.gmail.com>
 <10A60D54-07EB-4B5D-AD3B-59C6D8D7CF9D@linux.ibm.com>
 <5dc2f9cbb002d_23152aba75b6a5bcfd@john-XPS-13-9370.notmuch>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2d4334ad-545d-13b6-224a-14420e1da4c0@iogearbox.net>
Date:   Thu, 7 Nov 2019 00:07:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5dc2f9cbb002d_23152aba75b6a5bcfd@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25625/Wed Nov  6 10:44:04 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/6/19 5:50 PM, John Fastabend wrote:
> Ilya Leoshkevich wrote:
>>> Am 06.11.2019 um 17:15 schrieb Alexei Starovoitov <alexei.starovoitov@gmail.com>:
>>> On Wed, Nov 6, 2019 at 8:12 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>>>>
>>>> Currently it's not possible to set bpf_jit_enable = 2 when
>>>> CONFIG_BPF_JIT_ALWAYS_ON is set, which makes debugging certain problems
>>>> harder.
>>>
>>> This is obsolete way of debugging.
>>> Please use bpftool dump jited instead.
>>
>> Is there a way to integrate bpftool nicely with e.g. test_verifier?
>> With bpf_jit_enable = 2, I can see JITed code for each test right away,
>> without pausing it (via gdb or rebuilding with added sleep()) and
>> running bpftool.
> 
> On the library side we can set the log_level causing the verifier logic
> steps to be printed. I guess adding it to bpftool might be nice. At least
> I would find it useful. I'll probably get to it sometime if its not
> already there somewhere and/or someone doesn't beat me to it.

+1

Was wondering whether it may be worth it moving parts of the logic from bpftool
into libbpf wrt jit dump as a higher level api, so it could be used directly for
checking out the jit disasm + opcodes for specific tests given we have the fd
there as well, but that might be too specific perhaps and would bring one more
lib dependency to libbpf for a rather narrow use case. Adding sleep before prog
fd close and/or shelling out to bpftool etc all is a crude temporary hack as
well (currently using something long these lines locally). Would it make sense
to dump some meta data and generated opcodes per test case to a file as opt-in
e.g. ./test_verifier 711 --dump produces 711.opcodes out of bpf_obj_get_info_by_fd()
which then bpftool could dump this artifact through its own disasm?

Thanks,
Daniel

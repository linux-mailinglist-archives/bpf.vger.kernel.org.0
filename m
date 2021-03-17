Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2BB33F624
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 18:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhCQQ7y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 12:59:54 -0400
Received: from www62.your-server.de ([213.133.104.62]:43806 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhCQQ7w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Mar 2021 12:59:52 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lMZWQ-0008vr-LU; Wed, 17 Mar 2021 17:59:50 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lMZWQ-000HRk-Fg; Wed, 17 Mar 2021 17:59:50 +0100
Subject: Re: [PATCH bpf-next v2] bpf: net: emit anonymous enum with
 BPF_TCP_CLOSE value explicitly
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20210317042906.1011232-1-yhs@fb.com>
 <CAADnVQLY1ftbZxFqAMSN4amWoYZN0ka3DyVLXAWhgsTO7V9V+Q@mail.gmail.com>
 <58a10cec-180b-d8d5-e1d3-de9b695a8878@fb.com>
 <CAADnVQ+hUjX-Hk9=9X+=ii1SusfsZJrsxXUn4krH1bUvNjuVRg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c768692d-5a61-df68-a89a-b7ba64b5c188@iogearbox.net>
Date:   Wed, 17 Mar 2021 17:59:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+hUjX-Hk9=9X+=ii1SusfsZJrsxXUn4krH1bUvNjuVRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26111/Wed Mar 17 12:08:39 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/17/21 5:45 PM, Alexei Starovoitov wrote:
> On Tue, Mar 16, 2021 at 10:58 PM Yonghong Song <yhs@fb.com> wrote:
>> On 3/16/21 10:44 PM, Alexei Starovoitov wrote:
>>> On Tue, Mar 16, 2021 at 9:29 PM Yonghong Song <yhs@fb.com> wrote:
>>>> +       BTF_TYPE_EMIT_ENUM(BPF_TCP_ESTABLISHED);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +late_initcall(bpf_emit_btf_type);
>>>
>>> I think if we burn a dummy function on this it would be a wrong
>>> pattern to follow.
>>
>> Maybe we can pick another initcall to piggyback?
>>
>>> This is just a nop C statement.
>>> Typically we add BUILD_BUG_ON near the places that rely on that constraint.
>>> There is such a function already. It's tcp_set_state() as you pointed out.
>>> It's not using BTF of course, but I would move above BTF_TYPE_EMIT_ENUM there.
>>> I'm not sure why you're calling it "pollute net/ipv4/tcp.c".
>>
>> This is the minor reason. I first coded in that place and feel awkward
>> where we have macro referenced above and we still emit a BTF_TYPE_EMIT
>> below although with some comments.
>>
>> The major reason is I think we may have some uapi type/enum's (e.g., in
>> uapi/linux/bpf.h) which will be used in bpf program but not in kernel
>> itself. So we cannot generate types in vmlinux btf because of this. So I
>> used this case to find a place to generate these btf types.
>> BPF_TCP_CLOSE is actually such an example, it happens we have a
>> BUILD_BUG_ON in kernel to access it.
>> Maybe I am too forward looking?
> 
> It's great to be forward looking :)
> I'm just having a hard time justifying an empty function with single 'ret' insn
> that actually will be called at init time and it will stay empty like this for
> foreseeable future. Static analysis tools and whatnot will start sending
> patches to remove that empty function.

+1, even empty function exported as symbol for modules (to avoid compiler
optimization) might be better than initcall, imho.

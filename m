Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F0F2F1794
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 15:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbhAKOHp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 09:07:45 -0500
Received: from www62.your-server.de ([213.133.104.62]:40704 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbhAKOHo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 09:07:44 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kyxqW-000Fxo-Tv; Mon, 11 Jan 2021 15:07:00 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kyxqW-0009t5-My; Mon, 11 Jan 2021 15:07:00 +0100
Subject: Re: [PATCH bpf] bpf: local storage helpers should check nullness of
 owner ptr passed
To:     KP Singh <kpsingh@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Gilad Reti <gilad.reti@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
References: <20210107173729.2667975-1-kpsingh@kernel.org>
 <CAEf4BzbxVtR+kaTFyHiH0tz3npr_vnpOidmG=t4sQAtaNE95UA@mail.gmail.com>
 <CAEf4BzYjSYBTocYAWv1FDiyRFTmy_XqcE-DvZfZw5K2qoL9Z+Q@mail.gmail.com>
 <CACYkzJ7OCLAfg2OAnvpvexHpaQ8MzntibE79Gf18V++Nc1O0PA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <281d55ae-984d-5a40-e0be-3a3480564379@iogearbox.net>
Date:   Mon, 11 Jan 2021 15:06:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACYkzJ7OCLAfg2OAnvpvexHpaQ8MzntibE79Gf18V++Nc1O0PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26046/Mon Jan 11 13:34:14 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/7/21 9:25 PM, KP Singh wrote:
> On Thu, Jan 7, 2021 at 8:15 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> On Thu, Jan 7, 2021 at 11:07 AM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>>> On Thu, Jan 7, 2021 at 9:37 AM KP Singh <kpsingh@kernel.org> wrote:
>>>>
>>>> The verifier allows ARG_PTR_TO_BTF_ID helper arguments to be NULL, so
>>>> helper implementations need to check this before dereferencing them.
>>>> This was already fixed for the socket storage helpers but not for task
>>>> and inode.
>>>>
>>>> The issue can be reproduced by attaching an LSM program to
>>>> inode_rename hook (called when moving files) which tries to get the
>>>> inode of the new file without checking for its nullness and then trying
>>>> to move an existing file to a new path:
>>>>
>>>>    mv existing_file new_file_does_not_exist
>>>
>>> Seems like it's simple to write a selftest for this then?
> 
> Sure, I will send in a separate patch for selftest and also for the typo.

If it's small or trivial to add a selftest for the fix, I'd suggest to add it
as part of this series for 'ease of logistics' as it would otherwise be a bit
odd to i) either have a stand-alone patch against bpf tree with just a selftest
or ii) having to wait until bpf syncs into bpf-next and then send one against
bpf-next where for the latter there's risk that it gets forgotten in meantime
as it might take a while.

Thanks,
Daniel

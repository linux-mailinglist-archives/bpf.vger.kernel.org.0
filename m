Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9100F217BED
	for <lists+bpf@lfdr.de>; Wed,  8 Jul 2020 01:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgGGX4m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jul 2020 19:56:42 -0400
Received: from www62.your-server.de ([213.133.104.62]:44540 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729316AbgGGX4m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jul 2020 19:56:42 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jsxRs-0008LV-4Z; Wed, 08 Jul 2020 01:56:28 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jsxRr-000HTb-V0; Wed, 08 Jul 2020 01:56:27 +0200
Subject: Re: [PATCH bpf-next v4 1/4] bpf: add BPF_CGROUP_INET_SOCK_RELEASE
 hook
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>
References: <20200706230128.4073544-1-sdf@google.com>
 <20200706230128.4073544-2-sdf@google.com>
 <CAEf4Bzb=vHUC2dgxNEE2fvCZrk9+crmZAp+6kb5U1wLF293cHQ@mail.gmail.com>
 <073ac0af-5de7-0a61-4e11-e4ca292f6456@iogearbox.net>
 <CAKH8qBujza3yn0+YXTV6zg7csWLUaA7RxEiompE5yz4QJsULoA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0f640b14-907a-7e44-9499-6c0e7f92358c@iogearbox.net>
Date:   Wed, 8 Jul 2020 01:56:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAKH8qBujza3yn0+YXTV6zg7csWLUaA7RxEiompE5yz4QJsULoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25866/Tue Jul  7 15:47:52 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/8/20 1:43 AM, Stanislav Fomichev wrote:
> On Tue, Jul 7, 2020 at 2:42 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 7/7/20 1:42 AM, Andrii Nakryiko wrote:
>>> On Mon, Jul 6, 2020 at 4:02 PM Stanislav Fomichev <sdf@google.com> wrote:
>>>>
>>>> Implement BPF_CGROUP_INET_SOCK_RELEASE hook that triggers
>>>> on inet socket release. It triggers only for userspace
>>>> sockets, the same semantics as existing BPF_CGROUP_INET_SOCK_CREATE.
>>>>
>>>> The only questionable part here is the sock->sk check
>>>> in the inet_release. Looking at the places where we
>>>> do 'sock->sk = NULL', I don't understand how it can race
>>>> with inet_release and why the check is there (it's been
>>>> there since the initial git import). Otherwise, the
>>>> change itself is pretty simple, we add a BPF hook
>>>> to the inet_release and avoid calling it for kernel
>>>> sockets.
>>>>
>>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
>>>> ---
>>>>    include/linux/bpf-cgroup.h | 4 ++++
>>>>    include/uapi/linux/bpf.h   | 1 +
>>>>    kernel/bpf/syscall.c       | 3 +++
>>>>    net/core/filter.c          | 1 +
>>>>    net/ipv4/af_inet.c         | 3 +++
>>>>    5 files changed, 12 insertions(+)
>>>>
>>>
>>> Looks good overall, but I have no idea about sock->sk NULL case.
>>
>> +1, looks good & very useful hook. For the sock->sk NULL case here's a related
>> discussion on why it's needed [0].
> Thanks for the pointer! I'll resend a v5 with s/sock/sock_create/ you
> mentioned and will clean up the commit description a bit.

Already fixed up the selftest and a typo in the commit desc there & applied it. Let
me know if you prefer a respin though and I can toss it taking the respin which would
work just as well. :)

Thanks,
Daniel

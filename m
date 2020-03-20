Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC73018D952
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 21:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgCTUaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Mar 2020 16:30:22 -0400
Received: from www62.your-server.de ([213.133.104.62]:42446 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCTUaW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Mar 2020 16:30:22 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jFOHW-0000Nl-5N; Fri, 20 Mar 2020 21:30:14 +0100
Received: from [85.7.42.192] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jFOHV-000BXR-Mz; Fri, 20 Mar 2020 21:30:13 +0100
Subject: Re: [PATCH bpf-next 1/4] xdp: Support specifying expected existing
 program when attaching XDP
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <158462359206.164779.15902346296781033076.stgit@toke.dk>
 <158462359315.164779.13931660750493121404.stgit@toke.dk>
 <20200319155236.3d8537c5@kicinski-fedora-PC1C0HJN> <875zez76ph.fsf@toke.dk>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ad09e018-377f-9864-60eb-cf4291f49d41@iogearbox.net>
Date:   Fri, 20 Mar 2020 21:30:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <875zez76ph.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25757/Fri Mar 20 14:13:59 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/20/20 9:48 AM, Toke Høiland-Jørgensen wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
>> On Thu, 19 Mar 2020 14:13:13 +0100 Toke Høiland-Jørgensen wrote:
>>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>>>
>>> While it is currently possible for userspace to specify that an existing
>>> XDP program should not be replaced when attaching to an interface, there is
>>> no mechanism to safely replace a specific XDP program with another.
>>>
>>> This patch adds a new netlink attribute, IFLA_XDP_EXPECTED_FD, which can be
>>> set along with IFLA_XDP_FD. If set, the kernel will check that the program
>>> currently loaded on the interface matches the expected one, and fail the
>>> operation if it does not. This corresponds to a 'cmpxchg' memory operation.
>>>
>>> A new companion flag, XDP_FLAGS_EXPECT_FD, is also added to explicitly
>>> request checking of the EXPECTED_FD attribute. This is needed for userspace
>>> to discover whether the kernel supports the new attribute.
>>>
>>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>
>> I didn't know we wanted to go ahead with this...
> 
> Well, I'm aware of the bpf_link discussion, obviously. Not sure what's
> happening with that, though. So since this is a straight-forward
> extension of the existing API, that doesn't carry a high implementation
> cost, I figured I'd just go ahead with this. Doesn't mean we can't have
> something similar in bpf_link as well, of course.

Overall series looks okay, but before we go down that road, especially given there is
the new bpf_link object now, I would like us to first elaborate and figure out how XDP
fits into the bpf_link concept, where its limitations are, whether it even fits at all,
and how its semantics should look like realistically given bpf_link is to be generic to
all program types. Then we could extend the atomic replace there generically as well. I
think at the very minimum it might have similarities with what is proposed here, but
from a user experience I would like to avoid having something similar in XDP API and
then again in bpf_link which would just be confusing..

Thanks,
Daniel

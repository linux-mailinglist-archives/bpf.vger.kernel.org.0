Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2111D37D69
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 21:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfFFTnK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 15:43:10 -0400
Received: from www62.your-server.de ([213.133.104.62]:48902 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfFFTnK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 15:43:10 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hYyEa-0002Jo-GE; Thu, 06 Jun 2019 21:39:36 +0200
Received: from [178.197.249.21] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hYyEa-000LVN-A7; Thu, 06 Jun 2019 21:39:36 +0200
Subject: Re: [PATCH bpf-next] bpf: allow CGROUP_SKB programs to use
 bpf_get_current_cgroup_id() helper
To:     Roman Gushchin <guro@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
References: <20190606185911.4089151-1-guro@fb.com>
 <20190606190752.GA28743@tower.DHCP.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a604b9eb-4e39-c4ec-0868-bac360bc2fb4@iogearbox.net>
Date:   Thu, 6 Jun 2019 21:39:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190606190752.GA28743@tower.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25472/Thu Jun  6 10:09:59 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/06/2019 09:08 PM, Roman Gushchin wrote:
> On Thu, Jun 06, 2019 at 11:59:11AM -0700, Roman Gushchin wrote:
>> Currently bpf_get_current_cgroup_id() is not supported for
>> CGROUP_SKB programs. An attempt to load such a program generates an
>> error like this:
>>     libbpf:
>>     0: (b7) r6 = 0
>>     ...
>>     8: (63) *(u32 *)(r10 -28) = r6
>>     9: (85) call bpf_get_current_cgroup_id#80
>>     unknown func bpf_get_current_cgroup_id#80
>>
>> There are no particular reasons for denying it,
>> and we have some use cases where it might be useful.
> 
> Ah, sorry, it's not so simple, as we probably need to take
> the cgroup pointer from the socket, not from current.
> 
> So the implementation of the helper should be different
> for this type of programs.
> 
> So I wonder if it's better to introduce a new helper
> bpf_get_sock_cgroup_id()?
> 
> What do you think?

We do have bpf_skb_cgroup_id(), did you give that a try?

Thanks,
Daniel

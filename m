Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF342876B9
	for <lists+bpf@lfdr.de>; Thu,  8 Oct 2020 17:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbgJHPIs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Oct 2020 11:08:48 -0400
Received: from www62.your-server.de ([213.133.104.62]:36928 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730854AbgJHPIr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Oct 2020 11:08:47 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kQXX9-0008Fp-NI; Thu, 08 Oct 2020 17:08:43 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kQXX9-000GNz-HO; Thu, 08 Oct 2020 17:08:43 +0200
Subject: Re: [PATCH bpf-next] bpf_fib_lookup: return target ifindex even if
 neighbour lookup fails
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        ast@fb.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
References: <20201008145314.116800-1-toke@redhat.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bf190e76-b178-d915-8d0d-811905d38fd2@iogearbox.net>
Date:   Thu, 8 Oct 2020 17:08:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20201008145314.116800-1-toke@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25951/Thu Oct  8 15:53:03 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/8/20 4:53 PM, Toke Høiland-Jørgensen wrote:
> The bpf_fib_lookup() helper performs a neighbour lookup for the destination
> IP and returns BPF_FIB_LKUP_NO_NEIGH if this fails, with the expectation
> that the BPF program will pass the packet up the stack in this case.
> However, with the addition of bpf_redirect_neigh() that can be used instead
> to perform the neighbour lookup.
> 
> However, for that we still need the target ifindex, and since
> bpf_fib_lookup() already has that at the time it performs the neighbour
> lookup, there is really no reason why it can't just return it in any case.
> With this fix, a BPF program can do the following to perform a redirect
> based on the routing table that will succeed even if there is no neighbour
> entry:
> 
> 	ret = bpf_fib_lookup(skb, &fib_params, sizeof(fib_params), 0);
> 	if (ret == BPF_FIB_LKUP_RET_SUCCESS) {
> 		__builtin_memcpy(eth->h_dest, fib_params.dmac, ETH_ALEN);
> 		__builtin_memcpy(eth->h_source, fib_params.smac, ETH_ALEN);
> 
> 		return bpf_redirect(fib_params.ifindex, 0);
> 	} else if (ret == BPF_FIB_LKUP_RET_NO_NEIGH) {
> 		return bpf_redirect_neigh(fib_params.ifindex, 0);
> 	}
> 
> Cc: David Ahern <dsahern@gmail.com>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

ACK, this looks super useful! Could you also add a new flag which would skip
neighbor lookup in the helper while at it (follow-up would be totally fine from
my pov since both are independent from each other)?

Thanks,
Daniel

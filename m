Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C2246405B
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 22:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhK3Vnq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Nov 2021 16:43:46 -0500
Received: from www62.your-server.de ([213.133.104.62]:38320 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbhK3Vnp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Nov 2021 16:43:45 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1msArK-000FUV-Ek; Tue, 30 Nov 2021 22:40:18 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1msArK-00081w-3U; Tue, 30 Nov 2021 22:40:18 +0100
Subject: Re: [PATCH bpf] bpf: Fix the off-by-two error in range markings
To:     Maxim Mikityanskiy <maximmi@nvidia.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20211130181607.593149-1-maximmi@nvidia.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3c3512be-91c3-5caf-7e88-155f923404e8@iogearbox.net>
Date:   Tue, 30 Nov 2021 22:40:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20211130181607.593149-1-maximmi@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26369/Tue Nov 30 10:18:45 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/30/21 7:16 PM, Maxim Mikityanskiy wrote:
> The first commit cited below attempts to fix the off-by-one error that
> appeared in some comparisons with an open range. Due to this error,
> arithmetically equivalent pieces of code could get different verdicts
> from the verifier, for example (pseudocode):
> 
>    // 1. Passes the verifier:
>    if (data + 8 > data_end)
>        return early
>    read *(u64 *)data, i.e. [data; data+7]
> 
>    // 2. Rejected by the verifier (should still pass):
>    if (data + 7 >= data_end)
>        return early
>    read *(u64 *)data, i.e. [data; data+7]
> 
> The attempted fix, however, shifts the range by one in a wrong
> direction, so the bug not only remains, but also such piece of code
> starts failing in the verifier:
> 
>    // 3. Rejected by the verifier, but the check is stricter than in #1.
>    if (data + 8 >= data_end)
>        return early
>    read *(u64 *)data, i.e. [data; data+7]
> 
> The change performed by that fix converted an off-by-one bug into
> off-by-two. The second commit cited below added the BPF selftests
> written to ensure than code chunks like #3 are rejected, however,
> they should be accepted.
> 
> This commit fixes the off-by-two error by adjusting new_range in the
> right direction and fixes the tests by changing the range into the one
> that should actually fail.
> 
> Fixes: fb2a311a31d3 ("bpf: fix off by one for range markings with L{T, E} patterns")
> Fixes: b37242c773b2 ("bpf: add test cases to bpf selftests to cover all access tests")
> Signed-off-by: Maxim Mikityanskiy <maximmi@nvidia.com>
> ---
> After this patch is merged, I'm going to submit another patch to
> bpf-next, that will add new selftests for this bug.

Thanks for the fix, pls post the selftests for bpf tree; it's okay to route
them via bpf so they can go via CI for both trees eventually.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824D931E20E
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 23:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhBQW2W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 17:28:22 -0500
Received: from www62.your-server.de ([213.133.104.62]:47188 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhBQW2U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 17:28:20 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lCVII-0003pX-V7; Wed, 17 Feb 2021 23:27:38 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lCVII-000FMT-5D; Wed, 17 Feb 2021 23:27:38 +0100
Subject: Re: [PATCH v2 bpf-next] bpf: x86: Fix BPF_FETCH atomic and/or/xor
 with r0 as src
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
References: <20210216125307.1406237-1-jackmanb@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d7befe74-f340-2b3d-1ea4-05cc21b8dc4e@iogearbox.net>
Date:   Wed, 17 Feb 2021 23:27:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210216125307.1406237-1-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26083/Wed Feb 17 13:11:33 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/16/21 1:53 PM, Brendan Jackman wrote:
> This code generates a CMPXCHG loop in order to implement atomic_fetch
> bitwise operations. Because CMPXCHG is hard-coded to use rax (which
> holds the BPF r0 value), it saves the _real_ r0 value into the
> internal "ax" temporary register and restores it once the loop is
> complete.
> 
> In the middle of the loop, the actual bitwise operation is performed
> using src_reg. The bug occurs when src_reg is r0: as described above,
> r0 has been clobbered and the real r0 value is in the ax register.
> 
> Therefore, perform this operation on the ax register instead, when
> src_reg is r0.
> 
> Fixes: 981f94c3e921 ("bpf: Add bitwise atomic instructions")
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Applied, thanks!

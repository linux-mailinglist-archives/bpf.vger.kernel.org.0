Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFDB3EA3FE
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 13:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbhHLLrb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Aug 2021 07:47:31 -0400
Received: from www62.your-server.de ([213.133.104.62]:53010 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbhHLLra (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Aug 2021 07:47:30 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mE9As-0007T9-6D; Thu, 12 Aug 2021 13:47:02 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mE9Ar-000NuU-Uo; Thu, 12 Aug 2021 13:47:02 +0200
Subject: Re: [PATCH bpf-next] bpf: Clear zext_dst of dead insns
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210812111220.181824-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c98de343-2195-8c9d-2cea-32d17e3c78c7@iogearbox.net>
Date:   Thu, 12 Aug 2021 13:47:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210812111220.181824-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26261/Thu Aug 12 10:22:34 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey Ilya,

On 8/12/21 1:12 PM, Ilya Leoshkevich wrote:
> "access skb fields ok" verifier test fails on s390 with the "verifier
> bug. zext_dst is set, but no reg is defined" message. The first insns
> of the test prog are:
> 
>     0:	61 01 00 00 00 00 00 00 	ldxw %r0,[%r1+0]
>     8:	35 00 00 01 00 00 00 00 	jge %r0,0,1
>    10:	61 01 00 08 00 00 00 00 	ldxw %r0,[%r1+8]
> 
> and the 3rd one is dead (this does not look intentional to me, but this
> is a separate topic).
> 
> sanitize_dead_code() converts dead insns into "ja -1", but keeps
> zext_dst. When opt_subreg_zext_lo32_rnd_hi32() tries to parse such
> an insn, it sees this discrepancy and bails. This problem can be seen
> only with JITs whose bpf_jit_needs_zext() returns true.
> 
> Fix by clearning dead insns' zext_dst.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

I presume this would rather be bpf tree material, no? Do you also have a
Fixes tag I could add?

And one last small request: if this is not already covered by test_verifier
selftest, could you add one along with the fix?

Thanks a lot,
Daniel

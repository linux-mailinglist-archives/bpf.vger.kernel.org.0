Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B175CA40FA
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2019 01:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfH3XWL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Aug 2019 19:22:11 -0400
Received: from www62.your-server.de ([213.133.104.62]:58600 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfH3XWK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Aug 2019 19:22:10 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i3qDY-0004Ds-Uq; Sat, 31 Aug 2019 01:22:09 +0200
Received: from [178.197.249.19] (helo=pc-63.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i3qDY-000Enp-NW; Sat, 31 Aug 2019 01:22:08 +0200
Subject: Re: [PATCH v3] bpf: s390: add JIT support for multi-function programs
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>, bpf@vger.kernel.org
Cc:     iii@linux.ibm.com, jolsa@redhat.com
References: <20190826182036.17456-1-yauheni.kaliuta@redhat.com>
 <20190828182846.10473-1-yauheni.kaliuta@redhat.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f5ecc32b-b72f-df15-000e-3b2bf35192d0@iogearbox.net>
Date:   Sat, 31 Aug 2019 01:22:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190828182846.10473-1-yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25557/Fri Aug 30 10:30:29 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/28/19 8:28 PM, Yauheni Kaliuta wrote:
> This adds support for bpf-to-bpf function calls in the s390 JIT
> compiler. The JIT compiler converts the bpf call instructions to
> native branch instructions. After a round of the usual passes, the
> start addresses of the JITed images for the callee functions are
> known. Finally, to fixup the branch target addresses, we need to
> perform an extra pass.
> 
> Because of the address range in which JITed images are allocated on
> s390, the offsets of the start addresses of these images from
> __bpf_call_base are as large as 64 bits. So, for a function call,
> the imm field of the instruction cannot be used to determine the
> callee's address. Use bpf_jit_get_func_addr() helper instead.
> 
> The patch borrows a lot from:
> 
> commit 8c11ea5ce13d ("bpf, arm64: fix getting subprog addr from aux
> for calls")
> 
> commit e2c95a61656d ("bpf, ppc64: generalize fetching subprog into
> bpf_jit_get_func_addr")
> 
> commit 8484ce8306f9 ("bpf: powerpc64: add JIT support for
> multi-function programs")
> 
> (including the commit message).
> 
> test_verifier (5.3-rc6 with CONFIG_BPF_JIT_ALWAYS_ON=y):
> 
> without patch:
> Summary: 1501 PASSED, 0 SKIPPED, 47 FAILED
> 
> with patch:
> Summary: 1540 PASSED, 0 SKIPPED, 8 FAILED
> 
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>

Applied, thanks!

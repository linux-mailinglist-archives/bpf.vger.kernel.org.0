Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64AC78BB2F
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2019 16:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfHMOI4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Aug 2019 10:08:56 -0400
Received: from www62.your-server.de ([213.133.104.62]:39112 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfHMOI4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Aug 2019 10:08:56 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hxXTo-0003dA-Ak; Tue, 13 Aug 2019 16:08:52 +0200
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=pc-66.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hxXTo-000Qxi-3J; Tue, 13 Aug 2019 16:08:52 +0200
Subject: Re: [PATCH bpf] s390/bpf: use 32-bit index for tail calls
To:     Ilya Leoshkevich <iii@linux.ibm.com>, ast@kernel.org
Cc:     bpf@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
References: <20190812161807.1400-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ec7cc1e0-8062-be37-cc9e-30e36f160d08@iogearbox.net>
Date:   Tue, 13 Aug 2019 16:08:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190812161807.1400-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25540/Tue Aug 13 10:16:47 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/12/19 6:18 PM, Ilya Leoshkevich wrote:
> "p runtime/jit: pass > 32bit index to tail_call" fails when
> bpf_jit_enable=1, because the tail call is not executed.
> 
> This in turn is because the generated code assumes index is 64-bit,
> while it must be 32-bit, and as a result prog array bounds check fails,
> while it should pass. Even if bounds check would have passed, the code
> that follows uses 64-bit index to compute prog array offset.
> 
> Fix by using clrj instead of clgrj for comparing index with array size,
> and also by using llgfr for truncating index to 32 bits before using it
> to compute prog array offset.
> 
> Fixes: 6651ee070b31 ("s390/bpf: implement bpf_tail_call() helper")
> Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> Acked-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied, thanks!

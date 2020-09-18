Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CDE270910
	for <lists+bpf@lfdr.de>; Sat, 19 Sep 2020 01:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgIRXJ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Sep 2020 19:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgIRXJ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Sep 2020 19:09:29 -0400
X-Greylist: delayed 73 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Sep 2020 16:09:29 PDT
Received: from www62.your-server.de (www62.your-server.de [IPv6:2a01:4f8:d0a:276a::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422D5C0613CE
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2020 16:09:29 -0700 (PDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kJPVN-00050r-Ki; Sat, 19 Sep 2020 01:09:25 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kJPVN-0000uh-El; Sat, 19 Sep 2020 01:09:25 +0200
Subject: Re: [PATCH RESEND bpf-next] samples/bpf: Fix test_map_in_map on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Song Liu <song@kernel.org>
References: <20200915115519.3769807-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3882b942-9a44-d7f4-0c9a-9dbaca648d6c@iogearbox.net>
Date:   Sat, 19 Sep 2020 01:09:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200915115519.3769807-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25932/Fri Sep 18 15:48:08 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/15/20 1:55 PM, Ilya Leoshkevich wrote:
> s390 uses socketcall multiplexer instead of individual socket syscalls.
> Therefore, "kprobe/" SYSCALL(sys_connect) does not trigger and
> test_map_in_map fails. Fix by using "kprobe/__sys_connect" instead.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied, thanks!

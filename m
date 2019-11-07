Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB7AF3418
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 17:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfKGQFV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 11:05:21 -0500
Received: from www62.your-server.de ([213.133.104.62]:44058 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbfKGQFV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 11:05:21 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iSkHe-0005xt-Cc; Thu, 07 Nov 2019 17:05:18 +0100
Received: from [178.197.249.41] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iSkHd-0008v5-WE; Thu, 07 Nov 2019 17:05:18 +0100
Subject: Re: [PATCH bpf-next] tools, bpf_asm: warn when jumps are out of range
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20191107100349.88976-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9192a9eb-309a-a42e-4f39-7e5cc3693650@iogearbox.net>
Date:   Thu, 7 Nov 2019 17:05:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191107100349.88976-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25626/Thu Nov  7 10:50:48 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/7/19 11:03 AM, Ilya Leoshkevich wrote:
> When compiling larger programs with bpf_asm, it's possible to
> accidentally exceed jt/jf range, in which case it won't complain, but
> rather silently emit a truncated offset, leading to a "happy debugging"
> situation.
> 
> Add a warning to help detecting such issues. It could be made an error
> instead, but this might break compilation of existing code (which might
> be working by accident).
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

LGTM, applied, thanks!

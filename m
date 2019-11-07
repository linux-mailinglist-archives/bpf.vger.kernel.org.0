Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB410F3424
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 17:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfKGQHk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 11:07:40 -0500
Received: from www62.your-server.de ([213.133.104.62]:44660 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389041AbfKGQHj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 11:07:39 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iSkJs-000671-6o; Thu, 07 Nov 2019 17:07:36 +0100
Received: from [178.197.249.41] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iSkJr-0001Ux-R0; Thu, 07 Nov 2019 17:07:35 +0100
Subject: Re: [PATCH bpf-next] s390/bpf: use kvcalloc for addrs array
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20191107141838.92202-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <34c26e08-bd98-d92a-783f-28f90e4bec11@iogearbox.net>
Date:   Thu, 7 Nov 2019 17:07:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191107141838.92202-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25626/Thu Nov  7 10:50:48 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/7/19 3:18 PM, Ilya Leoshkevich wrote:
> A BPF program may consist of 1m instructions, which means JIT
> instruction-address mapping can be as large as 4m. s390 has
> FORCE_MAX_ZONEORDER=9 (for memory hotplug reasons), which means maximum
> kmalloc size is 1m. This makes it impossible to JIT programs with more
> than 256k instructions.
> 
> Fix by using kvcalloc, which falls back to vmalloc for larger
> allocations. An alternative would be to use a radix tree, but that is
> not supported by bpf_prog_fill_jited_linfo.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Also applied, thanks!

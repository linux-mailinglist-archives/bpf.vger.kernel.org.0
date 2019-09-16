Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF137B3885
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2019 12:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbfIPKo3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Sep 2019 06:44:29 -0400
Received: from www62.your-server.de ([213.133.104.62]:54878 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfIPKo3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 06:44:29 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i9nyJ-0002R6-Rr; Mon, 16 Sep 2019 12:11:03 +0200
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=pc-66.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i9nyJ-000AEQ-LJ; Mon, 16 Sep 2019 12:11:03 +0200
Subject: Re: [PATCH bpf v2] bpf: fix accessing bpf_sysctl.file_pos on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Andrey Ignatov <rdna@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20190816105300.49035-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0e48ebeb-2538-8394-32cb-d4a4aa339cda@iogearbox.net>
Date:   Mon, 16 Sep 2019 12:11:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190816105300.49035-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25574/Mon Sep 16 10:25:07 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/16/19 12:53 PM, Ilya Leoshkevich wrote:
> "ctx:file_pos sysctl:read write ok" fails on s390 with "Read value  !=
> nux". This is because verifier rewrites a complete 32-bit
> bpf_sysctl.file_pos update to a partial update of the first 32 bits of
> 64-bit *bpf_sysctl_kern.ppos, which is not correct on big-endian
> systems.
> 
> Fix by using an offset on big-endian systems.
> 
> Ditto for bpf_sysctl.file_pos reads. Currently the test does not detect
> a problem there, since it expects to see 0, which it gets with high
> probability in error cases, so change it to seek to offset 3 and expect
> 3 in bpf_sysctl.file_pos.
> 
> Fixes: e1550bfe0de4 ("bpf: Add file_pos field to bpf_sysctl ctx")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied, thanks!

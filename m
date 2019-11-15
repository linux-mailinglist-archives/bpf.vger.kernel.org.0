Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63A45FE7C5
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2019 23:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKOW2Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Nov 2019 17:28:16 -0500
Received: from www62.your-server.de ([213.133.104.62]:50588 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfKOW2Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Nov 2019 17:28:16 -0500
Received: from sslproxy01.your-server.de ([88.198.220.130])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iVk4b-0007OR-8j; Fri, 15 Nov 2019 23:28:13 +0100
Received: from [178.197.248.45] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iVk4a-0008Ko-Tk; Fri, 15 Nov 2019 23:28:13 +0100
Subject: Re: [PATCH bpf-next] s390/bpf: make sure JIT passes do not increase
 code size
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20191114151820.53222-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9486776a-a628-dfb4-9d41-726e251bf638@iogearbox.net>
Date:   Fri, 15 Nov 2019 23:28:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191114151820.53222-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25634/Fri Nov 15 10:44:37 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/14/19 4:18 PM, Ilya Leoshkevich wrote:
> The upcoming s390 branch length extension patches rely on "passes do
> not increase code size" property in order to consistently choose between
> short and long branches. Currently this property does not hold between
> the first and the second passes for register save/restore sequences, as
> well as various code fragments that depend on SEEN_* flags.
> 
> Generate the code during the first pass conservatively: assume register
> save/restore sequences have the maximum possible length, and that all
> SEEN_* flags are set.
> 
> Also refuse to JIT if this happens anyway (e.g. due to a bug), as this
> might lead to verifier bypass once long branches are introduced.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied, thanks!

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEF98DF69
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2019 22:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfHNUzY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Aug 2019 16:55:24 -0400
Received: from www62.your-server.de ([213.133.104.62]:40106 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfHNUzY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Aug 2019 16:55:24 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hy0Ih-0003of-7A; Wed, 14 Aug 2019 22:55:19 +0200
Received: from [178.193.45.231] (helo=pc-63.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hy0Ih-000TrX-0B; Wed, 14 Aug 2019 22:55:19 +0200
Subject: Re: [PATCH bpf v2] selftests/bpf: fix "bind{4,6} deny specific IP &
 port" on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20190814104109.22020-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8e14fad6-c8d2-f62d-bfb4-f3d95ddddcd7@iogearbox.net>
Date:   Wed, 14 Aug 2019 22:55:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190814104109.22020-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25541/Wed Aug 14 10:26:08 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/14/19 12:41 PM, Ilya Leoshkevich wrote:
> "bind4 allow specific IP & port" and "bind6 deny specific IP & port"
> fail on s390 because of endianness issue: the 4 IP address bytes are
> loaded as a word and compared with a constant, but the value of this
> constant should be different on big- and little- endian machines, which
> is not the case right now.
> 
> Use __bpf_constant_ntohl to generate proper value based on machine
> endianness.
> 
> Fixes: 1d436885b23b ("selftests/bpf: Selftest for sys_bind post-hooks.")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Looks good, applied, thanks.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A66027091F
	for <lists+bpf@lfdr.de>; Sat, 19 Sep 2020 01:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgIRXTd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Sep 2020 19:19:33 -0400
Received: from www62.your-server.de ([213.133.104.62]:50512 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgIRXTd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Sep 2020 19:19:33 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kJPUA-0004x4-GN; Sat, 19 Sep 2020 01:08:10 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kJPUA-000VsA-Ar; Sat, 19 Sep 2020 01:08:10 +0200
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix endianness issue in
 sk_assign
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <20200915113815.3768217-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2df873b7-e0b9-1eeb-5952-2ee2a46fe315@iogearbox.net>
Date:   Sat, 19 Sep 2020 01:08:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200915113815.3768217-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25932/Fri Sep 18 15:48:08 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/15/20 1:38 PM, Ilya Leoshkevich wrote:
> server_map's value size is 8, but the test tries to put an int there.
> This sort of works on x86 (unless followed by non-0), but hard fails on
> s390.
> 
> Fix by using __s64 instead of int.
> 
> Fixes: 2d7824ffd25c ("selftests: bpf: Add test for sk_assign")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied, thanks!

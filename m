Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A71D97E3D
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2019 17:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfHUPKw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 11:10:52 -0400
Received: from www62.your-server.de ([213.133.104.62]:41754 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbfHUPKw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 11:10:52 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i0SG9-0003RE-AD; Wed, 21 Aug 2019 17:10:49 +0200
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=pc-66.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i0SG9-0000dI-3v; Wed, 21 Aug 2019 17:10:49 +0200
Subject: Re: [PATCH bpf] selftests/bpf: fix test_btf_dump with O=
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20190819123847.67494-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <53e06e6b-e182-c5f1-7526-7311b2458d69@iogearbox.net>
Date:   Wed, 21 Aug 2019 17:10:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190819123847.67494-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25548/Wed Aug 21 10:27:18 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/19/19 2:38 PM, Ilya Leoshkevich wrote:
> test_btf_dump fails when run with O=, because it needs to access source
> files and assumes they live in ./progs/, which is not the case in this
> scenario.
> 
> Fix by instructing kselftest to copy btf_dump_test_case_*.c files to the
> test directory. Since kselftest does not preserve directory structure,
> adjust the test to look in ./progs/ and then in ./.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied, thanks!

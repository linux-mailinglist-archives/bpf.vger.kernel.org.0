Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A11397E39
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2019 17:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfHUPJs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 11:09:48 -0400
Received: from www62.your-server.de ([213.133.104.62]:41398 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfHUPJs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 11:09:48 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i0SF5-0003MO-LE; Wed, 21 Aug 2019 17:09:43 +0200
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=pc-66.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i0SF5-000MxR-EQ; Wed, 21 Aug 2019 17:09:43 +0200
Subject: Re: [PATCH bpf] selftests/bpf: fix test_cgroup_storage on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20190820141804.88799-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <deeb83e8-d33d-9a97-88a9-304a174a1e37@iogearbox.net>
Date:   Wed, 21 Aug 2019 17:09:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190820141804.88799-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25548/Wed Aug 21 10:27:18 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/20/19 4:18 PM, Ilya Leoshkevich wrote:
> test_cgroup_storage fails on s390 with an assertion failure: packets are
> dropped when they shouldn't. The problem is that BPF_DW packet count is
> accessed as BPF_W with an offset of 0, which is not correct on
> big-endian machines.
> 
> Since the point of this test is not to verify narrow loads/stores,
> simply use BPF_DW when working with packet counts.
> 
> Fixes: 68cfa3ac6b8d ("selftests/bpf: add a cgroup storage test")
> Fixes: 919646d2a3a9 ("selftests/bpf: extend the storage test to test per-cpu cgroup storage")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied, thanks!

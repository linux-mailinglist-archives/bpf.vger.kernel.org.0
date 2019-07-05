Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0770D607BF
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2019 16:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfGEOWH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Jul 2019 10:22:07 -0400
Received: from www62.your-server.de ([213.133.104.62]:51766 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfGEOWH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Jul 2019 10:22:07 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hjP6D-00046A-OJ; Fri, 05 Jul 2019 16:22:05 +0200
Received: from [2a02:1205:5069:fce0:c5f9:cd68:79d4:446d] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hjP6D-000NNK-Ey; Fri, 05 Jul 2019 16:22:05 +0200
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: do not ignore clang failures
To:     Ilya Leoshkevich <iii@linux.ibm.com>, bpf@vger.kernel.org,
        liu.song.a23@gmail.com, andrii.nakryiko@gmail.com
References: <CAEf4Bzb3BKoEcYiM3qQ6uqn+bZZ7kO2ogvZPba7679TWFT4fmw@mail.gmail.com>
 <20190701184025.25731-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cc418117-32a7-b7aa-3570-29b1b3421303@iogearbox.net>
Date:   Fri, 5 Jul 2019 16:22:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190701184025.25731-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25501/Fri Jul  5 10:01:52 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/01/2019 08:40 PM, Ilya Leoshkevich wrote:
> Am 01.07.2019 um 17:31 schrieb Andrii Nakryiko <andrii.nakryiko@gmail.com>:
>> Do we still need clang | llc pipeline with new clang? Could the same
>> be achieved with single clang invocation? That would solve the problem
>> of not detecting pipeline failures.
> 
> I’ve experimented with this a little, and found that new clang:
> 
> - Does not understand -march, but -target is sufficient.
> - Understands -mcpu.
> - Understands -Xclang -target-feature -Xclang +foo as a replacement for
>   -mattr=foo.
> 
> However, there are two issues with that:
> 
> - Don’t older clangs need to be supported? For example, right now alu32
>   progs are built conditionally.

We usually require latest clang to be able to test most recent features like
BTF such that it helps to catch potential bugs in either of the projects
before release.

> - It does not seem to be possible to build test_xdp.o without -target
>   bpf.

For everything non-tracing, it does not make sense to invoke clang w/o
the -target bpf flag, see also Documentation/bpf/bpf_devel_QA.rst +573
for more explanation, so this needs to be present for building test_xdp.o.

Thanks,
Daniel

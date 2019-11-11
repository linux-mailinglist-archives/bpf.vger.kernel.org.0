Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE915F7488
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2019 14:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfKKNHi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Nov 2019 08:07:38 -0500
Received: from www62.your-server.de ([213.133.104.62]:48694 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfKKNHh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Nov 2019 08:07:37 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iU9Pr-0003PW-Lo; Mon, 11 Nov 2019 14:07:35 +0100
Received: from [2a02:1205:507e:bf80:bef8:7f66:49c8:72e5] (helo=pc-11.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iU9Pr-000VQK-CH; Mon, 11 Nov 2019 14:07:35 +0100
Subject: Re: [PATCH bpf-next v2] [tools/bpf] workaround a verifier failure for
 test_progs
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@fb.com>, kernel-team@fb.com
References: <20191107170045.2503480-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a9403907-73d4-bd25-6f2d-44be85cd63e0@iogearbox.net>
Date:   Mon, 11 Nov 2019 14:07:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191107170045.2503480-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25630/Mon Nov 11 10:59:49 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/7/19 6:00 PM, Yonghong Song wrote:
> With latest llvm compiler, running test_progs will have
> the following verifier failure for test_sysctl_loop1.o:
>    libbpf: load bpf program failed: Permission denied
>    libbpf: -- BEGIN DUMP LOG ---
>    libbpf:
>    invalid indirect read from stack var_off (0x0; 0xff)+196 size 7
>    ...
>    libbpf: -- END LOG --
>    libbpf: failed to load program 'cgroup/sysctl'
>    libbpf: failed to load object 'test_sysctl_loop1.o'
> 
> The related bytecodes look below:
>    0000000000000308 LBB0_8:
>        97:       r4 = r10
>        98:       r4 += -288
>        99:       r4 += r7
>       100:       w8 &= 255
>       101:       r1 = r10
>       102:       r1 += -488
>       103:       r1 += r8
>       104:       r2 = 7
>       105:       r3 = 0
>       106:       call 106
>       107:       w1 = w0
>       108:       w1 += -1
>       109:       if w1 > 6 goto -24 <LBB0_5>
>       110:       w0 += w8
>       111:       r7 += 8
>       112:       w8 = w0
[...]
Applied, thanks!

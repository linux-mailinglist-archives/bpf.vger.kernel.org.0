Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7A733FAE8
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 23:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCQWTT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 18:19:19 -0400
Received: from www62.your-server.de ([213.133.104.62]:54944 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhCQWSv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Mar 2021 18:18:51 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lMeV7-0004K4-8v; Wed, 17 Mar 2021 23:18:49 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lMeV7-000Rtu-2k; Wed, 17 Mar 2021 23:18:49 +0100
Subject: Re: [PATCH] MIPS/bpf: Enable bpf_probe_read{, str}() on MIPS again
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
References: <1615965307-6926-1-git-send-email-yangtiezhu@loongson.cn>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6b239565-8fbb-d183-6a4d-13fc90af3e27@iogearbox.net>
Date:   Wed, 17 Mar 2021 23:18:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1615965307-6926-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26111/Wed Mar 17 12:08:39 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/17/21 8:15 AM, Tiezhu Yang wrote:
> After commit 0ebeea8ca8a4 ("bpf: Restrict bpf_probe_read{, str}() only to
> archs where they work"), bpf_probe_read{, str}() functions were not longer
> available on MIPS, so there exists some errors when running bpf program:
> 
> root@linux:/home/loongson/bcc# python examples/tracing/task_switch.py
> bpf: Failed to load program: Invalid argument
> [...]
> 11: (85) call bpf_probe_read#4
> unknown func bpf_probe_read#4
> [...]
> Exception: Failed to load BPF program count_sched: Invalid argument
> 
> So select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE in arch/mips/Kconfig,
> otherwise the bpf old helper bpf_probe_read() will not be available.
> 
> This is similar with the commit d195b1d1d1196 ("powerpc/bpf: Enable
> bpf_probe_read{, str}() on powerpc again").
> 
> Fixes: 0ebeea8ca8a4 ("bpf: Restrict bpf_probe_read{, str}() only to archs where they work")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thomas, I presume you pick this up via mips tree (with typos fixed)? Or do you
want us to route the fix via bpf with your ACK? (I'm fine either way.)

Thanks,
Daniel

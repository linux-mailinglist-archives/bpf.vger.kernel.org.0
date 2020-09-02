Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A103625B5ED
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 23:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgIBVdU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 17:33:20 -0400
Received: from www62.your-server.de ([213.133.104.62]:55190 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgIBVdU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 17:33:20 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kDaNZ-000376-Tv; Wed, 02 Sep 2020 23:33:17 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kDaNZ-000PGv-Pq; Wed, 02 Sep 2020 23:33:17 +0200
Subject: Re: EF_BPF_GNU_XBPF
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <87mu282gay.fsf@oracle.com>
 <CAADnVQ+AZvXTSitF+Fj5ohYiKWERN2yrPtOLR9udKcBTHSZzxA@mail.gmail.com>
 <87y2ls0w41.fsf@oracle.com>
 <20200902203206.nx6ws4ixuo2bcic6@ast-mbp.dhcp.thefacebook.com>
 <87o8mn281a.fsf@oracle.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d0a6eb38-76a4-b335-878b-647fe68f937a@iogearbox.net>
Date:   Wed, 2 Sep 2020 23:33:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87o8mn281a.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25918/Wed Sep  2 15:41:14 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/2/20 11:17 PM, Jose E. Marchesi wrote:
> 
>>> As such, the property of being verifiable is irrelevant.
>>
>> No. It's a fundamental property of BPF.
>> If it's not verifiable it's not BPF.
> 
> Sure.
> 
>> It's not xBPF either.
> 
> Heh, beg to differ :)
> 
>> Please call it something else and don't confuse people that your ISA
>> has any overlap with BPF. It doesn't. It's not verifiable.
> 
> Nonsense.  xBPF has as much overlap with BPF as it can have: around 99%.
> 
> The purpose of having the e_flag is to avoid confusion, not to increase
> it.  xBPF objects are mainly used to test the GCC BPF backend (and other
> purposes we have in mind, like ease the debugging of BPF programs) but
> we want to eliminate the chance of these objects to be confused with
> legit BPF files, and used as such.

I fully agree with Alexei. Looking at [0], if some of these extensions are
useful and help/optimize code generation, why not add them to the BPF runtime
in the kernel so they can be properly used in general for code generation
from gcc/llvm in BPF backend? xBPF would indeed be highly confusing if it cannot
be used from the runtime (unless these are properly integrated into the kernel,
verified and thus become a fixed part of eBPF ISA).

   [0] https://linuxplumbersconf.org/event/7/contributions/724/attachments/636/1166/bpf.pdf

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12A7233940
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 21:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgG3Tro (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 15:47:44 -0400
Received: from www62.your-server.de ([213.133.104.62]:36664 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgG3Tro (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jul 2020 15:47:44 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k1EWi-0007ew-B5; Thu, 30 Jul 2020 21:47:40 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k1EWi-000C0T-0x; Thu, 30 Jul 2020 21:47:40 +0200
Subject: Re: [PATCH bpf-next 1/1] arm64: bpf: Add BPF exception tables
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Qian Cai <cai@lca.pw>
Cc:     linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        songliubraving@fb.com, andriin@fb.com, catalin.marinas@arm.com,
        john.fastabend@gmail.com, ast@kernel.org, zlim.lnx@gmail.com,
        kpsingh@chromium.org, yhs@fb.com, will@kernel.org, kafai@fb.com,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200728152122.1292756-1-jean-philippe@linaro.org>
 <20200728152122.1292756-2-jean-philippe@linaro.org>
 <20200730122855.GA3773@lca.pw> <20200730142213.GB1529030@myrica>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f2f05f41-ccf9-e693-85bf-59ebbf8dadfe@iogearbox.net>
Date:   Thu, 30 Jul 2020 21:47:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200730142213.GB1529030@myrica>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25889/Thu Jul 30 17:03:53 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/30/20 4:22 PM, Jean-Philippe Brucker wrote:
> On Thu, Jul 30, 2020 at 08:28:56AM -0400, Qian Cai wrote:
>> On Tue, Jul 28, 2020 at 05:21:26PM +0200, Jean-Philippe Brucker wrote:
>>> When a tracing BPF program attempts to read memory without using the
>>> bpf_probe_read() helper, the verifier marks the load instruction with
>>> the BPF_PROBE_MEM flag. Since the arm64 JIT does not currently recognize
>>> this flag it falls back to the interpreter.
>>>
>>> Add support for BPF_PROBE_MEM, by appending an exception table to the
>>> BPF program. If the load instruction causes a data abort, the fixup
>>> infrastructure finds the exception table and fixes up the fault, by
>>> clearing the destination register and jumping over the faulting
>>> instruction.
>>>
>>> To keep the compact exception table entry format, inspect the pc in
>>> fixup_exception(). A more generic solution would add a "handler" field
>>> to the table entry, like on x86 and s390.
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>
>> This will fail to compile on arm64,
>>
>> https://gitlab.com/cailca/linux-mm/-/blob/master/arm64.config
>>
>> arch/arm64/mm/extable.o: In function `fixup_exception':
>> arch/arm64/mm/extable.c:19: undefined reference to `arm64_bpf_fixup_exception'
> 
> Thanks for the report, I attached a fix. Daniel, can I squash it and
> resend as v2 or is it too late?

If you want I can squash your attached snippet into the original patch of
yours. If you want to send a v2 that is fine as well of course. Let me know.

Thanks,
Daniel

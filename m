Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F661510044
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 16:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346732AbiDZOWF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 10:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347988AbiDZOWF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 10:22:05 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556E0377DE
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 07:18:57 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1njM1Y-000FVJ-Us; Tue, 26 Apr 2022 16:18:40 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1njM1Y-0002hc-Aw; Tue, 26 Apr 2022 16:18:40 +0200
Subject: Re: [PATCH bpf] x86/kprobes: Fix KRETPROBES when
 CONFIG_KRETPROBE_ON_RETHOOK is set
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Adam Zabrocki <pi3@pi3.com.pl>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Solar Designer <solar@openwall.com>, bpf@vger.kernel.org,
        rostedt@goodmis.org
References: <20220422164027.GA7862@pi3.com.pl>
 <008a7004-ede5-8ffe-062c-ca77649ce3a7@iogearbox.net>
 <20220426175048.f2bf5526b7ff543ba5087c85@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <96df719a-8149-e552-1e35-f736da91bcba@iogearbox.net>
Date:   Tue, 26 Apr 2022 16:18:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220426175048.f2bf5526b7ff543ba5087c85@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26524/Tue Apr 26 10:20:15 2022)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/26/22 10:50 AM, Masami Hiramatsu wrote:
> On Mon, 25 Apr 2022 16:42:12 +0200
> Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 4/22/22 6:40 PM, Adam Zabrocki wrote:
>>> [PATCH bpf] x86/kprobes: Fix KRETPROBES when CONFIG_KRETPROBE_ON_RETHOOK is set
>>>
>>> The recent kernel change "kprobes: Use rethook for kretprobe if possible",
>>> introduced a potential NULL pointer dereference bug in the KRETPROBE
>>> mechanism. The official Kprobes documentation defines that "Any or all
>>> handlers can be NULL". Unfortunately, there is a missing return handler
>>> verification to fulfill these requirements and can result in a NULL pointer
>>> dereference bug.
>>>
>>> This patch adds such verification in kretprobe_rethook_handler() function.
>>>
>>> Fixes: 73f9b911faa7 ("kprobes: Use rethook for kretprobe if possible")
>>> Signed-off-by: Adam Zabrocki <pi3@pi3.com.pl>
>>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>>
>> I don't mind if this fix gets routed via bpf tree if all parties are okay with
>> it (Masami? Steven?). Just noting that there is currently no specific dependency
>> in bpf tree for it, but if it's easier to route this way, happy to take it.
> 
> Yeah, I and Steve talked about it and he suggested this to be merged
> via BPF tree since the original commit came from the BPF tree.

Okay, I just applied it to bpf tree then.

Thanks everyone,
Daniel

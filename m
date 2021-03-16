Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975AC33E26C
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 00:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCPXwb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 19:52:31 -0400
Received: from www62.your-server.de ([213.133.104.62]:36204 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhCPXw0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 19:52:26 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lMJU0-000DoQ-EB; Wed, 17 Mar 2021 00:52:16 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lMJU0-000NkQ-8P; Wed, 17 Mar 2021 00:52:16 +0100
Subject: Re: [PATCH v3 bpf] ftrace: Fix modify_ftrace_direct.
To:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, andrii@kernel.org, paulmck@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20210316195815.34714-1-alexei.starovoitov@gmail.com>
 <20210316161633.64abfbd5@gandalf.local.home>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <18c16cfb-20df-6d1e-d7a5-106d5b80a90b@iogearbox.net>
Date:   Wed, 17 Mar 2021 00:52:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210316161633.64abfbd5@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26110/Tue Mar 16 12:05:23 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/16/21 9:16 PM, Steven Rostedt wrote:
> On Tue, 16 Mar 2021 12:58:15 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>> From: Alexei Starovoitov <ast@kernel.org>
>>
>> The following sequence of commands:
>>    register_ftrace_direct(ip, addr1);
>>    modify_ftrace_direct(ip, addr1, addr2);
>>    unregister_ftrace_direct(ip, addr2);
>> will cause the kernel to warn:
>> [   30.179191] WARNING: CPU: 2 PID: 1961 at kernel/trace/ftrace.c:5223 unregister_ftrace_direct+0x130/0x150
>> [   30.180556] CPU: 2 PID: 1961 Comm: test_progs    W  O      5.12.0-rc2-00378-g86bc10a0a711-dirty #3246
>> [   30.182453] RIP: 0010:unregister_ftrace_direct+0x130/0x150
>>
>> When modify_ftrace_direct() changes the addr from old to new it should update
>> the addr stored in ftrace_direct_funcs. Otherwise the final
>> unregister_ftrace_direct() won't find the address and will cause the splat.
>>
>> Fixes: 0567d6809182 ("ftrace: Add modify_ftrace_direct()")
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Applied, thanks!

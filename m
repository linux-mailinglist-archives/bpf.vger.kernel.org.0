Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD4814D2FB
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2020 23:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgA2WUx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jan 2020 17:20:53 -0500
Received: from www62.your-server.de ([213.133.104.62]:48978 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgA2WUw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jan 2020 17:20:52 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iwvhZ-00021p-Rf; Wed, 29 Jan 2020 23:20:50 +0100
Received: from [178.197.248.37] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1iwvhZ-000Sl6-Hc; Wed, 29 Jan 2020 23:20:49 +0100
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net>
 <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net>
Date:   Wed, 29 Jan 2020 23:20:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25710/Wed Jan 29 12:38:38 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/29/20 8:28 PM, Alexei Starovoitov wrote:
> On Wed, Jan 29, 2020 at 8:25 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>
>>> Fixes: 849fa50662fbc ("bpf/verifier: refine retval R0 state for bpf_get_stack helper")
>>> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
>>
>> Applied, thanks!
> 
> Daniel,
> did you run the selftests before applying?
> This patch breaks two.
> We have to find a different fix.
> 
> ./test_progs -t get_stack
> 68: (85) call bpf_get_stack#67
>   R0=inv(id=0,smax_value=800) R1_w=ctx(id=0,off=0,imm=0)
> R2_w=map_value(id=0,off=0,ks=4,vs=1600,umax_value=4294967295,var_off=(0x0;
> 0xffffffff)) R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0;
> 0xffffffff)) R4_w=inv0 R6=ctx(id=0,off=0,im?
> R2 unbounded memory access, make sure to bounds check any array access
> into a map

Sigh, had it in my wip pre-rebase tree when running tests. I've revert it from the
tree since this needs to be addressed. Sorry for the trouble.

Thanks,
Daniel

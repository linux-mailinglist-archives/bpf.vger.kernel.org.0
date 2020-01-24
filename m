Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD48414797A
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 09:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgAXIg1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 03:36:27 -0500
Received: from www62.your-server.de ([213.133.104.62]:37024 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAXIg0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 03:36:26 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iuuRz-0000HI-MQ; Fri, 24 Jan 2020 09:36:23 +0100
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=linux-3.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1iuuRz-000PwN-FX; Fri, 24 Jan 2020 09:36:23 +0100
Subject: Re: [bpf PATCH] bpf: verifier, do_refine_retval_range may clamp umin
 to 0 incorrectly
To:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc:     yhs@fb.com, ast@kernel.org
References: <157984984270.18622.13529102486040865869.stgit@john-XPS-13-9370>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6cdc9a24-39af-a06a-1db4-3cbf7eae598c@iogearbox.net>
Date:   Fri, 24 Jan 2020 09:36:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <157984984270.18622.13529102486040865869.stgit@john-XPS-13-9370>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25704/Thu Jan 23 12:37:43 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/24/20 8:10 AM, John Fastabend wrote:
> do_refine_retval_range() is called to refine return values from specified
> helpers, probe_read_str and get_stack at the moment, the reasoning is
> because both have a max value as part of their input arguments and
> because the helper ensure the return value will not be larger than this
> we can set umax and smax values of the return register, r0.
> 
> However, the return value is a signed integer so setting umax is incorrect
> It leads to further confusion when the do_refine_retval_range() then calls,
> __reg_deduce_bounds() which will see a umax value as meaning the value is
> unsigned and then assuming it is unsigned set the smin = umin which in this
> case results in 'smin = 0' and an 'smax = X' where X is the input argument
> from the helper call.
> 
> Here are the comments from _reg_deduce_bounds() on why this would be safe
> to do.
> 
>   /* Learn sign from unsigned bounds.  Signed bounds cross the sign
>    * boundary, so we must be careful.
>    */
>   if ((s64)reg->umax_value >= 0) {
> 	/* Positive.  We can't learn anything from the smin, but smax
> 	 * is positive, hence safe.
> 	 */
> 	reg->smin_value = reg->umin_value;
> 	reg->smax_value = reg->umax_value = min_t(u64, reg->smax_value,
> 						  reg->umax_value);
> 
> But now we incorrectly have a return value with type int with the
> signed bounds (0,X). Suppose the return value is negative, which is
> possible the we have the verifier and reality out of sync. Among other
> things this may result in any error handling code being falsely detected
> as dead-code and removed. For instance the example below shows using
> bpf_probe_read_str() causes the error path to be identified as dead
> code and removed.
> 
>>From the 'llvm-object -S' dump,
> 
>   r2 = 100
>   call 45
>   if r0 s< 0 goto +4
>   r4 = *(u32 *)(r7 + 0)
> 
> But from dump xlate
> 
>    (b7) r2 = 100
>    (85) call bpf_probe_read_compat_str#-96768
>    (61) r4 = *(u32 *)(r7 +0)  <-- dropped if goto
> 
> Due to verifier state after call being
> 
>   R0=inv(id=0,umax_value=100,var_off=(0x0; 0x7f))
> 
> To fix omit setting the umax value because its not safe. The only
> actual bounds we know is the smax. This results in the correct bounds
> (SMIN, X) where X is the max length from the helper. After this the
> new verifier state looks like the following after call 45.
> 
> R0=inv(id=0,smax_value=100)
> 
> Then xlated version no longer removed dead code giving the expected
> result,
> 
>    (b7) r2 = 100
>    (85) call bpf_probe_read_compat_str#-96768
>    (c5) if r0 s< 0x0 goto pc+4
>    (61) r4 = *(u32 *)(r7 +0)
> 
> Note, bpf_probe_read_* calls are root only so we wont hit this case
> with non-root bpf users.
> 
> Fixes: 849fa50662fbc ("bpf: verifier, refine bounds may clamp umin to 0 incorrectly")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>

Been reviewing this fix internally, therefore also:

Reviewed-by: Daniel Borkmann <daniel@iogearbox.net>

Still waiting to give Yonghong a chance to take a look as well before applying
and getting bpf PR out (should be roughly in morning US time).

Thanks,
Daniel

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBAC0172D88
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2020 01:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgB1Amk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Feb 2020 19:42:40 -0500
Received: from www62.your-server.de ([213.133.104.62]:60130 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgB1Amk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Feb 2020 19:42:40 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1j7Tji-0007l6-SV; Fri, 28 Feb 2020 01:42:38 +0100
Received: from [85.7.42.192] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1j7Tji-000BuH-Mm; Fri, 28 Feb 2020 01:42:38 +0100
Subject: Re: Alignment check in tnum_is_aligned()
To:     Bogdan Harjoc <harjoc@gmail.com>, bpf@vger.kernel.org
References: <CAF4+tmr3gfjj+k5L-7BNSrVZEdgPH=KAvCpi57XxDCS2z2Vm0w@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c77d7b7d-5ed2-4284-04b5-51f6fbfdaf37@iogearbox.net>
Date:   Fri, 28 Feb 2020 01:42:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAF4+tmr3gfjj+k5L-7BNSrVZEdgPH=KAvCpi57XxDCS2z2Vm0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25735/Thu Feb 27 20:18:16 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/27/20 6:07 PM, Bogdan Harjoc wrote:
> Hello,
> 
> bpf programs that call lock_xadd() on pointers obtained from bpf
> helpers fail to load because tnum_is_aligned() returns false during
> bpf validation. Should tnum_is_aligned() evaluate a.value & a.mask
> instead of a.value | a.mask ?
> 
> An example bpf tracing snippet that fails validation is:
> 
>      struct task_struct *t = (struct task_struct *)bpf_get_current_task();
>      lock_xadd(&t->usage.refs.counter, 1);

Note that bumping the refcount on bpf_get_current_task() pointer is not
possible from BPF.

> I noticed using a kprobe (listed below) that tnum_is_aligned()
> receives value=0, mask=0xffffffffffffffff and returns 0 for the
> lock_xadd() call above.

The implementation is ...

bool tnum_is_aligned(struct tnum a, u64 size)
{
         if (!size)
                 return true;
         return !((a.value | a.mask) & (size - 1));
}

... an a.value=0, a.mask=0xffffffffffffffff means that the verifier knows
nothing about the returned value from bpf_get_current_task(), so it could
be any pointer value in the whole u64 range. The masking for alignment is
based on the size arg above, not a.mask. Also bpf_get_current_task() does not
return a pointer type from verifier pov, so there's no check_generic_ptr_alignment()
test performed.

Cheers,
Daniel

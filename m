Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC2C3748FA
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 22:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhEEUBf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 16:01:35 -0400
Received: from www62.your-server.de ([213.133.104.62]:44690 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhEEUBe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 16:01:34 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1leNhE-000CJh-5s; Wed, 05 May 2021 22:00:36 +0200
Received: from [85.7.101.30] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1leNhD-000Q9m-Us; Wed, 05 May 2021 22:00:35 +0200
Subject: Re: [PATCH bpf] bpf: Don't WARN_ON_ONCE in bpf_bprintf_prepare
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        syzbot <syzbot@syzkaller.appspotmail.com>
References: <20210505162307.2545061-1-revest@chromium.org>
 <CAEf4BzZiK1ncN7RzeJ-62e=itekn34VuFf7WNhUF=9OoznMP6Q@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fe37ff8f-ebf0-25ec-4f3c-df3373944efa@iogearbox.net>
Date:   Wed, 5 May 2021 22:00:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZiK1ncN7RzeJ-62e=itekn34VuFf7WNhUF=9OoznMP6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26161/Wed May  5 13:06:38 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/5/21 8:55 PM, Andrii Nakryiko wrote:
> On Wed, May 5, 2021 at 9:23 AM Florent Revest <revest@chromium.org> wrote:
>>
>> The bpf_seq_printf, bpf_trace_printk and bpf_snprintf helpers share one
>> per-cpu buffer that they use to store temporary data (arguments to
>> bprintf). They "get" that buffer with try_get_fmt_tmp_buf and "put" it
>> by the end of their scope with bpf_bprintf_cleanup.
>>
>> If one of these helpers gets called within the scope of one of these
>> helpers, for example: a first bpf program gets called, uses
> 
> Can we afford having few struct bpf_printf_bufs? They are just 512
> bytes, so can we have 3-5 of them? Tracing low-level stuff isn't the
> only situation where this can occur, right? If someone is doing
> bpf_snprintf() and interrupt occurs and we run another BPF program, it
> will be impossible to do bpf_snprintf() or bpf_trace_printk() from the
> second BPF program, etc. We can't eliminate the probability, but
> having a small stack of buffers would make the probability so
> miniscule as to not worry about it at all.
> 
> Good thing is that try_get_fmt_tmp_buf() abstracts all the details, so
> the changes are minimal. Nestedness property is preserved for
> non-sleepable BPF programs, right? If we want this to work for
> sleepable we'd need to either: 1) disable migration or 2) instead of
> assuming a stack of buffers, do a loop to find unused one. Should be
> acceptable performance-wise, as it's not the fastest code anyway
> (printf'ing in general).
> 
> In any case, re-using the same buffer for sort-of-optional-to-work
> bpf_trace_printk() and probably-important-to-work bpf_snprintf() is
> suboptimal, so seems worth fixing this.
> 
> Thoughts?

Yes, agree, it would otherwise be really hard to debug. I had the same
thought on why not allowing nesting here given users very likely expect
these helpers to just work for all the contexts.

Thanks,
Daniel

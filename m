Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55D031D6C7
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 10:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhBQJAO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 04:00:14 -0500
Received: from www62.your-server.de ([213.133.104.62]:35734 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhBQJAO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 04:00:14 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lCIgF-000G0a-T9; Wed, 17 Feb 2021 09:59:32 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lCIgF-00028c-M3; Wed, 17 Feb 2021 09:59:31 +0100
Subject: Re: [PATCH v2 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit
 cmpxchg
To:     Brendan Jackman <jackmanb@google.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
References: <20210216141925.1549405-1-jackmanb@google.com>
 <80228f01-c43c-f121-0b80-bb368b530111@iogearbox.net>
 <CACYkzJ4-QSevoMuPZ_xtYP2WK1_2MKVC1op6Y1+wTtmP_FnOaw@mail.gmail.com>
 <CA+i-1C3ZTymNxLor0==orAdnboPXTCwFQWsu-8+K9VtOrprpZg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <08669818-c99d-0d30-e1db-53160c063611@iogearbox.net>
Date:   Wed, 17 Feb 2021 09:59:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CA+i-1C3ZTymNxLor0==orAdnboPXTCwFQWsu-8+K9VtOrprpZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26082/Tue Feb 16 13:17:58 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/17/21 8:59 AM, Brendan Jackman wrote:
> On Wed, 17 Feb 2021 at 02:43, KP Singh <kpsingh@kernel.org> wrote:
>> On Wed, Feb 17, 2021 at 1:50 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>> On 2/16/21 3:19 PM, Brendan Jackman wrote:
> [...]
>>> Looks good overall, one small nit ... is it possible to move this into fixup_bpf_calls()
>>> where we walk the prog insns & handle most of the rewrites already?
>>
>> Ah, so I thought fixup_bpf_calls was for "calls" but now looking at
>> the function it does
>> more than just fixing up calls. I guess we could also rename it and
>> update the comment
>> on the function.
> 
> Ah yes. Looks like we have:
> 
> - Some division-by-zero related stuff
> - Implementation of LD_ABS/LD_IND
> - Some spectre mitigation
> - Tail calls
> - Fixups for map and jiffies helper calls
> 
> How about I rename this function to do_misc_fixups and add a short
> comment to each of the above sections outlining what they're doing?

Sounds good to me, I would probably make the rename & comments a separate
patch from the 32 bit cmpxchg fix though.

Thanks,
Daniel

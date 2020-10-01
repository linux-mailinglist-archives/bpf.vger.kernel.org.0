Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6FF27FFF1
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 15:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbgJANVD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 09:21:03 -0400
Received: from www62.your-server.de ([213.133.104.62]:47462 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731993AbgJANU6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 09:20:58 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kNyVz-0005O2-Eu; Thu, 01 Oct 2020 15:20:55 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kNyVz-000Ehn-9x; Thu, 01 Oct 2020 15:20:55 +0200
Subject: Re: mb2q experience and couple issues
To:     Thomas Gleixner <tglx@linutronix.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <CAADnVQLV86GcC5fE68Eiv0aM9g7o3a5ZDh0kmXv7Tba4x-jRbg@mail.gmail.com>
 <87sgayfgwz.fsf@nanos.tec.linutronix.de>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <84c7a204-3d2e-0573-05ad-bd14d9de4d47@iogearbox.net>
Date:   Thu, 1 Oct 2020 15:20:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87sgayfgwz.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25943/Wed Sep 30 15:54:21 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/1/20 11:13 AM, Thomas Gleixner wrote:
> On Wed, Sep 30 2020 at 11:12, Alexei Starovoitov wrote:
>> For the last couple years we've been using mb2q tool to normalize patches
>> and it worked wonderfully.
> 
> Fun. I thought I'm the only user of it :)

We're using it pretty much daily since you've put it on korg :) It's in
a bunch of scripts^hacks we use for bpf trees:

   https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/pw.git/

>> Recently we've hit few bugs:
>> curl -s https://patchwork.kernel.org/patch/11807443/mbox/ >
>> /tmp/mbox.i; ~/bin/mb2q --mboxout mbox.o /tmp/mbox.i
>> Drop Message w/o Message-ID: No subject
>> No patches found in mbox
>>
>> I've tried to debug it, but couldn't figure out what's going on.
>> The subject and message-id fields are parsed correctly,
>> but later something happens.
>> Could you please take a look?
> 
> The problem is the mbox storage format. The mbox created by curl has a
> mail body which has a line starting with 'From' in the mail body:
> 
>    From the VAR btf_id, the verifier can also read the address of the
>    ksym's corresponding kernel var from kallsyms and use that to fill
>    dst_reg.
> 
> The mailbox parser trips over that From and takes it as start of the
> next message.
> 
>       http://qmail.org/qmail-manual-html/man5/mbox.html
> 
> Usually mailbox storage escapes a From at the start of a
> newline with '>':
> 
>    >From the VAR btf_id, the verifier can also read the address of the
>    ksym's corresponding kernel var from kallsyms and use that to fill
>    dst_reg.
> 
> Yes, it's ugly and I haven't figured out a proper way to deal with
> that. There are quite some mbox formats out there and they all are
> incompatible with each other and all of them have different horrors.
> 
> Let me think about it.

It seems these issues only appeared since maybe a month or so. Perhaps also
something changed on ozlabs/patchwork side.

Cheers,
Daniel

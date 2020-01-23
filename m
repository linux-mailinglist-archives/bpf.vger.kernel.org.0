Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E69991473F9
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 23:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAWWo6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 17:44:58 -0500
Received: from www62.your-server.de ([213.133.104.62]:48100 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAWWo6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 17:44:58 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iulDb-0000HU-22; Thu, 23 Jan 2020 23:44:55 +0100
Received: from [178.197.248.20] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1iulDa-000Fp0-Ir; Thu, 23 Jan 2020 23:44:54 +0100
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
To:     Daniel Xu <dxu@dxuuu.xyz>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
References: <C03IYDPABSU1.1C6OL4DJ7ID1H@dlxu-fedora-R90QNFJV>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9341443f-b29a-e92e-0e12-7990927b4e33@iogearbox.net>
Date:   Thu, 23 Jan 2020 23:44:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <C03IYDPABSU1.1C6OL4DJ7ID1H@dlxu-fedora-R90QNFJV>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25704/Thu Jan 23 12:37:43 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/23/20 11:30 PM, Daniel Xu wrote:
> On Thu Jan 23, 2020 at 11:23 PM, Daniel Borkmann wrote:
> [...]
>>
>> Yes, so we've been following this practice for all the BPF helpers no
>> matter
>> which program type. Though for tracing it may be up to debate whether it
>> makes
>> still sense given there's nothing to be leaked here since you can read
>> this data
>> anyway via probe read if you'd wanted to. So we might as well get rid of
>> the
>> clearing for all tracing helpers.
> 
> Right, that makes sense. Do you want me to leave it in for this patchset
> and then remove all of them in a followup patchset?

Lets leave it in and in a different set, we can clean this up for all tracing
related helpers at once.

>> Different question related to your set. It looks like br_stack is only
>> available
>> on x86, is that correct? For other archs this will always bail out on
>> !br_stack
>> test. Perhaps we should document this fact so users are not surprised
>> why their
>> prog using this helper is not working on !x86. Wdyt?
> 
> I think perf_event_open() should fail on !x86 if a user tries to configure
> it with branch stack collection. So there would not be the opportunity for
> the bpf prog to be attached and run. I haven't tested this, though. I'll
> look through the code / install a VM and test it.

As far as I can see the prog would still be attachable and runnable, just that
the helper always will return -EINVAL on these archs. Maybe error code should be
changed into -ENOENT to avoid confusion wrt whether user provided some invalid
input args. Should this actually bail out with -EINVAL if size is not a multiple
of sizeof(struct perf_branch_entry) as otherwise we'd end up copying half broken
branch entry information?

Thanks,
Daniel

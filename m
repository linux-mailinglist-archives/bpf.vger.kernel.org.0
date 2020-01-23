Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08459147455
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 00:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgAWXJq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 18:09:46 -0500
Received: from www62.your-server.de ([213.133.104.62]:51846 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgAWXJq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 18:09:46 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iulbZ-0003Iv-NT; Fri, 24 Jan 2020 00:09:41 +0100
Received: from [178.197.248.20] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1iulbZ-000TS6-9W; Fri, 24 Jan 2020 00:09:41 +0100
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
To:     Andrii Nakryiko <andriin@fb.com>, Daniel Xu <dxu@dxuuu.xyz>,
        John Fastabend <john.fastabend@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>
References: <C03IYDPABSU1.1C6OL4DJ7ID1H@dlxu-fedora-R90QNFJV>
 <2b11467f-9d93-8109-4561-d25ac605ef10@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <34ee093c-9757-e8dd-bc06-80398822f27e@iogearbox.net>
Date:   Fri, 24 Jan 2020 00:09:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2b11467f-9d93-8109-4561-d25ac605ef10@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25704/Thu Jan 23 12:37:43 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/23/20 11:41 PM, Andrii Nakryiko wrote:
> On 1/23/20 2:30 PM, Daniel Xu wrote:
>> On Thu Jan 23, 2020 at 11:23 PM, Daniel Borkmann wrote:
>> [...]
>>>
>>> Yes, so we've been following this practice for all the BPF helpers no
>>> matter
>>> which program type. Though for tracing it may be up to debate whether it
>>> makes
>>> still sense given there's nothing to be leaked here since you can read
>>> this data
>>> anyway via probe read if you'd wanted to. So we might as well get rid of
>>> the
>>> clearing for all tracing helpers.
>>
>> Right, that makes sense. Do you want me to leave it in for this patchset
>> and then remove all of them in a followup patchset?
> 
> I don't think we can remove that for existing tracing helpers (e.g.,
> bpf_probe_read). There are applications that explicitly expect
> destination memory to be zeroed out on failure. It's a BPF world's
> memset(0).

Due to avoiding error checks that way if the expected outcome of the buf
is non-zero anyway? Agree, that those would break, so yeah they cannot be
removed then.

> I also wonder if BPF verifier has any extra assumptions for
> ARG_PTR_TO_UNINIT_MEM w.r.t. it being initialized after helper call
> (e.g., for liveness tracking).

There are no extra assumptions other than memory being written after the
helper call (whether success or failure of the helper itself doesn't matter,
so there are no assumptions about the content); the data that has been
written to the buffer is marked as initialized but unknown (e.g. in
check_stack_write() the case where reg remains NULL since value_regno is
negative).

Thanks,
Daniel

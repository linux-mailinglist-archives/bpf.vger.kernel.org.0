Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAB7364DF
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2019 21:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfFETlw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jun 2019 15:41:52 -0400
Received: from www62.your-server.de ([213.133.104.62]:58416 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFETlv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jun 2019 15:41:51 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1hYbXF-0000QP-F6; Wed, 05 Jun 2019 21:25:21 +0200
Received: from [178.197.249.21] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hYbXF-0008Ni-66; Wed, 05 Jun 2019 21:25:21 +0200
Subject: Re: [PATCH 0/2] Move bpf_num_possible_cpus() to libbpf_util
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Hechao Li <hechaol@fb.com>
Cc:     Song Liu <songliubraving@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
References: <20190604223815.2487730-1-hechaol@fb.com>
 <BDC04C37-0C03-4D98-B4F2-437C7A746F88@fb.com>
 <C4921362-A75B-4333-91C7-437B4AA4C854@fb.com>
 <a6761839-7b1c-3504-0a96-28452c5b1450@iogearbox.net>
 <4F4DDA32-3BF0-40D7-BA75-7FA1A9FD0843@fb.com>
 <2a6ab005-0ac1-be09-d5dc-05ea672cbf9a@iogearbox.net>
 <8E01213E-C06A-4251-9982-FF8394A4BFF5@fb.com>
 <CAEf4BzYUqdUOidoJAStJh=Kg-h2+4CPRuJ2yLESfWa1CfB8aFw@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0baf92c0-be5b-6cf3-749c-f825e1e966dc@iogearbox.net>
Date:   Wed, 5 Jun 2019 21:25:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYUqdUOidoJAStJh=Kg-h2+4CPRuJ2yLESfWa1CfB8aFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25471/Wed Jun  5 10:12:21 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/05/2019 08:55 PM, Andrii Nakryiko wrote:
> On Wed, Jun 5, 2019 at 10:41 AM Hechao Li <hechaol@fb.com> wrote:
[...]
>> Thanks a lot for the detailed explanation, Daniel. And sorry for the reply format. Sure, I will add it as a libbpf_
>> API instead. Moving  the macro BPF_DECLARE_PERCPU in selftest util to libbpf also makes sense to me.
>> However, since bpf_num_possible_cpus in selftest exits the process in case of failures, which is not good for
>> a user facing API, how about making #CPU a param and define it as
>>
>> #define BPF_DECLARE_PERCPU(type, name, ncpu) \
>>              struct { type v; } __bpf_percpu_val_align name[ncpu]
>>
>> And the user should do
>> int ncpu = libbpf_num_possible_cpus();
>> // error handling if ncpu <=0
>> BPF_DECLARE_PERCPU(long, value, ncpu)
>>
>> The problem of this method is, the user may still pass sysconf(_SC_NPROCESSORS_CONF) as ncpu.
>> I think this can be avoided by putting some comments around this macro. Does it make sense?
> 
> BPF_DECLARE_PERCPU doesn't do anything fancy and is used only from
> single selftest, so I'd keep it where it is right now. There is no
> need to pollute libbpf_internal.h with lots of stuff, if it's not
> widely used.

That hack is basically for the case where a map value is not a multiple of
8 bytes, meaning without padding the lookup could corrupt the application; I
don't think users are aware of this w/o looking at the kernel implementation,
but I'm fine with leaving it as is, we could always migrate it later if needed.

> For libbpf_num_possible_cpus() - definitely change it to return int
> with <0 on error.

Yes, definitely, we cannot exit out of the lib.

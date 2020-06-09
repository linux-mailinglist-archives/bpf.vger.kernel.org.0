Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41441F4A0B
	for <lists+bpf@lfdr.de>; Wed, 10 Jun 2020 01:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgFIXWE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jun 2020 19:22:04 -0400
Received: from www62.your-server.de ([213.133.104.62]:56018 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgFIXWE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jun 2020 19:22:04 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jinZ8-0008AV-RG; Wed, 10 Jun 2020 01:21:58 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jinZ8-000KbJ-FH; Wed, 10 Jun 2020 01:21:58 +0200
Subject: Re: [PATCH] libbpf: Define __WORDSIZE if not available
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Irina Tirdea <irina.tirdea@intel.com>,
        bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200608161150.GA3073@kernel.org>
 <CAEf4BzbEcV6YaezP4yY8J=kYSBhh0cRHCvgCUe9xvB12mF08qg@mail.gmail.com>
 <20200609153445.GF24868@kernel.org>
 <d8baea0a-7358-a15b-38e5-850e84eae702@iogearbox.net>
 <20200609211653.GI24868@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6b2630e7-ac41-b6d4-9e6a-41db717d1b29@iogearbox.net>
Date:   Wed, 10 Jun 2020 01:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200609211653.GI24868@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25838/Tue Jun  9 14:50:43 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/9/20 11:16 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 09, 2020 at 10:37:48PM +0200, Daniel Borkmann escreveu:
>> Hey Arnaldo,
>>
>> On 6/9/20 5:34 PM, Arnaldo Carvalho de Melo wrote:
>>> Some systems, such as Android, don't have a define for __WORDSIZE, do it
>>> in terms of __SIZEOF_LONG__, as done in perf since 2012:
>>>
>>>     http://git.kernel.org/torvalds/c/3f34f6c0233ae055b5
>>>
>>> For reference: https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html
>>>
>>> I build tested it here and Andrii did some Travis CI build tests too.
>>>
>>> Acked-by: Andrii Nakryiko <andriin@fb.com>
>>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>
>> Diff missing?
> 
> Oh well, sorry about that, EBADCOFFEE or something:
> 
> From: Arnaldo Carvalho de Melo <acme@kernel.org>
> 
> Some systems, such as Android, don't have a define for __WORDSIZE, do it
> in terms of __SIZEOF_LONG__, as done in perf since 2012:
> 
>     http://git.kernel.org/torvalds/c/3f34f6c0233ae055b5
> 
> For reference: https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html
> 
> I build tested it here and Andrii did some Travis CI build tests too.
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
[...]

Applied, thanks!

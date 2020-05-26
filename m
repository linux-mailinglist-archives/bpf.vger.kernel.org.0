Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7381E3175
	for <lists+bpf@lfdr.de>; Tue, 26 May 2020 23:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgEZVsD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 17:48:03 -0400
Received: from www62.your-server.de ([213.133.104.62]:49032 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgEZVsD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 17:48:03 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jdhQX-0002Rl-PG; Tue, 26 May 2020 23:48:01 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jdhQX-000CEk-Hv; Tue, 26 May 2020 23:48:01 +0200
Subject: Re: [PATCH 0/8] selftests/bpf: installation and out of tree build
 fixes
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>, bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
 <xuny367so4k3.fsf@redhat.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <77645d8b-2448-a35b-912a-abd3e329139d@iogearbox.net>
Date:   Tue, 26 May 2020 23:48:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <xuny367so4k3.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25824/Tue May 26 14:27:30 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/22/20 8:40 AM, Yauheni Kaliuta wrote:
> 
> Actually, a bit more needed :)

Not quite sure how to parse this, I presume you are intending to send a v2 of
this series with [0] folded in? Please also do not add line-breaks in the middle
of all your Fixes tags as otherwise it would break searching for commits in the
git log. For the v2 respin, please also add a better cover letter than just saying
nothing more than 'I had a look, here are some fixes.'. At least a minimal high
level summary of the selftest Makefile changes in this series.

Thanks,
Daniel

   [0] https://patchwork.ozlabs.org/project/netdev/patch/20200522081901.238516-1-yauheni.kaliuta@redhat.com/

>>>>>> On Fri, 22 May 2020 07:13:02 +0300, Yauheni Kaliuta  wrote:
> 
>   > I had a look, here are some fixes.
>   > Yauheni Kaliuta (8):
>   >   selftests/bpf: remove test_align from Makefile
>   >   selftests/bpf: build bench.o for any $(OUTPUT)
>   >   selftests/bpf: install btf .c files
>   >   selftests/bpf: fix object files installation
>   >   selftests/bpf: add output dir to include list
>   >   selftests/bpf: fix urandom_read installation
>   >   selftests/bpf: fix test.h placing for out of tree build
>   >   selftests/bpf: factor out MKDIR rule
> 
>   >  tools/testing/selftests/bpf/Makefile | 77 ++++++++++++++++++++--------
>   >  1 file changed, 55 insertions(+), 22 deletions(-)
> 
>   > --
>   > 2.26.2
> 
> 


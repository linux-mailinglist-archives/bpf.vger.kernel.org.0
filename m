Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81467397080
	for <lists+bpf@lfdr.de>; Tue,  1 Jun 2021 11:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhFAJnL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 05:43:11 -0400
Received: from www62.your-server.de ([213.133.104.62]:56288 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhFAJnL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Jun 2021 05:43:11 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lo0ts-0008EZ-0d; Tue, 01 Jun 2021 11:41:28 +0200
Received: from [85.7.101.30] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lo0tr-000PUW-QG; Tue, 01 Jun 2021 11:41:27 +0200
Subject: Re: [PATCH bpf-next] bpf: tnums: Provably sound, faster, and more
 precise algorithm for tnum_mul
To:     Edward Cree <ecree.xilinx@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        hv90@scarletmail.rutgers.edu
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>,
        Matan Shachnai <m.shachnai@rutgers.edu>,
        Srinivas Narayana <srinivas.narayana@rutgers.edu>,
        Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
References: <20210528035520.3445-1-harishankar.vishwanathan@rutgers.edu>
 <CAEf4BzYnTYdDnVuEuiHpg=LWT_JvwJim8kTEBpGKrH3wePez2Q@mail.gmail.com>
 <a4da47de-daf8-e167-a796-83bd4167341b@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d0a2f2f4-b0fe-76ba-8af4-b4c734f4be5d@iogearbox.net>
Date:   Tue, 1 Jun 2021 11:41:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a4da47de-daf8-e167-a796-83bd4167341b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26187/Mon May 31 13:15:33 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/1/21 10:11 AM, Edward Cree wrote:
> On 30/05/2021 06:59, Andrii Nakryiko wrote:
>> I think your algorithm makes sense, but I've also CC'ed original
>> author of tnum logic. Edward, please take a look as well.Yep, I've been in discussions with them about the paper and their
>   algorithm appears fine to me.  As for the patch, nothing to add
>   beyond your observations.

SGTM, Edward, okay to add your Acked-by or Reviewed-by in that case when applying v2 [0]?

Thanks,
Daniel

   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20210531020157.7386-1-harishankar.vishwanathan@rutgers.edu/

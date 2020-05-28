Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CBD1E6B4E
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 21:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406647AbgE1Tlr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 15:41:47 -0400
Received: from www62.your-server.de ([213.133.104.62]:56010 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406540AbgE1Tlq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 15:41:46 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jeOPP-0002Aa-NR; Thu, 28 May 2020 21:41:43 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jeOPP-000U40-FV; Thu, 28 May 2020 21:41:43 +0200
Subject: Re: [PATCH bpf-next V2] bpf: Fix map_check_no_btf return code
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>
References: <159057923399.191121.11186124752660899399.stgit@firesoul>
 <CAEf4Bzavr2hLv+Z0be0_uGRfPqNsBKAsQL7MpQUoXQX46rj4eA@mail.gmail.com>
 <20200528090842.6fb4e42d@carbon>
 <CAEf4BzZ0L=J9PbYndB4rFLvBEnZR6opUppDnD=b9BXsR2AR0cQ@mail.gmail.com>
 <CAADnVQJorSsnhGef5_Nfdwe=G2XP2LXdetNRqCKpjJmkKhSN7g@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0250363a-68a5-3152-b6df-2b2894a08abc@iogearbox.net>
Date:   Thu, 28 May 2020 21:41:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAADnVQJorSsnhGef5_Nfdwe=G2XP2LXdetNRqCKpjJmkKhSN7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25826/Thu May 28 14:33:30 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/28/20 8:38 PM, Alexei Starovoitov wrote:
> On Thu, May 28, 2020 at 11:21 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> My biggest grudge with changing error code is that old error code will
>> still be used in older kernels, so if libbpf were to help users with
>> more helpful message, it now needs to support both error codes,
>> forever, potentially depending on kernel version. This constant
>> splitting of logic is annoying, so I'd rather avoid it.
> 
> +1.
> 
> I think what this patch is trying to do is to fix strerror() lack of
> understanding of error code on the kernel side by changing
> the error code.
> There are plenty of similar places in the kernel.
> I think it's better to fix strerror via wrapper that understand kernel
> error codes.
> There probably will be more than one such ENOTSUPP error.

Fully agree, libbpf is the better place to provide a more user friendly
error especially given the older kernel case.

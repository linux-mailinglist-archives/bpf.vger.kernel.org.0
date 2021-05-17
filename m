Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4165C383CC5
	for <lists+bpf@lfdr.de>; Mon, 17 May 2021 20:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhEQS5w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 May 2021 14:57:52 -0400
Received: from www62.your-server.de ([213.133.104.62]:58014 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbhEQS5t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 May 2021 14:57:49 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1liiPn-000Dy4-8H; Mon, 17 May 2021 20:56:31 +0200
Received: from [85.7.101.30] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1liiPm-000Oqz-VD; Mon, 17 May 2021 20:56:30 +0200
Subject: Re: [PATCH v3] bpf.2: Use standard types and attributes
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zack Weinberg <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Joseph Myers <joseph@codesourcery.com>,
        Florian Weimer <fweimer@redhat.com>
References: <6740a229-842e-b368-86eb-defc786b3658@gmail.com>
 <20210515190116.188362-1-alx.manpages@gmail.com>
 <9df36138-f622-49a6-8310-85ff0470ccd6@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <521cd198-fea2-c2a8-ed96-5848ae39b6f2@iogearbox.net>
Date:   Mon, 17 May 2021 20:56:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9df36138-f622-49a6-8310-85ff0470ccd6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26173/Mon May 17 13:11:33 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/16/21 11:16 AM, Alejandro Colomar (man-pages) wrote:
> On 5/15/21 9:01 PM, Alejandro Colomar wrote:
>> Some manual pages are already using C99 syntax for integral
>> types 'uint32_t', but some aren't.  There are some using kernel
>> syntax '__u32'.  Fix those.
>>
>> Both the kernel and the standard types are 100% binary compatible,
>> and the source code differences between them are very small, and
>> not important in a manual page:
>>
>> - Some of them are implemented with different underlying types
>>    (e.g., s64 is always long long, while int64_t may be long long
>>    or long, depending on the arch).  This causes the following
>>    differences.
>>
>> - length modifiers required by printf are different, resulting in
>>    a warning ('-Wformat=').
>>
>> - pointer assignment causes a warning:
>>    ('-Wincompatible-pointer-types'), but there aren't any pointers
>>    in this page.
>>
>> But, AFAIK, all of those warnings can be safely ignored, due to
>> the binary compatibility between the types.
>>
>> ...
>>
>> Some pages also document attributes, using GNU syntax
>> '__attribute__((xxx))'.  Update those to use the shorter and more
>> portable C11 keywords such as 'alignas()' when possible, and C2x
>> syntax '[[gnu::xxx]]' elsewhere, which hasn't been standardized
>> yet, but is already implemented in GCC, and available through
>> either --std=c2x or any of the --std=gnu... options.
>>
>> The standard isn't very clear on how to use alignas() or
>> [[]]-style attributes, and the GNU documentation isn't better, so
>> the following link is a useful experiment about the different
>> alignment syntaxes:
>> __attribute__((aligned())), alignas(), and [[gnu::aligned()]]:
>> <https://stackoverflow.com/q/67271825/6872717>
>>
>> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> Discussion: <https://lore.kernel.org/linux-man/6740a229-842e-b368-86eb-defc786b3658@gmail.com/T/>
>> Nacked-by: Alexei Starovoitov <ast@kernel.org>
>> Nacked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

You forgot to retain my ...

Nacked-by: Daniel Borkmann <daniel@iogearbox.net>

>> Acked-by: Zack Weinberg <zackw@panix.com>
>> Cc: LKML <linux-kernel@vger.kernel.org>
>> Cc: glibc <libc-alpha@sourceware.org>
>> Cc: GCC <gcc-patches@gcc.gnu.org>
>> Cc: bpf <bpf@vger.kernel.org>
>> Cc: David Laight <David.Laight@ACULAB.COM>
>> Cc: Joseph Myers <joseph@codesourcery.com>
>> Cc: Florian Weimer <fweimer@redhat.com>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   man2/bpf.2 | 49 ++++++++++++++++++++++++-------------------------
>>   1 file changed, 24 insertions(+), 25 deletions(-)
>>

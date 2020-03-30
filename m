Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5AF198786
	for <lists+bpf@lfdr.de>; Tue, 31 Mar 2020 00:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgC3WlI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Mar 2020 18:41:08 -0400
Received: from www62.your-server.de ([213.133.104.62]:54412 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3WlI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Mar 2020 18:41:08 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jJ35d-0001n9-M7; Tue, 31 Mar 2020 00:41:05 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jJ35d-0008o8-EH; Tue, 31 Mar 2020 00:41:05 +0200
Subject: Re: CONFIG_DEBUG_INFO_BTF and CONFIG_GCC_PLUGIN_RANDSTRUCT
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
References: <CAG48ez2sZ58VQ4+LJu39H1M0Y98LhRYR19G_fDAPJPBf7imxuw@mail.gmail.com>
 <CAADnVQ+Ux3-D_7ytRJx_Pz4fStRLS1vkM=-tGZ0paoD7n+JCLQ@mail.gmail.com>
 <CAG48ez0ajun-ujQQqhDRooha1F0BZd3RYKvbJ=8SsRiHAQjUzw@mail.gmail.com>
 <202003301016.D0E239A0@keescook>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c332da87-a770-8cf9-c252-5fb64c06c17e@iogearbox.net>
Date:   Tue, 31 Mar 2020 00:41:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <202003301016.D0E239A0@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25767/Mon Mar 30 15:08:30 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/30/20 7:20 PM, Kees Cook wrote:
> On Mon, Mar 30, 2020 at 06:17:32PM +0200, Jann Horn wrote:
>> On Mon, Mar 30, 2020 at 5:59 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>> On Mon, Mar 30, 2020 at 8:14 AM Jann Horn <jannh@google.com> wrote:
>>>>
>>>> I noticed that CONFIG_DEBUG_INFO_BTF seems to partly defeat the point
>>>> of CONFIG_GCC_PLUGIN_RANDSTRUCT.
>>>
>>> Is it a theoretical stmt or you have data?
>>> I think it's the other way around.
>>> gcc-plugin breaks dwarf and breaks btf.
>>> But I only looked at gcc patches without applying them.
>>
>> Ah, interesting - I haven't actually tested it, I just assumed
>> (perhaps incorrectly) that the GCC plugin would deal with DWARF info
>> properly.
> 
> Yeah, GCC appears to create DWARF before the plugin does the
> randomization[1], so it's not an exposure, but yes, struct randomization
> is pretty completely incompatible with a bunch of things in the kernel
> (by design). I'm happy to add negative "depends" in the Kconfig if it
> helps clarify anything.

Is this expected to get fixed at some point wrt DWARF? Perhaps would make
sense then to add a negative "depends" for both DWARF and BTF if the option
GCC_PLUGIN_RANDSTRUCT is set given both would be incompatible/broken.

Thanks,
Daniel

> -Kees
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84052
> 


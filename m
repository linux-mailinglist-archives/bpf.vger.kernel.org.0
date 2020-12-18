Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BB42DE314
	for <lists+bpf@lfdr.de>; Fri, 18 Dec 2020 14:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgLRNF5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Dec 2020 08:05:57 -0500
Received: from www62.your-server.de ([213.133.104.62]:35068 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgLRNF5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Dec 2020 08:05:57 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kqFRa-000A5m-BY; Fri, 18 Dec 2020 14:05:14 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kqFRa-000LL1-5u; Fri, 18 Dec 2020 14:05:14 +0100
Subject: Re: Please remove all bit fields in bpf uapi
To:     Florian Weimer <fweimer@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Meng Zhuo <mengzhuo1203@gmail.com>, linux-api@vger.kernel.org,
        bpf@vger.kernel.org
References: <CACt3ES2LCfNDq-nskrySJjWD5EO9WCAst_+kJT7UbhYOmD+45g@mail.gmail.com>
 <X9xu2q8QFCCf70r7@kroah.com>
 <CACt3ES3NTRZF4jbCjgHybGHofNypQ3EPnYvuJi-eZZXJtonQUg@mail.gmail.com>
 <X9yE+hJpT73PdKjG@kroah.com> <87im8z1il5.fsf@oldenburg2.str.redhat.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f1dc3a14-5007-83f1-c1ea-92eacafc93f5@iogearbox.net>
Date:   Fri, 18 Dec 2020 14:05:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87im8z1il5.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26020/Thu Dec 17 15:34:34 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/18/20 12:04 PM, Florian Weimer wrote:
>> On Fri, Dec 18, 2020 at 05:09:58PM +0800, Meng Zhuo wrote:
>>> Hi, Greg
>>>
>>> Thank you for your reply
>>> It's fine to do compile bit fields "by hand".
>>
>> Surely Go has something like "if (field & 0x01)", right?  That's all you
>> need for a bitfield.
>>
>> Look at the most common syscall, open(2)?  It uses bitfields, why
>> can't Go handle that?
> 
> Flag arguments are very different from bit-fields in struct types.
> 
> Structs with bit-fields are not part of the highly portable C subset.
> Even C compilers differ in their interpretation.

Bitfields are still quite common though, not special to BPF in any way ...
how do you deal with all these cases then?

git grep -P -n "[a-z]+:[1-9]+" include/uapi/ | wc -l
272

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AFF372D5E
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 17:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhEDPy3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 11:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhEDPy3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 11:54:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E4AC061574;
        Tue,  4 May 2021 08:53:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l14so10003123wrx.5;
        Tue, 04 May 2021 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vFudBmXu/+RTuQ8QzQZplAS5i4hzpB1lVEpniyoJ/gA=;
        b=gxXPXQiEecmdIIy4Lw1Zy5q+l5oQDdubypgrul0HRPcNFJCHhGkkrzrAcSeQ6f9AmC
         i4S+TOu0F2ncNFWbGch3mQ53vaHw2Lek1jrbfqZVSuxdFFFxTIVDpn2miD6Bnllp55lR
         xmjmGxJUzu8rWZwQ4HBmnwir35hD6K6kSur+bpy0fovcOYZzjKYVenqgxf66SWoEclBD
         xDbvSSDDUMdIbNAfurKQ6xdZZJE4vlnqQrIsb1l4XaLWCBHiqN9W5TsHJIiV9b3PRap9
         Qh7KvzYyuTACCAkDrnaK7Q58vDD0K3tfckk9KWK1oQqZ19ledKixAIb1fffU7AlCb3Vm
         2jsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vFudBmXu/+RTuQ8QzQZplAS5i4hzpB1lVEpniyoJ/gA=;
        b=U1IQwwbk2yWcr1EONXcI+lAxlwNTxvlwuhjvqhNHj6djziiJqzz5L/Ffs01LH7+gak
         H5QVd/AKq1B4hK06qm1dx4LKpgG3tBJgnvWEeIVmbYIa4qrGELst6x4EoVwG16XUQgMQ
         g/Gxt1KHiFQbbpblvo3UUbF7scaumZUVBsHPDSnXUm78l6XzBtFZRBZ0dVnba7e4dsn8
         OsJX9DxzH1m78Gvd+GhImfgyk3lhDW2BkrqWJ6kpeFQ8ziFYj166tZPRjr2jDuQ7m4nn
         E7+J0SPWuczHOM2LhTpVPL7NnzFXQAQCTsWh704j+VDL92dcL8OnxjCFTwpZ5GoaNXb5
         Z/HQ==
X-Gm-Message-State: AOAM533SM5n3HACHwsGo7c2YErJAmBbX2N0MQGe6z5+htZVIRUpcPe+k
        LN2LnOj5zWNsrtZFPNuLfK5R4iWFCuu9IQ==
X-Google-Smtp-Source: ABdhPJxGOqa+8jNdMAdHPH7LCR9tXljMAkwsxkiD4yDPJsecJJJB0m5E49H7BlbrJfUni6lNjL9d0w==
X-Received: by 2002:a5d:4304:: with SMTP id h4mr6125597wrq.210.1620143611803;
        Tue, 04 May 2021 08:53:31 -0700 (PDT)
Received: from [192.168.0.237] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id f25sm17103717wrd.67.2021.05.04.08.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 08:53:31 -0700 (PDT)
Subject: Re: [RFC v2] bpf.2: Use standard types and attributes
To:     Greg KH <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Zack Weinberg <zackw@panix.com>,
        Joseph Myers <joseph@codesourcery.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20210504110519.16097-1-alx.manpages@gmail.com>
 <CAADnVQLdW=jH1CUP02jokEu3Sh+=xKsCXvjA19kfz7KOn9mzkA@mail.gmail.com>
 <YJFZHW2afbAMVOmE@kroah.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <69fb22e0-84bd-47fb-35b5-537a7d39c692@gmail.com>
Date:   Tue, 4 May 2021 17:53:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJFZHW2afbAMVOmE@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Greg and Alexei,

> On Tue, May 04, 2021 at 07:12:01AM -0700, Alexei Starovoitov wrote:
>> For the same reasons as explained earlier:
>> Nacked-by: Alexei Starovoitov <ast@kernel.org>

Okay, I'll add that.


On 5/4/21 4:24 PM, Greg KH wrote:> I agree, the two are not the same 
type at all, this change should not be
> accepted.

I get that in the kernel you don't use the standard fixed-width types 
(with some exceptions), probably not to mess with code that relies on 
<stdint.h> not being included (I hope there's not much code that relies 
on this in 2021, but who knows).

But, there is zero difference between these types, from the point of 
view of the compiler.  There's 100% compatibility between those types, 
and you're able to mix'n'match them.  See some example below.

Could you please explain why the documentation, which supposedly only 
documents the API and not the internal implementation, should not use 
standard naming conventions?  The standard is much easier to read for 
userspace programmers, which might ignore why the kernel does some 
things in some specific ways.

BTW, just to clarify, bpf.2 is just a small sample to get reviews; the 
original intention was to replace __uNN by uintNN_t in all of the manual 
pages.

Thanks,

Alex

...

Example:

$ cat test.c
#include <stdint.h>

typedef int __s32;

int32_t foo(void);

int main(void)
{
	return 1 - foo();
}


__s32 foo(void)
{
	return 1;
}
$ cc -Wall -Wextra -Werror -S -Og test.c -o test.s
$ cat test.s
	.file	"test.c"
	.text
	.globl	foo
	.type	foo, @function
foo:
.LFB1:
	.cfi_startproc
	movl	$1, %eax
	ret
	.cfi_endproc
.LFE1:
	.size	foo, .-foo
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	call	foo
	movl	%eax, %edx
	movl	$1, %eax
	subl	%edx, %eax
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
$


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/

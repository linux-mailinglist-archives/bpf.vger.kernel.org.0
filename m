Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DA1340F71
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 21:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhCRU4m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 16:56:42 -0400
Received: from www62.your-server.de ([213.133.104.62]:57206 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhCRU43 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 16:56:29 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lMzgy-0004qC-68; Thu, 18 Mar 2021 21:56:28 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lMzgy-000Fy0-2F; Thu, 18 Mar 2021 21:56:28 +0100
Subject: Re: [PATCH] libbpf: allow bpf object kern_version to be overridden
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <20210318062520.3838605-1-rafaeldtinoco@ubuntu.com>
 <20210318193121.370561-1-rafaeldtinoco@ubuntu.com>
 <CAEf4BzZBy+H_ZHTf+fErB2-aMpJr+JSAgCYwvtWbG7dT3=97Cw@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <318f936b-2f7c-7d4a-cb40-baf673bd6c9e@iogearbox.net>
Date:   Thu, 18 Mar 2021 21:56:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZBy+H_ZHTf+fErB2-aMpJr+JSAgCYwvtWbG7dT3=97Cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26112/Thu Mar 18 12:08:11 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/18/21 8:46 PM, Andrii Nakryiko wrote:
> On Thu, Mar 18, 2021 at 12:31 PM Rafael David Tinoco
> <rafaeldtinoco@ubuntu.com> wrote:
>>
>> Unfortunately some distros don't have their accurate kernel version
>> defined correctly in version.h due to long term support decisions. This
>> makes LINUX_VERSION_CODE to be defined as the original upstream version
>> in header, while the running in-kernel version is different.
>>
>> Older kernels might still check kern_version during bpf_prog_load(),
>> making it impossible to load a program that could still be portable.
>> This patch allows one to override bpf objects kern_version attributes,
>> so program can bypass this in-kernel check during load.
>>
>> Example:
>>
>> A kernel 4.15.0-129.132, for example, might have 4.15.18 version defined
>> in its headers, which is the kernel it is based on, but have a 4.15.0
>> version defined within the kernel due to other factors.
>>
>> $ export LIBBPF_KERN_VERSION=4.15.18
>> $ sudo -E ./portablebpf -v
>> ...
>> libbpf: bpf object: kernel_version enforced by env variable: 266002
>> ...
>>
>> This will also help portable binaries within similar older kernels, as
>> long as they have their BTF data converted from DWARVES (for example).
>>
>> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
>> ---
> 
> Libbpf currently provides a way to specify custom kernel version using
> a special "version" ELF section:
> 
> int _version SEC("version") = 123;
> 
> But it seems like you would want to set it at runtime, so this
> compile-time approach might be problematic. But instead of hijacking
> get_kernel_version(), it's better to add a simple setter counterpart
> to bpf_object__kversion() that would just override obj->kern_version.

+1, agree, setter makes sense for old kernels, so the loader app can set/
retrieve from wherever it's needed. In addition, couldn't you also backport
the old commit that ignores the kern_version from kernel side (won't help
existing users, but at least might simplify things once they start upgrade)?

Thanks,
Daniel

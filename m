Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6891D2F22DE
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 23:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389431AbhAKWfi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 17:35:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387685AbhAKWfi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Jan 2021 17:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610404451;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u8wvNzKHbCZNUsD83LMMeksH/oMSQX1O0M/D4dVfyQY=;
        b=dhDcYdTk9SKgDxVPLjWn3lucWu22cke9s7zRkQwUDPjsPPsJRrWZ/t26p/C2nA+Q0TcTdh
        DW8eGfPN57uWVff3wR8YVNgQjSH3uKCMtcnXdAUXCVbr5mwvctQ/GUgch8TZPbGf29hSg5
        Sxnt4lSFGpnsBfGkM6EHRhyjdyVrhVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-hkyCXt0CPaam7ZZh2m3OAQ-1; Mon, 11 Jan 2021 17:34:07 -0500
X-MC-Unique: hkyCXt0CPaam7ZZh2m3OAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF376803620;
        Mon, 11 Jan 2021 22:34:05 +0000 (UTC)
Received: from tstellar.remote.csb (ovpn-114-95.phx2.redhat.com [10.3.114.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0C7150DE3;
        Mon, 11 Jan 2021 22:34:04 +0000 (UTC)
Reply-To: tstellar@redhat.com
Subject: Re: Check pahole availibity and BPF support of toolchain before
 starting a Linux kernel build
To:     Jiri Olsa <jolsa@redhat.com>, Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
References: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
 <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com>
 <CA+icZUVm6ZZveqVoS83SVXe1nqkqZVRjLO+SK1_nXHKkgh4yPQ@mail.gmail.com>
 <CAEf4BzaEA5aWeCCvHp7ASo9TdfotcBtqNGexirEynHDSo7ufgg@mail.gmail.com>
 <CA+icZUVrF_LCVhELbNLA7=FzEZK4=jk3QLD9XT2w5bQNo=nnOA@mail.gmail.com>
 <20210111223144.GA1250730@krava>
From:   Tom Stellard <tstellar@redhat.com>
Organization: Red Hat
Message-ID: <ed779f29-18b9-218f-a937-878328a769fe@redhat.com>
Date:   Mon, 11 Jan 2021 14:34:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210111223144.GA1250730@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/11/21 2:31 PM, Jiri Olsa wrote:
> On Mon, Jan 11, 2021 at 10:30:22PM +0100, Sedat Dilek wrote:
> 
> SNIP
> 
>>>>
>>>> Building a new Linux-kernel...
>>>>
>>>> - Sedat -
>>>>
>>>> [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
>>>> [2] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758026878
>>>> [3] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758056553
>>>
>>> There are no significant bug fixes between pahole 1.19 and master that
>>> would solve this problem, so let's try to repro this.
>>>
>>
>> You are right pahole fom latest Git does not solve the issue.
>>
>> + info BTFIDS vmlinux
>> + [  != silent_ ]
>> + printf   %-7s %s\n BTFIDS vmlinux
>>   BTFIDS  vmlinux
>> + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
>> FAILED: load BTF from vmlinux: Invalid argument
> 
> hm, is there a .BTF section in vmlinux?
> 
> is this working over vmlinux:
>   $ bpftool btf dump file ./vmlinux
> 
> do you have a verbose build output? I'd think pahole scream first..
> 

It does.  For me, pahole segfaults at scripts/link-vmlinux.sh:131.  This 
is pretty easy for me to reproduce.  I have logs, what other information 
would be helpful?  How about a pahole backtrace?

-Tom

> jirka
> 


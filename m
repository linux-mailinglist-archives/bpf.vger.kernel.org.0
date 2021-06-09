Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780133A0AD1
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 05:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbhFIDqB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Jun 2021 23:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46690 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236542AbhFIDqB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 8 Jun 2021 23:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623210246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OGeHcfpGB2J4iosdVTMmZq2wvP1+el8Py0z0pfMwv04=;
        b=Vvpbc5Hsxyed/xsHoRpAf5mODY1JWWZ9fDj+FgNM8B90Ov5sZNoNshRGLDaZATQDhu7mY5
        IuI1pLZPXQks0NGHUceUV/3k1DrAcxICjPMLt1EQthrcfN1zjk+ldqadsSIvA8YC5dEMpF
        XqJvLuAbPflxk5WCKRVmTgya72Q5m90=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-bVvP7QI5M7m6GhZqCzEF0Q-1; Tue, 08 Jun 2021 23:44:05 -0400
X-MC-Unique: bVvP7QI5M7m6GhZqCzEF0Q-1
Received: by mail-oo1-f70.google.com with SMTP id p4-20020a4a48040000b029020eb67f7264so14576384ooa.23
        for <bpf@vger.kernel.org>; Tue, 08 Jun 2021 20:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OGeHcfpGB2J4iosdVTMmZq2wvP1+el8Py0z0pfMwv04=;
        b=I8NAoOxafWaw/kuAE4xB/ylauZmaWgDbw/LQVXbwG933xhfHk3ZEgyniNXl3jwcEpi
         znVClLCVlnyVYBXDA90xI15A98vQzhj7r4P8onfADV4WkjrL3KajFfMj6s+dbwgK5x0J
         tXHCExVCpmGbKH0qPGXZL3yhp/cflT6FuWTLy5mT0bggQ5HH6AroP5oqAQCz8r6ehQcY
         s1cnN6timgkHiTiDj0ZgIJ95KzhHGDgjAbVyVICWqRKvOBMqxCytT+MRH0Uv1f7VkZP2
         yNlIrctNn6pzPn3Z5s6pFTQ/9DSzk7RA4ue//PM03wVtKSpyjRf98QEWMza5EihdTbmx
         PV8g==
X-Gm-Message-State: AOAM532ZDoXXVyd81r8HOvVLBjJeiFpRZIjVaXyef5f47DhwMxYS30Jd
        sGBqVN+S9E3Dfl3yPD9afo+A8Xc3Rs8WoJRCHPu+JZnu+W3Mp1xjKxCWN4IekXeqQpaYcbVtXl6
        PVmReAxS9uwIG
X-Received: by 2002:aca:914:: with SMTP id 20mr5020381oij.127.1623210244813;
        Tue, 08 Jun 2021 20:44:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiOhrEMyVtgLQBo67EDf2/4stemIf+VMSzBVFmnpTYPhQHv8SfxhuFyAnQ6mfPW5gU1WLg4w==
X-Received: by 2002:aca:914:: with SMTP id 20mr5020367oij.127.1623210244569;
        Tue, 08 Jun 2021 20:44:04 -0700 (PDT)
Received: from tstellar.remote.csb (97-120-191-69.ptld.qwest.net. [97.120.191.69])
        by smtp.gmail.com with ESMTPSA id v22sm3203492oic.37.2021.06.08.20.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 20:44:04 -0700 (PDT)
Subject: Re: [PATCH v2 bpf-next 06/11] libbpf: add BPF static linker APIs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@fb.com>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>
References: <20210313193537.1548766-7-andrii@kernel.org>
 <20210607231146.1077-1-tstellar@redhat.com>
 <CAEf4Bzad7OQj9JS7GVmBjAXyxKcc-nd77gxPQfFB8_hy_Xo+_g@mail.gmail.com>
 <b1bdf1df-e3a8-1ce8-fc33-4ab40b39fb06@redhat.com>
 <84b3cb2c-2dff-4cd8-724c-a1b56316816b@redhat.com>
 <CAEf4BzbCiMkQazSe2hky=Jx6QXZiZ2jyf+AuzMJEyAv+_B7vug@mail.gmail.com>
From:   Tom Stellard <tstellar@redhat.com>
Message-ID: <b322da84-95f3-2800-f2c8-556e9855d517@redhat.com>
Date:   Tue, 8 Jun 2021 20:44:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbCiMkQazSe2hky=Jx6QXZiZ2jyf+AuzMJEyAv+_B7vug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/7/21 9:08 PM, Andrii Nakryiko wrote:
> On Mon, Jun 7, 2021 at 7:41 PM Tom Stellard <tstellar@redhat.com> wrote:
>>
>> On 6/7/21 5:25 PM, Andrii Nakryiko wrote:
>>> On Mon, Jun 7, 2021 at 4:12 PM Tom Stellard <tstellar@redhat.com> wrote:
>>>>
>>>>
>>>> Hi,
>>>>
>>>>> +                               } else {
>>>>> +                                       pr_warn("relocation against STT_SECTION in non-exec section is not supported!\n");
>>>>> +                                       return -EINVAL;
>>>>> +                               }
>>>>
>>>> Kernel build of commit 324c92e5e0ee are failing for me with this error
>>>> message:
>>>>
>>>> /builddir/build/BUILD/kernel-5.13-rc4-61-g324c92e5e0ee/linux-5.13.0-0.rc4.20210603git324c92e5e0ee.35.fc35.x86_64/tools/bpf/bpftool/bpftool gen object /builddir/build/BUILD/kernel-5.13-rc4-61-g324c92e5e0ee/linux-5.13.0-0.rc4.20210603git324c92e5e0ee.35.fc35.x86_64/tools/testing/selftests/bpf/bind_perm.linked1.o /builddir/build/BUILD/kernel-5.13-rc4-61-g324c92e5e0ee/linux-5.13.0-0.rc4.20210603git324c92e5e0ee.35.fc35.x86_64/tools/testing/selftests/bpf/bind_perm.o
>>>> libbpf: relocation against STT_SECTION in non-exec section is not supported!
>>>>
>>>> What information can I provide to help debug this failure?
>>>
>>> Can you please send that bind_perm.o file? Also what's your `clang
>>> --version` output?
>>>
>>
>> clang version 12.0.0 (Fedora 12.0.0-2.fc35)
>>
>>>> I suspect this might be due to Clang commit 6a2ea84600ba ("BPF: Add
>>>> more relocation kinds"), but I get a different error on 324c92e5e0ee.
>>>> So meanwhile you might try applying 9f0c317f6aa1 ("libbpf: Add support
>>>> for new llvm bpf relocations") from bpf-next/master and check if that
>>>> helps. But please do share bind_perm.o, just to double-check what's
>>>> going on.
>>>>
>>
>> Here is bind_perm.o: https://fedorapeople.org/~tstellar/bind_perm.o
>>
> 
> So somehow you end up with .eh_frame section in BPF object file, which
> shouldn't ever happen. So there must be something that you are doing
> differently (compiler flags or something else) that makes Clang
> produce .eh_frame. So we need to figure out why .eh_frame gets
> generated. Not sure how, but maybe you have some ideas of what might
> be different about your build.
> 

Thanks for the pointer.  The problem was that in the Fedora kernel builds,
we enable -funwind-tables by default on all architectures, which is why the
.eh_frame section was there.  I fixed our clang builds, but I'm now getting
a new error when I run: CC=clang make -C tools/testing/selftests/bpf  V=1


/builddir/build/BUILD/kernel-5.13-rc4-61-g324c92e5e0ee/linux-5.13.0-0.rc4.20210603git324c92e5e0ee.35.fc35.x86_64/tools/testing/selftests/bpf/tools/sbin/bpftool gen skeleton /builddir/build/BUILD/kernel-5.13-rc4-61-g324c92e5e0ee/linux-5.13.0-0.rc4.20210603git324c92e5e0ee.35.fc35.x86_64/tools/testing/selftests/bpf/bpf_cubic.linked3.o name bpf_cubic > /builddir/build/BUILD/kernel-5.13-rc4-61-g324c92e5e0ee/linux-5.13.0-0.rc4.20210603git324c92e5e0ee.35.fc35.x86_64/tools/testing/selftests/bpf/bpf_cubic.skel.h
libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2

Here is the bpf_cubic.lined3.o object file: https://fedorapeople.org/~tstellar/bpf_cubic.linked3.o

-Tom



>> Thanks,
>> Tom
>>
>>>>
>>>>>
>>>>> Thanks,
>>>>> Tom
>>>>>
>>>>
>>>
>>
> 


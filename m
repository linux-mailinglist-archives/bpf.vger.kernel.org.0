Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A3D187905
	for <lists+bpf@lfdr.de>; Tue, 17 Mar 2020 06:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgCQFV0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Mar 2020 01:21:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46393 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgCQFV0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Mar 2020 01:21:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id c19so11269126pfo.13
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2020 22:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gct5Div9yO3xZ7uj+wMJ5J+JaU8FAOUzHSAPaDD/q3A=;
        b=VTzELuAKDRdhLYXZTeD6naICUU0PwcEisv0CUwH07hsgCDgTbAtpVqWKV0qVfjTAmM
         h77cznbW1Ye3Xvjab1cgE2z4+orY/pBhUOUrSywBm1geg+cdB6va27ONoD479vOr3rbk
         Jyhd7103Ppbo+lTH8L7Z9g4tE0X5cPew7Al4mBrwTJYmdL9YaWxCuI5t5GPXpxbvTRDO
         qZ0h2VpfbEpP9zd3RtKygyTzMBu/iGs6XKrFDxdxoj4Pkdzws4nl6Fu42fSDRFcfaTA3
         0nnnYy3vf+/75aESv5/5c11KKEx3bMfmgxYHP7oGnpqoJjtmYNstkPl8HoyXMEYv8R7N
         KQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gct5Div9yO3xZ7uj+wMJ5J+JaU8FAOUzHSAPaDD/q3A=;
        b=TwxYC01WvPv+k2bVdv+TG9W14OgraLq0O3ekg4qchJ/2znKFfkquKrzixMnGWyEbwm
         QRjtAhDAYc2+PKQcYNi1abPqPG3mJNDuQOBfs0xF6xL7iVQN80lF7uSXBR/UFMxHWBXD
         SdXnv23GNUP79n4twIQPkiEdg2cdomj6A6mm1UNatHKoHeyauGiLayfbL6mX0DzlgV9w
         vVnxBfErnqPxu5fBQswNVB/KFWRyS2ERIBpVc/8XBPQ2T1z3nrzvIHSlmqPBJjOJkg2+
         rXrkV9V3v3kF/s673apZCVTml0uxUPlmDJuak9mYj54pm/EQDYIwkaW1zmSp7t573Ycw
         MLQg==
X-Gm-Message-State: ANhLgQ173t/0u8XK5m8ObGOcPP+tBv2/0t4lEInYhUUxWJnaiEk2FhF0
        o0JvDBKTnDP/tDGCp0LBFskFyg==
X-Google-Smtp-Source: ADFU+vvXsZLUhxvYBpj8hFqsViWBU1qsKu1fkjaecEPliHmI0WaB0rpdd/Ajv2EFPQzHNAsDPS8Ycg==
X-Received: by 2002:a63:d143:: with SMTP id c3mr3197691pgj.171.1584422484251;
        Mon, 16 Mar 2020 22:21:24 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id e9sm1374336pjt.23.2020.03.16.22.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 22:21:23 -0700 (PDT)
Date:   Mon, 16 Mar 2020 22:21:20 -0700
From:   Fangrui Song <maskray@google.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com,
        Stanislav Fomichev <sdf@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf v2] bpf: Support llvm-objcopy and llvm-objdump for
 vmlinux BTF
Message-ID: <20200317052120.diawg3a75kxl5hkn@google.com>
References: <20200317011654.zkx5r7so53skowlc@google.com>
 <CAEf4BzYTJqWU++QnQupxFBWGSMPfGt6r-5u9jbeLnEF2ipw+Mw@mail.gmail.com>
 <20200317033701.w7jwos7mvfnde2t2@google.com>
 <CAEf4BzYyimAo2_513kW6hrDWwmzSDhNjTYksjy01ugKKTPt+qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzYyimAo2_513kW6hrDWwmzSDhNjTYksjy01ugKKTPt+qA@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2020-03-16, Andrii Nakryiko wrote:
>On Mon, Mar 16, 2020 at 8:37 PM Fangrui Song <maskray@google.com> wrote:
>>
>> On 2020-03-16, Andrii Nakryiko wrote:
>> >On Mon, Mar 16, 2020 at 6:17 PM Fangrui Song <maskray@google.com> wrote:
>> >>
>> >> Simplify gen_btf logic to make it work with llvm-objcopy and
>> >> llvm-objdump.  We just need to retain one section .BTF. To do so, we can
>> >> use a simple objcopy --only-section=.BTF instead of jumping all the
>> >> hoops via an architecture-less binary file.
>> >>
>> >> We use a dd comment to change the e_type field in the ELF header from
>> >> ET_EXEC to ET_REL so that .btf.vmlinux.bin.o will be accepted by lld.
>> >>
>> >> Fixes: df786c9b9476 ("bpf: Force .BTF section start to zero when dumping from vmlinux")
>> >> Cc: Stanislav Fomichev <sdf@google.com>
>> >> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> >> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>> >> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
>> >> Link: https://github.com/ClangBuiltLinux/linux/issues/871
>> >> Signed-off-by: Fangrui Song <maskray@google.com>
>> >> ---
>> >>  scripts/link-vmlinux.sh | 13 ++-----------
>> >>  1 file changed, 2 insertions(+), 11 deletions(-)
>> >>
>> >> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>> >> index dd484e92752e..84be8d7c361d 100755
>> >> --- a/scripts/link-vmlinux.sh
>> >> +++ b/scripts/link-vmlinux.sh
>> >> @@ -120,18 +120,9 @@ gen_btf()
>> >>
>> >>         info "BTF" ${2}
>> >>         vmlinux_link ${1}
>> >> -       LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
>> >
>> >Is it really tested? Seems like you just dropped .BTF generation step
>> >completely...
>>
>> Sorry, dropped the whole line:/
>> I don't know how to test .BTF . I can only check readelf -S...
>>
>> Attached the new patch.
>>
>>
>>  From 02afb9417d4f0f8d2175c94fc3797a94a95cc248 Mon Sep 17 00:00:00 2001
>> From: Fangrui Song <maskray@google.com>
>> Date: Mon, 16 Mar 2020 18:02:31 -0700
>> Subject: [PATCH bpf v2] bpf: Support llvm-objcopy and llvm-objdump for
>>   vmlinux BTF
>>
>> Simplify gen_btf logic to make it work with llvm-objcopy and llvm-objdump.
>> We use a dd comment to change the e_type field in the ELF header from
>> ET_EXEC to ET_REL so that .btf.vmlinux.bin.o can be accepted by lld.
>>
>> Fixes: df786c9b9476 ("bpf: Force .BTF section start to zero when dumping from vmlinux")
>> Cc: Stanislav Fomichev <sdf@google.com>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/871
>> Signed-off-by: Fangrui Song <maskray@google.com>
>> ---
>>   scripts/link-vmlinux.sh | 14 +++-----------
>>   1 file changed, 3 insertions(+), 11 deletions(-)
>>
>> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>> index dd484e92752e..b23313944c89 100755
>> --- a/scripts/link-vmlinux.sh
>> +++ b/scripts/link-vmlinux.sh
>> @@ -120,18 +120,10 @@ gen_btf()
>>
>>         info "BTF" ${2}
>>         vmlinux_link ${1}
>> -       LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
>> +       ${PAHOLE} -J ${1}
>
>I'm not sure why you are touching this line at all. LLVM_OBJCOPY part
>is necessary, pahole assumes llvm-objcopy by default, but that can
>(and should for objcopy) be overridden with LLVM_OBJCOPY.

Why is LLVM_OBJCOPY assumed? What if llvm-objcopy is not available?
This is confusing that one tool assumes llvm-objcopy while the block
below immediately uses GNU objcopy (without this patch).

e83b9f55448afce3fe1abcd1d10db9584f8042a6 "kbuild: add ability to
generate BTF type info for vmlinux" does not say why LLVM_OBJCOPY is
set.

>>
>> -       # dump .BTF section into raw binary file to link with final vmlinux
>> -       bin_arch=$(LANG=C ${OBJDUMP} -f ${1} | grep architecture | \
>> -               cut -d, -f1 | cut -d' ' -f2)
>> -       bin_format=$(LANG=C ${OBJDUMP} -f ${1} | grep 'file format' | \
>> -               awk '{print $4}')
>> -       ${OBJCOPY} --change-section-address .BTF=0 \
>> -               --set-section-flags .BTF=alloc -O binary \
>> -               --only-section=.BTF ${1} .btf.vmlinux.bin
>> -       ${OBJCOPY} -I binary -O ${bin_format} -B ${bin_arch} \
>> -               --rename-section .data=.BTF .btf.vmlinux.bin ${2}
>> +       # Extract .BTF section, change e_type to ET_REL, to link with final vmlinux
>> +       ${OBJCOPY} --only-section=.BTF ${1} ${2} && printf '\1' | dd of=${2} conv=notrunc bs=1 seek=16
>>   }
>>
>>   # Create ${2} .o file with all symbols from the ${1} object file
>> --
>> 2.25.1.481.gfbce0eb801-goog
>>

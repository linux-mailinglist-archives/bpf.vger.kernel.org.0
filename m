Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1158D18A208
	for <lists+bpf@lfdr.de>; Wed, 18 Mar 2020 18:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgCRR7Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Mar 2020 13:59:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44372 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgCRR7X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Mar 2020 13:59:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id 37so14090088pgm.11
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2020 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kK8JP8gd4yz+zOXP3vtIvRW8Qz1igXnbOxhMrNUKqQw=;
        b=hfXF8svZ86L1cETZEPg9HvNAwb66UiRvmKN+bJj9/LPUW23+ZJnhFkXZt2vkfk4N41
         xD8UBbPlFqq6HPuMi7TBSskEGC/r5NZru0h6YS4ooO05SHIE0r4nb6q5U9SfrZKGCmNg
         beVGj1KjYtTXlxJ9thNH4viVq7uZvkqwSn5lPJqMClE6nI9DG2GYBFfZniicDiwaCZke
         IjwD8qRNxoympLb+MulSBxoyTfHKOPmOEqvVwmMtelYRihzTudgUuSYP8Kpo2qsTha2M
         axMYGohi6+Q3PlCZRLVRuN3N6bhXuk6TCVkTuOdHKAYO2P13zC5gRlrrnZ6n4aHUzrOg
         6ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kK8JP8gd4yz+zOXP3vtIvRW8Qz1igXnbOxhMrNUKqQw=;
        b=dCClGugo4VSQpxg+oP4WX7q5lVBeZcoiWr0GXN7hLuIo4yjWMACNiSxgMXERvijuY9
         KdcR8R0rMkJZr3bMsLqrOPKOVIm0RPNsFqsQ1yULzle65BimwGO2kpH6viXIKL87V1Ks
         gw4KDxH3Mi1HpP7g6/4jlEuVuSFOrHRt79H6qY72nErmgmWDPlOm3EZU4VKENDAAeXNk
         ECdcvLHilcAdbP7MNkyRLwE2fW1TBFuUUS2h0NkR3tThh7eN3jN+WqxcWHNs/UR9R7nP
         94C5r2FrnJmpd7G+HphQZGPJSRGro8ZPD/aEeN6TgV4gvfKuMwh+cfzRw0WThhRVoL+a
         qpag==
X-Gm-Message-State: ANhLgQ2rHsCVeLj/sdb4CInOJzXshapy7PqTyXE+7+2gSB8iOKb8Epql
        dxt5fG12t++hamGO/M2EgdOhTw==
X-Google-Smtp-Source: ADFU+vtx8HWd/4/7T+SARBI6K7y/EeZzAPWKRCsQHTQHFVMDH+k9lKhAZfooP5yafBGgJZdFmUE1IA==
X-Received: by 2002:a62:83c3:: with SMTP id h186mr5544260pfe.4.1584554361726;
        Wed, 18 Mar 2020 10:59:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id j38sm6514734pgi.51.2020.03.18.10.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:59:20 -0700 (PDT)
Date:   Wed, 18 Mar 2020 10:59:18 -0700
From:   Fangrui Song <maskray@google.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com,
        Stanislav Fomichev <sdf@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH bpf-next v4] bpf: Support llvm-objcopy and llvm-objdump
 for vmlinux BTF
Message-ID: <20200318175918.ulpzopsao4sm6aei@google.com>
References: <20200317011654.zkx5r7so53skowlc@google.com>
 <CAEf4BzYTJqWU++QnQupxFBWGSMPfGt6r-5u9jbeLnEF2ipw+Mw@mail.gmail.com>
 <20200317033701.w7jwos7mvfnde2t2@google.com>
 <CAEf4BzYyimAo2_513kW6hrDWwmzSDhNjTYksjy01ugKKTPt+qA@mail.gmail.com>
 <20200317052120.diawg3a75kxl5hkn@google.com>
 <CAEf4BzYepRs4uB9vd1SCFY81H5S1kbvw2n9bKNeh-ORK_kutSg@mail.gmail.com>
 <20200317054359.snyyojyf6gjxufij@google.com>
 <20200317162405.GB2459609@mini-arch.hsd1.ca.comcast.net>
 <20200317205832.lna5phig2ed3bf2n@google.com>
 <CAEf4BzY8uzcpS8t0JW70V-DrrZ4MbeXOyEtCrpTtQyHW+uQcRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzY8uzcpS8t0JW70V-DrrZ4MbeXOyEtCrpTtQyHW+uQcRg@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2020-03-17, Andrii Nakryiko wrote:
>On Tue, Mar 17, 2020 at 1:58 PM Fangrui Song <maskray@google.com> wrote:
>>
>>
>> On 2020-03-17, Stanislav Fomichev wrote:
>> >On 03/16, Fangrui Song wrote:
>> >> On 2020-03-16, Andrii Nakryiko wrote:
>> >> > On Mon, Mar 16, 2020 at 10:21 PM Fangrui Song <maskray@google.com> wrote:
>> >> > >
>> >> > >
>> >> > > On 2020-03-16, Andrii Nakryiko wrote:
>> >> > > >On Mon, Mar 16, 2020 at 8:37 PM Fangrui Song <maskray@google.com> wrote:
>> >> > > >>
>> >> > > >> On 2020-03-16, Andrii Nakryiko wrote:
>> >> > > >> >On Mon, Mar 16, 2020 at 6:17 PM Fangrui Song <maskray@google.com> wrote:
>> >> > > >> >>
>> >> > > >> >> Simplify gen_btf logic to make it work with llvm-objcopy and
>> >> > > >> >> llvm-objdump.  We just need to retain one section .BTF. To do so, we can
>> >> > > >> >> use a simple objcopy --only-section=.BTF instead of jumping all the
>> >> > > >> >> hoops via an architecture-less binary file.
>> >> > > >> >>
>> >> > > >> >> We use a dd comment to change the e_type field in the ELF header from
>> >> > > >> >> ET_EXEC to ET_REL so that .btf.vmlinux.bin.o will be accepted by lld.
>> >> > > >> >>
>> >> > > >> >> Fixes: df786c9b9476 ("bpf: Force .BTF section start to zero when dumping from vmlinux")
>> >> > > >> >> Cc: Stanislav Fomichev <sdf@google.com>
>> >> > > >> >> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> >> > > >> >> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>> >> > > >> >> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
>> >> > > >> >> Link: https://github.com/ClangBuiltLinux/linux/issues/871
>> >> > > >> >> Signed-off-by: Fangrui Song <maskray@google.com>
>> >> > > >> >> ---
>> >> > > >> >>  scripts/link-vmlinux.sh | 13 ++-----------
>> >> > > >> >>  1 file changed, 2 insertions(+), 11 deletions(-)
>> >> > > >> >>
>> >> > > >> >> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>> >> > > >> >> index dd484e92752e..84be8d7c361d 100755
>> >> > > >> >> --- a/scripts/link-vmlinux.sh
>> >> > > >> >> +++ b/scripts/link-vmlinux.sh
>> >> > > >> >> @@ -120,18 +120,9 @@ gen_btf()
>> >> > > >> >>
>> >> > > >> >>         info "BTF" ${2}
>> >> > > >> >>         vmlinux_link ${1}
>> >> > > >> >> -       LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
>> >> > > >> >
>> >> > > >> >Is it really tested? Seems like you just dropped .BTF generation step
>> >> > > >> >completely...
>> >> > > >>
>> >> > > >> Sorry, dropped the whole line:/
>> >> > > >> I don't know how to test .BTF . I can only check readelf -S...
>> >> > > >>
>> >> > > >> Attached the new patch.
>> >> > > >>
>> >> > > >>
>> >> > > >>  From 02afb9417d4f0f8d2175c94fc3797a94a95cc248 Mon Sep 17 00:00:00 2001
>> >> > > >> From: Fangrui Song <maskray@google.com>
>> >> > > >> Date: Mon, 16 Mar 2020 18:02:31 -0700
>> >> > > >> Subject: [PATCH bpf v2] bpf: Support llvm-objcopy and llvm-objdump for
>> >> > > >>   vmlinux BTF
>> >> > > >>
>> >> > > >> Simplify gen_btf logic to make it work with llvm-objcopy and llvm-objdump.
>> >> > > >> We use a dd comment to change the e_type field in the ELF header from
>> >> > > >> ET_EXEC to ET_REL so that .btf.vmlinux.bin.o can be accepted by lld.
>> >> > > >>
>> >> > > >> Fixes: df786c9b9476 ("bpf: Force .BTF section start to zero when dumping from vmlinux")
>> >> > > >> Cc: Stanislav Fomichev <sdf@google.com>
>> >> > > >> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> >> > > >> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
>> >> > > >> Link: https://github.com/ClangBuiltLinux/linux/issues/871
>> >> > > >> Signed-off-by: Fangrui Song <maskray@google.com>
>> >> > > >> ---
>> >> > > >>   scripts/link-vmlinux.sh | 14 +++-----------
>> >> > > >>   1 file changed, 3 insertions(+), 11 deletions(-)
>> >> > > >>
>> >> > > >> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>> >> > > >> index dd484e92752e..b23313944c89 100755
>> >> > > >> --- a/scripts/link-vmlinux.sh
>> >> > > >> +++ b/scripts/link-vmlinux.sh
>> >> > > >> @@ -120,18 +120,10 @@ gen_btf()
>> >> > > >>
>> >> > > >>         info "BTF" ${2}
>> >> > > >>         vmlinux_link ${1}
>> >> > > >> -       LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
>> >> > > >> +       ${PAHOLE} -J ${1}
>> >> > > >
>> >> > > >I'm not sure why you are touching this line at all. LLVM_OBJCOPY part
>> >> > > >is necessary, pahole assumes llvm-objcopy by default, but that can
>> >> > > >(and should for objcopy) be overridden with LLVM_OBJCOPY.
>> >> > >
>> >> > > Why is LLVM_OBJCOPY assumed? What if llvm-objcopy is not available?
>> >> >
>> >> > It's pahole assumption that we have to live with. pahole assumes
>> >> > llvm-objcopy internally, unless it is overriden with LLVM_OBJCOPY env
>> >> > var. So please revert this line otherwise you are breaking it for GCC
>> >> > objcopy case.
>> >>
>> >> Acknowledged. Uploaded v3.
>> >>
>> >> I added back 2>/dev/null which was removed by a previous change, to
>> >> suppress GNU objcopy warnings. The warnings could be annoying in V=1
>> >> output.
>> >>
>> >> > > This is confusing that one tool assumes llvm-objcopy while the block
>> >> > > below immediately uses GNU objcopy (without this patch).
>> >> > >
>> >> > > e83b9f55448afce3fe1abcd1d10db9584f8042a6 "kbuild: add ability to
>> >> > > generate BTF type info for vmlinux" does not say why LLVM_OBJCOPY is
>> >> > > set.
>> >> > >
>> >> > > >>
>> >> > > >> -       # dump .BTF section into raw binary file to link with final vmlinux
>> >> > > >> -       bin_arch=$(LANG=C ${OBJDUMP} -f ${1} | grep architecture | \
>> >> > > >> -               cut -d, -f1 | cut -d' ' -f2)
>> >> > > >> -       bin_format=$(LANG=C ${OBJDUMP} -f ${1} | grep 'file format' | \
>> >> > > >> -               awk '{print $4}')
>> >> > > >> -       ${OBJCOPY} --change-section-address .BTF=0 \
>> >> > > >> -               --set-section-flags .BTF=alloc -O binary \
>> >> > > >> -               --only-section=.BTF ${1} .btf.vmlinux.bin
>> >> > > >> -       ${OBJCOPY} -I binary -O ${bin_format} -B ${bin_arch} \
>> >> > > >> -               --rename-section .data=.BTF .btf.vmlinux.bin ${2}
>> >> > > >> +       # Extract .BTF section, change e_type to ET_REL, to link with final vmlinux
>> >> > > >> +       ${OBJCOPY} --only-section=.BTF ${1} ${2} && printf '\1' | dd of=${2} conv=notrunc bs=1 seek=16
>> >> > > >>   }
>> >> > > >>
>> >> > > >>   # Create ${2} .o file with all symbols from the ${1} object file
>> >> > > >> --
>> >> > > >> 2.25.1.481.gfbce0eb801-goog
>> >> > > >>
>> >>
>> >> From ca3597477542453e9f63185c27c162da081a4baf Mon Sep 17 00:00:00 2001
>> >> From: Fangrui Song <maskray@google.com>
>> >> Date: Mon, 16 Mar 2020 22:38:23 -0700
>> >> Subject: [PATCH bpf v3] bpf: Support llvm-objcopy and llvm-objdump for
>> >>  vmlinux BTF
>> >>
>> >> Simplify gen_btf logic to make it work with llvm-objcopy and llvm-objdump.
>> >> Add 2>/dev/null to suppress GNU objcopy (but not llvm-objcopy) warnings
>> >> "empty loadable segment detected at vaddr=0xffffffff81000000, is this intentional?"
>> >> Our use of --only-section drops many SHF_ALLOC sections which will essentially nullify
>> >> program headers. When used as linker input, program headers are simply
>> >> ignored.
>> >>
>> >> We use a dd command to change the e_type field in the ELF header from
>> >> ET_EXEC to ET_REL so that .btf.vmlinux.bin.o can be accepted by lld.
>> >> Accepting ET_EXEC as an input file is an extremely rare GNU ld feature
>> >> that lld does not intend to support, because this is very error-prone.
>> >>
>> >> Fixes: df786c9b9476 ("bpf: Force .BTF section start to zero when dumping from vmlinux")
>> >> Cc: Stanislav Fomichev <sdf@google.com>
>> >> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> >> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
>> >> Link: https://github.com/ClangBuiltLinux/linux/issues/871
>> >> Signed-off-by: Fangrui Song <maskray@google.com>
>> >> ---
>> >>  scripts/link-vmlinux.sh | 12 ++----------
>> >>  1 file changed, 2 insertions(+), 10 deletions(-)
>> >>
>> >> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>> >> index dd484e92752e..c3e808a89d4a 100755
>> >> --- a/scripts/link-vmlinux.sh
>> >> +++ b/scripts/link-vmlinux.sh
>> >> @@ -122,16 +122,8 @@ gen_btf()
>> >>      vmlinux_link ${1}
>> >>      LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
>> >> -    # dump .BTF section into raw binary file to link with final vmlinux
>> >> -    bin_arch=$(LANG=C ${OBJDUMP} -f ${1} | grep architecture | \
>> >> -            cut -d, -f1 | cut -d' ' -f2)
>> >> -    bin_format=$(LANG=C ${OBJDUMP} -f ${1} | grep 'file format' | \
>> >> -            awk '{print $4}')
>> >> -    ${OBJCOPY} --change-section-address .BTF=0 \
>> >> -            --set-section-flags .BTF=alloc -O binary \
>> >> -            --only-section=.BTF ${1} .btf.vmlinux.bin
>> >> -    ${OBJCOPY} -I binary -O ${bin_format} -B ${bin_arch} \
>> >> -            --rename-section .data=.BTF .btf.vmlinux.bin ${2}
>> >> +    # Extract .BTF section, change e_type to ET_REL, to link with final vmlinux
>> >> +    ${OBJCOPY} --only-section=.BTF ${1} ${2} 2> /dev/null && printf '\1' | dd of=${2} conv=notrunc bs=1 seek=16
>> >No, it doesn't work unfortunately, I get "in-kernel BTF is malformed"
>> >from the kernel.
>> >
>> >I think that's because -O binary adds the following:
>> >$ nm .btf.vmxlinux.bin
>> >00000000002f7bc9 D _binary__btf_vmlinux_bin_end
>> >00000000002f7bc9 A _binary__btf_vmlinux_bin_size
>> >0000000000000000 D _binary__btf_vmlinux_bin_start
>> >
>> >While non-binary mode doesn't:
>> >$ nm .btf.vmxlinux.bin
>> >
>> >We don't add them manually in the linker map and expect objcopy to add
>> >them, see:
>> >https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/btf.c#n3480
>>
>> Attached v4.
>>
>> * Added status=none to the dd command to suppress stderr output.
>> * `objcopy -I binary` synthesized symbols are only used in BTF, not
>> elsewhere. I think we can replace it with a more common trick,
>> __start_$sectionname __stop_$sectionname.
>> * GNU ld<2.23 can define __start_BTF and __stop_BTF as SHN_ABS.
>>    I think it is totally fine for a SHN_ABS symbol to be referenced by an
>>    R_X86_64_32S (absolute relocation), but arch/x86/tools/relocs.c
>>    contains an unnecessarily rigid check that rejects this.
>>
>>    ...
>>    Invalid absolute R_X86_64_32S relocation: __start_BTF
>>    make[3]: *** [arch/x86/boot/compressed/Makefile:123:
>>    arch/x86/boot/compressed/vmlinux.relocs] Error 1
>>
>>    Since we are going to bump binutils version requirement to 2.23, which
>>    will completely avoid the issue. I will not mention it again.
>>    https://lore.kernel.org/lkml/202003161354.538479F16@keescook/
>>
>> * I should mention that an orphan BTF (previously .BTF) could trigger
>>    a --orphan-handling=warn warning. So eventually we might need to
>>    add an output section description
>>
>>      BTF : { *(BTF) }
>>
>>    to the vmlinux linker script for every arch.
>>    I'll not do that in this patch, though.
>>
>> >
>> >>  }
>> >>  # Create ${2} .o file with all symbols from the ${1} object file
>> >> --
>> >> 2.25.1.481.gfbce0eb801-goog
>> >>
>>
>>  From 9b694d68fefe041464eccb948f6d246fab67942d Mon Sep 17 00:00:00 2001
>> From: Fangrui Song <maskray@google.com>
>> Date: Tue, 17 Mar 2020 13:51:04 -0700
>> Subject: [PATCH bpf-next v4] bpf: Support llvm-objcopy and
>>   llvm-objdump for vmlinux BTF
>>
>> Simplify gen_btf logic to make it work with llvm-objcopy and llvm-objdump.
>> The existing 'file format' and 'architecture' parsing logic is brittle
>> and does not work with llvm-objcopy/llvm-objdump.
>>
>> .BTF in .tmp_vmlinux.btf is non-SHF_ALLOC. Add the SHF_ALLOC flag and
>> rename .BTF to BTF so that C code can reference the section via linker
>> synthesized __start_BTF and __stop_BTF. This fixes a small problem that
>> previous .BTF had the SHF_WRITE flag. Additionally, `objcopy -I binary`
>> synthesized symbols _binary__btf_vmlinux_bin_start and
>> _binary__btf_vmlinux_bin_start (not used elsewhere) are replaced with
>> more common __start_BTF and __stop_BTF.
>>
>> Add 2>/dev/null because GNU objcopy (but not llvm-objcopy) warns
>> "empty loadable segment detected at vaddr=0xffffffff81000000, is this intentional?"
>>
>> We use a dd command to change the e_type field in the ELF header from
>> ET_EXEC to ET_REL so that lld will accept .btf.vmlinux.bin.o.  Accepting
>> ET_EXEC as an input file is an extremely rare GNU ld feature that lld
>> does not intend to support, because this is error-prone.
>>
>> Fixes: df786c9b9476 ("bpf: Force .BTF section start to zero when dumping from vmlinux")
>> Cc: Stanislav Fomichev <sdf@google.com>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/871
>> Signed-off-by: Fangrui Song <maskray@google.com>
>> ---
>>   kernel/bpf/btf.c        |  9 ++++-----
>>   kernel/bpf/sysfs_btf.c  | 11 +++++------
>>   scripts/link-vmlinux.sh | 16 ++++++----------
>>   3 files changed, 15 insertions(+), 21 deletions(-)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 787140095e58..51fff49de561 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -3477,8 +3477,8 @@ static struct btf *btf_parse(void __user *btf_data, u32 btf_data_size,
>>         return ERR_PTR(err);
>>   }
>>
>> -extern char __weak _binary__btf_vmlinux_bin_start[];
>> -extern char __weak _binary__btf_vmlinux_bin_end[];
>> +extern char __weak __start_BTF[];
>> +extern char __weak __stop_BTF[];
>>   extern struct btf *btf_vmlinux;
>>
>>   #define BPF_MAP_TYPE(_id, _ops)
>> @@ -3605,9 +3605,8 @@ struct btf *btf_parse_vmlinux(void)
>>         }
>>         env->btf = btf;
>>
>> -       btf->data = _binary__btf_vmlinux_bin_start;
>> -       btf->data_size = _binary__btf_vmlinux_bin_end -
>> -               _binary__btf_vmlinux_bin_start;
>> +       btf->data = __start_BTF;
>> +       btf->data_size = __stop_BTF - __start_BTF;
>>
>>         err = btf_parse_hdr(env);
>>         if (err)
>> diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
>> index 7ae5dddd1fe6..3b495773de5a 100644
>> --- a/kernel/bpf/sysfs_btf.c
>> +++ b/kernel/bpf/sysfs_btf.c
>> @@ -9,15 +9,15 @@
>>   #include <linux/sysfs.h>
>>
>>   /* See scripts/link-vmlinux.sh, gen_btf() func for details */
>> -extern char __weak _binary__btf_vmlinux_bin_start[];
>> -extern char __weak _binary__btf_vmlinux_bin_end[];
>> +extern char __weak __start_BTF[];
>> +extern char __weak __stop_BTF[];
>>
>>   static ssize_t
>>   btf_vmlinux_read(struct file *file, struct kobject *kobj,
>>                  struct bin_attribute *bin_attr,
>>                  char *buf, loff_t off, size_t len)
>>   {
>> -       memcpy(buf, _binary__btf_vmlinux_bin_start + off, len);
>> +       memcpy(buf, __start_BTF + off, len);
>>         return len;
>>   }
>>
>> @@ -30,15 +30,14 @@ static struct kobject *btf_kobj;
>>
>>   static int __init btf_vmlinux_init(void)
>>   {
>> -       if (!_binary__btf_vmlinux_bin_start)
>> +       if (!__start_BTF)
>>                 return 0;
>>
>>         btf_kobj = kobject_create_and_add("btf", kernel_kobj);
>>         if (!btf_kobj)
>>                 return -ENOMEM;
>>
>> -       bin_attr_btf_vmlinux.size = _binary__btf_vmlinux_bin_end -
>> -                                   _binary__btf_vmlinux_bin_start;
>> +       bin_attr_btf_vmlinux.size = __stop_BTF - __start_BTF;
>>
>>         return sysfs_create_bin_file(btf_kobj, &bin_attr_btf_vmlinux);
>>   }
>> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>> index dd484e92752e..c0d2ecf1bff7 100755
>> --- a/scripts/link-vmlinux.sh
>> +++ b/scripts/link-vmlinux.sh
>> @@ -122,16 +122,12 @@ gen_btf()
>>         vmlinux_link ${1}
>>         LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
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
>> +       # Extract .BTF, add SHF_ALLOC, rename to BTF so that we can reference
>> +       # it via linker synthesized __start_BTF and __stop_BTF. Change e_type
>> +       # to ET_REL so that it can be used to link final vmlinux.
>> +       ${OBJCOPY} --only-section=.BTF --set-section-flags .BTF=alloc,readonly \
>> +               --rename-section .BTF=BTF ${1} ${2} 2>/dev/null && \
>
>You can't just rename .BTF into BTF. ".BTF" is part of BTF
>specification, tools like bpftool rely on that specific name. Libbpf
>relies on this name as well. It cannot be changed. Please stop making
>arbitrary changes and breaking stuff, please.

I can't find anything which really assumes ".BTF" under tools/bpf/bpftool

% grep -r '\.BTF'
Documentation/bpftool-btf.rst:            .BTF section with well-defined BTF binary format data,

>
>> +               printf '\1' | dd of=${2} conv=notrunc bs=1 seek=16 status=none
>
>I wonder if there is any less hacky and more obvious way to achieve this?..

No. As a maintainer of lld/ELF, I abandoned https://reviews.llvm.org/D76174 .
Also as a maintainer of LLVM binary utilities, I have to complain the whole
scheme is really hacky and did not get enough scrutiny when they were merged.

A previous comment said pahole somehow relied on llvm-objcopy so LLVM_OBJCOPY
is used, while llvm-objcopy/llvm-objdump are not really supported...  Note, on
March 16, I just pushed https://reviews.llvm.org/D76046 to make llvm-objdump
print bfdnames to some part of the existing hacks happy...

I am trying my best to make this stuff better.
BTF, when merged into LLVM in December 2018, was not really the best example demonstrating how a subproject should be merged...
OK, I'll stop complaining here.

commit cb0cc635c7a9fa8a3a0f75d4d896721819c63add "powerpc: Include .BTF section"
places .BTF somewhere in the writable section area, so if you insist on ".BTF",
I'll make a similar change and add some stuff to arch/x86/kernel/vmlinux.lds.S

>Also, this script has `set -e` at the top, so you don't have to chain
>all command with &&, you put this on separate line with the same
>effect, but it will look less confusing.

Not using section "BTF" has the downside that we have to add

.BTF : {
   PROVIDE(__start_BTF = .);
   *(.BTF)
   PROVIDE(__stop_BTF = .);
}

to every arch/*/kernel/vmlinux.lds.S which can use BTF.

>>   }
>>
>>   # Create ${2} .o file with all symbols from the ${1} object file
>> --
>> 2.25.1.481.gfbce0eb801-goog
>>

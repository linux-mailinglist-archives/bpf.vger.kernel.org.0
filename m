Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81DB71934B7
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 00:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgCYXmU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 19:42:20 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45274 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgCYXmU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 19:42:20 -0400
Received: by mail-vk1-f195.google.com with SMTP id b187so1201809vkh.12
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 16:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NJTDUzMQxgbt5FoYCcRtnrSaEsa4v/zg/qqads6NNnk=;
        b=UuN1EQOO9NetOOVOpWuocBVvbk3G/6HyLyKjzHvvVMgI2naKPkJdAIQ6ufa6WggY+D
         eBE5sRF8Ku/0cQyg06LS8SRoLdWTldmN90Gr48YufIOIJntz9rOJ4Gqb/KuOmcnxE2Xv
         /jjdfELD8j6iOMfXWNGVMQVLBwas8SpXpjxu+80u8f0UMJv0UBf5NuYkaefjPol4BJds
         75u75tPvYfrKZX0Z5doIrIsS0ee0QWwUKu6MR+IFXzxbUxOTDkA4EGJtwmqa9UUS5sog
         pLixWafN1hNLftHlCPRe70TdXEWX95EpP85xhuKY0ea40U5yR9h4C8i3GvbV/tS32JPZ
         k/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NJTDUzMQxgbt5FoYCcRtnrSaEsa4v/zg/qqads6NNnk=;
        b=j961ZkEbQQeLk3hTVmuHDVAVWSDVbnffpkC5MKqQnqxlsixmrQbAeYvCqMYEEtEJnM
         DeUO3e3ogMlskc+FM9JC7AqKdZh9uN/9Yav8TRio1nQcbM7P+ljGObSeJ98YofxsA1vP
         P1BKM3BwU6ZLMitxnhnhc2LzcvMGIMoIhZ0sR8HXgha3KFlYBmilLjNlpNJ9DbwASenR
         rXqu6wsoFn3b2Jpc4ttBHCp86vpxuyYnKyWx9Pw1xMjIwy4EG7l0c7CwUBVTGeWWy/9G
         g7jL5+oa9THv5BU1dL7CTH+ExhWrK1cuQxbAfjbvKCE/sGcKp4qX0x2zH4fS4/eb4zRR
         km+g==
X-Gm-Message-State: ANhLgQ0EpT3FZNonaCCDqbb+nIZnrm8TBBZsW8bCMBT13iiDpdbD+o3U
        gjSs3mh1Wwo25+iljivnvcDm16uKOCq0C6hc8DU=
X-Google-Smtp-Source: ADFU+vthbsy4SiGDWM7V6xGzbvz0ZgIuKXi2Ecy+deEdS+4HGPx7A74csdmKqKBiAZs6zDXFHCMbrXtDn1B3eWoaj94=
X-Received: by 2002:a1f:5544:: with SMTP id j65mr4156269vkb.27.1585179739261;
 Wed, 25 Mar 2020 16:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyo_hqRCs6hp7w6zWEf5RzEZF6zyXj_Bb_AgXVKgab7tg06NQ@mail.gmail.com>
 <20200325222345.GA27005@chromium.org>
In-Reply-To: <20200325222345.GA27005@chromium.org>
From:   Matt Cover <werekraken@gmail.com>
Date:   Wed, 25 Mar 2020 16:42:07 -0700
Message-ID: <CAGyo_hoS0t-ADUxt7gqGYpU=8oZx=Asxsdxq=mzbP9v78rgMmA@mail.gmail.com>
Subject: Re: libbpf/BTF loading issue with fentry/fexit selftests
To:     KP Singh <kpsingh@chromium.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 25, 2020 at 3:23 PM KP Singh <kpsingh@chromium.org> wrote:
>
> On 25-M=C3=A4r 15:16, Matt Cover wrote:
> > I'm looking to explore the bpf trampoline Alexei introduced for
> > tracing progs, but am encountering a libbpf/BTF issue with loading
> > the selftests. Hoping you guys might have a pointer or two.
> >
> > The kernel build used pahole 1.15. All llvm-project components used
> > in compiling the selftests were 10.0.0-rc6.
> >
> > I believe the following confirms that BTF is indeed present in this ker=
nel.
> >
> >
> > [vagrant@localhost bpf]$ uname -r
> > 5.5.9-1.btf.el7.x86_64
> > [vagrant@localhost bpf]$ grep CONFIG_DEBUG_INFO_BTF /boot/config-`uname=
 -r`
>
> It seems like you might have CONFIG_TEST_BPF disabled.
>
> This is explained in Documentation/filter.txt:
>
> Testing
> -------
>
> Next to the BPF toolchain, the kernel also ships a test module that
> contains various test cases for classic and internal BPF that can be
> executed against the BPF interpreter and JIT compiler. It can be found
> in lib/test_bpf.c and enabled via Kconfig:
>
>   CONFIG_TEST_BPF=3Dm
>
> After the module has been built and installed, the test suite can be
> executed via insmod or modprobe against 'test_bpf' module. Results of
> the test cases including timings in nsec can be found in the kernel
> log (dmesg).

Thanks for the info KP. Unfortunately, the issue remains with
CONFIG_TEST_BPF=3Dm and test_bpf loaded.


[vagrant@localhost bpf]$ uname -r
5.5.9-1.btf.1.el7.x86_64
[vagrant@localhost bpf]$ grep CONFIG_TEST_BPF /boot/config-`uname -r`
CONFIG_TEST_BPF=3Dm
[vagrant@localhost bpf]$ sudo modprobe test_bpf
[vagrant@localhost bpf]$ ~/bpftool btf dump file
/sys/kernel/btf/vmlinux | grep -i 'fentry\|fexit'
    'BPF_TRAMP_FENTRY' val=3D0
    'BPF_TRAMP_FEXIT' val=3D1
    'BPF_TRACE_FENTRY' val=3D24
    'BPF_TRACE_FEXIT' val=3D25
[vagrant@localhost bpf]$ sudo ./test_progs -t fexit_test | grep '^libbpf\|F=
AIL'
libbpf: Error loading BTF: Invalid argument(22)
libbpf: magic: 0xeb9f
libbpf: Error loading .BTF into kernel: -22.
libbpf: Error loading BTF: Invalid argument(22)
libbpf: magic: 0xeb9f
libbpf: Error loading .BTF into kernel: -22.
libbpf: fexit/bpf_fentry_test1 is not found in vmlinux BTF
test_fexit_test:FAIL:prog_load fail err -2 errno 22
#10 fexit_test:FAIL
Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED


The -vvv output didn't change, so forgoing a second copy.

>
> - KP
>
> > CONFIG_DEBUG_INFO_BTF=3Dy
> > [vagrant@localhost bpf]$ ~/bpftool btf dump file ~/vmlinux-`uname -r`
> > | grep -i fexit
> >     'BPF_TRAMP_FEXIT' val=3D1
> >     'BPF_TRACE_FEXIT' val=3D25
>
> [...]
>
> > libbpf: collecting relocating info for: 'fexit/bpf_fentry_test6'
> > libbpf: relo for shdr 16, symb 32, value 40, type 1, bind 1, name 34
> > ('test6_result'), insn 18
> > libbpf: found data map 0 (fexit_te.bss, sec 16, off 0) for insn 18
> > libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
> > libbpf: fexit/bpf_fentry_test1 is not found in vmlinux BTF
> > test_fexit_test:FAIL:prog_load fail err -2 errno 22
> > #10 fexit_test:FAIL
> > Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
> >
> >
> > Any hints on the issue?
> >
> > -Matt C.

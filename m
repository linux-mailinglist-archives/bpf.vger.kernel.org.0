Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADBA619354A
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 02:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCZBbu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 21:31:50 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45788 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCZBbu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 21:31:50 -0400
Received: by mail-qv1-f67.google.com with SMTP id g4so2155820qvo.12
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 18:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j7FF/lCI/a6VDmrNhXy3egXWTeVlilEZ3s3aRmfHp3I=;
        b=BE6s4N273DnP0qW/SJ/wwQtXQJKHkkR79+L+Qgspixv5sl0B7/LcafoSejmVvt2bBi
         6MDlmYY35GrIEKv44UbLbZW9r7VxfJpgrUrAMlcOu6tFu2/EaeAS0SCCxD1ejnaxpE/Y
         muD/9PKSDIYg9vNakt/5SJomno/b2WBz5CW8SXQzXQx+L2ysDwIqJNOP/XEOz0BgPGwb
         t+9Ancu4gZQqjbk00IHOPzb174jgpyt5xnL87HSALeonRLPaHd3DhKCdswdW4UB2mL75
         9azhcZWvc/MsNxjFNwRRmCzwGjfh78NBGz7WmDIN8K+oDWv9rfLd+fPcI5quBImw75eT
         dVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j7FF/lCI/a6VDmrNhXy3egXWTeVlilEZ3s3aRmfHp3I=;
        b=E53Uv42+mdG4rEMULqW+iZyyEVEc8Cajv4l6SWl563fTcEBd1cvnIDf3ZFu7vl2X6Z
         xMhp2uXtY9HcD37Kw2+np9nsFfI3XvgHgw1MLuf5PCkl8DX4G0RyDP/XfSow9nYtywRH
         tkmVuqkCdl6gOVf60ysh5DvzuTUqzfxM8rOtRUT3v6IPQHthHAFR99LVlJqZ3HPXEFSk
         0R5jy2+Q80fnkR5N2KCQ2RRSOjQe0lNtI4vND+vQgHeKMACwqh4o8q1lP89mi058oX55
         r8li1TEBC0LrMZQHPxaZ8u2mor4C2BU15kNnUlT3WoM0Ns42QbkATT8ZJUYNVedKmpYy
         z/lw==
X-Gm-Message-State: ANhLgQ03L7jx2ISJEM20Mm8ljSqTCwV0MYbkMm+84qoKDAF2coOhmecj
        EnHm5ulQZ7OzFsxqpt9JQXBfgollEuza8bDWTYo=
X-Google-Smtp-Source: ADFU+vsnpZDMuRbXhPDxp8QXi30mqWNYG4TEyDdsCOC4PqVgCi9keQ9RPiQVVZqSeEBA6GYj3nN2iA2gmsAidIuKYwA=
X-Received: by 2002:a0c:ee28:: with SMTP id l8mr5964886qvs.196.1585186309008;
 Wed, 25 Mar 2020 18:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyo_hqRCs6hp7w6zWEf5RzEZF6zyXj_Bb_AgXVKgab7tg06NQ@mail.gmail.com>
In-Reply-To: <CAGyo_hqRCs6hp7w6zWEf5RzEZF6zyXj_Bb_AgXVKgab7tg06NQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 25 Mar 2020 18:31:38 -0700
Message-ID: <CAEf4BzbN0rdiLvSe3_669FMKcV99RXrnKAKDtr8GnRP+4omQsw@mail.gmail.com>
Subject: Re: libbpf/BTF loading issue with fentry/fexit selftests
To:     Matt Cover <werekraken@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 25, 2020 at 3:16 PM Matt Cover <werekraken@gmail.com> wrote:
>
> I'm looking to explore the bpf trampoline Alexei introduced for
> tracing progs, but am encountering a libbpf/BTF issue with loading
> the selftests. Hoping you guys might have a pointer or two.
>
> The kernel build used pahole 1.15. All llvm-project components used
> in compiling the selftests were 10.0.0-rc6.
>
> I believe the following confirms that BTF is indeed present in this kernel.

BTF is, but that BTF doesn't have information about FUNCs (only
FUNC_PROTOs). You need pahole 1.16 for fentry/fexit.

>
>
> [vagrant@localhost bpf]$ uname -r
> 5.5.9-1.btf.el7.x86_64
> [vagrant@localhost bpf]$ grep CONFIG_DEBUG_INFO_BTF /boot/config-`uname -r`
> CONFIG_DEBUG_INFO_BTF=y
> [vagrant@localhost bpf]$ ~/bpftool btf dump file ~/vmlinux-`uname -r`
> | grep -i fexit
>     'BPF_TRAMP_FEXIT' val=1
>     'BPF_TRACE_FEXIT' val=25
> [vagrant@localhost bpf]$ ~/bpftool btf dump file
> /sys/kernel/btf/vmlinux | grep -i fexit
>     'BPF_TRAMP_FEXIT' val=1
>     'BPF_TRACE_FEXIT' val=25
>
>
> The fexit_test.o file also has BTF information.
>
>
> [vagrant@localhost bpf]$ ~/bpftool btf dump file fexit_test.o | grep FUNC_PROTO
> [4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
> [7] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
> [9] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
> [11] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
> [13] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
> [15] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
>
>
> However, I get libbpf/BTF load errors when trying to run any
> fentry/fexit tests.
>
>
> [vagrant@localhost bpf]$ sudo ./test_progs -t fexit_test | grep '^libbpf\|FAIL'
> libbpf: Error loading BTF: Invalid argument(22)
> libbpf: magic: 0xeb9f
> libbpf: Error loading .BTF into kernel: -22.
> libbpf: Error loading BTF: Invalid argument(22)
> libbpf: magic: 0xeb9f
> libbpf: Error loading .BTF into kernel: -22.
> libbpf: fexit/bpf_fentry_test1 is not found in vmlinux BTF
> test_fexit_test:FAIL:prog_load fail err -2 errno 22
> #10 fexit_test:FAIL
> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>
>
> I saw in a similar thread that -vvv output was requested. Figured the
> same applies here.

Yeah, for tricky issues that good. In this case it was pretty obvious,
but generally it's a good idea for sure, thanks!
>
>
> [vagrant@localhost bpf]$ sudo ./test_progs -vvv -t fexit_test | grep
> '^libbpf\|FAIL'

[...]

>
>
> Any hints on the issue?
>
> -Matt C.

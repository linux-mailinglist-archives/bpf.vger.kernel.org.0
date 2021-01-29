Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F22308423
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 04:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhA2DKS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 22:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhA2DKM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 22:10:12 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811E8C061573
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 19:09:32 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b17so4486416plz.6
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 19:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Vowffm/uWYAuRc4NMlcIieuGC83Zcq0grxm2Vfy4pqs=;
        b=1e+UPGNT8kTAhcMluRWwpTWq+ug0PhhH7QtZaGKbasByBr2io1O6T7hcp37s9PTIVT
         n5ROCfu/ykFcripX6m4UR8wYXSg4b+hUaIGaQm/nYewyYbfSZ2Lozzp2J7T56boYwjGD
         lotgOuHLf8T6n2YhjakHHBu0KvayWlmmg9VwpZw2mat4rzDnPWDVsj81egSSTNIXhw45
         lcIBfHxrttn85XVjjETFa/oWyLFi4bIH1naaM4I61DLXRTnBWF2k25euqwsrFeu1hNhT
         mvCXGHnbI45rn1mdeSVZWYEgTTIiW/BYUil0pRn52RmAvcVyARLzVI3XLz5blVttp0Ic
         gvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Vowffm/uWYAuRc4NMlcIieuGC83Zcq0grxm2Vfy4pqs=;
        b=IHbJnUiYUp3f6EdsQlRArEESD6bechQy1HpiRqEdd+5dlXfarBSwSTzaoKRC2nAeLL
         4t/QvOd4aXt332fsfKC0gpinVSumWgnRmeH+Xci/DJZ7XxyQTS19/S7lBh1fmLpA+SPh
         ybjF447VFnQJbHJUDQOQwq15l5tvMk87V4qEEUmHSb6iU++HtBYAFnZxeVmDkpxcAP2o
         KQbxpgYv6SXEOSvWm69wuPlKjOj2Nv4QFa/SBtGwPy3QwH8lfQqKA8fYzjTS4M3t9sgR
         8wSqmBy9eIxBhwKJlkKfoODGh6JavhQosyb1A+tU3tNbPYK1xDSr5bpYQ76UZWl1aFD+
         3FoQ==
X-Gm-Message-State: AOAM533FBKcazbTx5oXpfbJERvWgCVZpyII+m/QAnv9C+w9JZs7e6wnl
        Ck6dL/aTz1J6sCrU7SlR/riW8g==
X-Google-Smtp-Source: ABdhPJzwUSdOKdBf/b9ZQPo2ln/19TXDQctlX6FgLz+O9bx+pyAEY1G2JR3vsSdwhHoQD4/lDhPsSA==
X-Received: by 2002:a17:90b:e8b:: with SMTP id fv11mr2584078pjb.210.1611889772018;
        Thu, 28 Jan 2021 19:09:32 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:d17c:10cd:6087:d51e? ([2601:646:c200:1ef2:d17c:10cd:6087:d51e])
        by smtp.gmail.com with ESMTPSA id e20sm7047333pgr.48.2021.01.28.19.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 19:09:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions properly
Date:   Thu, 28 Jan 2021 19:09:29 -0800
Message-Id: <D8D2B06A-295E-4E13-A176-0D5D7F226E84@amacapital.net>
References: <20210129023259.wffchzof4rlw5pvs@ast-mbp.dhcp.thefacebook.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
In-Reply-To: <20210129023259.wffchzof4rlw5pvs@ast-mbp.dhcp.thefacebook.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jan 28, 2021, at 6:33 PM, Alexei Starovoitov <alexei.starovoitov@gmail.=
com> wrote:
>=20
> =EF=BB=BFOn Thu, Jan 28, 2021 at 06:18:37PM -0800, Andy Lutomirski wrote:
>>> On Thu, Jan 28, 2021 at 5:53 PM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>=20
>>> On Thu, Jan 28, 2021 at 05:31:35PM -0800, Andy Lutomirski wrote:
>>>>=20
>>>> What exactly could the fault code even do to fix this up?  Something li=
ke:
>>>>=20
>>>> if (addr =3D=3D 0 && SMAP off && error_code says it's kernel mode && we=

>>>> don't have permission to map NULL) {
>>>>  special care for bpf;
>>>> }
>>>=20
>>> right. where 'special care' is checking extable and skipping single
>>> load instruction.
>>>=20
>>>> This seems arbitrary and fragile.  And it's not obviously
>>>> implementable safely without taking locks,
>>>=20
>>> search_bpf_extables() needs rcu_read_lock() only.
>>> Not the locks you're talking about.
>>=20
>> I mean the locks in the if statement.  How am I supposed to tell
>> whether this fault is a special bpf fault or a normal page fault
>> without taking a lock to look up the VMA or to do some other hack?
>=20
> search_bpf_extables() only needs a faulting rip.
> No need to lookup vma.
> if (addr =3D=3D 0 && search_bpf_extables(regs->ip)...
> is trivial enough and won't penalize page faults in general.
> These conditions are not going to happen in the normal kernel code.

The need to make this decision will happen in normal code.

The page fault code is a critical piece of the kernel. The absolute top prio=
rity is correctness.  Then performance for the actual common case, which is a=
 regular page fault against a valid VMA. Everything else is lower priority.

This means I=E2=80=99m not about to add an if (special bpf insn) before the V=
MA lookup. And by the time we do the VMA lookup, we have already lost.

You could try to play games with pagefault_disable(), but that will have its=
 own problems.


> The faulting address and faulting ip will precisely identify this situatio=
n.
> There is no guess work.

If there is a fault on an instruction with an exception handler and the faul=
ting address is a valid user pointer, it is absolutely ambiguous whether it=E2=
=80=99s BPF chasing a NULL pointer or something else following a valid user p=
ointer.

The only reason this thing works somewhat reliably right now is that SMAP le=
ssens the ambiguity to some extent.


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8678C3534A1
	for <lists+bpf@lfdr.de>; Sat,  3 Apr 2021 18:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhDCQCD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Apr 2021 12:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhDCQCD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Apr 2021 12:02:03 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA85AC0613E6
        for <bpf@vger.kernel.org>; Sat,  3 Apr 2021 09:01:58 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id z1so8046762ybf.6
        for <bpf@vger.kernel.org>; Sat, 03 Apr 2021 09:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jaoImIBte+b3tcieoUd3MRSFx4IWiYZ836FmSaGO3Vw=;
        b=c/NTVDUCKP15JEcR3tQ9kNdH8dvTZNvFsCznWcwn4AcajQFcFdpjKxIxUdAPV+uyqN
         AI+h/JqNIt+CHPlu8ubMzMWweWJcs4lEIkgjwpSHj3fDtWbHKqRcx4myIxGDpTSE5YLS
         fZQ4PhZui/ae+sMsZ1rvvN5++5lcWM43KZxXtjxhui0yqwh9vEAB/PYWSQE04DkpfjD+
         sX/NwojDJNF8TDRNwhvwVu7hCvFJcmx5Ydg344QYoSytJt+7dgjibMVaOQX/OUU1/Bj/
         eEESUva7JqM1PZKz8Rwo9j9TONUZz2vCSxrdIC+WCcedztMphC78C6EtcRuXkDqCWPZi
         9N+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jaoImIBte+b3tcieoUd3MRSFx4IWiYZ836FmSaGO3Vw=;
        b=IMeze0hlzsH/CsuyWsdbwDmJrzug7jOh+ndMlmHi720FDQJ63znZ19CFbJcOyL/GW9
         ociWa+cOpjzbPF6k13X0DeXCnxapcM7iYyJKXWkuNIrtLSUC8i2qBPQk3i5jp0+OvvlB
         lUqa/h2/8IOIKRlttVV7dRR73w3RBSPzFnAfSueARGyjdtwzpOKkIoEc4TABv926Txx6
         zAC85zZ5gdWFAyurmOn53yJiC2hrY+4PBxo2rOYa9i7JdIE8GE1EN0si41yMQSWYdyNT
         Es7/DOKH82fnfIdNiyb3/4JjfRz7Urz3wKVZDlCS2kXXNbMNFhM/CsiJqsyceY1r7jF0
         QxPg==
X-Gm-Message-State: AOAM530eEtRhKCD1baJreuru+3hBSBkRdGbyVP+3HrQhyBFYYEtYt0p+
        Rx18DSJtb3vrWd93+RiFNhLtKwL4cf0nZykHClSIgZaM
X-Google-Smtp-Source: ABdhPJwZNgNdMasx435o9jhEek/BVOC+0ri/KgMjOnnEMg7RqMM32d4Ee8xurpt4101Tx1NaldNMbw6+q2GgqsyQMm4=
X-Received: by 2002:a25:5b55:: with SMTP id p82mr24245305ybb.510.1617465718171;
 Sat, 03 Apr 2021 09:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <21e66a09-514f-f426-b9e2-13baab0b938b@csgroup.eu> <24d7f121-5ae9-4605-3624-a5601542980e@csgroup.eu>
In-Reply-To: <24d7f121-5ae9-4605-3624-a5601542980e@csgroup.eu>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 3 Apr 2021 09:01:47 -0700
Message-ID: <CAEf4BzZCnP3oB81w4BDL4TCmvO3vPw8MucOTbVnjbW8UuCtejw@mail.gmail.com>
Subject: Re: selftests/bpf - Error: failed to open BPF object file: Endian mismatch
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     bpf <bpf@vger.kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 2, 2021 at 1:02 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 02/04/2021 =C3=A0 09:48, Christophe Leroy a =C3=A9crit :
> > Hello,
> >
> > I'm having hard time cross-building bpf selftests on an x86 for a power=
pc target.
> >
> > [root@PC-server-ldb bpf]# make CROSS_COMPILE=3Dppc-linux- ARCH=3Dpowerp=
c V=3D1
> > /root/gen_ldb/linux-powerpc/tools/testing/selftests/bpf/host-tools/sbin=
/bpftool gen skeleton
> > /root/gen_ldb/linux-powerpc/tools/testing/selftests/bpf/atomic_bounds.o=
 >
> > /root/gen_ldb/linux-powerpc/tools/testing/selftests/bpf/atomic_bounds.s=
kel.h
> > libbpf: elf: endianness mismatch in atomic_bounds.
> > Error: failed to open BPF object file: Endian mismatch
> >
> > [root@PC-server-ldb bpf]# file atomic_bounds.o
> > atomic_bounds.o: ELF 64-bit MSB relocatable, eBPF, version 1 (SYSV), wi=
th debug_info, not stripped
> >
> > Seems like the just-built host bpftool doesn't take into account target=
's endianness.
> >
> > I see the patch https://github.com/torvalds/linux/commit/313e7f6f ("sel=
ftest/bpf: Use -m{little,
> > big}-endian for clang") in bpf selftest to enable cross-compilation, bu=
t it seems it is not enough.
> >
> > What should I do to get bpftool work with the target's endianness ?
> >

bpftool is using bpf_object__open() from libbpf to discover all
information (maps, progs, etc) from the given BPF object file. This is
needed to generate BPF skeleton.

But libbpf itself doesn't support opening BPF object files with
non-native endianness. We solved that problem for BTF specifically to
allow cross-compiling kernel (to let pahole -J generate BTF for an
endianness different from the host endianness), but libbpf was never
taught to work with non-native endianness of loaded ELF file.

And solving this for ELF processing in libbpf is a messier problem
than for BTF itself, so I don't know if I'd like to support such use
case at all.

>
> I also see https://github.com/torvalds/linux/commit/8859b0da ("tools/bpft=
ool: Fix cross-build") but
> that commit doesn't seem to address endianness difference between the hos=
t and the target.
>
> Christophe

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336673347D0
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 20:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCJTUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 14:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhCJTTw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 14:19:52 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E73C061760
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 11:19:52 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id c131so19025783ybf.7
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 11:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6+DonT4+YN4qNZ+1D8ZcSb/P3Lp+yMkYFiQdLi4vXAQ=;
        b=a1WpytEdrs7N4H1cm+5D4FNgzwKpnhpIarWsYVrM2bTTJy6gFh7/0OdTw3AUfGrZYN
         mL/1doMWieHPNOarZn2RBeKroj9QCMDL69TJpzAKNnmt+xvKf9bpUJpNVxRMRujomYWJ
         Jwo+5D0h5tJZSRnIgSmNtDIhAG3uBNEQ1eOIySOPmTnoSjM7pQhqD90YmQm12okCO225
         m7XfuMfRQ8GKYQu3yd/UM0lCvyDx77inLbCW9Zheg91Wbc1LHvfCf5lpIocKnv6GL/zl
         XPyUoUZbiAXGyj/DwnDPpc0pyJutWjq0lwY13wHgzi1cBLMsrEKJEcIIH074l1Kvn7OT
         KLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6+DonT4+YN4qNZ+1D8ZcSb/P3Lp+yMkYFiQdLi4vXAQ=;
        b=nGKQHp/NipKXHk8OYmfcgJB7H8Eh+T3v4PLpH4ZIcd8pedWfk0Abfi3LNk40X2CaUr
         3bBRTDtjOUfvvTaMor3LvObnqBywsWNfPkHwTGhRfct32rxae8D8UE77+ll7c+z9Qlly
         g9naugEDbt9aYdP7xq03u+U2NqaY5yNz7pLJ8ZfhAvsyNgQ0QNcovFlia1UclJRczS75
         g5xewgx+1lVLrypma0HymopZAFjp+VnmlGLT9VjxHoOiy3xopJ6L4PkAh9Dbw9Pk4D6V
         xFhKEofE8925c4b4mUeRGnSP5Wh17vILsQh1eo/RP7IQx1YO2e4QXp8P28CbxiFlSkm2
         QArQ==
X-Gm-Message-State: AOAM532XokysCH0Hy+UiAHhC9FarMGv4D8yuMKBmk9HkhuyjWq2nPSwK
        R8ZatICSE5xP52L/d6igR2dXjhhNkqcVQZadgJM=
X-Google-Smtp-Source: ABdhPJylXCp/j2lvzJ/vaaFEvLIt5cuG/+uK/XenUEQmqee5wPsVWWbMrloWGtdVoGqbzhxN/lwBHjQ84SsWURSOcaA=
X-Received: by 2002:a25:40d8:: with SMTP id n207mr6230608yba.459.1615403991671;
 Wed, 10 Mar 2021 11:19:51 -0800 (PST)
MIME-Version: 1.0
References: <CADmGQ+0dDjfs6UL63m3vLAfu+GHgSFdMO+Rmz_jk+0R9Wva2Tw@mail.gmail.com>
 <20210303181457.172434-1-rafaeldtinoco@ubuntu.com> <CAEf4BzZE_Ss7-cNdVpKJbC57mr2V_-OMcC9fvHw7XTntn3K2jA@mail.gmail.com>
 <043B1B9B-EEF7-49CD-88AF-29A2A3E97304@ubuntu.com> <67E3C788-2835-4793-8A9C-51C5D807C294@ubuntu.com>
In-Reply-To: <67E3C788-2835-4793-8A9C-51C5D807C294@ubuntu.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Mar 2021 11:19:40 -0800
Message-ID: <CAEf4BzaPytBkMqDh15eLPskOj_+FQa0ta2G+BToEn1pSwMGpfA@mail.gmail.com>
Subject: Re: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Vamsi Kodavanty <vamsi@araalinetworks.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 9, 2021 at 9:58 PM Rafael David Tinoco
<rafaeldtinoco@ubuntu.com> wrote:
>
>
>
> On 5 Mar 2021, at 03:32, Rafael David Tinoco <rafaeldtinoco@ubuntu.com> w=
rote:
>
>
> Specially the attach_kprobe_legacy() function:
>
> https://github.com/rafaeldtinoco/portablebpf/blob/master/mine.c#L31
>
> I wanted to reply here in case others also face this.
>
>
> Great, glad it worked out. It would be great if you could contribute
> legacy kprobe support for libbpf as a proper patch, since it probably
> would be useful for a bunch of other people stuck with old kernels.
>
>
>
> I=E2=80=99m sorry to come back to this but I=E2=80=99d like to clarify so=
mething, if you allow me.
>
> If I recompile old kernels (4.x.y) with the =E2=80=9Cscripts/link-vmlinux=
.sh" patch (setting $btf_vmlinux_bin_o and gen_btf()) I=E2=80=99m able to u=
se "pahole -J" to generate the .BTF ELF section from a vmlinux file (out of=
 the debugging package, for example) using its DWARF data.
>
> Using objcopy, I=E2=80=99m also able to extract only the .BTF ELF section=
 from it and use the generated file (smaller) as a base BTF file for libbpf=
 (since old kernels don=E2=80=99t have /sys/kernel/btf/vmlinux interface).
>
> So, in my case, with this, I can get an ~30MB ELF file (from a an almost =
600MB vmlinux) with BTF data that can feed libbpf to do needed relocations =
for my BPF object. Execution works perfectly and I can have the same libbpf=
 based code to run in a 4.15 and a 5.8 kernel, smooth.

Surprised that .BTF is so big at 30MB. It depends on kernel config you
are using, but that's still few times bigger than what I normally see.

Otherwise, yeah, that's how it should work (except see the patch that
adds core_btf_path and discussion around it).

>
> What is not entirely clear to me yet is =E2=80=A6 why can=E2=80=99t I use=
 a =E2=80=9Cvmlinux=E2=80=9D file from a previous compiled kernel (that has=
 not been compiled with a changed link-vmlinux.sh file) and do the same: ge=
nerate the BTF section from its DWARF data with pahole and use generated fi=
le (or the BTF section extract only) as input to libbpf.
>
> I mean, I can do, but it does not work=E2=80=A6 Assumption: it only works=
 for the ones I build with patched link-vmlinux.sh (not the ones already bu=
ilt and provided as packages). The code execution output (debug=3D1 on libb=
pf) is at : https://pastebin.ubuntu.com/p/bx6tygY8p2/
>

From what I see all the CO-RE relocations applied successfully (even
though all the offsets stayed the same, so presumably you compiled
your BPF program with vmlinux.h from the exact same kernel you are
running it on?). Are you sure that vmlinux image you are providing
corresponds to the actual kernel you are running on?

I'd start by comparing libbpf logs for vmlinux you get with modified
link-vmlinux.sh script and with just explicit pahole -J. If all the
CO-RE parts are identical, the problem is somewhere else most
probably.

I see "libbpf: load bpf program failed: Invalid argument" in that log,
which means that CO-RE was done and successful and only when trying to
load your BPF program into the kernel it failed.


> The difference for a new 4.x.y kernel and the existing ones (older packag=
ed kernels) is the vmlinux_link() function linking the BTF object file in e=
ach of the 3 tmp_kallsyms steps.
>
> Is there a way I can get the already existing kernels to work with only p=
ahole DWARF to BTF conversion data ?

Yes and you've found it, I think. There is no difference to libbpf and
.BTF itself whether it's run in link-vmlinux.sh or with explicit
pahole -J. Look for the problem somewhere else.

>
> Thank you!
>
> -rafaeldtinoco
>

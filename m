Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263672EC71D
	for <lists+bpf@lfdr.de>; Thu,  7 Jan 2021 00:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbhAFX4R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jan 2021 18:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbhAFX4Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jan 2021 18:56:16 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C73AC06136A
        for <bpf@vger.kernel.org>; Wed,  6 Jan 2021 15:55:36 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id b64so4472141ybg.7
        for <bpf@vger.kernel.org>; Wed, 06 Jan 2021 15:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ow8Ps1KHcWoR1FhAA7H2eHMH9CQCQ3ZT/EcwsW1DSnI=;
        b=KccQLkRoQufnG1EWSxZn3s55vAA+ieP51NWVWhKUQgj73NS6YAv2/ZTFxtHEJ8Es3f
         ntu+Qq7VQMCYcJ4jFCCemkW1meLba8xraiSfepGWcx668c/J3LH2Sdi8av1dnyY4jagN
         pJG7iolCpWBbSDPCi83NMOffTbjqSmUv/GufD/YsXxcUU8lQ483I6j95blKU/AaSi1xI
         N+4x+DVs+JA8fVLZu8nMrwsMfazSj7A+kTn+LgNaxgwTRE6rnFi6dYd87UbLY88EjZ5c
         WFWIyt+DpJWV9owHHCT3d46Sx7ihSoY2TmIAeS/mlV/xUhEfhTn61pLOo85fdcf7A37a
         BPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ow8Ps1KHcWoR1FhAA7H2eHMH9CQCQ3ZT/EcwsW1DSnI=;
        b=frSsDrecOrbD6CkHhN/GwQvRuYRJYy7KrrLWqpPGKxigLDBaoEDF76ibyUKV6NuX1C
         L4gY+UDHl/N+UX6MNQJQKhA2uz1AphlSph5yykLuh8h0J6tGq49/uSq+9CRU9JqVoK7v
         u39UHZjW3uXRJqeKBT5QOv1QiMLSldfCNxFIT11fVepUFQLZXJ27ZfVwG+YvDspm663X
         X5hvWLUnocUhEXgpY/t38dU6AwPRizLkfWiJo+Ph2Tj2xONR3T/L8/3ZQJzOge+lARAS
         J85mMPJLIZq20ZpVjhncWdS+UDn1daZnCTfllZdvOWITDutb1lzmkcz3t7B5tlIZbDNW
         vwFQ==
X-Gm-Message-State: AOAM531fSkAqgTMSDHBtxOTTGe0YmIFH7chF/gOIBH8WFVjOWVFJowKn
        9pv9uDJTUlwykrSovCSG6deKfW1fciPu4FmLYjtwLsEmvTM=
X-Google-Smtp-Source: ABdhPJxF7Nvpvce8hZ972tjmssiWmeb58Qzo8F6pHgWWuveScz6XRobOTrpoJu6sYJcISc5rIC68Tun1OwfGdS39tr4=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr9320964ybe.403.1609977335743;
 Wed, 06 Jan 2021 15:55:35 -0800 (PST)
MIME-Version: 1.0
References: <CADmGQ+1euj7Uv9e8UyZMMXDiYAKqXe9=GSTBFNbbg1E0R-ejyg@mail.gmail.com>
In-Reply-To: <CADmGQ+1euj7Uv9e8UyZMMXDiYAKqXe9=GSTBFNbbg1E0R-ejyg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Jan 2021 15:55:25 -0800
Message-ID: <CAEf4BzbJZLjNoiK8_VfeVg_Vrg=9iYFv+po-38SMe=UzwDKJ=Q@mail.gmail.com>
Subject: Re: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
To:     Vamsi Kodavanty <vamsi@araalinetworks.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 6, 2021 at 10:04 AM Vamsi Kodavanty
<vamsi@araalinetworks.com> wrote:
>
> Had a few questions on CO-RE dependencies and usage. From what I read
> CO-RE needs a supported kernel version and be compiled with
> `CONFIG_DEBUG_INFO_BTF=y`.
>
> I also understand there are three pieces to enable CO-RE
> functionality. (1) The BTF format. For efficient/compressed kernel
> symbol table. (2) clang changes to emit the BTF relocations. (3)

BTF is not really a symbol table, rather a type information. Like
simpler and more compact DWARF.

> `libbpf` changes to locate a BTF file and fix-up relocations. Once
> these 3 steps are done the resulting byte code is no different from
> non-CO-RE byte code.
>
> Given this I am hoping the knowledgeable folks on this mailer correct
> and guide me if I am stating something incorrectly.
>
> (1) Is the kernel support requirement ONLY for the purposes of
> generating and exposing the BTF file information on
> `/sys/kernel/btf/vmlinux`? So that the eBPF CO-RE applications
> `libbpf` can find the BTF information at a standard location?.

/sys/kernel/btf/vmlinux is a standardized place, but libbpf will also
try to search for vmlinux image (and BTF info within it) in a few
standard locations, see [0]. Early versions of in-kernel BTF didn't
even expose /sys/kernel/btf/vmlinux.

  [0] https://github.com/libbpf/libbpf/blob/master/src/btf.c#L4580

>
> (2) If the answer to the above question is YES. Could the below
> mechanism be used so that it works on all kernels whether they support
> the `CONFIG_DEBUG_INFO_BTF` flag or not?.
>        (a) Extract BTF generation process outside of the kernel build.
> Use this to generate the equivalent BTF file for it.

Yes, CONFIG_DEBUG_INFO_BTF=y is the most convenient way to add BTF
info, but it's also possible to just embed BTF manually with a direct
invocation of pahole -J, see [1] on how it's done for
CONFIG_DEBUG_INFO_BTF. You can do that for *any* kernel image, no
matter the version, and it will work with CO-RE relocations.

  [1] https://github.com/torvalds/linux/blob/master/scripts/link-vmlinux.sh#L137-L170

>        (b) Make changes to `libbpf` to look for BTF not only at the
> standard locations but also at a user specified location. The BTF file
> generated in (a) can be presented here.

You can already do that, actually, though it's not very obvious. You
can specify (or override) kernel BTF location by using
bpf_object__load_xattr() and passing target_btf_path pointing to your
BTF location (see [2]). I've been meaning to add it instead to a
bpf_object_open_opts, btw, to make its use possible with a BPF
skeleton. Also keep in mind that currently libbpf expects that custom
BTF to be an ELF file with .BTF section, not just a raw BTF data. But
we can improve that, of course.

  [2] https://github.com/libbpf/libbpf/blob/master/src/libbpf.h#L136-L141
>
> This should provide us a way to enable CO-RE functionality on older
> kernel versions as well. I tried to make the above changes and tried
> against a 4.14 kernel and it did not work. Either I am not doing
> something right or my assumptions are wrong.
>
> Thanks in advance for your time. And I hope someone here can guide me
> in the right direction.
>
> Regards
> Vamsi.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAE6280046
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 15:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbgJANhe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 09:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732026AbgJANhe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Oct 2020 09:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601559452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N6TARuuJJvGz1UNxEwwB4OqyQk30MamEotJwgCM7uJw=;
        b=LcFA1IbggYKzEQPH9V/PczXiEsDsHfrLG6WGB/onKC6+LGiu8eDVKcwv51bfV4vFmKA0V/
        Q1fGfFF8TW28YTJJihffhl1s76KQ9nBSiaM7khT7dru1pD4OvTHKuUxZ59Lv+Ll1LARBko
        xtXRud0HtEA8EiN//ki7FybLQBM66uk=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-5FaNNUbUN4iqbqMvxffnIQ-1; Thu, 01 Oct 2020 09:37:30 -0400
X-MC-Unique: 5FaNNUbUN4iqbqMvxffnIQ-1
Received: by mail-oi1-f198.google.com with SMTP id c130so271012oig.0
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 06:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=N6TARuuJJvGz1UNxEwwB4OqyQk30MamEotJwgCM7uJw=;
        b=CaAXnHRLz4v+Lbuinm6l6/aRCDj0FdCSPdTy+mCjVcuIAnrte/KHW/H6bzhmZaiHeY
         C3gsM/WetKEk2Umof6aWtXIf9pRQAoy6kDJGOfvMS7D8QVfdn9ms0puCvGrF/sWWdjF6
         le9HPU9r9FR8RslXx+91i1ibolZU3lr3R6h5qVDe9MENdU+kr5aYN+3PERBY2I4ZVY7I
         4EMpSaaJJd2an8h7dzZhR39J2dq+TsQaKuiya7hd4ZMlfFJ79QiRfjNG5y43eKH1ShDP
         gSjPbu/8OPBb7KkcTb1GslQ85Fm3tua4r3o+FIjxTrkKgb+BEcix6adFhbIAbcBgS3oX
         z0XA==
X-Gm-Message-State: AOAM5325pa/VmWc5mlWe5wmhBs/WV0ARrQ+zdDa2KrouzIQmsnLcCCsi
        vfZ6+gliOywxKc3bG9KMPBWJzPJ0IjJEzbH2cTbOHrs6zSFKy2UCBufAOxJ1D0nbAhL2NfgVMEx
        /joIIP1CX1Fhi
X-Received: by 2002:a05:6830:16d1:: with SMTP id l17mr4950156otr.105.1601559448728;
        Thu, 01 Oct 2020 06:37:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyeytfCuNQsT/f/k3hj2TSyL6ydARYKziMy6Q3ttKhCi00NZaKf4YRHr7cpfWVPu/3r1/ncg==
X-Received: by 2002:a05:6830:16d1:: with SMTP id l17mr4950142otr.105.1601559448402;
        Thu, 01 Oct 2020 06:37:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r7sm1019550oij.34.2020.10.01.06.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 06:37:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9F715183A1F; Thu,  1 Oct 2020 15:37:22 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: BTF without CONFIG_DEBUG_INFO_BTF=y
In-Reply-To: <20201001132250.GF3169811@kernel.org>
References: <VI1PR83MB02542417DBEF45BBA9C90FF7FB300@VI1PR83MB0254.EURPRD83.prod.outlook.com>
 <87h7rejkwh.fsf@toke.dk> <20201001125029.GE3169811@kernel.org>
 <20201001132250.GF3169811@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 01 Oct 2020 15:37:22 +0200
Message-ID: <87v9fuhxt9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Arnaldo Carvalho de Melo <acme@kernel.org> writes:

> Em Thu, Oct 01, 2020 at 09:50:29AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
>> Em Thu, Oct 01, 2020 at 12:33:18PM +0200, Toke H=C3=B8iland-J=C3=B8rgens=
en escreveu:
>> > Kevin Sheldrake <Kevin.Sheldrake@microsoft.com> writes:
>> > > I've seen mention a few times that BTF information can be made
>> > > available from a kernel that wasn't configured with
>> > > CONFIG_DEBUG_INFO_BTF. Please can someone tell me if this is true an=
d,
>> > > if so, how I could go about accessing and using it in kernels 4.15 to
>> > > 5.8?
>
>> > > I have built the dwarves package from the github latest and run paho=
le
>> > > with '-J' against my kernel image to no avail - it actually seg
>> > > faults:
>
>> > > ~/dwarves/build $ sudo ./pahole /boot/vmlinuz-5.3.0-1022-azure
>> > > btf_elf__new: cannot get elf header.
>> > > ctf__new: cannot get elf header.
>> > > ~/dwarves/build $ sudo ./pahole -J /boot/vmlinuz-5.3.0-1022-azure
>> > > btf_elf__new: cannot get elf header.
>> > > ctf__new: cannot get elf header.
>> > > Segmentation fault
>> > > ~/dwarves/build $ sudo ./pahole --version
>> > > v1.17
>
>> > > Judging by the output, I'm guessing that my kernel image isn't the
>> > > right kind of file. Can someone point me in the right direction?
>
>> > vmlinuz is a compressed image. There's a script in the kernel source
>> > tree (scripts/extract-vmlinux), however the kernel image in /boot/
>> > probably also has debug information stripped from it, so that likely
>> > won't help you. You'll need to get hold of a kernel image with debug
>> > information still intact somehow...
>
>> > (Either way, pahole shouldn't be segfaulting, so hopefully someone can
>> > take a look at that).
>
>> Reproduced:
>
>> [acme@five pahole]$ cp /boot/vmlinuz-5.9.0-rc6+ .
>> [acme@five pahole]$ pahole -J vmlinuz-5.9.0-rc6+
>> btf_elf__new: cannot get elf header.
>> ctf__new: cannot get elf header.
>> tag__check_id_drift: subroutine_type id drift, core_id: 1145, btf_type_i=
d: 1143, type_id_off: 0
>> pahole: type 'vmlinuz-5.9.0-rc6+' not found
>> libbpf: Unsupported BTF_KIND:0
>> btf_elf__encode: btf__new failed!
>> free(): double free detected in tcache 2
>> Aborted (core dumped)
>> [acme@five pahole]$
>=20=20
>> Working on a fix. Thanks for the report!
>
> commit 4e55425d9eaac78689fbd296283e1557bb6ca725
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Thu Oct 1 10:10:50 2020 -0300
>
>     pahole: Only try using a single file name as a type name if not encod=
ing BTF or CTF
>=20=20=20=20=20
>     Otherwise we end up trying to encode without any debug info and this
>     causes a segfault:
>=20=20=20=20=20
>     Before:
>=20=20=20=20=20
>       $ pahole -J vmlinuz-5.9.0-rc6+
>       tag__check_id_drift: subroutine_type id drift, core_id: 1145, btf_t=
ype_id: 1143, type_id_off: 0
>       pahole: type 'vmlinuz-5.9.0-rc6+' not found
>       libbpf: Unsupported BTF_KIND:0
>       btf_elf__encode: btf__new failed!
>       free(): double free detected in tcache 2
>       Aborted (core dumped)
>       $
>=20=20=20=20=20
>     The vmlinuz file doesn't contain any debugging info, fixing it we get:
>=20=20=20=20=20
>       $ pahole -J vmlinuz-5.9.0-rc6+
>       pahole: vmlinuz-5.9.0-rc6+: No debugging information found
>       $
>=20=20=20=20=20
>     If debugging info is available, it all works as before:
>=20=20=20=20=20
>     Using /sys/kernel/btf/vmlinux
>=20=20=20=20=20
>     $ ls -la /sys/kernel/btf/vmlinux
>     -r--r--r--. 1 root root 3393761 Oct  1 09:50 /sys/kernel/btf/vmlinux
>=20=20=20=20=20
>       $ pahole -E fw_cache_entry
>       struct fw_cache_entry {
>             struct list_head {
>                     struct list_head * next;          /*     0     8 */
>                     struct list_head * prev;          /*     8     8 */
>             } list; /*     0    16 */
>             const char  *              name;          /*    16     8 */
>=20=20=20=20=20
>             /* size: 24, cachelines: 1, members: 2 */
>             /* last cacheline: 24 bytes */
>       };
>       $
>=20=20=20=20=20
>     Or explicitely asking for DWARF, where it will find the appropriate
>     vmlinux according to its buildid in /sys/kernel/notes:
>=20=20=20=20=20
>       $ pahole -F dwarf pm_clock_entry
>       struct pm_clock_entry {
>             struct list_head           node;          /*     0    16 */
>             char *                     con_id;        /*    16     8 */
>             struct clk *               clk;           /*    24     8 */
>             enum pce_status            status;        /*    32     4 */
>=20=20=20=20=20
>             /* size: 40, cachelines: 1, members: 4 */
>             /* padding: 4 */
>             /* last cacheline: 40 bytes */
>       };
>       $ pahole -F dwarf --expand_types pm_clock_entry
>       struct pm_clock_entry {
>             struct list_head {
>                     struct list_head * next;          /*     0     8 */
>                     struct list_head * prev;          /*     8     8 */
>             } node; /*     0    16 */
>             char *                     con_id;        /*    16     8 */
>             struct clk *               clk;           /*    24     8 */
>             enum pce_status            status;        /*    32     4 */
>=20=20=20=20=20
>             /* size: 40, cachelines: 1, members: 4 */
>             /* padding: 4 */
>             /* last cacheline: 40 bytes */
>       };
>       $
>=20=20=20=20=20
>     Reported-by: Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
>     Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Yeah, that's much better!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CAE413E9A
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 02:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhIVAU6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 20:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhIVAU6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 20:20:58 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAAAC061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 17:19:29 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id t4so3407031qkb.9
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 17:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wGYoGb0BP2uosN/e0L73kDBkxA3Hi895DHAlNmetKJw=;
        b=W9EJwNH51IzBFkPsvVs+FXDJPbTQceFc66jXSBfS3MyCPN74EUuTkAg20kNUVwbPGq
         m+AMPYkZRCiWt0CMmmvG35eAfLCAxOOBsIkoh47hZenUkRLeyh1dxst6uHMOVU6TdUsC
         2NbqO8gqAklh+YnyzyTK/ERqc6lhjqOCclxufMbbKWz+0dfStRx00G4CcIWW01cECA9t
         rFmXJ5yBa6PPOfKs5S8EVZfXeCSXHXOuMMBDv/T8HfrRKhZkcuDOsvbGxiFIy79r4UPa
         Xnu6jw98ceGXn8v2RfR8ueeAdDZ2BFiL5IxqUMiYsYtMruJRIgkHwb4mVKPweHuDYkUR
         IZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wGYoGb0BP2uosN/e0L73kDBkxA3Hi895DHAlNmetKJw=;
        b=6uazdyayOViB/EDC2geuLNcZmmHYomb98bG083nScJ9G3djCfdZJOL0OGxdwb3Oiem
         G2jxihl4luq3D5S45Z1XGboS2CoItJKb3wzBqctuslto2RE72ngM2TRmRJZJgQYVDm7K
         GmNdN5466spZ01TtKSjd5NR4mfyGac5jxebkDK6Qf7vOy344SCXSHzeP/VLTxRYs884J
         BM/C4ZpUC0wR0EI3dOe5wF6wxylnTqgdArb/Pc2udBLjaeUb/kYnUXwC26vpbkN2Hd7l
         9zrYH/nGI5XyW5iMS2SxXTk2hwKDS+AHCVDQi/tX1K3E0zn56coaTW+XiyiEBJBrEc3j
         YDWQ==
X-Gm-Message-State: AOAM531fB6vN3JknYMn+Fznom033k8KFp+9ca4YxtTWGnQbask9GZ9ot
        mc/W5n9mB5gTqdkgbWEPc+0MpU+Hh2HWz0IU8K0=
X-Google-Smtp-Source: ABdhPJz4ZxefVm6vdNTZfTvig9lhHDO6I79dXMyV+qm5uQxvXHye5HXh9LJ76I3hxQcbbKfLOP1cnbrsNUrULkHzpQQ=
X-Received: by 2002:a25:1884:: with SMTP id 126mr25072121yby.114.1632269968187;
 Tue, 21 Sep 2021 17:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <6850bdde-b660-5ed3-9749-2fc6c1c1d0b7@redhat.com> <20210914122231.1870-1-larysa.zaremba@intel.com>
In-Reply-To: <20210914122231.1870-1-larysa.zaremba@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Sep 2021 17:19:16 -0700
Message-ID: <CAEf4BzZO=7MKWfx2OCwEc+sKkfPZYzaELuobi4q5p1bOKk4AQQ@mail.gmail.com>
Subject: Re: XDP-hints as BTF early design discussion phase
To:     Larysa Zaremba <larysa.zaremba@intel.com>
Cc:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Michal Swiatkowski <michal.swiatkowski@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Toke Hoiland Jorgensen <toke@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 5:23 AM Larysa Zaremba <larysa.zaremba@intel.com> w=
rote:
>
> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
> Date: Mon, 13 Sep 2021 13:35:04 +0200
>
> > Trying to get started with XDP-hints again.
>
> > The fundamental idea is that XDP-hints metadata struct's are defined by
> > the kernel, preferably by the kernel module, and described via BTF. As
> > BTF layout is defined by kernel, this means userspace (AF_XDP) and
> > BPF-progs must adapt to layout (used by running kernel). This imply tha=
t
> > kernel is free to change layout.
>
> > The BTF ID is exposed (to BPF-prog and AF_XDP) on per packet basis, to
> > give kernel more freedom to change layout runtime. This push
> > responsibility to userspace/BPF-prog of handling different layouts,
> > which seems natural. For the kernel this solves many issues around
> > concurrency and NIC config changes that affects BTF info available (e.g=
.
> > when BTF layout is allowed to change).
>
> Aside from generic XDP hints defined directly in kernel code,
> it should be possible to define custom hints layout inside network driver=
.
> Kernel module BTF support[1][2] provides the means to do so.
>
> As long as our XDP program is attached to interfaces serviced by a single=
 driver
> and BPF program uses hints layouts only from this particular driver + gen=
eric,
> there should be no problem, we can easily obtain a BTF type_id in BPF cod=
e
> and compare it to the one sent by driver,
> because BTF type_ids are unique in such case (was discussed earlier).
>
> However, if we want a single program to use layouts from multiple drivers=
,
> we can=E2=80=99t do it so easily, because in such case same type_id can p=
oint
> to absolutely different types. Obviously, probability of both those types=
 being
> hints structures is extremely low,
> but using type_id only would be at least inconsistent.
> This generates the following issues:
>
> 1.      We have to send both BTF ID and type_id in generic hints struct f=
rom driver.
>     This takes up precious space inside generic structure.
>     The first solution we=E2=80=99ve came up with is not using full 64 bi=
ts, but instead
>     splitting 32 bits we already planned for type_id into for example,
>     12 for BTF_ID and 20 for type_id. Feel free to suggest a better solut=
ion.
> 2.      BTF ID needs to be compared in BPF code too,
>     but it=E2=80=99s not that easily obtained as type_id
>     (through  bpf_core_type_id_kernel which expands to __builtin_btf_type=
_id).
>     This patch[3] suggests that at least at some point there was an inten=
sion
>     to return both BTF_ID and type_id in a single 64 bit integer.
>     However, I=E2=80=99ve run a test and bpf_core_type_id_kernel does not=
 seem
>     to return anything on the most significant 32 bits.
>     libbpf source also seems to patch only type_ids into program.
>     Therefore I have a question to BPF CO-RE developers,
>     do I understand the situation correctly?
>     Is there any other existing way to obtain a BTF ID (not type_id)
>     from type name inside BPF code?

I've even posted a patch before that was resolving local BTF types to
the module BTF FD/ID (that was one of the points of contention) and
BTF type ID. See [0] for context. I think we never reached any
conclusion and this never landed.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20201205025140.4=
43115-1-andrii@kernel.org/

>
> So I would like to ask for some suggestions in this situation.
>
>
> > End-goal is to make it easier for kernel drivers can invent new layouts
> > to suite new hardware features. Thus, we prefer a solution where
> > XDP-hints metadata struct's are defined in the kernel module code.
>
>
> > (Idea below ... please let us know what you think, wrong direction?)
>
> > Exploring kernel module code defining the XDP-hints metadata struct.
>
> > Kernel module BTFs are now[1][2] exposed through sysfs as
> > /sys/kernel/btf/<module-name>. Thus, userspace can use libbpf
> > btf__load_module_btf() and others BTF APIs. Started playing here[3].
>
> > Credit to Toke, who had an idea that drivers could "say" what struct's
> > are available, by defining a union with a known name e.g.
> > metadata_hints_avail' and have supported metadata struct's included in
> > that union. Then we don't need new APIs for exporting these BTF-metadat=
a
> > struct's. To find struct names, we BTF walk this union.
>
>
> > -Jesper
>
> --Larysa
>
> >   [1]
> > https://lore.kernel.org/bpf/20201110011932.3201430-5-andrii@kernel.org/
> >   [2] 36e68442d1af ("bpf: Load and verify kernel module BTFs") (Author:
> > Andrii Nakryiko)
> >   [3]
> > https://github.com/xdp-project/bpf-examples/blob/master/BTF-playground/
>
> [1]
> https://lwn.net/Articles/836249/
> [2]
> https://www.spinics.net/lists/netdev/msg702049.html
> [3]
> https://reviews.llvm.org/D91489
>
> ________________________________
> Intel Technology Poland sp. z o.o.
> ul. S=C5=82owackiego 173 | 80-298 Gda=C5=84sk | S=C4=85d Rejonowy Gda=C5=
=84sk P=C3=B3=C5=82noc | VII Wydzia=C5=82 Gospodarczy Krajowego Rejestru S=
=C4=85dowego - KRS 101882 | NIP 957-07-52-316 | Kapita=C5=82 zak=C5=82adowy=
 200.000 PLN.
>
> Ta wiadomo=C5=9B=C4=87 wraz z za=C5=82=C4=85cznikami jest przeznaczona dl=
a okre=C5=9Blonego adresata i mo=C5=BCe zawiera=C4=87 informacje poufne. W =
razie przypadkowego otrzymania tej wiadomo=C5=9Bci, prosimy o powiadomienie=
 nadawcy oraz trwa=C5=82e jej usuni=C4=99cie; jakiekolwiek przegl=C4=85dani=
e lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the=
 sole use of the intended recipient(s). If you are not the intended recipie=
nt, please contact the sender and delete all copies; any review or distribu=
tion by others is strictly prohibited.

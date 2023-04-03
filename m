Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181326D3B09
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 02:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjDCAF3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 20:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDCAF2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 20:05:28 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C295FC5
        for <bpf@vger.kernel.org>; Sun,  2 Apr 2023 17:05:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eh3so110667390edb.11
        for <bpf@vger.kernel.org>; Sun, 02 Apr 2023 17:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680480326; x=1683072326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5Z7iFY+51eP7rfwplrTUpwUsDxzkwULtfio6Pn36s4=;
        b=bCplw1uEdDYF/8vixtzXjjnfd1Rzy52I5T4HpWgiZVDwEDqaAdfyzT+/AYNzvg/fpX
         7glGu1++Z2102KLzzbdNqZ9mBM7r7ZoakjzP5dP0ncXuv9xUvPZbr3Ej+hInKjwWEuB/
         IribAxsuDPu4uNAhU8u9k0euQuRddlRf5s2HvQw67pxO+qEvQNqVE8ExJd37l+yeJpiZ
         kE7yOUm7shC+gMXdUMvv0LyW8cLfp9LqzvughDD0qzsSTwAR7IyBMH+onjedC7VX1Qr9
         0Cibt6fnwihnbGSI6r0fonU/TRCb7+mrcgAJ1MGUiTUEkHRPICotlPPgoCCeD+HLjOoh
         iI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680480326; x=1683072326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5Z7iFY+51eP7rfwplrTUpwUsDxzkwULtfio6Pn36s4=;
        b=TqrutwkF4GSbqZqlBmfNi1fRLA/Y177BnvHfnVVMqu6a0pToqaSUEX5Ax1JZ4QKAlk
         iz5xKIlxs+1pPNPo4stNk7FgJYS+ymGRmQdbGCz7rGHbX46f1UZ+FqKBMXQoX6iU0LZT
         E4KGtEZswOCpB+noFvkLBVczMZTLV8+CvIDJO0xpTaTO3Lrtscyk9sMNkElTIpmPddJ6
         d1IodKePJiEYyNZDrnnkNjEwSw9m4KQ1eDLMnyNW/3NOHWZ3q6b6XesJ8MnhhR/tdp/f
         RDSZT4Bqzs4oFLDfNx4SqKe5dWdY+dzS9BSUale4y9lhpaHdfwroF2B8wRfW8Det6Dku
         s18w==
X-Gm-Message-State: AAQBX9cMlXf34HSG8KgPdrPih++YbX+LItY+FbGcL6QdPlYlnHCTuWTA
        ACV7oiEw0/5kHwkpPojr0GvJxLuPvQkIWXMe+/w=
X-Google-Smtp-Source: AKy350bZQ/vvfdt0muxFgu389fVUQgZSe29TuxC0Ti3YKnKnCqhtq76E68h0ZZF4iR5Jfy5yazc83a+IY32hP8eGfUs=
X-Received: by 2002:a17:907:7f19:b0:926:8f9:735d with SMTP id
 qf25-20020a1709077f1900b0092608f9735dmr18630973ejc.3.1680480325764; Sun, 02
 Apr 2023 17:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230326054946.2331-1-dthaler1968@googlemail.com>
In-Reply-To: <20230326054946.2331-1-dthaler1968@googlemail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 2 Apr 2023 17:05:14 -0700
Message-ID: <CAADnVQKZMHW9e+BaAiPUMXnKFba5WgtSJYkKYbhNRJ-JpgQ2ZA@mail.gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next v4] bpf, docs: Add docs on extended 64-bit
 immediate instructions
To:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc:     bpf <bpf@vger.kernel.org>, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 25, 2023 at 10:49=E2=80=AFPM Dave Thaler
<dthaler1968=3D40googlemail.com@dmarc.ietf.org> wrote:
>
> From: Dave Thaler <dthaler@microsoft.com>
>
> Add docs on extended 64-bit immediate instructions, including six instruc=
tions
> previously undocumented.  Include a brief description of maps and variabl=
es,
> as used by those instructions.
>
> V1 -> V2: rebased on top of latest master
>
> V2 -> V3: addressed comments from Alexei
>
> V3 -> V4: addressed comments from David Vernet
>
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/instruction-set.rst | 57 +++++++++++++++++++++++----
>  Documentation/bpf/linux-notes.rst     | 22 +++++++++++
>  2 files changed, 71 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/in=
struction-set.rst
> index b4464058905..b3efa4b74ec 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -401,14 +401,55 @@ and loaded back to ``R0``.
>  -----------------------------
>
>  Instructions with the ``BPF_IMM`` 'mode' modifier use the wide instructi=
on
> -encoding for an extra imm64 value.
> -
> -There is currently only one such instruction.
> -
> -``BPF_LD | BPF_DW | BPF_IMM`` means::
> -
> -  dst =3D imm64
> -
> +encoding defined in `Instruction encoding`_, and use the 'src' field of =
the
> +basic instruction to hold an opcode subtype.
> +
> +The following table defines a set of ``BPF_IMM | BPF_DW | BPF_LD`` instr=
uctions
> +with opcode subtypes in the 'src' field, using new terms such as "map"
> +defined further below:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +opcode construction        opcode  src  pseudocode                      =
           imm type     dst type
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst =3D imm64                   =
             integer      integer
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst =3D map_by_fd(imm)          =
             map fd       map
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst =3D map_val(map_by_fd(imm)) =
+ next_imm   map fd       data pointer
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst =3D var_addr(imm)           =
             variable id  data pointer
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst =3D code_addr(imm)          =
             integer      code pointer
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst =3D map_by_idx(imm)         =
             map index    map
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst =3D map_val(map_by_idx(imm))=
 + next_imm  map index    data pointer
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +where
> +
> +* map_by_fd(imm) means to convert a 32-bit POSIX file descriptor into an=
 address of a map (see `Maps`_)

I removed the screaming "POSIX" word, since "file descriptor" is
descriptive enough.

> +* map_by_idx(imm) means to convert a 32-bit index into an address of a m=
ap
> +* map_val(map) gets the address of the first value in a given map
> +* var_addr(imm) gets the address of a platform variable (see `Platform V=
ariables`_) with a given id
> +* code_addr(imm) gets the address of the instruction at a specified rela=
tive offset in number of (64-bit) instructions
> +* the 'imm type' can be used by disassemblers for display
> +* the 'dst type' can be used for verification and JIT compilation purpos=
es
> +
> +Maps
> +~~~~
> +
> +Maps are shared memory regions accessible by eBPF programs on some platf=
orms.
> +A map can have various semantics as defined in a separate document, and =
may or may not have a single
> +contiguous memory region, but the 'map_val(map)' is currently only defin=
ed for maps that do have a single
> +contiguous memory region.

Reformatted these sections to fit 80 char.
And applied.

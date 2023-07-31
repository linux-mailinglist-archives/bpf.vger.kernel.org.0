Return-Path: <bpf+bounces-6463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F15BA76A00E
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 20:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD522815B4
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 18:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878BB1D31C;
	Mon, 31 Jul 2023 18:11:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526F2182DA
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 18:11:00 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FB0E7B
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 11:10:58 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso71695231fa.1
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690827057; x=1691431857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owHVIzMbfmfWBLx7Sv3zc7JvDyp8fsje0XDOGjXqYWE=;
        b=jTR8A97Dlg/0ja3P44VOej34BA4I2q7dXINOSO87QGZlFDiHS5d8NATTtIExquga3L
         mKvh/v4YNAcHrZm2Ec/R7yHr9dJi+muzDDkbPTrv8rDq/7CFTvHGujfpgBEfQ5psfR0l
         Xhu2AwaQp9OwTJ6lZRErYGnTLOOE9D7M0wYnZAS27IgiRPSJaAOod2vCHy12OV8pGfp9
         7sd1jjgTWG1/QL15MJ7if9hjmMk5CBTZD8C64e7HkbJlQWqIXIoqDucD7N4w3UDxGiEC
         yH6RzxoMV+kq2rhmgDjnzA+Awf81vNMWVOfFMl3XZHEChoLFTlJyRm6VxU0iQljj1Hhr
         +UPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690827057; x=1691431857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owHVIzMbfmfWBLx7Sv3zc7JvDyp8fsje0XDOGjXqYWE=;
        b=SSLHnXBT5Dx37r+9dq/jcTLpibbFn7SFOoD9LYyoEA/CnAtWMlJZu/MpveCfkluoWt
         kLZCZ8bvmw+oWqkmfjIqGOfjYKebbs6hAlxx5Uq3pNv2+Ht28uEyjrFPgfFGA/KEKKUR
         YBGFQmuFnF6xCdwpGvskxKeNo99etrusJ9dto3qnbnaPIzdaGa65fPYsqRT1xRdVvIdT
         7+DEXKa7v0xmWoGvXZYASDmx93/nWquT3gnzYWF6yD4O02f8tKUfmI6PUkP3qiO5X8yy
         Kp8MTT+5VOoQwCz1CmGYXz/G5gMqrqj0oDzumfVEoQNUfcWTRnC5Ly0y0Mb797ZRKbA5
         cHgA==
X-Gm-Message-State: ABy/qLZnDIXr5SxU5eOEWwVnicnxjGcaQ32O5+koEQfj/TWHTd9qcWEX
	nymfAMCs0CI9PmsNLCJZqrlMLdNyNOZI/YFxQcYicSvw
X-Google-Smtp-Source: APBJJlHPKpgkHW6fjriJcoJXBs0DDNPBksKb8ILNixCKBWzT+p7Uu0KxUYXKmB9bvOswXIBzNQgpal2er8J+5H3YeJM=
X-Received: by 2002:a2e:b0c1:0:b0:2b9:e93e:65d9 with SMTP id
 g1-20020a2eb0c1000000b002b9e93e65d9mr500898ljl.40.1690827056449; Mon, 31 Jul
 2023 11:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878rb0yonc.fsf@oracle.com> <13eb5cae-e599-7f80-aa11-65846fccdc62@linux.dev>
 <87v8e4x7cr.fsf@oracle.com> <87pm4bykxw.fsf@oracle.com> <CAADnVQLaZrqq232fxts0GmymaaG=fpvRbSZaBkfNnKFuy0LM8A@mail.gmail.com>
 <87jzujnms6.fsf@oracle.com> <CAADnVQ+2mHqRc2EBCKe+NHHPQ+FqaNt2PmD6t9DN6GwPnu1RQg@mail.gmail.com>
 <87edkqm257.fsf@oracle.com> <CAADnVQ+gLXpeY-kOJ_cEAuoXkrQeeD+KL6jsFfyDXcm+rk-xmg@mail.gmail.com>
 <87edkpkt2h.fsf@oracle.com>
In-Reply-To: <87edkpkt2h.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 31 Jul 2023 11:10:44 -0700
Message-ID: <CAADnVQJ1OgD1xCWLscRbRN72sZ575xpm-bEuuaT2eLtMj7Pc-g@mail.gmail.com>
Subject: Re: GCC and binutils support for BPF V4 instructions
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 30, 2023 at 2:06=E2=80=AFPM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Sat, Jul 29, 2023 at 9:54=E2=80=AFPM Jose E. Marchesi
> > <jose.marchesi@oracle.com> wrote:
> >>
> >> The individual flags... I am not sure, other arches have them, but may=
be
> >> having them in BPF doesn't make much sense and it is not worth the ext=
ra
> >> complication and wasted bits in e_flags.  How realistic is to expect
> >> that some kernel may support a particular version of the BPF ISA, and
> >> also have support for some particular instruction from a later ISA as
> >> the result of a backport or something?  Not for me to judge... I was
> >> already bitten by my utter ignorance on kernel business when I added
> >> that silly useless -mkernel=3DVERSION option to GCC 8-)
> >>
> >> What I am pretty sure is that we will need something like EF_BPF_CPUVE=
R
> >> if we are ever gonna support relaxation in any linker external to
> >> libbpf, and also to detect (and error/warn) when several objects with
> >> different BPF versions are linked together.
> >
> > Ok. Let's start with EF_BPF_CPUVER 0xF
> > and not waste bits on individual instructions, as you said.
> > When kernel backports are done the patches are sent together.
> > It wouldn't be wise to backport SDIV without JMP32, for example.
> > git history will get screwed up and further backports will be a pain.
> > The risk of untested combinations increases, etc.
> > I think it's safe to assume that a given kernel will support either v3
> > or v4.
>
> This is good to know.  Thanks for explaining.
>
> > The kernel version doesn't matter, of course :)
>
> Yeah GCC no longer supports -mkernel :P
>
> Allright, so I just pushed a binutils patch for elf.h, the disassembler,
> the assembler and readelf:
>
>   https://sourceware.org/pipermail/binutils/2023-July/128723.html
>
> Note that the ISA version selection logic in the disassembler is:
>
> 1. If the user specifies an explicit version (v1, v2, v3, v4) then use
>    it.
>
> 2. Otherwise, use the EF_BPF_CPUVER bits in the ELF header to derive the
>    version to use:
>
>    2.1. If the CPUVER is zero, then use the latest supported version
>         (currently v4).  This is for backwards compability.
>
>    2.2. Else, if CPUVER is one of the supported versions by the
>         disassembler (currently 1, 2, 3 or 4) then use it.
>
>    2.3. Else, emit an error "unknown BPF CPU version %d".
>
> Maybe 2.3 should be a warning instead of an error...

Warn is probably better.
Older disasm should still print what it knows about from newer ELF.
Unknown insns from cpu=3Dv5 will be 'unknown'. That's better than no
output at all.


Return-Path: <bpf+bounces-11982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC47C61F3
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 02:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5937282706
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 00:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE428652;
	Thu, 12 Oct 2023 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG+co2oV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16AF62A
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 00:42:28 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8756FA4
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 17:42:26 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so345052a12.0
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 17:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697071345; x=1697676145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCXtJwY5YQKRZSp+BAjMnKEm0yiUQjA/st+JT2OhSCU=;
        b=IG+co2oV4OQMGcVuL04pXMEkF97/jTfgip1YBIS6ZBFkudbQiItgSRviLUwMI5p4C0
         GRf/Vnp+dcOBmY5mQ/cpZdSMMwn+isPqUExScPRKAZ6v6bhmCeGtxWsKQ1Nb1a3TPHFD
         OPSESyPDI198LnYX9i4OPuCkYWhroC2lEYhHHxYsQwbVPdPq+lkVvYP82ijGE1G8DPvy
         LSKvKvXr0tFveA8z0HRbe86IVM3tkoH+nSXfe4nXK59GrHt4zKE6fQSNzDqGRi0Vy6+Q
         UyiOE4HGW94JLiDQNY++4JIZonCCO5KHntnvA1vgQPqNn84oqffM6XRoMCcoyTRlx36j
         50rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697071345; x=1697676145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCXtJwY5YQKRZSp+BAjMnKEm0yiUQjA/st+JT2OhSCU=;
        b=wBnzdCuaexouGz3M+ynWgtVrdQsvs7trOdr67vqr+znzt827Jql98A6RlUM6ZH6IJ7
         VH19QST9YZG7TdgWs5KsWydp914/mC//TE6qv6D8Kn0i8MUbkO3fjWPpdRHl6/8Iz+IK
         TlTjC33KEC3A+fCbopcenJIw/XF/GiGjaPhIv6fcxsRSS5sdU9ezbnt1FmmdA3DcZjwd
         BQf/rqrudv7mWZfoVFfNTUvUSbvhSmIhakUx1rSe9VAOQNIpMx8yFFl6TxM2PiV+sZuG
         oYoCvHzMT9yf7+aBHkjKQm+N4q9NgbwUGlTqvRqx/NidPvkTSKUy1SGxo7ZuBFQm3dR+
         s8mQ==
X-Gm-Message-State: AOJu0Yxs+QqA9rOd/u2MiPtHrhYocR54rvi9enr7ARKXTBkQ9NEF5R18
	rDuW5rEK+WhdJY0eEl938eJzxNZl7IrHAFlxaABYo1PI
X-Google-Smtp-Source: AGHT+IFgb8RCJr+npXkwYveIUPBC4tR9TyaUQqA+FsKRI487tc4LjqKkV/Nmy+PuxJPMNyTkNS9GlIH0VqmrHCkmFLY=
X-Received: by 2002:a05:6402:951:b0:53d:a7ea:225f with SMTP id
 h17-20020a056402095100b0053da7ea225fmr4111659edz.38.1697071344892; Wed, 11
 Oct 2023 17:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004004350.533234-1-song@kernel.org> <CAEf4BzbM6yvBwT3-_7NkzKgqdoXc_G3+_5Fnv96b_2U68=Hunw@mail.gmail.com>
 <CAADnVQKMxUg3Djh8UjRPdw7RE6yOiNUgYGjG_eCPqMtnguO+fA@mail.gmail.com>
 <095DCE9A-BC4D-415F-81F6-B6C20BA08B9A@fb.com> <FCAD3D3A-B230-40D8-A422-DED507B95C89@fb.com>
 <A53BABCE-A22D-40B0-91BA-009B54AB8F09@fb.com> <92BDCF92-3219-4EDA-A6F8-1EA8D88BEE41@fb.com>
 <7a9576222aa40b1c84ad3a9ba3e64011d1a04d41.camel@linux.ibm.com> <CAPhsuW7yXG4pahGTuBUWYmqQzYBJji=VFLmBYotHWL82janT_A@mail.gmail.com>
In-Reply-To: <CAPhsuW7yXG4pahGTuBUWYmqQzYBJji=VFLmBYotHWL82janT_A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Oct 2023 17:42:13 -0700
Message-ID: <CAEf4BzbaWL_AJ55E+nniexL04nhTegR0DWCd4bLyXW8rXVGegg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Avoid unnecessary -EBUSY from htab_lock_bucket
To: Song Liu <song@kernel.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Song Liu <songliubraving@meta.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 3:13=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Hi Ilya,
>
> On Tue, Oct 10, 2023 at 1:49=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.c=
om> wrote:
> >
> [...]
> > >
> > > Thanks,
> > > Song
> > >
> > > PS: the root image from the CI is not easy to use. Hopefully you
> > > have something better than that.
> >
> > Hi,
> >
> > Thanks for posting the analysis and links to the artifacts, that saved
> > me quite some time. The crash is caused by a backchain issue in the
> > trampoline code and has nothing to do with your patch; I've posted the
> > fix here [1].
>
> Thanks for the fix!
>
> Song

Song, can you please resend your patch so that CI can test it again on
top of Ilya's changes? Thanks!

>
> >
> > The difference between compilers is most likely caused by different
> > inlining decisions around lookup_elem_raw(). When it's inlined, the
> > test becomes a no-op.
> >
> > Regarding GDB, Debian and Ubuntu have gdb-multiarch package. On Fedora
> > one has to build it from source; the magic binutils-gdb configure flag
> > is --enable-targets=3Dall.
> >
> > Regarding the development environment, in this case I've sidestepped
> > the need for a proper image by putting everything into initramfs:
> >
> > workdir=3D$(mktemp -d)
> > tar -C "$workdir" -xf libbpf-vmtest-rootfs-2022.10.23-bullseye-
> > s390x.tar.zst
> > rsync -a selftests "$workdir"
> > (cd "$workdir" && find . | cpio -o --format=3Dnewc -R root:root)
> > >initrd.cpio
> > qemu-system-s390x -accel kvm -smp 2 -m 4G -kernel kbuild-
> > output/arch/s390/boot/bzImage -nographic -append 'nokaslr console=3Dtty=
S1
> > rdinit=3D/bin/sh' -initrd initrd.cpio -s
>
> Nice trick!
>
> > For the regular development I have a different setup, with a
> > non-minimal Debian install inside the guest, and the testcases mounted
> > from the host using 9p.
> >
> > Best regards,
> > Ilya
> >
> > [1]
> > https://lore.kernel.org/bpf/20231010203512.385819-1-iii@linux.ibm.com/


Return-Path: <bpf+bounces-62573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5432EAFBEB9
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F0F560B92
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 23:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FAE1D5150;
	Mon,  7 Jul 2025 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iomgy742"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0007F17555
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751931928; cv=none; b=LKzvPTOxBYvxZirBIG1c0d8riTBB6e1Zdf0C85kxT9MURXZ2PVKSB3WZThK39sALDBqAGiErzsS5YadEyHewcoRUseqZl5xIO4quhO97k+7P6owosgqgv+kOnD+18KHQxEqq9gFzA1YtqA8DUM3BeWXK+jCaXYsfDdPdnvtjl4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751931928; c=relaxed/simple;
	bh=f3ZqPaoD0lspwOR8X1kvIxBd+yqgGJU6hGVSHXVdHNA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UvsttvOfzkDROemTUi+Sc4JRiJsN/GptjR9YnFcqZk6xzL3aiukpLmZto7oJG+WDTNIdmWk8y1vRwekzggnBNJ6ct4IeRV+HSUDCbjgkWW92HloUqvHcVaHtDDa8V8O3yTmPvDtI8Oke1NAlq3p+Jifbd4gjw53zMy/u3zaldTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iomgy742; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso3282988b3a.0
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 16:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751931926; x=1752536726; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Y1jPEXVVVG/Bl1tAgRJ/XNXXhhkQQuJmwDeax/wuT0=;
        b=iomgy742F/YJb+6YDs5qPaT8wxxn5Yw3m+sbQrOacCLTONLsXxaqMBo9+waXhr3JY1
         8fks0xA4Dc7j/YHnokerpuk4PAJoQ8YUQZ0YBaZuVjnn+g2DsKSIDVpxdjGuPPaFtAkD
         Lrgu+JA0MfjU6zjuCmqtPr3AYyoqoM2QWjmjm5do2BR9gnmep5ixtdk8pzYGYE545fqt
         MHRWAomtL/6t+rk4h8y91KuKfeee59w1ycVDO9MEGi00yJeKRJ1Kw3Feg9LJhGY2OzGy
         zl/IT7FT7/pwH0rW2U8t3rQtXyqa+bMAXyxHAeB7BVjrdN5xblydwIfBLCHirdc6GKgo
         hSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751931926; x=1752536726;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Y1jPEXVVVG/Bl1tAgRJ/XNXXhhkQQuJmwDeax/wuT0=;
        b=v2fQn0lfREV3ED9IctF1ZanGXXoEzUYgB6cooskcwXnZkzN7AGR+hrcSGCpskFOCOr
         iYTNeqViNWYOvt0FeXk/Q8VePhwghZbT9tD1iYo5s/unOJUVrRuu1rWHuTYhVJxhYo5G
         kn3/qcp8FqWok/jnYMFgRmfYbDiCVGWcZ8G9WnCpR2B3Mn4KlZ1E4YJZZrJtSmWs3Xsj
         c7wl830iW4ETOWZor2OZkvUrGyrkqzVH7DL1tSpSOY2PL3fBgJTr5cFap2piqQUhQHBV
         LXZaI9FoIUGNVXwiNUiVbd/osTZAYzSufvbeBJ1E4ql90Yy59WzRk4kXweI+7i20spCH
         G1Vw==
X-Gm-Message-State: AOJu0Yys1uilSjant8H1nHS3sIit8Dpuv4atQQPjEV9k9MaiVvTzf6R4
	PoGCPLRAQ9C6p4wzBQ7ykk0PV+HgGHiWT1X71OtMxmFPUe4bCBRY/N8j
X-Gm-Gg: ASbGncufmv66fxJZft9DsOr9g98EtRVyyd29e5/CkaDsyFiNOBAzS08VcS7A4k/LgjA
	+WS538If7/mz66vhUqifmtSbqwTWcuJvuoe2jA9CLx2gy6WWptgFgBf5DMWdxF/03l2PCrEAuMK
	3G1VRMYe0fcLoV/mJPtS1xtpc2zAU8VRZnj/ngUehkZ7d5Z1WVzH8hibEtFQVEIErK1iOZGWEj9
	VaDt5jQoVxanilvX9phWPxnKa7UzZIlHOdFiKnhOpOkerHmji2cdztNIki8xDeJtdC7DL5Z7QmW
	kmzRLMhykaAfUPmNJehYVPP0oNDa1nkA3EWrE+DrObbP2MpbiYuZUJ30vZiRxB+66hY=
X-Google-Smtp-Source: AGHT+IG4z2n3IVa8d1FASjAQ956FIsqPaMWPC+LhIb1IEnXw1oTzV3I25kBUovTQn+M5y5sqdjstwQ==
X-Received: by 2002:a05:6300:8a07:b0:22b:3da9:fb33 with SMTP id adf61e73a8af0-22b3daa01d9mr997679637.12.1751931926120;
        Mon, 07 Jul 2025 16:45:26 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:6ad])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce43d4de1sm10052935b3a.171.2025.07.07.16.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 16:45:25 -0700 (PDT)
Message-ID: <e726d778a3cf75e3ceec54f5f43b9d5d66ba5e97.camel@gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Mon, 07 Jul 2025 16:45:24 -0700
In-Reply-To: <aFLWaNSsV7M2gV98@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
	 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
	 <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
	 <aFLWaNSsV7M2gV98@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-18 at 15:08 +0000, Anton Protopopov wrote:
> On 25/06/17 08:22PM, Alexei Starovoitov wrote:
> > On Sun, Jun 15, 2025 at 1:55=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > >=20
> > > The final line generates an indirect jump. The
> > > format of the indirect jump instruction supported by BPF is
> > >=20
> > >     BPF_JMP|BPF_X|BPF_JA, SRC=3D0, DST=3DRx, off=3D0, imm=3Dfd(M)
> > >=20
> > > and, obviously, the map M must be the same map which was used to
> > > init the register rX. This patch implements this in the following,
> > > hacky, but so far suitable for all existing use-cases, way. On
> > > encountering a `gotox` instruction libbpf tracks back to the
> > > previous direct load from map and stores this map file descriptor
> > > in the gotox instruction.
> >=20
> > ...
> >=20
> > > +/*
> > > + * This one is too dumb, of course. TBD to make it smarter.
> > > + */
> > > +static int find_jt_map_fd(struct bpf_program *prog, int insn_idx)
> > > +{
> > > +       struct bpf_insn *insn =3D &prog->insns[insn_idx];
> > > +       __u8 dst_reg =3D insn->dst_reg;
> > > +
> > > +       /* TBD: this function is such smart for now that it even igno=
res this
> > > +        * register. Instead, it should backtrack the load more caref=
ully.
> > > +        * (So far even this dumb version works with all selftests.)
> > > +        */
> > > +       pr_debug("searching for a load instruction which populated ds=
t_reg=3Dr%u\n", dst_reg);
> > > +
> > > +       while (--insn >=3D prog->insns) {
> > > +               if (insn->code =3D=3D (BPF_LD|BPF_DW|BPF_IMM))
> > > +                       return insn[0].imm;
> > > +       }
> > > +
> > > +       return -ENOENT;
> > > +}
> > > +
> > > +static int bpf_object__patch_gotox(struct bpf_object *obj, struct bp=
f_program *prog)
> > > +{
> > > +       struct bpf_insn *insn =3D prog->insns;
> > > +       int map_fd;
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < prog->insns_cnt; i++, insn++) {
> > > +               if (!insn_is_gotox(insn))
> > > +                       continue;
> > > +
> > > +               if (obj->gen_loader)
> > > +                       return -EFAULT;
> > > +
> > > +               map_fd =3D find_jt_map_fd(prog, i);
> > > +               if (map_fd < 0)
> > > +                       return map_fd;
> > > +
> > > +               insn->imm =3D map_fd;
> > > +       }
> >=20
> > This is obviously broken and cannot be made smarter in libbpf.
> > It won't be doing data flow analysis.
> >=20
> > The only option I see is to teach llvm to tag jmp_table in gotox.
> > Probably the simplest way is to add the same relo to gotox insn
> > as for ld_imm64. Then libbpf has a direct way to assign
> > the same map_fd into both ld_imm64 and gotox.
>=20
> This would be nice.

I did not implement this is a change for jt section + jt symbols.
It can be added, but thinking about it again, are you sure it is
necessary to have map fd in the gotox?

Verifier should be smart enough already to track what map the rX in
the `gotox rX` is a derivative of. It can make use of
bpf_insn_aux_data->map_index to enforce that only one map is used with
a particular gotox instruction.

[...]


Return-Path: <bpf+bounces-62574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AC3AFBEC7
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDBE1AA2C92
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 23:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F1928DF3E;
	Mon,  7 Jul 2025 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai2Ps8NT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F9328CF61
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932169; cv=none; b=PCRDFou8elnMTD4RvEixq3ccqusahzBG/umXT1BFFM+u7NKTI05ekC1uKkjv61JE9YqUf1jJDRabV2grmlTY03KVD20pd6o2x+MPWdvAGkjwNSzF+rY2s/LU1VeKCrcEs/HGEztSQJcfQ0S4lVgbJxz5knebQHZ+/cRTHYaAGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932169; c=relaxed/simple;
	bh=EpUwfCS0Rhs6rfLT/L4kVSBApFH5Neu/8IvE7LgD+xE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8kMzMxOv7Hzp9YH/rC3GagH0PYnauUrEy6ab7WpJw5Lz4nhOI7NABxy/tFh0yhJRV9EehQUkOZ5wxTQZi2fvbxJAHbH/yLAf9J6NTUxcrZoUnmM5ED6oLMlHdzyC1QEaz/YUue4FAaVolgsfQh1PN1S4zx136Ib27rEIuJMgTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai2Ps8NT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso2811124f8f.1
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 16:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751932166; x=1752536966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48fk4oNfWG3DsOi8kLc3ybG0FhgfpnUahLuBViZM+sY=;
        b=Ai2Ps8NTfJqPJIkI5TSE8R5+cZBUVB61qJNI0HKZmKSTTaBcSMrObKpm/aShT+kmBh
         P7DmEx+T12CN/mkJPMv0h49F/RmBOR3tWRWKs/fCTtEzAniK+f7G5M5JtzgOf1MUMEZP
         LgGad1/Zp4qIlG/Zo7logHrpuMIfiX8II7jx37Y7pNQRep8gLQJwvacFbiAGq9Ya/1fn
         +Yr5vayNzN8RZKXH9q+bmpBmQXe/I8LF5F5F7HdvNwbAw7rKQJC8EsCdZXsZ+zkl4n3e
         AhFZ3WQxwApHujYTCx4U5F8mL7rMLVgvPbabQkTDZCBkEVtEQqvEdRJ+CrWzSxgDBVw0
         26tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751932166; x=1752536966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48fk4oNfWG3DsOi8kLc3ybG0FhgfpnUahLuBViZM+sY=;
        b=XahkHuBX3Gnwx/4MXHzds2nPoIP6EEBPdVEjGrmqUZPHuCU/T1nEB0oUL3LaycMKx3
         qs1JlB3WPkVNScRwHhVkv55U5vEOJJEyUPGgkakJ11QtIqVU3Dwc8qwE4keSXy+Jecuk
         NCX2yvWKNaMAeWUOtwQ0Ixl0UwSND997wfS0jbXiilPdVbdzUnAv9dg16Dvi71HJ31vx
         rMsxhTey9kthgTddAwdJftQy/KDGX5h7oGDVx/9YTwu01FKMHeWqxamVci26/D5WPhPx
         trNDAOw/QCBqzs3NZYnS64My/4i6qjNkImCVzoWrVgIUSPHU5ixkOi8+POojHrQp1F7a
         S6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3kdWEIEDnLV2oUYl7fGpxwpPZyhi6PaRXL+7Ibkxx6DAIRY/+lzVnz9qb455aPBerpJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC+LS3C5+31tXEnWMvDmQHp+lnmLUFO+wm4RHj/G6++nwitS5N
	u2i4nv55EzBzq5gLejJG9++AHrhc7pGcdNdJdJY+4d2y9NtGwzXWGqFUZ5ABBOhs3LChaNhWyHM
	ULWJEly/SrxTnvuB4yPUBGxlYS3MmikU=
X-Gm-Gg: ASbGncv0qC8ZxSRe0mCDZy2LAWKQGiTgqu0ezgQCasgB0C5fqkLBjx4JGqsPaGfGJfv
	q6pCsrlqpgns8CGsgDK+hA6od0f0E3B6nmf3bT5uF0TULpgEKoXx9g9KqN9mHQbeYEa1NxyStMg
	WXMhuiRB3M6CHM7fHI8tvo391jViHNhBd9QkOm1eFTSOVB0Hy8gg1N1unYdhRt4ghmD+5Fzaz9m
	uJtqTBOdxg=
X-Google-Smtp-Source: AGHT+IHNK1NpmCkM5SNWFKpUyUURgTUK+gZ6zuXcfGLf8aN173QcIs3+jG6sT2h3JY7o4XxUZewTebKDrH3cGf8K7v8=
X-Received: by 2002:a5d:64c6:0:b0:3a5:2e59:833a with SMTP id
 ffacd0b85a97d-3b49700c68fmr12161582f8f.1.1751932166128; Mon, 07 Jul 2025
 16:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-9-a.s.protopopov@gmail.com> <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
 <aFLWaNSsV7M2gV98@mail.gmail.com> <e726d778a3cf75e3ceec54f5f43b9d5d66ba5e97.camel@gmail.com>
In-Reply-To: <e726d778a3cf75e3ceec54f5f43b9d5d66ba5e97.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 7 Jul 2025 16:49:15 -0700
X-Gm-Features: Ac12FXwD2aMBZaIESyiDpMhz5bkmLOd6fo5lZVzisAG2ZyrgqR4Y66JPzoSTynw
Message-ID: <CAADnVQLaBuDYBoQvVtug63MJO+2=oqb9PYap8Jv+U8HB4ETe9Q@mail.gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Anton Protopopov <aspsk@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 4:45=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2025-06-18 at 15:08 +0000, Anton Protopopov wrote:
> > On 25/06/17 08:22PM, Alexei Starovoitov wrote:
> > > On Sun, Jun 15, 2025 at 1:55=E2=80=AFAM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > >
> > > > The final line generates an indirect jump. The
> > > > format of the indirect jump instruction supported by BPF is
> > > >
> > > >     BPF_JMP|BPF_X|BPF_JA, SRC=3D0, DST=3DRx, off=3D0, imm=3Dfd(M)
> > > >
> > > > and, obviously, the map M must be the same map which was used to
> > > > init the register rX. This patch implements this in the following,
> > > > hacky, but so far suitable for all existing use-cases, way. On
> > > > encountering a `gotox` instruction libbpf tracks back to the
> > > > previous direct load from map and stores this map file descriptor
> > > > in the gotox instruction.
> > >
> > > ...
> > >
> > > > +/*
> > > > + * This one is too dumb, of course. TBD to make it smarter.
> > > > + */
> > > > +static int find_jt_map_fd(struct bpf_program *prog, int insn_idx)
> > > > +{
> > > > +       struct bpf_insn *insn =3D &prog->insns[insn_idx];
> > > > +       __u8 dst_reg =3D insn->dst_reg;
> > > > +
> > > > +       /* TBD: this function is such smart for now that it even ig=
nores this
> > > > +        * register. Instead, it should backtrack the load more car=
efully.
> > > > +        * (So far even this dumb version works with all selftests.=
)
> > > > +        */
> > > > +       pr_debug("searching for a load instruction which populated =
dst_reg=3Dr%u\n", dst_reg);
> > > > +
> > > > +       while (--insn >=3D prog->insns) {
> > > > +               if (insn->code =3D=3D (BPF_LD|BPF_DW|BPF_IMM))
> > > > +                       return insn[0].imm;
> > > > +       }
> > > > +
> > > > +       return -ENOENT;
> > > > +}
> > > > +
> > > > +static int bpf_object__patch_gotox(struct bpf_object *obj, struct =
bpf_program *prog)
> > > > +{
> > > > +       struct bpf_insn *insn =3D prog->insns;
> > > > +       int map_fd;
> > > > +       int i;
> > > > +
> > > > +       for (i =3D 0; i < prog->insns_cnt; i++, insn++) {
> > > > +               if (!insn_is_gotox(insn))
> > > > +                       continue;
> > > > +
> > > > +               if (obj->gen_loader)
> > > > +                       return -EFAULT;
> > > > +
> > > > +               map_fd =3D find_jt_map_fd(prog, i);
> > > > +               if (map_fd < 0)
> > > > +                       return map_fd;
> > > > +
> > > > +               insn->imm =3D map_fd;
> > > > +       }
> > >
> > > This is obviously broken and cannot be made smarter in libbpf.
> > > It won't be doing data flow analysis.
> > >
> > > The only option I see is to teach llvm to tag jmp_table in gotox.
> > > Probably the simplest way is to add the same relo to gotox insn
> > > as for ld_imm64. Then libbpf has a direct way to assign
> > > the same map_fd into both ld_imm64 and gotox.
> >
> > This would be nice.
>
> I did not implement this is a change for jt section + jt symbols.
> It can be added, but thinking about it again, are you sure it is
> necessary to have map fd in the gotox?
>
> Verifier should be smart enough already to track what map the rX in
> the `gotox rX` is a derivative of. It can make use of
> bpf_insn_aux_data->map_index to enforce that only one map is used with
> a particular gotox instruction.

How would it associate gotox with map (set of IPs) at check_cfg() stage?
llvm needs to help.


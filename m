Return-Path: <bpf+bounces-60978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009D9ADF2D5
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CBF3BEC93
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9F12EAB84;
	Wed, 18 Jun 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ww+vhGyy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0362F2DFF15
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265013; cv=none; b=VawH/Uf5LmjImvvF3VLPxFgmxjJIoYe0ronwADBBnJ0buRDdcXlt3V8YpLO2oAmthXI5eFkqcDWqfpqoyMh6cZiJTJ4Df/zfCPvGx2Z9IkAZXokSdeghUH36VYdAXiTxb9mXNwVlcYcfhBRQpLhzCzWbglJKSKevRCvolTit6/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265013; c=relaxed/simple;
	bh=EfNIMEvOqXayPwLcM0cShxa2ZJuMjzz7/i7KxBAJUxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgW21gomWt7PLlhQqtDN5Qkgu1Vz9alYmwyhBUeDz/UCLBNkK6y7ttAaTDDMdfWrsyYuW5mZxmk08eGxc7xByTfHiU8wxVeCrjugz+lYwLulhSLgclJgnnLWx8xxUDoIwNaln0QrBrUx0bOSgMYqGLr0vSWO3krA67FOPs2zWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ww+vhGyy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d7b50815so60840905e9.2
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750265010; x=1750869810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MILr42DFGRdxX4tsY4hgWg/wY4rAW5m9e9TfpX8Mhco=;
        b=Ww+vhGyyOh/61KFSl1IE+wbZPklUm/4h94NcvCh6CVqIBNhijSIlat/28XSZzFboUV
         1Gvj4Qn1PXfzSkDGi/IT0b6lBa7zF9qwjqYHODR53JX08dH/BgXUZMBxyH3g1Y1g7N1Z
         wopWbDjtnB3Wq/fQRNUSkJquoPr0fL89tT9U59WqaugzlLrvnAPncQA8AqFEZjBP/7Dk
         o0cJM7j/fUj7EAZsM4Psg0YeJfsHEyI6jTwCrUP+3KdE/OYXHndzZxO8aUevHCQqysnl
         3cMqTDDqRn0iBSjXyi2LrBOFlhKiV8XL7Pf6tbxRRzyHwVSXQaqBoYAWDa9JQ3dmgGuH
         o+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750265010; x=1750869810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MILr42DFGRdxX4tsY4hgWg/wY4rAW5m9e9TfpX8Mhco=;
        b=uf5IMAJclLrX8442KSAxF8xi026Uvonzbe9kFV3/nK0IXVrF9wTE8MWWVYvp6GrL9u
         osDkHgPj4A/KGcR1vHA2LpEK7OWO4WM3WINKES0v7W+FZasUWvWHY0KTrNCEm9sWgOEN
         bdRCladRiha+Y5FeLXYTttXMpYFhFdMUaMY8D8e+n3cffcyvtr1Hzgh/xaDfG72nEVgj
         H/WpNKDG0/p6htesp5JyyEXxcpWVTXytKTeFQPnDibsMTGsX3Uk3zBbjSSMxjczgPy+m
         jml5KhkB373WyqLQzrOt1IwT2HsWJFDuLTB5zxQYLi9hpe+1CjGiNTQKQN2tJizib+zW
         NZrA==
X-Gm-Message-State: AOJu0Yx3R2c5moF1nrHC6DKgBEs6TL0+BjmJJhb1Sj0kTI4w6fljV3UQ
	NKtYlrjp/eo+oT3wxaRw3r4q906ybRSF+Ry4X5qH6UduVOFv3D76WxFH6NHf6bFuwLsiCehenjo
	xZIYl0Hv+m4GQc+dbQXNIf+wSb/qqLeo=
X-Gm-Gg: ASbGnctGo3C+/uJid7CEDXFhYCspCbBSmRRb9sqH0PwxGT+sJEZgyw4oihL/Xfd4XZj
	wI3hLHSNk+oKe6/slj344thmQC89WY0ALi24FZrx/63wruQ/VZjn7pxrJXuPeM6F0vz5pjZPeY+
	Wrqcou/eJ9qnqv4n3ePSLy7Cpe2F26bfNwj39XwQIyfbfX/hYai32Shjad2Tlvo5+d8HSRs/z6
X-Google-Smtp-Source: AGHT+IEnr6DNtrOsQZ3J1ehMphXrok0sEr6A84THc06IlMUgsqJPcgFi2Ffa4ZdJ4RxJQxVX1kVkv8qpBHYTud0QSMk=
X-Received: by 2002:a05:6000:24c8:b0:3a4:f918:9db9 with SMTP id
 ffacd0b85a97d-3a572e79fa4mr14195991f8f.32.1750265010041; Wed, 18 Jun 2025
 09:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-10-a.s.protopopov@gmail.com> <CAADnVQKPbBRGOj2mB5Um80VFUh_vVg=oRJCdYUgyz_DrObuagQ@mail.gmail.com>
 <aFLR7NrdX3gbjC1s@mail.gmail.com> <CAADnVQ+nHemrEgeWYHxLi1UVeJ2u7DtSDTpcrPR7w2PgFPgQZw@mail.gmail.com>
 <aFLq/blfEEiIqXGz@mail.gmail.com>
In-Reply-To: <aFLq/blfEEiIqXGz@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Jun 2025 09:43:19 -0700
X-Gm-Features: Ac12FXxCFr6Q1aQdAM_-8uI2sFt3cXiuSNdqOs-rhaUYwLwUmht7e8xL1F4Z6Zc
Message-ID: <CAADnVQK7M7L4j8ydo7GOFqZ4rbdJwg_Ghx6uNcD8SqMQnBbZCQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 9/9] selftests/bpf: add selftests for indirect jumps
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 9:30=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 25/06/18 09:01AM, Alexei Starovoitov wrote:
> > On Wed, Jun 18, 2025 at 7:43=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > >
> > > On 25/06/17 08:24PM, Alexei Starovoitov wrote:
> > > > On Sun, Jun 15, 2025 at 1:55=E2=80=AFAM Anton Protopopov
> > > > <a.s.protopopov@gmail.com> wrote:
> > > > > +SEC("syscall")
> > > > > +int two_towers(struct simple_ctx *ctx)
> > > > > +{
> > > > > +       switch (ctx->x) {
> > > > >
> > > >
> > > > Not sure why you went with switch() statements everywhere.
> > > > Please add few tests with explicit indirect goto
> > > > like interpreter does: goto *jumptable[insn->code];
> > >
> > > This requires to patch libbpf a bit more, as some meta-info
> > > accompanying this instruction should be emitted, like LLVM does with
> > > jump_table_sizes. And this probably should be a different section,
> > > such that it doesn't conflict with LLVM/GCC. I thought to add this
> > > later, but will try to add to the next version.
> >
> > Hmm. I'm not sure why llvm should handle explicit indirect goto
> > any different than the one generated from switch.
> > The generated bpf.o should be the same.
>
> For a switch statement LLVM will create a jump table
> and create the {,.rel}.llvm_jump_table_sizes tables.
>
> For a direct goto *, say
>
>     static const void *table[] =3D {
>             &&l1, &&l2, &&l3, &&l4, &&l5,
>     };
>     if (index > ARRAY_SIZE(table))
>             return 0;
>     goto *table[index];
>
> it will not generate {,.rel}.llvm_jump_table_sizes. I wonder, does
> LLVM emit the size of `table`? (If no, then some assembly needed to
> emit it.) In any case it should be easy to add this case, but still
> it is a bit of coding, thus a bit different case.)

It's controlled by -emit-jump-table-sizes-section flag.
I haven't looked at pending llvm/bpf diff, but it should be possible
to standardize. Emit it for both or for none.
My preference would be for _none_.

Not sure why you made libbpf rely on that section name.
Relocations against text can be in other rodata sections.
Normal behavior for x86 and other backends.


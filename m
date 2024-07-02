Return-Path: <bpf+bounces-33676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9109249CE
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DE21F22706
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C289201270;
	Tue,  2 Jul 2024 21:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHXO1gy8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC76128372
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954996; cv=none; b=Qv0xnWOUDwz01vi/IsXKmFMM5KDM4p8i+mQGIALD+uCnBnU3/AItU7Nounxft8DC1WmLi5Fn3Lem0U9nn2YrEABjt4owa56RgiC/MgGqTXHuXLtITCEL7uZUQm/FgU6l340d22Bm7OcIuMALAF7UWgz5wPxO++lTCqTjQfe6Jy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954996; c=relaxed/simple;
	bh=Ai2JBe80HSZUZBA6D4v+fQtdL8oBTa2juKAPqP8GjQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRGh+4EJLSnXbzpp0QvlUV1S9cfa3L0BtueCxLJuo5qnNOaeyg+zGVzNji0VxO+c6QXSjWwgbfub+VABQe26/3jyNgV512FzSU09QpwtWyqn+8lLIZfSwecCiulGBfcZlUx7lDgzZGK3dTtoMpR9HethHs1dm24A3sgISssH0fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHXO1gy8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-706524adf91so3838612b3a.2
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 14:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719954994; x=1720559794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSt1LCWRtBtfDebvaY5Y0Wwy/1IUFBN2byg44CszrqE=;
        b=CHXO1gy8PPZwD9cPgSQo7PSmRwF/UqtyCupfxnMWU2cXZWJqDVydnp0490hLlaPQre
         /WjuJDXApWRVf+nZSJrnNy9QM4i1FQCz0zsQAzVtYJYufFsDwYDpgb257T1SDeUvErYy
         R1UXZcxkPyxWDzddfhJK1I6gLsjilhky0FhoQfeooy9dZHo3p3lBU4bU51NAxWw3TYXl
         I3RqMAiRwl54V91Z6iQG7cKsRmRM21HtlCFy47TAMHjTQISFnJx8gSEqZBkwMm+oNZFb
         /11Gt3I+VjIdSKgM3n5SYFJ6pg2ZlnMPXXyQNSnk+fNZdh0lXzqzkFnOPJTFaMRmGA0M
         mraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719954994; x=1720559794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSt1LCWRtBtfDebvaY5Y0Wwy/1IUFBN2byg44CszrqE=;
        b=wr5ZavFx3cvRqD56BCrfJr78yjY1pfVSRlangOd/B9uf+94JkW9ZmjvSvaN4aecL0A
         TpDGT2k0IC+jlkcMg9aG+G3g4mHwzzUF9VJRDdaKsaa7waeiK07CpHRvIsunHbhp5bIU
         doJGQBGkmBuYB+xp+uFIJ6vP2XzfLZMSFgQk547p7RL3ObWgxqGIi5MnVLX1j7xMdQsv
         75UTolw8YgP4Z2KW679OrN14j9HlDYf0p36AGfrOAs4iWAmbbrdeNUdrvOfyQOa7aMqP
         OLAjPU1Y629zWKxJ0NohtaahpLsv8qq4Ozl8iXnlJRP1yE0PvZIOmPSCbWawQVbxZ6An
         lEPA==
X-Gm-Message-State: AOJu0Yx4tlHwi76QxlKXDz9kUELc4rwNTHpkecZqkF5C/XCQ8VmF4FNo
	LXa4XGdbHOeBgEtbP4hzQSmY8i17NJgJT7+U2DZOedLd2auFRMSVJKePcIUqzozQDpd5knkzkM8
	CSLB2hUw1bxv4nJ1SI1EvMeORNyw=
X-Google-Smtp-Source: AGHT+IEMmMUf+g/3x7AHCLlM3lsmDbkFp1xxGFSusjaIaMw7dTVGghZxigLrxFwcLEfhmNZAXf7/3ygwm6Bkv97YUFE=
X-Received: by 2002:a05:6a00:1396:b0:706:6996:f025 with SMTP id
 d2e1a72fcca58-70aaaed4911mr13721254b3a.24.1719954994125; Tue, 02 Jul 2024
 14:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629094733.3863850-1-eddyz87@gmail.com> <20240629094733.3863850-5-eddyz87@gmail.com>
 <CAEf4BzY_6iBHx5Hu1ick8qHb-kOaKpyG0vEqAcc1D7RKdbZs_Q@mail.gmail.com> <6e74d6336ad5193d890b2704025783f90c4f0fbb.camel@gmail.com>
In-Reply-To: <6e74d6336ad5193d890b2704025783f90c4f0fbb.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 14:16:22 -0700
Message-ID: <CAEf4Bzb3ETD-wKyF9g65bBoa2ayS=eJ=AwmcTYctc5i015-psA@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 4/8] selftests/bpf: extract utility function for
 BPF disassembly
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 1:59=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-07-01 at 17:41 -0700, Andrii Nakryiko wrote:
> > On Sat, Jun 29, 2024 at 2:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > uint32_t disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz)=
;
> >
> > or you can return `struct bpf_insn *` which will point to the next
> > hypothetical instruction?
>
> Not sure if it simplifies clients, e.g. from this patch, the following:
>
> +       for (i =3D skip_first_insn ? 1 : 0; i < cnt;) {
> +               i +=3D disasm_insn(buf + i, insn_buf, sizeof(insn_buf));
> +               fprintf(prog_out, "%s\n", insn_buf);
> +       }
>
> Would become:
>
> +       for (i =3D buf + skip_first_insn ? 1 : 0; i < buf + cnt;) {
> +               i =3D disasm_insn(buf + i, insn_buf, sizeof(insn_buf));
> +               fprintf(prog_out, "%s\n", insn_buf);
> +       }
>

struct bpf_insn *insn =3D skip_first_insn ? buf + 1 : buf, *insn_end =3D bu=
f + cnt;

while (insn !=3D insn_end) {
    insn =3D disasm_insn(insn, insn_buf, sizeof(insn_buf));
    fprintf(prog_out, "%s\n", insn_buf);
}

less addition, but it's simple enough in both cases, of course (I just
find 1 or 2 as a result kind of a bad contract, but whatever)


> idk, can change if you insist.
>
> [...]
>
> > > +       sscanf(buf, "(%*[^)]) %n", &pfx_end);
> >
> > let me simplify this a bit ;)
> >
> > pfx_end =3D 5;
> >
> > not as sophisticated, but equivalent
>
> Okay :(

if 5 makes you sad, do keep sscanf(), of course, no worries :)

>
> >
> > > +       sscanf(buf, "(%*[^)]) call %*[^#]%n", &sfx_start);
> >
> > is it documented that sfx_start won't be updated if sscanf() doesn't
> > successfully match?
> >
> > if not, maybe let's do something like below
> >
> > if (strcmp(buf + 5, "call ", 5) =3D=3D 0 && (tmp =3D strrchr(buf, '#'))=
)
> >     sfx_start =3D tmp - buf;
>
> Will change, the doc is obscure.
>
> [...]


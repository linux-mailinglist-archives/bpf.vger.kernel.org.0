Return-Path: <bpf+bounces-55421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DEEA7E81D
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 19:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B8418899B2
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFE721638E;
	Mon,  7 Apr 2025 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY+a9blC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D720FA94
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046778; cv=none; b=uVxmyPdzvRdmNlUx9hZ3d/ztC9JFxBjwEUjAn9JM092l4ZVGxXtQHo28N1x9vMlylLDR+bRZMjZGC9+u79ekMMzbssUxWem2kCOkaXuuUf83oHedAuhaVXKD7KIvPNlGhSh9hoX4DZJN5uxyl5xpT+r7KZlb9XK2rfW8Qp/qfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046778; c=relaxed/simple;
	bh=ki8IJoKw5vpLxSbOpmp2+cnSUHuZ720wywNIfVxeTfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6O1+OYbJpHDt6DYvC1XaqCuvhSFtM/l48ZWIgLk2IKzJ2nLMpbABJgLn8HXGr81/NowIkMBId4MojzrScFzxXJquLSn7eFXd7TpB7fM3ccz4GZkt2/JGJIGZ1hFoyfDM3qDXW0vHHCH1d2/YbOlNsfEBC6zP35zHTDfXuBS2ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fY+a9blC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736b0c68092so3683530b3a.0
        for <bpf@vger.kernel.org>; Mon, 07 Apr 2025 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744046776; x=1744651576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cno63MUqBvBLzcvKEkg90ZnmEBlBBvSPi9LQJ6+1c0E=;
        b=fY+a9blCAQslzFxlml+gfYwVVM3UhSMUfalmeKm/+StOfACvNqhvN2NzXL17auN5/1
         ykz4xm6yNWpdURNBM/1hBKhN0s3qJJ3eOlTCbfNdP9uRl3Hq5I7SagJMKMWa01KEshUH
         qfd5hU3vOe3yy5tUVU4y15N7sSySPL6EZdA7JZ4qSArkTTCQEkaWj5bnsWC1AlsFaOLO
         o6uG23KUdIfrmHVPhkZhlZIHQj1yLKEjQVuz/RG01w6KyB+Spzt3pA+53iUwECy9U6rZ
         GR1TugSfqY0kfu8JoBX32VSyhg+nI8EYIFZJ1ksSEjgEVnDC14gE4OOKuQkEEk4+2To3
         3REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744046776; x=1744651576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cno63MUqBvBLzcvKEkg90ZnmEBlBBvSPi9LQJ6+1c0E=;
        b=ktuhip9WGOBc/kLabTTOSM65U51nKjD3wzu/btTRd6Xy+CpFkk8P20J6KIi5DMvNNG
         oREbVKASSLULLPEDgotXjiILLjy0UQ3L5tZCTFsTvS4TneQL5nV9byqg/vpoUZNC+VOS
         12KJm5s4JUchPeqI/eqh9W7bELfmYGKE/0IoJtwNy5d1y7SY2L/4a6jZEidbF7fX4eSs
         pow4NlxRC3g/z2HQF1EuY+Mkepi2DgnqM+wNeoMiuOfJ3xVpGEmXRua+KrCqRsBHuCcQ
         hPyDjSvmGXljd+QcGIHvb1HWaylEr3DMu7IzxwIjAobtLhE7qgO2XfvrA6NTRd2UxIRJ
         R1dw==
X-Gm-Message-State: AOJu0YyN9W3bqwyWx4s/7D9PzU45BcFcjwW2CrCLhDwfP05ezS0EA7mt
	80y1yhxsYY00EQS9Ox0kh7KvOBf7XkNG0ivrt7C8g0Z2G6kXD6Pzr6bec9Z+50WuEjgfN6giCGw
	7NVPSpTy2Jh2Dd3cPadyQ+9Ag2N4=
X-Gm-Gg: ASbGncvyx0baBcRzufxjswlDRYLJrw0OHcdzdNgHjMXQNtYBaZCixMsBzKwGUN4BTsL
	1JTwpDfxCsRVxeRlSEDrjgRRckcWjbzCz/c5IVf0pJ52NcydYflwc/Roq6wGIeo82PZmPipocih
	U5IbqPJ9b3AbZVfEEEFg7eO2uwkwxO8BJP+y0na1g/jQ==
X-Google-Smtp-Source: AGHT+IHgggvRdMMbwPhX/MnPzwgUxci6oTNY13g7SHdrKYlMD1PRBNJ1aOLmXLY91lO0On/K+nR3nlQ3KZnmCP+Mpj8=
X-Received: by 2002:a05:6a00:130b:b0:736:a6e0:e66d with SMTP id
 d2e1a72fcca58-739e4922098mr17606327b3a.6.1744046776342; Mon, 07 Apr 2025
 10:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331211217.201198-1-mykyta.yatsenko5@gmail.com>
 <CAEf4BzbD1SP=fv0cG81HBS6Ld_v07f4RXgDDR_EMhEYAkHjx9Q@mail.gmail.com> <8dc17d02-91e8-4720-8f4d-33a450eddcc8@gmail.com>
In-Reply-To: <8dc17d02-91e8-4720-8f4d-33a450eddcc8@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 7 Apr 2025 10:26:04 -0700
X-Gm-Features: ATxdqUFvSzHSL7bVzQBqA-sI5g3XLjNgOO1da6vKALqVapUd7pLYs9lP5axMUVs
Message-ID: <CAEf4BzY55W6rn-jSzdfCJGDW1J+58b_BuyO_LXfD0KA1L6ijEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: support struct/union presets
 in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 9:35=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 04/04/2025 19:39, Andrii Nakryiko wrote:
> > On Mon, Mar 31, 2025 at 2:12=E2=80=AFPM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko<yatsenko@meta.com>
> >>
> >> Extend commit e3c9abd0d14b ("selftests/bpf: Implement setting global
> >> variables in veristat") to support applying presets to members of
> >> the global structs or unions in veristat.
> >> For example:
> >> ```
> >> ./veristat set_global_vars.bpf.o  -G "union1.struct3.var_u8_h =3D 0xBB=
"
> >> ```
> >>
> >> Signed-off-by: Mykyta Yatsenko<yatsenko@meta.com>
> >> ---
> >>   .../selftests/bpf/prog_tests/test_veristat.c  |   5 +
> >>   tools/testing/selftests/bpf/progs/prepare.c   |   1 -
> >>   .../selftests/bpf/progs/set_global_vars.c     |  40 +++++++
> >>   tools/testing/selftests/bpf/veristat.c        | 106 ++++++++++++++++=
--
> >>   4 files changed, 144 insertions(+), 8 deletions(-)
> >>

[...]

> >> +       while ((name =3D strtok_r(NULL, ".", &saveptr))) {
> >> +               err =3D btf_find_member(btf, base_type, 0, name, &memb=
er_tid, &member_offset);
> >> +               if (err) {
> >> +                       fprintf(stderr, "Could not find member %s for =
variable %s\n", name, var);
> >> +                       return err;
> >> +               }
> >> +               if (btf_kflag(base_type)) {
> > hm... doesn't kflag on, say, STRUCT, just mean that there are *some*
> > fields that are bitfields? If we don't reference those fields, it
> > should be fine, no?
> >
> > So, instead, I think we should just check that
> > btf_member_bitfield_size() for that field is zero, and if not --
> > complain.
> >
> > Can you please also add a test case where we have a struct with
> > bitfields, but we set only non-bitfield values and it all should work
> > just fine. Thanks.
>
> There is already a test with bitfield struct, this behavior does not
> repro, though
> (btf_kflag is not set for structs with bitfields).
> I think it's better to move this check out of the loop and only run on
> the final type
>   we return in sinfo, either way it makes no sense to do it on structs,
> as you noticed.

Discussed offline. Checking kflag will trigger false positives and
will reject fields that are "colocated" with bitfields within the same
struct/union. The proper way to check this would be
btf_member_bitfield_size(), as suggested above.

> I think I'll also move
>
> +               sinfo->size =3D member_type->size;
> +               sinfo->type =3D member_tid;
> out, as we only care for the last type in the chain.
>
> > pw-bot: cr
> >
> >> +                       fprintf(stderr, "Bitfield presets are not supp=
orted %s\n", name);
> >> +                       return -EINVAL;
> >> +               }
> >> +               member_type =3D btf__type_by_id(btf, member_tid);
> >> +               sinfo->offset +=3D member_offset / 8;
> >> +               sinfo->size =3D member_type->size;
> >> +               sinfo->type =3D member_tid;
> >> +               base_type =3D member_type;
> >> +       }
> >> +       return 0;
> >> +}
> >> +

[...]


Return-Path: <bpf+bounces-51181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAEDA316EC
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 21:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D4A3A35E3
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 20:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C28B262D3B;
	Tue, 11 Feb 2025 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akYXqf7z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A481CA84
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307236; cv=none; b=EnZxe3ITAJlF8W4bq3MqUWyjBvizWbNseHO/RNIKj+VWkJGM/NxNPNgMAKXKL8mhuaZfZr9HEUke5+5shySrdbpynijEYNrn3ckZlEyoCAump60KTNXFUaUgQR3miaRYe+iUaNY6X9cBTFNw2v53dssSDlaG0NIvu8urBMaeBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307236; c=relaxed/simple;
	bh=x1OFxNhwAm2hcVmCIfSaumXm68GXVluOU6Dc/o7HEnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjYHkK/bn3P8We2WTDJHad9asRhaX1kUdeLh1C4w8qPaMmeQW+FZAlgV3UovijQtn+4m18UiQWwlekZwTqHFLdOcIBIzZqvexm7JedqxnrljSK7Q+PX5MuKh8pUlp9vA9KTFjEGfl/ZF+oDhzwO0biZPzg2Rv5gP+sWxJhgmGsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akYXqf7z; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f62cc4088so72230645ad.3
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 12:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739307234; x=1739912034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hlzN/FjQBGt8AoZPhYCmEoFrf5/sGXRy1zCiZTZlis=;
        b=akYXqf7zgp/967OR86jyQKgX0gQ7uZWpWiw8w3sfFYnPq84NcLthtW7cgOlZJzFWIT
         /VCLaVZRY8ZBzYPt/ODUDlGrzWn88boQc74VAZVLUc2e57WI3C/AK7cKgyJbGZ6ZQClx
         OnnayYLZskHIa2j51/RxyJkoaxsJ8CTu8caazLa6T2ne3cws3y+ZdBgyWs3XnyFMUIHK
         sKFQMvSRejqR/p1pg3B+9ZLD2mXf2FIgkFIR+WgaRaoseDIPcVmgSnQA6Q1q1aHZeQd/
         ti4YKFcVT6dSf3cixgGEfcW8UO85sazGn+1mEI7CeDO56MxRwQVkefwyPkBTtu5LdTgP
         slRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739307234; x=1739912034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hlzN/FjQBGt8AoZPhYCmEoFrf5/sGXRy1zCiZTZlis=;
        b=sXHNH+YxpYoauPPf+1Seu98l8w3BjERioGBF+wW1fxxF+B4MGxcLMeU8GAlX0pwU8+
         fR9tz9Qd2WkW5sM6df3XFOkBhdA55CtbqqlDzAzVVu46FgGXqYthldgBbJHPxRSvP/Hx
         KysYpaI6ETud2FM5NybWsAhmOWxGq8wj/fQh59EZr23cTQTgAoPDbGqVQt1XqMq/stCb
         MCThCnRYnZiXQTn0HqK5qFUROn0n2FMi71BkuPZNT3nkOYogxDKGGH/idneXYPHXFCow
         ld5ODky37qCeOcCePsQMOE/1uKV+G2KS33uJAxRCgFx86b6B2bKx0/5d5ZE4FIO1huO9
         wFgQ==
X-Gm-Message-State: AOJu0Yy2gY0q+DOkS7PVoZX9yqXGAAPCGXhqqvItWkA8PbYVu+w1DPW+
	pMcZty9QVTQZ6kGLaUIfX/ERLynW4Ow8g3QPZJT+sBUQpWm2r+fIFTP2ARmgXifHqkRkQw+wnjN
	wWtbi0lKushtkPldV25ntJI+hWfI=
X-Gm-Gg: ASbGncsVNO5UV6FPM8x/sNhT460fvDOvqJ6fqBg7tjZGQYBeQ1FUki5b7tTLY51qtgP
	Pb21ggzFQ79dA5orQQlEHJZiK5erTf8K/A1QY/K6W4ZgA5ryAJpQ++bU9nWglCbBMaCsYqMs32B
	IYpfyT1J6Iv/2q
X-Google-Smtp-Source: AGHT+IG5qBELbCGDAnMoAtHMLMx7US0DJK6d+y5J0nHcR4PvXqfR4LePUdTi/lLAiN9ii40vWnVUxwqEkYJLqiRGR8A=
X-Received: by 2002:a05:6a21:6d99:b0:1e1:dbfd:582b with SMTP id
 adf61e73a8af0-1ee5c7454cdmr1064672637.15.1739307233596; Tue, 11 Feb 2025
 12:53:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210135129.719119-1-mykyta.yatsenko5@gmail.com>
 <20250210135129.719119-2-mykyta.yatsenko5@gmail.com> <CAEf4BzYVWSogUYk8pEPGs0N4eNb5fcXtmFMLkicokmqHPpbZCg@mail.gmail.com>
 <e2f5ec85-f3ba-4bd5-bc04-e6d9bc8945e8@gmail.com>
In-Reply-To: <e2f5ec85-f3ba-4bd5-bc04-e6d9bc8945e8@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Feb 2025 12:53:40 -0800
X-Gm-Features: AWEUYZmeojxCaeHo8WccEdJOn1v4ZsqJ_SEYj3b4zWiVUE1-PIpNq85f4isLYtU
Message-ID: <CAEf4BzYLa24Sp889pUPQ_4c4+MvdeP5GFu4ZDBvXPnRRvyDB7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: implement setting global
 variables in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:00=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 11/02/2025 01:13, Andrii Nakryiko wrote:
> > On Mon, Feb 10, 2025 at 5:51=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> To better verify some complex BPF programs we'd like to preset global
> >> variables.
> >> This patch introduces CLI argument `--set-global-vars` or `-G` to
> >> veristat, that allows presetting values to global variables defined
> >> in BPF program. For example:
> >>
> >> prog.c:
> >> ```
> >> enum Enum { ELEMENT1 =3D 0, ELEMENT2 =3D 5 };
> >> const volatile __s64 a =3D 5;
> >> const volatile __u8 b =3D 5;
> >> const volatile enum Enum c =3D ELEMENT2;
> >> const volatile bool d =3D false;
> >>
> >> char arr[4] =3D {0};
> >>
> >> SEC("tp_btf/sched_switch")
> >> int BPF_PROG(...)
> >> {
> >>          bpf_printk("%c\n", arr[a]);
> >>          bpf_printk("%c\n", arr[b]);
> >>          bpf_printk("%c\n", arr[c]);
> >>          bpf_printk("%c\n", arr[d]);
> >>          return 0;
> >> }
> >> ```
> >> By default verification of the program fails:
> >> ```
> >> ./veristat prog.bpf.o
> >> ```
> >> By presetting global variables, we can make verification pass:
> >> ```
> >> ./veristat wq.bpf.o  -G "a =3D 0" -G "b =3D 1" -G "c =3D 2" -G "d =3D =
3"
> >> ```
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   tools/testing/selftests/bpf/veristat.c | 319 +++++++++++++++++++++++=
+-
> >>   1 file changed, 307 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/se=
lftests/bpf/veristat.c
> >> index 06af5029885b..b4521ebb6e6a 100644
> >> --- a/tools/testing/selftests/bpf/veristat.c
> >> +++ b/tools/testing/selftests/bpf/veristat.c
> >> @@ -154,6 +154,15 @@ struct filter {
> >>          bool abs;
> >>   };
> >>

[...]

> >> +static int enum_value_from_name(const struct btf *btf, const struct b=
tf_type *t,
> >> +                               const char *evalue, long long *retval)
> >> +{
> >> +       if (btf_is_enum(t)) {
> >> +               struct btf_enum *e =3D btf_enum(t);
> >> +               int i, n =3D btf_vlen(t);
> >> +
> >> +               for (i =3D 0; i < n; ++i) {
> >> +                       const char *cur_name =3D btf__name_by_offset(b=
tf, e[i].name_off);
> >> +
> >> +                       if (strcmp(cur_name, evalue) =3D=3D 0) {
> >> +                               *retval =3D e[i].val;
> >> +                               return 0;
> >> +                       }
> >> +               }
> >> +       } else if (btf_is_enum64(t)) {
> >> +               struct btf_enum64 *e =3D btf_enum64(t);
> >> +               int i, n =3D btf_vlen(t);
> >> +
> >> +               for (i =3D 0; i < n; ++i) {
> >> +                       struct btf_enum64 *cur =3D e + i;
> >> +                       const char *cur_name =3D btf__name_by_offset(b=
tf, cur->name_off);
> > you have two conceptually identical loops, but in one you do `cur =3D e
> > + i` and in another you do `e[i]` access... why?
> The difference is that for e64 case we get value by the
> `btf_enum64_value` function, which accepts pointer to `btf_enum64`,
> I think it is a bit cleaner to have an explicit assignment `struct
> btf_enum64 *cur =3D e + i;`, instead of passing `&e[i]`
> into  btf_enum64_value. Though, let's make both loops more consistent.

I'd just do `e++` inside for() and get rid of cur altogether.

> >> +                       __u64 value =3D  btf_enum64_value(cur);
> >> +
> >> +                       if (strcmp(cur_name, evalue) =3D=3D 0) {
> >> +                               *retval =3D value;

[...]

> >> +       }
> >> +
> >> +       /* Check if value fits into the target variable size */
> >> +       if  (sinfo->size < sizeof(preset->ivalue)) {
> >> +               bool is_signed =3D is_signed_type(base_type);
> >> +               __u32 unsigned_bits =3D sinfo->size * 8 - (is_signed ?=
 1 : 0);
> >> +               long long max_val =3D 1ll << unsigned_bits;
> > what about u64? 1 << 64 ?
>
> This should not be executed for u64, check `if (sinfo->size <
> sizeof(preset->ivalue))` is there for that.

ah, missed that check, ok

>
> >
> >> +
> >> +               if (preset->ivalue >=3D max_val || preset->ivalue < -m=
ax_val) {
> >> +                       fprintf(stderr,
> >> +                               "Variable %s value %lld is out of rang=
e [%lld; %lld]\n",
> >> +                               btf__name_by_offset(btf, t->name_off),=
 preset->ivalue,
> >> +                               is_signed ? -max_val : 0, max_val - 1)=
;
> >> +                       return -EINVAL;
> >> +               }
> >> +       }
> >> +

[...]


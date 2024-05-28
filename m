Return-Path: <bpf+bounces-30705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE168D13BA
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 07:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8A31F23B60
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 05:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74748446AF;
	Tue, 28 May 2024 05:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aOUgv6/M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A446A3E487
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873168; cv=none; b=KJoI8ELjUY66IMaRgAw0LCNafW0ZMnj9BIBMGrSaEw/7Cu/8rOiZzHUZ9wnpfapIQjGymNaKfB6DhMS31g9Ew3RhnJG2O6zCYkWSnCvtru04mNZ3PN3i+dMkqg7OFxF4XMThoFABbgbl+VOAEUdraCAPKkfPWoCzDuhx0t7YgDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873168; c=relaxed/simple;
	bh=2ZGZeycdp5GJxWuvBsZV8gpu6cM4WHkuZaGF7VCG6/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2gsJTSPKEXGM5CR23RJ2B/dBfpEq0nNckvrms+JBPgrc3Jal7a82Mq3FvfJBWRtzNYxVzrDsepl9GAklRGOM+DflSywVLJ8qhrkCXobZmQTkSDDuDGDEldmDsP7Ocsru3q0jog8+k26DnBb7tHoBg+byERZq3hx9b+KeOc37Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aOUgv6/M; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6341cf2c99so17569166b.0
        for <bpf@vger.kernel.org>; Mon, 27 May 2024 22:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716873164; x=1717477964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEzBOXaIzbfMi17IPevGDHsDdowwd5GTFXbnEzHCSrk=;
        b=aOUgv6/MvoCU8iHGHkp26EK5gjdQdCZHrrTzdBdwTVMK0ur4bBtHGtoQLmbHL+pZBz
         XANS12lTfjoTB+IR7PZQnWvWwL+1W590Y/BMhp0cK4y6SXUM6w6lqyPBemGVjkRf9Iw0
         pDAMkZJIPiCCiU9kPoSzKPFc64SMW86CKrlue1IJ2ea4iSwSpHumYTjhqJt7drxi0/FO
         h/nHGeGURQPuokI6OXNCskMKwHhVsT40Il3Hr8p6SsffgSWjbt8Fmgpy959eoj0DijYr
         1VFpsEbFJnpZw3xFRshPj8yD4L8h7jI/NtFx1vsIil4KvB86I8i3kCPbF8X9E3N3UGGg
         qiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716873164; x=1717477964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEzBOXaIzbfMi17IPevGDHsDdowwd5GTFXbnEzHCSrk=;
        b=QgMd0yWtU4bDUozjpV5oVpDSt1a6eq71+CiUCLwVMihbeWiMYtzEOg6JcLS/Zv5Czt
         XT1mxQFpJ84BEmZXXx1ubN+ZtxX+RpTE76fkmRQf7D2FwFn+D4TZnYktU1RBlwQGK4xi
         0SVxSLTKjq2nsYzHML6Wyf4MHj/F3/qjpqNLIJKXkToQymwhSpLbcjlYK9z4MJz7JYrR
         d5QxONhE1Tom4VbRR7EFlOx0Cq2NnVa3gUxyaj7R385E7T0bXroEuz57NeaNKSfLKM4O
         ke7VePxeTEqakaMDu+PNcNl1a/JnhAhYBqukgpGNvdm4f+tmx9da0nURQurpQrb+UeWt
         Ibvg==
X-Forwarded-Encrypted: i=1; AJvYcCXYlMf8teZFpeNE/NhJD9YNpeynr3gCGUDO7HEDjXl+CL8V73DIdhuPRuo79bWRAW4DgQY4xYo4hYM555MqULn2pYwi
X-Gm-Message-State: AOJu0YxhgL9hTUlgHKeR+KmIzjAr/IaBLg/SoJC1tocKQifnurfLYBxA
	H7gIvEEqfsfetPmF6+SBt/mS7LSHDRrR3oeLyfnOqhsNXR9kLapXVnui0C75Fv0fb/7dRh9nfUZ
	KUgcDnPVlT34k+HzimG/Y7AiXfgOxcScEAW9B3A==
X-Google-Smtp-Source: AGHT+IEgxGjpAfcQgJZPSZI09AOkDzjS2yiXb3qyIvWjw9VwAJvJ9LR53vE4/EKu6a8gJSxYcCVxmFt54915XaKYz7w=
X-Received: by 2002:a17:906:69a:b0:a5a:7ce8:f52c with SMTP id
 a640c23a62f3a-a62641b1fccmr653519166b.16.1716873163902; Mon, 27 May 2024
 22:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527153137.271933-1-alexghiti@rivosinc.com> <ZlSuIu1aFLzAiH_1@krava>
In-Reply-To: <ZlSuIu1aFLzAiH_1@krava>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 28 May 2024 07:12:31 +0200
Message-ID: <CAHVXubhSXjFKP_7qfw0GMvrrVinwvCKizAiC2Xeu5EP6U0JpKQ@mail.gmail.com>
Subject: Re: [PATCH -fixes] bpf: resolve_btfids: Fix integer overflow when
 calling elf_update()
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Mon, May 27, 2024 at 6:00=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, May 27, 2024 at 05:31:37PM +0200, Alexandre Ghiti wrote:
> > The following error was encoutered in [1]:
> >
> > FAILED elf_update(WRITE): no error
>
> hi,
> this fix got already in, check this patch:
>   https://patchwork.kernel.org/project/netdevbpf/patch/20240514070931.199=
694-1-friedrich.vock@gmx.de/

Damn, I missed this.

If possible, I think that adding the link to the bug report (or at
least the "FAILED elf_update(WRITE): no error" string) would make
sense, since it is not a "potential" overflow anymore.

Thanks,

Alex

>
> thanks,
> jirka
>
> >
> > elf_update() returns the total size of the file which here happens to b=
e
> > a ~2.5GB vmlinux file: this size overflows the integer used to hold the
> > return value of elf_update() and is then interpreted as being negative.
> >
> > So fix this by using the correct type expected by elf_update() which is
> > off_t.
> >
> > Fixes: fbbb68de80a4 ("bpf: Add resolve_btfids tool to resolve BTF IDs i=
n ELF object")
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218887 [1]
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  tools/bpf/resolve_btfids/main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids=
/main.c
> > index d9520cb826b3..af393c7dee1f 100644
> > --- a/tools/bpf/resolve_btfids/main.c
> > +++ b/tools/bpf/resolve_btfids/main.c
> > @@ -728,7 +728,7 @@ static int sets_patch(struct object *obj)
> >
> >  static int symbols_patch(struct object *obj)
> >  {
> > -     int err;
> > +     off_t err;
> >
> >       if (__symbols_patch(obj, &obj->structs)  ||
> >           __symbols_patch(obj, &obj->unions)   ||
> > --
> > 2.39.2
> >


Return-Path: <bpf+bounces-37959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1506B95D05E
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 16:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DE6CB2688C
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1E61E4B2;
	Fri, 23 Aug 2024 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGWYN3bp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E47186E3B
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424492; cv=none; b=oaqNOf8tvbXVPSMDm2nMu4FYPd9gGrJ7DNKSPtkUqTZwGPgk0BTohIbgGDAnWJYoJnSbC2em9fYuXL3Z/H6QuIHRi5m5/e6zOV3cz4Z/LIAEImI12KXTsz/ccsxKPpHEDNqXN0iiPCy6zen7DDChXDCu3u6DlBUw3hOnv6YUIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424492; c=relaxed/simple;
	bh=vtBLxHvDR4dcs9wsPoBaS5WuVY9PH1sBmhkwgghRcco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqBR9n3UkFlU5JT2ASpuXJeADgpc7O+uDTXQj0XtS7+XDzMkrJoRXto766TcxW71Zwqsjch2/YhYgKf9WJ0E80G2beXqxdBvHjtKwzWZK3SNR0JC98dbL5DCiErpj0H/8DMz48IeIv1dphcZI2JEVZsAVF/XyIZWvtyQNAap9yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGWYN3bp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42819654737so16125335e9.1
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724424489; x=1725029289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvRF761fuLrp6lLyJXk2SVDZ/NpY6Lgum2KEBRhAjAw=;
        b=XGWYN3bpKtPJPc+LxokmTIoZe9hm9q9afIvfcWu77Geswvr9XwU96NFP+MTDM793nz
         ux3Fm5zI240YnT8tesxCG6W2zhsHDNCzCoSY11gBsmQKRf/HquROwsW+28EebfGpMAnk
         NkhbFj8H1UWk3YpVkjBBWzPNFksUN3BVuzzIlypedhzNUgZ2W+Q0WiSRmItQZUueuFk/
         1cuh02QxTCT80t5qEu/kgllFtVKGtWvJmuLobTWDaxld31nVWyG9hUXwktfei4R0b4sP
         jmW58ZtH2HtC80lCO8nEI+Uq0jvaDB6/H//IUsHA5nWkdpUqC6+xaBnHk9OZsv0XTG7X
         6+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724424489; x=1725029289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvRF761fuLrp6lLyJXk2SVDZ/NpY6Lgum2KEBRhAjAw=;
        b=AclHy4wBZwYSJDKwRguF7wErPVTmdqfjRDe4FIHpEkzNEm2D1mN757HF3+G9cq3pwp
         lHFwGbUzKBIfmD61tHrsxTqPEoHodjuZ9liIJspyY7rdWN5mN2245uq8DK9T5ADcZ17q
         MCUwq2rlSmtYIgqzlstVhRP1apsQBc5r0daUXvLVGq+vbP53QvbKIIxeKVlbWhFvsp63
         q6Lvlo0Zv7WiobzOqckjjVlQJ6Fe7Ck5O72sh9CJi04wNOJCs6WRnIIznrzlAYjfAUto
         WIxR9qos8ZjdwXPPvfk46OGBOIo3YiK4Jgl18Ra50ANDEABwWrlpWrRtVgdpB1mmF8qP
         TXiA==
X-Forwarded-Encrypted: i=1; AJvYcCV0Z4Bc+lBVCznABppNPkz5u/uGralbq+8AfdXpzats7tFCKUyJfDCmQOngiS98IiygJP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeiaOU4QDI8oGKrGIAsNPUppz0cJoowUY77b4uRz7mk1WjTIvr
	JJ4ySmoB8VutlhUHVloJGlD9VYmsIleHKwCbfYqbaDFa7IwN3+kJbsQkBQC+3lPCy3SXYWa3DtJ
	A7yyM9bdLWnTb+fzqhpmGc4C8JB8=
X-Google-Smtp-Source: AGHT+IGccmHLR3XnH3OjMC7XncXwGlmXn0raWuNABUdXeSUvBRdQfSB9+WOkGRJWP8CmYnONA5PkYEe4GF9XnucWXCQ=
X-Received: by 2002:a5d:5091:0:b0:368:36e6:b23a with SMTP id
 ffacd0b85a97d-373118e3f02mr1610355f8f.55.1724424488801; Fri, 23 Aug 2024
 07:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806230319.869734-1-andrii@kernel.org> <ZrM5ZKXwjKiWjRk9@krava>
 <CAEf4BzZb_-Rw9miDyb8+ABT9siK7eUeigiKaLqch9DDz0EBSbQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZb_-Rw9miDyb8+ABT9siK7eUeigiKaLqch9DDz0EBSbQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Aug 2024 07:47:57 -0700
Message-ID: <CAADnVQ+mq48x3dELpAajq+uihfGvfGjV-3kHeSwpDarovAkTKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: make use of PROCMAP_QUERY ioctl
 if available
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 8:17=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Aug 7, 2024 at 2:07=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
> >
> > On Tue, Aug 06, 2024 at 04:03:19PM -0700, Andrii Nakryiko wrote:
> >
> > SNIP
> >
> > >  ssize_t get_uprobe_offset(const void *addr)
> > >  {
> > > -     size_t start, end, base;
> > > -     char buf[256];
> > > -     bool found =3D false;
> > > +     size_t start, base, end;
> > >       FILE *f;
> > > +     char buf[256];
> > > +     int err, flags;
> > >
> > >       f =3D fopen("/proc/self/maps", "r");
> > >       if (!f)
> > >               return -errno;
> > >
> > > -     while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf,=
 &base) =3D=3D 4) {
> > > -             if (buf[2] =3D=3D 'x' && (uintptr_t)addr >=3D start && =
(uintptr_t)addr < end) {
> > > -                     found =3D true;
> > > -                     break;
> > > +     /* requested executable VMA only */
> > > +     err =3D procmap_query(fileno(f), addr, PROCMAP_QUERY_VMA_EXECUT=
ABLE, &start, &base, &flags);
> > > +     if (err =3D=3D -EOPNOTSUPP) {
> > > +             bool found =3D false;
> > > +
> > > +             while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &e=
nd, buf, &base) =3D=3D 4) {
> > > +                     if (buf[2] =3D=3D 'x' && (uintptr_t)addr >=3D s=
tart && (uintptr_t)addr < end) {
> > > +                             found =3D true;
> > > +                             break;
> > > +                     }
> > > +             }
> > > +             if (!found) {
> > > +                     fclose(f);
> > > +                     return -ESRCH;
> > >               }
> > > +     } else if (err) {
> > > +             fclose(f);
> > > +             return err;
> >
> > I feel like I commented on this before, so feel free to ignore me,
> > but this seems similar to the code below, could be in one function
>
> Do you mean get_rel_offset()? That one is for data symbols (USDT
> semaphores), so it a) doesn't do arch-specific adjustments and b)
> doesn't filter by executable flag. So while the logic of parsing and
> finding VMA is similar, conditions and adjustments are different. It
> feels not worth combining them, tbh.
>
> >
> > anyway it's good for follow up
> >
> > there was another selftest in the original patchset adding benchmark
> > for the procfs query interface, is it coming in as well?
>
> I didn't plan to send it, given it's not really a test. But I can put
> it on Github somewhere, probably, if it's useful.

With and without this selftest applied I see:
./test_progs -t uprobe
#416     uprobe:OK
#417     uprobe_autoattach:OK
[   47.448908] ref_ctr_offset mismatch. inode: 0x16b5f921 offset:
0x2d4297 ref_ctr_offset(old): 0x45e8b56 ref_ctr_offset(new): 0x45e8b54
#418/1   uprobe_multi_test/skel_api:OK

Is this a known issue?

Applied anyway.


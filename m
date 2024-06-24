Return-Path: <bpf+bounces-32943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54919157BA
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 22:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69541C22528
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 20:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160211CFBC;
	Mon, 24 Jun 2024 20:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJQMu4t1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABAC19D88F
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260234; cv=none; b=VTjKBViwUX1RaQ7coxeq9DGtz7GGzLyUPQf5W6tS82MXcxY3e5H8YSKy/aFqAXVEogpSLyuB/gL6FnKk2fjZPOy4MhcxOtzQCBKzZk111jvK8Cev+xJ80YLOPxI3sE5QIjlr13bum8rUCEK+xLM04t8hxvEO6qS5V5oitaB/WPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260234; c=relaxed/simple;
	bh=MCRhOTnXCW0ajduq9NIYaaOOLkItm8Uo7fv01C/HkzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhGLGT5608UZ4w2+BiQvi0OoyDpmf5uRJ2e3Koi7y0vR9Sx9DZBycjOreu0a4jo0wlsNljeRD1MKidYE+zjAFdU6tARzeqGl8GNvhwTq0SJSnEQZfkeHmdNz6UnaU8esT6R+d2blQdPs6BS3WcE8m0ITuQGNObFuGx4ZP2ByZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJQMu4t1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4249196a361so10831295e9.0
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 13:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719260231; x=1719865031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fqv4/jX/EyiL7EFy60OMiBqi11jCSz3DVahorfrCnpM=;
        b=VJQMu4t1kceiafzHj4iYe1yH/tGKZy9VCu2d7pT6suE2AGnb6jE5pcABnUKwenwT/c
         Bj2TOumgPdi/be9zK6yTDxHmD03Msv6T9MlSSENMNtixqKYlTYYlNKQn6uAk3XlLqFYu
         FsFBPNyTxKcpxyinCmtch2U9cGh29AkHL5ge4BoUgWbtgErpZfLdBOC3lHUfjmueQfm/
         Qw7Aym/sj82fQ4e/9/cyTIQNLOeIet1KLBxRt91XKLQq4PJN8ogxQCi42owU8/UgTngz
         iaGogQFkJuYGKyLm1iZXWr4R7Cg9r0W7CQtPiO/mnWlvk33EtZ/KPuWHAQN9/6r/YeAt
         md+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719260231; x=1719865031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fqv4/jX/EyiL7EFy60OMiBqi11jCSz3DVahorfrCnpM=;
        b=NMKm+8BLHmiEfjbxp9aE5gKWaNl7SDTgaYcn/RpHVt2DvRTL4/nbjr599D48LS9M/H
         LlJ4GDPfGsujbnkwI8nbyvxNQhx7p9YwAAPyrr0qZULTRIEYn4uYBz4zMcwt3wh273c3
         HEykkkF+87Sai/Wo12iakY1omtjFtlyjuzjtogMgmvyXojk2oE1QEAH4djTxFuslXvxT
         NxPTGo1DK/LDWekIuzqZbPEdaFz9FlcAqVizPcUdUhLn0jf+HsGHZx+T0eBs5TtfSqNs
         dB6zZNQkiAPzif+PxqgvRTfgC0Uxd1SPP7ooc+yi9ju2u05O+Y4PX/7J19F8CVlW5KLH
         fGpA==
X-Gm-Message-State: AOJu0YyMBLUuq/eJRwyCj0Y1/+YzEEyS7TRUufWV299DiwnSPcEPBvEd
	65/VgVthJ96hxn5R+RTHSIzCsctYVX2pO65aU2j393xG/2tO+a/N+Y0tWUEMBawBa1y0Ph7YIp1
	6PDeBZA0p3qyQvxK6kDep2QtSkJc=
X-Google-Smtp-Source: AGHT+IGHL3h2Ds4HcPo1DuwelHrHFEwq6dMLvz8fd/52Ly3MjpxwjQeb1zM8D4qSHX98aM7dy36Keajh30Uk6TYtui0=
X-Received: by 2002:a05:6000:1885:b0:360:7a3f:7a3a with SMTP id
 ffacd0b85a97d-366e96b23e2mr4959402f8f.44.1719260231162; Mon, 24 Jun 2024
 13:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623070324.12634-1-shung-hsi.yu@suse.com> <20240623070324.12634-2-shung-hsi.yu@suse.com>
 <CAADnVQJar6vM-3U_e49yxz=keZs7=xn7O+k_EOAWjnA7kH1VLg@mail.gmail.com> <o7b3dfsmkmlh57geyzahgcysaosqxcrsqcmhycqc7vtcgxfgie@mvlcwnwtzael>
In-Reply-To: <o7b3dfsmkmlh57geyzahgcysaosqxcrsqcmhycqc7vtcgxfgie@mvlcwnwtzael>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Jun 2024 13:17:00 -0700
Message-ID: <CAADnVQ+mjK7Zi8XCcMYRVLoHOeV_Lj89J6eOCZGOXBvkOZz8HQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: verifier: use check_add_overflow() to
 check for addition overflows
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 8:26=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Sun, Jun 23, 2024 at 08:38:44PM GMT, Alexei Starovoitov wrote:
> > On Sun, Jun 23, 2024 at 12:03=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@sus=
e.com> wrote:
> > > signed_add*_overflows() was added back when there was no overflow-che=
ck
> > > helper. With the introduction of such helpers in commit f0907827a8a91
> > > ("compiler.h: enable builtin overflow checkers and add fallback code"=
), we
> > > can drop signed_add*_overflows() in kernel/bpf/verifier.c and use the
> > > generic check_add_overflow() instead.
> > >
> > > This will make future refactoring easier, and possibly taking advanta=
ge of
> > > compiler-emitted hardware instructions that efficiently implement the=
se
> > > checks.
> > >
> > > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > > ---
> > > shung-hsi.yu: maybe there's a better name instead of {min,max}_cur, b=
ut
> > > I coudln't come up with one.
> >
> > Just smin/smax without _cur suffix ?
>
> Going with Jiri's suggestion under patch 2 to drop the new variables inst=
ead.
>
> > What is the asm before/after ?
>
> Tested with only this patch applied and compiled with GCC 13.3.0 for
> x86_64. x86 reading is difficult for me, but I think the relevant change
> for signed addition are:
>
> Before:
>
>         s64 smin_val =3D src_reg->smin_value;
>      675:       4c 8b 46 28             mov    0x28(%rsi),%r8
> {
>      679:       48 89 f8                mov    %rdi,%rax
>         s64 smax_val =3D src_reg->smax_value;
>         u64 umin_val =3D src_reg->umin_value;
>         u64 umax_val =3D src_reg->umax_value;
>
>         if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
>      67c:       48 8b 7f 28             mov    0x28(%rdi),%rdi
>         u64 umin_val =3D src_reg->umin_value;
>      680:       48 8b 56 38             mov    0x38(%rsi),%rdx
>         u64 umax_val =3D src_reg->umax_value;
>      684:       48 8b 4e 40             mov    0x40(%rsi),%rcx
>         s64 res =3D (s64)((u64)a + (u64)b);
>      688:       4d 8d 0c 38             lea    (%r8,%rdi,1),%r9
>         return res < a;
>      68c:       4c 39 cf                cmp    %r9,%rdi
>      68f:       41 0f 9f c2             setg   %r10b
>         if (b < 0)
>      693:       4d 85 c0                test   %r8,%r8
>      696:       0f 88 8f 00 00 00       js     72b <scalar_min_max_add+0x=
bb>
>             signed_add_overflows(dst_reg->smax_value, smax_val)) {
>                 dst_reg->smin_value =3D S64_MIN;
>                 dst_reg->smax_value =3D S64_MAX;
>      69c:       48 bf ff ff ff ff ff    movabs $0x7fffffffffffffff,%rdi
>      6a3:       ff ff 7f
>         s64 smax_val =3D src_reg->smax_value;
>      6a6:       4c 8b 46 30             mov    0x30(%rsi),%r8
>                 dst_reg->smin_value =3D S64_MIN;
>      6aa:       48 be 00 00 00 00 00    movabs $0x8000000000000000,%rsi
>      6b1:       00 00 80
>         if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
>      6b4:       45 84 d2                test   %r10b,%r10b
>      6b7:       75 12                   jne    6cb <scalar_min_max_add+0x=
5b>
>             signed_add_overflows(dst_reg->smax_value, smax_val)) {
>      6b9:       4c 8b 50 30             mov    0x30(%rax),%r10
>         s64 res =3D (s64)((u64)a + (u64)b);
>      6bd:       4f 8d 1c 02             lea    (%r10,%r8,1),%r11
>         if (b < 0)
>      6c1:       4d 85 c0                test   %r8,%r8
>      6c4:       78 58                   js     71e <scalar_min_max_add+0x=
ae>
>         if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
>      6c6:       4d 39 da                cmp    %r11,%r10
>      6c9:       7e 58                   jle    723 <scalar_min_max_add+0x=
b3>
>      6cb:       48 89 70 28             mov    %rsi,0x28(%rax)
>      ...
>         if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
>      71e:       4d 39 da                cmp    %r11,%r10
>      721:       7c a8                   jl     6cb <scalar_min_max_add+0x=
5b>
>                 dst_reg->smin_value +=3D smin_val;
>      723:       4c 89 ce                mov    %r9,%rsi
>                 dst_reg->smax_value +=3D smax_val;
>      726:       4c 89 df                mov    %r11,%rdi
>      729:       eb a0                   jmp    6cb <scalar_min_max_add+0x=
5b>
>                 return res > a;
>      72b:       4c 39 cf                cmp    %r9,%rdi
>      72e:       41 0f 9c c2             setl   %r10b
>      732:       e9 65 ff ff ff          jmp    69c <scalar_min_max_add+0x=
2c>
>      737:       66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
>      73e:       00 00
>      740:       90                      nop
>
> After:
>
>         if (check_add_overflow(dst_reg->smin_value, smin_val, &smin) ||
>    142d3:       4c 89 de                mov    %r11,%rsi
>    142d6:       49 03 74 24 28          add    0x28(%r12),%rsi
>    142db:       41 89 54 24 54          mov    %edx,0x54(%r12)
>                 dst_reg->smax_value =3D S64_MAX;
>    142e0:       48 ba ff ff ff ff ff    movabs $0x7fffffffffffffff,%rdx
>    142e7:       ff ff 7f
>    142ea:       41 89 44 24 50          mov    %eax,0x50(%r12)
>                 dst_reg->smin_value =3D S64_MIN;
>    142ef:       48 b8 00 00 00 00 00    movabs $0x8000000000000000,%rax
>    142f6:       00 00 80
>         if (check_add_overflow(dst_reg->smin_value, smin_val, &smin) ||
>    142f9:       70 27                   jo     14322 <adjust_reg_min_max_=
vals+0xde2>
>             check_add_overflow(dst_reg->smax_value, smax_val, &smax)) {
>    142fb:       49 03 4c 24 30          add    0x30(%r12),%rcx
>    14300:       0f 90 c0                seto   %al
>    14303:       48 89 ca                mov    %rcx,%rdx
>    14306:       0f b6 c0                movzbl %al,%eax
>                 dst_reg->smax_value =3D S64_MAX;
>    14309:       48 85 c0                test   %rax,%rax
>    1430c:       48 b8 ff ff ff ff ff    movabs $0x7fffffffffffffff,%rax
>    14313:       ff ff 7f
>    14316:       48 0f 45 d0             cmovne %rax,%rdx
>    1431a:       48 8d 40 01             lea    0x1(%rax),%rax
>    1431e:       48 0f 44 c6             cmove  %rsi,%rax
>
> Also uploaded complete disassembly for before[1] and after[2].
>
> On a brief look it seems before this change it does lea, cmp, setg with
> a bit more branching, and after this change it uses add, seto,
> cmove/cmovene. Will look a bit more into this.

New code is better indeed.
That alone is worth doing this change.
Pls include before/after asm in the commit log.


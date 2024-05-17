Return-Path: <bpf+bounces-29980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C17C8C8E83
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 01:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A70B21356
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 23:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E433A1411F8;
	Fri, 17 May 2024 23:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj/nsTyx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C383B43ACA;
	Fri, 17 May 2024 23:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715988798; cv=none; b=XzEKZIvIFsh+l8DqJYSYTG4/mKfyg+QOCpiOuDw+n6RUDinWwKRVGa7xq+mvDkW/DbT9cmCwWtqLZjXafmbh0rG7O9Nn7zl0RTLTZLvP99RAOR0mFpM9JjbafPxrPlboPk6dpsnY6l0RnH8pMUrPI5sKcQM7MyE22dUsWnshOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715988798; c=relaxed/simple;
	bh=6E7a1R54O4oY/Bv3V3I/b/LpPkVXPb2htFKqeLsOJQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2ABcNS0gSwfDlcQJPb8uKRkMYe+hZqbpM8L3+uW3bW8FSbsF/jSO8kU+lf1X8nGxpDTme7sbzRWlujCpbMsREtErcT2RVwpj4MIm8Ou+XC1opKB3xzPOdvOg7y366UeYvBUTfOoaAmSghSCRx6yC7DTsqJlmK2BmK9jfjVMas0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tj/nsTyx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34e0d47bd98so381704f8f.0;
        Fri, 17 May 2024 16:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715988795; x=1716593595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qy5GA9CL6efAYNR6rsn4txm+1VlWlDb+jy2cujQvFME=;
        b=Tj/nsTyxveSoWWPWDLqCKv2+DS2BfXuA2vE4wqi5f8ZS5Bv5MlxV+DMg7Sz5hf6oER
         BUrr1+pdeAlVzfBE8wEwkJ0qJpEeNr6ITZFseLyvtVDSZ+g2lFaDv9CgLlygiZYwcD0s
         1lMU9tlILG9ZYIbaslew0trKJBwn9KnU3Ek96Y4tmeXNoOFZJuQdtg3WvI0XPpBruqA6
         vyraMQTltcRnEpyPD6YmQjoIOpNTvsX6XFXCG8EPsTybo9ovwLlgX0b2h+jIHWz2ozEf
         2t55rRjJ/Q/QpE3Aaz7cdnPgdEPFhaYPpkhhDo/FFAFJrQiFKkWGeoMvtx4i6h5VIvjm
         qWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715988795; x=1716593595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qy5GA9CL6efAYNR6rsn4txm+1VlWlDb+jy2cujQvFME=;
        b=rg7yButq8vrgGRwrF6dJVslORXE0jE3p76RNsE0UI4F/6s+GTLK9910U8FpU781q4K
         68Atdni+VQfy+3JUI/cAv93SWSq4EZp04t4LaFWWRan06jxdS8i6SE93TaO7t/SCosb+
         /hS1odgaM0o49duLH9zxKxn6VSxTXSOaWhFjpsrrY6MYeV2l3VxvrH2bQkxnMYxMZM1z
         s/RCe1m8iQ6BfEEsiEj823Kjgoz0I2XIx3VCj5rzSHRO84Sq3ahNfxY1fyMpF+OFnHv3
         iz0PQgE3FzBRKwXxCmIJahVgvnGOWXP+RglDLYzUIXR7br22jvoW9bbljdPNCvSpPUwZ
         xisQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkYutZ//M0P7saTdeepUkjNSyeu02aGiP2/c0Eb/+1f8hhctZId/Z3ci8hu/NHt8GC6y+F539YRaGWY4d1h5naJgSRFj62tDwrFLnL
X-Gm-Message-State: AOJu0Yw3ER10ySlrIOlq8LHWRStmnE8xI0YZxPwkbbbUJz71Z7sW7d1y
	IAnAL6oo57SGZjTQ3dcCAYRXO0KsEvAqEvC20hqllcDvPyvMtGxV16pUP1f7i2a4CgveovlXLY1
	tJGuxAH78cPcjor6MkJpNFp/1R3A=
X-Google-Smtp-Source: AGHT+IFkvtdpZQ7uzEvzJEF1GhJfoeLNWA35B9P6yCrzkpFHgHgdYb8Apw1NgA9K6XxflUZUV0/k/R3PENWBVmlX+kE=
X-Received: by 2002:a05:6000:e50:b0:34a:6fac:6dab with SMTP id
 ffacd0b85a97d-354b8dfddc1mr333994f8f.12.1715988794866; Fri, 17 May 2024
 16:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWYdi0ymezpYsQsPv7qzpx2fWuTkoD1-wG1eT-9x-TSREFrQg@mail.gmail.com>
In-Reply-To: <CABWYdi0ymezpYsQsPv7qzpx2fWuTkoD1-wG1eT-9x-TSREFrQg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 May 2024 16:33:03 -0700
Message-ID: <CAADnVQ+YXf=1iO3C7pBvV1vhfWDyko2pJzKDXv7i6fkzsBM0ig@mail.gmail.com>
Subject: Re: bpftool does not print full names with LLVM 17 and newer
To: Ivan Babrou <ivan@cloudflare.com>
Cc: bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 2:51=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
>
> Hello,
>
> We recently bumped LLVM used for bpftool compilation from 15 to 18 and
> our alerting system notified us about some unknown bpf programs. It
> turns out, the names were truncated to 15 chars, whereas before they
> were longer.
>
> After some investigation, I was able to see that the following code:
>
>     diff --git a/src/common.c b/src/common.c
>     index 958e92a..ac38506 100644
>     --- a/src/common.c
>     +++ b/src/common.c
>     @@ -435,7 +435,9 @@ void get_prog_full_name(const struct
> bpf_prog_info *prog_info, int prog_fd,
>         if (!prog_btf)
>             goto copy_name;
>
>     +    printf("[0] finfo.type_id =3D %x\n", finfo.type_id);
>         func_type =3D btf__type_by_id(prog_btf, finfo.type_id);
>     +    printf("[1] finfo.type_id =3D %x\n", finfo.type_id);
>         if (!func_type || !btf_is_func(func_type))
>             goto copy_name;
>
> When ran under gdb, shows:
>
>     (gdb) b common.c:439
>     Breakpoint 1 at 0x16859: file common.c, line 439.
>
>     (gdb) r
>     3403: tracing  [0] finfo.type_id =3D 0
>
>     Breakpoint 1, get_prog_full_name (prog_info=3D0x7fffffffe160,
> prog_fd=3D3, name_buff=3D0x7fffffffe030 "", buff_len=3D128) at common.c:4=
39
>     439        func_type =3D btf__type_by_id(prog_btf, finfo.type_id);
>     (gdb) print finfo
>     $1 =3D {insn_off =3D 0, type_id =3D 1547}
>
>
> Notice that finfo.type_id is printed as zero, but in gdb it is in fact 15=
47.
>
> Disassembly difference looks like this:
>
>     -    8b 75 cc                 mov    -0x34(%rbp),%esi
>     -    e8 47 8d 02 00           call   3f5b0 <btf__type_by_id>
>     +    31 f6                    xor    %esi,%esi
>     +    e8 a9 8c 02 00           call   3f510 <btf__type_by_id>
>
> This can be avoided if one removes "const" during finfo initialization:
>
>     const struct bpf_func_info finfo =3D {};
>
> This seems like a pretty annoying miscompilation, and hopefully
> there's a way to make clang complain about this loudly, but that's
> outside of my expertise. There might be other places like this that we
> just haven't noticed yet.
>
> I can send a patch to fix this particular issue, but I'm hoping for a
> more comprehensive approach from people who know better.

Wow. Great catch. Please send a patch to fix bpftool and,
I agree, llvm should be warning about such footgun,
but the way ptr_to_u64() is written is probably silencing it.
We probably should drop 'const' from it:
static inline __u64 ptr_to_u64(const void *ptr)

and maybe add a flavor of ptr_to_u64 with extra check
that the arg doesn't have a const modifier.
__builtin_types_compatible_p(typeof(ptr), void *)
should do the trick.


Return-Path: <bpf+bounces-37975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3F295D58B
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 20:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB531C21705
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 18:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B83B191F81;
	Fri, 23 Aug 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Arxa3oiZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71112190686
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439136; cv=none; b=KMQeKsuaWjNJxo4uc2HrJWIkcUltB2mOdze4MEG/OGYgt6AR1vpt5/IcBxtNW4IutqoROxvYH10IoLzJOYum7iFLv2bCM9y2OcobRwrbUnUBiIjJNaa792sTOZmzw6ShJN/7TyV0rXxadbt8ZVDuCEwKrz9cGN8WqMc2Al4pH4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439136; c=relaxed/simple;
	bh=9DGTo/QY0k1GKylhM/2lMinAqh7VuclVGIH2Ul2M+Tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzunD0LyFP9M2LP7XrGMUawJjJPtgsZMwy9DPxNhfhUl31VgA0A7ND4BiVjDIIacA6ERYj9LaL3rgtzpi5vMft8clFsZxW7cBJS9HIdPdn9pGE9YoCnAuzxSdsl+zu9J6zH5K0uMD/O0DPEi14XfO2Q72WFUGDHjTu6FPL4Z/YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Arxa3oiZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428243f928fso24159075e9.0
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 11:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724439133; x=1725043933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lvd4b2qk9dOh0xTGba9GeynfR2I1NLzJcgeJD08qPmo=;
        b=Arxa3oiZGv7fvX58e3ns4QOVSjuFzUKXlEk0HTU0JwQsC+iz6NxvbhpZWGog0klul4
         rD5ytVRfW8Nu/+s1PDoRt65Y9Ply8npj75CNu8cBUItqZECI9UQjmdc+35BESZiMvOD5
         HKIajWV5MEtH7rrv75Bx1LcHJB9iXC5+05VYyd+fkgGUWBLcyNcC2NNCZaB7Baf7wpYR
         +np88q4/fEsuvARKncN9QqAHiXurdvVseADFeWhgAzWkS0xmUufErtQPTr9XjpmDo8PA
         3GtADHqBMljvhNcRRbW1vHuKUF7GyYgqX796nLd7IQ4eQVg4MHLNaAaLYec3ZkxloTkf
         mY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724439133; x=1725043933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lvd4b2qk9dOh0xTGba9GeynfR2I1NLzJcgeJD08qPmo=;
        b=NT8dRT1sW8NwYhKUZe6BjeqzHuQTGZAexoXi8FJrMNdvwkzBTOJuPkYtGJNhP/rAgj
         KygGxk5/mEwCcZCdv494oK5CxGO4uFRvmFpdLnv1qkF0U57xmSo9tEn8heO6RgwoOGb7
         SiTEApEHpwreiqyAM6kw3dsExTLYaaW2Hjr/PZo6lMSTXycX0U5l1nPOlCOIs1fDjEek
         oxgm2wOys9XotrxgtQUzI3ZJaQ27RfSgDpvuHwcoow8yGVmWPIB29ZwRh6vD58IdwOo9
         hZGfPPfKT6XHe/SK00IjOYpu464AfeXgabVcA1x3FfEb/23iNWtYq63NkpkDAzqC4zSp
         CE/A==
X-Gm-Message-State: AOJu0YxBEm4H131/LviOU6OMpLlbtF1YScIQUB4uqNNR8imyTqYETLeg
	YWtUrZHYxnnGuqHKjy4YHyicX3p2EANMvszacRGiIMA2YbAd3g39/ku1/o7Z8rsqvj9/kISmxHi
	nlmT0YQLoWd12Zgx+ZImgCYmXdDo=
X-Google-Smtp-Source: AGHT+IFh48rmZfMpIi9XpwrzlxmBZ7rvkN1Fk/xwcYGbA6jx2t6X6WGXZ07z+QTA1g2yKt0ffQQ285s0cG8N2HjwY34=
X-Received: by 2002:a05:600c:816:b0:42b:892a:3296 with SMTP id
 5b1f17b1804b1-42b892a33d0mr16363875e9.37.1724439132473; Fri, 23 Aug 2024
 11:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823184823.3236004-1-linux@jordanrome.com> <20240823184823.3236004-2-linux@jordanrome.com>
In-Reply-To: <20240823184823.3236004-2-linux@jordanrome.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Aug 2024 11:52:01 -0700
Message-ID: <CAADnVQLkbkz07OpGkg0v0CYCw6MtOWoSLQT5qtYg82C-3BpN9w@mail.gmail.com>
Subject: Re: [bpf-next v9 2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 11:49=E2=80=AFAM Jordan Rome <linux@jordanrome.com>=
 wrote:
>
> +u32 dynamic_sz =3D 1;

..

> +
> +       // Make sure this passes the verifier
> +       ret =3D bpf_copy_from_user_str(data_long, dynamic_sz &=3D sizeof(=
data_long), user_ptr, 0);

Did you really mean to &=3D into the global variable while passing it as
an argument?

And the compiler didn't warn?


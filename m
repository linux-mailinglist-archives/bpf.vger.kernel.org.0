Return-Path: <bpf+bounces-45659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FDF9D9EFE
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 22:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644751654EF
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 21:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041EE1DF99E;
	Tue, 26 Nov 2024 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WumWpcGv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832C160884;
	Tue, 26 Nov 2024 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657921; cv=none; b=DfA4EjCfBCKFSgha+PyynUnIMuc6fXVhgXjPrBKlZAME8en+nInyRnSumo4GEXRuf2k6l4661TL8EFmtawP8sK2Z+rfgaEH+iPT8SjXZ+n1C/tm06GJE0XDsC5NEukfvYwjbvaqzaeQ2JK2Q2T4nlKde7LBkBixc2mte/30tE/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657921; c=relaxed/simple;
	bh=K2I+KLfVcJ/vg5KBDzBzCybrQaZV/okWFnSnK2PkFNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEi0I/BIYuFukyERM7Wwxsu1eKhxFDI7LJQcgzs4vAZEfBXL66DzB6eaaEMVSHbcE7NqevVJVMCxxfJzRwr75T0j1lV3G3nZvBpmKfBoi4kZ9AI5humEwYzmDFFvxF0wATFFbsivWxbGcrSKU9TGEMs2UQwL27rKlNQ+I/EOONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WumWpcGv; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea49a1b4c8so4793508a91.2;
        Tue, 26 Nov 2024 13:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732657919; x=1733262719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxjQl4++Xf2qMJwttqI8PkTkdAJoS8d4aSjLdU8VKZA=;
        b=WumWpcGvdMq5pCfaMGvvLgRP1poK8gO37kVaAGYj/NKeeDFosoiHGOBRIdKSN0J8jo
         3vkiTI90AThwi/bSJKbkMmJ/AeFQ8uAHnnZHqfbg1yTxVKzvAvE/H7f0OUhWqvXMQgEv
         jxyywSPlImUDUVNDOGX4myZIQv7tJGOK3F0WnAKPtcrBNHZ1xS3lCN2AbAsxA2YI7UBV
         Mf8qArlATxhLTYUGmcT6T4a7E/PAAGJnkKihXgFa1jKF3GQ1o7bHLA6GrtHvmOPQt6DF
         b3CzbDMF/6zFwvHgW87cth4qZRDCA0KMwpBHQRktbzS0U9KRN6NTZ1tsNIxERpPOGGwv
         jQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732657919; x=1733262719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxjQl4++Xf2qMJwttqI8PkTkdAJoS8d4aSjLdU8VKZA=;
        b=VYmkfJhMoXJP6ryJDTtoFz3Oj540XV21YI1D5oZg7x4oDQ6B9XNIduTVQWYaYnSX0/
         1GC7kvCBgYJZAolNHuxkrD17zRoB0kbGkpabtwsfdfBCsE5wCzbJWnmD4f/41W7yQd+m
         BZGrEcVbjC3/Sevpkj3oEwoBAiRuqvTyBj3sBSDS6bPNTMp/YJrB8YmzICZhCljtzpxX
         m3xnP65a8hzH7TRrdtdhSHc1L/qNDikhuLkTJYpuwD/OyoVTG84gZX0ixwDv0aCSIBkp
         xdGB4CP65lG4zVHp5p20onk/VUn0pzCAX6FHCG8rSdniz+GXi6CmhmCq8kE7pVwM3Asw
         L7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCX69dzR3o1ZMZBcVkKq+k5fPLMURD4kNQhxI5gW+j9GVC55HiGxngJUXibF2JZJUThCAao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwhWTOAwqtlayhy8vSUMPuv+wyP7ShWIZ15jelKZ0NXxIoOR4W
	F88C3AV4V88BR1vYELNhcZEsYcNoWu9e0Wlc9LsagOE0C+QnRVRWsNkEVPHgxiQqOpqaGsux9aJ
	6QbBIZaZx99FfTOxlIFgR92feVSo=
X-Gm-Gg: ASbGncuSNsbTazkxNWoS1WgcnyBzQZU/iTptTtovqGVMzdin9twf8gcn/8tb5ZOz6W5
	+v07pF+P+igGAnLFuCy+Dm+vZkeQNydGgKrWXlB4TQAsBVsM=
X-Google-Smtp-Source: AGHT+IEOTCkV3UECEigWtYDOkIXyJ1dy3Pw/vylD41IiufSAmfrBxwhp2URd/85yR5x4n1utvZ9vMv7DGNV4eY01aZE=
X-Received: by 2002:a17:90b:3ec2:b0:2ea:7cd5:4adf with SMTP id
 98e67ed59e1d1-2ee097e2105mr942379a91.31.1732657919397; Tue, 26 Nov 2024
 13:51:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122070218.3832680-1-eddyz87@gmail.com> <CAEf4BzakAiPWF9x2h-F737LbJ9ovXCJLbXV9R5vKg0Et5CbqSQ@mail.gmail.com>
 <69af35e3718748b99e4d295bead4072588a50296.camel@gmail.com>
In-Reply-To: <69af35e3718748b99e4d295bead4072588a50296.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Nov 2024 13:51:47 -0800
Message-ID: <CAEf4Bzb-PMAs7+B85qanUinQrk4aVs4Qk6orbyDP11uBcW-mWA@mail.gmail.com>
Subject: Re: [PATCH dwarves v1] btf_encoder: handle .BTF_ids section
 endianness when cross-compiling
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org, 
	kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yonghong.song@linux.dev, Alan Maguire <alan.maguire@oracle.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Vadim Fedorenko <vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 11:31=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2024-11-26 at 11:26 -0800, Andrii Nakryiko wrote:
> > On Thu, Nov 21, 2024 at 11:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > btf_encoder__tag_kfuncs() reads .BTF_ids section to identify a set of
> > > kfuncs present in the ELF being processed. This section consists of
> > > records of the following shape:
> > >
> > >   struct btf_id_and_flag {
> > >       uint32_t id;
> > >       uint32_t flags;
> > >   };
> > >
> >
> > Can we just set data->d_type to ELF_T_WORD and let libelf handle the by=
te swap?
>
> When I tried 'data->d_type =3D ELF_T_WORD' + gelf_xlatetom() snippet
> suggested by Tony Ambardar some time ago, I got a write protection error.
> Concluded that this is so, because file is opened in O_RDONLY mode.

Ok, maybe don't follow my words *exactly*, just in spirit ;) I see
there is elf_getdata_rawchunk() API in libelf, which seems useful:

/* Get data translated from a chunk of the file contents as section data
   would be for TYPE.  The resulting Elf_Data pointer is valid until
   elf_end (ELF) is called.  */
extern Elf_Data *elf_getdata_rawchunk (Elf *__elf,
                                       int64_t __offset, size_t __size,
                                       Elf_Type __type);

I don't know the surrounding code, I was just hoping to leverage
libelf's byte swapping support (which I think I learned from Tony as
well). But if it's too inconvenient, so be it.

>
> (Also please note v2 of this patch).
>
> [...]
>


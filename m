Return-Path: <bpf+bounces-71256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78095BEBC8F
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 23:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861DB5E8526
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 21:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663D229AB1A;
	Fri, 17 Oct 2025 21:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9kgEuHE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADEE23A98E
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760735502; cv=none; b=aUvtwzD4F6GMEQEYxanIcAXu/+q0ekHL5QwQNJn/wHkEAFIqDWS4UqD878W/du6QsDy6B9JYVRc566T89prMUKha8NTDFGltDrsXCBrrpGilLPczZBKHpdS9cFWVlksolQpMpfZ0K8P7mgxqF2U3qrIxoSzhiOyu+ohN01o/9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760735502; c=relaxed/simple;
	bh=kYxZqYBUbOkzVSBehpV0DsX3L/e7GWEL9Bw1314UAtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4p3RKyg3oefM8GmbHoKtsL2To3igb/13qN8rtJLLcOjneGfCaD6z8tuLr33QrkMvCcKMt6Bivc5MOA+ihnVBYmFfoAn/G8LWOzX/xxQ407Wes1Sq6vJp/JTjk4BMduNscqmF2MIOfFrcFCVIaxz0NDVDHLoesBNANivD/K9/g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9kgEuHE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so17569135e9.2
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 14:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760735500; x=1761340300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiHl8WzAVL2qKpnePXsl7zcrN/bL2fL7C8nA+V5ZPsc=;
        b=E9kgEuHE1jhdbl6kTBrE+cL+Siiw07h9a1oLmsnrgMp8AaF2dOYl5HGKOl7LlX2K+A
         jx2eAEb97lFjgfV0bM6hq/MNdVAhZ7XdLeDkKUKOGtsfXRH7TvI1Tm1QiaDJgLhMDdyO
         3bQ4JdvqakhcJZpq4apvNNFvJtsyt8S8ftyFfb5j8ibNVDeArbKeWKad2xJrph2dBwgE
         mC2Hsh0k79XsfKGgx7jQbgCyxTPCPf68g2Jh/7ocAMj99gvwEnjEuG6YfYlF/DkeYdFt
         aUlVkYaTyMTpz17auhk7pNAc213bQwbTfrWd74jysxeW+D0ja68TDC8RGLcEzyq0nawh
         oL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760735500; x=1761340300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiHl8WzAVL2qKpnePXsl7zcrN/bL2fL7C8nA+V5ZPsc=;
        b=DY2PpPjm4gLuS8D9hCWxI+a7JAWg/1K43sl51KuaZltDtL96v1gpmUs1eK8S56fRK7
         pTWywJansffj1xlzVTWURopqKUmKMz8jgCXV2tCQm5aXy2IDnpD2LZA9VCrhoSOLf0po
         h+xd7M70LqPEV17AJTv/kv9JvKYoKhpt0CRZwbDfrCYDxbY10AdruH9azawgFyZIXKdK
         hY9BvAsPZsVzcxDpVUQWKQ9Wgkr2QHpsXtyXwiFMjFfQaTf21742b0phS/DWyvRnTbzd
         vw3tWYp0of1brEhTJJ90R6xKoqzy0iBoxj7jyy32fHi7OyPedlUU9GVwvKCNy5fTyxbm
         YsxA==
X-Forwarded-Encrypted: i=1; AJvYcCXtrdl51poz9Ru/SVNgUATgoGD42wo4o2BoyhJGallU0r6QAyyqizw8jNZOX2HpnXhkC5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKZj4AtZ7yckXGJxAs/xwaqpoprj+++qkupqL7fpQsZBUY+Zvq
	yOMXtnD+9UEmTBWnG3JAESGhaicyoedSbxf/jteSjhdVJRPNswUPB8ivXijKlgEvWnr2rOMPLFa
	pVQWWGNJ8NCCyKAB4I+v0UpExLy44HO8=
X-Gm-Gg: ASbGnctV6AnSfa0DLIj/lBrx+fMlSGEvlgpZFsyzYjGtjicQB/IleQiRwpG6oBKBHeI
	0GBGF1SxdNhPvg7g9/GHZqWpoH8YeNqXsUIeSL3qC9Eryvk8iwS8BKeKCUvJAzsMqWURliwX8Si
	hqxGYdak1MURbdqvZ6LC3eqGr/ehn45zk9IOMkMs0Ur9LT5xnhE+wsky/Eyp6tt6L3uZS/JVxEu
	PvWvZjftvHWLUrlwXbHWT+HqUkbbD5B+KK/2w9RjXhlm9ZWZ1+uutIP1aMz4QFdz6/M9LlnD4rG
	9a3od82/gR6bHXH5vNB3x0gIaTvi
X-Google-Smtp-Source: AGHT+IE/P0Bj5yNA+QZE8SFcpK8hODv2phJy6bPwGq1nnWwOCRFBMSfu7tsBJfL7WV3Tbc783Y0htYPzVeiBFA8jNF8=
X-Received: by 2002:a05:600c:3544:b0:471:c72:c80b with SMTP id
 5b1f17b1804b1-471178ad7b3mr39047125e9.18.1760735499583; Fri, 17 Oct 2025
 14:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141727.51355-1-puranjay@kernel.org> <CAADnVQLp2w-C+mV+x=A_hxhoNHUk0k5n0gGGFULT_9WiVoABtA@mail.gmail.com>
 <CANk7y0hs9FORh1ONS38+8s5S3fN4gMyv4Nc9PkKPapwjQkZpxg@mail.gmail.com>
In-Reply-To: <CANk7y0hs9FORh1ONS38+8s5S3fN4gMyv4Nc9PkKPapwjQkZpxg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Oct 2025 14:11:28 -0700
X-Gm-Features: AS18NWAmJcVI-LiTqJvNndGcaxbzeXHNPxIEI-KLAdcUAngMdd4uHzBydAtnGvg
Message-ID: <CAADnVQJU3A6jHOLfJ78J5_+aHN_8rO9YOhty3cV4DM9v39TOUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix list_del() in arena list
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 12:18=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
>
> On Fri, Oct 17, 2025 at 8:41=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Oct 17, 2025 at 7:17=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> > >
> > > The __list_del fuction doesn't set the previous node's next pointer t=
o
> > > the next node of the node to be deleted. It just updates the local va=
riable
> > > and not the actual pointer in the previous node.
> > >
> > > The test was passing up till now because the bpf code is doing bpf_fr=
ee()
> > > after list_del and therfore reading head->first from the userspace wi=
ll
> > > read all zeroes. But after arena_list_del() is finished, head->first =
should
> > > point to NULL;
> > >
> > > If you remove the bpf_free() call in arena_list_del(), the test will =
start
> > > crashing because now the userpsace will read 0x100 (LIST_POISON1) in
> > > head->first and segfault.
> > >
> > > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > > ---
> > >  tools/testing/selftests/bpf/bpf_arena_list.h | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/bpf_arena_list.h b/tools/tes=
ting/selftests/bpf/bpf_arena_list.h
> > > index 85dbc3ea4da5..e16fa7d95fcf 100644
> > > --- a/tools/testing/selftests/bpf/bpf_arena_list.h
> > > +++ b/tools/testing/selftests/bpf/bpf_arena_list.h
> > > @@ -64,14 +64,12 @@ static inline void list_add_head(arena_list_node_=
t *n, arena_list_head_t *h)
> > >
> > >  static inline void __list_del(arena_list_node_t *n)
> > >  {
> > > -       arena_list_node_t *next =3D n->next, *tmp;
> > > +       arena_list_node_t *next =3D n->next;
> > >         arena_list_node_t * __arena *pprev =3D n->pprev;
> > >
> > >         cast_user(next);
> > >         cast_kern(pprev);
> > > -       tmp =3D *pprev;
> > > -       cast_kern(tmp);
> > > -       WRITE_ONCE(tmp, next);
> > > +       WRITE_ONCE(*pprev, next);
> >
> > This looks wrong, since cast_kern() is necessary on older llvm
> > that don't have arena support.
> > On newer llvm above change should make no difference.
> > list_del() will still do the poisoning as it should.
> >
> > I'm missing what you're trying to "fix".
>
>
> The logic is broken, __list_del() is not removing the node.
>
> For a second assume, everything is in kernel code and not arena,
> I am also removing WRITE_ONCE for the sake of explanation:
>
> so, the lines will become (removing all arena magic):
>
>
> arena_list_node_t *next =3D n->next, *tmp;
> arena_list_node_t **pprev =3D n->pprev;
>
> tmp =3D *pprev;
> tmp =3D next;
>
> [...]
>
> tmp is a local variable and setting it to next doesn't modify the list.

D'oh. Not sure what I was thinking.


Return-Path: <bpf+bounces-69128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB233B8D973
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 12:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4EA73BCF6E
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 10:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22541258EEB;
	Sun, 21 Sep 2025 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsEaCJI0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAD71E260D
	for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758450901; cv=none; b=pN3/Hf2aXB3Ge2/655Kd04X1kM8Le2PDIaqCHURz68knW1xkbmuKv5/ErY/NYniiKmFtmYoW/zB7ZkPCCor8thPCZjnkbmtAahNmykFtdQt8dkYxY4lvbzfc9OpdPWsypF81d9E0k6X5T9OmjJ8EqcYMG5lLi5C5dkZro5Msdvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758450901; c=relaxed/simple;
	bh=u6v+erV7srb3rAQE+0wUYhb/ZkGSgq0/YYm7vpEK9RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BT881bDlXZJqemSBo9jB7LGsfW+UuUFDBS4z+87jRlodpCz5Vvww1GAWEiSMNZHzX5sUcfPDZgsjO1wvhLT2mh7EY2k0ypjaLog0lyb87XX6GLmhY0L+wGzEB5r2oT5wMBN0FQVLfQ3HIXSBCphAYxsq0nlVHGYhvPZo6cbeiNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsEaCJI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C21C116B1
	for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758450901;
	bh=u6v+erV7srb3rAQE+0wUYhb/ZkGSgq0/YYm7vpEK9RU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WsEaCJI0xQ8zEDJD0HL28U5b1m6YaRQj2YBoTlk51XcP0Ojku99QP+s4Q9lbSFVgL
	 3p1PuA8/CotHmfzAG04WjwzC3tMYgjvWPeDjXsfsIawUMaQSwiYsNVGTbCSNDxAdh/
	 oXvVQc2dRmEjQFaevw+yw22hI4BxES29tJcb+9NjobCBUMgZ9/tjiKd58rgDxCcs6N
	 ndDGeeXHEjxdh6CKy0C5XwIHokOR6iXTg91kFeqbIV5jdDhBEVNIgFvXVVywQMv4kz
	 dXdCCRVZHJpjZuKQ4cXy4ygwyDJ5aWvVdt0thCGoVYvVnK/eBbnuMOwfbNNPu7KTGP
	 GaJ24+kELtCwQ==
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so1057976f8f.1
        for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 03:35:01 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyi6MeleGZ7y98WJGW++bsY7qqkZnCf48AHZbVL41IHdr1X3vyw
	lKa24Ya+RhDAehnzt5p2Pr2wamjEjggljixvf+FJx8CapEOpmqNjBavbYqllHSDxsZdhq9xr8/w
	j4fw8dRHSnnCenD+uTJz86bBqSSZng2vaYBjv9xKf
X-Google-Smtp-Source: AGHT+IGFVLvU+mFHi5zGVxh6PgOA7c4c5bWdm5kZe04VlecxUhpJrcVEZgP2ulJIAZ/ic6UhE0M/YAu6yCVK2osA1ss=
X-Received: by 2002:a05:6000:18a9:b0:3ee:1125:5250 with SMTP id
 ffacd0b85a97d-3ee7e106a16mr7539885f8f.24.1758450899694; Sun, 21 Sep 2025
 03:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914215141.15144-1-kpsingh@kernel.org> <20250914215141.15144-2-kpsingh@kernel.org>
 <CAADnVQLo8udasPu_tWeffY88opzpxb2Xj9c2ppt1Lvz5VkRUvA@mail.gmail.com>
In-Reply-To: <CAADnVQLo8udasPu_tWeffY88opzpxb2Xj9c2ppt1Lvz5VkRUvA@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Sun, 21 Sep 2025 12:34:48 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7Nzw56Dt+Mh-9PSLLjqjzWjCfNXfdCaK38LDF5m3FK-w@mail.gmail.com>
X-Gm-Features: AS18NWD5idQT-4FF2YGt0K7LdZRdvrbeDLh-9TMefe_jzXOWo_EQFLP3TQkYToY
Message-ID: <CACYkzJ7Nzw56Dt+Mh-9PSLLjqjzWjCfNXfdCaK38LDF5m3FK-w@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] bpf: Update the bpf_prog_calc_tag to use SHA256
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 4:19=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Sep 14, 2025 at 2:51=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> >
> >  int bpf_prog_calc_tag(struct bpf_prog *fp)
> >  {
> > -       size_t size =3D bpf_prog_insn_size(fp);
> > -       u8 digest[SHA1_DIGEST_SIZE];
> > +       u32 insn_size =3D bpf_prog_insn_size(fp);
> >         struct bpf_insn *dst;
> >         bool was_ld_map;
> > -       u32 i;
> > +       int i, ret =3D 0;
>
> I undid all of the above extra noise and removed unnecessary 'ret'
> while applying the first 7 patches.

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1cda2589d4b3..9b64674df16b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -39,6 +39,7 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/memcontrol.h>
 #include <linux/execmem.h>
+#include <crypto/sha2.h>

 #include <asm/barrier.h>
 #include <linux/unaligned.h>
@@ -296,7 +297,6 @@ void __bpf_prog_free(struct bpf_prog *fp)
 int bpf_prog_calc_tag(struct bpf_prog *fp)
 {
        size_t size =3D bpf_prog_insn_size(fp);
-       u8 digest[SHA1_DIGEST_SIZE];
        struct bpf_insn *dst;
        bool was_ld_map;
        u32 i;
@@ -327,8 +327,7 @@ int bpf_prog_calc_tag(struct bpf_prog *fp)
                        was_ld_map =3D false;
                }
        }
-       sha1((const u8 *)dst, size, digest);
-       memcpy(fp->tag, digest, sizeof(fp->tag));
+       sha256((u8 *)dst, size, fp->digest);
        vfree(dst);
        return 0;
 }

Updated as well

- KP
>
> Pls address comments and respin.

